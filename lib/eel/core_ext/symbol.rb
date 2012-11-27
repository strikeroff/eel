class Symbol

  delegate :gt, :gteq, :lt, :lteq,
           :eq, :in,
           :desc, :asc,
           to: :attr

  def attr
    attr = Arel::Attributes::Attribute.new
    attr.name = self
    attr
  end

  def of val
    relation = case val
                 when Class
                   val.arel_table
                 when Symbol
                   val.to_s.classify.constantize
                 when String
                   val.classify.constantize
                 else
                   raise "Can't use #{val.class} as a relation"
               end

    attr = Arel::Attributes::Attribute.new
    attr.name = self
    attr.relation = relation
    attr
  end

end