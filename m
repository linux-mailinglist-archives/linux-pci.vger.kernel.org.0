Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D039EE67
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFHFwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:52:36 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:46775 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFHFwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:52:36 -0400
Received: by mail-oo1-f41.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso4722838ooc.13;
        Mon, 07 Jun 2021 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQipCvQ5oEhrz8zWr9eccTldK+elGG4aWGjFi4FzJp8=;
        b=gbzF3hFxtCrRlKpfd70F0l8MwaSMMiRrdRIYjCZh9QCsOMrT+teGA1ct6Cvy8zP3en
         xVtmbHhqRmBD48b4yMW3ADjQ7DQKpOZ0TJQtZUSpdxKtF0FeMcOYjGCnKFop3yH8xbN8
         +Kv8vtxeLu3m3KNmBUXsGu1jd89pGyrKNblxdXLwshoM9xcKA9jSiyKZGAEPt1v23q+V
         mbFCdLDDX4U1ofzc498lswrIzQqplrOs+gRArKf8JN5NLbp8CK+E5jAg3seI2jF9z7Y/
         vcO6FBDCESyZp0A6oZcbg3Y3r9JwrYsDLJ2UWeIfBqKiqVLC4y00dfIfuJTL03ZxxN9a
         PT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQipCvQ5oEhrz8zWr9eccTldK+elGG4aWGjFi4FzJp8=;
        b=gUybadSPvHsHr2/8sjmH7JAvHND9WK6LnhFgO4/JhXZAfjHNgFAUY8syB4ZH1Q+FBY
         nIUoHXZ95IEAe3G8RNTXfz0SgABSpBjKCyoDGl8lcM5XyJeGRm8pOHfHpt6ryluIUTiA
         zyuhCw+/MqdlDz8fPvdMCiw8FLdeHGiuX/votO2ljgcnTJn/eXU7RrAAGDhafd/8XVKW
         rpV0UvUGbKx53u8vH8SDHPcgxAC9TjojpufqL4bvShLdkD5q2THd5OiFLE4TwYUxut/c
         GIXLEDBT0bzRctRqLNsm1Mm0qu4VrmEuRVsl5vN3hKOsCkdr+QSt8N/UYHybps3YB+x+
         YW4Q==
X-Gm-Message-State: AOAM532+jFV0RGes4r9fh0tEWvc/ijzKtEGP6XAzXz8byGN5vsWxAGsy
        XwK+dFjMfBTmuCledF88Ups=
X-Google-Smtp-Source: ABdhPJxFW9C9BQGAYM1p1Dt4SAprMYSwNqB/Uz1YeDsDQ3s25jrVO5DMaC0YXnVFKdsTI+V94fKV3A==
X-Received: by 2002:a4a:b4cd:: with SMTP id g13mr15941096ooo.4.1623131383938;
        Mon, 07 Jun 2021 22:49:43 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:43 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v7 8/8] PCI: Change the type of probe argument in reset functions
Date:   Tue,  8 Jun 2021 11:18:57 +0530
Message-Id: <20210608054857.18963-9-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new enum pci_reset_mode_t to make the context of probe argument
in reset functions clear and the code easier to read.
Change the type of probe argument in functions which implement reset
methods from int to pci_reset_mode_t to make the intent clear.

