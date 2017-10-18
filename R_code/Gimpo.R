# Basic Packages
library(readr)
library(openxlsx)
library(dplyr)

Sys.setenv(R_ZIPCMD= "C:/Rtools/bin/zip")

# Setwd
setwd("D:/Data/Public_data/real_transaction_price_2017/Gimpo/")

# Import files
apart <- read.xlsx("D:/Data/Public_data/real_transaction_price_2017/Gimpo/dealing/����Ʈ(�Ÿ�)_�ǰŷ���_2017����.xlsx")
officehotel <- read.xlsx("D:/Data/Public_data/real_transaction_price_2017/Gimpo/dealing/���ǽ���(�Ÿ�)_�ǰŷ���_2017����.xlsx")
villa <- read.xlsx("D:/Data/Public_data/real_transaction_price_2017/Gimpo/dealing/�����ټ���(�Ÿ�)_�ǰŷ���_2017����.xlsx")
multi <- read.xlsx("D:/Data/Public_data/real_transaction_price_2017/Gimpo/dealing/�ܵ��ٰ���(�Ÿ�)_�ǰŷ���_2017����.xlsx")

# Address column
apart <- apart %>%
  mutate(�ּ� = paste0(�ñ���, " ",����))
officehotel <- officehotel %>%
  mutate(�ּ� = paste0(�ñ���, " ",����))
villa <- villa %>%
  mutate(�ּ� = paste0(�ñ���, " ",����))

# File for geocoding
apart_dup <- apart[!duplicated(apart$�ּ�), ]
apart_dup <- apart_dup %>%
  select(�ּ�)

officehotel_dup <- officehotel[!duplicated(officehotel$�ּ�), ]
officehotel_dup <- officehotel_dup %>%
  select(�ּ�)

villa_dup <- villa[!duplicated(villa$�ּ�), ]
villa_dup <- villa_dup %>%
  select(�ּ�)

multi_dup <- multi[!duplicated(multi$�ñ���), ]
multi_dup <- multi_dup %>%
  select(�ñ���)

# Save
write.xlsx(apart_dup, "apart_gimpo.xlsx", row.names = FALSE)
write.xlsx(officehotel_dup, "officehotel_gimpo.xlsx", row.names = FALSE)
write.xlsx(villa_dup, "villa_gimpo.xlsx", row.names = FALSE)
write.xlsx(multi_dup, "multi_gimpo.xlsx", row.names = FALSE)

# Merge Data(Geocoding)
apart_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Gimpo/apart_gimpo_g.csv")
officehotel_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Gimpo/officehotel_gimpo_g.csv")
villa_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Gimpo/villa_gimpo_g.csv")
multi_g <- read.csv("D:/Data/Public_data/real_transaction_price_2017/Gimpo/multi_gimpo_g.csv")

apart <- merge(apart, apart_g, by = c("�ּ�"), all.x = TRUE)
officehotel <- merge(officehotel, officehotel_g, by = c("�ּ�"), all.x = TRUE)
villa <- merge(villa, villa_g, by = c("�ּ�"), all.x = TRUE)
multi <- merge(multi, multi_g, by = c("�ñ���"), all.x = TRUE)

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

gimpo <- rbind(apart, villa, officehotel, multi)

gimpo <- gimpo %>%
  arrange(�ּ�)

gimpo$`�������(��)` <- as.numeric(gimpo$`�������(��)`)
gimpo$`��������(��)` <- as.numeric(gimpo$`��������(��)`)
gimpo$`�ŷ��ݾ�(����)` <- gsub(",", "", gimpo$`�ŷ��ݾ�(����)`)
gimpo$`�ŷ��ݾ�(����)` <- as.numeric(gimpo$`�ŷ��ݾ�(����)`)

# Calculate price/square
gimpo_1 <- gimpo %>%
  filter(�ǹ����� == '����Ʈ' | �ǹ����� == '���ǽ���' | �ǹ����� == '����/�ټ���') %>%
  mutate('�ŷ��ݾ�/����' = `�ŷ��ݾ�(����)` / `�������(��)`)

gimpo_2 <- gimpo %>%
  filter(�ǹ����� == '�ܵ�' | �ǹ����� == '�ٰ���') %>%
  mutate('�ŷ��ݾ�/����' = `�ŷ��ݾ�(����)` / `��������(��)`)

gimpo <- rbind(gimpo_1, gimpo_2)

gimpo <- gimpo %>%
  arrange(�ּ�)

write.xlsx(gimpo, "����_�Ÿ�_����.xlsx", row.names = FALSE)