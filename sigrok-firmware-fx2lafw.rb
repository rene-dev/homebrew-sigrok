require 'formula'

class SigrokFirmwareFx2lafw < Formula
  url 'http://sigrok.org/download/source/sigrok-firmware-fx2lafw/sigrok-firmware-fx2lafw-0.1.2.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/sigrok-firmware-fx2lafw',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha256 '85c658f851fd90089382756b4c5f0326f96d630a0ad5637455a84a4a058b3572'

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
