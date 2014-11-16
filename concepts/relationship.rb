#coding=utf-8

class Relationship
   include Neo4j::ActiveRel
   
   property :name
  
end