% Hello, gohbase

## What is HBase

> Apache HBase™ is the Hadoop database, a distributed, scalable, big data store.

_~ hbase.apache.org_

## Starting gohbase

Project started on April 25th by Benoit (author of OpenTSDB):

![](https://avatars1.githubusercontent.com/u/128281?v=3&s=400)

# HBase Architecture

##

<img src="http://image.slidesharecdn.com/integrationofapachehiveandhbasefinal-120504182226-phpapp02/95/integration-of-hive-and-hbase-8-728.jpg?cb=1336156216" style="height:600px;width:800px;"></img>

## 

<img src="http://www.n10k.com/assets/2013-05-29-hbase-for-architects-logdata_high.jpg" style="height:600px;width:800px;"></img>

# gohbase Architecture

## packages

- gohbase
- gohbase/hrpc
- gohbase/region
- gohbase/regioninfo
- gohbase/zk

## gohbase/zk

```go
type ResourceName string

const (
    Meta = ResourceName("/hbase/meta-region-server")
    Master = ResourceName("/hbase/master")
)
func LocateResource(zkquorum string,
        resource ResourceName) (string, uint16, error)

```

## gohbase/regioninfo

```go
// Info describes a region.
type Info struct {
    // Table name.
    Table []byte

    // RegionName.
    RegionName []byte

    // StartKey
    StartKey []byte

    // StopKey.
    StopKey []byte

    // Once a region becomes unreachable, this channel is created, and any
    // functions that wish to be notified when the region becomes available
    // again can read from this channel, which will be closed when the region
    // is available again
    available     chan struct{}
    availableLock sync.Mutex
}
```

## gohbase/region

```go
func NewClient(host string, port uint16, ctype ClientType,
    queueSize int, flushInterval time.Duration) (*Client, error)

func (c *Client) processRpcs()
func (c *Client) receiveRpcs()

func (c *Client) QueueRPC(rpc hrpc.Call) error
```

## gohbase/hrpc

```go
func NewGet(ctx context.Context, table, key []byte,
        options ...func(Call) error) (*Get, error)

func NewAppStr(ctx context.Context, table, key string,
        values map[string]map[string][]byte) (*Mutate, error)

func NewDelStr(ctx context.Context, table, key string,
        values map[string]map[string][]byte) (*Mutate, error)

func NewIncStr(ctx context.Context, table, key string,
        values map[string]map[string][]byte) (*Mutate, error)

func NewPutStr(ctx context.Context, table, key string,
        values map[string]map[string][]byte) (*Mutate, error)

func NewPutStrRef(ctx context.Context, table, key string,
        data interface{}) (*Mutate, error)

```

##

```go
ctx := context.WithTimeout(context.Background(), time.Millisecond * 100)
headers := map[string][]string{"cf": []string{"a","b"}}
get, err := hrpc.NewGetStr(ctx, []byte("my-table"), []byte("my-key"),
                hrpc.Families(headers))
```

##

```go
data := struct {
        AnInt       int        `hbase:"cf:a"`
        AnInt8      int8       `hbase:"cf:b"`
        AnUInt64    uint64     `hbase:"cf:j"`
        AComplex128 complex128 `hbase:"cf:n"`
        APointer    *int       `hbase:"cf:o"`
        ASlice      []uint8    `hbase:"cf:q"`
    }{  
        AnInt:       10, 
        AnInt8:      20, 
        AnUInt16:    80, 
        AComplex128: 140,
        APointer:    &number,
        ASlice:      []uint8{1, 1, 3, 5, 8, 13, 21, 34, 55},
    }
put, err := hrpc.NewPutStrRef(context.Background(), []byte("my-table"),
                []byte("my-key"), data)
```

## gohbase

```go
func NewClient(zkquorum string, options ...Option) *Client
func (c *Client) SendRPC(rpc hrpc.Call) (*hrpc.Result, error)
func (c *Client) Scan(s *hrpc.Scan) ([]*hrpc.Result, error)
```

```go
c := gohbase.NewClient("localhost")
rsp, err := c.SendRPC(get)
```

##

### The SendRPC Algorithm

```
Given an RPC...
Check cache for a region covering RPC's key
if region exists in cache:
    if region is available:
        fetch client for region from cache
        queue RPC with client
        wait for response on RPC's channel
        if there was a recoverable error:
            mark region as unavailable
            if first to do so:
                go establishRegion(region)
            wait for region to be marked as available
            recurse
        else if there was an unrecoverable error:
            mark all regions using this client as unavailable
            if first to do so:
                for each region that was using the client:
                    go estalishRegion(region)
            wait for region to be marked as available
            recurse
        else
            return the response and any errors to the user
    else
        wait for region to be marked as available
        recurse
```

##

### The SendRPC Algorithm

```
else
    look up region in meta table (uses SendRPC)
    make new regioninfo
    mark new regioninfo as unavailable
    put new regioninfo in the cache
    go establishRegion(region, location we got from meta table)
    wait for region to be marked as available
    recurse
        
```

##

### The SendRPC Algorithm (establishRegion)

```
Given a regioninfo, and potentially a location
err := nil
loop:
    if a location is known and err is nil:
        check cache for a client at this location
        if client exists:
            send get request (a probe) to the region
            if err is nil:
                add mapping from regioninfo to client
                mark regioninfo as done
                return
        else:
            make a new client to the location
            if err is nil:
                send a get request (a probe) to the region
                if err is nil:
                    add mapping from regioninfo to client
                    mark regioninfo as done
                    return
    if err is not nil:
        sleep for a time
        increase backoff amount
    if regioninfo is for the meta table or admin:
        look up location in zookeeper
    else:
        look up location in the meta table (uses SendRPC)
```

# Problems I had to solve

## Concurrent Operations in the region client

##

### Before

1. Acquire lock
2. Send request
3. Receive response
4. Release lock

## 

### After

1. Put operation in queue
2. Wait on channel for response

## 

### After

1. Wait for full queue or timeout
2. Empty queue into local list
3. Assign an ID to each request
4. Write requests to wire
5. goto 1

## 

### After

1. Wait for Responses from server
2. When response received, deserialize message
3. Look in requests sent for call ID
4. Send response/errors over channel
5. goto 1

## (lack of) documentation

Three places I had to go to for HBase help:

1. The .proto files in the HBase source code
2. Benoit
3. The HBase source code itself

## 

### Example: scan

`Client.proto`:

```c
message ScanRequest {
  optional RegionSpecifier region = 1;
  optional Scan scan = 2;
  optional uint64 scanner_id = 3;
  optional uint32 number_of_rows = 4;
  optional bool close_scanner = 5;
  optional uint64 next_call_seq = 6;
  optional bool client_handles_partials = 7;
  optional bool client_handles_heartbeats = 8;
}

message ScanResponse {
  repeated uint32 cells_per_result = 1;
  optional uint64 scanner_id = 2;
  optional bool more_results = 3;
  optional uint32 ttl = 4;
  repeated Result results = 5;
  optional bool stale = 6;
  repeated bool partial_flag_per_result = 7;
  optional bool more_results_in_region = 8;
  optional bool heartbeat_message = 9;
}
```

## Race conditions

Channels and goroutines are nice, but they can't always protect you from subtle
race conditions.

```go
err = c.write(buf)
if err != nil {
    return err
}

c.sentRPCsMutex.Lock()
c.sentRPCs[c.id] = rpc
c.sentRPCsMutex.Unlock()
```

## Gracefully handling failure

See `SendRPC` and `establishRegion` from earlier.

# HBase pain points

## Annoying to setup

There are entire companies built around deploying HBase for you.

## stack traces

Whenever an error is encountered (like a request is made to a region that got
moved), HBase sends an entire stack trace over the network to the client.

## Corruption

This was backed by a local filesystem, and not HDFS, so probably won't see this
in production, but...

Saw table existed in HBase shell. If I attempted to use the table, got an error
saying the table doesn't exist. If I tried to create the table, got an error
saying the table exist. If I tried to delete the table, got an error saying the
table doesn't exist.

Solution was to burn it all to the ground and start over fresh with no data.

## Create Table

```c
message CreateTableRequest {
  required TableSchema table_schema = 1;
  repeated bytes split_keys = 2;
}
```

If you send this to the HMaster, the HMaster will return no errors. When the
HMaster asks a region server to host the new region, the region server replies
with `java.lang.NumberFormatException` and the region never gets hosted
anywhere.

## The scariest part

I'm not currently aware of anything that does what HBase does, but better.

# State of the project

## What's Good

- All of the non-admin operations are supported and work
- Can handle regions moving and region server / zookeeper failure
- Can batch together operations transparently, reducing overhead
- Reflection-based API is much nicer for specific tasks (needs work though)

## What needs work

## Admin Features

```go
ac := gohbase.NewClient(host, gohbase.Admin())
dit := hrpc.NewDisableTable(context.Background(), []byte(table))
_, err := ac.SendRPC(dit)
```

All ground work and logic is in place to have an admin client. Only working
operations are disable table and delete table. Create table is in there, but
non-functional. More admin operations need to be added.

## Tests

Test coverage is way lower than it needs to be. Currently 18% coverage.

## Real World Use

Needs to be run on a real cluster, and have bottlenecks and bugs identified /
eliminated.

It's only ever been run on a laptop, so different issues will probably be
exposed when run in a truly distributed setup.

## User facing API

The user facing API needs to be refined. It'll probably become obvious what
improvements can be made when real applications are written using gohbase.

The reflection API is a step in the right direction, in my opinion.

That is, unless you like using a `map[string]map[string][]byte`.

## And probably more

I'm sure Benoit is aware of other things that need to be done.

# Questions?
