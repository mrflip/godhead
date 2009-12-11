class String
  [:camelize, :underscore, :demodulize].each do |inflection|
    next if self.respond_to?(inflection)
    self.class_eval %Q{
      def #{inflection}
        Extlib::Inflection.#{inflection} self
      end}
  end
end
