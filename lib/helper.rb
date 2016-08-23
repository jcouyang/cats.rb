module Helper
  def alias_names names, m
    names.each do |name| 
      define_method(name) do |*args, &block| 
        self.send(m, *args, &block)
      end
    end
  end    
end