Add a new line in return statement of pci_reset_bus_function().

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c    |  2 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
 drivers/pci/hotplug/pciehp.h                  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |  4 +-
 drivers/pci/pci-acpi.c                        | 10 ++-
 drivers/pci/pci.c                             | 85 ++++++++++++-------
 drivers/pci/pci.h                             | 12 +--
 drivers/pci/pcie/aer.c                        |  2 +-
 drivers/pci/quirks.c                          | 37 ++++----
 include/linux/pci.h                           |  8 +-
 include/linux/pci_hotplug.h                   |  2 +-
 11 files changed, 101 insertions(+), 65 deletions(-)

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
index 4fd200d8b..87da03adc 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -181,7 +181,7 @@ void pciehp_release_ctrl(struct controller *ctrl);

 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe);
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, pci_reset_mode_t mode);
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index fb3840e22..24b3c8787 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -834,14 +834,14 @@ void pcie_disable_interrupt(struct controller *ctrl)
  * momentarily, if we see that they could interfere. Also, clear any spurious
  * events after.
  */
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
+int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, pci_reset_mode_t mode)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	down_write(&ctrl->reset_lock);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 40dd24cd3..9de334457 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -944,16 +944,20 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 /**
  * pci_dev_acpi_reset - do a function level reset using _RST method
  * @dev: device to reset
- * @probe: check if _RST method is included in the acpi_device context.
+ * @probe: If PCI_RESET_PROBE, check whether _RST method is included
+ *         in the acpi_device context.
  */
-int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	acpi_handle handle = ACPI_HANDLE(&dev->dev);

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!handle || !acpi_has_method(handle, "_RST"))
 		return -ENOTTY;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2e7efd7e7..e28611d7c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4650,14 +4650,17 @@ EXPORT_SYMBOL_GPL(pcie_flr);
 /**
  * pcie_reset_flr - initiate a PCIe function level reset
  * @dev: device to reset
- * @probe: If set, only check if the device can be reset this way.
+ * @mode: If PCI_RESET_PROBE, only check if the device can be reset this way.
  *
  * Initiate a function level reset on @dev.
  */
-int pcie_reset_flr(struct pci_dev *dev, int probe)
+int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	u32 cap;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;

@@ -4665,18 +4668,21 @@ int pcie_reset_flr(struct pci_dev *dev, int probe)
 	if (!(cap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	return pcie_flr(dev);
 }
 EXPORT_SYMBOL_GPL(pcie_reset_flr);

-static int pci_af_flr(struct pci_dev *dev, int probe)
+static int pci_af_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	int pos;
 	u8 cap;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
 	if (!pos)
 		return -ENOTTY;
@@ -4688,7 +4694,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
 		return -ENOTTY;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	/*
@@ -4719,7 +4725,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 /**
  * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
  * @dev: Device to reset.
- * @probe: If set, only check if the device can be reset this way.
+ * @mode: If PCI_RESET_PROBE, only check if the device can be reset this way.
  *
  * If @dev supports native PCI PM and its PCI_PM_CTRL_NO_SOFT_RESET flag is
  * unset, it will be reinitialized internally when going from PCI_D3hot to
@@ -4731,10 +4737,13 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
  * by default (i.e. unless the @dev's d3hot_delay field has a different value).
  * Moreover, only devices in D0 can be reset by this function.
  */
-static int pci_pm_reset(struct pci_dev *dev, int probe)
+static int pci_pm_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	u16 csr;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
 		return -ENOTTY;

@@ -4742,7 +4751,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
 		return -ENOTTY;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	if (dev->current_state != PCI_D0)
@@ -4991,10 +5000,13 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);

-static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
+static int pci_parent_bus_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	struct pci_dev *pdev;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;
@@ -5003,44 +5015,47 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 		if (pdev != dev)
 			return -ENOTTY;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }

-static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
+static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, pci_reset_mode_t mode)
 {
 	int rc = -ENOTTY;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!hotplug || !try_module_get(hotplug->owner))
 		return rc;

 	if (hotplug->ops->reset_slot)
-		rc = hotplug->ops->reset_slot(hotplug, probe);
+		rc = hotplug->ops->reset_slot(hotplug, mode);

 	module_put(hotplug->owner);

 	return rc;
 }

