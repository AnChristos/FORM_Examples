# Use a Jupyter-compatible base image
FROM jupyter/minimal-notebook:latest

USER root

# Install build dependencies for FORM 5.0
RUN apt-get update && apt-get install -y \
    wget \
    gcc \
    g++ \
    make \
    cmake \
    libgmp-dev \
    zlib1g-dev \
    && apt-get clean

# Download and Build FORM 5.0
# 1. Download and Extract
RUN https://github.com/form-dev/form/releases/download/v5.0.0/form-5.0.0.tar.gz && \
    tar -xzvf form-5.0.0.tar.gz && \
    rm form-5.0.0.tar.gz

# 2. Configure
# We use a wildcard 'cd form-*/' to handle any folder naming surprises
RUN cd form-*/ && \
    mkdir build && \
    cd build && \
    cmake .. -DENABLE_FORMLIB=ON

# 3. Compile (This is the slow part - now cached!)
RUN cd form-*/build && \
    make -j$(nproc)

# 4. Install
RUN cd form-*/build && \
    make install

# 5. Cleanup source files to keep the image small
RUN rm -rf form-*
# Ensure the notebook user has permissions and the right tools
RUN pip install --upgrade pip && \
    pip install "matplotlib>=3.8.0" "ipykernel>=6.29.0" "matplotlib-inline>=0.1.6" "numpy"

USER ${NB_USER}
