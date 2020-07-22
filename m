Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B22296DF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 13:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgGVLDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 07:03:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39016 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVLDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 07:03:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MB3R5D070410;
        Wed, 22 Jul 2020 06:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595415807;
        bh=vy++iuijnlTzQzvlmFNJ8Bmy1T6Qyths2jOTFLhpC1A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tK6m31cQtmhxaoyGg4l0xVs1elqdeJSGBqfnTslxGYTG0IG3+lWAEkot6Bb/peDLY
         bc6Oq9zdWpEn2pvTNWQuMQyW5G3Z3RI864dNspKSUuESQ3a8RpRJwz0cqmpF/MAN3h
         2shlUyXUlp8FwKwPex9MZK/BaTZGZz3SZDh8NmE8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MB3RAV019824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 06:03:27 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 06:03:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 06:03:26 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MB3IFZ078616;
        Wed, 22 Jul 2020 06:03:23 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 01/15] PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits" property
Date:   Wed, 22 Jul 2020 16:33:03 +0530
Message-ID: <20200722110317.4744-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722110317.4744-1-kishon@ti.com>
References: <20200722110317.4744-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
property to configure the number of bits passed through from PCIe
address to internal address in Inbound Address Translation register.
This only used the NO MATCH BAR.

However standard PCI dt-binding already defines "dma-ranges" to
describe the address ranges accessible by PCIe controller. Add support
in Cadence PCIe host driver to parse dma-ranges and configure the
inbound regions for BAR0, BAR1 and NO MATCH BAR. Cadence IP specifies
maximum size for BAR0 as 256GB, maximum size for BAR1 as 2 GB.

This adds support to take the next biggest region in "dma-ranges" and
find the smallest BAR that each of the regions fit in and if there is
no BAR big enough to hold the region, split the region to see if it can
be fitted using multiple BARs.

"dma-ranges" of J721E will be
dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
Since there is no BAR which can hold 2^48 size, NO_MATCH_BAR will be
used here.

Legacy device tree binding compatibility is maintained by retaining
support for "cdns,no-bar-match-nbits".

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from [1]
1) Use list_sort() for sorting the address ranges by size
2) Clear CDNS_PCIE_LM_RC_BAR_CFG register before configuring them

[1] -> http://lore.kernel.org/r/20200521080153.5902-1-kishon@ti.com
 .../controller/cadence/pcie-cadence-host.c    | 251 +++++++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h |  28 +-
 2 files changed, 262 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8c2543f28ba0..f42a0acfce00 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -4,6 +4,7 @@
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
 #include <linux/kernel.h>
+#include <linux/list_sort.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
@@ -11,6 +12,17 @@
 
 #include "pcie-cadence.h"
 
