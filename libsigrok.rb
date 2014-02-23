require 'formula'

class Libsigrok < Formula
  url 'http://sigrok.org/download/source/libsigrok/libsigrok-0.2.2.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libsigrok',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha1 '93004c49c5cad7df5e0fc7621df5ca9ed6e2a7df'

  depends_on 'libzip'
  depends_on 'glib'
  depends_on 'libserialport' => :optional
  depends_on 'libftdi' => :optional
  depends_on 'libusb'
  depends_on 'libtool'
  depends_on 'pkg-config' => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    if build.head?
      system "./autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
    system "ln", "-s", "/usr/local/share/", "#{prefix}/share"
  end

end
