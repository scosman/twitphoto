require 'helper'
require 'test/unit'
require 'twitphoto'
require 'adaptors'

class TestTwitphoto < Test::Unit::TestCase

  should "test getPhotoFromUrl" do
    assert_equal TwitPhoto.getPhotoUrlFromUrl("http://tweetphoto.com/28103398"), "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=medium&url=http://tweetphoto.com/28103398"
    assert_equal TwitPhoto.getPhotoUrlFromUrl("http://lockerz.com/s/110826629"), "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=medium&url=http://lockerz.com/s/110826629"
    assert_equal TwitPhoto.getPhotoUrlFromUrl("http://plixi.com/p/89511189"), "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=medium&url=http://plixi.com/p/89511189"
    assert_equal TwitPhoto.getPhotoUrlFromUrl("http://yfrog.com/gzozrllj"), "http://yfrog.com/gzozrllj:medium"
    assert_equal TwitPhoto.getPhotoUrlFromUrl("http://instagr.am/p/Fv3t0"), "http://instagr.am/p/Fv3t0/media/?size=m"
    assert_equal TwitPhoto.getPhotoUrlFromUrl("http://twitpic.com/5bpgp0"), "http://twitpic.com/show/thumb/5bpgp0"
    assert TwitPhoto.getPhotoUrlFromUrl("http://google.ca").nil?
  end

  should "test getPhotoUrlsFromText" do
    assert_equal TwitPhoto.getPhotoUrlsFromText("http:www.google.com").length, 0
    assert_equal TwitPhoto.getPhotoUrlsFromText("http:www.google.com http://tweetphoto.com/28103398").length, 1
    assert_equal TwitPhoto.getPhotoUrlsFromText("http:www.google.com http://tweetphoto.com/28103398 http://instagr.am/p/Fv3t0").length, 2
    assert_equal TwitPhoto.getPhotoUrlsFromText("http://lockerz.com/s/110826629").length, 1
    assert_equal TwitPhoto.getPhotoUrlsFromText("Content http://twitpic.com/5bpgp0 content").length, 1
    assert_equal TwitPhoto.getPhotoUrlsFromText("Content http://yfrog.com/gzozrllj http://plixi.com/p/89511189 content").length, 2
  end

  should "test TweetPhot/Lockerz/Plixi" do
    assert_equal Adaptors::LockerzAdaptor.getImageUrl("http://tweetphoto.com/28103398"), "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=medium&url=http://tweetphoto.com/28103398"
    assert_equal Adaptors::LockerzAdaptor.getImageUrl("http://lockerz.com/s/110826629"), "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=medium&url=http://lockerz.com/s/110826629"
    assert_equal Adaptors::LockerzAdaptor.getImageUrl("http://plixi.com/p/89511189"), "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=medium&url=http://plixi.com/p/89511189" 
    assert Adaptors::YFrogAdaptor.getImageUrl("http://notyfrog.com/gzozrllj").nil?
  end
  
  should "test Yfrog" do
    assert_equal Adaptors::YFrogAdaptor.getImageUrl("http://yfrog.com/gzozrllj"), "http://yfrog.com/gzozrllj:medium" 
    assert Adaptors::YFrogAdaptor.getImageUrl("http://notyfrog.com/gzozrllj").nil?
    assert_equal Adaptors::YFrogAdaptor.getImageUrl("http://yfrog.com/gz23uqdj"), "http://yfrog.com/gz23uqdj:medium"
  end

  should "test Instagram" do
    assert_equal Adaptors::InstagramAdaptor.getImageUrl("http://instagr.am/p/Fv3t0"), "http://instagr.am/p/Fv3t0/media/?size=m"
    assert Adaptors::InstagramAdaptor.getImageUrl("http://instagr.aam/p/Fv3t0").nil?
    assert_equal Adaptors::InstagramAdaptor.getImageUrl("http://instagr.am/p/Fv3t0/"), "http://instagr.am/p/Fv3t0/media/?size=m"
  end

  should "test TwitPic" do
    assert_equal Adaptors::TwitPicAdaptor.getImageUrl("http://twitpic.com/5bpgp0"), "http://twitpic.com/show/thumb/5bpgp0"
    assert Adaptors::TwitPicAdaptor.getImageUrl("http://nottwitpic.com/5bpgp0").nil?
    assert_equal Adaptors::TwitPicAdaptor.getImageUrl("http://twitpic.com/5b3rhe"), "http://twitpic.com/show/thumb/5b3rhe"
  end

end
