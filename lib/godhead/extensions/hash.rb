class Hash
  # remove all key-value pairs where the value is nil
  def compact
    reject{|key,val| val.nil? }
  end
  # Replace the hash with its compacted self
  def compact!
    replace(compact)
  end

  # lambda for recursive merges
  Hash::DEEP_MERGER = proc do |key,v1,v2|
    if (v1.respond_to?(:merge) && v2.respond_to?(:merge))
      v1.merge(v2.compact, &Hash::DEEP_MERGER)
    else
      (v2.nil? ? v1 : v2)
    end
  end

  #
  # Merge hashes recursively.
  # Nothing special happens to array values
  #
  #     x = { :subhash => { 1 => :val_from_x, 222 => :only_in_x, 333 => :only_in_x }, :scalar => :scalar_from_x}
  #     y = { :subhash => { 1 => :val_from_y, 999 => :only_in_y },                    :scalar => :scalar_from_y }
  #     x.deep_merge y
  #     => {:subhash=>{1=>:val_from_y, 222=>:only_in_x, 333=>:only_in_x, 999=>:only_in_y}, :scalar=>:scalar_from_y}
  #     y.deep_merge x
  #     => {:subhash=>{1=>:val_from_x, 222=>:only_in_x, 333=>:only_in_x, 999=>:only_in_y}, :scalar=>:scalar_from_x}
  #
  # Nil values always lose.
  #
  #     x = {:subhash=>{:nil_in_x=>nil, 1=>:val1,}, :nil_in_x=>nil}
  #     y = {:subhash=>{:nil_in_x=>5},              :nil_in_x=>5}
  #     y.deep_merge x
  #     => {:subhash=>{1=>:val1, :nil_in_x=>5}, :nil_in_x=>5}
  #     x.deep_merge y
  #     => {:subhash=>{1=>:val1, :nil_in_x=>5}, :nil_in_x=>5}
  #
  def deep_merge hsh2
    merge hsh2, &Hash::DEEP_MERGER
  end

  # Merge hashes recursively -- see #deep_merge
  def deep_merge! hsh2
    merge! hsh2, &Hash::DEEP_MERGER
  end
end
