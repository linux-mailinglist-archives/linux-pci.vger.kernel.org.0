Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760AD3943D4
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 16:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhE1OJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhE1OJq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 10:09:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B77C061763;
        Fri, 28 May 2021 07:08:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v13so1670244ple.9;
        Fri, 28 May 2021 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sb4vaVbLXqrF4pGm+Dy3hXkAmePJygTBSkU6zsnjJc0=;
        b=u2L9Y6ZskZLbuJK/FB66mjS4a5SWhByGITBM1YIdMN/64BN3LJzjjaZcoUYKEqooyi
         avl+Wg6FhKrFd4XLnd+UueLNvJDtXxGJiHqPMZSxJCYwu3wW1sRiURnJ1HUZQ8r2i8mr
         Xtf6dIUdaoLqC/DbeqOBO7BmkLFeJmPOpXnkltUEqwWOUSF9z9bo4VA5ZDDZp1hxnexw
         grKYMFBpjhiDjOQz2T7D95sY8FP8yqR7/2cfkxH/5ObRpXvIySfyrEnrw3C2lAXJeRf9
         a7wfqt7LEY0ecsPwOT6Ml8LX6AWZGohjuO/pg222jcXDsI2/M88NvAhFaQOfY/by6o42
         5bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb4vaVbLXqrF4pGm+Dy3hXkAmePJygTBSkU6zsnjJc0=;
        b=diGag8iwr41s6/B+zoVfzY6ophM0zBeIzkSjf06UYilERUbqlzEbtf/H8pJxkJM9Aj
         zII/8KDLKmbUobyGhFZ8+rAJTEmg3t75bPLlyV+ddV72wrEa+en2y8TpzUp1vVhsZtcL
         dgxbTrq8X1CoLiIqOPyL9+4Lpgv09fZypQPi9ewDLtCzD0jRdtFpdB9/SH2AJyQXk9Re
         v4wwms6BFyySCcYpAQVC6zVQLhGcQ0O8ymKS3mU9COr/af0mQ+cpZvFdz96IyNiEsZ3q
         qg5dtFraOEgBBdQNlttH77fxjVOjVxSgr1o7jWtn/nrPGBh+DMh/cuVGz305Ck/l9x0Y
         iN+w==
X-Gm-Message-State: AOAM5321M81XIcAJgbKB5ng7kwSAEirA2hu4jIWZkbnUs4jsmPxu2jgQ
        uUWlCa0dYF7VbG1QMN9UvFY=
X-Google-Smtp-Source: ABdhPJxJol9aqhHeIF2sxDCKGRXRF5dXkJGK4S4JwXjiEKxvY0MyufwCv1PeAwCdZx4rJ14DqKP6sw==
X-Received: by 2002:a17:90b:1b0a:: with SMTP id nu10mr4587527pjb.70.1622210890940;
        Fri, 28 May 2021 07:08:10 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id j3sm4607841pfe.98.2021.05.28.07.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:08:10 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v4 2/7] PCI: Add new array for keeping track of ordering of reset methods
Date:   Fri, 28 May 2021 19:37:50 +0530
Message-Id: <20210528140755.7044-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528140755.7044-1-ameynarkhede03@gmail.com>
References: <20210528140755.7044-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new array reset_methods in struct pci_dev
to keep track of reset mechanisms supported by the
device and their ordering. Also refactor probing and reset
functions to take advantage of calling convention of reset
functions.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/pci.c   | 107 ++++++++++++++++++++++++++------------------
 drivers/pci/pci.h   |   8 +++-
 drivers/pci/probe.c |   5 +--
 include/linux/pci.h |   7 +++
 4 files changed, 80 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7cacb6d21..cbdb5bd0d 100644
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
@@ -5068,6 +5076,19 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+/*
+ * The ordering for functions in pci_reset_fn_methods
+ * is required for reset_methods byte array defined
+ * in struct pci_dev.
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
@@ -5090,65 +5111,65 @@ static void pci_dev_restore(struct pci_dev *dev)
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
+				 * A reset method returns -ENOTTY if it doesn't support this device
+				 * and we should try the next method.
+				 *
+				 * If it returns 0 (success), we're finished.  If it returns any
+				 * other error, we're also finished: this indicates that further
+				 * reset mechanisms might be broken on the device.
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
index ef7c46613..1b3ba3116 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,7 +39,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
@@ -612,6 +612,12 @@ struct pci_dev_reset_methods {
 	int (*reset)(struct pci_dev *dev, int probe);
 };
 
+struct pci_reset_fn_method {
+	int (*reset_fn)(struct pci_dev *, int probe);
+	char *name;
+};
+
+extern const struct pci_reset_fn_method pci_reset_fn_methods[];
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_reset(struct pci_dev *dev, int probe);
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc..c5cfdd239 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2403,9 +2403,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
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
index 35c8e9e7e..738c0cadb 100644
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
@@ -506,6 +508,10 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+	/*
+	 * See pci_reset_fn_methods array in pci.c for ordering.
+	 */
+	u8 reset_methods[PCI_RESET_METHODS_NUM];	/* Reset methods ordered by priority */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -1219,6 +1225,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, int probe);
 int pcie_flr(struct pci_dev *dev);
+bool pci_reset_supported(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
-- 
2.31.1

