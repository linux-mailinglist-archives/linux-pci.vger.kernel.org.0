Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0723DC600
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhGaMti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Jul 2021 08:49:38 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:56783 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhGaMti (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jul 2021 08:49:38 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D252D3003F487;
        Sat, 31 Jul 2021 14:49:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C29D421C424; Sat, 31 Jul 2021 14:49:30 +0200 (CEST)
Message-Id: <251f4edcc04c14f873ff1c967bc686169cd07d2d.1627638184.git.lukas@wunner.de>
In-Reply-To: <cover.1627638184.git.lukas@wunner.de>
References: <cover.1627638184.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 31 Jul 2021 14:39:01 +0200
Subject: [PATCH 1/4] PCI: pciehp: Ignore Link Down/Up caused by error-induced
 Hot Reset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        "Oliver OHalloran" <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stuart Hayes reports that an error handled by DPC at a Root Port results
in pciehp gratuitously bringing down a subordinate hotplug port:

  RP -- UP -- DP -- UP -- DP (hotplug) -- EP

pciehp brings the slot down because the Link to the Endpoint goes down.
That is caused by a Hot Reset being propagated as a result of DPC.
Per PCIe Base Spec 5.0, section 6.6.1 "Conventional Reset":

  For a Switch, the following must cause a hot reset to be sent on all
  Downstream Ports: [...]

  * The Data Link Layer of the Upstream Port reporting DL_Down status.
    In Switches that support Link speeds greater than 5.0 GT/s, the
    Upstream Port must direct the LTSSM of each Downstream Port to the
    Hot Reset state, but not hold the LTSSMs in that state. This permits
    each Downstream Port to begin Link training immediately after its
    hot reset completes. This behavior is recommended for all Switches.

  * Receiving a hot reset on the Upstream Port.

Once DPC recovers, pcie_do_recovery() walks down the hierarchy and
invokes pcie_portdrv_slot_reset() to restore each port's config space.
At that point, a hotplug interrupt is signaled per PCIe Base Spec r5.0,
section 6.7.3.4 "Software Notification of Hot-Plug Events":

  If the Port is enabled for edge-triggered interrupt signaling using
  MSI or MSI-X, an interrupt message must be sent every time the logical
  AND of the following conditions transitions from FALSE to TRUE: [...]

  * The Hot-Plug Interrupt Enable bit in the Slot Control register is
    set to 1b.

  * At least one hot-plug event status bit in the Slot Status register
    and its associated enable bit in the Slot Control register are both
    set to 1b.

Prevent pciehp from gratuitously bringing down the slot by clearing the
error-induced Data Link Layer State Changed event before restoring
config space.  Afterwards, check whether the link has unexpectedly
failed to retrain and synthesize a DLLSC event if so.

Allow each pcie_port_service_driver (one of them being pciehp) to define
a slot_reset callback and re-use the existing pm_iter() function to
iterate over the callbacks.

Thereby, the Endpoint driver remains bound throughout error recovery and
may restore the device to working state.

Surprise removal during error recovery is detected through a Presence
Detect Changed event.  The hotplug port is expected to not signal that
event as a result of a Hot Reset.

The issue isn't DPC-specific, it also occurs when an error is handled by
AER through aer_root_reset().  So while the issue was noticed only now,
it's been around since 2006 when AER support was first introduced.

Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
Link: https://lore.kernel.org/linux-pci/08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com/
Reported-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.19+: ba952824e6c1: PCI/portdrv: Report reset for frozen channel
Cc: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/Kconfig               |  3 +++
 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_core.c |  4 ++++
 drivers/pci/hotplug/pciehp_hpc.c  | 28 ++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h        |  2 ++
 drivers/pci/pcie/portdrv_core.c   | 20 ++++++++++----------
 drivers/pci/pcie/portdrv_pci.c    |  3 +++
 7 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..a295d3c48927 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -182,6 +182,9 @@ config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
 
+config PCI_ERROR_RECOVERY
+	def_bool PCIEAER || EEH
+
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
 	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index d4a930881054..7f24fe30a898 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -189,6 +189,8 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
+int pciehp_slot_reset(struct pcie_device *dev);
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ad3393930ecb..46a62237dcc8 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -351,6 +351,10 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.runtime_suspend = pciehp_runtime_suspend,
 	.runtime_resume	= pciehp_runtime_resume,
 #endif	/* PM */
+
+#ifdef	CONFIG_PCI_ERROR_RECOVERY
+	.slot_reset	= pciehp_slot_reset,
+#endif
 };
 
 int __init pcie_hp_init(void)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 9d06939736c0..72ef22d0c2c9 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -862,6 +862,34 @@ void pcie_disable_interrupt(struct controller *ctrl)
 	pcie_write_cmd(ctrl, 0, mask);
 }
 
