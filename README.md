bazel_shade_plugin
==================

## Introduction
In maven, we have `maven_shade_plugin`. It allows user can reweite package name. This is very useful if project 
 and project's dependencies share same dependency. In such case, we have no choice but rewrite the duplicated dependeicy's package name. 
 
## How to use this project
Add following line to your `WORKSPACE` file,
~~~
load(
    "@com_github_zhexuany_bazel_shade//:java_shade.bzl",
    "java_shade_repositories",
    "java_shade"
)
java_shade_repositories()
~~~

Add following lines to your `BUILD` file,
~~~
java_shade(
    name = "shaded_args",
    input_jar = "@io_netty_netty_codec_socks//jar",
    rules = "shading_rule"
)

java_import(
    name = "shaded_scalding",
    jars = ["shaded_args.jar"]
)%
~~~
`shade_rule` is a file where you can specify shading rule. The name could be different of course.

~~~
rule io.netty.** io.netty.netty.@1
~~~

### Location
1. rule file and `BUILD` must be in smae directory.
### Format
Say you have a dependency `io.netty.**`, and you want to shade it to `io.netty.netty.**`. The content in rule file should look like `rule io.netty.** io.netty.netty.@1`.

## Example
