# Unilab Deployer

## powered by Vue2 & Golang

## Project build
```
sudo make build
```

### Project deploy
```
sudo make deploy 
```

### Stop deploy
```
sudo make stop
```

### Browse
```
type `https://lab.cs.tsinghua.edu.cn/unilab/` to find your course.
type `https://lab.cs.tsinghua.edu.cn/unilab/report.html` to view frontend pages report.
```

### Access MySQL Container
```
# enter mysql container
sudo docker exec -it unilab-mysql bash
mysql -P$(PASSWORD)
# ...do your operations
type `Ctrl+P -> Ctrl+Q` to exit
```

## HOW TO migrate MySQL database
here is a feasible but not very simple and convenient method
```
# 1. DO NOT STOP THE RUNNER! enter mysql container and execute:

mysqldump -p unilab [table_name] > /tmp/mysql-backup/unilab-[tablename].sql

# now in your dir <../unilab-mount/mysql-backup>, there should be a file named "unilab-[tablename].sql" which contains table defination and table data, maybe you want to do some modifications in this .sql file.

# 2. COPY this file to ./mysql/init/rebuild.sql

# 3. shutdown the RUNNER

# 4. delete older mysql DB

rm -r ./unilab-mount/mysql

# 5. rerun the runner in background, the mysql container will execute scripts in ./mysql/init/*.sql when initializing MySQL DB.

sudo docker-compose build
sudo docker-compose up -d
```
