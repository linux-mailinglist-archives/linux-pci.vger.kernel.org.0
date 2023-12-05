Return-Path: <linux-pci+bounces-520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166EF805ADF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3996D1C214B6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD12692A7;
	Tue,  5 Dec 2023 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z36Lfk2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC569288
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 17:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FA3C433CA;
	Tue,  5 Dec 2023 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796290;
	bh=XxBZyK07KrgM9wDgcJEblAD+Kh9xWEHLc4pprnPshOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z36Lfk2HmhOkj5nd6uCN1uyoh/7RC9NtyAJ+Uo/2VK4mg/Aj9qPyNsjfcZWicXI63
	 whNMh/LZCNjDbJ7LtHU721/tkwZKKLuNpTUzspk67JOvuZsmgocNDKkHXY0pSxEker
	 2NYHghXrWQvNmAFlgZBx0P1wqbYsLL4XvIOGjRA+mxVkSS8oLaG7M9Zs8DinGEQ9NI
	 olUz++XOWitm2m/h7acmuqRnFEzWb5viu3+PEdtMHjKpOv9A9JSO74MZho5PlbwWPL
	 jPKfV8HnTc2aJNQ4X/xDRmnObVkHEnmH9fYEgi2mOkmqo5qgcT/zAByEKQGq/KG1Rv
	 nwK06OvP9pKPA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/7] PCI: Use resource names in PCI log messages
Date: Tue,  5 Dec 2023 11:11:15 -0600
Message-Id: <20231205171119.680358-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205171119.680358-1-helgaas@kernel.org>
References: <20231205171119.680358-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay12@gmail.com>

Use the pci_resource_name() to get the name of the resource and use it
while printing log messages.

[bhelgaas: rename to match struct resource * names, also use names in other
BAR messages]
Link: https://lore.kernel.org/r/20211106112606.192563-3-puranjay12@gmail.com
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c       |  7 ++--
 drivers/pci/pci.c       | 25 +++++++-------
 drivers/pci/probe.c     | 26 +++++++--------
 drivers/pci/quirks.c    | 15 ++++++---
 drivers/pci/setup-bus.c | 30 +++++++++++------
 drivers/pci/setup-res.c | 72 +++++++++++++++++++++++------------------
 6 files changed, 103 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 25dbe85c4217..aaa33e8dc4c9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -745,6 +745,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	u16 ctrl, total;
 	struct pci_sriov *iov;
 	struct resource *res;
+	const char *res_name;
 	struct pci_dev *pdev;
 
 	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
