require 'formula'

class SigrokCli < Formula
  url 'http://sigrok.org/download/source/sigrok-cli/sigrok-cli-0.5.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/sigrok-cli',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha256 '73a30501525b13c09624ae00d37041cdaa50238d89c6febf169fc784affe723c'

  depends_on 'libsigrok'
  depends_on 'libsigrokdecode'
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