-static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
+static int pci_dev_reset_slot_function(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	if (dev->multifunction || dev->subordinate || !dev->slot ||
 	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;

-	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
+	return pci_reset_hotplug_slot(dev->slot->hotplug, mode);
 }

-static int pci_reset_bus_function(struct pci_dev *dev, int probe)
+static int pci_reset_bus_function(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	int rc;

-	rc = pci_dev_reset_slot_function(dev, probe);
+	rc = pci_dev_reset_slot_function(dev, mode);
 	if (rc != -ENOTTY)
 		return rc;
-	return pci_parent_bus_reset(dev, probe);
+	return pci_parent_bus_reset(dev, mode);
 }

 static void pci_dev_lock(struct pci_dev *dev)
@@ -5168,7 +5183,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 				 * finished: this indicates that further reset
 				 * mechanisms might be broken on the device.
 				 */
-				rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
+				rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_DO_RESET);
 				if (rc != -ENOTTY)
 					return rc;
 				break;
@@ -5204,7 +5219,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
 	might_sleep();

 	for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
-		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
+		rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_PROBE);
 		if (!rc)
 			reset_methods[i] = prio--;
 		else if (rc != -ENOTTY)
@@ -5520,21 +5535,24 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 	}
 }

-static int pci_slot_reset(struct pci_slot *slot, int probe)
+static int pci_slot_reset(struct pci_slot *slot, pci_reset_mode_t mode)
 {
 	int rc;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!slot || !pci_slot_resetable(slot))
 		return -ENOTTY;

-	if (!probe)
+	if (mode != PCI_RESET_PROBE)
 		pci_slot_lock(slot);

 	might_sleep();

-	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
+	rc = pci_reset_hotplug_slot(slot->hotplug, mode);

-	if (!probe)
+	if (mode != PCI_RESET_PROBE)
 		pci_slot_unlock(slot);

 	return rc;
@@ -5548,7 +5566,7 @@ static int pci_slot_reset(struct pci_slot *slot, int probe)
  */
 int pci_probe_reset_slot(struct pci_slot *slot)
 {
-	return pci_slot_reset(slot, 1);
+	return pci_slot_reset(slot, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);

@@ -5571,14 +5589,14 @@ static int __pci_reset_slot(struct pci_slot *slot)
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
@@ -5587,14 +5605,17 @@ static int __pci_reset_slot(struct pci_slot *slot)
 	return rc;
 }

-static int pci_bus_reset(struct pci_bus *bus, int probe)
+static int pci_bus_reset(struct pci_bus *bus, pci_reset_mode_t mode)
 {
 	int ret;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	if (!bus->self || !pci_bus_resetable(bus))
 		return -ENOTTY;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	pci_bus_lock(bus);
@@ -5633,14 +5654,14 @@ int pci_bus_error_reset(struct pci_dev *bridge)
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
@@ -5651,7 +5672,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
  */
 int pci_probe_reset_bus(struct pci_bus *bus)
 {
-	return pci_bus_reset(bus, 1);
+	return pci_bus_reset(bus, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);

@@ -5665,7 +5686,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;

-	rc = pci_bus_reset(bus, 1);
+	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
 	if (rc)
 		return rc;

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e9cfb7cd6..9787700f8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -603,19 +603,19 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
-	int (*reset)(struct pci_dev *dev, int probe);
+	int (*reset)(struct pci_dev *dev, pci_reset_mode_t mode);
 };

 struct pci_reset_fn_method {
-	int (*reset_fn)(struct pci_dev *pdev, int probe);
+	int (*reset_fn)(struct pci_dev *pdev, pci_reset_mode_t mode);
 	char *name;
 };

 extern const struct pci_reset_fn_method pci_reset_fn_methods[];
 #ifdef CONFIG_PCI_QUIRKS
-int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t mode);
 #else
-static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+static inline int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	return -ENOTTY;
 }
@@ -704,9 +704,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
-int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
+int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t mode);
 #else
-static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t mode)
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
index 45a8c3caa..60fd101ac 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3681,7 +3681,7 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
  * not available.
  */
-static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
+static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	/*
 	 * http://www.intel.com/content/dam/doc/datasheet/82599-10-gbe-controller-datasheet.pdf
@@ -3691,7 +3691,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	 * Thus we must call pcie_flr() directly without first checking if it is
 	 * supported.
 	 */
