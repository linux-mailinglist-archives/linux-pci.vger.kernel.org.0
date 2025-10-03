Return-Path: <linux-pci+bounces-37519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F4BB647B
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FE94344AC4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC927F4D5;
	Fri,  3 Oct 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="p+Ftlmij"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A835275860;
	Fri,  3 Oct 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482111; cv=none; b=oDE7Vb4OBu0l2Fpdx5gfiL6AJrMjO56+d1oyWiGRRUoIiiTy2gtrWljCSn2MGJQi3BARyYcmY8tW57xl69X4fd3FsdMU57QRhUz6B1Nk0LOhfsY1cv7tq1wP9BdYgSSZN82w7myBBgQZgdBRRTMfcYZdpcnn2MFe7iOWO51+ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482111; c=relaxed/simple;
	bh=1Mjt8IXBt8f6Mhe+VfcjXU6q0F0NTRgXpDiZCPaONLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItIuTGzZXdibJpWW9eDL/5KySCWkDxe3sc3ruwr6UITV+m5//A8IQfvDhyh8C5+gEcNmmMsTKQMk1y4Ge1iqYru/sF5nRlHNQuVagwKTUFskiMKwT2YTH7N9D+da6ALZ9jvp6jLWqbtu9XZF2DV15QpfWUMEptlza6ecJ5VUGR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=p+Ftlmij; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482109; x=1791018109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4ijJ021O6Jl00VOy/IsHrHY4ShgXRWyy/Q296Dl1D8=;
  b=p+Ftlmij/3ethZZM1eGkgqBwAvNnOEgeWdrEaIC9Mq/B8qOSG5slkTgs
   yokM6a18bR8rIrEUAd/C/cyeoeCYBe8rD11l0oCN8TZngtnUEXcpB07NX
   p7Uz6FoZAiFBXgfV7iMt6B6RRfCciNyqo6NQxFqsH7iJUv1n+ipZ6ODX3
   8SqGfpt2pkUnWHDOeW+5yzcGNoOngxnn0TiQEO2Q2jBm9HnaUy0BtwWP+
   WP4wAg9QXNGOmTERsfzr6XblrRbbWpRoXefkZAeLQOzSL5jE2R6Yg6kuR
   TIF7+29Fzn8FWoiIRA5cMdAmrzJah/rPF3ZhtMvZO15OiWGIch6ylwyWV
   w==;
X-CSE-ConnectionGUID: IUUx5IXdSKaFBlcCyvINtQ==
X-CSE-MsgGUID: KIDT40C7SVOC9NKKnRQ6Vg==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4214776"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:01:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:43651]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.112:2525] with esmtp (Farcaster)
 id 3d6eac18-9bf1-44d8-9ac7-a134f3d0e68e; Fri, 3 Oct 2025 09:01:47 +0000 (UTC)
X-Farcaster-Flow-ID: 3d6eac18-9bf1-44d8-9ac7-a134f3d0e68e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:01:47 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:01:44 +0000
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
Subject: [RFC PATCH 01/13] pci: pcsc: Add plumbing for the PCI Configuration Space Cache (PCSC)
Date: Fri, 3 Oct 2025 09:00:37 +0000
Message-ID: <ecfa9cca72b51e20505093e145246054e91fe9a4.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce the basic infrastructure for the PCI Configuration Space Cache
(PCSC), a mechanism to cache PCI configuration space accesses to reduce
latency and bus traffic.

The PCSC implements a transparent interception layer for PCI config
space operations by dynamically injecting its own ops into the PCI bus
hierarchy. The design preserves existing PCI ops while allowing PCSC to
intercept and cache accesses:

The` struct pci_bus` is extended to hold the original `pci_ops`, while
the cache ones are injected via `pcsc_inject_bus_ops()`. The cache ops
are injected when new buses are added via registering it to a bus
notifier and integrating it at:
  * `pci_register_host_bridge()` - for root buses
  * `pci_alloc_child_bus()` - for child buses
  * `pci_bus_set_ops()` - when ops are dynamically changed

The implementation includes weak pcsc_hw_config_read/write functions
that handle calling the original op, when access to the actual HW is
required.

This approach ensures complete transparency - existing drivers and
subsystems continue to use standard PCI config access functions while
PCSC can intercept and cache accesses as needed. The weak functions also
allow architecture-specific implementations to override the default
behavior.

