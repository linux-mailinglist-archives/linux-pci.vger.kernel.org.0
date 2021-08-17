Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6C3EF17A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhHQSKh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhHQSKe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:10:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46411C061764;
        Tue, 17 Aug 2021 11:10:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so203965pjb.0;
        Tue, 17 Aug 2021 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5R+sAHflr+KG+cLGMf3VBfa4enUIPyLVzd+QztdkS5s=;
        b=FcBDycQ4BE6421kYpFSai6So/SdM795AuKFZ30EeAHehT3SS81iOmGkKbIxwxW9yXw
         z+7J0tQEdUm1Ve3dm2kKap29kBEkURX6cR3T4OdLBQ3kmCkW2f7tUum2hAfA+AJ0/gpg
         POh7UTZH/ZTUe0PyyPPYcIsqiYWudXxR6ufqhI7x9tAmfEP7bZyUW+ThSBGOMU15Ml0d
         2BXse7sd8QAE6EcskYxmn2oPNwt5l5L3aAvuwL1rP8j8i4fU+uRQkO/iNth0GK0Od708
         vVIFIreYSASFHT4kg3K3Pg0ArzckVlqUwwbMjdkn5NVHd9c1v4N9IgDXK29mSkHuO5nW
         yjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5R+sAHflr+KG+cLGMf3VBfa4enUIPyLVzd+QztdkS5s=;
        b=WAw0jDoi330nIKqT5qcjwrBOci+bOk1I5hBc3VyOYRsuu5CznUAXm3I+efWT3VtdHF
         eMoGVWlaUcTCJwBJJSjQJA309wf0C9bTU5vF2WCnjr1QfVS0iyQ1/a7dWbSxBA5vYPw4
         b5xeIO+GkGjOTWB6Yb9jJ3YKWhAbW2SK/KTQuZAC0xIP+c5qxAHZY/C4nc7VA88YusUs
         KaUXmFD2vSumsGpjLusUCJTYRmpkOhDeqUCIhAFI1T7T2z0f/gNB1jfMGeluBHL08FPM
         pjIcpKERCw2GCrMkJKN6cE7M1EgT/BrJOASBZYZem2nZ/X4nhVboBQShxDT4WqUhd5Ru
         C1QQ==
X-Gm-Message-State: AOAM530HYvKJOwSgKWuui61XV8gVpc8ncHqcDcud93qITWE4C2FfP5NZ
        E/FMeXsoikdG/s+vrVeY4Fw=
X-Google-Smtp-Source: ABdhPJxXaol80VLQkh5055oq3bJOMHzO0Y4wbyQ+ytPU/fxH3y490PTYPlQ1o8pz6Spe+HY+c90yJQ==
X-Received: by 2002:a65:6894:: with SMTP id e20mr4561150pgt.419.1629223800811;
        Tue, 17 Aug 2021 11:10:00 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id d18sm4011306pgk.24.2021.08.17.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:10:00 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 3/9] PCI: Add new array for keeping track of ordering of reset methods
Date:   Tue, 17 Aug 2021 23:39:31 +0530
Message-Id: <20210817180937.3123-4-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180937.3123-1-ameynarkhede03@gmail.com>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
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
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 drivers/pci/pci.c   | 95 ++++++++++++++++++++++++++-------------------
 drivers/pci/pci.h   |  8 +++-
 drivers/pci/probe.c |  5 +--
 include/linux/pci.h |  7 ++++
 4 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d1d96711..67eab3d29 100644
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
index 37c913bbc..743895374 100644
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
index df3f9db6e..5d8ad230f 100644
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
index aa85e7d31..d1a9a232d 100644
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

