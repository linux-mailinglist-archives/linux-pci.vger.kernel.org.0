Return-Path: <linux-pci+bounces-37524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD580BB64C3
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 677654E276F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D7281376;
	Fri,  3 Oct 2025 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="KDDwukY6"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B828150F;
	Fri,  3 Oct 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482239; cv=none; b=ezcbLtdj/ptqHnXi5Q16XHiXzIWuAmhny9WCNsDQoZC26RFbz7cppcJkEhCyKNRHjNGicSlYtqyusF3a2uP57hI9ozP1GAjARRm09htodjuVXlmsRtcYxp8GTFpP4YpVnXBHwZJ20+AqPiA5oLao620E2BB9AwHGut6kfEt7Voc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482239; c=relaxed/simple;
	bh=YUIXWB9DQpkrQk4uATLGgMYEq0Q2/OSHXmRDBN8np6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9PRNIi2Xi+P3B9H/7Vx6F3Y7wfRp4Y9dy+DzYBE200N+zvPWQYBGigthlktMzB2UVXtShs9g5wbLmsZ1bSVCEKZ8kcffHApY21g5ZulqAwioyY2BkFKagzU1Nf325OCplwk4g8sphNlsWKVzQpXEfZ4WSgt0P+KoWxxtfKjKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=KDDwukY6; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482237; x=1791018237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Mvwx7/lH7MVq6cdziprtPczRXASQRPlRUci+PHX/9w=;
  b=KDDwukY62IKgrBL423ocvq4gLQ3o87xILNLA+USF+bwlzegOXOgaTtvr
   VzRms54muyRySYPoVnm3rzVjnM2oBoPGpaccwIR8Xvn6y6FlW3+khE/5Z
   T58yL4vCM2vOFLxWUsC+C6UmW2ES0W1HDtFCisVK8V8v0t3NXIonW71gb
   PAvSctz+8BJ+oGheIo7/Hh6fw3WlKRju+MDbBZxaL+zRe6LgZXuecvKya
   NGIHqUvhohvpqYxtLB9TwkAWwT57ojm9p7soD31nOx+vlKNXMyBlQDVR7
   AxkSQzung3jVzCLNwgwV/xqMIhhiBb2golexPl0gbXSRQSnZimoC5Pun3
   w==;
X-CSE-ConnectionGUID: +lIA1xYvRnynGPZfiLR4Eg==
X-CSE-MsgGUID: rVagEA40RwuFBQnOSMwBMg==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4203485"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:03:55 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:63163]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.71:2525] with esmtp (Farcaster)
 id 97b22730-fdc0-482d-b08f-52743c9bdbae; Fri, 3 Oct 2025 09:03:55 +0000 (UTC)
X-Farcaster-Flow-ID: 97b22730-fdc0-482d-b08f-52743c9bdbae
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:03:54 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:03:52 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 06/13] pci: pcsc: handle device resets
Date: Fri, 3 Oct 2025 09:00:42 +0000
Message-ID: <0fa6f46439b535eedaa82c360e1ea19e7f052fca.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PCI Configuration Space Cache (PCSC) maintains cached values of
configuration space registers for performance optimization. When a PCI
device is reset or bus operations are dynamically changed, cached values
become stale and can cause incorrect behavior. This patch ensures cache
coherency by invalidating the PCSC cache in all scenarios where the
underlying configuration space values may have changed.

Device Reset Handling:
----------------------
When PCI devices are reset, their configuration space registers return
to default values. Add pcsc_device_reset() calls after all device reset
operations to invalidate stale cached values:

- Function Level Resets (FLR) in `pcie_flr()`
- Advanced Features FLR in `pci_af_flr()`
- Power Management resets (D3hot->D0 transition) in `pci_pm_reset()`
- Device-specific resets in `pci_dev_specific_reset()`
- D3cold power state transitions in `__pci_set_power_state()`
- ACPI-based resets in `pci_dev_acpi_reset()`
- Bus restore operations in `pci_bus_restore_locked()`
- Slot restore operations in `pci_slot_restore_locked()`
- Secondary bus resets in `pci_bridge_secondary_bus_reset()`

