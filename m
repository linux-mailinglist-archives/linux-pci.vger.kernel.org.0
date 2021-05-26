Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0D3914A8
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhEZKQW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhEZKQS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 06:16:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D9C06138B;
        Wed, 26 May 2021 03:14:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a7so374786plh.3;
        Wed, 26 May 2021 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAZN0TnEkim3n9XAqfhlq/IkJcPTImfrdMGkmm/+jLE=;
        b=sPWtzuy3bGWMd1X0omYzvyiiXIC9k5iCP9A5U96nI3Y199/5UKYO4qfNhQB9+TO1s7
         j9s/kNNnFQBhq1jTCCKbPecU2nZ8uWZQeT5d71kJoiBtcQb7tr7QcZ64D/dF3UbSoYai
         uB+Li3xpMCSLiE2CGmTT66gOPoMJdcBn3oAftXx15EJynx1gCV3DSwXru7u+PBBrBH50
         kZKTLbK7gHHYDf4edhbwyTZDyB582PFNNm2tQuKem026PRiILLeRF3LhDziwLDefIF2p
         1mJqk0fqXL/eUZR+vN7Dq61f5yeKulb5hODvJsQTg5fiDM05rIK36sRKhVTGmb6fPPZg
         J/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAZN0TnEkim3n9XAqfhlq/IkJcPTImfrdMGkmm/+jLE=;
        b=XO45g1dU4f8TS8EyaulikL45WnQrrMY3ojPH23g13XjyKq7GnJYw1iHwHYy4jp16jE
         m/541m/aFReLVImP6A7BHuqJiZ9WUoXI06T7UL3WOiOoNGiSvyOz4RdGZPWTNidCPUmA
         vKznxayii3CU0QSWGUG6scg24id29z2cFozxzbQEqn4hWadsgqxrMM3HwApxDQKty6/D
         uGC6F0gn+uWE7jwVE166aRH+oXcy306XZ8Ro2W+plpbJwczoJA3QZ9TwMO+vHcXmFAsT
         12FtfLtBkYjAoYX3YbMY5hhBeHnK3hDdVkI0DtbLzIBLm3VhzWDYbsB286WPiZSKt14D
         PFSw==
X-Gm-Message-State: AOAM530qnNDFIOMlOgESc+WlSbCjz0tTXcW8RgcmOElA8xdYlLDr8kFC
        4dMt/fADYbFkmAR9lHL8ZeI=
X-Google-Smtp-Source: ABdhPJzexDYLwj6QCw4yC9+ZvYXVePWNL+gcW3H6XTh2S/3TlJQVI9aXp8q+UfZResT+Lz4OEWKXtA==
X-Received: by 2002:a17:902:fe02:b029:f5:6e58:91c0 with SMTP id g2-20020a170902fe02b02900f56e5891c0mr35242247plj.81.1622024086234;
        Wed, 26 May 2021 03:14:46 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id c191sm15662614pfc.94.2021.05.26.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:14:45 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v3 7/7] PCI: Change the type of probe argument in reset functions
Date:   Wed, 26 May 2021 15:44:03 +0530
Message-Id: <20210526101403.108721-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101403.108721-1-ameynarkhede03@gmail.com>
References: <20210526101403.108721-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new enum pci_reset_mode_t to make the context
of probe argument in reset functions clear and the code
easier to read.
Change the type of probe argument in functions which implement
reset methods from int to pci_reset_mode_t to make the intent clear.
Add a new line in return statement of pci_reset_bus_function.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c    |  2 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
 drivers/pci/hotplug/pciehp.h                  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |  7 +-
 drivers/pci/pci.c                             | 85 +++++++++++++------
 drivers/pci/pci.h                             |  8 +-
 drivers/pci/pcie/aer.c                        |  2 +-
 drivers/pci/quirks.c                          | 46 +++++++---
 include/linux/pci.h                           |  8 +-
 include/linux/pci_hotplug.h                   |  2 +-
 10 files changed, 112 insertions(+), 52 deletions(-)

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
index 4fd200d8b..7cbc30dd3 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -181,7 +181,7 @@ void pciehp_release_ctrl(struct controller *ctrl);
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe);
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, pci_reset_mode_t probe);
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index fb3840e22..31f75f5f2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -834,14 +834,17 @@ void pcie_disable_interrupt(struct controller *ctrl)
  * momentarily, if we see that they could interfere. Also, clear any spurious
  * events after.
  */
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, enum pci_reset_mode probe)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
 
-	if (probe)
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	down_write(&ctrl->reset_lock);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1d859b100..e731dab9f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4616,10 +4616,13 @@ EXPORT_SYMBOL_GPL(pcie_flr);
  *
  * Initiate a function level reset on @dev.
  */
-int pcie_reset_flr(struct pci_dev *dev, int probe)
+int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	u32 cap;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;
 
