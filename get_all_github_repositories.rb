#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'trollop'

BASE_URL = 'https://www.github.com'

def get_repositories username
    repositories_url = "#{BASE_URL}/#{username}?tab=repositories"
    github = Nokogiri::HTML open repositories_url
    github.css('h3.repo-list-name a').map {|a| a.attr 'href'}
end

def clone repo_url
    begin
        `git clone #{repo_url}`
    rescue Exception => e
        warn "Error cloning #{repo_url}: #{e.message}"
    end
end

def pull repo
    begin
        current_dir = Dir.pwd
        Dir.chdir repo
        `git pull`
        Dir.chdir current_dir
        puts "pulled #{repo}"
    rescue Exception => e
        warn "Error pulling #{repo}: #{e.message}"
    end
end

def get_all_repositories archive_dir, username
    if not File.directory? archive_dir then
        raise "Error: expected '#{archive_dir}' to be a directory"
    end
    current_dir = Dir.pwd 
    Dir.chdir archive_dir

    repos = get_repositories username
    repos.each do |repo_link|
        _, _ , repo = repo_link.split '/'
        repo_dir = File.absolute_path File.join(archive_dir, repo)
        if File.exist? repo_dir and File.directory? repo_dir then
            pull repo
        else
            if File.file? repo_dir then
                warn "I don't know what to do: #{repo_dir} is a file, not a directory. "
                warn "Skipping this repository '#{repo_name}' ..."
                next
            else
                clone "#{BASE_URL}#{repo_link}.git"
            end
        end
    end

    Dir.chdir current_dir
end


opts = Trollop::options do
    banner <<-EOB
Use get_all_github_repositories.rb to clone or pull all the repositories belonging to a user into an archival directory.

Usage:

    get_all_github_repositories.rb --username a-name --archive-dir a-dir

Options:    
EOB
    opt :username, "Github username to get all github repositories from", 
        :type => :string
    opt :archive_dir, "Directory to place all github repositories in, default is .",
        :type => :string
end

Trollop::die :username if not opts[:username] or opts[:username].empty?
Trollop::die :archive_dir if not opts[:archive_dir] or not File.directory? opts[:archive_dir]

get_all_repositories opts[:archive_dir], opts[:username]
