Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73333951D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhCLRgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 12:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhCLRgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 12:36:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A1C061574;
        Fri, 12 Mar 2021 09:36:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j6so12246248plx.6;
        Fri, 12 Mar 2021 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbrCD0QksJvbladF2pSbKHap/I9l4dbU3nddsfuyvyw=;
        b=IhFDQPqig9wPYYHb/xsHbGWyIu/fHSgkOpAqto/afvNC/NZyQGCFNGNDthpirixsq1
         v/nxEf3zKaJOfSDLf/d+4DRb5hOv0A9hGlj2q9oRvHqEG02wL1JMuFBnY+3BSMEFtbe0
         7Yr7vh3aL7aNbE2SrmVILVcnfRk6XKMb54NJTZ93lI2duWV4i044gyczJ5AxgjAtdNBS
         Pwy5nU7qQFE2D+gkKANq5/URk5ZHjHCWD5eUvmjeR6n4t4ujM2xhSL5Yoc8Fao1o4Ly+
         d90+6jsdQentbwBuOM0SBUZLwK4JVf1UcI2eCoxjTykyvf1kK1z9xJgK1dR6TZWa7Zi1
         vPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbrCD0QksJvbladF2pSbKHap/I9l4dbU3nddsfuyvyw=;
        b=f/w9QbmbyilqRfmOtuY7tnxdO0OC4Hmoso+ZlUiaRURlAAGS9keebjFiVBKVeasce5
         IPguLMW0AytUANMhYNTmVy4F6mu/i4apUzRogEsGWvghlEAaEIBK3S9mlmiNWKGdlIAC
         2Gp2qkoGsNDMThNJ+RaS02rQyUGKtjmfcjeHQVkemK852Y1cD3s2+XNalVeZA1XmBUTO
         IRvv/GTo5AMrILSkHNECZjUhJjf+HHZYCJxaCpl3WYRARoiFlFaiTeVbw2iqDKjEiXYw
         wZRzBxnDlw/fSgwbt+uRO7kngEDZjbc5Je3ytmEAFo5sAH208e/pvUUxFBLF1jRiszpr
         TldA==
X-Gm-Message-State: AOAM530MkMBCH0ndX6+ZwAy+VaIjqBQa0S5+v/Qo14cu+lpfem8FecgH
        wThvz36VJlbF5QUt8rpwbp7gh3MmQWqyGA==
X-Google-Smtp-Source: ABdhPJxpxD/SBh6SuNUNo49K5IRPmkXySv+RNtQ+X+t7/jymqHCDmmYiqDMYe0F4zcLlJqeBpbEaJg==
X-Received: by 2002:a17:902:aa0a:b029:e4:c090:ad76 with SMTP id be10-20020a170902aa0ab02900e4c090ad76mr180949plb.2.1615570606528;
        Fri, 12 Mar 2021 09:36:46 -0800 (PST)
Received: from localhost.localdomain ([103.248.31.144])
        by smtp.googlemail.com with ESMTPSA id l10sm180045pfc.125.2021.03.12.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:36:46 -0800 (PST)
From:   ameynarkhede03@gmail.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH 2/4] PCI: Add new bitmap for keeping track of supported reset mechanisms
Date:   Fri, 12 Mar 2021 23:04:50 +0530
Message-Id: <20210312173452.3855-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312173452.3855-1-ameynarkhede03@gmail.com>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Introduce a new bitmap reset_methods in struct pci_dev
to keep track of reset mechanisms supported by the
device. Also refactor probing and reset functions
to take advantage of calling convention of reset
functions.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

 drivers/pci/pci.c   | 106 ++++++++++++++++++++++++--------------------
 drivers/pci/pci.h   |  11 ++++-
 drivers/pci/probe.c |   5 +--
 include/linux/pci.h |  10 +++++
 4 files changed, 79 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c084a3..407b44e85 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -40,6 +40,26 @@ const char *pci_power_names[] = {
 };
 EXPORT_SYMBOL_GPL(pci_power_names);