+#ifdef CONFIG_PCI_ERROR_RECOVERY
+/**
+ * pciehp_slot_reset() - ignore link event caused by error-induced hot reset
+ * @dev: PCI Express port service device
+ *
+ * Called from pcie_portdrv_slot_reset() after AER or DPC initiated a reset
+ * further up in the hierarchy to recover from an error.  The reset was
+ * propagated down to this hotplug port.  Ignore the resulting link flap.
+ * If the link failed to retrain successfully, synthesize the ignored event.
+ * Surprise removal during reset is detected through Presence Detect Changed.
+ */
+int pciehp_slot_reset(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+
+	if (ctrl->state != ON_STATE)
+		return 0;
+
+	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
+				   PCI_EXP_SLTSTA_DLLSC);
+
+	if (!pciehp_check_link_active(ctrl))
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
+
+	return 0;
+}
+#endif
+
 /*
  * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
  * bus reset of the bridge, but at the same time we want to ensure that it is
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 2ff5724b8f13..92a776d211ec 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -85,6 +85,7 @@ struct pcie_port_service_driver {
 	int (*runtime_suspend)(struct pcie_device *dev);
 	int (*runtime_resume)(struct pcie_device *dev);
 
+	int (*slot_reset)(struct pcie_device *dev);
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
 
@@ -110,6 +111,7 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 
 extern struct bus_type pcie_port_bus_type;
 int pcie_port_device_register(struct pci_dev *dev);
+int pcie_port_device_iter(struct device *dev, void *data);
 #ifdef CONFIG_PM
 int pcie_port_device_suspend(struct device *dev);
 int pcie_port_device_resume_noirq(struct device *dev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed6649c41..ebcec7daa245 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -362,24 +362,24 @@ int pcie_port_device_register(struct pci_dev *dev)
 	return status;
 }
 
-#ifdef CONFIG_PM
-typedef int (*pcie_pm_callback_t)(struct pcie_device *);
+typedef int (*pcie_callback_t)(struct pcie_device *);
 
-static int pm_iter(struct device *dev, void *data)
+int pcie_port_device_iter(struct device *dev, void *data)
 {
 	struct pcie_port_service_driver *service_driver;
 	size_t offset = *(size_t *)data;
-	pcie_pm_callback_t cb;
+	pcie_callback_t cb;
 
 	if ((dev->bus == &pcie_port_bus_type) && dev->driver) {
 		service_driver = to_service_driver(dev->driver);
-		cb = *(pcie_pm_callback_t *)((void *)service_driver + offset);
+		cb = *(pcie_callback_t *)((void *)service_driver + offset);
 		if (cb)
 			return cb(to_pcie_device(dev));
 	}
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /**
  * pcie_port_device_suspend - suspend port services associated with a PCIe port
  * @dev: PCI Express port to handle
@@ -387,13 +387,13 @@ static int pm_iter(struct device *dev, void *data)
 int pcie_port_device_suspend(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, suspend);
-	return device_for_each_child(dev, &off, pm_iter);
+	return device_for_each_child(dev, &off, pcie_port_device_iter);
 }
 
 int pcie_port_device_resume_noirq(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, resume_noirq);
-	return device_for_each_child(dev, &off, pm_iter);
+	return device_for_each_child(dev, &off, pcie_port_device_iter);
 }
 
 /**
@@ -403,7 +403,7 @@ int pcie_port_device_resume_noirq(struct device *dev)
 int pcie_port_device_resume(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, resume);
-	return device_for_each_child(dev, &off, pm_iter);
+	return device_for_each_child(dev, &off, pcie_port_device_iter);
 }
 
 /**
@@ -413,7 +413,7 @@ int pcie_port_device_resume(struct device *dev)
 int pcie_port_device_runtime_suspend(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, runtime_suspend);
-	return device_for_each_child(dev, &off, pm_iter);
+	return device_for_each_child(dev, &off, pcie_port_device_iter);
 }
 
 /**
@@ -423,7 +423,7 @@ int pcie_port_device_runtime_suspend(struct device *dev)
 int pcie_port_device_runtime_resume(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, runtime_resume);
-	return device_for_each_child(dev, &off, pm_iter);
+	return device_for_each_child(dev, &off, pcie_port_device_iter);
 }
 #endif /* PM */
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index c7ff1eea225a..1af74c3d9d5d 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -160,6 +160,9 @@ static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
 
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
+	size_t off = offsetof(struct pcie_port_service_driver, slot_reset);
+	device_for_each_child(&dev->dev, &off, pcie_port_device_iter);
+
 	pci_restore_state(dev);
 	pci_save_state(dev);
 	return PCI_ERS_RESULT_RECOVERED;
-- 
2.31.1

