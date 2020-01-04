Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856731304FC
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2020 23:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgADWvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jan 2020 17:51:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38227 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADWvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jan 2020 17:51:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so25162853pfc.5;
        Sat, 04 Jan 2020 14:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VqlsVp/NSaIMmgDSqvtwHY9q2FVKamntUndP7LxowRg=;
        b=gcQcOdvsli1NRJYb+XCVGBiznblI7DL2DaGTIfSQA9BlVJv7aZ59VTYZdXIAM7tqVx
         RlDRU1pHnBWQdOsKAUsuuVxEI54QYfs/y4RnU0q6pKszXa4SzkIch/XNX6vzndO9yoPm
         YP9JXyNoowg8fPl6GV+KckySGD9xxSMlVRWJ/l0tkLyjlc3yJA8byI4k8Qv9SL3WUu7t
         YwPqimVWdi7JhhtdqgfZeaCl+FWpD45RqfYprURHQVvF55DAYyb9DKIHfsjIiWh9KE0y
         S3ZeCc6hHanxFO/hWAgctfS4rrsmU2NoOYem3Q0XETrL7Yiemr58bIneNmedrf5lmlSC
         sABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VqlsVp/NSaIMmgDSqvtwHY9q2FVKamntUndP7LxowRg=;
        b=c+g9VQqQALg5QkBHDd4yLs6JXUoJh+voHKJDIgKZ/s2mMldiQfyRJ07BytRo/1au7/
         cW96k1/zjqkacOsGtvz17T8X5gDI/eKcSvCAc8zVCYcSs4T9y7iFTb53xasQszTIJvrQ
         aJCymE9gw1K5bnLwzks08qjl1OmahDNVEfoGJHE0rURCS5UIrHFelQTx72cZreGiK6dS
         PHOpEfenUEy6VcQc/eM9W8SQ8uR3LWhSuSYzsWW1/1hVtgaLvmws+SR45x1hC1FYzTOX
         ATPehQ8G4uXdvnNlKpKk+Wv+POUi6/uFkd/Bl2f803iGkJNkt78flTflqL9OCZZRejUA
         ksrg==
X-Gm-Message-State: APjAAAXpXHaC5n8MBSVS5pr5pEaCc7pWcFlkxYki7qPTqz+Hec7aidKv
        ku63MYuXhYOfb0vdduNJDzI+ZDan
X-Google-Smtp-Source: APXvYqxYZhspN4ldPGSx/DgKUDAvk+Voi1/8Ft/cVXMlJTe6GpeTOZLQePaCVcG4+22GQWrNm97Dgg==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr69251463pfg.51.1578178313639;
        Sat, 04 Jan 2020 14:51:53 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id c1sm39259301pfo.44.2020.01.04.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 14:51:53 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: pci: Clear ACS state at kexec
Date:   Sat,  4 Jan 2020 14:51:49 -0800
Message-Id: <20200104225149.27342-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ACS bits remain sticky through kexec reset. This is not really a
problem for Linux because turning IOMMU on assumes ACS on. But,
this becomes a problem if we kexec into something other than
Linux and that does not turn ACS on always.

Reset the ACS bits to default before kexec or device remove.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 drivers/pci/pci-driver.c |  4 ++++
 drivers/pci/pci.c        | 39 +++++++++++++++++++++++++++------------
 drivers/pci/pci.h        |  1 +
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..bd8d08e50b97 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -453,6 +453,8 @@ static int pci_device_remove(struct device *dev)
 
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
+	/* Undo the PCI ACS settings in pci_init_capabilities() */
+	pci_disable_acs(pci_dev);
 
 	/*
 	 * If the device is still on, set the power state as "unknown",
@@ -493,6 +495,8 @@ static void pci_device_shutdown(struct device *dev)
 	 */
 	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
 		pci_clear_master(pci_dev);
+	if (kexec_in_progress)
+		pci_disable_acs(pci_dev);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index da2e59daad6f..8254617cff03 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3261,15 +3261,23 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 	pci_info(dev, "disabled ACS redirect\n");
 }
 
+
+/* Standard PCI ACS capailities
+ * Source Validation | P2P Request Redirect | P2P Completion Redirect | Upstream Forwarding
+ */
+#define PCI_STD_ACS_CAP (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
+
 /**
- * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
+ * pci_std_enable_disable_acs - enable/disable ACS on devices using standard
+ * ACS capabilities
  * @dev: the PCI device
  */
-static void pci_std_enable_acs(struct pci_dev *dev)
+static void pci_std_enable_disable_acs(struct pci_dev *dev, int enable)
 {
 	int pos;
 	u16 cap;
 	u16 ctrl;
+	u16 val = 0;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
 	if (!pos)
@@ -3278,19 +3286,26 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
 
-	/* Source Validation */
-	ctrl |= (cap & PCI_ACS_SV);
+	val = (cap & PCI_STD_ACS_CAP);
 
-	/* P2P Request Redirect */
-	ctrl |= (cap & PCI_ACS_RR);
+	if (enable)
+		ctrl |= val;
+	else
+		ctrl &= ~val;
 
-	/* P2P Completion Redirect */
-	ctrl |= (cap & PCI_ACS_CR);
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+}
 
-	/* Upstream Forwarding */
-	ctrl |= (cap & PCI_ACS_UF);
+/**
+ * pci_disable_acs - enable ACS if hardware support it
+ * @dev: the PCI device
+ */
+void pci_disable_acs(struct pci_dev *dev)
+{
+	if (pci_acs_enable)
+		pci_std_enable_disable_acs(dev, 0);
 
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+	pci_disable_acs_redir(dev);
 }
 
 /**
@@ -3305,7 +3320,7 @@ void pci_enable_acs(struct pci_dev *dev)
 	if (!pci_dev_specific_enable_acs(dev))
 		goto disable_acs_redir;
 
-	pci_std_enable_acs(dev);
+	pci_std_enable_disable_acs(dev, 1);
 
 disable_acs_redir:
 	/*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6394e7746fb5..480e4de46fa8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -526,6 +526,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_enable_acs(struct pci_dev *dev);
+void pci_disable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.17.1

