require 'formula'

class Libserialport < Formula
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libserialport'
  #sha1 ''
  version 'dev'

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

end
