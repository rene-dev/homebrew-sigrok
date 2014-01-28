require 'formula'

class Libsigrokdecode < Formula
  url 'http://sigrok.org/download/source/libsigrokdecode/libsigrokdecode-0.2.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libsigrokdecode',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha1 '8c5de1c1a6097f5a1584e3d4635d3fb5e37307cb'

  depends_on 'libsigrok'
  depends_on 'glib'
  depends_on 'pkg-config' => :build
  depends_on :python3
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    if build.head?
      system "./autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

end
