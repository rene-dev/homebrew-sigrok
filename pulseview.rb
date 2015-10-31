require 'formula'

class Pulseview < Formula
  url 'http://sigrok.org/download/source/pulseview/pulseview-0.2.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/pulseview',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha1 '92be17ef8196fb98162d27b5c0fca382d92dee31'

  depends_on 'libsigrok' => :build
  depends_on 'rene-dev/sigrok/libsigrokdecode'
  depends_on :python3
  depends_on 'libserialport'
  depends_on 'boost'
  depends_on 'qt'
  depends_on 'pkg-config' => :build
  depends_on 'cmake' => :build
  depends_on 'glib'
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    py_ver = Formula["python3"].pkg_version.to_s[0..2] # e.g "3.4"
    ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/#{py_ver}/lib/pkgconfig/"
    system "cmake", ".", "-DENABLE_DECODE=y", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/pulseview", "-V"
  end
end
