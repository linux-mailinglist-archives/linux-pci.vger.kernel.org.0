Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8766196
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfGKW0P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35530 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfGKW0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:13 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so16212945ioo.2;
        Thu, 11 Jul 2019 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqFBk1FaYQjd5Lzc/850mm3V6XDniUot7IqB9zeZTao=;
        b=JcM5L6GuN8ncWjv+3WRDFgbZGs1pMOi1cAzotJyME1JgQbkm4tcvyGJ382atCLNTDj
         kQtZz8an0A/vJCcjYQeB3i2A0J1YQ0+IunvPdMm7A4XHVNnId/M1gwtcWYl9FG6b0M9i
         C8gA21gINuWZUNk17WFs3F3exotOKJJ6DZw8itU9vM2roTObAQqEM2CcEFFDopW35tnS
         U7lqrm1PCP/8zUAAq3F1euyodEVQ20d/hMJXIbSI7H10Ht3U7PxFmbNQhVz2SAiUsIjX
         sR00BrA60UvSMxxokcGDSHQ+rEirvBADOF8XqOOSZIjGnkxDkfCRFxM3Viv/Da0OeQzU
         7Pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqFBk1FaYQjd5Lzc/850mm3V6XDniUot7IqB9zeZTao=;
        b=tcIILu4pUBoJx+SHhFz4Ai6rEJ9SKj7kFYinIQgznCxRLKKKQrzfTFLtiROaL391HR
         vNmDqxvVYrR9Du2FuYreuTdrbXKqDuYRAmX/O2S9ZqebcfPrxQsSaLB8W3RnxzEqb38T
         GAPHm5ui9nBl0JIqzmd1hm14e/TWznq/DDJqk/rNtFPnHTwfg9spdDqVpRaIdRWYI2rF
         XYIZp7JeEvf+vtRvJJV97t5t202xNsm85gszTF3o1eAdwoN4FESmOONh0x7ZBwpfvz+u
         W07sbns2YyUlGAZR0/Byr/nsCRPzLoZzM5H0yZO2jehS4AnTikl3tjFV4Oz1FeX619D/
         Hetg==
X-Gm-Message-State: APjAAAUS9y937vvchcpB8eCaq871bGw4KT2SX/PP45fcTII3BTE78Mgx
        m+X7UEEfG4t2dbioppQoVVbs/avIV1bJpw==
X-Google-Smtp-Source: APXvYqzbYgulXcThSGIMz/NMbDOKuJMQszIhPvb5qChUfwJv3PxF494BVb5b5byadTNBwnRJaOlrjA==
X-Received: by 2002:a6b:f114:: with SMTP id e20mr4139658iog.169.1562883972052;
        Thu, 11 Jul 2019 15:26:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:11 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 01/11] PCI: Move #define PCI_PM_* lines to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:31 -0600
Message-Id: <20190711222341.111556-2-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The #define PCI_PM_* lines are only used within drivers/pci/ and they do not
need to be seen by the rest of the kernel. Move #define PCI_* to
drivers/pci/pci.h

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 5 +++++
 include/linux/pci.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9cb99380c61e..7e30fbde5c84 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,6 +39,11 @@ int pci_probe_reset_function(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
+#define PCI_PM_D2_DELAY         200
+#define PCI_PM_D3_WAIT          10
+#define PCI_PM_D3COLD_WAIT      100
+#define PCI_PM_BUS_WAIT         50
+
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd436da7eccc..3bda6a87a815 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -145,11 +145,6 @@ static inline const char *pci_power_name(pci_power_t state)
 	return pci_power_names[1 + (__force int) state];
 }
 
-#define PCI_PM_D2_DELAY		200
-#define PCI_PM_D3_WAIT		10
-#define PCI_PM_D3COLD_WAIT	100
-#define PCI_PM_BUS_WAIT		50
-
 /**
  * The pci_channel state describes connectivity between the CPU and
  * the PCI device.  If some PCI bus between here and the PCI device
-- 
2.20.1