The `core` initcall level is chosen so the cache is initialised before
the PCI driver, ensuring that all config space access go through the
cache.

Kconfig options are added for both PCSC and PCIe PCSC support, with the
latter extending the cache to handle 4KB PCIe configuration space.

In this initial patch, the cache simply passes through all accesses to
the hardware via the original ops - actual caching functionality will be
added in subsequent patches.

There is one caveat in this patch. The map_bus operations can
potentially alter the cache, without invalidating / updating the cache.
This is not an issue for the current upstream usages, as it is only
being used in Root complexes and the
`pci_generic_config_{read,write}{,32}`

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/Kconfig      |  10 ++
 drivers/pci/Makefile     |   1 +
 drivers/pci/access.c     |  81 ++++++++++++++-
 drivers/pci/pcie/Kconfig |   9 ++
 drivers/pci/pcsc.c       | 208 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c      |  24 ++++-
 include/linux/pci.h      |   3 +
 include/linux/pcsc.h     |  86 ++++++++++++++++
 8 files changed, 419 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/pcsc.c
 create mode 100644 include/linux/pcsc.h

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9a249c65aedc..c26162b58365 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -40,6 +40,16 @@ config PCI_DOMAINS_GENERIC
 config PCI_SYSCALL
 	bool
 
+config PCSC
+	bool "PCI Configuration Space Cache"
+	depends on PCI
+	default n
+	help
+	  This option enables support for the PCI Configuration Space Cache
+	  (PCSC). PCSC is a transparent caching layer that
+	  intercepts configuration space operations and maintains cached
+	  copies of register values
+
 source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..012561b97e32 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
+obj-$(CONFIG_PCSC)			+= pcsc.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..b89e9210d330 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
+#include <linux/pcsc.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
@@ -189,15 +190,93 @@ EXPORT_SYMBOL_GPL(pci_generic_config_write32);
  * @ops:	new raw operations
  *
  * Return previous raw operations