+static u64 bar_max_size[] = {
+	[RP_BAR0] = _ULL(128 * SZ_2G),
+	[RP_BAR1] = SZ_2G,
+	[RP_NO_BAR] = _BITULL(63),
+};
+
+static u8 bar_aperture_mask[] = {
+	[RP_BAR0] = 0x1F,
+	[RP_BAR1] = 0xF,
+};
+
 static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 				      int where)
 {
@@ -101,6 +113,217 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
+static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+					enum cdns_pcie_rp_bar bar,
+					u64 cpu_addr, u64 size,
+					unsigned long flags)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 addr0, addr1, aperture, value;
+
+	if (!rc->avail_ib_bar[bar])
+		return -EBUSY;
+
+	rc->avail_ib_bar[bar] = false;
+
+	aperture = ilog2(size);
+	addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), addr1);
+
+	if (bar == RP_NO_BAR)
+		return 0;
+
+	value = cdns_pcie_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
+	value &= ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
+		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
+		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
+		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
+		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
+	if (size + cpu_addr >= SZ_4G) {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |= LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
+		value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
+	} else {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |= LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
+		value |= LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
+	}
+
+	value |= LM_RC_BAR_CFG_APERTURE(bar, aperture);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
+
+	return 0;
+}
+
+static enum cdns_pcie_rp_bar
+cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size)
+{
+	enum cdns_pcie_rp_bar bar, sel_bar;
+
+	sel_bar = RP_BAR_UNDEFINED;
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
+		if (!rc->avail_ib_bar[bar])
+			continue;
+
+		if (size <= bar_max_size[bar]) {
+			if (sel_bar == RP_BAR_UNDEFINED) {
+				sel_bar = bar;
+				continue;
+			}
+
+			if (bar_max_size[bar] < bar_max_size[sel_bar])
+				sel_bar = bar;
+		}
+	}
+
+	return sel_bar;
+}
+
+static enum cdns_pcie_rp_bar
+cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size)
+{
+	enum cdns_pcie_rp_bar bar, sel_bar;
+
+	sel_bar = RP_BAR_UNDEFINED;
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
+		if (!rc->avail_ib_bar[bar])
+			continue;
+
+		if (size >= bar_max_size[bar]) {
+			if (sel_bar == RP_BAR_UNDEFINED) {
+				sel_bar = bar;
+				continue;
+			}
+
+			if (bar_max_size[bar] > bar_max_size[sel_bar])
+				sel_bar = bar;
+		}
+	}
+
+	return sel_bar;
+}
+
+static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
+				     struct resource_entry *entry)
+{
+	u64 cpu_addr, pci_addr, size, winsize;
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	enum cdns_pcie_rp_bar bar;
+	unsigned long flags;
+	int ret;
+
+	cpu_addr = entry->res->start;
+	pci_addr = entry->res->start - entry->offset;
+	flags = entry->res->flags;
+	size = resource_size(entry->res);
+
+	if (entry->offset) {
+		dev_err(dev, "PCI addr: %llx must be equal to CPU addr: %llx\n",
+			pci_addr, cpu_addr);
+		return -EINVAL;
+	}
+
+	while (size > 0) {
+		/*
+		 * Try to find a minimum BAR whose size is greater than
+		 * or equal to the remaining resource_entry size. This will
+		 * fail if the size of each of the available BARs is less than
+		 * the remaining resource_entry size.
+		 * If a minimum BAR is found, IB ATU will be configured and
+		 * exited.
+		 */
+		bar = cdns_pcie_host_find_min_bar(rc, size);
+		if (bar != RP_BAR_UNDEFINED) {
+			ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
+							   size, flags);
+			if (ret)
+				dev_err(dev, "IB BAR: %d config failed\n", bar);
+			return ret;
+		}
+
+		/*
+		 * If the control reaches here, it would mean the remaining
+		 * resource_entry size cannot be fitted in a single BAR. So we
+		 * find a maximum BAR whose size is less than or equal to the
+		 * remaining resource_entry size and split the resource entry
+		 * so that part of resource entry is fitted inside the maximum
+		 * BAR. The remaining size would be fitted during the next
+		 * iteration of the loop.
+		 * If a maximum BAR is not found, there is no way we can fit
+		 * this resource_entry, so we error out.
+		 */
+		bar = cdns_pcie_host_find_max_bar(rc, size);
+		if (bar == RP_BAR_UNDEFINED) {
+			dev_err(dev, "No free BAR to map cpu_addr %llx\n",
+				cpu_addr);
+			return -EINVAL;
+		}
+
+		winsize = bar_max_size[bar];
+		ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
+						   flags);
+		if (ret) {
+			dev_err(dev, "IB BAR: %d config failed\n", bar);
+			return ret;
+		}
+
+		size -= winsize;
+		cpu_addr += winsize;
+	}
+
+	return 0;
+}
+
+static int cdns_pcie_host_dma_ranges_cmp(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct resource_entry *entry1, *entry2;
+
+        entry1 = container_of(a, struct resource_entry, node);
+        entry2 = container_of(b, struct resource_entry, node);
+
+        return resource_size(entry2->res) - resource_size(entry1->res);
+}
+
+static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	struct resource_entry *entry;
+	u32 no_bar_nbits = 32;
+	int err;
+
+	bridge = pci_host_bridge_from_priv(rc);
+	if (!bridge)
+		return -ENOMEM;
+
+	if (list_empty(&bridge->dma_ranges)) {
+		of_property_read_u32(np, "cdns,no-bar-match-nbits",
+				     &no_bar_nbits);
+		err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+						   (u64)1 << no_bar_nbits, 0);
+		if (err)
+			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
+		return err;
+	}
+
+	list_sort(NULL, &bridge->dma_ranges, cdns_pcie_host_dma_ranges_cmp);
+
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		err = cdns_pcie_host_bar_config(rc, entry);
+		if (err)
+			dev_err(dev, "Fail to configure IB using dma-ranges\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -154,16 +377,9 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 		r++;
 	}
 
