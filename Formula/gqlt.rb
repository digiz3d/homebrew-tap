class Gqlt < Formula
  desc "Simple GraphQL toolkit ! ❤"
  homepage "https://github.com/digiz3d/graphql-parser"
  version "1.0.1"

  on_linux do
    on_arm do
      url "https://github.com/digiz3d/graphql-parser/releases/download/v1.0.1/aarch64-linux-gqlt",
      sha256 "462526415400f5e3b94c3c74692362dfbca0862255490855db4c72529a6dfd36"
    end
    on_intel do
      url "https://github.com/digiz3d/graphql-parser/releases/download/v1.0.1/x86_64-linux-gqlt",
      sha256 "b9b815c2da29bad446c8946b736b2ee9e57fb390f4cd800abb517af2132e9651"
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/digiz3d/graphql-parser/releases/download/v1.0.1/aarch64-macos-gqlt",
      sha256 "159d2f8383bfcc7d2c374bfbab76045182021b4855e8054ebdfb3b5a7440ab31"
    end
  end

  def install
    binary_name = nil
    on_linux do
      on_arm { binary_name = "aarch64-linux-gqlt" }
      on_intel { binary_name = "x86_64-linux-gqlt" }
    end
    on_macos do
      on_arm { binary_name = "aarch64-macos-gqlt" }
    end
    odie "Unsupported platform: no gqlt binary for #{OS.kernel_name}-#{Hardware::CPU.arch}" if binary_name.nil?
    bin.install binary_name => "gqlt"
  end

  def caveats; <<~EOS
    ❤ Thanks for installing gqlt ! ❤
  EOS
  end
end
