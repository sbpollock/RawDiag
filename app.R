# Import libraries
library(rawDiag) # https://github.com/fgcz/rawDiag/releases
library(ggplot2)
library(protViz)

# Create directories
dir.create("/input/rawdiag")
dir.create("/input/rawdiag/tabular")
dir.create("/input/rawdiag/figures")
dir.create("/input/rawdiag/figures/basepeak")
dir.create("/input/rawdiag/figures/tic")
dir.create("/input/rawdiag/figures/ms1_injection")
dir.create("/input/rawdiag/figures/ms2_injection")

# List files and print
fl <- list.files("/input", pattern = ".raw")
cat(fl)

# Start for-loop through each file
for (i in 1:length(fl)) {

    # Define filename
    rawfilename <- paste0("/input/", fl[i])

    # Read in raw file
    raw <- read.raw(rawfilename)

    # Define simple filename (remove .raw)
    simple <- strsplit(fl[i], ".raw")[[1]][1]

    # Write out tabular file data
    write.csv(raw, paste0("/input/rawdiag/tabular/", simple, ".csv"))

    # Create basepeak intensity graph
    p_bpi <- ggplot(subset(raw, BasePeakIntensity > 0)) +
        geom_area(aes(x = StartTime, y = BasePeakIntensity)) +
        labs(x = "Retention Time (min)", y = "Base Peak Intensity", title = fl[i])

    # Create total ion chromatogram graph
    p_tic <- ggplot(subset(raw, TIC > 0)) +
        geom_area(aes(x = StartTime, y = TIC)) +
        labs(x = "Retention Time (min)", y = "Total Ion Intensity", title = fl[i])

    # Create MS fill time graph
    p_ms1 <- ggplot(subset(raw, MSOrder == "Ms")) +
        geom_point(aes(x = StartTime, y = IonInjectionTimems), alpha = 0.5, size = 0.5) +
        labs(x = "Retention Time (min)", y = "MS1 ion injection time (ms)", title = fl[i])

    # Create MS2 fill time graph
    p_ms2 <- ggplot(subset(raw, MSOrder == "Ms2")) +
        geom_point(aes(x = StartTime, y = IonInjectionTimems), alpha = 0.5, size = 0.5) +
        labs(x = "Retention Time (min)", y = "MS2 ion injection time (ms)", title = fl[i])

    ###################
    ### SAVE IMAGES ###
    ###################

    ggsave(
        filename = paste0("/input/rawdiag/figures/basepeak/", simple, ".png"),
        plot = p_bpi,
        device = "png",
        dpi = 300,
        units = "in",
        width = 6,
        height = 4
    )

    ggsave(
        filename = paste0("/input/rawdiag/figures/tic/", simple, ".png"),
        plot = p_tic,
        device = "png",
        dpi = 300,
        units = "in",
        width = 6,
        height = 4
    )

    ggsave(
        filename = paste0("/input/rawdiag/figures/ms1_injection/", simple, ".png"),
        plot = p_ms1,
        device = "png",
        dpi = 300,
        units = "in",
        width = 6,
        height = 4
    )

    ggsave(
        filename = paste0("/input/rawdiag/figures/ms2_injection/", simple, ".png"),
        plot = p_ms2,
        device = "png",
        dpi = 300,
        units = "in",
        width = 6,
        height = 4
    )
}