@@ -785,6 +786,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
+		res_name = pci_resource_name(dev, i + PCI_IOV_RESOURCES);
+
 		/*
 		 * If it is already FIXED, don't change it, something
 		 * (perhaps EA or header fixups) wants it this way.
@@ -802,8 +805,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		}
 		iov->barsz[i] = resource_size(res);
 		res->end = res->start + resource_size(res) * total - 1;
-		pci_info(dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
-			 i, res, i, total);
+		pci_info(dev, "%s %pR: contains BAR %d for %d VFs\n",
+			 res_name, res, i, total);
 		i += bar64;
 		nres++;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af36a0bf3e42..e62c17a8859d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3350,6 +3350,7 @@ static struct resource *pci_ea_get_resource(struct pci_dev *dev, u8 bei,
 static int pci_ea_read(struct pci_dev *dev, int offset)
 {
 	struct resource *res;
+	const char *res_name;
 	int ent_size, ent_offset = offset;
 	resource_size_t start, end;
 	unsigned long flags;
@@ -3379,6 +3380,7 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 		goto out;
 
 	res = pci_ea_get_resource(dev, bei, prop);
+	res_name = pci_resource_name(dev, bei);
 	if (!res) {
 		pci_err(dev, "Unsupported EA entry BEI: %u\n", bei);
 		goto out;
@@ -3452,16 +3454,16 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 	res->flags = flags;
 
 	if (bei <= PCI_EA_BEI_BAR5)
-		pci_info(dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei, res, prop);
+		pci_info(dev, "%s %pR: from Enhanced Allocation, properties %#02x\n",
+			 res_name, res, prop);
 	else if (bei == PCI_EA_BEI_ROM)
-		pci_info(dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   res, prop);
+		pci_info(dev, "%s %pR: from Enhanced Allocation, properties %#02x\n",
+			 res_name, res, prop);
 	else if (bei >= PCI_EA_BEI_VF_BAR0 && bei <= PCI_EA_BEI_VF_BAR5)
-		pci_info(dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei - PCI_EA_BEI_VF_BAR0, res, prop);
+		pci_info(dev, "%s %pR: from Enhanced Allocation, properties %#02x\n",
+			 res_name, res, prop);
 	else
-		pci_info(dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_info(dev, "BEI %d %pR: from Enhanced Allocation, properties %#02x\n",
 			   bei, res, prop);
 
 out:
@@ -6749,14 +6751,15 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 					   resource_size_t align, bool resize)
 {
 	struct resource *r = &dev->resource[bar];
+	const char *r_name = pci_resource_name(dev, bar);
 	resource_size_t size;
 
 	if (!(r->flags & IORESOURCE_MEM))
 		return;
 
 	if (r->flags & IORESOURCE_PCI_FIXED) {
-		pci_info(dev, "BAR%d %pR: ignoring requested alignment %#llx\n",
-			 bar, r, (unsigned long long)align);
+		pci_info(dev, "%s %pR: ignoring requested alignment %#llx\n",
+			 r_name, r, (unsigned long long)align);
 		return;
 	}
 
@@ -6792,8 +6795,8 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	 * devices and we use the second.
 	 */
 
-	pci_info(dev, "BAR%d %pR: requesting alignment to %#llx\n",
-		 bar, r, (unsigned long long)align);
+	pci_info(dev, "%s %pR: requesting alignment to %#llx\n",
+		 r_name, r, (unsigned long long)align);
 
 	if (resize) {
 		r->start = 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1dbc06f0305c..f6ec79b6a037 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -180,6 +180,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	u64 l64, sz64, mask64;
 	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
+	const char *res_name = pci_resource_name(dev, res - dev->resource);
 
 	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
 
@@ -254,8 +255,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	sz64 = pci_size(l64, sz64, mask64);
 	if (!sz64) {
-		pci_info(dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
-			 pos);
+		pci_info(dev, FW_BUG "%s: invalid; can't size\n", res_name);
 		goto fail;
 	}
 
@@ -265,8 +265,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 			res->start = 0;
 			res->end = 0;
-			pci_err(dev, "reg 0x%x: can't handle BAR larger than 4GB (size %#010llx)\n",
-				pos, (unsigned long long)sz64);
+			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
+				res_name, (unsigned long long)sz64);
 			goto out;
 		}
 
@@ -275,8 +275,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET;
 			res->start = 0;
 			res->end = sz64 - 1;
-			pci_info(dev, "reg 0x%x: can't handle BAR above 4GB (bus address %#010llx)\n",
-				 pos, (unsigned long long)l64);
+			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
+				 res_name, (unsigned long long)l64);
 			goto out;
 		}
 	}
@@ -302,8 +302,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		res->flags |= IORESOURCE_UNSET;
 		res->start = 0;
 		res->end = region.end - region.start;
-		pci_info(dev, "reg 0x%x: initial BAR value %#010llx invalid\n",
-			 pos, (unsigned long long)region.start);
+		pci_info(dev, "%s: initial BAR value %#010llx invalid\n",
+			 res_name, (unsigned long long)region.start);
 	}
 
 	goto out;
@@ -313,7 +313,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->flags = 0;
 out:
 	if (res->flags)
