bazel_shade_plugin
==================

## Introduction
In maven, we have `maven_shade_plugin`. It allows user can reweite package name. This is very useful if project 
 and project's dependencies share same dependency. In such case, we have no choice but rewrite the duplicated dependeicy's package name. 
 
## How to use this project
### Location
1. rule file and `BUILD` must be in smae directory.
### Format
Say you have a dependency `io.netty.**`, and you want to shade it to `io.netty.netty.**`. The content in rule file should look like `rule io.netty.** io.netty.netty.@1`.

## Example
