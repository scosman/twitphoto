require 'adaptors'

class TwitPhoto

  public
  def self.getPhotoUrlsFromText(text)
    urlStrings = URI.extract text
    results = []

    urlStrings.each do |url|
      imageUrl = TwitPhoto.getPhotoUrlFromUrl url
      if !imageUrl.nil?
        results << imageUrl
      end 
    end

    return results
  end

  def self.getPhotoUrlFromUrl url
    adaptors = [Adaptors::YFrogAdaptor, Adaptors::TwitPicAdaptor, Adaptors::LockerzAdaptor, Adaptors::InstagramAdaptor]

    adaptors.each do |adaptor|
       imageUrl = adaptor.getImageUrl url
       if !imageUrl.nil?
         return imageUrl
       end
    end

    return nil
  end

  def self.add num1, num2
    return num1 + num2
  end

end
