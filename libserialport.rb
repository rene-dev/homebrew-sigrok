require 'formula'

class Libserialport < Formula
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libserialport'
  #sha1 ''
  version 'dev'

  depends_on 'glib'
  depends_on 'libtool'
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

end