@@ -4627,18 +4630,21 @@ int pcie_reset_flr(struct pci_dev *dev, int probe)
 	if (!(cap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	return pcie_flr(dev);
 }
 EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
-static int pci_af_flr(struct pci_dev *dev, int probe)
+static int pci_af_flr(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	int pos;
 	u8 cap;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
 	if (!pos)
 		return -ENOTTY;
@@ -4650,7 +4656,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
 		return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	/*
@@ -4693,10 +4699,13 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
  * by default (i.e. unless the @dev's d3hot_delay field has a different value).
  * Moreover, only devices in D0 can be reset by this function.
  */
-static int pci_pm_reset(struct pci_dev *dev, int probe)
+static int pci_pm_reset(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	u16 csr;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
 		return -ENOTTY;
 
@@ -4704,7 +4713,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
 		return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	if (dev->current_state != PCI_D0)
@@ -4953,10 +4962,13 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
-static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
+static int pci_parent_bus_reset(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	struct pci_dev *pdev;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;
@@ -4965,16 +4977,19 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 		if (pdev != dev)
 			return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
 
-static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
+static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, pci_reset_mode_t probe)
 {
 	int rc = -ENOTTY;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (!hotplug || !try_module_get(hotplug->owner))
 		return rc;
 
@@ -4986,8 +5001,11 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
 	return rc;
 }
 
-static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
+static int pci_dev_reset_slot_function(struct pci_dev *dev, pci_reset_mode_t probe)
 {
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (dev->multifunction || dev->subordinate || !dev->slot ||
 	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;
@@ -4995,12 +5013,16 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
-static int pci_reset_bus_function(struct pci_dev *dev, int probe)
+static int pci_reset_bus_function(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	int rc = pci_dev_reset_slot_function(dev, probe);
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (rc != -ENOTTY)
 		return rc;
+
 	return pci_parent_bus_reset(dev, probe);
 }
 
@@ -5081,17 +5103,20 @@ static void pci_dev_restore(struct pci_dev *dev)
  * @dev: device to reset
  * @probe: check if _RST method is included in the acpi_device context.
  */
-static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+static int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 #ifdef CONFIG_ACPI
 	acpi_handle handle = ACPI_HANDLE(&dev->dev);
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	/* Return -ENOTTY if _RST method is not included in the dev context */
 	if (!handle || !acpi_has_method(handle, "_RST"))
 		return -ENOTTY;
 
 	/* Return 0 for probe phase indicating that we can reset this device */
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	/* Invoke _RST() method to perform a function level reset */
@@ -5157,7 +5182,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 				 * other error, we're also finished: this indicates that further
 				 * reset mechanisms might be broken on the device.
 				 */
-				rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
+				rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_DO_RESET);
 				if (rc != -ENOTTY)
 					return rc;
 				break;
@@ -5193,7 +5218,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
 	might_sleep();
 
 	for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
-		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
+		rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_PROBE);
 		if (!rc)
 			reset_methods[i] = prio--;
 		else if (rc != -ENOTTY)
@@ -5509,21 +5534,24 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 	}
 }
 
-static int pci_slot_reset(struct pci_slot *slot, int probe)
+static int pci_slot_reset(struct pci_slot *slot, pci_reset_mode_t probe)
 {
 	int rc;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (!slot || !pci_slot_resetable(slot))
 		return -ENOTTY;
 
-	if (!probe)
+	if (probe == PCI_RESET_DO_RESET)
 		pci_slot_lock(slot);
 
 	might_sleep();
 
 	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
 
-	if (!probe)
+	if (probe == PCI_RESET_DO_RESET)
 		pci_slot_unlock(slot);
 
 	return rc;
@@ -5537,7 +5565,7 @@ static int pci_slot_reset(struct pci_slot *slot, int probe)
  */
 int pci_probe_reset_slot(struct pci_slot *slot)
 {
-	return pci_slot_reset(slot, 1);
+	return pci_slot_reset(slot, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
 
@@ -5560,14 +5588,14 @@ static int __pci_reset_slot(struct pci_slot *slot)
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
@@ -5576,14 +5604,17 @@ static int __pci_reset_slot(struct pci_slot *slot)
 	return rc;
 }
 
-static int pci_bus_reset(struct pci_bus *bus, int probe)
+static int pci_bus_reset(struct pci_bus *bus, pci_reset_mode_t probe)
 {
 	int ret;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (!bus->self || !pci_bus_resetable(bus))
 		return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	pci_bus_lock(bus);
@@ -5622,14 +5653,14 @@ int pci_bus_error_reset(struct pci_dev *bridge)
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
@@ -5640,7 +5671,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
  */
 int pci_probe_reset_bus(struct pci_bus *bus)
 {
-	return pci_bus_reset(bus, 1);
+	return pci_bus_reset(bus, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
@@ -5654,7 +5685,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
-	rc = pci_bus_reset(bus, 1);
+	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
 	if (rc)
 		return rc;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1b3ba3116..f05db86af 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -609,19 +609,19 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
-	int (*reset)(struct pci_dev *dev, int probe);
+	int (*reset)(struct pci_dev *dev, pci_reset_mode_t probe);
 };
 
 struct pci_reset_fn_method {
-	int (*reset_fn)(struct pci_dev *, int probe);
+	int (*reset_fn)(struct pci_dev *, pci_reset_mode_t probe);
 	char *name;
 };
 
 extern const struct pci_reset_fn_method pci_reset_fn_methods[];
 #ifdef CONFIG_PCI_QUIRKS
-int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t probe);
 #else
-static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+static inline int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	return -ENOTTY;
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f4e891bd5..1259f1cdb 100644
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
index ceec67342..17ed9a9c8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3693,8 +3693,11 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
  * not available.
  */
-static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
+static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, pci_reset_mode_t probe)
 {
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	/*
 	 * http://www.intel.com/content/dam/doc/datasheet/82599-10-gbe-controller-datasheet.pdf
 	 *
@@ -3703,7 +3706,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	 * Thus we must call pcie_flr() directly without first checking if it is
 	 * supported.
 	 */
-	if (!probe)
+	if (probe == PCI_RESET_DO_RESET)
 		pcie_flr(dev);
 	return 0;
 }
@@ -3715,13 +3718,16 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 #define NSDE_PWR_STATE		0xd0100
 #define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */
 
-static int reset_ivb_igd(struct pci_dev *dev, int probe)
+static int reset_ivb_igd(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	void __iomem *mmio_base;
 	unsigned long timeout;
 	u32 val;
 
-	if (probe)
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	mmio_base = pci_iomap(dev, 0, 0);
@@ -3758,11 +3764,14 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 }
 
 /* Device-specific reset method for Chelsio T4-based adapters */
-static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
+static int reset_chelsio_generic_dev(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	u16 old_command;
 	u16 msix_flags;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	/*
 	 * If this isn't a Chelsio T4-based device, return -ENOTTY indicating
 	 * that we have no device-specific reset method.
@@ -3774,7 +3783,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 	 * If this is the "probe" phase, return 0 indicating that we can
 	 * reset this device.
 	 */
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	/*
@@ -3836,17 +3845,20 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
  *    Chapter 3: NVMe control registers
  *    Chapter 7.3: Reset behavior
  */
-static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
+static int nvme_disable_and_flr(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	void __iomem *bar;
 	u16 cmd;
 	u32 cfg;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
+	    pcie_reset_flr(dev, PCI_RESET_PROBE) || !pci_resource_start(dev, 0))
 		return -ENOTTY;
 
-	if (probe)
+	if (probe == PCI_RESET_PROBE)
 		return 0;
 
 	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
@@ -3910,11 +3922,16 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  * device too soon after FLR.  A 250ms delay after FLR has heuristically
  * proven to produce reliably working results for device assignment cases.
  */
-static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
+static int delay_250ms_after_flr(struct pci_dev *dev, pci_reset_mode_t probe)
 {
-	int ret = pcie_reset_flr(dev, probe);
+	int ret;
+
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
 
-	if (probe)
+	ret = pcie_reset_flr(dev, probe);
+
+	if (probe == PCI_RESET_PROBE)
 		return ret;
 
 	msleep(250);
@@ -3941,10 +3958,13 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
  * because when a host assigns a device to a guest VM, the host may need
  * to reset the device but probably doesn't have a driver for it.
  */
-int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t probe)
 {
 	const struct pci_dev_reset_methods *i;
 
+	if (probe >= PCI_RESET_ACTION_MAX)
+		return -EINVAL;
+
 	for (i = pci_dev_reset_methods; i->reset; i++) {
 		if ((i->vendor == dev->vendor ||
 		     i->vendor == (u16)PCI_ANY_ID) &&
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9bec3c616..ee7cd3577 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,6 +51,12 @@
 
 #define PCI_RESET_METHODS_NUM 6
 
+typedef enum pci_reset_mode {
+	PCI_RESET_DO_RESET,
+	PCI_RESET_PROBE,
+	PCI_RESET_ACTION_MAX,
+} pci_reset_mode_t;
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -1222,7 +1228,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-int pcie_reset_flr(struct pci_dev *dev, int probe);
+int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t probe);
 int pcie_flr(struct pci_dev *dev);
 bool pci_reset_supported(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index b482e42d7..84976d620 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -44,7 +44,7 @@ struct hotplug_slot_ops {
 	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
-	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
+	int (*reset_slot)		(struct hotplug_slot *slot, pci_reset_mode_t probe);
 };
 
 /**
-- 
2.31.1

