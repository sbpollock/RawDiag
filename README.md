# Use rawDiag to generate mgf and tabular LCMS files
rawDiag is an R-based "a software tool supporting rational method optimization by providing MS operator-tailored diagnostic plots of scan-level metadata". It is used to extract LCMS data, such as base peak intensity, that can be used to visualize and perform QC on runs. rawDiag is described in detail in a 2018 Journal of Proteome Research [publication](https://pubs.acs.org/doi/10.1021/acs.jproteome.8b00173). 

## Instructions
This script will build the rawDiag processing image, then take all of the .raw files in a mounted directory and output tabular and .mgf files to the mounted directory in an output folder, then quits the container.

1. Open Terminal and navigate to wherever you put this Github repo.

3. Set the path to the folder to mount:

MOUNT_PATH=/Users/samuelpollock/Mounts/PO_vs_FASP_NU

3. Run the application:

docker build -t rawdiag . && \
docker run --rm -v $MOUNT_PATH:/input rawdiag

4. After 1-2mins per file, check the mounted folder for your outputs!

## Troubleshooting
- Sometimes rawDiag can get finicky. If it is ever throwing errors (after previously working) you may need to comment out the rawdiag installation line in the Dockerfile, re-build the image, then un-comment-out, then re-run.

