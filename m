Return-Path: <linux-pci+bounces-2718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFC8403EB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 12:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D58282400
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9586C14AB2;
	Mon, 29 Jan 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOw95HYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4A1E48C;
	Mon, 29 Jan 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528241; cv=none; b=CrF8aa1MmZIYpE9EbN6ZotuiveFVeKuU9a6NW82CtQX77LD43zzw9lmIkhQdqrpUQRXUmyQrPrGPq1r6e+yemfdTdWVnRQECvCInyCVe/uqg0DHWHxRneNO8Lt3vOJKor/cbUzq6WsBQehxNShjyWfQgShDcJDOVM0Drm5D99rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528241; c=relaxed/simple;
	bh=n+P7qHJEIq2V70wnllFn/3PAXvuly6wK/oDSQT7vCsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mhl19eEjdYZ4DXoP1+OvaE6CVy7XHe73JnIi+R+Ug57dNprRNl/APsIOHVOhb75AhBLfyq4dUVxOSAJ2cDk0F1J9QZAgePywNkayD0OuQnx9RSLNaA9L9q7mbY6afN0X7Yd7x0kw1Wn1ZrOdlj+3mjr0nQqb/aPwD+bfOUTXiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOw95HYh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706528239; x=1738064239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n+P7qHJEIq2V70wnllFn/3PAXvuly6wK/oDSQT7vCsk=;
  b=YOw95HYhkg7o4gTjySIHvAXNBjWvKo0alHM/mwhcRAE30CCwWz/n2IcA
   wC4F/fpLvggjKJR9wzx/JTH5ceHWual2hxPnzl7iyDPMHmBM/ba5FTqQF
   VifbhmNsATW/5PRkPIwe2ebEBu1nzeGuHMN9Fg/DUHCnfef5o9OubcoGm
   UZiklgH2+vM+/DkYhzY5tJfW5O+kjsLDFMHfeJut4eeM0A+uAZiQ7Zyqa
   d0/TR5S389rysOqeobfB39PpjgShKKQOyvOsPMXPb+3t1ln75WzJ6+48i
   ybR55Zlwej2ZD1lvSEhArk6Xypa7U8pvRW+l8H85QfdYQ7TmEKfDB4ZF2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9672538"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="9672538"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:37:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960869964"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="960869964"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.253.213])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:37:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Place interrupt related code into irq.c
Date: Mon, 29 Jan 2024 13:36:54 +0200
Message-Id: <20240129113655.3368-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Interrupt related code is spread into irq.c, pci.c, and setup-irq.c.
Group them into pre-existing irq.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/Makefile     |   2 +-
 drivers/pci/irq.c        | 204 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c |   9 --
 drivers/pci/pci.c        | 144 ---------------------------
 drivers/pci/setup-irq.c  |  64 ------------
 5 files changed, 205 insertions(+), 218 deletions(-)
 delete mode 100644 drivers/pci/setup-irq.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..54a7adf0bb88 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
 				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
