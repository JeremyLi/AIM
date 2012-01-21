# -*- coding: utf-8 -*-
#!/usr/bin/env ruby
 
require 'json'

class Concept
    attr_accessor :words
    attr_accessor :R
    
        #self.words
    def init w, r
        self.words=w
        self.R = r
     end
     
     def to_json 
           #super(options)
             jsonstr="{" + "\"words\":\"#{self.words}\""  
             jsonstr += "," +"\"relationships\":{"
            i = 0
            for k, v in self.R
                    if i == 0
                     i += 1
                    jsonstr += "\"#{k}\":#{v.to_json}"
                   else
                        jsonstr += ","
                         jsonstr += "\"#{k}\":#{v.to_json}"
                    end
             end
             jsonstr += "}"
            jsonstr += "}\n"  
         end
      
    end


class RelationShip < Concept
    attr_accessor :from, :to
    
    def to_json     
        #super(options)
     " {\"words\":\"#{self.words}\", \"from\":\"#{self.from}\", \"to\":\"#{self.to}\"}"
    end
end


class ConsciousModel
    attr_accessor :D
    attr_accessor :K
    
    def add_concept(c)
       self.D ||= {}
        unless self.D[c]
            self.D[c] = Concept.new
            self.D[c].words = c
         else 
            puts 'exist!'
          end
    end
    
    def add_knowledge(pre, r, nxt)
        self.K ||= {}
        self.K[r] = RelationShip.new
        self.K[r].from = pre
        self.K[r].to = nxt
        self.K[r].words = r
    end
    
    
    
    def load_dict(filename)
         self.D ||= {}   ##必须加self或@
         self.K ||= {}
         file= File.new(filename)       
         for l in file
            l=l.strip.split
            for w in l
               c=RelationShip.new
               c.words=w
               self.D[w]=c
               self.K[w]=c
             end
        end
    end
    
    def write_dict(filename)
        f=File.open(filename, "w+")
        if self.D
            for w in self.D
                f.puts w
             end
         end
         f.close
    end
    
    
       def load_knowledge(filename)
         T ||= {}  
         self.K ||= {}
         file= File.new(filename) 
         file.each_line do |line|
          #  jsonstr += line
        T= JSON::parse(line)         
         for k, v in T
           c =Concept.new
           c.words= k
           c.R={}
           for kk, vv in v
                
           
            self.K[k]
         end
          end        
    end
    
    
   def write_knowledge(filename)
            f=File.open(filename, "w+")
            if self.K
                for k, v in self.K
                    jsonstr="{" + "\"#{k}\":#{ v.to_json}" +"}"
                f.puts jsonstr
              #end
            end
            f.close
    end
    
    
    
end


class Context < ConsciousModel
    
end


########################

w = ConsciousModel.new
w.load_dict "CorpusWordPOSlist.txt"
 w.add_concept "家"
p w.D["嫁"].words

 c=Concept.new

c.words = "山歌"
 
  c.R={}
 
  c.R["唱"]=RelationShip.new
 
 c.R["唱"].words = "唱"
 
  c.R["唱"].from  = "歌手"
 
  c.R["唱"].to = "山歌"
  
  c.R["消除"]=RelationShip.new
 
 c.R["消除"].words = "消除"
 
  c.R["消除"].from  = "作者"
 
  c.R["消除"].to = "假设"
 
 c.R.to_json