For secondary bus resets, `pcsc_reset_bus_recursively()` invalidates the
cache for all devices on the secondary bus and subordinate buses. This
also covers hotplug slot reset operations since `pciehp_reset_slot()`
calls `pci_bridge_secondary_bus_reset()`.

In addition, functions like `pci_dev_wait` are configured to bypass the
cahce and reads the actual HW values.

Dynamic Ops Changes:
--------------------
The patch also addresses cache consistency issues when bus operations
are dynamically changed via `pci_bus_set_ops()``. Different ops
implementations may return different values for the same registers, and
hardware state may have changed while using the different ops. This
commit resets the cache for all devices on the affected bus

Implementation Details:
-----------------------
The cache invalidation clears the cached_bitmask while preserving the
cacheable_bitmask, as the configuration space layout remains unchanged
after a reset. This allows the cache to be repopulated with fresh values
on subsequent configuration space accesses.

Known Limitations:
------------------
- There is currently a gap in handling PowerPC secondary bus resets, as
the architecture-specific `pcibios_reset_secondary_bus()` can bypass the
generic `pci_reset_secondary_bus()` where our cache invalidation occurs.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/access.c   | 13 ++++++---
 drivers/pci/pci-acpi.c |  4 +++
 drivers/pci/pci.c      | 60 +++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pcsc.c     | 17 ++++++++++++
 drivers/pci/quirks.c   |  7 ++++-
 include/linux/pcsc.h   | 11 ++++++++
 6 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b89e9210d330..0a5de8d76bfe 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -245,11 +245,16 @@ struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops)
 		/*
 		 * IMPORTANT: Dynamic ops changes after PCSC injection can lead to
 		 * cache consistency issues if operations were performed that should
-		 * have invalidated the cache. We re-inject PCSC ops here, but the
-		 * caller is responsible for ensuring cache consistency if needed.
-		 * This will be fixed in a future commit, when PCSC resets are
-		 * introduced.
+		 * have invalidated the cache. We must reset the cache for all
+		 * devices on this bus to ensure consistency. (No need for recursive
+		 * reset on subordinate buses)
 		 */
+		struct pci_dev *dev;
+
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			if (dev->pcsc && dev->pcsc->cached_bitmask)
+				bitmap_zero(dev->pcsc->cached_bitmask, PCSC_CFG_SPC_SIZE);
+		}
 
 		pr_warn("PCSC: Dynamic ops change detected on bus %04x:%02x, resetting cache\n",
 			pci_domain_nr(bus), bus->number);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9369377725fa..0b638115c7c7 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -983,6 +983,10 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 		return -ENOTTY;
 	}
 
+#ifdef CONFIG_PCSC
+	pcsc_device_reset(dev);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f518cfa266b5..db940f8fd408 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
+#include <linux/pcsc.h>
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
@@ -1248,11 +1249,19 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 		}
 
 		if (root && root->config_rrs_sv) {
+#ifdef CONFIG_PCSC
+			pcsc_hw_config_read(dev->bus, dev->devfn, PCI_VENDOR_ID, 4, &id);
+#else
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+#endif
 			if (!pci_bus_rrs_vendor_id(id))
 				break;
 		} else {
+#ifdef CONFIG_PCSC
+			pcsc_hw_config_read(dev->bus, dev->devfn, PCI_COMMAND, 4, &id);
+#else
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
+#endif
 			if (!PCI_POSSIBLE_ERROR(id))
 				break;
 		}
@@ -1564,7 +1573,9 @@ static int __pci_set_power_state(struct pci_dev *dev, pci_power_t state, bool lo
 
 		if (pci_platform_power_transition(dev, PCI_D3cold))
 			return error;
-
+	#ifdef CONFIG_PCSC
+		pcsc_device_reset(dev);
+	#endif
 		/* Powering off a bridge may power off the whole hierarchy */
 		if (dev->current_state == PCI_D3cold)
 			__pci_bus_set_current_state(dev->subordinate, PCI_D3cold, locked);
@@ -4493,6 +4504,10 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
+#ifdef CONFIG_PCSC
+	pcsc_device_reset(dev);
+#endif
+
 	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4560,6 +4575,10 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	 */
 	msleep(100);
 
+#ifdef CONFIG_PCSC
+	pcsc_device_reset(dev);
+#endif
+
 	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 }
 
@@ -4605,6 +4624,10 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
+#ifdef CONFIG_PCSC
+	pcsc_device_reset(dev);
+#endif
+
 	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
 }
 
@@ -4904,6 +4927,31 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 			    PCIE_RESET_READY_POLL_MS - delay);
 }
 
+#ifdef CONFIG_PCSC
+/**
+ * pcsc_reset_bus_recursively - Recursively reset PCSC cache for all devices
+ * in bus hierarchy
+ * @bus: PCI bus to process
+ *
+ * Recursively invalidate PCSC cache for all devices on the given bus
+ * and all subordinate buses.
+ */
+static void pcsc_reset_bus_recursively(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (!bus)
+		return;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pcsc_device_reset(dev);
+		/* If this device is a bridge, recursively process its subordinate bus */
+		if (dev->subordinate)
+			pcsc_reset_bus_recursively(dev->subordinate);
+	}
+}
+#endif
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
@@ -4920,6 +4968,10 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+
+#ifdef CONFIG_PCSC
+	pcsc_reset_bus_recursively(dev->subordinate);
+#endif
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
@@ -5542,6 +5594,9 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_dev_restore(dev);
+#ifdef CONFIG_PCSC
+		pcsc_device_reset(dev);
+#endif
 		if (dev->subordinate) {
 			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
 			pci_bus_restore_locked(dev->subordinate);
@@ -5579,6 +5634,9 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		pci_dev_restore(dev);
+#ifdef CONFIG_PCSC
+		pcsc_device_reset(dev);
+#endif
 		if (dev->subordinate) {
 			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
 			pci_bus_restore_locked(dev->subordinate);
diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 44d842733230..5412dea23446 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -837,6 +837,23 @@ int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
 }
 EXPORT_SYMBOL_GPL(pcsc_cached_config_write);
 
+int pcsc_device_reset(struct pci_dev *dev)
+{
+	if (unlikely((!dev)))
+		return -EINVAL;
+
+	if (unlikely(!pcsc_is_initialised()))
+		return 0;
+
+	/* The layout of the CFG Space is not going to change after a device
+	 * reset, whether the reset is FLR or conventional. Only the values
+	 * are going to change. We could further optimise the cache to maintain
+	 * some of the HWInt values that are going to remain constant after a reset.
+	 */
+	bitmap_zero(dev->pcsc->cached_bitmask, PCSC_CFG_SPC_SIZE);
+	return 0;
+}
+
 static struct pci_ops pcsc_ops = {
 	.add_bus = pcsc_add_bus,
 	.remove_bus = pcsc_remove_bus,
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6eb3d20386e9..97555fbba938 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4239,8 +4239,13 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 		if ((i->vendor == dev->vendor ||
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
-		     i->device == (u16)PCI_ANY_ID))
+		     i->device == (u16)PCI_ANY_ID)) {
+#ifdef CONFIG_PCSC
+			if (!probe)
+				pcsc_device_reset(dev);
+#endif
 			return i->reset(dev, probe);
+		}
 	}
 
 	return -ENOTTY;
diff --git a/include/linux/pcsc.h b/include/linux/pcsc.h
index 516d73931608..85471273c0a9 100644
--- a/include/linux/pcsc.h
+++ b/include/linux/pcsc.h
@@ -121,4 +121,15 @@ int pcsc_remove_device(struct pci_dev *dev);
  */
 bool pcsc_is_initialised(void);
 
+/**
+ * pcsc_device_reset - Handle PCI device reset
+ * @dev: PCI device being reset
+ *
+ * This function should be called when a PCI device is being reset
+ * to ensure the cache is properly invalidated.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int pcsc_device_reset(struct pci_dev *dev);
+
 #endif /* _LINUX_PCSC_H */
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


