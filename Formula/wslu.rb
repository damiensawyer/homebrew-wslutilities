class Wslu < Formula
  desc "A collection of utilities for WSL"
  homepage "https://github.com/wslutilities/wslu"
  url "https://github.com/wslutilities/wslu/archive/v3.1.0.tar.gz"
  sha256 "d5bfa71d3799d5fda50d5e13be87d77df71b5e1b61462f63d85d5ba54efc4f85"
  version "3.1.0"

  depends_on "make" => :build
  depends_on "gzip" => :build
  depends_on "bc"
  depends_on "imagemagick"

  def install
    ENV["DESTDIR"] = prefix
    ENV["PREFIX"] = ""

    system "make", "all"
    system "make", "install"

    # Optionally, we can search for the bash completion file and install it if found
    bash_completion_file = Dir.glob("**/*wslu").first
    bash_completion.install bash_completion_file if bash_completion_file
  end

  def caveats
    <<~EOS
      wslu is designed for Windows Subsystem for Linux (WSL) environments.
      It may not function correctly in a standard Linux environment.

      Bash completion may not be available for this installation.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wslsys -v")
  end

  # Hook for uninstallation before brew removes the files
  def pre_uninstall
    # Call make uninstall with necessary environment variables
    ENV["DESTDIR"] = prefix
    ENV["PREFIX"] = ""

    system "make", "uninstall"
  end
end
