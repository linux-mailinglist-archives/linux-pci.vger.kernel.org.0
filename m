Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87ED3DCC07
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 16:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhHAOZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhHAOZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Aug 2021 10:25:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127FCC06175F;
        Sun,  1 Aug 2021 07:25:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k4-20020a17090a5144b02901731c776526so27816871pjm.4;
        Sun, 01 Aug 2021 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYuie5bBQ1R9okxCbicxPsdRMdKcRbsiETMhCT9MqHg=;
        b=mnAUwtxdEfrovVCKxSS+CZxigFN+Bk+P7BL4o11nFOSVLm0ZOnY8UlTYS/PRvQxEB0
         +0dPlOGYmrEpwrhK5Y/VsLIT1Ts4mrBVOnJoWMpK8DDubw20kasapkUSI/vqPm0HOgCA
         TKd22yjlSsSAmNvO4gjIotOFFY7QzWjJqB5pwjf3oM8BRM3UC6mUYmF59jUspEC0k7lr
         aIystTRseN1hAtHMW37TTIwbqc90MaK3D2oHejJDErwOr1wby/nTM9O4uVO81+NMY3wv
         Fp2Xok3vlmW+gVnO7M/XbmWPv1xce2vqysOV/Ueh74343ynXu9SGSG+/cWLYWHFMbCbu
         AyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYuie5bBQ1R9okxCbicxPsdRMdKcRbsiETMhCT9MqHg=;
        b=BQzO1YzpPGsFmX6+hlAE8ZuGhrYEBYIvglj7OVPD7w3ExAp6fKSE9RSZszLoSOc5s4
         +y6qF/AHtU3suFTQVnNzg8oEXGQkVg68yHFpuWqMn96GNxz5j5XSvD5eTGGwZhhV+dnt
         MnJS5jpqrfcgIc+/EndCzSFm2DkU8haRTuKGWZzIfvBdMezMAt6OvuQ/pwXZTWhA2U0D
         flVljp8J87a4JpYEc821IrB6xv11ewoxTzq6tp8Asn4w/w3HQDupTO2JBovVFkguxH6D
         2EEru9OLIXOsPWLVuW3TrVt6SrmqwWYZVQM3LOHA8Trugf7UOLTl9DzXYQx9LNHRwB+t
         fXmg==
X-Gm-Message-State: AOAM530CFJ7DAw/vo9TwdSrnuvoOZ+2uueq/XnYhm/yerkI248QbRQC4
        t/0lhnx5LvxfgxcsKeJ8YeE=
X-Google-Smtp-Source: ABdhPJwe+Xjz+1GXybUGZJkwDewPks1iYaVgiakuOHCUyhW6hvDnJ45TPKabN9r6xA6rby9ewlmXfg==
X-Received: by 2002:a17:90a:1957:: with SMTP id 23mr8048217pjh.147.1627827939598;
        Sun, 01 Aug 2021 07:25:39 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.186])
        by smtp.googlemail.com with ESMTPSA id g11sm7740897pju.13.2021.08.01.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:25:39 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v13 3/9] PCI: Add new array for keeping track of ordering of reset methods
Date:   Sun,  1 Aug 2021 19:55:12 +0530
Message-Id: <20210801142518.1224-4-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801142518.1224-1-ameynarkhede03@gmail.com>
References: <20210801142518.1224-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new array reset_methods in struct pci_dev to keep track of
reset mechanisms supported by the device and their ordering.

Also refactor probing and reset functions to take advantage of calling
convention of reset functions.

Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/pci.c   | 95 ++++++++++++++++++++++++++-------------------
 drivers/pci/pci.h   |  8 +++-
 drivers/pci/probe.c |  5 +--
 include/linux/pci.h |  7 ++++
 4 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f219a3dc6750..010962d7dba6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -73,6 +73,11 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 		msleep(delay);
 }
 
+bool pci_reset_supported(struct pci_dev *dev)
+{
+	return dev->reset_methods[0] != 0;
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 int pci_domains_supported = 1;
 #endif
@@ -5117,6 +5122,16 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+/* dev->reset_methods[] is a 0-terminated list of indices into this array */
+static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
+	{ },
+	{ pci_dev_specific_reset, .name = "device_specific" },
+	{ pcie_reset_flr, .name = "flr" },
+	{ pci_af_flr, .name = "af_flr" },
+	{ pci_pm_reset, .name = "pm" },
+	{ pci_reset_bus_function, .name = "bus" },
+};
+
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
@@ -5139,65 +5154,65 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	int rc;
+	int i, m, rc = -ENOTTY;
 
 	might_sleep();
 
 	/*
-	 * A reset method returns -ENOTTY if it doesn't support this device
-	 * and we should try the next method.
+	 * A reset method returns -ENOTTY if it doesn't support this device and
+	 * we should try the next method.
 	 *
-	 * If it returns 0 (success), we're finished.  If it returns any
-	 * other error, we're also finished: this indicates that further
-	 * reset mechanisms might be broken on the device.
+	 * If it returns 0 (success), we're finished.  If it returns any other
+	 * error, we're also finished: this indicates that further reset
+	 * mechanisms might be broken on the device.
 	 */
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
+	for (i = 0; i <  PCI_NUM_RESET_METHODS; i++) {
+		m = dev->reset_methods[i];
+		if (!m)
+			return -ENOTTY;
+
+		rc = pci_reset_fn_methods[m].reset_fn(dev, 0);
+		if (!rc)
+			return 0;
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	return -ENOTTY;
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
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
+ * other functions in the same device.  The PCI device must be in D0-D3hot
+ * state.
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
+	int m, i, rc;
+
+	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
 
 	might_sleep();
 
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
+	i = 0;
+
+	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
+		rc = pci_reset_fn_methods[m].reset_fn(dev, 1);
+		if (!rc)
+			dev->reset_methods[i++] = m;
+		else if (rc != -ENOTTY)
+			break;
+	}
 
-	return pci_reset_bus_function(dev, 1);
+	dev->reset_methods[i] = 0;
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 37c913bbc6e1..7438953745e0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,7 +33,8 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+bool pci_reset_supported(struct pci_dev *dev);
+void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
@@ -606,6 +607,11 @@ struct pci_dev_reset_methods {
 	int (*reset)(struct pci_dev *dev, int probe);
 };
 
+struct pci_reset_fn_method {
+	int (*reset_fn)(struct pci_dev *pdev, int probe);
+	char *name;
+};
+
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_reset(struct pci_dev *dev, int probe);
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index df3f9db6e151..5d8ad230f7d0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2405,9 +2405,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
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
index aa85e7d3147e..d1a9a232d08e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,6 +49,9 @@
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_PARITY)
 
+/* Number of reset methods used in pci_reset_fn_methods array in pci.c */
+#define PCI_NUM_RESET_METHODS 6
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -506,6 +509,10 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+	/*
+	 * See pci_reset_fn_methods array in pci.c for ordering.
+	 */
+	u8 reset_methods[PCI_NUM_RESET_METHODS];	/* Reset methods ordered by priority */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.32.0

