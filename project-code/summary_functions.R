SingleSamplesSummary  <- 
  function(variable) {
    # Make summary of input variable 
    #
    # Args:
    #   variable: the variable to be summarised.
    #
    # Returns:
    #   The summary of the variable.
    
    input_variable <- variable
    
    # Make summary of input variable for single samples, and add IQR, sd
    output <-  tidy(summary(input_variable)) %>% 
      mutate(.,
             iqr = IQR(input_variable),
             sd = sd(input_variable),
             n = "1",
             values = length(input_variable)
             #distinct = n_distinct(input_variable)
      ) %>%
      select(n,
             values,
             #distinct,
             everything())
    
    colnames(output) <- c("n",
                          "values", 
                          #"distinct", 
                          "min", 
                          "q1", 
                          "med", 
                          "mean", 
                          "q3", 
                          "max", 
                          "iqr", 
                          "sd")
    
    # Return the summary
    return(output)
    
  }

MergedSamplesSummary  <- 
  function(variable) {
    # Make summary of input variable 
    #
    # Args:
    #   variable: the variable to be summarised.
    #
    # Returns:
    #   The summary of the variable.
    
    input_variable <- variable
    
    # Make summary of input variables, and add IQR, sd
    output <-  tidy(summary(input_variable)) %>% 
      mutate(.,
             iqr = IQR(input_variable),
             sd = sd(input_variable),
             n = "8",
             values = length(input_variable)
             #distinct = n_distinct(input_variable)
      ) %>%
      select(n,
             values,
             #distinct,
             everything())
    
    colnames(output) <- c("n",
                          "values", 
                          #"distinct", 
                          "min", 
                          "q1", 
                          "med", 
                          "mean", 
                          "q3", 
                          "max", 
                          "iqr", 
                          "sd")
    
    # Return the summary
    return(output)
    
  }

SummariseROHs  <- 
  function(object_name, variable) {
    # Make summary of ROH variable grouped by Mb
    #
    # Args:
    #   variables: the ROH object_name and the ROH-variable to be summarised.
    #
    # Returns:
    #   The summary of the ROH-variable for each value of Mb.
    
    # Select the two relevant columns: the grouping variable and the ROH-variable
    roh_input <- select(object_name, Mb, var = variable)
    
    if (variable == "KB" | variable == "KBAVG") {
      # Convert the unit of the variable to Mb 
      roh_input <- mutate(roh_input, var = var/1000) 
    } 
    
    #Summarise the ROHs variable
    roh_summarised <-
      roh_input %>%
      group_by(Mb) %>%
      summarise(
        #values = length(var),
        distinct = n_distinct(var),
        "min" = min(var),
        "q1" = quantile(var, 0.25),
        "med" = median(var),
        "mean" = mean(var),
        "q3" = quantile(var, 0.75),
        "max" = max(var),
        iqr = IQR(var),
        sd = sd(var))
    
    # Return the summary
    return(roh_summarised)
    
  }

SummariseAncestry  <- 
  function(object_name, variable) {
    # Make summary of ancestry variable
    #
    # Args:
    #   variables: the ancestry object_name and the variable to be summarised.
    #
    # Returns:
    #   The summary of the variable 
    
    # Select the two relevant columns: the grouping variable and the ROH-variable
    ancestry_input <- select(object_name, Ancestry, Anc_2nd, var = variable)
    
    if (variable == "Pr_Anc") {
      Ancestry_var <- unique(ancestry_input$Ancestry)
    } 
    if (variable == "Pr_2nd") {
       Ancestry_var <- unique(ancestry_input$Anc_2nd)
    } 
    
    #Summarise the variable
    ancestry_summarised <-
      ancestry_input %>%
      summarise(
        "Ancestry" = Ancestry_var,
        values = length(var),
        "parameter" = variable, 
        #distinct = n_distinct(var),
        "min" = min(var),
        "q1" = quantile(var, 0.25),
        "med" = median(var),
        "mean" = mean(var),
        "q3" = quantile(var, 0.75),
        "max" = max(var),
        iqr = IQR(var),
        sd = sd(var))
    
    # Return the summary
    return(ancestry_summarised)
    
  }

MergedSamplesSummariseObjectForeachN  <-
  function(object_name) {
    #  Summarise the output object from the bySNP QC-report
    #
    # Args:
    #   object_name: the object to be summarised.
    #
    # Returns:
    #   the summarised object.
    
    input_object <- object_name
    
    # Summarise input object
    output <-  
      input_object %>% 
      filter(N > 0) %>% 
      # group_by N, CallRate to show N, CallRate
      group_by(N, CallRate) %>% 
      summarise(
        SNPs = n(),
        Genotypes = sum(N),
        Aa = sum(N_Aa),
        H = Aa/Genotypes
      ) 
    
    # Return the summarised object - ungrouped
    return(ungroup(output))
    
  }

MergedSamplesSummariseObjectForallN  <- 
  function(object_name) {
    #  Summarise the output object from the bySNP QC-report
    #
    # Args:
    #   object_name: the object to be summarised.
    #
    # Returns:
    #   the summarised object.
    
    input_object <- object_name
    
    # Summarise input object
    output <-  
      input_object %>% 
      filter(N > 0) %>% 
      summarise(
        SNPs = n(),
        Genotypes = sum(N),
        Aa = sum(N_Aa),
        H = Aa/Genotypes
      ) %>% 
      mutate(N = "1-8") %>% 
      select(N, 
             everything())
    
    # Return the summarised object - ungrouped
    return(ungroup(output))
    
  }

