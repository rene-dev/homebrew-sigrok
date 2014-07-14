require 'formula'

class Libsigrokdecode < Formula
  url 'http://sigrok.org/download/source/libsigrokdecode/libsigrokdecode-0.2.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libsigrokdecode',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha1 '8c5de1c1a6097f5a1584e3d4635d3fb5e37307cb'

  depends_on 'libsigrok'
  depends_on 'glib'
  depends_on 'pkg-config' => :build
  depends_on :python3
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

end
