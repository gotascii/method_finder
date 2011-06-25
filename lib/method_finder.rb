module MethodFinder
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def abbrev(name = nil)
      @abbrev ||= []
      if name.nil?
        @abbrev
      else
        @abbrev << name
      end
    end
  end

  def method_missing(meth, *args)
    matches = self.class.abbrev.select {|abbr| abbr =~ /#{meth}/ }
    return super if matches.empty?
    if matches.one?
      name = matches.first
      respond_to?(name) ? send(name) : super
    else
      matches
    end
  end
end