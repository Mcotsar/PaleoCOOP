library (ggplot2)
library (dplyr)
library (gridExtra)
library (grid)
library (reshape2)


##Plotting the probability of cooperation 0.20, 0.50, 0.80 for Tien Shan

##Scenario 1 Tien Shan

prob20 = Ouput_Scenario1_probcoop20_TienShan
prob20 = prob20 [,1:3]
prob20
prob20= melt (prob20, id.vars= "months", variable.name = "series")
prob20
prob20plot = ggplot(prob20, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 20") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank())
prob20plot
prob50 = Output_Scenario1_probcoop50_TienShan
prob50 = prob50 [,1:3]
prob50= melt (prob50, id.vars= "months", variable.name = "series")
prob50plot = ggplot(prob50, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 50") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob50plot
prob80 = Output_Scenario1_probcoop80_TienShan
prob80 = prob80 [,1:3]
prob80= melt (prob80, id.vars= "months", variable.name = "series")
prob80plot = ggplot(prob80, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 80") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob80plot
totalscenario1 = grid.arrange(prob20plot, prob50plot, prob80plot, top = textGrob("Scenario 1 Tien Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 3)

##Scenario 2 Tien Shan

prob20b = Output_Scenario2_probcoop20_TienShan
prob20b = prob20b [,1:3]
prob20b
prob20b = melt (prob20b, id.vars= "months", variable.name = "series")
prob20bplot = ggplot(prob20b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 20") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob20bplot
prob50b = Output_Scenario2_probcoop50_TienShan
prob50b = prob50b [,1:3]
prob50b = melt (prob50b, id.vars= "months", variable.name = "series")
prob50bplot = ggplot(prob50b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 50") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob50bplot
prob80b = Output_Scenario2_probcoop80_TienShan
prob80b = prob80b [,1:3]
prob80b = melt (prob80b, id.vars= "months", variable.name = "series")
prob80bplot = ggplot(prob80b, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 80") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_y_continuous(limits = c(0, 15)) + scale_x_continuous(limits = c(0, 400))
prob80bplot
totalscenario2 = grid.arrange(prob20bplot, prob50bplot, prob80bplot, top = textGrob("Scenario 2 Tien Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 3)


##Scenario 3 Tien Shan

prob20c = Output_Scenario3_probcoop20_TienShan
prob20c = prob20c [,1:3]
prob20c = melt (prob20c, id.vars= "months", variable.name = "series")
prob20cplot = ggplot(prob20c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 20") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob20cplot
prob50c = Output_Scenario3_probcoop50_TienShan
prob50c = prob50c [,1:3]
prob50c = melt (prob50c, id.vars= "months", variable.name = "series")
prob50cplot = ggplot(prob50c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 50") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob50cplot
prob80c = Output_Scenario3_probcoop80_TienShan
prob80c = prob80c [,1:3]
prob80c = melt (prob80c, id.vars= "months", variable.name = "series")
prob80cplot = ggplot(prob80c, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 80") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 400))
prob80cplot
totalscenario3 = grid.arrange(prob20cplot, prob50cplot, prob80cplot, top = textGrob("Scenario 2 and 3 Tien Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 3)

##Scenario 4 Tien Shan

prob20d = Output_Scenario4_probcoop20_TienShan
prob20d = prob20d [,1:3]
prob20d = melt (prob20d, id.vars= "months", variable.name = "series")
prob20dplot = ggplot(prob20d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 20") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 900))
prob20dplot
prob50d = Output_Scenario4_probcoop50_TienShan
prob50d = prob50d [,1:3]
prob50d = melt (prob50d, id.vars= "months", variable.name = "series")
prob50dplot = ggplot(prob50d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 50") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob50dplot
prob80d = Output_Scenario4_probcoop80_TienShan
prob80d = prob80d [,1:3]
prob80d = melt (prob80d, id.vars= "months", variable.name = "series")
prob80dplot = ggplot(prob80d, aes (months, value)) + geom_line (aes(colour= series), size= 1) + ggtitle ("Prob.coop 80") + theme ( plot.title = element_text(hjust = 0.5)) + scale_color_manual (values=c('darkseagreen3', 'coral1')) + ylab ("Population") + theme_minimal() + theme(legend.title=element_blank()) + scale_x_continuous(limits = c(0, 1250))
prob80dplot
totalscenario4 = grid.arrange(prob20dplot, prob50dplot, prob80dplot, top = textGrob("Scenario 4 Tien Shan", gp = gpar(fontsize = unit(20, "lines"))), nrow = 3)
