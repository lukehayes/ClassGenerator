#!/usr/bin/env ruby

require 'fileutils'

puts dirname = File.basename(Dir.getwd)

namespace = ARGV[0]
classname = ARGV[1]

template_dir    = "templates"
include_dir     = "include"
source_dir      = "src"


header_template = "header.h"
source_template = "source.cpp"

header_file = "#{classname}.h"
source_file = "#{classname}.cpp"

header_contents = ""
source_contents = ""

FileUtils.cp("#{template_dir}/#{header_template}", header_file)
FileUtils.cp("#{template_dir}/#{source_template}", source_file)

header_fh = File.open("#{template_dir}/#{header_template}", "r+")
source_fh = File.open("#{template_dir}/#{source_template}", "r+")

header_fh.read(nil, out_string = header_contents)
source_fh.read(nil, out_string = source_contents)

header_fh.each do |x| p x end

header_fh.close
source_fh.close

header_contents.gsub!("@1", namespace)
header_contents.gsub!("@2", classname)

source_contents.gsub!("@1", namespace)
source_contents.gsub!("@2", classname)

header_fh = File.open(header_file, "w")
source_fh = File.open(source_file, "w")

header_fh.write(header_contents)
source_fh.write(source_contents)

header_fh.close
source_fh.close

if Dir.exist? "#{include_dir}/#{namespace}"
  FileUtils.cp(header_file, "#{include_dir}/#{namespace}")
  FileUtils.cp(source_file, "#{source_dir}")
else
  puts "Dir Doesn't 'Exist, creating it..."
  FileUtils.mkdir_p("#{include_dir}/#{namespace}")
  FileUtils.mkdir_p("#{source_dir}")
  FileUtils.cp(header_file, "#{include_dir}/#{namespace}")
  FileUtils.cp(source_file, "#{source_dir}")
  puts "Created."
end

FileUtils.rm header_file
FileUtils.rm source_file

puts "#{include_dir}/#{namespace}/#{header_file}"
#FileUtils.cp(header_file, "#{include_dir}/#{namespace}/#{header_file}" )
#FileUtils.cp(source_file, "#{source_dir}/#{source_file}" )

puts "Created #{namespace}::#{classname} class."

