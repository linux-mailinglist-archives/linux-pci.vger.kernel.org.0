Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D28876619D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfGKW01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34626 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfGKW0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:24 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so16224648iot.1;
        Thu, 11 Jul 2019 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOIoEJiKcP7vpakpaaAnI3MdiobFP9JXIkK9dclT5Sg=;
        b=suoYMK+cDcUzj8/bNfNGnbhnCEPaNiRoO75KGYMJ4ENig42Y2CnEvQNCF+wGG6v/9h
         dlA/qBwi9RZn4p3f3rXKAB+j5u6mHMLpbjv3h/zmY5g5rKaGRuzT9gZhJpC2tZ1P+eml
         w5Git5WsUAavrL+PvLxgXAAqCaGiH8BNC6/PLthRnHdQ/0r/DwGMgGbFcfyRZlkQRS1m
         YrBUwqIa4eFJNYpI0NGpCwpdMDd+8FUA7lEPmYkJqgPvTSua+nVlBJ0okxmDCllpsgxm
         KLBY7QU+wxa2tzVp593DhMbN7/VqdJEXvXS3/gN/HQuwsAHjaiYlnyIJ2/cTQ3dkVvNN
         rmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOIoEJiKcP7vpakpaaAnI3MdiobFP9JXIkK9dclT5Sg=;
        b=J0EUNNj3QM6e+dfBIGLkuTyCFOdsVg0p+fVDf/PxS8OWF6eqqed/8wcuF6MiffaY3C
         8fa14Hpp71EMuGHc4duMR8UKgTiYFUdyX1zGs3ZTvXC3WQxmp20pUgu5EdCpsaU/taO/
         jf/XTZblg0O8TRGy541AaKOBbUkh0b/g+Y8LCo17XXDnyzZfr2uILASlnlVIrtg31FKL
         CC0Q4zUYjteUIe6pUTNJ5JwCOU6H9s2rGPZ83gQFRo9xq6jSDwptkjr0doPoifvc4Ue8
         Cc3eKg0Tt7M/xltwKYSxacpM3mX+KOonZVq6VUFM1BXrTbMj9y8CXlo7QurVaNW+jBn3
         paRQ==
X-Gm-Message-State: APjAAAXfA1H22MPARnUlPeuq9Zt/qNlhjJdzPdpDlKvGtSHrDzrEul/X
        eCs1tqBk5XNSS5UoWb04YTrIvAKSBSXcBg==
X-Google-Smtp-Source: APXvYqxpUwXIT6ElevR2eXDlrNot95sTB+oFjcn6YUNJWF7Fw0rKUmQ/yfUKiS9TlVbIV2n9W43JGg==
X-Received: by 2002:a5d:8049:: with SMTP id b9mr6596133ior.199.1562883983124;
        Thu, 11 Jul 2019 15:26:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:22 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 09/11] PCI: Move ECRC declarations to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:39 -0600
Message-Id: <20190711222341.111556-10-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_set_ecrc_checking() and pcie_ecrc_get_policy() are only called within
drivers/pci/. Since declarations do not need to be visible to the rest of
the kernel, move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 8 ++++++++
 include/linux/pci.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bc677e97a262..74249c31325c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -537,6 +537,14 @@ static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
 static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCIE_ECRC
+void pcie_set_ecrc_checking(struct pci_dev *dev);
+void pcie_ecrc_get_policy(char *str);
+#else
+static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
+static inline void pcie_ecrc_get_policy(char *str) { }
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 #else
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 263c087b95d5..8fbe3471e8f0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1501,14 +1501,6 @@ bool pci_aer_available(void);
 static inline bool pci_aer_available(void) { return false; }
 #endif
 
-#ifdef CONFIG_PCIE_ECRC
-void pcie_set_ecrc_checking(struct pci_dev *dev);
-void pcie_ecrc_get_policy(char *str);
-#else
-static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
-static inline void pcie_ecrc_get_policy(char *str) { }
-#endif
-
 bool pci_ats_disabled(void);
 
 #ifdef CONFIG_PCIE_PTM
-- 
2.20.1

