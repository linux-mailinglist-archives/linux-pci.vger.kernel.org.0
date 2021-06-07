Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57A39E677
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFGSYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhFGSYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 14:24:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7057FC061787;
        Mon,  7 Jun 2021 11:22:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b12so3215016plg.11;
        Mon, 07 Jun 2021 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAcRFUtR3ofinSM/RLsLfvOR2Fccz0rm5mzFFvQ1VLI=;
        b=nEfTimUGb1sGIl7eYYFRO3yVa28xu5yvFOCkid+jS2Bbn3bntMn6VhUcGH2XcnoMFV
         arczLUFaTSw1QL5dw81ZCT1wiLCgFmuNgm4ZHb6I6w7Y2m1XVwF4vw496LIeJgAuBsqE
         JGRSpbFJIku6Hl3v2gkJMXDKVeiZ+wBPnU8c48U5P8ENvGOVW4HoMtM338/hdZmJXqA8
         P2k/EP/AdJTzr6qe2z6U8svRVtIm/sOd4n7u7iuE+knwD04qOufeM7VllrYoWYfHTsXK
         7z0A1auOuDKBcHrfiJAE3wOo5Mb3OmDR6wEBbDYo4McEsABhUE/1WYGsmPInahTTVb8M
         +e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAcRFUtR3ofinSM/RLsLfvOR2Fccz0rm5mzFFvQ1VLI=;
        b=fTlG5QV82zYBoVnc4efmsfI5JTw9QReoMiSJQdNfYHW02vqYpylM7YBsCWfKMt+myg
         fMcqKGa6KbrPlpjUw9Gl9pr4HbAGxa1hl50xfnk9MJo6sf76wReJT5VMYZF+PfsV5hBS
         IAECCb8LijPMEy2ulJUzcbukY+ZQ2Z79qxlMsv0/Nx208AtBR1kHZJ2y8fp9uAKHDQLb
         IfLbWtfPkZVoooI7SjCJleURhLT0dNL2eRxa8A1MKKvcnGv6uoMzQjhK0+WpDUmvUgrB
         bHpV4DfRkwMH1V4R8M41iNbytUi/CCcLqvzHzNHuXfb0tqS5Mz2tqZRDBWq5/phH8ovy
         knwg==
X-Gm-Message-State: AOAM531U2LpHGp7iJmDjbKd3TClgyIDY4ZDHO8VPACbEU058mK/xKXIB
        ORuAEpr5d6liFLuLWPtdSZo=
X-Google-Smtp-Source: ABdhPJxUhBHfgpV6jDeJ0DskbPuomepvl2T1cis58aNJJ66blmJH3f5C52G6e21YhAGyUuJkgucKBw==
X-Received: by 2002:a17:90a:950c:: with SMTP id t12mr414726pjo.135.1623090149760;
        Mon, 07 Jun 2021 11:22:29 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.115])
        by smtp.googlemail.com with ESMTPSA id k1sm8687656pfa.30.2021.06.07.11.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:22:29 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v6 2/8] PCI: Add new array for keeping track of ordering of reset methods
Date:   Mon,  7 Jun 2021 23:51:31 +0530
Message-Id: <20210607182137.5794-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607182137.5794-1-ameynarkhede03@gmail.com>
References: <20210607182137.5794-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new array reset_methods in struct pci_dev to keep track of
reset mechanisms supported by the device and their ordering.
Also refactor probing and reset functions to take advantage of calling
convention of reset functions.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/pci.c   | 108 ++++++++++++++++++++++++++------------------
 drivers/pci/pci.h   |   8 +++-
 drivers/pci/probe.c |   5 +-
 include/linux/pci.h |   7 +++
 4 files changed, 81 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3bf36924c..39a9ea8bb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 		msleep(delay);
 }
 
