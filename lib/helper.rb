module Helper
  def alias_names names, m
    names.each do |name| 
      define_method(name) do |*args| 
        self.send(m, *args)
      end
    end
  end    
end
