def _shade_impl(ctx):
  ctx.action(
    inputs=[ctx.file.rules, ctx.file.input_jar],
    outputs=[ctx.outputs.jar],
    executable=ctx.executable._shade_runner,
    progress_message="jarjar %s" % ctx.label,
    arguments=["process", ctx.file.rules.path, ctx.file.input_jar.path, ctx.outputs.jar.path])

# Define a java_shade rule that can actually shade jar.
java_shade = rule(
    implementation = _shade_impl,
    attrs = {
        "input_jar": attr.label(allow_files=True, single_file=True),
        "rules": attr.label(allow_files=True, single_file=True),
        "_shade_runner": attr.label(executable=True, cfg="host", default=Label("@com_github_zhexuany_bazel_shade//:shade_runner")),
    },
    outputs = {
      "jar": "%{name}.jar"
    })

def _mvn_name(coord):
  nocolon = "_".join(coord.split(":"))
  nodot = "_".join(nocolon.split("."))
  nodash = "_".join(nodot.split("-"))
  return nodash

def _mvn_jar(coord, sha, bname, serv):
  nm = _mvn_name(coord)
  native.maven_jar(
    name = nm,
    artifact = coord,
    sha1 = sha,
    server = serv
  )
  native.bind(name=("com_github_zhexuany_bazel_shade/%s" % bname), actual = "@%s//jar" % nm)



def java_shade_repositories(server=None):
  _mvn_jar(
    "org.pantsbuild:jarjar:1.6.3",
    "cf54d4b142f5409c394095181c8d308a81869622",
    "jarjar",
    server)
  _mvn_jar(
    "org.ow2.asm:asm:5.0.4",
    "0da08b8cce7bbf903602a25a3a163ae252435795",
    "asm",
    server)
  _mvn_jar(
    "org.ow2.asm:asm-commons:5.0.4",
    "5a556786086c23cd689a0328f8519db93821c04c",
    "asm_commons",
    server)
