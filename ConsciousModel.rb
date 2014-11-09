# -*- coding: utf-8 -*-
#!/usr/bin/env ruby
 
#require 'json'

class Concept
    attr_accessor :words
    attr_accessor :R
     
    def init w, r
        self.words=w
        self.R = r
     end
     
     def to_r  
            relstr="#{self.words}:"  
            i = 0
            for k, v in self.R
                for vv in v            
                    if i == 0
                         i += 1
                        relstr += vv.to_r  # "\"#{v.words}\",\"#{v.from}\",\"#{v.to}\""
                   else
                        relstr += ";"
                        relstr += vv.to_r   #"\"#{v.words}\",\"#{v.from}\",\"#{v.to}\""
                    end
                    end
             end 
            relstr += "\n"  
         end
      
    end


class RelationShip < Concept
    attr_accessor :from, :to
    
    def to_r
     "#{self.words},#{self.from},#{self.to}"
    end
    
    def equal?(r)
        return self.from==r.from && self.words==r.words && self.to==r.to
    end
end


class ConsciousModel
    attr_accessor :D
    attr_accessor :K
    
    def add_concept(c)
       self.D ||= {}
       self.K ||= {}
        unless self.D[c]
            self.D[c] = Concept.new
            self.D[c].words = c
            self.K[c].words= c
         else 
            puts 'exist!'
          end
    end
    
    def add_knowledge(pre, r, nxt)
        self.K ||= {}
        
      # p self.K[pre]
        if not self.K[pre].R[r]
              self.K[pre].R[r] ||= []
        end
       
            rs= RelationShip.new
            rs.from = pre
            rs.to = nxt
            rs.words = r
            
            isin=false
            for rr in self.K[pre].R[r]
                 
                if   rr.equal? rs
                      isin = true
                    p isin
                    break;
                 end
            end
            if not isin
            p "rs"
                self.K[pre].R[r]  << rs
            end
    end
    
    
    
    def load_dict(filename)
         self.D ||= {}   ##必须加self或@
         self.K ||= {}
         file= File.new(filename)  
         for l in file
            l=l.strip.split
            for w in l
               c=Concept.new
               c.words=w
               c.R={}
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
         self.K = {}
         self.D ={}
         file= File.open(filename, "r+") 
         file.each_line do |line| 
             line = line.strip
             #p line
            words, rel = line.split(":")
            c=Concept.new
            c.words = words
            c.R = {}  ##必须初始化，否则后面的to_r方法出错
           # p rel
            if rel
                rels = rel.split(";")
                #p rels
                for r in rels
                    w,f,t = r.split(",");
                    rs=RelationShip.new
                    rs.words = w
                    rs.from = f
                    rs.to=t
                    c.R[w]  ||= []
                    c.R[w] << rs
                end
            end 
            self.K[words] = c
            self.D[words]=c
        end
     end
    
    
   def write_knowledge(filename)
            f=File.open(filename, "w+")
            if self.K
                for k, v in self.K
                    relstr= v.to_r
                    f.puts relstr
                end
            end
            f.close
    end
    
    
    
end


class Context < ConsciousModel
    
end


########################

w = ConsciousModel.new
# w.load_dict "CorpusWordPOSlist.txt"
w.load_knowledge "knowledgedb"

# w.add_concept "家"
#p w.D["嫁"].words
 #w.add_knowledge  "山歌","唱", "她"
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
 
 c.R["消除"].to_r


