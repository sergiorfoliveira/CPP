library(readxl)
# You don't need to install sqldf if you've already have it installed...
# ...or if you are using PySpark
#install.packages("sqldf")
library(sqldf)

# The original survey data is in the file "Percepções sobre Planos de Progressão de Carreira_Perceptions on Career Progression Plans(1-98).xlsx"
# This other spreadsheet contains less columns but the same number of records:
# Let's load the survey data
Data <- read_excel("ColumnsSupressed - Percepções sobre Planos de Progressão de Carreira_Perceptions on Career Progression Plans(1-98).xlsx")
View(Data)
summary(Data)

# Let's transform the column "Importance":
Data$Importance=as.integer(Data$Importance)

# Let's transform the column "Benefits":
# -1 = 'A existência de um Plano de Progressão de Carreira traz mais malefícios que benefícios para uma empresa / The existence of a Career Progression Plan brings more harm than benefits to a company'
#  0 = 'A existência de um Plano de Progressão de Carreira não traz nem benefícios nem malefícios para uma empresa / The existence of a Career Progression Plan brings neither benefits nor harm to a company '
#  1 = 'A existência de um Plano de Progressão de Carreira traz mais benefícios que malefícios para uma empresa / The existence of a Career Progression Plan brings more benefits than harm to a company'
#
Data <- sqldf(c("UPDATE Data SET Benefits = '1' WHERE Benefits LIKE '%more benefits%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET Benefits = '0' WHERE Benefits LIKE '%neither benefits%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET Benefits = '-1' WHERE Benefits LIKE '%more harm%';" , "SELECT * FROM Data"))
Data$Benefits=as.integer(Data$Benefits)

