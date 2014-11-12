# coding: utf-8
require 'neo4j-core'
#require 'neo4j-embedded'
#require 'neo4j-embedded/embedded_session'

session = Neo4j::Session.open(:embedded_db, '../db/neo4j/development/data/graph.db')
session.start
node0 = Neo4j::Node.create({name: 'enter'})
#node0 = Neo4j::Node.load 0
puts "Loads node #{node0[:name]} with id #{node0.id}"
 
#require 'iconv'

def  create_nodes  filename, node0

file = File.new  filename
#tmp_file = File.new 'tmp_words2.txt', 'a'

for line in file
  print line
  #line = Iconv.iconv("UTF-8//IGNORE", "GBK//IGNORE", line).to_a[0].strip
  #line = line.encode('utf-8')
  #print ' : ', line, '\n'
  #tmp_file.puts line
  line = line.strip
  
   node = Neo4j::Node.create({words:  line}) if line.length > 0
      
   node0[line] = node.id if line.length > 0
  
end

  file.close
end


create_nodes 'words1.txt', node0
create_nodes 'words2.txt', node0
create_nodes 'words3.txt', node0
create_nodes 'words4.txt', node0
create_nodes 'words5.txt', node0

