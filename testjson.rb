# -*- coding: utf-8 -*-
#!/usr/bin/env ruby
 
 class A
    attr_accessor :w
    attr_accessor :r
    
        #self.words
    def init (w, r)
        self.w=w
        self.r = r
     end
     
     def to_json 
           
             jsonstr="{" + "\"words\":\"#{self.w}\""  
             jsonstr += "," +"\"relationships\":{"
            i = 0
            for k, v in self.r 
                   if i == 0
                     i += 1
                    jsonstr += "\"#{k}\":#{v.to_json}"
                   else
                        jsonstr += ","
                         jsonstr += "\"#{k}\":#{v.to_json}"
                    end
             end
             jsonstr += "}"
            jsonstr += "}"  
         end
      
    end

    a=A.new
    w="WWWWWW"
    r={"a"=>"AAAAAA", "b"=>"BBBBBB"}
    a.init w, r
    
    a.to_json



class B < A
    attr_accessor :from, :to
    
    def to_json(options)        
        #super(options)
     " {\"words\":#{self.words}, \"from\":#{self.from}, \"to\":#{self.to}}"
    end
end
