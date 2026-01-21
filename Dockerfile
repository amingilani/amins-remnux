FROM remnux/remnux-distro:focal

# Install Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

RUN sudo apt-get update && \
    sudo apt-get install -y zsh byobu && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    byobu-enable

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]