+static int pci_af_flr(struct pci_dev *dev, int probe);
+static int pci_pm_reset(struct pci_dev *dev, int probe);
+static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe);
+static int pci_parent_bus_reset(struct pci_dev *dev, int probe);
+
+/*
+ * The ordering for functions in pci_reset_fn_methods
+ * is required for bitmap positions defined
+ * in reset_methods in struct pci_dev
+ */
+const struct pci_reset_fn_method pci_reset_fn_methods[] = {
+	{ .reset_fn = &pci_dev_specific_reset, .name = "device_specific" },
+	{ .reset_fn = &pcie_flr, .name = "flr" },
+	{ .reset_fn = &pci_af_flr, .name = "af_flr" },
+	{ .reset_fn = &pci_pm_reset, .name = "pm" },
+	{ .reset_fn = &pci_dev_reset_slot_function, .name = "slot" },
+	{ .reset_fn = &pci_parent_bus_reset, .name = "bus" },
+	{ 0 },
+};
+
 int isa_dma_bridge_buggy;
 EXPORT_SYMBOL(isa_dma_bridge_buggy);

@@ -5080,71 +5100,59 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	int rc;
+	int i, rc = -ENOTTY;
+	const struct pci_reset_fn_method *reset;

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
-	rc = pcie_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_af_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, 0);
+	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
+		if (!(dev->reset_methods & (1 << i)))
+			continue;
+
+		/*
+		 * A reset method returns -ENOTTY if it doesn't support this device
+		 * and we should try the next method.
+		 *
+		 * If it returns 0 (success), we're finished.  If it returns any
+		 * other error, we're also finished: this indicates that further
+		 * reset mechanisms might be broken on the device.
+		 */
+		rc = reset->reset_fn(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
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
+ * Stores reset mechanisms supported by device in reset_methods bitmap
+ * field of struct pci_dev
  */
-int pci_probe_reset_function(struct pci_dev *dev)
+void pci_init_reset_methods(struct pci_dev *dev)
 {
-	int rc;
+	int i, rc;
+	const struct pci_reset_fn_method *reset;

-	might_sleep();
+	dev->reset_methods = 0;

-	rc = pci_dev_specific_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pcie_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_af_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
+	might_sleep();

-	return pci_parent_bus_reset(dev, 1);
+	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
+		rc = reset->reset_fn(dev, 1);
+		if (!rc)
+			dev->reset_methods |= (1 << i);
+		else if (rc != -ENOTTY)
+			break;
+	}
 }

 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef7c46613..ec093efdc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,7 +39,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);

-int pci_probe_reset_function(struct pci_dev *dev);
+void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);

@@ -612,6 +612,15 @@ struct pci_dev_reset_methods {
 	int (*reset)(struct pci_dev *dev, int probe);
 };

+typedef int (*pci_reset_fn_t)(struct pci_dev *, int);
+
+struct pci_reset_fn_method {
+	pci_reset_fn_t reset_fn;
+	char *name;
+};
+
+extern const struct pci_reset_fn_method pci_reset_fn_methods[];
+
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_reset(struct pci_dev *dev, int probe);
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc..01dd037bd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2403,9 +2403,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */

 	pcie_report_downtraining(dev);
-
-	if (pci_probe_reset_function(dev) == 0)
-		dev->reset_fn = 1;
+	pci_init_reset_methods(dev);
+	dev->reset_fn = !!dev->reset_methods;
 }

 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 621ff5224..56d6e4750 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -325,6 +325,16 @@ struct pci_dev {
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
 	u8		revision;	/* PCI revision, low byte of class word */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
+	/*
+	 * bit 0 -> dev_specific
+	 * bit 1 -> flr
+	 * bit 2 -> af_flr
+	 * bit 3 -> pm
+	 * bit 4 -> slot
+	 * bit 5 -> bus
+	 * See pci_reset_fn_methods array in pci.c
+	 */
+	u8 __bitwise reset_methods;		/* bitmap for device supported reset capabilities */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
--
2.30.2
