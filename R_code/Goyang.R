# Basic Packages
library(readr)
library(openxlsx)
library(dplyr)

Sys.setenv(R_ZIPCMD= "C:/Rtools/bin/zip")

# Setwd_apart
setwd("D:/Data/Public_data/real_transaction_price_2017/Goyang/apartment/")

# Import files_apart
list.files()
flist.xlsx <- list.files()
fname.list <- substr(flist.xlsx, 1, nchar(flist.xlsx)-5)

for(i in 1:length(fname.list)){
  tmp.xlsx <- read.xlsx(flist.xlsx[i])
  assign(fname.list[i], tmp.xlsx)
  message("[", fname.list[i], "] has completed")
}

# Merge data
apart_all <- NULL
for(i in 1:length(fname.list)){
  tmp <- get(fname.list[i])
  apart_all <- rbind(apart_all, tmp)
}

# Address column
apart_all <- apart_all %>%
  mutate(�ּ� = paste0(�ñ���, " ",����))

# File for geocoding
apart_all_dup <- apart_all[!duplicated(apart_all$�ּ�), ]
apart_all_dup <- apart_all_dup %>%
  select(�ּ�)

# Save
write.xlsx(apart_all_dup, "apart_goyang.xlsx", row.names = FALSE)

# Setwd_multi
setwd("D:/Data/Public_data/real_transaction_price_2017/Goyang/multi/")

# Import files_multi
list.files()
flist.xlsx <- list.files()
fname.list <- substr(flist.xlsx, 1, nchar(flist.xlsx)-5)

for(i in 1:length(fname.list)){
  tmp.xlsx <- read.xlsx(flist.xlsx[i])
  assign(fname.list[i], tmp.xlsx)
  message("[", fname.list[i], "] has completed")
}

# Merge data
multi_all <- NULL
for(i in 1:length(fname.list)){
  tmp <- get(fname.list[i])
  multi_all <- rbind(multi_all, tmp)
}

# File for geocoding
multi_all_dup <- multi_all[!duplicated(multi_all$�ñ���), ]
multi_all_dup <- multi_all_dup %>%
  select(�ñ���)

# Save
write.xlsx(multi_all_dup, "multi_goyang.xlsx", row.names = FALSE)

# Setwd_officehotel
setwd("D:/Data/Public_data/real_transaction_price_2017/Goyang/officehotel/")

# Import files_officehotel
list.files()
flist.xlsx <- list.files()
fname.list <- substr(flist.xlsx, 1, nchar(flist.xlsx)-5)

for(i in 1:length(fname.list)){
  tmp.xlsx <- read.xlsx(flist.xlsx[i])
  assign(fname.list[i], tmp.xlsx)
  message("[", fname.list[i], "] has completed")
}

# Merge data
officehotel_all <- NULL
for(i in 1:length(fname.list)){
  tmp <- get(fname.list[i])
  officehotel_all <- rbind(officehotel_all, tmp)
}

# Address column
officehotel_all <- officehotel_all %>%
  mutate(�ּ� = paste0(�ñ���, " ",����))

# File for geocoding
officehotel_all_dup <- officehotel_all[!duplicated(officehotel_all$�ּ�), ]
officehotel_all_dup <- officehotel_all_dup %>%
  select(�ּ�)

# Save
write.xlsx(officehotel_all_dup, "officehotel_goyang.xlsx", row.names = FALSE)

# Setwd_villa
setwd("D:/Data/Public_data/real_transaction_price_2017/Goyang/villa/")

# Import files_officehotel
list.files()
flist.xlsx <- list.files()
fname.list <- substr(flist.xlsx, 1, nchar(flist.xlsx)-5)

for(i in 1:length(fname.list)){
  tmp.xlsx <- read.xlsx(flist.xlsx[i])
  assign(fname.list[i], tmp.xlsx)
  message("[", fname.list[i], "] has completed")
}

# Merge data
villa_all <- NULL
for(i in 1:length(fname.list)){
  tmp <- get(fname.list[i])
  villa_all <- rbind(villa_all, tmp)
}

# Address column
villa_all <- villa_all %>%
  mutate(�ּ� = paste0(�ñ���, " ",����))

# File for geocoding
villa_all_dup <- villa_all[!duplicated(villa_all$�ּ�), ]
villa_all_dup <- villa_all_dup %>%
  select(�ּ�)

# Save
write.xlsx(villa_all_dup, "villa_goyang.xlsx", row.names = FALSE)

