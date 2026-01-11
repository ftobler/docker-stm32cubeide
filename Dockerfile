FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LICENSE_ALREADY_ACCEPTED=1
ENV PIP_ROOT_USER_ACTION=ignore

RUN apt-get update \
    && apt-get install unzip wget -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && wget https://github.com/ftobler/docker-stm32cubeide/releases/download/initial/st-stm32cubeide_2.0.0_26820_20251114_1348_amd64.deb_bundle.sh.zip \
    && mv *.zip st-stm32cubeide_amd64.deb_bundle.zip \
    && unzip *.zip \
    && rm *.zip \
    && mv *.sh st-stm32cubeide_amd64.deb_bundle.sh \
    && chmod +x *.sh \
    && ./st-stm32cubeide_amd64.deb_bundle.sh \
    && rm *.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y nodejs npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV STM32IDE_DIR="/opt/st/stm32cubeide_2.0.0"
ENV PATH="${PATH}:${STM32IDE_DIR}"

RUN if [ ! -d "$STM32IDE_DIR" ]; then \
    echo "Error: $STM32IDE_DIR is missing! The installation failed."; \
    exit 1; \
fi

CMD ["/bin/bash"]
