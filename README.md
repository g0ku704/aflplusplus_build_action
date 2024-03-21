# AFL++ Build action


## Background

This action is to have a generic build step that can be used in workflows by replacing the fuzz target compilers with AFL++ instrumented compilers instead.

## Inputs

```yaml
  file_name:
    description: "Name of the target source file"
    required: true
  source:
    description: "Path of the target source"
    required: true
  compiler:
    description: "AFL++ Compiler"
    default: "clang-lto"
  use_asan:
    description: "Compile target with ASAN"
    default: true 
```