-		pci_info(dev, "reg 0x%x: %pR\n", pos, res);
+		pci_info(dev, "%s %pR\n", res_name, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
@@ -1967,14 +1967,14 @@ int pci_setup_device(struct pci_dev *dev)
 				res = &dev->resource[0];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				pci_info(dev, "legacy IDE quirk: reg 0x10: %pR\n",
+				pci_info(dev, "BAR 0 %pR: legacy IDE quirk\n",
 					 res);
 				region.start = 0x3F6;
 				region.end = 0x3F6;
 				res = &dev->resource[1];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				pci_info(dev, "legacy IDE quirk: reg 0x14: %pR\n",
+				pci_info(dev, "BAR 1 %pR: legacy IDE quirk\n",
 					 res);
 			}
 			if ((progif & 4) == 0) {
@@ -1983,14 +1983,14 @@ int pci_setup_device(struct pci_dev *dev)
 				res = &dev->resource[2];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				pci_info(dev, "legacy IDE quirk: reg 0x18: %pR\n",
+				pci_info(dev, "BAR 2 %pR: legacy IDE quirk\n",
 					 res);
 				region.start = 0x376;
 				region.end = 0x376;
 				res = &dev->resource[3];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				pci_info(dev, "legacy IDE quirk: reg 0x1c: %pR\n",
+				pci_info(dev, "BAR 3 %pR: legacy IDE quirk\n",
 					 res);
 			}
 		}
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..905ff3def1bf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -570,13 +570,14 @@ static void quirk_extend_bar_to_page(struct pci_dev *dev)
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct resource *r = &dev->resource[i];
+		const char *r_name = pci_resource_name(dev, i);
 
 		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
 			r->end = PAGE_SIZE - 1;
 			r->start = 0;
 			r->flags |= IORESOURCE_UNSET;
-			pci_info(dev, "expanded BAR %d to page size: %pR\n",
-				 i, r);
+			pci_info(dev, "%s %pR: expanded to page size\n",
+				 r_name, r);
 		}
 	}
 }
@@ -605,6 +606,7 @@ static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
 	u32 region;
 	struct pci_bus_region bus_region;
 	struct resource *res = dev->resource + pos;
+	const char *res_name = pci_resource_name(dev, pos);
 
 	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (pos << 2), &region);
 
@@ -622,8 +624,7 @@ static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
 	bus_region.end = region + size - 1;
 	pcibios_bus_to_resource(dev->bus, res, &bus_region);
 
-	pci_info(dev, FW_BUG "%s quirk: reg 0x%x: %pR\n",
-		 name, PCI_BASE_ADDRESS_0 + (pos << 2), res);
+	pci_info(dev, FW_BUG "%s %pR: %s quirk\n", res_name, res, name);
 }
 
 /*
@@ -670,6 +671,12 @@ static void quirk_io_region(struct pci_dev *dev, int port,
 	bus_region.end = region + size - 1;
 	pcibios_bus_to_resource(dev->bus, res, &bus_region);
 
+	/*
+	 * "res" is typically a bridge window resource that's not being
+	 * used for a bridge window, so it's just a place to stash this
+	 * non-standard resource.  Printing "nr" or pci_resource_name() of
+	 * it doesn't really make sense.
+	 */
 	if (!pci_claim_resource(dev, nr))
 		pci_info(dev, "quirk: %pR claimed by %s\n", res, name);
 }
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fd74f1c99dba..909e6a7c3cc3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -213,6 +213,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				      struct list_head *head)
 {
 	struct resource *res;
+	const char *res_name;
 	struct pci_dev_resource *add_res, *tmp;
 	struct pci_dev_resource *dev_res;
 	resource_size_t add_size, align;
@@ -222,6 +223,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		bool found_match = false;
 
 		res = add_res->res;
+
 		/* Skip resource that has been reset */
 		if (!res->flags)
 			goto out;
@@ -237,6 +239,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 			continue;
 
 		idx = res - &add_res->dev->resource[0];
+		res_name = pci_resource_name(add_res->dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;
 		if (!resource_size(res)) {
@@ -249,9 +252,9 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
 						  add_size, align))
-				pci_info(add_res->dev, "failed to add %llx res[%d]=%pR\n",
-					 (unsigned long long) add_size, idx,
-					 res);
+				pci_info(add_res->dev, "%s %pR: failed to add %llx\n",
+					 res_name, res,
+					 (unsigned long long) add_size);
 		}
 out:
 		list_del(&add_res->list);