# Merge Data(Geocoding)
apart_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Goyang/apart_goyang_g.csv")
officehotel_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Goyang/officehotel_goyang_g.csv")
villa_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Goyang/villa_goyang_g.csv")
multi_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Goyang/multi_goyang_g.csv")

apart <- merge(apart_all, apart_g, by = c("�ּ�"), all.x = TRUE)
officehotel <- merge(officehotel_all, officehotel_g, by = c("�ּ�"), all.x = TRUE)
villa <- merge(villa_all, villa_g, by = c("�ּ�"), all.x = TRUE)
multi <- merge(multi_all, multi_g, by = c("�ñ���"), all.x = TRUE)

# Merge Data(All)
names(apart)[6] <- "����(�ǹ�)��"

apart <- apart %>%
  mutate(�ǹ����� = "����Ʈ", '�����Ǹ���(��)' = NA, '������(��)' = NA, 
             '��������(��)' = NA, �ŷ����� = "�Ÿ�") %>%
  select(�ּ�, �ñ���, ����, ����, �ι�, '����(�ǹ�)��', '�������(��)', 
           '�����Ǹ���(��)', '������(��)', '��������(��)', �����, 
           �����, '�ŷ��ݾ�(����)', ��, ����⵵, ���θ�, x, y, �ǹ�����,
           �ŷ�����)

names(villa)[6] <- "����(�ǹ�)��"

villa <- villa %>%
  mutate(�ǹ����� = "����/�ټ���", '������(��)' = NA, 
             '��������(��)' = NA, �ŷ����� = "�Ÿ�") %>%
  select(�ּ�, �ñ���, ����, ����, �ι�, '����(�ǹ�)��', '�������(��)', 
           '�����Ǹ���(��)', '������(��)', '��������(��)', �����, 
           �����, '�ŷ��ݾ�(����)', ��, ����⵵, ���θ�, x, y, �ǹ�����,
           �ŷ�����)

names(officehotel)[6] <- "����(�ǹ�)��"

officehotel <- officehotel %>%
  mutate(�ǹ����� = "���ǽ���", '�����Ǹ���(��)' = NA, '������(��)' = NA, 
             '��������(��)' = NA, �ŷ����� = "�Ÿ�") %>%
  select(�ּ�, �ñ���, ����, ����, �ι�, '����(�ǹ�)��', '�������(��)', 
           '�����Ǹ���(��)', '������(��)', '��������(��)', �����, 
           �����, '�ŷ��ݾ�(����)', ��, ����⵵, ���θ�, x, y, �ǹ�����,
           �ŷ�����)

names(multi)[2] <- "�ǹ�����"

multi <- multi %>%
  mutate(�ּ� = NA, ���� = NA, ���� = NA, �ι� = NA, 
           '����(�ǹ�)��' = NA, '�������(��)' = NA, '�����Ǹ���(��)' = NA,
           �� = NA, �ŷ����� = "�Ÿ�") %>%
  select(�ּ�, �ñ���, ����, ����, �ι�, '����(�ǹ�)��', '�������(��)', 
           '�����Ǹ���(��)', '������(��)', '��������(��)', �����, 
           �����, '�ŷ��ݾ�(����)', ��, ����⵵, ���θ�, x, y, �ǹ�����,
           �ŷ�����)

goyang <- rbind(apart, villa, officehotel, multi)

goyang <- goyang %>%
  arrange(�ּ�)

goyang$`�������(��)` <- as.numeric(goyang$`�������(��)`)
goyang$`��������(��)` <- as.numeric(goyang$`��������(��)`)
goyang$`�ŷ��ݾ�(����)` <- gsub(",", "", goyang$`�ŷ��ݾ�(����)`)
goyang$`�ŷ��ݾ�(����)` <- as.numeric(goyang$`�ŷ��ݾ�(����)`)

# Calculate price/square
goyang_1 <- goyang %>%
  filter(�ǹ����� == '����Ʈ' | �ǹ����� == '���ǽ���' | �ǹ����� == '����/�ټ���') %>%
  mutate('�ŷ��ݾ�/����' = `�ŷ��ݾ�(����)` / `�������(��)`)

goyang_2 <- goyang %>%
  filter(�ǹ����� == '�ܵ�' | �ǹ����� == '�ٰ���') %>%
  mutate('�ŷ��ݾ�/����' = `�ŷ��ݾ�(����)` / `��������(��)`)

goyang <- rbind(goyang_1, goyang_2)

goyang <- goyang %>%
  arrange(�ּ�)

write.xlsx(goyang, "����_�Ÿ�_����.xlsx", row.names = FALSE)