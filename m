Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233443EF158
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhHQSGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhHQSGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:06:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A40C0612A8;
        Tue, 17 Aug 2021 11:05:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u15so10310185plg.13;
        Tue, 17 Aug 2021 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AENU2zwfMHMFO6+tFuQdbqqy/9tg69HSH7MuwdfUXOw=;
        b=DKvgJcRAAKPMKX1bC1nXt5nl2Z9AFSSCMxobUnmvzj5ymFbasxC5gmd8pEOIFSHY2q
         aTlCTpPz7EipQxx3+qk5wR0C272ZUxkqT4M3flBHDPuLgWXbk+lcsFwwwrHyPZ0lyygG
         Vc0GpTfDYWQhhCalnD94Sl3no/HXPDHfiSaqsHnKGXjwYGjEl68AHWM0ZBrQUTYsv1j7
         I/Dy7Ly5uMojDLs+A6XwKhVrtV7OuFh7VW22pcESwu2pJz9ogbumv5q2NYmWfUpahzXk
         +dfm7SuBSdc3XvESJ89P89Vzec88D3sB2337Q3w7lXmNeCpZQzi9E9Jc5AHGopDv00pD
         72vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AENU2zwfMHMFO6+tFuQdbqqy/9tg69HSH7MuwdfUXOw=;
        b=R59FwjvFph44zWKKgeGr30Ma7QtdnXXMwITr4E/OIDGbi5IHC4cqd80RyqeB+V9tuP
         g27H0AY/Op6R0SB5+FtRcvEVLmHmTUu6Eg1b4leIBunDYnHdl+Pr7qZ/DULyBg2aL8kD
         KInCnzZHO68F3JA/q6vqySY6Zs9QrjkZJ5ct7mnhpx/tTpDD2GJh1eF8uF8SMHLOiRzY
         d2sBAfqUjkL3rhIHIoAQFHGUOzTh2MXaOOIGQEAqcurUbyyRzPIRCMBvZfHR+AyRbDfF
         WZnCsCOKa0ylhS0EJSSAArjR8KbVWdWkVEAomzFznad0YXeLtu7yaDsjiBPYHBuOWcFk
         vHxQ==
X-Gm-Message-State: AOAM530n0mMZ2ReVKH3zVQRn7BLQFi4Ps9k4BN/6/BNgja+JUg1fqDOw
        +diKJPOCpuDrxEFJc+sgRzM=
X-Google-Smtp-Source: ABdhPJy2hNmZiibRzKHmCswfYfV0FGq/TCv1oxhqwGyyX7Y+/biHs/xrUf3QP3epVxR1ZKUktqFijw==
X-Received: by 2002:a63:eb06:: with SMTP id t6mr4722254pgh.235.1629223541268;
        Tue, 17 Aug 2021 11:05:41 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id 65sm4065632pgi.12.2021.08.17.11.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:05:41 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 9/9] PCI: Change the type of probe argument in reset functions
Date:   Tue, 17 Aug 2021 23:35:00 +0530
Message-Id: <20210817180500.1253-10-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180500.1253-1-ameynarkhede03@gmail.com>
References: <20210817180500.1253-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change the type of probe argument in functions which implement reset
methods from int to bool to make the context and intent clear.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c    |  2 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
 drivers/pci/hotplug/pciehp.h                  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |  2 +-
 drivers/pci/hotplug/pnv_php.c                 |  4 +-
 drivers/pci/pci-acpi.c                        |  5 +-
 drivers/pci/pci.c                             | 52 +++++++++----------
 drivers/pci/pci.h                             | 12 ++---
 drivers/pci/pcie/aer.c                        |  2 +-
 drivers/pci/quirks.c                          | 20 +++----
 include/linux/pci.h                           |  5 +-
 include/linux/pci_hotplug.h                   |  2 +-
 12 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 15d6c8452..f97fa8e99 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -306,7 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
 		return -ENOMEM;
 	}
 
