require 'formula'

class Libsigrok < Formula
  url 'http://sigrok.org/download/source/libsigrok/libsigrok-0.3.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libsigrok',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha1 '140db550820f98042d95432a87a9d7e3078b1490'

  depends_on 'libzip'
  depends_on 'glib'
  depends_on 'libserialport' => :optional
  depends_on 'libftdi' => :optional
  depends_on 'libusb'
  depends_on 'libtool'
  depends_on 'glibmm'
  depends_on 'doxygen'
  depends_on 'pkg-config' => :build
  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
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
