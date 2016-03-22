require 'formula'

class Libsigrokdecode < Formula
  url 'http://sigrok.org/download/source/libsigrokdecode/libsigrokdecode-0.4.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/libsigrokdecode',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha256 'fd7e9d1b73245e844ead97a16d5321c766196f946c9b28a8646cab2e98ec3537'

  depends_on 'libsigrok'
  depends_on 'glib'
  depends_on 'pkg-config' => :build
  depends_on :python3
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

end