+ *
+ * When PCSC is enabled, this function maintains transparency by:
+ * - Returning the original non-PCSC ops to the caller
+ * - Properly handling the case where PCSC ops are already injected
+ * - Re-injecting PCSC ops after setting new ops when appropriate
  */
 struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops)
 {
 	struct pci_ops *old_ops;
 	unsigned long flags;
+#ifdef CONFIG_PCSC
+	bool pcsc_was_injected = false;
+	struct pci_ops *pcsc_ops_ptr = NULL;
+#endif
 
 	raw_spin_lock_irqsave(&pci_lock, flags);
-	old_ops = bus->ops;
+
+#ifdef CONFIG_PCSC
+	/*
+	 * Check if PCSC ops are currently injected. If so, we need to:
+	 * 1. Return the original (non-PCSC) ops to maintain transparency
+	 * 2. Update orig_ops to point to the new ops
+	 * 3. Re-inject PCSC ops if the new ops are different from PCSC ops
+	 */
+	if (bus->orig_ops) {
+		pcsc_was_injected = true;
+		pcsc_ops_ptr = bus->ops;  /* Save current PCSC ops */
+		old_ops = bus->orig_ops;   /* Return the real original ops */
+
+		/*
+		 * If the caller is trying to restore the PCSC ops themselves,
+		 * just keep the current setup and return the original ops
+		 */
+		if (ops == pcsc_ops_ptr)
+			goto out_unlock;
+
+		/* Clear orig_ops temporarily to allow re-injection */
+		bus->orig_ops = NULL;
+	} else
+#endif
+	{
+		old_ops = bus->ops;
+	}
+
 	bus->ops = ops;
+
+#ifdef CONFIG_PCSC
+	/*
+	 * Re-inject PCSC ops if they were previously injected and the new ops
+	 * are not the PCSC ops themselves. This maintains caching transparency.
+	 */
+	if (pcsc_was_injected && ops != pcsc_ops_ptr) {
+		/*
+		 * IMPORTANT: Dynamic ops changes after PCSC injection can lead to
+		 * cache consistency issues if operations were performed that should
+		 * have invalidated the cache. We re-inject PCSC ops here, but the
+		 * caller is responsible for ensuring cache consistency if needed.
+		 * This will be fixed in a future commit, when PCSC resets are
+		 * introduced.
+		 */
+
+		pr_warn("PCSC: Dynamic ops change detected on bus %04x:%02x, resetting cache\n",
+			pci_domain_nr(bus), bus->number);
+
+		if (pcsc_inject_bus_ops(bus)) {
+			pr_err("PCSC: Failed to re-inject ops after ops change on bus %04x:%02x\n",
+				pci_domain_nr(bus), bus->number);
+			/*
+			 * If re-injection fails, we've lost caching but at least
+			 * the caller's requested ops are in place. Log it
+			 */
+			pr_warn("PCSC: Cache disabled for bus %04x:%02x after ops change\n",
+				pci_domain_nr(bus), bus->number);
+		} else {
+			pr_debug("PCSC: Successfully re-injected ops after ops change on bus %04x:%02x\n",
+				pci_domain_nr(bus), bus->number);
+		}
+	} else if (!pcsc_was_injected) {
+		/* First-time injection for this bus */
+		if (pcsc_inject_bus_ops(bus)) {
+			pr_err("PCSC: Failed to inject ops on bus %04x:%02x\n",
+				pci_domain_nr(bus), bus->number);
+		}
+	}
+
+out_unlock:
+#endif
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 	return old_ops;
 }
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..2f1efc41afcc 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,12 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_PCSC
+	bool "PCI Configuration Space Cache PCIE Support"
+	depends on PCSC
+	default y
+	help
+	This option adds PCIe support to the PCSC, by expanding the
+	configuration space to 4K and adding support for PCIe Capabilities.
+	For more information check PCSC and `/drivers/pci/pcsc.c`
diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
new file mode 100644
index 000000000000..dec7c51b5cfd
--- /dev/null
+++ b/drivers/pci/pcsc.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ * Author: Evangelos Petrongonas <epetron@amazon.de>
+ *
+ * Implementation of the PCI Configuration Space Cache (PCSC)
+ * PCSC is a module which caches the PCI Configuration Space Accesses
+ * It implements a write-invalidate policy, meaning that writes are
+ * propagated to the device and invalidating the cache. The registers that
+ * we are caching are based on the values that are safe to cache and we
+ * are not expecting them to change without OS actions.
+ *
+ */
+
+ #define pr_fmt(fmt) "PCSC: " fmt
+
+#include <linux/pcsc.h>
+
+static bool pcsc_initialised;
+
+static int pcsc_add_bus(struct pci_bus *bus)
+{
+	if (!bus->orig_ops || !bus->orig_ops->add_bus)
+		return 0;
+	return bus->orig_ops->add_bus(bus);
+}
+
+static void pcsc_remove_bus(struct pci_bus *bus)
+{
+	if (bus->orig_ops && bus->orig_ops->remove_bus)
+		bus->orig_ops->remove_bus(bus);
+}
+
+/**
+ * pcsc_map_bus - Map PCI configuration space for memory-mapped access
+ * @bus: PCI bus structure
+ * @devfn: Device and function number
+ * @where: Offset in configuration space
+ *
+ * WARNING: Cache Bypass Issue
+ * This function returns a memory-mapped I/O address that provides direct
+ * access to PCI configuration space, completely bypassing the PCSC cache.
+ *
+ * Any reads or writes performed through the returned MMIO address will NOT:
+ * - Use cached values for reads
+ * - Update cached values on reads
+ * - Invalidate cached values on writes
+ *
+ * This can lead to cache inconsistency where:
+ * 1. PCSC cache contains stale data after MMIO writes
+ * 2. Subsequent cached reads return outdated values
+ * 3. Cache coherency is lost until the next cache invalidation
+ *
+ * Current users include:
+ * - (pci_generic_config_{read,write}{,32}) which are already handled
+ * - operations on RCs that are not supported by PCSC.
+ * Therefore, there is no risk of cache inconsistency here.
+ * However, any future use of map_bus after cache population poses risks.
+ *
+ * IMPORTANT: Callers using the returned MMIO address are responsible for
+ * maintaining cache consistency. Consider invalidating relevant cache entries
+ * after MMIO operations if the device's cache may be active.
+ *
+ * Return: Virtual address for memory-mapped config space access, or NULL
+ */
+static void __iomem *pcsc_map_bus(struct pci_bus *bus, unsigned int devfn,
+				  int where)
+{
+	if (!bus->orig_ops || !bus->orig_ops->map_bus)
+		return NULL;
+	return bus->orig_ops->map_bus(bus, devfn, where);
+}
+
+/* Weak references to allow architecture-specific overrides */
+int __weak pcsc_hw_config_read(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	/*
+	 * This function is only called from pcsc_cached_config_read,
+	 * which means PCSC ops have already been injected and orig_ops
+	 * should be valid.
+	 */
+	if (bus->orig_ops && bus->orig_ops->read)
+		return bus->orig_ops->read(bus, devfn, where, size, val);
+
+	*val = 0xffffffff;
+	return PCIBIOS_FUNC_NOT_SUPPORTED;
+}
+EXPORT_SYMBOL_GPL(pcsc_hw_config_read);
+
+int __weak pcsc_hw_config_write(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 val)
+{
+	/*
+	 * This function is only called from pcsc_cached_config_write,
+	 * which means PCSC ops have already been injected and orig_ops
+	 * should be valid.
+	 */
+	if (bus->orig_ops && bus->orig_ops->write)
+		return bus->orig_ops->write(bus, devfn, where, size, val);
+
+	return PCIBIOS_FUNC_NOT_SUPPORTED;
+}
+EXPORT_SYMBOL_GPL(pcsc_hw_config_write);
+
+int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, u32 *val)
+{
+	if (!pcsc_initialised)
+		goto read_from_dev;
+
+read_from_dev:
+	return pcsc_hw_config_read(bus, devfn, where, size, val);
+}
+EXPORT_SYMBOL_GPL(pcsc_cached_config_read);
+
+int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
+			     int size, u32 val)
+{
+	if (!pcsc_initialised)
+		goto write_to_dev;
+
+write_to_dev:
+	return pcsc_hw_config_write(bus, devfn, where, size, val);
+}
+EXPORT_SYMBOL_GPL(pcsc_cached_config_write);
+
+static struct pci_ops pcsc_ops = {
+	.add_bus = pcsc_add_bus,
+	.remove_bus = pcsc_remove_bus,
+	.map_bus = pcsc_map_bus,
+	.read = pcsc_cached_config_read,
+	.write = pcsc_cached_config_write,
+};
+
+int pcsc_inject_bus_ops(struct pci_bus *bus)
+{
+	if (!bus)
+		return -EINVAL;
+
+	if (!bus->ops) {
+		WARN_ONCE(
+			1,
+			"PCSC: Cannot inject ops - bus %04x:%02x ops not defined\n",
+			pci_domain_nr(bus), bus->number);
+		return -EINVAL;
+	}
+
+	if (bus->ops->read == pcsc_cached_config_read || bus->orig_ops)
+		return 0;
+
+	bus->orig_ops = bus->ops;
+	bus->ops = &pcsc_ops;
+
+	pci_dbg(bus, "PCSC: Injected ops for bus");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcsc_inject_bus_ops);
+
+static void pcsc_remove_bus_ops(struct pci_bus *bus)
+{
+	if (bus->orig_ops && bus->ops == &pcsc_ops) {
+		bus->ops = bus->orig_ops;
+		bus->orig_ops = NULL;
+	}
+}
+
+static int pcsc_bus_notify(struct notifier_block *nb, unsigned long action,
+			   void *data)
+{
+	struct device *dev = data;
+	struct pci_bus *bus;
+
+	bus = to_pci_bus(dev);
+	if (!bus)
+		return NOTIFY_OK;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		pcsc_inject_bus_ops(bus);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		/*
+		 * Remove on DEL_DEVICE to unhook before device_del() completes.
+		 * This ensures caching is disabled before the final cleanup.
+		 */
+		pcsc_remove_bus_ops(bus);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pcsc_bus_nb = {
+	.notifier_call = pcsc_bus_notify,
+};
+
+static int __init pcsc_init(void)
+{
+	bus_register_notifier(&pci_bus_type, &pcsc_bus_nb);
+
+	pcsc_initialised = true;
+	pr_info("initialised\n");
+
+	return 0;
+}
+
+core_initcall(pcsc_init);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 37f5bd476f39..33a186e4bf1e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/pcsc.h>
 #include <linux/msi.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
@@ -1039,6 +1040,11 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	}
 #endif
 
