class Gqlt < Formula
  desc "Simple GraphQL toolkit ! ❤"
  homepage "https://github.com/digiz3d/graphql-toolkit"
  version "1.0.3"  # gqlt:version

  on_linux do
    on_arm do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.3/aarch64-linux-gqlt"  # gqlt:url-aarch64-linux
      sha256 "c4bf714f3aeb640470e8dee0dd566c858bc26ee706c6b523b40e90bcef52c947"  # gqlt:sha-aarch64-linux
    end
    on_intel do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.3/x86_64-linux-gqlt"  # gqlt:url-x86_64-linux
      sha256 "4062aff93dac5c43049d94393499e4ef7131167d3279c8ad56db5b8142b748d5"  # gqlt:sha-x86_64-linux
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.3/aarch64-macos-gqlt"  # gqlt:url-aarch64-macos
      sha256 "6fb3d1c4c597e3d76a12d5c3b3577bd0722040eeb9469a91944fb91e4dbbafca"  # gqlt:sha-aarch64-macos
    end
    on_intel do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.3/x86_64-macos-gqlt"  # gqlt:url-x86_64-macos
      sha256 "0ea0c456e0e670db59217edcf89439ede4bba783453a81c16614c56c81909b1f"  # gqlt:sha-x86_64-macos
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
      on_intel { binary_name = "x86_64-macos-gqlt" }
    end
    odie "Unsupported platform: no gqlt binary for #{OS.kernel_name}-#{Hardware::CPU.arch}" if binary_name.nil?
    bin.install binary_name => "gqlt"
  end

  def caveats; <<~EOS
    ❤ Thanks for installing gqlt ! ❤
  EOS
  end
end
