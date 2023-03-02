#!/usr/bin/env ruby

require 'fileutils'

dirname = __dir__

#------------------------------------------------------------
# Define the header and source files.
#------------------------------------------------------------
header_template = <<HEREDOC
#pragma once

namespace @1 {

    class @2
    {
    public:
        @2();
        ~@2();
    };
}
HEREDOC

source_template = <<HEREDOC
#include "@1/@2.h"

namespace @1 {
    @2::@2() {}
    @2::~@2() {}
}
HEREDOC

if dirname == "build"
  puts "In build dir."
  include_dir     = "../#{dirname}/include"
  source_dir      = "../#{dirname}/src"
else
  puts "In main dir."
  include_dir     = "include"
  source_dir      = "src"
end

#------------------------------------------------------------
# Get args from command line.
#------------------------------------------------------------
namespace = ARGV[0]
classname = ARGV[1]

#------------------------------------------------------------
# Replace the "tags" with namespace and classname.
#------------------------------------------------------------
puts header_template
header_template.gsub!("@1", namespace)
header_template.gsub!("@2", classname)
source_template.gsub!("@1", namespace)
source_template.gsub!("@2", classname)

#------------------------------------------------------------
# Create new templace files and write new template.
#------------------------------------------------------------
header_file = "#{classname}.h"
source_file = "#{classname}.cpp"

header_fh = File.open(header_file, "w")
source_fh = File.open(source_file, "w")

header_fh.write(header_template)
source_fh.write(source_template)

header_fh.close
source_fh.close

if Dir.exist? "#{include_dir}/#{namespace}"
  FileUtils.cp(header_file, "#{include_dir}/#{namespace}")
else
  puts "Directory: #{include_dir}/ dir doesn't exist, creating it..."
  FileUtils.mkdir_p("#{dirname}/#{include_dir}/#{namespace}")
  FileUtils.cp(header_file, "#{include_dir}/#{namespace}")
  puts "#{include_dir}/ Created."
end

if Dir.exist? "#{source_dir}"
  FileUtils.cp(source_file, "#{source_dir}")
else
  puts "Directory: #{source_dir}/ dir doesn't exist, creating it..."
  FileUtils.mkdir_p("#{dirname}/#{source_dir}")
  FileUtils.cp(source_file, "#{source_dir}")
  puts "#{source_dir}/ Created."
end

FileUtils.rm header_file
FileUtils.rm source_file

puts "Created #{namespace}::#{classname} class."

