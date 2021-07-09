Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8383C2381
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhGIMlZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 08:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhGIMlZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 08:41:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1916C0613DD;
        Fri,  9 Jul 2021 05:38:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f17so8602093pfj.8;
        Fri, 09 Jul 2021 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvIUpfi5XGXA2DEIiLPdFby3rxDR4GrgAhHlPQEkITI=;
        b=twok6VMrroQEGeyfLZUw8E9Aif5YdPeBFvHdiY58DHr+IwlXkK26wm2L/XxfeFygfO
         3TUtIjMY8rw3B3JbIm6XUvts5uCTPlGCHuPtALRpCu/DQpQgKdIC7PoVXUE9EzZOM/c7
         2W54nMF1y0aFpq63CcPBqasbhbzuwQLPCvVPl0Fj9Mw7T06sBgk1wadSQ90z1XBD3iz+
         sNcq3wJtssud2/WsVyqWxMTu7U2pXo5tqPkNGEx/qx8zpWNQms1r/ADyyV7IgzktBWKU
         nGyMXelBYPX3XbB6LqahwDaP9EgZcjhG2ZcMR5cRM6zIdTWHb5kNE58cyiplTdDFDm6l
         KpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvIUpfi5XGXA2DEIiLPdFby3rxDR4GrgAhHlPQEkITI=;
        b=C+bnVN/vzPy3rgKjf6satltyStxv+IDOFrYN35uNzp4noIcZRn+vS0lhG15yJR7WaW
         dG+AoqZHu0eDs/Re0KbUhQvxFW8WljY4Y+BG1/GQtmLNTVkg/o5Eik2D0vhckMuYLk+P
         HkHsl7/+plqVjEjeKoghvnbLlV/DR2j+P56n/ahLO0LFjcWYx2WcUwqaxczpkQaoJ8Oe
         mXSu9DllXsVrH6cn9xO6JDgRIU/SgROxIZ3SZkUdxXhDJbXzCVZHXqaJ6uU99dg6VVYG
         Ena4+HQe9ZoR+ULBuJd3jeasf8HE0vC+//lGLnA+nX2Yqc91vpxP/odSB0di6l3I664E
         vKIQ==
X-Gm-Message-State: AOAM531kyLvbgphpcAyfaFd10zpDKZWPeqQrxnw01Xd6xVttYaBJZbtR
        udAKHMI/sI4YtTGwnh2E6is=
X-Google-Smtp-Source: ABdhPJyDRQqwmEY19ZKW/O/RQ7u63g6iA4x3LMOCDVV1fZohMrfYH1ANhWif47+dtbL8BpnSp4feyQ==
X-Received: by 2002:a63:7152:: with SMTP id b18mr829877pgn.209.1625834321246;
        Fri, 09 Jul 2021 05:38:41 -0700 (PDT)
Received: from localhost.localdomain ([152.57.176.46])
        by smtp.googlemail.com with ESMTPSA id j6sm5592402pji.23.2021.07.09.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:38:40 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering of reset methods
Date:   Fri,  9 Jul 2021 18:08:07 +0530
Message-Id: <20210709123813.8700-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709123813.8700-1-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
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
index 072a3d4dc..bc4af914a 100644
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