+#ifdef CONFIG_PCSC
+	if (pcsc_inject_bus_ops(bus))
+		pci_err(bus, "PCSC: Failed to inject ops\n");
+#endif
+
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
 	if (b) {
 		/* Ignore it if we already got here via a different bridge */
@@ -1236,10 +1242,24 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->bus_flags = parent->bus_flags;
 
 	host = pci_find_host_bridge(parent);
-	if (host->child_ops)
+	if (host->child_ops) {
 		child->ops = host->child_ops;
-	else
+#ifdef CONFIG_PCSC
+		child->orig_ops = host->child_ops;
+#endif
+	} else {
 		child->ops = parent->ops;
+#ifdef CONFIG_PCSC
+		child->orig_ops = parent->orig_ops;
+#endif
+	}
+
+#ifdef CONFIG_PCSC
+	if (child->ops) {
+		if (pcsc_inject_bus_ops(child))
+			pci_err(child, "PCSC: Failed to inject ops\n");
+	}
+#endif
 
 	/*
 	 * Initialize some portions of the bus device, but don't register
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..b6cbf93db644 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -669,6 +669,9 @@ struct pci_bus {
 	struct resource busn_res;	/* Bus numbers routed to this bus */
 
 	struct pci_ops	*ops;		/* Configuration access functions */
+#ifdef CONFIG_PCSC
+	struct pci_ops	*orig_ops;	/* Original ops before PCSC injection */
+#endif
 	void		*sysdata;	/* Hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
 
diff --git a/include/linux/pcsc.h b/include/linux/pcsc.h
new file mode 100644
index 000000000000..45816eb2b2c8
--- /dev/null
+++ b/include/linux/pcsc.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2025 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ * Author: Evangelos Petrongonas <epetron@amazon.de>
+ *
+ */
+
+#ifndef _LINUX_PCSC_H
+#define _LINUX_PCSC_H
+
+#include <linux/pci.h>
+
+/**
+ * pcsc_hw_config_read - Direct hardware PCI config space read
+ * @bus: PCI bus
+ * @devfn: PCI device function
+ * @where: offset in PCI config space
+ * @size: size of data to read
+ * @val: pointer to store read data
+ *
+ * This function performs a direct hardware read from PCI configuration space,
+ * bypassing the PCSC cache. It is a weak function that can be overridden by
+ * architecture-specific implementations.
+ *
+ * Return: 0 on success, non-zero error code on failure
+ */
+int pcsc_hw_config_read(struct pci_bus *bus, unsigned int devfn, int where,
+			int size, u32 *val);
+
+/**
+ * pcsc_hw_config_write - Direct hardware PCI config space write
+ * @bus: PCI bus
+ * @devfn: PCI device function
+ * @where: offset in PCI config space
+ * @size: size of data to write
+ * @val: value to write
+ *
+ * This function performs a direct hardware write to PCI configuration space,
+ * bypassing the PCSC cache. It is a weak function that can be overridden by
+ * architecture-specific implementations.
+ *
+ * Return: 0 on success, non-zero error code on failure
+ */
+int pcsc_hw_config_write(struct pci_bus *bus, unsigned int devfn, int where,
+			 int size, u32 val);
+
+/**
+ * pcsc_cached_config_read - Read PCI config space register via PCSC
+ * @bus: PCI bus
+ * @devfn: PCI device function
+ * @where: offset in PCI config space
+ * @size: size of data to read
+ * @val: pointer to store read data
+ *
+ * Reads a register from the PCI configuration space of a device using the
+ * PCSC infrastructure.
+ *
+ * Return: 0 on success, non-zero error code on failure
+ */
+int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, u32 *val);
+
+/**
+ * pcsc_cached_config_write - Write PCI config space register via PCSC
+ * @bus: PCI bus
+ * @devfn: PCI device function
+ * @where: offset in PCI config space
+ * @size: size of data to write
+ * @val: value to write
+ *
+ * Writes a value to a register in the PCI configuration space of a device using
+ * the PCSC infrastructure.
+ *
+ * Return: 0 on success, non-zero error code on failure
+ */
+int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
+			     int size, u32 val);
+
+/**
+ * pcsc_inject_bus_ops Inject the pcsc ops into bus pci_ops
+ * @bus: the bus in which to inject the ops
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int pcsc_inject_bus_ops(struct pci_bus *bus);
+#endif /* _LINUX_PCSC_H */
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


