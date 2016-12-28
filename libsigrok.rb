require 'formula'

class Libsigrok < Formula
  url 'http://sigrok.org/download/source/libsigrok/libsigrok-0.4.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libsigrok',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha256 '5f291f3fee36e6dab1336f1c78596e50588831bc5ebd7cddc2a95fe8c71d669e'

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
    ENV.delete "PYTHONPATH"
    if build.head?
      system "./autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}", "--disable-java"
    system "make", "install"
    system "ln", "-s", "/usr/local/share/", "#{prefix}/share"
  end

end
