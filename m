Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0484727A531
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1B0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:26:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:64441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgI1B0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:26:08 -0400
IronPort-SDR: NscM44WksQD1InfeZeYwO+qDLZiP7iaY6iT/VSDSgfJzLWq2Ee826XCWxCElBJCfiYVez3TnlQ
 h8MXVE+ecnVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141939478"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="141939478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:26:23 -0700
IronPort-SDR: /otH0sgCXg2q4brE7zz1N9lx9pMbMW8X/gu/8gsZ3M3or6UBnz0ha5lqNowAcXr8BiB3i8i8Ry
 K9hOGDqqfhDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="456639887"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2020 18:26:23 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/3] PCI: Introduce a minimizing assignment algorithm
Date:   Sun, 27 Sep 2020 21:06:08 -0400
Message-Id: <20200928010609.5375-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200928010609.5375-1-jonathan.derrick@intel.com>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI domains have limited resources that get exhausted by hotplug
resource domains. VMD subdevice domains, for example, tend to support
only 32MB MMIO, of which the decoable address space is split between
prefetchable and non-prefetchable windows using existing resource
assignment algorithms. In addition to these limitations, hotplug bridges
require additional resource reservations as specified by default or
module parameters "pci=hp{io,mmio,mmiopref}size, further exhausting the
domain resources prior to full domain assignment.

Introduce a minimizing assignment algorithm which starts with the
default or user-requested hotplug resource values, tries with minimal
hotplug resource values, and lastly tries no hotplug resource values.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/setup-bus.c | 98 ++++++++++++++++++++++++++++++++++++++---
 include/linux/pci.h     |  2 +
 2 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f22502e8e6e6..7beb4f37660b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1200,6 +1200,35 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	;
 }
 
+enum {
+	PCI_SIZING_VARIANT_DEFAULT,
+	PCI_SIZING_VARIANT_NOHOTPLUG,
+	PCI_SIZING_VARIANT_MINIMUM,
+	PCI_NUM_SIZING_VARIANTS,
+};
+
+static void hotplug_sizes(int sizing_variant, resource_size_t *io,
+			  resource_size_t *mmio, resource_size_t *pref)
+{
+	switch (sizing_variant) {
+	case PCI_SIZING_VARIANT_MINIMUM:
+		*io = 0;
+		*mmio = 0;
+		*pref = 0;
+		break;
+	case PCI_SIZING_VARIANT_NOHOTPLUG:
+		*io = 256;
+		*mmio = 1 << 20;
+		*pref = 1 << 20;
+		break;
+	case PCI_SIZING_VARIANT_DEFAULT:
+	default:
+		*io = pci_hotplug_io_size;
+		*mmio = pci_hotplug_mmio_size;
+		*pref = pci_hotplug_mmio_pref_size;
+	}
+}
+
 void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
@@ -1248,11 +1277,11 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
-		if (bus->self->is_hotplug_bridge) {
-			additional_io_size  = pci_hotplug_io_size;
-			additional_mmio_size = pci_hotplug_mmio_size;
-			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
-		}
+		if (bus->self->is_hotplug_bridge)
+			hotplug_sizes(bus->self->sizing_variant,
+				      &additional_io_size,
+				      &additional_mmio_size,
+				      &additional_mmio_pref_size);
 		/* Fall through */
 	default:
 		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
@@ -2247,3 +2276,62 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 	BUG_ON(!list_empty(&add_list));
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
+
+static int __set_sizing_variant(struct pci_dev *dev, void *data)
+{
+	if (dev->is_hotplug_bridge)
+		dev->sizing_variant = *((int *) data);
+
+	return 0;
+}
+
+static void release_bridge_resources(struct pci_bus *bus)
+{
+	struct resource *res;
+	struct pci_dev *dev;
+	int i;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate) {
+			for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END; i++)
+				reset_resource(&dev->resource[i]);
+
+			release_bridge_resources(dev->subordinate);
+		}
+
+		if (pci_is_root_bus(bus))
+			continue;
+
+		pci_bus_for_each_resource(bus, res, i)
+			reset_resource(res);
+	}
+}
+
+void pci_bus_assign_resources_fallback_sizing(struct pci_bus *bus)
+{
+	LIST_HEAD(fail_head);
+	int i = 0;
+
+	pci_walk_bus(bus, __set_sizing_variant, &i);
+	__pci_bus_assign_resources(bus, NULL, &fail_head);
+
+	if (list_empty(&fail_head))
+		return;
+
+	for (i = 0; i < PCI_NUM_SIZING_VARIANTS; i++) {
+		pci_walk_bus(bus, __set_sizing_variant, &i);
+
+		down_read(&pci_bus_sem);
+		__pci_bus_size_bridges(bus, NULL);
+		up_read(&pci_bus_sem);
+
+		__pci_bus_assign_resources(bus, NULL, &fail_head);
+		if (list_empty(&fail_head))
+			return;
+
+		release_and_restore_resources(&fail_head);
+		release_bridge_resources(bus);
+		free_list(&fail_head);
+	}
+}
+EXPORT_SYMBOL(pci_bus_assign_resources_fallback_sizing);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 801e9ad0d57e..72ae11d3b5ea 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -424,6 +424,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	sizing_variant:2;	/* normal, minimum, no hotplug */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -1299,6 +1300,7 @@ void pci_assign_unassigned_resources(void);
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
+void pci_bus_assign_resources_fallback_sizing(struct pci_bus *bus);
 int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
-- 
2.18.1

