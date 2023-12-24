class Dinit < Formula
  desc "Service monitoring / 'init' system"
  homepage "https://davmac.org/projects/dinit/"
  url "https://github.com/davmac314/dinit/releases/download/v0.17.1/dinit-0.17.1.tar.xz"
  sha256 "0617956ed2e8cddae5e21f6034546a2f7338364111b99dcc6cd5f3c37080301c"
  license "Apache-2.0"
  depends_on "make" => :build

  def install
    system "./configure", "--sbindir=#{sbin}", "--mandir=#{man}", "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  service do
    run [opt_sbin/"dinit"]
    keep_alive always: true
    log_path "#{Dir.home}/Library/Logs/dinit.log"
    error_log_path "#{Dir.home}/Library/Logs/dinit.log"
  end

  test do
    system "#{sbin}/dinitctl", "--version"
  end
end
