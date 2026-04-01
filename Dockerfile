FROM jupyter/minimal-notebook:latest

USER root

# 1. Install system tools
RUN apt-get update && apt-get install -y wget && apt-get clean

# 2. Install FORM 5.0 
RUN wget https://github.com/form-dev/form/releases/download/v5.0.0/form-5.0.0-x86_64-linux.tar.gz && \
    tar -xzvf form-5.0.0-x86_64-linux.tar.gz && \
    mv $(find . -name "form" -type f) /usr/local/bin/form && \
    mv $(find . -name "tform" -type f) /usr/local/bin/tform && \
    chmod +x /usr/local/bin/form /usr/local/bin/tform && \
    # Remove everything EXCEPT your GitHub files
    rm -rf form-5.0.0* form/

# 3. Fix Permissions 
RUN chown -R ${NB_USER}:users /home/jovyan

USER ${NB_USER}

# 4. Set the home directory as the starting point
WORKDIR /home/jovyan

# 5. Install Python requirements
RUN pip install --no-cache-dir matplotlib numpy ipykernel matplotlib-inline
