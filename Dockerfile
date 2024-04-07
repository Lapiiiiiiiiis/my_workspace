# Use an official base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /root

# Install necessary tools
RUN apt-get update && \
    apt-get install -y \
    python3 \
    git \
    locales \
    subversion \
    stow \
    curl \
    tree \
    file \
    vim \
    cscope \
    libpcre2-32-0 \
    gettext-base \
    man-db \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Other configuration or setup steps if needed

# locale config
RUN locale-gen en_US.UTF-8

# Setting proxy
ENV https_proxy=http://192.168.0.102:7890
ENV http_proxy=http://192.168.0.102:7890
ENV all_proxy=socks5://192.168.0.102:7890

# Install fish
RUN curl -L -o fish_3.7.1-1~jammy_amd64.deb https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+files/fish_3.7.1-1~jammy_amd64.deb
RUN dpkg -i fish_3.7.1-1~jammy_amd64.deb
# Install rg
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
RUN dpkg -i ripgrep_14.1.0-1_amd64.deb

# Install fish plugins
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install
RUN curl -L -o bat_0.24.0_amd64.deb https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb
RUN dpkg -i bat_0.24.0_amd64.deb
RUN curl -L -o fd_9.0.0_amd64.deb https://github.com/sharkdp/fd/releases/download/v9.0.0/fd_9.0.0_amd64.deb
RUN dpkg -i fd_9.0.0_amd64.deb

SHELL ["/bin/fish", "-c"]
RUN curl -L https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher install PatrickF1/fzf.fish && fisher install jethrokuan/z

# Install good vimrc by github
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && /bin/sh ~/.vim_runtime/install_awesome_vimrc.sh

# Install rg
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_0.41.0_Linux_x86_64.tar.gz"
RUN tar xf lazygit.tar.gz lazygit
# Install lazygit
RUN install lazygit /usr/local/bin

# Using stow manage configure files
RUN git clone https://github.com/Lapiiiiiiiiis/dotfiles.git
RUN cd dotfiles && stow -R -t ~/ tmux vim fish

# Delete proxy
ENV https_proxy=
ENV http_proxy=
ENV all_proxy=

# Todo:




# Specify the default command to run when the container starts
CMD ["/bin/fish"]

