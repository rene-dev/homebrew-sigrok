require 'formula'

class SigrokCli < Formula
  url 'http://sigrok.org/download/source/sigrok-cli/sigrok-cli-0.4.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/sigrok-cli'
  sha1 '2172480abf1b7c4be0d50ae3a0c94a7a37e13529'

  depends_on 'libsigrok'
  depends_on 'libsigrokdecode'
  depends_on 'libserialport' => :optional
  depends_on 'glib'
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    if build.head?
      system "./autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/sigrok-cli", "--version"
  end
end
