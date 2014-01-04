require 'formula'

class Pulseview < Formula
  url 'http://sigrok.org/download/source/pulseview/pulseview-0.1.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/pulseview'
  sha1 '800450bdf65ce9c7559c2522a73b0a50e087bcc0'

  depends_on 'libsigrok'
  depends_on 'libsigrokdecode'
  depends_on 'boost'
  depends_on 'qt'
  depends_on 'pkg-config' => :build
  depends_on 'cmake' => :build

  def install
    system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "."
    system "make", "install"
  end

  test do
    system "#{bin}/pulseview", "-V"
  end
end
