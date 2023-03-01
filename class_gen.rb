#!/usr/bin/env ruby

require 'fileutils'

namespace = ARGV[0]
classname = ARGV[1]

template_dir    = "templates"
header_template = "header.h"
source_template = "source.cpp"

class_file = "#{classname}.h"
source_file = "#{classname}.cpp"

header_contents = ""
source_contents = ""

FileUtils.cp("#{template_dir}/#{header_template}", class_file)
FileUtils.cp("#{template_dir}/#{source_template}", source_file)

header_fh = File.open(class_file, "r+")
source_fh = File.open(source_file, "r+")

header_fh.read(nil, out_string = header_contents)
source_fh.read(nil, out_string = source_contents)

header_fh.close
source_fh.close

header_contents.gsub!("@1", namespace)
header_contents.gsub!("@2", classname)

source_contents.gsub!("@1", namespace)
source_contents.gsub!("@2", classname)

header_fh = File.open(class_file, "w")
source_fh = File.open(source_file, "w")

header_fh.write(header_contents)
source_fh.write(source_contents)

puts "Done"

