require 'adaptors'

module TwitPhoto
class TwitPhoto

  public

  # gets all of the photo URLs from a blog of text
  #
  # == Parameters:
  # text::
  #   the text you want to extract media from
  #
  # == Returns:
  # return::
  #   an array of URLs as strings (not URI objects)
  #
  # == Example:
  # Get photo URLs from a block of text
  #   TwitPhoto::TwitPhoto.getPhotoUrlsFromText "Hello http://yfrog.com/kfx6gdj http://yfrog.com/klmjxyej"
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

  # extracts the media url from a shortened url (if possible)
  #
  # == Parameters:
  # url::
  #   The URL as a string (not URI)
  #
  # == Returns:
  # return::
  #   A media URL as a string, or nil
  # 
  # == Example:
  #    TwitPhoto::TwitPhoto.getPhotoUrlFromUrl "http://yfrog.com/kfx6gdj"
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

  # returns all of the photo URLs from a tweet object from the "twitter" gem (http://twitter.rubyforge.org/)
  #
  # IMPORTANT: this expects detailed entities from the twitter API, so request with :include_entities => 't'
  # 
  # IMPORTANT: this will yield better results than the other methods, since Twitter now has native media support
  #
  # == Paramaters
  # tweet::
  #   the tweet object from the twitter gem
  #
  # == Returns:
  # returns::
  #   the array of media URLs in this tweet
  def self.getPhotoUrlsFromTweet tweet
    results = []

    # ensure the user included entites
    if !defined? tweet.entites || tweet.entities.nil?
      raise ArgumentError, 'not a valid tweet object, make sure you :include_entities => \'t\' in the request'
    end

    # process URLs from third party photos
    urls = tweet.entities.urls || []
    urls.each do |url|
      # sometimes its in expanded, sometimes URL
      actualUrl = url.expanded_url
      if actualUrl.nil?
        actualUrl = url.url
      end
      if !actualUrl.nil?
        photoUrl = TwitPhoto.getPhotoUrlFromUrl actualUrl
        if !photoUrl.nil?
          results << photoUrl
        end
      end
    end

    # find any media from twitter itself (photobucket)
    medias = tweet.entities.media || []
    medias.each do |media|
      #only photos
      if 'photo'.eql? media[:type]
        results << media.media_url
      end
    end

    return results
  end


end
end
