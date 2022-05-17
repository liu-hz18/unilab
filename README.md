# Unilab Deployer

#### powered by Vue2 & Golang

## Project build
```
$ sudo make build
```

### Project deploy
```
$ sudo make deploy 
```

### Stop deploy
```
$ sudo make stop
```

### Browse
```
type `https://lab.cs.tsinghua.edu.cn/unilab/` to find your course.
type `https://lab.cs.tsinghua.edu.cn/unilab/report.html` to view frontend pages report.
```

### Access MySQL Container
```
# enter mysql container
$ sudo docker exec -it unilab-mysql bash
$ mysql -uroot -p$(PASSWORD)
# ...do your operations
type `Ctrl+P -> Ctrl+Q` to exit
```
```
# you can also access mysql from host machine
# 1. see docker0 ip address
$ ip addr
# 2. connect to mysql
$ mysql -uroot -p123456 -h(docker0_ip_addr) -P3307
e.g.
$ mysql -uroot -p123456 -h172.17.0.1 -P3307
```

## HOW TO migrate MySQL database
here is a feasible but not very simple and convenient method
```
# 1. DO NOT STOP THE RUNNER! enter mysql container and execute:

$ mysqldump -p unilab [tablename] > /tmp/mysql-backup/unilab-[tablename].sql
# now in your dir <../unilab-mount/mysql-backup>, there should be a file named "unilab.sql" which contains table defination and table data, maybe you want to do some modifications in this .sql file.

# 2. COPY this file(s) to ./mysql/init/
# 3. shutdown the RUNNER
# 4. delete older mysql DB
$ rm -r ./unilab-mount/mysql

# 5. rerun the runner in background, the mysql container will execute scripts in ./mysql/init/*.sql when initializing MySQL DB.

$ sudo docker-compose build
$ sudo docker-compose up -d
```

## System Profiling
Requirements
```
install graphviz and configure it in your $PATH, see http://graphviz.org/download/
```
monitor CPU and MEM
```
# execute these commands on YOUR COMPUTER which have a graphic desktop and local browser.
$ go tool pprof -http=":8081" https://lab.cs.tsinghua.edu.cn/unilab/api/debug/pprof/profile
$ go tool pprof -http=":8082" https://lab.cs.tsinghua.edu.cn/unilab/api/debug/pprof/heap
```
monitor goroutine tracing
```
$ curl https://lab.cs.tsinghua.edu.cn/unilab/api/debug/pprof/trace -o trace.out
$ go tool trace -http="localhost:8081" ./trace.out
```

## Stress Testing
Requirements: install go-wrk
```
$ git clone https://github.com/adeven/go-wrk.git
$ cd go-wrk
$ go build
# run a test
$ ./go-wrk [flags] url
```
