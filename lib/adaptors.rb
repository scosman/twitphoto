require 'uri'

module TwitPhoto
class Adaptors
  class InstagramAdaptor
    def self.getImageUrl url
        if url.index("http://instagr.am") != 0
          return nil
        end

        # ensure last char is '/'
        if url[url.length - 1] != "/"[0]
          url = url + "/"
        end

        return url + "media/?size=m"
    end
  end

  class LockerzAdaptor
    def self.getImageUrl url
        # TweetPhoto was a good name, why they changed twice I don't understand
        if url.index("http://tweetphoto.com") != 0 && url.index("http://plixi.com") != 0 && url.index("http://lockerz.com") != 0
          return nil
        end

        return "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=medium&url=" + url 
    end
  end

  class TwitPicAdaptor
    def self.getImageUrl url
        # check for "http://twitpic.com" (no domain since yfrog supports many domains
        if url.index("http://twitpic.com") != 0
          return nil
        end

        uri = URI.parse(url)
        id = uri.path

        return "http://twitpic.com/show/large" + id 
    end
  end

  class YFrogAdaptor
    def self.getImageUrl url
        # check for "http://yfrog." (no domain since yfrog supports many domains
        if url.index("http://yfrog.") != 0
          return nil
        end

        uri = URI.parse(url)
        id = uri.path
        
        return "http://yfrog.com" + id + ":medium"
    end
  end

end
end
