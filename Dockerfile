# Usa una imagen base con soporte CUDA para GPUs
FROM ollama/ollama

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Instala el toolkit de NVIDIA (sin necesidad de 'sudo')
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
    && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
    && apt-get update \
    && apt-get install -y nvidia-container-toolkit \
    && rm -rf /var/lib/apt/lists/*

# Agrega Ollama al PATH (por si no se reconoce)
ENV PATH="/root/.ollama/bin:$PATH"

# Expone el puerto de Ollama
EXPOSE 11434

# Comando para iniciar Ollama
CMD ["serve"]