-				   setup-bus.o vc.o mmap.o setup-irq.o
+				   setup-bus.o vc.o mmap.o
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index 0050e8f6814e..4555630be9ec 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -8,9 +8,13 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 
+#include "pci.h"
+
 /**
  * pci_request_irq - allocate an interrupt line for a PCI device
  * @dev:	PCI device to operate on
@@ -74,3 +78,203 @@ void pci_free_irq(struct pci_dev *dev, unsigned int nr, void *dev_id)
 	kfree(free_irq(pci_irq_vector(dev, nr), dev_id));
 }
 EXPORT_SYMBOL(pci_free_irq);
+
+/**
+ * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
+ * @dev: the PCI device
+ * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
+ *
+ * Perform INTx swizzling for a device behind one level of bridge.  This is
+ * required by section 9.1 of the PCI-to-PCI bridge specification for devices
+ * behind bridges on add-in cards.  For devices with ARI enabled, the slot
+ * number is always 0 (see the Implementation Note in section 2.2.8.1 of
+ * the PCI Express Base Specification, Revision 2.1)
+ */
+u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin)
+{
+	int slot;
+
+	if (pci_ari_enabled(dev->bus))
+		slot = 0;
+	else
+		slot = PCI_SLOT(dev->devfn);
+
+	return (((pin - 1) + slot) % 4) + 1;
+}
+
+int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
+{
+	u8 pin;
+
+	pin = dev->pin;
+	if (!pin)
+		return -1;
+
+	while (!pci_is_root_bus(dev->bus)) {
+		pin = pci_swizzle_interrupt_pin(dev, pin);
+		dev = dev->bus->self;
+	}
+	*bridge = dev;
+	return pin;
+}
+
+/**
+ * pci_common_swizzle - swizzle INTx all the way to root bridge
+ * @dev: the PCI device
+ * @pinp: pointer to the INTx pin value (1=INTA, 2=INTB, 3=INTD, 4=INTD)
+ *
+ * Perform INTx swizzling for a device.  This traverses through all PCI-to-PCI
+ * bridges all the way up to a PCI root bus.
+ */
+u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
+{
+	u8 pin = *pinp;
+
+	while (!pci_is_root_bus(dev->bus)) {
+		pin = pci_swizzle_interrupt_pin(dev, pin);
+		dev = dev->bus->self;
+	}
+	*pinp = pin;
+	return PCI_SLOT(dev->devfn);
+}
+EXPORT_SYMBOL_GPL(pci_common_swizzle);
+
+void pci_assign_irq(struct pci_dev *dev)
+{
+	u8 pin;
+	u8 slot = -1;
+	int irq = 0;
+	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
+
+	if (!(hbrg->map_irq)) {
+		pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
+		return;
+	}
+
+	/*
+	 * If this device is not on the primary bus, we need to figure out
+	 * which interrupt pin it will come in on. We know which slot it
+	 * will come in on because that slot is where the bridge is. Each
+	 * time the interrupt line passes through a PCI-PCI bridge we must
+	 * apply the swizzle function.
+	 */
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	/* Cope with illegal. */
+	if (pin > 4)
+		pin = 1;
+
+	if (pin) {
+		/* Follow the chain of bridges, swizzling as we go. */
+		if (hbrg->swizzle_irq)
+			slot = (*(hbrg->swizzle_irq))(dev, &pin);
+
+		/*
+		 * If a swizzling function is not used, map_irq() must
+		 * ignore slot.
+		 */
+		irq = (*(hbrg->map_irq))(dev, slot, pin);
+		if (irq == -1)
+			irq = 0;
+	}
+	dev->irq = irq;
+
+	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
+
+	/*
+	 * Always tell the device, so the driver knows what is the real IRQ
+	 * to use; the device does not use it.
+	 */
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
+}
+
+static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
+{
+	struct pci_bus *bus = dev->bus;
+	bool mask_updated = true;
+	u32 cmd_status_dword;
+	u16 origcmd, newcmd;
+	unsigned long flags;
+	bool irq_pending;
+
+	/*
+	 * We do a single dword read to retrieve both command and status.
+	 * Document assumptions that make this possible.
+	 */
+	BUILD_BUG_ON(PCI_COMMAND % 4);
+	BUILD_BUG_ON(PCI_COMMAND + 2 != PCI_STATUS);
+
+	raw_spin_lock_irqsave(&pci_lock, flags);
+
+	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
+
+	irq_pending = (cmd_status_dword >> 16) & PCI_STATUS_INTERRUPT;
+
+	/*
+	 * Check interrupt status register to see whether our device
+	 * triggered the interrupt (when masking) or the next IRQ is
+	 * already pending (when unmasking).
+	 */
+	if (mask != irq_pending) {
+		mask_updated = false;
+		goto done;
+	}
+
+	origcmd = cmd_status_dword;
+	newcmd = origcmd & ~PCI_COMMAND_INTX_DISABLE;
+	if (mask)
+		newcmd |= PCI_COMMAND_INTX_DISABLE;
+	if (newcmd != origcmd)
+		bus->ops->write(bus, dev->devfn, PCI_COMMAND, 2, newcmd);
+
+done:
+	raw_spin_unlock_irqrestore(&pci_lock, flags);
+
+	return mask_updated;
+}
+
+/**
+ * pci_check_and_mask_intx - mask INTx on pending interrupt
+ * @dev: the PCI device to operate on
+ *
+ * Check if the device dev has its INTx line asserted, mask it and return
+ * true in that case. False is returned if no interrupt was pending.
+ */
+bool pci_check_and_mask_intx(struct pci_dev *dev)
+{
+	return pci_check_and_set_intx_mask(dev, true);
+}
+EXPORT_SYMBOL_GPL(pci_check_and_mask_intx);
+
+/**
+ * pci_check_and_unmask_intx - unmask INTx if no interrupt is pending
+ * @dev: the PCI device to operate on
+ *
+ * Check if the device dev has its INTx line asserted, unmask it if not and
+ * return true. False is returned and the mask remains active if there was
+ * still an interrupt pending.
+ */
+bool pci_check_and_unmask_intx(struct pci_dev *dev)
+{
+	return pci_check_and_set_intx_mask(dev, false);
+}
+EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
+
+/**
+ * pcibios_penalize_isa_irq - penalize an ISA IRQ
+ * @irq: ISA IRQ to penalize
+ * @active: IRQ active or not
+ *
+ * Permits the platform to provide architecture-specific functionality when
+ * penalizing ISA IRQs. This is the default implementation. Architecture
+ * implementations can override this.
+ */
+void __weak pcibios_penalize_isa_irq(int irq, int active) {}
+
+int __weak pcibios_alloc_irq(struct pci_dev *dev)
+{
+	return 0;
+}
+
+void __weak pcibios_free_irq(struct pci_dev *dev)
+{
+}
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..ec838f2e892e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -419,15 +419,6 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	return error;
 }
 
