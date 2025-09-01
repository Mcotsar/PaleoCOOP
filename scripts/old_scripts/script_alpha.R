library (ggplot2)
library (dplyr)
library (gridExtra)
library (grid)
library (reshape2)

#SCENARIO 1. Tian Shan. 

# Scenario 1 alpha 0.5 cost 10 prob coop 0.5

scenario1_alpha5_a = PaleoCOOP_TienShan_Scenario1_alpha0.5_cost10_probcoop0.5
scenario1_alpha5_a = scenario1_alpha5_a [,1:3]
scenario1_alpha5_a= melt (scenario1_alpha5_a, id.vars= "months", variable.name = "series")
scenario1_alpha5_a = ggplot(scenario1_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_a

# Scenario 1 alpha 0.5 cost 10 prob coop 0.8

scenario1_alpha5_b = PaleoCOOP_TienShan_Scenario1_alpha0.5_cost10_probcoop0.8
scenario1_alpha5_b = scenario1_alpha5_b [,1:3]
scenario1_alpha5_b= melt (scenario1_alpha5_b, id.vars= "months", variable.name = "series")
scenario1_alpha5_b = ggplot(scenario1_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_b  


# Scenario 1 alpha 0.5 cost 20 prob coop 0.5

scenario1_alpha5_c = PaleoCOOP_TienShan_Scenario1_alpha0.5_cost20_probcoop0.5
scenario1_alpha5_c = scenario1_alpha5_c [,1:3]
scenario1_alpha5_c= melt (scenario1_alpha5_c, id.vars= "months", variable.name = "series")
scenario1_alpha5_c = ggplot(scenario1_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_c

# Scenario 1 alpha 0.5 cost 20 prob coop 0.8

scenario1_alpha5_d = PaleoCOOP_TienShan_Scenario1_alpha0.5_cost20_probcoop0.8
scenario1_alpha5_d = scenario1_alpha5_d [,1:3]
scenario1_alpha5_d= melt (scenario1_alpha5_d, id.vars= "months", variable.name = "series")
scenario1_alpha5_d = ggplot(scenario1_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_d

# Scenario 1 alpha 0.8 cost 10 prob coop 0.5

scenario1_alpha8_e = PaleoCOOP_TienShan_Scenario1_alpha0.8_cost10_probcoop0.5
scenario1_alpha8_e = scenario1_alpha8_e [,1:3]
scenario1_alpha8_e= melt (scenario1_alpha8_e, id.vars= "months", variable.name = "series")
scenario1_alpha8_e = ggplot(scenario1_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_e

# Scenario 1 alpha 0.8 cost 10 prob coop 0.8

scenario1_alpha8_f = PaleoCOOP_TienShan_Scenario1_alpha0.8_cost10_probcoop0.8
scenario1_alpha8_f = scenario1_alpha8_f [,1:3]
scenario1_alpha8_f= melt (scenario1_alpha8_f, id.vars= "months", variable.name = "series")
scenario1_alpha8_f = ggplot(scenario1_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_f

# Scenario 1 alpha 0.8 cost 20 prob coop 0.5

scenario1_alpha8_g = PaleoCOOP_TienShan_Scenario1_alpha0.8_cost20_probcoop0.5
scenario1_alpha8_g = scenario1_alpha8_g [,1:3]
scenario1_alpha8_g= melt (scenario1_alpha8_g, id.vars= "months", variable.name = "series")
scenario1_alpha8_g = ggplot(scenario1_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_g

# Scenario 1 alpha 0.8 cost 20 prob coop 0.8

scenario1_alpha8_h = PaleoCOOP_TienShan_Scenario1_alpha0.8_cost20_probcoop0.8
scenario1_alpha8_h = scenario1_alpha8_h [,1:3]
scenario1_alpha8_h= melt (scenario1_alpha8_h, id.vars= "months", variable.name = "series")
scenario1_alpha8_h = ggplot(scenario1_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_h

#join scenario 1 together

totalscenario1 = grid.arrange(scenario1_alpha5_a, scenario1_alpha5_b, scenario1_alpha5_c, scenario1_alpha5_d, scenario1_alpha8_e, scenario1_alpha8_f, scenario1_alpha8_g, scenario1_alpha8_h, top = textGrob("Scenario 1 Tian Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario1


#SCENARIO 2. Tian Shan


# Scenario 2 alpha 0.5 cost 10 prob coop 0.5

scenario2_alpha5_a = PaleoCOOP_tienshan_Scenario2_alpha0.5_cost10_probcoop0.5
scenario2_alpha5_a = scenario2_alpha5_a [,1:3]
scenario2_alpha5_a= melt (scenario2_alpha5_a, id.vars= "months", variable.name = "series")
scenario2_alpha5_a = ggplot(scenario2_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_a


# Scenario 2 alpha 0.5 cost 10 prob coop 0.8

scenario2_alpha5_b = PaleoCOOP_tienshan_Scenario2_alpha0.5_cost10_probcoop0.8
scenario2_alpha5_b = scenario2_alpha5_b [,1:3]
scenario2_alpha5_b= melt (scenario2_alpha5_b, id.vars= "months", variable.name = "series")
scenario2_alpha5_b = ggplot(scenario2_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_b  

# Scenario 2 alpha 0.5 cost 20 prob coop 0.5

scenario2_alpha5_c = PaleoCOOP_tienshan_Scenario2_alpha0.5_cost20_probcoop0.5
scenario2_alpha5_c = scenario2_alpha5_c [,1:3]
scenario2_alpha5_c= melt (scenario2_alpha5_c, id.vars= "months", variable.name = "series")
scenario2_alpha5_c = ggplot(scenario2_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_c

# Scenario 2 alpha 0.5 cost 20 prob coop 0.8

scenario2_alpha5_d = PaleoCOOP_tienshan_Scenario2_alpha0.5_cost20_probcoop0.8
scenario2_alpha5_d = scenario2_alpha5_d [,1:3]
scenario2_alpha5_d= melt (scenario2_alpha5_d, id.vars= "months", variable.name = "series")
scenario2_alpha5_d = ggplot(scenario2_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_d


# Scenario 2 alpha 0.8 cost 10 prob coop 0.5

scenario2_alpha8_e = PaleoCOOP_tienshan_Scenario2_alpha0.8_cost10_probcoop0.5
scenario2_alpha8_e = scenario2_alpha8_e [,1:3]
scenario2_alpha8_e= melt (scenario2_alpha8_e, id.vars= "months", variable.name = "series")
scenario2_alpha8_e = ggplot(scenario2_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_e

# Scenario 2 alpha 0.8 cost 10 prob coop 0.8

scenario2_alpha8_f = PaleoCOOP_tienshan_Scenario2_alpha0.8_cost10_probcoop0.8
scenario2_alpha8_f = scenario2_alpha8_f [,1:3]
scenario2_alpha8_f= melt (scenario2_alpha8_f, id.vars= "months", variable.name = "series")
scenario2_alpha8_f = ggplot(scenario2_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_f

# Scenario 2 alpha 0.8 cost 20 prob coop 0.5

scenario2_alpha8_g = PaleoCOOP_tienshan_Scenario2_alpha0.8_cost20_probcoop0.5
scenario2_alpha8_g = scenario2_alpha8_g [,1:3]
scenario2_alpha8_g= melt (scenario2_alpha8_g, id.vars= "months", variable.name = "series")
scenario2_alpha8_g = ggplot(scenario2_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_g

# Scenario 2 alpha 0.8 cost 20 prob coop 0.8

scenario2_alpha8_h = PaleoCOOP_tienshan_Scenario2_alpha0.8_cost20_probcoop0.8
scenario2_alpha8_h = scenario2_alpha8_h [,1:3]
scenario2_alpha8_h= melt (scenario2_alpha8_h, id.vars= "months", variable.name = "series")
scenario2_alpha8_h = ggplot(scenario2_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_h

#join scenario 2 together

totalscenario2 = grid.arrange(scenario2_alpha5_a, scenario2_alpha5_b, scenario2_alpha5_c, scenario2_alpha5_d, scenario2_alpha8_e, scenario2_alpha8_f, scenario2_alpha8_g, scenario2_alpha8_h, top = textGrob("Scenario 2 Tian Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario2


#SCENARIO 3. Tian Shan.


# Scenario 3 alpha 0.5 cost 10 prob coop 0.5

scenario3_alpha5_a = PaleoCOOP_Tienshan_Scenario3_alpha0.5_cost10_probcoop0.5
scenario3_alpha5_a = scenario3_alpha5_a [,1:3]
scenario3_alpha5_a= melt (scenario3_alpha5_a, id.vars= "months", variable.name = "series")
scenario3_alpha5_a = ggplot(scenario3_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_a

# Scenario 3 alpha 0.5 cost 10 prob coop 0.8

scenario3_alpha5_b = PaleoCOOP_Tienshan_Scenario3_alpha0.5_cost10_probcoop0.8
scenario3_alpha5_b = scenario3_alpha5_b [,1:3]
scenario3_alpha5_b= melt (scenario3_alpha5_b, id.vars= "months", variable.name = "series")
scenario3_alpha5_b = ggplot(scenario3_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_b  

# Scenario 3 alpha 0.5 cost 20 prob coop 0.5

scenario3_alpha5_c = PaleoCOOP_Tienshan_Scenario3_alpha0.5_cost20_probcoop0.5
scenario3_alpha5_c = scenario3_alpha5_c [,1:3]
scenario3_alpha5_c= melt (scenario3_alpha5_c, id.vars= "months", variable.name = "series")
scenario3_alpha5_c = ggplot(scenario3_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_c

# Scenario 3 alpha 0.5 cost 20 prob coop 0.8

scenario3_alpha5_d = PaleoCOOP_Tienshan_Scenario3_alpha0.5_cost20_probcoop0.8
scenario3_alpha5_d = scenario3_alpha5_d [,1:3]
scenario3_alpha5_d= melt (scenario3_alpha5_d, id.vars= "months", variable.name = "series")
scenario3_alpha5_d = ggplot(scenario3_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_d

# Scenario 3 alpha 0.8 cost 10 prob coop 0.5

scenario3_alpha8_e = PaleoCOOP_Tienshan_Scenario3_alpha0.8_cost10_probcoop0.5
scenario3_alpha8_e = scenario3_alpha8_e [,1:3]
scenario3_alpha8_e= melt (scenario3_alpha8_e, id.vars= "months", variable.name = "series")
scenario3_alpha8_e = ggplot(scenario3_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_e


# Scenario 3 alpha 0.8 cost 10 prob coop 0.8

scenario3_alpha8_f = PaleoCOOP_Tienshan_Scenario3_alpha0.8_cost10_probcoop0.8
scenario3_alpha8_f = scenario3_alpha8_f [,1:3]
scenario3_alpha8_f= melt (scenario3_alpha8_f, id.vars= "months", variable.name = "series")
scenario3_alpha8_f = ggplot(scenario3_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_f


# Scenario 3 alpha 0.8 cost 20 prob coop 0.5

scenario3_alpha8_g = PaleoCOOP_Tienshan_Scenario3_alpha0.8_cost20_probcoop0.5
scenario3_alpha8_g = scenario3_alpha8_g [,1:3]
scenario3_alpha8_g= melt (scenario3_alpha8_g, id.vars= "months", variable.name = "series")
scenario3_alpha8_g = ggplot(scenario3_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_g

# Scenario 3 alpha 0.8 cost 20 prob coop 0.8

scenario3_alpha8_h = PaleoCOOP_Tienshan_Scenario3_alpha0.8_cost20_probcoop0.8
scenario3_alpha8_h = scenario3_alpha8_h [,1:3]
scenario3_alpha8_h= melt (scenario3_alpha8_h, id.vars= "months", variable.name = "series")
scenario3_alpha8_h = ggplot(scenario3_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_h

#join scenario 3 together

totalscenario3 = grid.arrange(scenario3_alpha5_a, scenario3_alpha5_b, scenario3_alpha5_c, scenario3_alpha5_d, scenario3_alpha8_e, scenario3_alpha8_f, scenario3_alpha8_g, scenario3_alpha8_h, top = textGrob("Scenario 3 Tian Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario3


#SCENARIO 4. Tian Shan.

# Scenario 4 alpha 0.5 cost 10 prob coop 0.5

scenario4_alpha5_a = PaleoCOOP_tienshan_Scenario4_alpha0.5_cost10_probcoop0.5
scenario4_alpha5_a = scenario4_alpha5_a [,1:3]
scenario4_alpha5_a= melt (scenario4_alpha5_a, id.vars= "months", variable.name = "series")
scenario4_alpha5_a = ggplot(scenario4_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_a

# Scenario 4 alpha 0.5 cost 10 prob coop 0.8

scenario4_alpha5_b = PaleoCOOP_tienshan_Scenario4_alpha0.5_cost10_probcoop0.8
scenario4_alpha5_b = scenario4_alpha5_b [,1:3]
scenario4_alpha5_b= melt (scenario4_alpha5_b, id.vars= "months", variable.name = "series")
scenario4_alpha5_b = ggplot(scenario4_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_b  

# Scenario 4 alpha 0.5 cost 20 prob coop 0.5

scenario4_alpha5_c = PaleoCOOP_tienshan_Scenario4_alpha0.5_cost20_probcoop0.5
scenario4_alpha5_c = scenario4_alpha5_c [,1:3]
scenario4_alpha5_c= melt (scenario4_alpha5_c, id.vars= "months", variable.name = "series")
scenario4_alpha5_c = ggplot(scenario4_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_c

# Scenario 4 alpha 0.5 cost 20 prob coop 0.8

scenario4_alpha5_d = PaleoCOOP_tienshan_Scenario4_alpha0.5_cost20_probcoop0.8
scenario4_alpha5_d = scenario4_alpha5_d [,1:3]
scenario4_alpha5_d= melt (scenario4_alpha5_d, id.vars= "months", variable.name = "series")
scenario4_alpha5_d = ggplot(scenario4_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_d

# Scenario 4 alpha 0.8 cost 10 prob coop 0.5

scenario4_alpha8_e = PaleoCOOP_tienshan_Scenario4_alpha0.8_cost10_probcoop0.5
scenario4_alpha8_e = scenario4_alpha8_e [,1:3]
scenario4_alpha8_e= melt (scenario4_alpha8_e, id.vars= "months", variable.name = "series")
scenario4_alpha8_e = ggplot(scenario4_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_e

# Scenario 4 alpha 0.8 cost 10 prob coop 0.8

scenario4_alpha8_f = PaleoCOOP_tienshan_Scenario4_alpha0.8_cost10_probcoop0.8
scenario4_alpha8_f = scenario4_alpha8_f [,1:3]
scenario4_alpha8_f= melt (scenario4_alpha8_f, id.vars= "months", variable.name = "series")
scenario4_alpha8_f = ggplot(scenario4_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_f


# Scenario 4 alpha 0.8 cost 20 prob coop 0.5

scenario4_alpha8_g = PaleoCOOP_tienshan_Scenario4_alpha0.8_cost20_probcoop0.5
scenario4_alpha8_g = scenario4_alpha8_g [,1:3]
scenario4_alpha8_g= melt (scenario4_alpha8_g, id.vars= "months", variable.name = "series")
scenario4_alpha8_g = ggplot(scenario4_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_g


# Scenario 4 alpha 0.8 cost 20 prob coop 0.8

scenario4_alpha8_h = PaleoCOOP_tienshan_Scenario4_alpha0.8_cost20_probcoop0.8
scenario4_alpha8_h = scenario4_alpha8_h [,1:3]
scenario4_alpha8_h= melt (scenario4_alpha8_h, id.vars= "months", variable.name = "series")
scenario4_alpha8_h = ggplot(scenario4_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_h

#join scenario 4 together

totalscenario4 = grid.arrange(scenario4_alpha5_a, scenario4_alpha5_b, scenario4_alpha5_c, scenario4_alpha5_d, scenario4_alpha8_e, scenario4_alpha8_f, scenario4_alpha8_g, scenario4_alpha8_h, top = textGrob("Scenario 4 Tian Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario4

#### ALTAI ######

#please, delete dataset from Tian Shan bc same code is used here

#Scenario 1 Altai

# Scenario 1 alpha 0.5 cost 10 prob coop 0.5

scenario1_alpha5_a = PaleoCOOP_Scenario1_altai_alpha0.5_cost10_probcoop0.5
scenario1_alpha5_a = scenario1_alpha5_a [,1:3]
scenario1_alpha5_a= melt (scenario1_alpha5_a, id.vars= "months", variable.name = "series")
scenario1_alpha5_a = ggplot(scenario1_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_a


# Scenario 1 alpha 0.5 cost 10 prob coop 0.8

scenario1_alpha5_b = PaleoCOOP_Scenario1_altai_alpha0.5_cost10_probcoop0.8
scenario1_alpha5_b = scenario1_alpha5_b [,1:3]
scenario1_alpha5_b= melt (scenario1_alpha5_b, id.vars= "months", variable.name = "series")
scenario1_alpha5_b = ggplot(scenario1_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_b  


# Scenario 1 alpha 0.5 cost 20 prob coop 0.5

scenario1_alpha5_c = PaleoCOOP_Scenario1_altai_alpha0.5_cost20_probcoop0.5
scenario1_alpha5_c = scenario1_alpha5_c [,1:3]
scenario1_alpha5_c= melt (scenario1_alpha5_c, id.vars= "months", variable.name = "series")
scenario1_alpha5_c = ggplot(scenario1_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_c


# Scenario 1 alpha 0.5 cost 20 prob coop 0.8

scenario1_alpha5_d = PaleoCOOP_Scenario1_altai_alpha0.5_cost20_probcoop0.8
scenario1_alpha5_d = scenario1_alpha5_d [,1:3]
scenario1_alpha5_d= melt (scenario1_alpha5_d, id.vars= "months", variable.name = "series")
scenario1_alpha5_d = ggplot(scenario1_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha5_d


# Scenario 1 alpha 0.8 cost 10 prob coop 0.5

scenario1_alpha8_e = PaleoCOOP_Scenario1_altai_alpha0.8_cost10_probcoop0.5
scenario1_alpha8_e = scenario1_alpha8_e [,1:3]
scenario1_alpha8_e= melt (scenario1_alpha8_e, id.vars= "months", variable.name = "series")
scenario1_alpha8_e = ggplot(scenario1_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_e


# Scenario 1 alpha 0.8 cost 10 prob coop 0.8

scenario1_alpha8_f = PaleoCOOP_Scenario1_altai_alpha0.8_cost10_probcoop0.8
scenario1_alpha8_f = scenario1_alpha8_f [,1:3]
scenario1_alpha8_f= melt (scenario1_alpha8_f, id.vars= "months", variable.name = "series")
scenario1_alpha8_f = ggplot(scenario1_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_f

# Scenario 1 alpha 0.8 cost 20 prob coop 0.5

scenario1_alpha8_g = PaleoCOOP_Scenario1_altai_alpha0.8_cost20_probcoop0.5
scenario1_alpha8_g = scenario1_alpha8_g [,1:3]
scenario1_alpha8_g= melt (scenario1_alpha8_g, id.vars= "months", variable.name = "series")
scenario1_alpha8_g = ggplot(scenario1_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_g


# Scenario 1 alpha 0.8 cost 20 prob coop 0.8

scenario1_alpha8_h = PaleoCOOP_Scenario1_altai_alpha0.8_cost20_probcoop0.8
scenario1_alpha8_h = scenario1_alpha8_h [,1:3]
scenario1_alpha8_h= melt (scenario1_alpha8_h, id.vars= "months", variable.name = "series")
scenario1_alpha8_h = ggplot(scenario1_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario1_alpha8_h

#join scenario 1 together

totalscenario1 = grid.arrange(scenario1_alpha5_a, scenario1_alpha5_b, scenario1_alpha5_c, scenario1_alpha5_d, scenario1_alpha8_e, scenario1_alpha8_f, scenario1_alpha8_g, scenario1_alpha8_h, top = textGrob("Scenario 1 Altai", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario1


#SCENARIO 2. Altai


# Scenario 2 alpha 0.5 cost 10 prob coop 0.5

scenario2_alpha5_a = PaleoCOOP_Scenario2_Altai_alpha0.5_cost10_probcoop0.5
scenario2_alpha5_a = scenario2_alpha5_a [,1:3]
scenario2_alpha5_a= melt (scenario2_alpha5_a, id.vars= "months", variable.name = "series")
scenario2_alpha5_a = ggplot(scenario2_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_a


# Scenario 2 alpha 0.5 cost 10 prob coop 0.8

scenario2_alpha5_b = PaleoCOOP_Scenario2_Altai_alpha0.5_cost10_probcoop0.8
scenario2_alpha5_b = scenario2_alpha5_b [,1:3]
scenario2_alpha5_b= melt (scenario2_alpha5_b, id.vars= "months", variable.name = "series")
scenario2_alpha5_b = ggplot(scenario2_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_b


# Scenario 2 alpha 0.5 cost 20 prob coop 0.5

scenario2_alpha5_c = PaleoCOOP_Scenario2_Altai_alpha0.5_cost20_probcoop0.5
scenario2_alpha5_c = scenario2_alpha5_c [,1:3]
scenario2_alpha5_c= melt (scenario2_alpha5_c, id.vars= "months", variable.name = "series")
scenario2_alpha5_c = ggplot(scenario2_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_c


# Scenario 2 alpha 0.5 cost 20 prob coop 0.8

scenario2_alpha5_d = PaleoCOOP_Scenario2_Altai_alpha0.5_cost20_probcoop0.8
scenario2_alpha5_d = scenario2_alpha5_d [,1:3]
scenario2_alpha5_d= melt (scenario2_alpha5_d, id.vars= "months", variable.name = "series")
scenario2_alpha5_d = ggplot(scenario2_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha5_d


# Scenario 2 alpha 0.8 cost 10 prob coop 0.5

scenario2_alpha8_e = PaleoCOOP_Scenario2_Altai_alpha0.8_cost10_probcoop0.5
scenario2_alpha8_e = scenario2_alpha8_e [,1:3]
scenario2_alpha8_e= melt (scenario2_alpha8_e, id.vars= "months", variable.name = "series")
scenario2_alpha8_e = ggplot(scenario2_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_e


# Scenario 2 alpha 0.8 cost 10 prob coop 0.8

scenario2_alpha8_f = PaleoCOOP_Scenario2_Altai_alpha0.8_cost10_probcoop0.8
scenario2_alpha8_f = scenario2_alpha8_f [,1:3]
scenario2_alpha8_f= melt (scenario2_alpha8_f, id.vars= "months", variable.name = "series")
scenario2_alpha8_f = ggplot(scenario2_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_f


# Scenario 2 alpha 0.8 cost 20 prob coop 0.5

scenario2_alpha8_g = PaleoCOOP_Scenario2_Altai_alpha0.8_cost20_probcoop0.5
scenario2_alpha8_g = scenario2_alpha8_g [,1:3]
scenario2_alpha8_g= melt (scenario2_alpha8_g, id.vars= "months", variable.name = "series")
scenario2_alpha8_g = ggplot(scenario2_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_g

# Scenario 2 alpha 0.8 cost 20 prob coop 0.8

scenario2_alpha8_h = PaleoCOOP_Scenario2_Altai_alpha0.8_cost20_probcoop0.8
scenario2_alpha8_h = scenario2_alpha8_h [,1:3]
scenario2_alpha8_h= melt (scenario2_alpha8_h, id.vars= "months", variable.name = "series")
scenario2_alpha8_h = ggplot(scenario2_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario2_alpha8_h

#join scenario 2 together

totalscenario2 = grid.arrange(scenario2_alpha5_a, scenario2_alpha5_b, scenario2_alpha5_c, scenario2_alpha5_d, scenario2_alpha8_e, scenario2_alpha8_f, scenario2_alpha8_g, scenario2_alpha8_h, top = textGrob("Scenario 2 Altai", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario2


#SCENARIO 3. Altai


# Scenario 3 alpha 0.5 cost 10 prob coop 0.5

scenario3_alpha5_a = PaleoCOOP_Scenario3_Altai_alpha0.5_cost10_probcoop0.5
scenario3_alpha5_a = scenario3_alpha5_a [,1:3]
scenario3_alpha5_a= melt (scenario3_alpha5_a, id.vars= "months", variable.name = "series")
scenario3_alpha5_a = ggplot(scenario3_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_a



# Scenario 3 alpha 0.5 cost 10 prob coop 0.8

scenario3_alpha5_b = PaleoCOOP_Scenario3_Altai_alpha0.5_cost10_probcoop0.8
scenario3_alpha5_b = scenario3_alpha5_b [,1:3]
scenario3_alpha5_b= melt (scenario3_alpha5_b, id.vars= "months", variable.name = "series")
scenario3_alpha5_b = ggplot(scenario3_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_b  


# Scenario 3 alpha 0.5 cost 20 prob coop 0.5

scenario3_alpha5_c = PaleoCOOP_Scenario3_Altai_alpha0.5_cost20_probcoop0.5
scenario3_alpha5_c = scenario3_alpha5_c [,1:3]
scenario3_alpha5_c= melt (scenario3_alpha5_c, id.vars= "months", variable.name = "series")
scenario3_alpha5_c = ggplot(scenario3_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_c


# Scenario 3 alpha 0.5 cost 20 prob coop 0.8

scenario3_alpha5_d = PaleoCOOP_Scenario3_Altai_alpha0.5_cost20_probcoop0.8
scenario3_alpha5_d = scenario3_alpha5_d [,1:3]
scenario3_alpha5_d= melt (scenario3_alpha5_d, id.vars= "months", variable.name = "series")
scenario3_alpha5_d = ggplot(scenario3_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha5_d


# Scenario 3 alpha 0.8 cost 10 prob coop 0.5

scenario3_alpha8_e = PaleoCOOP_Scenario3_Altai_alpha0.8_cost10_probcoop0.5
scenario3_alpha8_e = scenario3_alpha8_e [,1:3]
scenario3_alpha8_e= melt (scenario3_alpha8_e, id.vars= "months", variable.name = "series")
scenario3_alpha8_e = ggplot(scenario3_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_e


# Scenario 3 alpha 0.8 cost 10 prob coop 0.8

scenario3_alpha8_f = PaleoCOOP_Scenario3_Altai_alpha0.8_cost10_probcoop0.8
scenario3_alpha8_f = scenario3_alpha8_f [,1:3]
scenario3_alpha8_f= melt (scenario3_alpha8_f, id.vars= "months", variable.name = "series")
scenario3_alpha8_f = ggplot(scenario3_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_f



# Scenario 3 alpha 0.8 cost 20 prob coop 0.5

scenario3_alpha8_g = PaleoCOOP_Scenario3_Altai_alpha0.8_cost20_probcoop0.5
scenario3_alpha8_g = scenario3_alpha8_g [,1:3]
scenario3_alpha8_g= melt (scenario3_alpha8_g, id.vars= "months", variable.name = "series")
scenario3_alpha8_g = ggplot(scenario3_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_g


# Scenario 3 alpha 0.8 cost 20 prob coop 0.8

scenario3_alpha8_h = PaleoCOOP_Scenario3_Altai_alpha0.8_cost20_probcoop0.8
scenario3_alpha8_h = scenario3_alpha8_h [,1:3]
scenario3_alpha8_h= melt (scenario3_alpha8_h, id.vars= "months", variable.name = "series")
scenario3_alpha8_h = ggplot(scenario3_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario3_alpha8_h

#join scenario 3 together

totalscenario3 = grid.arrange(scenario3_alpha5_a, scenario3_alpha5_b, scenario3_alpha5_c, scenario3_alpha5_d, scenario3_alpha8_e, scenario3_alpha8_f, scenario3_alpha8_g, scenario3_alpha8_h, top = textGrob("Scenario 3 Altai", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario3

#SCENARIO 4. Altai

# Scenario 4 alpha 0.5 cost 10 prob coop 0.5

scenario4_alpha5_a = PaleoCOOP_Scenario4_Altai_alpha0.5_cost10_probcoop0.5
scenario4_alpha5_a = scenario4_alpha5_a [,1:3]
scenario4_alpha5_a= melt (scenario4_alpha5_a, id.vars= "months", variable.name = "series")
scenario4_alpha5_a = ggplot(scenario4_alpha5_a, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_a


# Scenario 4 alpha 0.5 cost 10 prob coop 0.8

scenario4_alpha5_b = PaleoCOOP_Scenario4_Altai_alpha0.5_cost10_probcoop0.8
scenario4_alpha5_b = scenario4_alpha5_b [,1:3]
scenario4_alpha5_b= melt (scenario4_alpha5_b, id.vars= "months", variable.name = "series")
scenario4_alpha5_b = ggplot(scenario4_alpha5_b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_b 


# Scenario 4 alpha 0.5 cost 20 prob coop 0.5

scenario4_alpha5_c = PaleoCOOP_Scenario4_Altai_alpha0.5_cost20_probcoop0.5
scenario4_alpha5_c = scenario4_alpha5_c [,1:3]
scenario4_alpha5_c= melt (scenario4_alpha5_c, id.vars= "months", variable.name = "series")
scenario4_alpha5_c = ggplot(scenario4_alpha5_c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_c

# Scenario 4 alpha 0.5 cost 20 prob coop 0.8

scenario4_alpha5_d = PaleoCOOP_Scenario4_Altai_alpha0.5_cost20_probcoop0.8
scenario4_alpha5_d = scenario4_alpha5_d [,1:3]
scenario4_alpha5_d= melt (scenario4_alpha5_d, id.vars= "months", variable.name = "series")
scenario4_alpha5_d = ggplot(scenario4_alpha5_d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.5 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha5_d


# Scenario 4 alpha 0.8 cost 10 prob coop 0.5

scenario4_alpha8_e = PaleoCOOP_Scenario4_Altai_alpha0.8_cost10_probcoop0.5
scenario4_alpha8_e = scenario4_alpha8_e [,1:3]
scenario4_alpha8_e= melt (scenario4_alpha8_e, id.vars= "months", variable.name = "series")
scenario4_alpha8_e = ggplot(scenario4_alpha8_e, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_e


# Scenario 4 alpha 0.8 cost 10 prob coop 0.8

scenario4_alpha8_f = PaleoCOOP_Scenario4_Altai_alpha0.8_cost10_probcoop0.8
scenario4_alpha8_f = scenario4_alpha8_f [,1:3]
scenario4_alpha8_f= melt (scenario4_alpha8_f, id.vars= "months", variable.name = "series")
scenario4_alpha8_f = ggplot(scenario4_alpha8_f, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 10 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_f


# Scenario 4 alpha 0.8 cost 20 prob coop 0.5

scenario4_alpha8_g = PaleoCOOP_Scenario4_Altai_alpha0.8_cost20_probcoop0.5
scenario4_alpha8_g = scenario4_alpha8_g [,1:3]
scenario4_alpha8_g= melt (scenario4_alpha8_g, id.vars= "months", variable.name = "series")
scenario4_alpha8_g = ggplot(scenario4_alpha8_g, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.5") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_g


# Scenario 4 alpha 0.8 cost 20 prob coop 0.8

scenario4_alpha8_h = PaleoCOOP_Scenario4_Altai_alpha0.8_cost20_probcoop0.8
scenario4_alpha8_h = scenario4_alpha8_h [,1:3]
scenario4_alpha8_h= melt (scenario4_alpha8_h, id.vars= "months", variable.name = "series")
scenario4_alpha8_h = ggplot(scenario4_alpha8_h, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("alpha 0.8 - cost 20 - prob coop 0.8") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
scenario4_alpha8_h



#join scenario 4 together

totalscenario4 = grid.arrange(scenario4_alpha5_a, scenario4_alpha5_b, scenario4_alpha5_c, scenario4_alpha5_d, scenario4_alpha8_e, scenario4_alpha8_f, scenario4_alpha8_g, scenario4_alpha8_h, top = textGrob("Scenario 4 Altai", gp = gpar(fontsize = unit(20, "lines"))), nrow = 2)
totalscenario4

  