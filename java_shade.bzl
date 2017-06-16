def _shade_impl(ctx):
  ctx.action(
    inputs=[ctx.file.rules, ctx.file.input_jar],
    outputs=[ctx.outputs.jar],
    executable=ctx.executable._jarjar_runner,
    progress_message="jarjar %s" % ctx.label,
    arguments=["process", ctx.file.rules.path, ctx.file.input_jar.path, ctx.outputs.jar.path])

# Define a rule that can actually shade jar file.
java_shade = rule(
    implementation = _shade_impl,
    attrs = {
        "input_jar": attr.label(allow_files=True, single_file=True),
        "rules": attr.label(allow_files=True, single_file=True),
        "_jarjar_runner": attr.label(executable=True, cfg="host", default=Label("@com_github_zhexuany_bazel_shade//:shade_runner")),
    },
    outputs = {
      "jar": "%{name}.jar"
    })