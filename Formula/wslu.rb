class Wslu < Formula
  desc "A collection of utilities for WSL"
  homepage "https://github.com/wslutilities/wslu"
  url "https://github.com/wslutilities/wslu/archive/v3.1.0.tar.gz"
  sha256 "d5bfa71d3799d5fda50d5e13be87d77df71b5e1b61462f63d85d5ba54efc4f85"
  version "3.1.0"

  def install
    # Ensure the configure.sh script is executable
    chmod "+x", "configure.sh"

    # Run configure.sh with the correct prefix
    system "./configure.sh", "--prefix=#{prefix}"

    # Run make with the prefix if necessary
    system "make", "PREFIX=#{prefix}"

    # Install the binaries manually from the 'out' directory
    bin.install Dir["out/*"]

    # Optionally, install the man pages
    man1.install Dir["out-docs/*.1.gz"]
    man7.install Dir["out-docs/*.7.gz"]
  end
end
