class Gqlt < Formula
  desc "Simple GraphQL toolkit ! ❤"
  homepage "https://github.com/digiz3d/graphql-toolkit"
  version "1.0.2"  # gqlt:version

  on_linux do
    on_arm do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.2/aarch64-linux-gqlt"  # gqlt:url-aarch64-linux
      sha256 "5edddc98d0f89eba344841b3ef52154a2205cef75a871ec65eb86f0b8cbf82cc"  # gqlt:sha-aarch64-linux
    end
    on_intel do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.2/x86_64-linux-gqlt"  # gqlt:url-x86_64-linux
      sha256 "1e084115fdc37f08558c3fd8a9ad42e7e833ae7f11f0c6fb07d267973c4156dd"  # gqlt:sha-x86_64-linux
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.2/aarch64-macos-gqlt"  # gqlt:url-aarch64-macos
      sha256 "a9d4813802d6f49879cec15e636252cf3a3b52380fc0d5d22e9be994297385d9"  # gqlt:sha-aarch64-macos
    end
    on_intel do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.0.2/x86_64-macos-gqlt"  # gqlt:url-x86_64-macos
      sha256 "57660b7099ac8c5f032846ca5e2461895267f63af2bffa8cb29ed89150960541"  # gqlt:sha-x86_64-macos
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