# Let's transform the column "BenefitsForTechnology":
# -1 = 'NÃO / NO'
#  0 = NULL
#  1 = 'SIM / YES'
#
Data <- sqldf(c("UPDATE Data SET BenefitsForTechnology = '-1' WHERE BenefitsForTechnology LIKE '%NÃO / NO%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET BenefitsForTechnology = '0' WHERE BenefitsForTechnology IS NULL;" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET BenefitsForTechnology = '1' WHERE BenefitsForTechnology LIKE '%SIM / YES%';" , "SELECT * FROM Data"))
Data$BenefitsForTechnology=as.integer(Data$BenefitsForTechnology)

# Let's transform the column "AnswersBasedOn":
# 0  = 'Minhas aspirações / My aspirations;'
# 1  = 'Minha intuição / My intuition;'
# 2  = 'Minha intuição / My intuition;Minhas aspirações / My aspirations;'
# 3  = 'Meu conhecimento teórico / My theoretical knowledge;'
# 4  = 'Minha intuição / My intuition;Meu conhecimento teórico / My theoretical knowledge;'
# 5  = 'Minha própria experiência / My own experience;'
# 6  = 'Minha própria experiência / My own experience;Minha intuição / My intuition;'
# 7  = 'Minhas aspirações / My aspirations;Minha própria experiência / My own experience;'
# 8  = 'Minha própria experiência / My own experience;Minhas aspirações / My aspirations;'
# 9  = 'Meu conhecimento teórico / My theoretical knowledge;Minha própria experiência / My own experience;'
# 10 = 'Minha própria experiência / My own experience;Meu conhecimento teórico / My theoretical knowledge;'
# 11 = 'Minha própria experiência / My own experience;Minha intuição / My intuition;Meu conhecimento teórico / My theoretical knowledge;'
# 12 = 'Minha própria experiência / My own experience;Minhas aspirações / My aspirations;Meu conhecimento teórico / My theoretical knowledge;'
# 13 = 'Minha intuição / My intuition;Meu conhecimento teórico / My theoretical knowledge;Minhas aspirações / My aspirations;Minha própria experiência / My own experience;'
# 14 = 'Minha própria experiência / My own experience;Minha intuição / My intuition;Minhas aspirações / My aspirations;Meu conhecimento teórico / My theoretical knowledge;'
# 15 = 'Minha própria experiência / My own experience;Meu conhecimento teórico / My theoretical knowledge;Minhas aspirações / My aspirations;Minha intuição / My intuition;'
#
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '15' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience;Meu conhecimento teórico / My theoretical knowledge;Minhas aspirações / My aspirations;Minha intuição / My intuition%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '14' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience;Minha intuição / My intuition;Minhas aspirações / My aspirations;Meu conhecimento teórico / My theoretical knowledge%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '13' WHERE AnswersBasedOn LIKE '%Minha intuição / My intuition;Meu conhecimento teórico / My theoretical knowledge;Minhas aspirações / My aspirations;Minha própria experiência / My own experience%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '12' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience;Minhas aspirações / My aspirations;Meu conhecimento teórico / My theoretical knowledge%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '11' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience;Minha intuição / My intuition;Meu conhecimento teórico / My theoretical knowledge%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '10' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience;Meu conhecimento teórico / My theoretical knowledge%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '9' WHERE AnswersBasedOn LIKE '%Meu conhecimento teórico / My theoretical knowledge;Minha própria experiência / My own experience%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '8' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience;Minhas aspirações / My aspirations%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '7' WHERE AnswersBasedOn LIKE '%Minhas aspirações / My aspirations;Minha própria experiência / My own experience%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '6' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience;Minha intuição / My intuition%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '5' WHERE AnswersBasedOn LIKE '%Minha própria experiência / My own experience%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '4' WHERE AnswersBasedOn LIKE '%Minha intuição / My intuition;Meu conhecimento teórico / My theoretical knowledge%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '3' WHERE AnswersBasedOn LIKE '%Meu conhecimento teórico / My theoretical knowledge%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '2' WHERE AnswersBasedOn LIKE '%Minha intuição / My intuition;Minhas aspirações / My aspirations%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '1' WHERE AnswersBasedOn LIKE '%Minha intuição / My intuition%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET AnswersBasedOn = '0' WHERE AnswersBasedOn LIKE '%Minhas aspirações / My aspirations%';" , "SELECT * FROM Data"))
Data$AnswersBasedOn=as.integer(Data$AnswersBasedOn)

# Let's transform the column "OwnerManager":
# 0 = 'NÃO / NO'
# 1 = 'SIM / YES'
#
Data <- sqldf(c("UPDATE Data SET OwnerManager = '0' WHERE OwnerManager LIKE 'NÃO / NO%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET OwnerManager = '1' WHERE OwnerManager LIKE 'SIM / YES%';" , "SELECT * FROM Data"))
Data$OwnerManager=as.integer(Data$OwnerManager)

# Let's transform the column "YearsOfExperience":
# 0 = '0-5'
# 1 = '6-10'
# 2 = '11-15'
# 3 = '16-20'
# 4 = '21-25'
# 5 = 'Mais de 25 / More than 25'
#
Data <- sqldf(c("UPDATE Data SET YearsOfExperience = '0' WHERE YearsOfExperience LIKE '0-5%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET YearsOfExperience = '1' WHERE YearsOfExperience LIKE '6-10%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET YearsOfExperience = '2' WHERE YearsOfExperience LIKE '11-15%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET YearsOfExperience = '3' WHERE YearsOfExperience LIKE '16-20%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET YearsOfExperience = '4' WHERE YearsOfExperience LIKE '21-25%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET YearsOfExperience = '5' WHERE YearsOfExperience LIKE 'Mais de 25 / More than 25%';" , "SELECT * FROM Data"))
Data$YearsOfExperience=as.integer(Data$YearsOfExperience)

# Let's transform the column "LevelOfEducation":
# 0 = "Segundo grau / High School"
# 1 = "Curso superior / Undergraduate"
# 2 = "MBA"
# 3 = "Mestrado / Master's degree"
# 4 = "Doutorado / PhD or equivalent"
# 5 = "Pós-Doc / Post-Doc"
#
Data <- sqldf(c("UPDATE Data SET LevelOfEducation = '0' WHERE LevelOfEducation LIKE 'Segundo grau / High School%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET LevelOfEducation = '1' WHERE LevelOfEducation LIKE 'Curso superior / Undergraduate%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET LevelOfEducation = '2' WHERE LevelOfEducation LIKE 'MBA%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET LevelOfEducation = '3' WHERE LevelOfEducation LIKE 'Mestrado%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET LevelOfEducation = '4' WHERE LevelOfEducation LIKE 'Doutorado / PhD or equivalent%';" , "SELECT * FROM Data"))
Data <- sqldf(c("UPDATE Data SET LevelOfEducation = '5' WHERE LevelOfEducation LIKE 'Pós-Doc / Post-Doc%';" , "SELECT * FROM Data"))
Data$LevelOfEducation=as.integer(Data$LevelOfEducation)

# Let's make a copy of the data supressing the column "ProfessionalArea":
Data1 = sqldf("SELECT Importance, Benefits, BenefitsForTechnology, AnswersBasedOn, Ownermanager, YearsOfExperience, LevelOfEducation FROM Data WHERE YearsOfExperience IS NOT NULL")
#
# Now we have only numeric columns on Data1, and so we may compute correlations:
cor(Data1)

# Let's regress the colunm "Benefits" from the others:
model=lm(Benefits ~ ., data=Data1)
summary(model)
# Let's regress the colunm "BenefitsForTechnology" from the others:
model=lm(BenefitsForTechnology ~ ., data=Data1)
summary(model)
