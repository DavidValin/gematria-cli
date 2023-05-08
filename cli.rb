#!/usr/bin/env ruby

# By David Valin <hola@davidvalin.com>

require 'rubygems'
require 'gematria'
require 'sqlite3'
require 'ruby-graphviz'

ARGV.delete(0)
EXPORT_GRAPH = ARGV.include? "--graph"
ONLY_EXPORT = ARGV.size == 1 && EXPORT_GRAPH

DB = SQLite3::Database.open Dir.home+'/g.db'
DB.execute "CREATE TABLE IF NOT EXISTS searches(search TEXT, hbr TEXT, eng TEXT, smp TEXT)"

# mapping from https://www.gematrix.org/?word=abcdefghijklmnopqrstuvwxyz
Gematria::Tables.add_table :hbr,
  'a' => 1,
  'b' => 2,
  'c' => 3,
  'd' => 4,
  'e' => 5,
  'f' => 6,
  'g' => 7,
  'h' => 8,
  'i' => 9,
  'j' => 600,
  'k' => 10,
  'l' => 20,
  'm' => 30,
  'n' => 40,
  'o' => 50,
  'p' => 60,
  'q' => 70,
  'r' => 80,
  's' => 90,
  't' => 100,
  'u' => 200,
  'v' => 700,
  'w' => 900,
  'x' => 300,
  'y' => 400,
  'z' => 500

# mapping from https://www.gematrix.org/?word=abcdefghijklmnopqrstuvwxyz
Gematria::Tables.add_table :eng,
  'a' => 6,
  'b' => 12,
  'c' => 18,
  'd' => 24,
  'e' => 30,
  'f' => 36,
  'g' => 42,
  'h' => 48,
  'i' => 54,
  'j' => 60,
  'k' => 66,
  'l' => 72,
  'm' => 78,
  'n' => 84,
  'o' => 90,
  'p' => 96,
  'q' => 102,
  'r' => 108,
  's' => 114,
  't' => 120,
  'u' => 126,
  'v' => 132,
  'w' => 138,
  'x' => 144,
  'y' => 150,
  'z' => 156

# mapping from https://www.gematrix.org/?word=abcdefghijklmnopqrstuvwxyz
Gematria::Tables.add_table :smp,
  'a' => 1,
  'b' => 2,
  'c' => 3,
  'd' => 4,
  'e' => 5,
  'f' => 6,
  'g' => 7,
  'h' => 8,
  'i' => 9,
  'j' => 10,
  'k' => 11,
  'l' => 12,
  'm' => 13,
  'n' => 14,
  'o' => 15,
  'p' => 16,
  'q' => 17,
  'r' => 18,
  's' => 19,
  't' => 20,
  'u' => 21,
  'v' => 22,
  'w' => 23,
  'x' => 24,
  'y' => 25,
  'z' => 26

if not ONLY_EXPORT
  search_query_tmp = ARGV.select {|s| s != "--graph"}
  search_query = search_query_tmp.join(" ")

  name_hbr = Gematria::Calculator.new search_query, :hbr
  name_eng = Gematria::Calculator.new search_query, :eng
  name_smp = Gematria::Calculator.new search_query, :smp
  puts "\n"
  puts "hebrew: \t" + name_hbr.converted.to_s
  puts " english: \t" + name_eng.converted.to_s
  puts " simple: \t" + name_smp.converted.to_s
  puts "\n"

  # Track this search
  DB.execute "INSERT INTO searches (search, hbr, eng, smp) VALUES (?, ?, ?, ?)",
    search_query,
    name_hbr.converted.to_s,
    name_eng.converted.to_s,
    name_smp.converted.to_s

  # Find other searches with the same value

  # ... in hebrew table
  results_hbr = DB.query "SELECT DISTINCT search FROM searches WHERE hbr=? and search!=?",
    name_hbr.converted.to_s,
    search_query

  # ... in english table
  results_eng = DB.query "SELECT DISTINCT search FROM searches WHERE eng=? and search!=?",
    name_eng.converted.to_s,
    search_query

  # ... in simple table
  results_smp = DB.query "SELECT DISTINCT search FROM searches WHERE smp=? and search!=?",
    name_smp.converted.to_s,
    search_query

  puts "  Other previous searches matching numerical value:\n"
  results_hbr.each {|s| puts "    "+s.join('')+" (hebrew value)"}
  results_eng.each {|s| puts "    "+s.join('')+" (english value)"}
  results_smp.each {|s| puts "    "+s.join('')+" (simple value)"}
  puts "\n"
end

# Export a png graphviz graph for any of "hbr", "eng" or "smp" gematria tables
def export_graph(lang)
  all_searches = DB.query "SELECT DISTINCT search, "+lang+" FROM searches"
  groups = all_searches.group_by do |row|
    row[1]
  end
  # puts all_searches
  groups.keys.each do |key|
    g = GraphViz.new(:G, :type => :digraph)
    terms_groups = groups[key].map do |row|
      row[0]
    end
    if terms_groups.length > 1
      terms_groups.each do |term|
        g.add_nodes(term)
      end
    end
    terms_groups.each do |term_left|
      terms_groups.each do |term_right|
        g.add_edges(term_left, term_right, :dir => :none) if term_left != term_right
      end
    end
    g.output(:png => "#{lang}_#{groups[key][0][1]}.png")
  end
end

# Export graphviz hierarchy graphs for hebrew, english and simple gematria tables
# using all searches stored in the database
if EXPORT_GRAPH
  export_graph("hbr")
  export_graph("eng")
  export_graph("smp")
end
