# encoding: utf-8
#
# Generate a historgram of all words in a directory tree with PDF files, for
# example, a directory with downloaded scientific articles.
#
# Requirements: To convert a PDF file, the *pdftotext* utility is used.
#
# Usage
#
#     ruby bib2import_words_list.rb path/to/pdf_files > output.txt
#
require 'tmpdir'

# Helper methods

def important_word(word)
  important = false
  case word
  when /.*\d.*/
    important = false
  else
    important = true
  end
  return important
end

def generate_histogram(histogram, string)
  string = string.encode('utf-8')
  one_line = string.gsub(/\n/, '')
  one_line.split(/[ .,!?;:()'`~"_\/\\–—‒-]/).each do |word|
    word = word.downcase
    if word.length > 4 and important_word(word) then
      if histogram.has_key? word then
        histogram[word] += 1
      else
        histogram[word] = 1
      end
    end
  end
end

# Core 

INPUT_DIR = ARGV[0] or '.'
histogram = Hash.new 0

Dir.mktmpdir do |output_dir|
  pdf_files = Dir["#{INPUT_DIR}/*.pdf"]

  pdf_files.each do |pdf_file|
    basename = File.basename pdf_file, '.pdf'

    output = `pdftotext #{pdf_file} -`
    txt_file = File.open("#{output_dir}/#{basename}.txt", "w") {|f| f.write output }

    warn "Error processing #{pdf_file}, #{output}" if $? != 0
  end

  txt_files = Dir["#{output_dir}/*"]

  txt_files.each do |txt_file|
    generate_histogram histogram, File.read(txt_file)
    File.delete txt_file
  end
end

# Generate the histogram
(histogram.sort_by {|word, count| count}).each do |word, count|
  puts "#{count}\t\t\t#{word}" if count > 10
end