-	if (!probe)
+	if (mode == PCI_RESET_DO_RESET)
 		pcie_flr(dev);
 	return 0;
 }
@@ -3703,13 +3703,13 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 #define NSDE_PWR_STATE		0xd0100
 #define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */

-static int reset_ivb_igd(struct pci_dev *dev, int probe)
+static int reset_ivb_igd(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	void __iomem *mmio_base;
 	unsigned long timeout;
 	u32 val;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	mmio_base = pci_iomap(dev, 0, 0);
@@ -3746,7 +3746,7 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 }

 /* Device-specific reset method for Chelsio T4-based adapters */
-static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
+static int reset_chelsio_generic_dev(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	u16 old_command;
 	u16 msix_flags;
@@ -3762,7 +3762,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 	 * If this is the "probe" phase, return 0 indicating that we can
 	 * reset this device.
 	 */
-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	/*
@@ -3824,17 +3824,17 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
  *    Chapter 3: NVMe control registers
  *    Chapter 7.3: Reset behavior
  */
-static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
+static int nvme_disable_and_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	void __iomem *bar;
 	u16 cmd;
 	u32 cfg;

 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
+	    pcie_reset_flr(dev, PCI_RESET_PROBE) || !pci_resource_start(dev, 0))
 		return -ENOTTY;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
@@ -3898,11 +3898,13 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  * device too soon after FLR.  A 250ms delay after FLR has heuristically
  * proven to produce reliably working results for device assignment cases.
  */
-static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
+static int delay_250ms_after_flr(struct pci_dev *dev, pci_reset_mode_t mode)
 {
-	int ret = pcie_reset_flr(dev, probe);
+	int ret;
+
+	ret = pcie_reset_flr(dev, mode);

-	if (probe)
+	if (ret || mode == PCI_RESET_PROBE)
 		return ret;

 	msleep(250);
@@ -3918,13 +3920,13 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 #define HINIC_OPERATION_TIMEOUT     15000	/* 15 seconds */

 /* Device-specific reset method for Huawei Intelligent NIC virtual functions */
-static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
+static int reset_hinic_vf_dev(struct pci_dev *pdev, pci_reset_mode_t mode)
 {
 	unsigned long timeout;
 	void __iomem *bar;
 	u32 val;

-	if (probe)
+	if (mode == PCI_RESET_PROBE)
 		return 0;

 	bar = pci_iomap(pdev, 0, 0);
@@ -3995,16 +3997,19 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
  * because when a host assigns a device to a guest VM, the host may need
  * to reset the device but probably doesn't have a driver for it.
  */
-int pci_dev_specific_reset(struct pci_dev *dev, int probe)
+int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t mode)
 {
 	const struct pci_dev_reset_methods *i;

+	if (mode >= PCI_RESET_MODE_MAX)
+		return -EINVAL;
+
 	for (i = pci_dev_reset_methods; i->reset; i++) {
 		if ((i->vendor == dev->vendor ||
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
 		     i->device == (u16)PCI_ANY_ID))
-			return i->reset(dev, probe);
+			return i->reset(dev, mode);
 	}

 	return -ENOTTY;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a7f063da2..c46df52e6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,6 +51,12 @@

 #define PCI_RESET_METHODS_NUM 6

+typedef enum pci_reset_mode {
+	PCI_RESET_DO_RESET,
+	PCI_RESET_PROBE,
+	PCI_RESET_MODE_MAX,
+} pci_reset_mode_t;
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -1230,7 +1236,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-int pcie_reset_flr(struct pci_dev *dev, int probe);
+int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t mode);
 int pcie_flr(struct pci_dev *dev);
 bool pci_reset_supported(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index b482e42d7..9e8da46e7 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -44,7 +44,7 @@ struct hotplug_slot_ops {
 	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
-	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
+	int (*reset_slot)		(struct hotplug_slot *slot, pci_reset_mode_t mode);
 };

 /**
--
2.31.1
