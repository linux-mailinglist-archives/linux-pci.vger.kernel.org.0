Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01591E2CD4
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391937AbgEZTNn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:13:43 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46164 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391983AbgEZTNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:41 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7AFEF30D639;
        Tue, 26 May 2020 12:13:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7AFEF30D639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520418;
        bh=EsBLxUZiy649ZiBRdK80O6rwq0lkq6mGhRDs7jPGYdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xj7guZeLqBw6/h3Fbq+q9orHO803qEFe9RRL+yXTSnCE331faLqti7RKP4TcZn23t
         IS+AnjdUfRvgLcVFNvvLtVgepPJOa3aPXPTQNU4e3Vd5SCjwqFxp9qMxJA+Gp8XsbE
         5xLZ5x9VasIk/VKIuZXs9rDkyas6AUqOpX/Gre8M=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 08C1314008C;
        Tue, 26 May 2020 12:13:35 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Corey Minyard <minyard@acm.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS)
Subject: [PATCH v2 09/14] device core: Add ability to handle multiple dma offsets
Date:   Tue, 26 May 2020 15:12:48 -0400
Message-Id: <20200526191303.1492-10-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The new field in struct device 'dma_pfn_offset_map' is used to facilitate
the use of multiple pfn offsets between cpu addrs and dma addrs.  It is
similar to 'dma_pfn_offset' except that the offset chosen depends on the
cpu or dma address involved.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/of/address.c        | 65 +++++++++++++++++++++++++++++++++++--
 drivers/usb/core/message.c  |  3 ++
 drivers/usb/core/usb.c      |  3 ++
 include/linux/device.h      | 10 +++++-
 include/linux/dma-direct.h  | 10 ++++--
 include/linux/dma-mapping.h | 46 ++++++++++++++++++++++++++
 kernel/dma/Kconfig          | 13 ++++++++
 7 files changed, 144 insertions(+), 6 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 96d8cfb14a60..a01afffcde7d 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -918,6 +918,47 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
 }
 EXPORT_SYMBOL(of_io_request_and_map);
 
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+static int attach_dma_pfn_offset_map(struct device *dev,
+				     struct device_node *node, int num_ranges)
+{
+	struct of_range_parser parser;
+	struct of_range range;
+	size_t r_size = (num_ranges + 1)
+		* sizeof(struct dma_pfn_offset_region);
+	struct dma_pfn_offset_region *r;
+
+	r = devm_kzalloc(dev, r_size, GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+	dev->dma_pfn_offset_map = r;
+	of_dma_range_parser_init(&parser, node);
+
+	/*
+	 * Record all info for DMA ranges array.  We could
+	 * just use the of_range struct, but if we did that it
+	 * would require more calculations for phys_to_dma and
+	 * dma_to_phys conversions.
+	 */
+	for_each_of_range(&parser, &range) {
+		r->cpu_beg = range.cpu_addr;
+		r->cpu_end = r->cpu_beg + range.size;
+		r->dma_beg = range.bus_addr;
+		r->dma_end = r->dma_beg + range.size;
+		r->pfn_offset = PFN_DOWN(range.cpu_addr)
+			- PFN_DOWN(range.bus_addr);
+		r++;
+	}
+	return 0;
+}
+#else
+static int attach_dma_pfn_offset_map(struct device *dev,
+				     struct device_node *node, int num_ranges)
+{
+	return 0;
+}
+#endif
+
 /**
  * of_dma_get_range - Get DMA range info
  * @dev:	device pointer; only needed for a corner case.
@@ -947,6 +988,8 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 	struct of_range_parser parser;
 	struct of_range range;
 	u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
+	bool dma_multi_pfn_offset = false;
+	int num_ranges = 0;
 
 	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
@@ -977,10 +1020,19 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 			 range.bus_addr, range.cpu_addr, range.size);
 
+		num_ranges++;
 		if (dma_offset && range.cpu_addr - range.bus_addr != dma_offset) {
-			pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
-			/* Don't error out as we'd break some existing DTs */
-			continue;
+			if (!IS_ENABLED(CONFIG_DMA_PFN_OFFSET_MAP)) {
+				pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
+				pr_warn("Perhaps set DMA_PFN_OFFSET_MAP=y?\n");
+				/*
+				 * Don't error out as we'd break some existing
+				 * DTs that are using configs w/o
+				 * CONFIG_DMA_PFN_OFFSET_MAP set.
+				 */
+				continue;
+			}
+			dma_multi_pfn_offset = true;
 		}
 		dma_offset = range.cpu_addr - range.bus_addr;
 
@@ -991,6 +1043,13 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
 			dma_end = range.bus_addr + range.size;
 	}
 
