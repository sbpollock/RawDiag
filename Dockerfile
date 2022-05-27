# Get shiny plus tidyverse image
FROM rocker/shiny-verse:4.1.0

# Install system libraries
RUN apt-get update && \
apt-get install -y \
sudo \
mono-devel \
mono-complete

# Install R pre-reqs
RUN R -e "install.packages(c('hexbin', 'RSQLite', 'scales','ggplot2','viridis','lattice'), repos='http://cran.rstudio.com/')"

# Install protViz: https://github.com/cpanse/protViz
RUN R -e "install.packages('protViz')"

# Install rawDiag: https://github.com/fgcz/rawDiag
RUN R -e "install.packages('http://fgcz-ms.uzh.ch/~cpanse/rawDiag_0.0.41.tar.gz', repo=NULL)"

# Add the app to the image
ADD app.R /app/

# Run app
CMD Rscript /app/app.R