@@ -571,6 +574,7 @@ EXPORT_SYMBOL(pci_setup_cardbus);
 static void pci_setup_bridge_io(struct pci_dev *bridge)
 {
 	struct resource *res;
+	const char *res_name;
 	struct pci_bus_region region;
 	unsigned long io_mask;
 	u8 io_base_lo, io_limit_lo;
@@ -583,6 +587,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus */
 	res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
+	res_name = pci_resource_name(bridge, PCI_BRIDGE_IO_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_IO) {
 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
@@ -591,7 +596,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 		l = ((u16) io_limit_lo << 8) | io_base_lo;
 		/* Set up upper 16 bits of I/O base/limit */
 		io_upper16 = (region.end & 0xffff0000) | (region.start >> 16);
-		pci_info(bridge, "  bridge window %pR\n", res);
+		pci_info(bridge, "  %s %pR\n", res_name, res);
 	} else {
 		/* Clear upper 16 bits of I/O base/limit */
 		io_upper16 = 0;
@@ -608,16 +613,18 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 {
 	struct resource *res;
+	const char *res_name;
 	struct pci_bus_region region;
 	u32 l;
 
 	/* Set up the top and bottom of the PCI Memory segment for this bus */
 	res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
+	res_name = pci_resource_name(bridge, PCI_BRIDGE_MEM_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_MEM) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
-		pci_info(bridge, "  bridge window %pR\n", res);
+		pci_info(bridge, "  %s %pR\n", res_name, res);
 	} else {
 		l = 0x0000fff0;
 	}
@@ -627,6 +634,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 {
 	struct resource *res;
+	const char *res_name;
 	struct pci_bus_region region;
 	u32 l, bu, lu;
 
@@ -640,6 +648,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	/* Set up PREF base/limit */
 	bu = lu = 0;
 	res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+	res_name = pci_resource_name(bridge, PCI_BRIDGE_PREF_MEM_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_PREFETCH) {
 		l = (region.start >> 16) & 0xfff0;
@@ -648,7 +657,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 			bu = upper_32_bits(region.start);
 			lu = upper_32_bits(region.end);
 		}
-		pci_info(bridge, "  bridge window %pR\n", res);
+		pci_info(bridge, "  %s %pR\n", res_name, res);
 	} else {
 		l = 0x0000fff0;
 	}
@@ -1013,6 +1022,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		int i;
 
 		pci_dev_for_each_resource(dev, r, i) {
+			const char *r_name = pci_resource_name(dev, i);
 			resource_size_t r_size;
 
 			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
@@ -1043,8 +1053,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (order < 0)
 				order = 0;
 			if (order >= ARRAY_SIZE(aligns)) {
-				pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
-					 i, r, (unsigned long long) align);
+				pci_warn(dev, "%s %pR: disabling; bad alignment %#llx\n",
+					 r_name, r, (unsigned long long) align);
 				r->flags = 0;
 				continue;
 			}
@@ -2235,6 +2245,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
 		     i++) {
 			struct resource *res = &bridge->resource[i];
+			const char *res_name = pci_resource_name(bridge, i);
 
 			if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
 				continue;
@@ -2247,8 +2258,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 			if (ret)
 				goto cleanup;
 
-			pci_info(bridge, "BAR %d: releasing %pR\n",
-				 i, res);
+			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
 
 			if (res->parent)
 				release_resource(res);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ceaa69491f5e..c6d933ddfd46 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -30,6 +30,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	u32 new, check, mask;
 	int reg;
 	struct resource *res = dev->resource + resno;
+	const char *res_name = pci_resource_name(dev, resno);
 
 	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
 	if (dev->is_virtfn)
@@ -104,8 +105,8 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
-		pci_err(dev, "BAR %d: error updating (%#010x != %#010x)\n",
-			resno, new, check);
+		pci_err(dev, "%s: error updating (%#010x != %#010x)\n",
+			res_name, new, check);
 	}
 
 	if (res->flags & IORESOURCE_MEM_64) {
@@ -113,8 +114,8 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		pci_write_config_dword(dev, reg + 4, new);
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
-			pci_err(dev, "BAR %d: error updating (high %#010x != %#010x)\n",
-				resno, new, check);
+			pci_err(dev, "%s: error updating (high %#010x != %#010x)\n",
+				res_name, new, check);
 		}
 	}
 