-	/*
-	 * Set Root Port no BAR match Inbound Translation registers:
-	 * needed for MSI and DMA.
-	 * Root Port BAR0 and BAR1 are disabled, hence no need to set their
-	 * inbound translation registers.
-	 */
-	addr0 = CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(rc->no_bar_nbits);
-	addr1 = 0;
-	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(RP_NO_BAR), addr0);
-	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(RP_NO_BAR), addr1);
+	err = cdns_pcie_host_map_dma_ranges(rc);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -173,10 +389,16 @@ static int cdns_pcie_host_init(struct device *dev,
 			       struct cdns_pcie_rc *rc)
 {
 	struct resource *bus_range = NULL;
+	struct pci_host_bridge *bridge;
 	int err;
 
+	bridge = pci_host_bridge_from_priv(rc);
+	if (!bridge)
+		return -ENOMEM;
+
 	/* Parse our PCI ranges and request their resources */
-	err = pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_range);
+	err = pci_parse_request_of_pci_ranges(dev, resources,
+					      &bridge->dma_ranges, &bus_range);
 	if (err)
 		return err;
 
@@ -205,6 +427,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct list_head resources;
+	enum cdns_pcie_rp_bar bar;
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
@@ -216,9 +439,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	pcie = &rc->pcie;
 	pcie->is_rc = true;
 
-	rc->no_bar_nbits = 32;
-	of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
-
 	rc->vendor_id = 0xffff;
 	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
 
@@ -248,6 +468,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	pcie->mem_res = res;
 
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
+		rc->avail_ib_bar[bar] = true;
+
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
 		goto err_init;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index df14ad002fe9..bc49c22e48a9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -87,6 +87,20 @@
 #define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
 #define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
 
+#define LM_RC_BAR_CFG_CTRL_DISABLED(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
+					(((aperture) - 2) << ((bar) * 8))
 
 /*
  * Endpoint Function Registers (PCI configuration space for endpoint functions)
@@ -170,11 +184,19 @@
 #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
 
 enum cdns_pcie_rp_bar {
+	RP_BAR_UNDEFINED = -1,
 	RP_BAR0,
 	RP_BAR1,
 	RP_NO_BAR
 };
 
+#define CDNS_PCIE_RP_MAX_IB	0x3
+
+struct cdns_pcie_rp_ib_bar {
+	u64 size;
+	bool free;
+};
+
 /* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register */
 #define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
@@ -251,19 +273,19 @@ struct cdns_pcie {
  * @bus_range: first/last buses behind the PCIe host controller
  * @cfg_base: IO mapped window to access the PCI configuration space of a
  *            single function at a time
- * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
- *                translation (nbits sets into the "no BAR match" register)
  * @vendor_id: PCI vendor ID
  * @device_id: PCI device ID
+ * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
+ *                available
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
 	struct resource		*cfg_res;
 	struct resource		*bus_range;
 	void __iomem		*cfg_base;
-	u32			no_bar_nbits;
 	u32			vendor_id;
 	u32			device_id;
+	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 };
 
 /**
-- 
2.17.1