+bool pci_reset_supported(struct pci_dev *dev)
+{
+	u8 null_reset_methods[PCI_RESET_METHODS_NUM] = { 0 };
+
+	return memcmp(null_reset_methods,
+		      dev->reset_methods, PCI_RESET_METHODS_NUM);
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 int pci_domains_supported = 1;
 #endif
@@ -5107,6 +5115,18 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+/*
+ * The ordering for functions in pci_reset_fn_methods is required for
+ * reset_methods byte array defined in struct pci_dev.
+ */
+const struct pci_reset_fn_method pci_reset_fn_methods[] = {
+	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pcie_reset_flr, .name = "flr" },
+	{ &pci_af_flr, .name = "af_flr" },
+	{ &pci_pm_reset, .name = "pm" },
+	{ &pci_reset_bus_function, .name = "bus" },
+};
+
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
@@ -5129,65 +5149,67 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	int rc;
+	int i, rc = -ENOTTY;
+	u8 prio;
 
 	might_sleep();
 
-	/*
-	 * A reset method returns -ENOTTY if it doesn't support this device
-	 * and we should try the next method.
-	 *
-	 * If it returns 0 (success), we're finished.  If it returns any
-	 * other error, we're also finished: this indicates that further
-	 * reset mechanisms might be broken on the device.
-	 */
-	rc = pci_dev_specific_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pcie_reset_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_af_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_reset_bus_function(dev, 0);
+	for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
+		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
+			if (dev->reset_methods[i] == prio) {
+				/*
+				 * A reset method returns -ENOTTY if it doesn't
+				 * support this device and we should try the
+				 * next method.
+				 *
+				 * If it returns 0 (success), we're finished.
+				 * If it returns any other error, we're also
+				 * finished: this indicates that further reset
+				 * mechanisms might be broken on the device.
+				 */
+				rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
+				if (rc != -ENOTTY)
+					return rc;
+				break;
+			}
+		}
+		if (i == PCI_RESET_METHODS_NUM)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
 /**
- * pci_probe_reset_function - check whether the device can be safely reset
- * @dev: PCI device to reset
+ * pci_init_reset_methods - check whether device can be safely reset
+ * and store supported reset mechanisms.
+ * @dev: PCI device to check for reset mechanisms
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
+ * to reads and writes to its PCI config space in order to use this function.
  *
- * Returns 0 if the device function can be reset or negative if the
- * device doesn't support resetting a single function.
+ * Stores reset mechanisms supported by device in reset_methods byte array
+ * which is a member of struct pci_dev.
  */
-int pci_probe_reset_function(struct pci_dev *dev)
+void pci_init_reset_methods(struct pci_dev *dev)
 {
-	int rc;
+	int i, rc;
+	u8 prio = PCI_RESET_METHODS_NUM;
+	u8 reset_methods[PCI_RESET_METHODS_NUM] = { 0 };
 
-	might_sleep();
+	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_RESET_METHODS_NUM);
 
-	rc = pci_dev_specific_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pcie_reset_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_af_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
+	might_sleep();
 
-	return pci_reset_bus_function(dev, 1);
+	for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
+		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
+		if (!rc)
+			reset_methods[i] = prio--;
+		else if (rc != -ENOTTY)
+			break;
+	}
+	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 37c913bbc..13ec6bd6f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,7 +33,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
@@ -606,6 +606,12 @@ struct pci_dev_reset_methods {
 	int (*reset)(struct pci_dev *dev, int probe);
 };
 
+struct pci_reset_fn_method {
+	int (*reset_fn)(struct pci_dev *pdev, int probe);
+	char *name;
+};
+
+extern const struct pci_reset_fn_method pci_reset_fn_methods[];
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_reset(struct pci_dev *dev, int probe);
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8..8cf532681 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2404,9 +2404,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 
 	pcie_report_downtraining(dev);
-
-	if (pci_probe_reset_function(dev) == 0)
-		dev->reset_fn = 1;
+	pci_init_reset_methods(dev);
+	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 20b90c205..0955246f8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,6 +49,8 @@
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_PARITY)
 
+#define PCI_RESET_METHODS_NUM 5
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -505,6 +507,10 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+	/*
+	 * See pci_reset_fn_methods array in pci.c for ordering.
+	 */
+	u8 reset_methods[PCI_RESET_METHODS_NUM];	/* Reset methods ordered by priority */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -1227,6 +1233,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, int probe);
 int pcie_flr(struct pci_dev *dev);
+bool pci_reset_supported(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
-- 
2.31.1

