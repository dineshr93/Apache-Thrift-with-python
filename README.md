# Writing Apache Thrift microservice with Python
## [Thrift](https://thrift.apache.org/tutorial/py.html) explained clearly avoiding the division error



## Steps
```sh

1 Download & rename exe as "thrift.exe" from https://thrift.apache.org/download
2 add to the Environpath
3 thrift files from https://thrift.apache.org/tutorial/py.html
4 do "thrift -r --gen py tutorial.thrift" it will create py-gen

5 pip install thrift
6 do "py setup.py build" inside ->thrift-0.9.3/lib/py to get build folder. Then Copy lib folder into workspace  
```
## Workspace in client
```sh
pygen
lib
client.py
```

## Workspace in server
```sh
pygen
lib
server.py
```
## Features

- The division error in the tutorial is taken care of
- This tutorial is mainly for Windows (but can be reproduced all above steps except 1 & 2)

## License

MIT

**Free Software, Hell Yeah!**
