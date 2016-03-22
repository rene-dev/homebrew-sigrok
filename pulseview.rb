require 'formula'

class Pulseview < Formula
  url 'http://sigrok.org/download/source/pulseview/pulseview-0.3.0.tar.gz'
  homepage 'http://sigrok.org/'
  head 'git://sigrok.org/pulseview',:using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }
  sha256 '5ffe2cb7a602fcdc60933d400c77bcd66e6ce529bc4f6e97d6a5e5a86f2f530e'

  depends_on 'libsigrok' => :build
  depends_on 'libsigrokdecode'
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
    ENV.delete "PYTHONPATH"
    py_ver = Formula["python3"].pkg_version.to_s[0..2] # e.g "3.4"
    ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/#{py_ver}/lib/pkgconfig/"
    system "cmake", ".", "-DENABLE_DECODE=y", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/pulseview", "-V"
  end
end