-int __weak pcibios_alloc_irq(struct pci_dev *dev)
-{
-	return 0;
-}
-
-void __weak pcibios_free_irq(struct pci_dev *dev)
-{
-}
-
 #ifdef CONFIG_PCI_IOV
 static inline bool pci_device_can_probe(struct pci_dev *pdev)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..75388584e60d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -24,7 +24,6 @@
 #include <linux/log2.h>
 #include <linux/logic_pio.h>
 #include <linux/pm_wakeup.h>
-#include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
@@ -2292,17 +2291,6 @@ void __weak pcibios_release_device(struct pci_dev *dev) {}
  */
 void __weak pcibios_disable_device(struct pci_dev *dev) {}
 
-/**
- * pcibios_penalize_isa_irq - penalize an ISA IRQ
- * @irq: ISA IRQ to penalize
- * @active: IRQ active or not
- *
- * Permits the platform to provide architecture-specific functionality when
- * penalizing ISA IRQs. This is the default implementation. Architecture
- * implementations can override this.
- */
-void __weak pcibios_penalize_isa_irq(int irq, int active) {}
-
 static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
@@ -3964,66 +3952,6 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 }
 EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
 
-/**
- * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
- * @dev: the PCI device
- * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
- *
- * Perform INTx swizzling for a device behind one level of bridge.  This is
- * required by section 9.1 of the PCI-to-PCI bridge specification for devices
- * behind bridges on add-in cards.  For devices with ARI enabled, the slot
- * number is always 0 (see the Implementation Note in section 2.2.8.1 of
- * the PCI Express Base Specification, Revision 2.1)
- */
-u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin)
-{
-	int slot;
-
-	if (pci_ari_enabled(dev->bus))
-		slot = 0;
-	else
-		slot = PCI_SLOT(dev->devfn);
-
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
-int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
-{
-	u8 pin;
-
-	pin = dev->pin;
-	if (!pin)
-		return -1;
-
-	while (!pci_is_root_bus(dev->bus)) {
-		pin = pci_swizzle_interrupt_pin(dev, pin);
-		dev = dev->bus->self;
-	}
-	*bridge = dev;
-	return pin;
-}
-
-/**
- * pci_common_swizzle - swizzle INTx all the way to root bridge
- * @dev: the PCI device
- * @pinp: pointer to the INTx pin value (1=INTA, 2=INTB, 3=INTD, 4=INTD)
- *
- * Perform INTx swizzling for a device.  This traverses through all PCI-to-PCI
- * bridges all the way up to a PCI root bus.
- */
-u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
-{
-	u8 pin = *pinp;
-
-	while (!pci_is_root_bus(dev->bus)) {
-		pin = pci_swizzle_interrupt_pin(dev, pin);
-		dev = dev->bus->self;
-	}
-	*pinp = pin;
-	return PCI_SLOT(dev->devfn);
-}
-EXPORT_SYMBOL_GPL(pci_common_swizzle);
-
 /**
  * pci_release_region - Release a PCI bar
  * @pdev: PCI device whose resources were previously reserved by
@@ -4737,78 +4665,6 @@ void pci_intx(struct pci_dev *pdev, int enable)
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
-static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
-{
-	struct pci_bus *bus = dev->bus;
-	bool mask_updated = true;
-	u32 cmd_status_dword;
-	u16 origcmd, newcmd;
-	unsigned long flags;
-	bool irq_pending;
-
-	/*
-	 * We do a single dword read to retrieve both command and status.
-	 * Document assumptions that make this possible.
-	 */
-	BUILD_BUG_ON(PCI_COMMAND % 4);
-	BUILD_BUG_ON(PCI_COMMAND + 2 != PCI_STATUS);
-
-	raw_spin_lock_irqsave(&pci_lock, flags);
-
-	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
-
-	irq_pending = (cmd_status_dword >> 16) & PCI_STATUS_INTERRUPT;
-
-	/*
-	 * Check interrupt status register to see whether our device
-	 * triggered the interrupt (when masking) or the next IRQ is
-	 * already pending (when unmasking).
-	 */
-	if (mask != irq_pending) {
-		mask_updated = false;
-		goto done;
-	}
-
-	origcmd = cmd_status_dword;
-	newcmd = origcmd & ~PCI_COMMAND_INTX_DISABLE;
-	if (mask)
-		newcmd |= PCI_COMMAND_INTX_DISABLE;
-	if (newcmd != origcmd)
-		bus->ops->write(bus, dev->devfn, PCI_COMMAND, 2, newcmd);
-
-done:
-	raw_spin_unlock_irqrestore(&pci_lock, flags);
-
-	return mask_updated;
-}
-
-/**
- * pci_check_and_mask_intx - mask INTx on pending interrupt
- * @dev: the PCI device to operate on
- *
- * Check if the device dev has its INTx line asserted, mask it and return
- * true in that case. False is returned if no interrupt was pending.
- */
-bool pci_check_and_mask_intx(struct pci_dev *dev)
-{
-	return pci_check_and_set_intx_mask(dev, true);
-}
-EXPORT_SYMBOL_GPL(pci_check_and_mask_intx);
-
-/**
- * pci_check_and_unmask_intx - unmask INTx if no interrupt is pending
- * @dev: the PCI device to operate on
- *
- * Check if the device dev has its INTx line asserted, unmask it if not and
- * return true. False is returned and the mask remains active if there was
- * still an interrupt pending.
- */
-bool pci_check_and_unmask_intx(struct pci_dev *dev)
-{
-	return pci_check_and_set_intx_mask(dev, false);
-}
-EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
-
 /**
  * pci_wait_for_pending_transaction - wait for pending transaction
  * @dev: the PCI device to operate on
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
deleted file mode 100644
index cc7d26b015f3..000000000000
--- a/drivers/pci/setup-irq.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Support routines for initializing a PCI subsystem
- *
- * Extruded from code written by
- *      Dave Rusling (david.rusling@reo.mts.dec.com)
- *      David Mosberger (davidm@cs.arizona.edu)
- *	David Miller (davem@redhat.com)
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/cache.h>
-#include "pci.h"
-
-void pci_assign_irq(struct pci_dev *dev)
-{
-	u8 pin;
-	u8 slot = -1;
-	int irq = 0;
-	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
-
-	if (!(hbrg->map_irq)) {
-		pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
-		return;
-	}
-
-	/*
-	 * If this device is not on the primary bus, we need to figure out
-	 * which interrupt pin it will come in on. We know which slot it
-	 * will come in on because that slot is where the bridge is. Each
-	 * time the interrupt line passes through a PCI-PCI bridge we must
-	 * apply the swizzle function.
-	 */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	/* Cope with illegal. */
-	if (pin > 4)
-		pin = 1;
-
-	if (pin) {
-		/* Follow the chain of bridges, swizzling as we go. */
-		if (hbrg->swizzle_irq)
-			slot = (*(hbrg->swizzle_irq))(dev, &pin);
-
-		/*
-		 * If a swizzling function is not used, map_irq() must
-		 * ignore slot.
-		 */
-		irq = (*(hbrg->map_irq))(dev, slot, pin);
-		if (irq == -1)
-			irq = 0;
-	}
-	dev->irq = irq;
-
-	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
-
-	/*
-	 * Always tell the device, so the driver knows what is the real IRQ
-	 * to use; the device does not use it.
-	 */
-	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
-}
-- 
2.39.2


