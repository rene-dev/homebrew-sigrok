require 'formula'

class SigrokCli < Formula
  url 'http://sigrok.org/download/source/sigrok-cli/sigrok-cli-0.7.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/sigrok-cli',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha256 '5669d968c2de3dfc6adfda76e83789b6ba76368407c832438cef5e7099a65e1c'

  depends_on 'andrimarjonsson/sigrok/libsigrok'
  depends_on 'andrimarjonsson/sigrok/libsigrokdecode'
  depends_on 'libserialport' => :optional
  depends_on 'glib'
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    ENV.delete "PYTHONPATH"
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
