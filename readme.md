# C/C++ class generator

This is a simple script that allows me to generate a C++ class and place it in the
correct location for successful compilation.

### Usage

`./class_gen FW MyObject` will generate a .h and .cpp file with `FW` being used as
the namespace and `MyObject` being used for the name of the class (and copy ctor etc).

At the moment, the script is hardcoded to create a header file in `/include/namespace/`
and a source file in `src/` of the current working directory.



