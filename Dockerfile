# Use an official base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /workspace

# Install necessary tools
RUN apt-get update && \
    apt-get install -y \
    python3 \
    git \
    locales \
    subversion \
    curl \
    tree \
    file \
    vim \
    cscope \
    libpcre2-32-0 \
    gettext-base \
    man-db \
    tmux \
    silversearcher-ag \
    && rm -rf /var/lib/apt/lists/*

# Other configuration or setup steps if needed
# Install fish
RUN curl -L -o fish_3.7.0-1~jammy_amd64.deb https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+files/fish_3.7.0-1~jammy_amd64.deb
RUN dpkg -i fish_3.7.0-1~jammy_amd64.deb

# Setting proxy
ENV https_proxy=http://192.168.0.102:7890
ENV http_proxy=http://192.168.0.102:7890
ENV all_proxy=socks5://192.168.0.102:7890
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

# Config tmux
RUN echo -e 'set-option -g default-shell "/bin/fish"\nset-window-option -g mode-keys vi' > ~/.tmux.conf

# Config fish
RUN echo 'set -gx TERM xterm-256color' > ~/.config/fish/config.fish

# Delete proxy
ENV https_proxy=
ENV http_proxy=
ENV all_proxy=

# Config vim
COPY my_configs.vim /root/.vim_runtime/

# locale config
RUN locale-gen en_US.UTF-8
# Todo:




# Specify the default command to run when the container starts
CMD ["/bin/fish"]

