# loopgen
Tool for creating ordered graphviz circo loops.
Generates a plain graphviz circo loop then hardcodes it and adds to it.

# usage
loopgen.sh input > output.dot

# input file format
```
x number of nodes
prefixes for the generated file (format information, labels)
(blank)
postfixes for the final file (extra connections, inputscale)
```

# output
graph with node0 to nodex

# example
input file
```
6
node0 [label="bop it"];
node1 [label="twist it"];
node2 [label="pull it"];
node3 [label="flick it"];
node4 [label="spin it"];
node5 [label="throw it away"];

node2 -> node5 [constraint=false,weight=0];
// this keeps the program from running out of memory
inputscale=72
```
command
```
loopgen.sh input | neato -Tpng > output.png
```
output
![fixed output](https://raw.github.com/rbong/loopgen/master/img/screen1.png)
normally, this would result in
![normal output](https://raw.github.com/rbong/loopgen/master/img/screen2.png)
