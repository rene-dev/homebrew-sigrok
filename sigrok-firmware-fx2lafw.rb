require 'formula'

class SigrokFirmwareFx2lafw < Formula
  url 'http://sigrok.org/download/source/sigrok-firmware-fx2lafw/sigrok-firmware-fx2lafw-0.1.1.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/sigrok-firmware-fx2lafw',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha1 'aac6f8f827e7446a5dabc6f82a8620372fd340e6'

  depends_on 'glib'
  depends_on 'libtool'
  depends_on 'sdcc'
  depends_on 'pkg-config' => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    if build.head?
      system "./autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

end