@@ -135,11 +136,12 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 int pci_claim_resource(struct pci_dev *dev, int resource)
 {
 	struct resource *res = &dev->resource[resource];
+	const char *res_name = pci_resource_name(dev, resource);
 	struct resource *root, *conflict;
 
 	if (res->flags & IORESOURCE_UNSET) {
-		pci_info(dev, "can't claim BAR %d %pR: no address assigned\n",
-			 resource, res);
+		pci_info(dev, "%s %pR: can't claim; no address assigned\n",
+			 res_name, res);
 		return -EINVAL;
 	}
 
@@ -153,16 +155,16 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 
 	root = pci_find_parent_resource(dev, res);
 	if (!root) {
-		pci_info(dev, "can't claim BAR %d %pR: no compatible bridge window\n",
-			 resource, res);
+		pci_info(dev, "%s %pR: can't claim; no compatible bridge window\n",
+			 res_name, res);
 		res->flags |= IORESOURCE_UNSET;
 		return -EINVAL;
 	}
 
 	conflict = request_resource_conflict(root, res);
 	if (conflict) {
-		pci_info(dev, "can't claim BAR %d %pR: address conflict with %s %pR\n",
-			 resource, res, conflict->name, conflict);
+		pci_info(dev, "%s %pR: can't claim; address conflict with %s %pR\n",
+			 res_name, res, conflict->name, conflict);
 		res->flags |= IORESOURCE_UNSET;
 		return -EBUSY;
 	}
@@ -201,6 +203,7 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 {
 	struct resource *root, *conflict;
 	resource_size_t fw_addr, start, end;
+	const char *res_name = pci_resource_name(dev, resno);
 
 	fw_addr = pcibios_retrieve_fw_addr(dev, resno);
 	if (!fw_addr)
@@ -231,12 +234,11 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 			root = &iomem_resource;
 	}
 
-	pci_info(dev, "BAR %d: trying firmware assignment %pR\n",
-		 resno, res);
+	pci_info(dev, "%s: trying firmware assignment %pR\n", res_name, res);
 	conflict = request_resource_conflict(root, res);
 	if (conflict) {
-		pci_info(dev, "BAR %d: %pR conflicts with %s %pR\n",
-			 resno, res, conflict->name, conflict);
+		pci_info(dev, "%s %pR: conflicts with %s %pR\n", res_name, res,
+			 conflict->name, conflict);
 		res->start = start;
 		res->end = end;
 		res->flags |= IORESOURCE_UNSET;
@@ -325,6 +327,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 int pci_assign_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = dev->resource + resno;
+	const char *res_name = pci_resource_name(dev, resno);
 	resource_size_t align, size;
 	int ret;
 
@@ -334,8 +337,8 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	res->flags |= IORESOURCE_UNSET;
 	align = pci_resource_alignment(dev, res);
 	if (!align) {
-		pci_info(dev, "BAR %d: can't assign %pR (bogus alignment)\n",
-			 resno, res);
+		pci_info(dev, "%s %pR: can't assign; bogus alignment\n",
+			 res_name, res);
 		return -EINVAL;
 	}
 
@@ -348,18 +351,18 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	 * working, which is better than just leaving it disabled.
 	 */
 	if (ret < 0) {
-		pci_info(dev, "BAR %d: no space for %pR\n", resno, res);
+		pci_info(dev, "%s %pR: can't assign; no space\n", res_name, res);
 		ret = pci_revert_fw_address(res, dev, resno, size);
 	}
 
 	if (ret < 0) {
-		pci_info(dev, "BAR %d: failed to assign %pR\n", resno, res);
+		pci_info(dev, "%s %pR: failed to assign\n", res_name, res);
 		return ret;
 	}
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
-	pci_info(dev, "BAR %d: assigned %pR\n", resno, res);
+	pci_info(dev, "%s %pR: assigned\n", res_name, res);
 	if (resno < PCI_BRIDGE_RESOURCES)
 		pci_update_resource(dev, resno);
 
@@ -367,10 +370,11 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_assign_resource);
 
-int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsize,
-			resource_size_t min_align)
+int pci_reassign_resource(struct pci_dev *dev, int resno,
+			  resource_size_t addsize, resource_size_t min_align)
 {
 	struct resource *res = dev->resource + resno;
+	const char *res_name = pci_resource_name(dev, resno);
 	unsigned long flags;
 	resource_size_t new_size;
 	int ret;
@@ -381,8 +385,8 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	flags = res->flags;
 	res->flags |= IORESOURCE_UNSET;
 	if (!res->parent) {
-		pci_info(dev, "BAR %d: can't reassign an unassigned resource %pR\n",
-			 resno, res);
+		pci_info(dev, "%s %pR: can't reassign; unassigned resource\n",
+			 res_name, res);
 		return -EINVAL;
 	}
 
@@ -391,15 +395,15 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	ret = _pci_assign_resource(dev, resno, new_size, min_align);
 	if (ret) {
 		res->flags = flags;
-		pci_info(dev, "BAR %d: %pR (failed to expand by %#llx)\n",
-			 resno, res, (unsigned long long) addsize);
+		pci_info(dev, "%s %pR: failed to expand by %#llx\n",
+			 res_name, res, (unsigned long long) addsize);
 		return ret;
 	}
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
-	pci_info(dev, "BAR %d: reassigned %pR (expanded by %#llx)\n",
-		 resno, res, (unsigned long long) addsize);
+	pci_info(dev, "%s %pR: reassigned; expanded by %#llx\n",
+		 res_name, res, (unsigned long long) addsize);
 	if (resno < PCI_BRIDGE_RESOURCES)
 		pci_update_resource(dev, resno);
 
@@ -409,8 +413,9 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 void pci_release_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = dev->resource + resno;
+	const char *res_name = pci_resource_name(dev, resno);
 
-	pci_info(dev, "BAR %d: releasing %pR\n", resno, res);
+	pci_info(dev, "%s %pR: releasing\n", res_name, res);
 
 	if (!res->parent)
 		return;
@@ -480,6 +485,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	u16 cmd, old_cmd;
 	int i;
 	struct resource *r;
+	const char *r_name;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
@@ -488,6 +494,8 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 		if (!(mask & (1 << i)))
 			continue;
 
+		r_name = pci_resource_name(dev, i);
+
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
 		if ((i == PCI_ROM_RESOURCE) &&
@@ -495,14 +503,14 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 			continue;
 
 		if (r->flags & IORESOURCE_UNSET) {
-			pci_err(dev, "can't enable device: BAR %d %pR not assigned\n",
-				i, r);
+			pci_err(dev, "%s %pR: not assigned; can't enable device\n",
+				r_name, r);
 			return -EINVAL;
 		}
 
 		if (!r->parent) {
-			pci_err(dev, "can't enable device: BAR %d %pR not claimed\n",
-				i, r);
+			pci_err(dev, "%s %pR: not claimed; can't enable device\n",
+				r_name, r);
 			return -EINVAL;
 		}
 
-- 
2.34.1