-	pcie_reset_flr(pdev, 0);
+	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 
 	pci_restore_state(pdev);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 336d149ee..6e666be69 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			oct->irq_name_storage = NULL;
 		}
 		/* Soft reset the octeon device before exiting */
-		if (!pcie_reset_flr(oct->pci_dev, 1))
+		if (!pcie_reset_flr(oct->pci_dev, PCI_RESET_PROBE))
 			octeon_pci_flr(oct);
 		else
 			cn23xx_vf_ask_pf_to_do_flr(oct);
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 4fd200d8b..23d6d6813 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -181,7 +181,7 @@ void pciehp_release_ctrl(struct controller *ctrl);
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe);
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe);
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index fb3840e22..d9f782b2e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -834,7 +834,7 @@ void pcie_disable_interrupt(struct controller *ctrl)
  * momentarily, if we see that they could interfere. Also, clear any spurious
  * events after.
  */
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 04565162a..4c17a5dc2 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -526,7 +526,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 	return 0;
 }
 
-static int pnv_php_reset_slot(struct hotplug_slot *slot, int probe)
+static int pnv_php_reset_slot(struct hotplug_slot *slot, bool probe)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 	struct pci_dev *bridge = php_slot->pdev;
@@ -537,7 +537,7 @@ static int pnv_php_reset_slot(struct hotplug_slot *slot, int probe)
 	 * which don't have a bridge. Only claim to support
 	 * reset_slot() if we have a bridge device (for now...)
 	 */
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return !bridge;
 
 	/* mask our interrupt while resetting the bridge */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e7b2f7d5c..968bf8aa5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -944,9 +944,10 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 /**
  * pci_dev_acpi_reset - do a function level reset using _RST method
  * @dev: device to reset
- * @probe: check if _RST method is included in the acpi_device context.
+ * @probe: If PCI_RESET_PROBE, check whether _RST method is included
+ *         in the acpi_device context.
  */
