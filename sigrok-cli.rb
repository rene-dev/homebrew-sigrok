require 'formula'

class SigrokCli < Formula
  url 'http://sigrok.org/download/source/sigrok-cli/sigrok-cli-0.5.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/sigrok-cli',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha1 '6fb5d6ff75f6492bca8d3da66ba446a6438438de'

  depends_on 'libsigrok'
  depends_on 'rene-dev/sigrok/libsigrokdecode'
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
    py_ver = Formula["python3"].pkg_version.to_s[0..2] # e.g "3.4"
    ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/#{py_ver}/lib/pkgconfig/"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/sigrok-cli", "--version"
  end
end
