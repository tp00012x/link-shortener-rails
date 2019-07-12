class ShortLink < ApplicationRecord
  include Obfuscate

  def to_param
    encrypt(id)
  end
end