-int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	acpi_handle handle = ACPI_HANDLE(&dev->dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5f76d04fa..08e57ece4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4663,11 +4663,11 @@ EXPORT_SYMBOL_GPL(pcie_flr);
 /**
  * pcie_reset_flr - initiate a PCIe function level reset
  * @dev: device to reset
- * @probe: If set, only check if the device can be reset this way.
+ * @probe: If PCI_RESET_PROBE, only check if the device can be reset this way.
  *
  * Initiate a function level reset on @dev.
  */
-int pcie_reset_flr(struct pci_dev *dev, int probe)
+int pcie_reset_flr(struct pci_dev *dev, bool probe)
 {
 	if (!pcie_has_flr(dev))
 		return -ENOTTY;
@@ -4679,7 +4679,7 @@ int pcie_reset_flr(struct pci_dev *dev, int probe)
 }
 EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
-static int pci_af_flr(struct pci_dev *dev, int probe)
+static int pci_af_flr(struct pci_dev *dev, bool probe)
 {
 	int pos;
 	u8 cap;
@@ -4726,7 +4726,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 /**
  * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
  * @dev: Device to reset.
- * @probe: If set, only check if the device can be reset this way.
+ * @probe: If PCI_RESET_PROBE, only check if the device can be reset this way.
  *
  * If @dev supports native PCI PM and its PCI_PM_CTRL_NO_SOFT_RESET flag is
  * unset, it will be reinitialized internally when going from PCI_D3hot to
@@ -4738,7 +4738,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
  * by default (i.e. unless the @dev's d3hot_delay field has a different value).
  * Moreover, only devices in D0 can be reset by this function.
  */
-static int pci_pm_reset(struct pci_dev *dev, int probe)
+static int pci_pm_reset(struct pci_dev *dev, bool probe)
 {
 	u16 csr;
 
@@ -4749,7 +4749,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
 		return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	if (dev->current_state != PCI_D0)
@@ -4998,7 +4998,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
-static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
+static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *pdev;
 
@@ -5016,7 +5016,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
 
-static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
+static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 {
 	int rc = -ENOTTY;
 
@@ -5031,7 +5031,7 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
 	return rc;
 }
 
-static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
+static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 {
 	if (dev->multifunction || dev->subordinate || !dev->slot ||
 	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
@@ -5040,7 +5040,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
-static int pci_reset_bus_function(struct pci_dev *dev, int probe)
+static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	int rc;
 
@@ -5203,7 +5203,7 @@ static ssize_t reset_method_store(struct device *dev,
 		if (i < n)
 			continue;
 
-		if (pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
+		if (pci_reset_fn_methods[m].reset_fn(pdev, PCI_RESET_PROBE)) {
 			pci_warn(pdev, "Unsupported reset method '%s'", name);
 			continue;
 		}
@@ -5222,7 +5222,7 @@ static ssize_t reset_method_store(struct device *dev,
 	if (pdev->reset_methods[0] == 0) {
 		pci_warn(pdev, "All device reset methods disabled by user");
 	} else if ((pdev->reset_methods[0] != 1) &&
-		   !pci_reset_fn_methods[1].reset_fn(pdev, 1)) {
+		   !pci_reset_fn_methods[1].reset_fn(pdev, PCI_RESET_PROBE)) {
 		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
 	}
 	return count;
@@ -5289,7 +5289,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 		if (!m)
 			return -ENOTTY;
 
-		rc = pci_reset_fn_methods[m].reset_fn(dev, 0);
+		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_DO_RESET);
 		if (!rc)
 			return 0;
 		if (rc != -ENOTTY)
@@ -5323,7 +5323,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
 	i = 0;
 
 	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
-		rc = pci_reset_fn_methods[m].reset_fn(dev, 1);
+		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_PROBE);
 		if (!rc)
 			dev->reset_methods[i++] = m;
 		else if (rc != -ENOTTY)
@@ -5640,21 +5640,21 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 	}
 }
 
-static int pci_slot_reset(struct pci_slot *slot, int probe)
+static int pci_slot_reset(struct pci_slot *slot, bool probe)
 {
 	int rc;
 
 	if (!slot || !pci_slot_resetable(slot))
 		return -ENOTTY;
 
-	if (!probe)
+	if (probe != PCI_RESET_PROBE)
 		pci_slot_lock(slot);
 
 	might_sleep();
 
 	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
 
-	if (!probe)
+	if (probe != PCI_RESET_PROBE)
 		pci_slot_unlock(slot);
 
 	return rc;
@@ -5668,7 +5668,7 @@ static int pci_slot_reset(struct pci_slot *slot, int probe)
  */
 int pci_probe_reset_slot(struct pci_slot *slot)
 {
-	return pci_slot_reset(slot, 1);
+	return pci_slot_reset(slot, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
 
@@ -5691,14 +5691,14 @@ static int __pci_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
-	rc = pci_slot_reset(slot, 1);
+	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
 	if (rc)
 		return rc;
 
 	if (pci_slot_trylock(slot)) {
 		pci_slot_save_and_disable_locked(slot);
 		might_sleep();
-		rc = pci_reset_hotplug_slot(slot->hotplug, 0);
+		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
 		pci_slot_restore_locked(slot);
 		pci_slot_unlock(slot);
 	} else
@@ -5707,14 +5707,14 @@ static int __pci_reset_slot(struct pci_slot *slot)
 	return rc;
 }
 
-static int pci_bus_reset(struct pci_bus *bus, int probe)
+static int pci_bus_reset(struct pci_bus *bus, bool probe)
 {
 	int ret;
 
 	if (!bus->self || !pci_bus_resetable(bus))
 		return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	pci_bus_lock(bus);
@@ -5753,14 +5753,14 @@ int pci_bus_error_reset(struct pci_dev *bridge)
 			goto bus_reset;
 
 	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_slot_reset(slot, 0))
+		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
 			goto bus_reset;
 
 	mutex_unlock(&pci_slot_mutex);
 	return 0;
 bus_reset:
 	mutex_unlock(&pci_slot_mutex);
-	return pci_bus_reset(bridge->subordinate, 0);
+	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
 }
 
 /**
@@ -5771,7 +5771,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
  */
 int pci_probe_reset_bus(struct pci_bus *bus)
 {
-	return pci_bus_reset(bus, 1);
+	return pci_bus_reset(bus, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
@@ -5785,7 +5785,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
-	rc = pci_bus_reset(bus, 1);
+	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
 	if (rc)
 		return rc;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b13dae332..45c93d78f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -604,18 +604,18 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
-	int (*reset)(struct pci_dev *dev, int probe);
+	int (*reset)(struct pci_dev *dev, bool probe);
 };
 
 struct pci_reset_fn_method {
-	int (*reset_fn)(struct pci_dev *pdev, int probe);
+	int (*reset_fn)(struct pci_dev *pdev, bool probe);
 	char *name;
 };
 
 #ifdef CONFIG_PCI_QUIRKS
-int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+int pci_dev_specific_reset(struct pci_dev *dev, bool probe);
 #else
-static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 {
 	return -ENOTTY;
 }
@@ -704,9 +704,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
-int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
+int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
 #else
-static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	return -ENOTTY;
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 98077595a..cfa7a1775 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1405,7 +1405,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	}
 
 	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
-		rc = pcie_reset_flr(dev, 0);
+		rc = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 		if (!rc)
 			pci_info(dev, "has been reset\n");
 		else
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0db5dac3d..50c3078bf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3669,7 +3669,7 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
  * not available.
  */
-static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
+static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
 {
 	/*
 	 * http://www.intel.com/content/dam/doc/datasheet/82599-10-gbe-controller-datasheet.pdf
@@ -3691,7 +3691,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 #define NSDE_PWR_STATE		0xd0100
 #define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */
 
-static int reset_ivb_igd(struct pci_dev *dev, int probe)
+static int reset_ivb_igd(struct pci_dev *dev, bool probe)
 {
 	void __iomem *mmio_base;
 	unsigned long timeout;
@@ -3734,7 +3734,7 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 }
 
 /* Device-specific reset method for Chelsio T4-based adapters */
-static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
+static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 {
 	u16 old_command;
 	u16 msix_flags;
@@ -3812,14 +3812,14 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
  *    Chapter 3: NVMe control registers
  *    Chapter 7.3: Reset behavior
  */
-static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
+static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 {
 	void __iomem *bar;
 	u16 cmd;
 	u32 cfg;
 
 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
+	    pcie_reset_flr(dev, PCI_RESET_PROBE) || !pci_resource_start(dev, 0))
 		return -ENOTTY;
 
 	if (probe)
@@ -3886,12 +3886,12 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  * device too soon after FLR.  A 250ms delay after FLR has heuristically
  * proven to produce reliably working results for device assignment cases.
  */
-static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
+static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
 {
 	if (probe)
-		return pcie_reset_flr(dev, 1);
+		return pcie_reset_flr(dev, PCI_RESET_PROBE);
 
-	pcie_reset_flr(dev, 0);
+	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 
 	msleep(250);
 
@@ -3906,7 +3906,7 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 #define HINIC_OPERATION_TIMEOUT     15000	/* 15 seconds */
 
 /* Device-specific reset method for Huawei Intelligent NIC virtual functions */
-static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
+static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 {
 	unsigned long timeout;
 	void __iomem *bar;
@@ -3983,7 +3983,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
  * because when a host assigns a device to a guest VM, the host may need
  * to reset the device but probably doesn't have a driver for it.
  */
-int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 {
 	const struct pci_dev_reset_methods *i;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d3b06bfd8..5a9e906b0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,6 +52,9 @@
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
 #define PCI_NUM_RESET_METHODS 7
 
+#define	PCI_RESET_PROBE		true
+#define PCI_RESET_DO_RESET	false
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -1232,7 +1235,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-int pcie_reset_flr(struct pci_dev *dev, int probe);
+int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index b482e42d7..608c012eb 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -44,7 +44,7 @@ struct hotplug_slot_ops {
 	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
-	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
+	int (*reset_slot)		(struct hotplug_slot *slot, bool probe);
 };
 
 /**
-- 
2.32.0

