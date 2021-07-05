Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF03BBE21
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhGEOYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGEOYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:24:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C73C061574;
        Mon,  5 Jul 2021 07:22:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so14928446pjs.2;
        Mon, 05 Jul 2021 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJ2O1nNK01wBf0p/nBO9VwAZPFLJ7/FBVU/jbxpeRWo=;
        b=OQCR1kNGUECykJo+Wqve+WnpwlSKagZ2Nw+7pagLfhs8zjBqKWGZuiSPi8qcPw+sUK
         uY3SLxZb+IiqioN2y+KNaMPzIcEUMvAC4f7UcOk2IqLj/+Fp5pKCmbDB+0WSPoJfK8pC
         K8rHyklHUupBVqZRf1giXbvWBQ1ZbryTOsWpwRi7oiIF5rWRHMmmtw7T+dgcu6BDF3R6
         WXkpQGIJbytanNpZJjXWUgW7nZNYUPOzZAWj9mBvFClD8Gi+hYoG7klg9TZBBsf6yJsE
         QiyAJTlVvL2XgTYHbmtZ/+nkbv9JgzOXwBeL/iTa7jdZrqIlRbIMeE7029g/CChruHW7
         EBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJ2O1nNK01wBf0p/nBO9VwAZPFLJ7/FBVU/jbxpeRWo=;
        b=JfDUYDA4whDmQkNnfWH2a81cGd/phNyh8QGmOI3O4Ts4Y2SXpHfe8R5MBSTxA45uQa
         SIPgtRv51b4MmDPYt0SgpAMPAt97tarMdK9FE6H7LkduV9TyP7pqgGiA4/+Til87jOLS
         wsmX0MWm53slj4whn47qCNHlM/7vSjVBBK1Igp0ji0Qa8jX8xfFcW1jNYrj+8ZxZDAtn
         UeDD0OyVsX1ffU/w/qEYbnbter9yDNO7THubtr3IQveeFDlCyY3g7T25f6N3yzLZuXKC
         WnroY6hIWmg7JRGZkfmhPvJJTpQ6DHCa7dXnxUHjGMnYTkvdm7Ultq4lMW4nk6eM0pGp
         ciVg==
X-Gm-Message-State: AOAM532J8/N+A2rzlOTEib867KNiRBp+mDMvgZJ/4iFCY3rl0BUKClPH
        AlebNhf8l2IKebR9ciswphM=
X-Google-Smtp-Source: ABdhPJynxhUsFfkq+J5SV9BLg8iG7oPeXQs6oHkC7xS13CN2lMLe4Uo+hYniIXUHEN86yNn7PjrwSw==
X-Received: by 2002:a17:902:7c94:b029:fc:5e8b:e645 with SMTP id y20-20020a1709027c94b02900fc5e8be645mr12678061pll.18.1625494929692;
        Mon, 05 Jul 2021 07:22:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.googlemail.com with ESMTPSA id 92sm22615307pjv.29.2021.07.05.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:22:09 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v9 2/8] PCI: Add new array for keeping track of ordering of reset methods
Date:   Mon,  5 Jul 2021 19:51:32 +0530
Message-Id: <20210705142138.2651-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705142138.2651-1-ameynarkhede03@gmail.com>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
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
 drivers/pci/pci.c   | 92 ++++++++++++++++++++++++++-------------------
 drivers/pci/pci.h   |  9 ++++-
 drivers/pci/probe.c |  5 +--
 include/linux/pci.h |  7 ++++
 4 files changed, 70 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fefa6d7b3..42440cb10 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 		msleep(delay);
 }
 
+int pci_reset_supported(struct pci_dev *dev)
+{
+	u8 null_reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	return memcmp(null_reset_methods,
+		      dev->reset_methods, sizeof(null_reset_methods));
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 int pci_domains_supported = 1;
 #endif
@@ -5104,6 +5112,15 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+const struct pci_reset_fn_method pci_reset_fn_methods[] = {
+	{ },
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
@@ -5126,65 +5143,62 @@ static void pci_dev_restore(struct pci_dev *dev)
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
+	for (i = 0; i <  PCI_NUM_RESET_METHODS && (m = dev->reset_methods[i]); i++) {
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
+	int i, n, rc;
+	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	n = 0;
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
+	for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
+		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
+		if (!rc)
+			reset_methods[n++] = i;
+		else if (rc != -ENOTTY)
+			break;
+	}
 
-	return pci_reset_bus_function(dev, 1);
+	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 37c913bbc..db1ad94e7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,7 +33,8 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+int pci_reset_supported(struct pci_dev *dev);
+void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
@@ -606,6 +607,12 @@ struct pci_dev_reset_methods {
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
index a95252113..a3e9a9c88 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2406,9 +2406,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
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
index d432428fd..9f3e85f33 100644
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

