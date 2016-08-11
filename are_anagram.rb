module AreAnagrams
  def self.are_anagrams?(string_a, string_b)
    raise NotImplementedError, 'Not implemented' if string_b.strip.empty? || string_b.strip.empty?
    string_a.chars.sort == string_b.chars.sort
  end
end
