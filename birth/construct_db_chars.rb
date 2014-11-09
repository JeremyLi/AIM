# coding: utf-8
require 'neo4j-core'
#require 'neo4j-embedded'
#require 'neo4j-embedded/embedded_session'

session = Neo4j::Session.open(:embedded_db, '../db/neo4j/development/data/graph.db')
session.start
#node = Neo4j::Node.create({name: 'enter'})
node0 = Neo4j::Node.load 0
puts "Loads node #{node0[:name]} with id #{node0.id}"
  
wordsFile = File.new('words1.txt')
l = 0
for line in wordsFile
  words = line.split
 l += 1
  print l,  ': '
  words.each_with_index do |w, i|
    if i>0 && i%2 == 0
      print w
        node = Neo4j::Node.create({char: w})
      ids=[]
       ids << node.id
       node0[w] = ids
    end
  end
  print "\n"
end

#session.stop
p 'birthday'