+	if (dma_multi_pfn_offset) {
+		dma_offset = 0;
+		ret = attach_dma_pfn_offset_map(dev, node, num_ranges);
+		if (ret)
+			return ret;
+	}
+
 	if (dma_start >= dma_end) {
 		ret = -EINVAL;
 		pr_debug("Invalid DMA ranges configuration on node(%pOF)\n",
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 6197938dcc2d..aaa3e58f5eb4 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1960,6 +1960,9 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		 */
 		intf->dev.dma_mask = dev->dev.dma_mask;
 		intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+		intf->dev.dma_pfn_offset_map = dev->dev.dma_pfn_offset_map;
+#endif
 		INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
 		intf->minor = -1;
 		device_initialize(&intf->dev);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index f16c26dc079d..d2ed4d90e56e 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -612,6 +612,9 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	 */
 	dev->dev.dma_mask = bus->sysdev->dma_mask;
 	dev->dev.dma_pfn_offset = bus->sysdev->dma_pfn_offset;
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	dev->dev.dma_pfn_offset_map = bus->sysdev->dma_pfn_offset_map;
+#endif
 	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a..67a240ad4fc5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -493,6 +493,8 @@ struct dev_links_info {
  * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
  *		DMA limit than the device itself supports.
  * @dma_pfn_offset: offset of DMA memory range relatively of RAM
+ * @dma_pfn_offset_map:	Like dma_pfn_offset but used when there are multiple
+ *		pfn offsets for multiple dma-ranges.
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
  * @dma_pools:	Dma pools (if dma'ble device).
@@ -578,7 +580,13 @@ struct device {
 					     allocations such descriptors. */
 	u64		bus_dma_limit;	/* upstream dma constraint */
 	unsigned long	dma_pfn_offset;
-
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	const struct dma_pfn_offset_region *dma_pfn_offset_map;
+					/* Like dma_pfn_offset, but for
+					 * the unlikely case of multiple
+					 * offsets. If non-null, dma_pfn_offset
+					 * will be set to 0. */
+#endif
 	struct device_dma_parameters *dma_parms;
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 24b8684aa21d..03110a57eabc 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -14,15 +14,21 @@ extern unsigned int zone_dma_bits;
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	dma_addr_t dev_addr = (dma_addr_t)paddr;
+	/* The compiler should remove the 2nd term if !DMA_PFN_OFFSET_MAP */
+	unsigned long dma_pfn_offset = dev->dma_pfn_offset
+		+ dma_pfn_offset_from_phys_addr(dev, paddr);
 
-	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+	return dev_addr - ((dma_addr_t)dma_pfn_offset << PAGE_SHIFT);
 }
 
 static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
 	phys_addr_t paddr = (phys_addr_t)dev_addr;
+	/* The compiler should remove the 2nd term if !DMA_PFN_OFFSET_MAP */
+	unsigned long dma_pfn_offset = dev->dma_pfn_offset
+		+ dma_pfn_offset_from_dma_addr(dev, paddr);
 
-	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+	return paddr + ((phys_addr_t)dma_pfn_offset << PAGE_SHIFT);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..91940bba2229 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -256,6 +256,52 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #ifdef CONFIG_HAS_DMA
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+struct dma_pfn_offset_region {
+	phys_addr_t	cpu_beg;
+	phys_addr_t	cpu_end;
+	dma_addr_t	dma_beg;
+	dma_addr_t	dma_end;
+	unsigned long	pfn_offset;
+};
+
+static inline unsigned long dma_pfn_offset_from_dma_addr(struct device *dev,
+							 dma_addr_t dma_addr)
+{
+	const struct dma_pfn_offset_region *m = dev->dma_pfn_offset_map;
+
+	if (m)
+		for (; m->cpu_end; m++)
+			if (dma_addr >= m->dma_beg && dma_addr < m->dma_end)
+				return m->pfn_offset;
+	return 0;
+}
+
+static inline unsigned long dma_pfn_offset_from_phys_addr(struct device *dev,
+							  phys_addr_t paddr)
+{
+	const struct dma_pfn_offset_region *m = dev->dma_pfn_offset_map;
+
+	if (m)
+		for (; m->cpu_end; m++)
+			if (paddr >= m->cpu_beg && paddr < m->cpu_end)
+				return m->pfn_offset;
+	return 0;
+}
+#else  /* CONFIG_DMA_PFN_OFFSET_MAP */
+static inline unsigned long dma_pfn_offset_from_dma_addr(struct device *dev,
+							 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+static inline unsigned long dma_pfn_offset_from_phys_addr(struct device *dev,
+							  phys_addr_t paddr)
+{
+	return 0;
+}
+#endif /* CONFIG_DMA_PFN_OFFSET_MAP */
+
 #include <asm/dma-mapping.h>
 
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c103a24e380..ceb7e5e8f501 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -195,3 +195,16 @@ config DMA_API_DEBUG_SG
 	  is technically out-of-spec.
 
 	  If unsure, say N.
+
+config DMA_PFN_OFFSET_MAP
+	bool "Uses a DMA range map to calculate PFN offset"
+	depends on PCIE_BRCMSTB
+	default n
+	help
+	  Some devices have a dma-range that gets converted to
+	  a dev->dma_pfn_offset value.  This option is for the
+	  atypical case of there being multiple dma-ranges requiring
+	  multiple pfn offsets, which are selected from when
+	  converting to phys to dma and vice versa.
+
+	  If unsure, say N.
-- 
2.17.1

