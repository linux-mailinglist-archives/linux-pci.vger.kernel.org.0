Return-Path: <linux-pci+bounces-43430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 563ADCD14F6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3ACBC304342A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF3E33BBD5;
	Fri, 19 Dec 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDrXqcdC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62B34105B;
	Fri, 19 Dec 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166175; cv=none; b=aaJ9ntlKAOhITInCGWwAdgwh2YrZ2oZi7ODkl466JPDKd5VHzUkWYNnXn/Bl5wyrYFoRU+hrh5ssu3e1BpU3bdPXZ+wXn6nouCb/I69xvuNEEG7k2VylW1x0iJ7TQIZJx3EM/yzWs1YLzTB63tZmWO61ZHR67waUz6aIZAbBfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166175; c=relaxed/simple;
	bh=Ggh/CA7ZGkotjZdlqofUy3jwBogYwx5cmhDn9qY6gvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfARMArFN7LHC8R5aGnLPt/T5A84NLZd32stFJS4qFBfkrw5p+03CQqtBVBSUMOSsMWmRDvRWSst02oyLwG5uFE8TLsWoksBPiL5TUlVfccPFjDYQcp/iZV6P0buUH54ut2S8ahAtcVARVh20kM16T+yzqArrvfOoKlVg3P4GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDrXqcdC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166172; x=1797702172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ggh/CA7ZGkotjZdlqofUy3jwBogYwx5cmhDn9qY6gvo=;
  b=fDrXqcdC6mm8TLzV6VZcEsMa9Vg3tt7ZTADvHpAZOghWzi4uJH9CPeME
   X4BxRDg04YG8GJDGtdKCpBzZ2jfOi4eFXTX2CSu7wlv28xXmUyenvSgSk
   Ye3WZV2SWTm4lyQgDGPI6sW3YuBSHYTMkHVU/l+/gqj8oZO4CYgrANdoW
   8HjjAhr5jeH/YIszpNCD/6Imoq976fo9u2TU2q7IwTo3pioUIkFBcWIsI
   NqqIdj5QeqcDMaTKp48sdCK9LJ67bKEFoyxk36XmCc1TVnUZz9X0fR6Fk
   h4SKpCA7geKDwzItZAXKXvWDswcs2ZGkGt/S7nEGWkxe2cglz78sfqeZX
   Q==;
X-CSE-ConnectionGUID: 36SZqhcRTxKWD/Z9PVLDPQ==
X-CSE-MsgGUID: PU4HKDtOS3qG1+YfNlFZEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="67880696"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="67880696"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:51 -0800
X-CSE-ConnectionGUID: mLL18Lu5Qb2O7fcBFaWYsA==
X-CSE-MsgGUID: x5pBbgEYSJGm6NVh1aksvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198497104"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 15/23] PCI: Use resource_assigned() in setup-bus.c algorithm
Date: Fri, 19 Dec 2025 19:40:28 +0200
Message-Id: <20251219174036.16738-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Many places in the resource fitting and assignment algorithm want to
know if the resource is assigned into the resource tree or not. Convert
open-coded ->parent checks to use resource_assigned().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 64 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3fcc7641c374..bbc615d85c88 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -132,7 +132,7 @@ static void restore_dev_resource(struct pci_dev_resource *dev_res)
 	int idx = pci_resource_num(dev, res);
 	const char *res_name = pci_resource_name(dev, idx);
 
-	if (WARN_ON_ONCE(res->parent))
+	if (WARN_ON_ONCE(resource_assigned(res)))
 		return;
 
 	res->start = dev_res->start;
@@ -166,7 +166,7 @@ static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 		if ((r->flags & type_mask) != type)
 			continue;
 
-		if (!r->parent)
+		if (!resource_assigned(r))
 			return r;
 		if (!r_assigned)
 			r_assigned = r;
@@ -269,7 +269,7 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
 struct resource *pbus_select_window(struct pci_bus *bus,
 				    const struct resource *res)
 {
-	if (res->parent)
+	if (resource_assigned(res))
 		return res->parent;
 
 	return pbus_select_window_for_type(bus, res->flags);
@@ -308,7 +308,7 @@ static bool pdev_resource_assignable(struct pci_dev *dev, struct resource *res)
 
 static bool pdev_resource_should_fit(struct pci_dev *dev, struct resource *res)
 {
-	if (res->parent)
+	if (resource_assigned(res))
 		return false;
 
 	if (res->flags & IORESOURCE_PCI_FIXED)
@@ -430,7 +430,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		 * Skip resource that failed the earlier assignment and is
 		 * not optional as it would just fail again.
 		 */
-		if (!res->parent && resource_size(res) &&
+		if (!resource_assigned(res) && resource_size(res) &&
 		    !pci_resource_is_optional(dev, idx))
 			goto out;
 
@@ -441,7 +441,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		res_name = pci_resource_name(dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;
-		if (!res->parent) {
+		if (!resource_assigned(res)) {
 			resource_set_range(res, align,
 					   resource_size(res) + add_size);
 			if (pci_assign_resource(dev, idx)) {
@@ -677,7 +677,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		list_for_each_entry(save_res, &save_head, list) {
 			struct resource *res = save_res->res;
 
-			if (res->parent)
+			if (resource_assigned(res))
 				continue;
 
 			restore_dev_resource(save_res);
@@ -693,7 +693,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
 		res = dev_res->res;
 
-		if (res->parent && !pci_need_to_release(fail_type, res)) {
+		if (resource_assigned(res) &&
+		    !pci_need_to_release(fail_type, res)) {
 			/* Remove it from realloc_head list */
 			remove_from_list(realloc_head, res);
 			remove_from_list(&save_head, res);
@@ -729,7 +730,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		res = dev_res->res;
 		dev = dev_res->dev;
 
-		if (res->parent)
+		if (resource_assigned(res))
 			continue;
 
 		if (fail_head) {
@@ -779,7 +780,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[0];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->parent && res->flags & IORESOURCE_IO) {
+	if (resource_assigned(res) && res->flags & IORESOURCE_IO) {
 		/*
 		 * The IO resource is allocated a range twice as large as it
 		 * would normally need.  This allows us to set both IO regs.
@@ -793,7 +794,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[1];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->parent && res->flags & IORESOURCE_IO) {
+	if (resource_assigned(res) && res->flags & IORESOURCE_IO) {
 		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_IO_BASE_1,
 					region.start);
@@ -803,7 +804,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[2];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->parent && res->flags & IORESOURCE_MEM) {
+	if (resource_assigned(res) && res->flags & IORESOURCE_MEM) {
 		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_0,
 					region.start);
@@ -813,7 +814,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[3];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->parent && res->flags & IORESOURCE_MEM) {
+	if (resource_assigned(res) && res->flags & IORESOURCE_MEM) {
 		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_1,
 					region.start);
@@ -854,7 +855,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
 	res_name = pci_resource_name(bridge, PCI_BRIDGE_IO_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->parent && res->flags & IORESOURCE_IO) {
+	if (resource_assigned(res) && res->flags & IORESOURCE_IO) {
 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
 		io_base_lo = (region.start >> 8) & io_mask;
 		io_limit_lo = (region.end >> 8) & io_mask;
@@ -886,7 +887,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
 	res_name = pci_resource_name(bridge, PCI_BRIDGE_MEM_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->parent && res->flags & IORESOURCE_MEM) {
+	if (resource_assigned(res) && res->flags & IORESOURCE_MEM) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		pci_info(bridge, "  %s %pR\n", res_name, res);
@@ -915,7 +916,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 	res_name = pci_resource_name(bridge, PCI_BRIDGE_PREF_MEM_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->parent && res->flags & IORESOURCE_PREFETCH) {
+	if (resource_assigned(res) && res->flags & IORESOURCE_PREFETCH) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		if (res->flags & IORESOURCE_MEM_64) {
@@ -1125,7 +1126,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 		return;
 
 	/* If resource is already assigned, nothing more to do */
-	if (b_res->parent)
+	if (resource_assigned(b_res))
 		return;
 
 	min_align = window_alignment(bus, IORESOURCE_IO);
@@ -1135,7 +1136,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 		pci_dev_for_each_resource(dev, r) {
 			unsigned long r_size;
 
-			if (r->parent || !(r->flags & IORESOURCE_IO))
+			if (resource_assigned(r) || !(r->flags & IORESOURCE_IO))
 				continue;
 
 			if (!pdev_resource_assignable(dev, r))
@@ -1331,7 +1332,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 		return;
 
 	/* If resource is already assigned, nothing more to do */
-	if (b_res->parent)
+	if (resource_assigned(b_res))
 		return;
 
 	max_order = 0;
@@ -1436,7 +1437,7 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	u16 ctrl;
 
 	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_0_WINDOW];
-	if (b_res->parent)
+	if (resource_assigned(b_res))
 		goto handle_b_res_1;
 	/*
 	 * Reserve some resources for CardBus.  We reserve a fixed amount
@@ -1452,7 +1453,7 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 
 handle_b_res_1:
 	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_1_WINDOW];
-	if (b_res->parent)
+	if (resource_assigned(b_res))
 		goto handle_b_res_2;
 	resource_set_range(b_res, pci_cardbus_io_size, pci_cardbus_io_size);
 	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
@@ -1480,7 +1481,7 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	}
 
 	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_0_WINDOW];
-	if (b_res->parent)
+	if (resource_assigned(b_res))
 		goto handle_b_res_3;
 	/*
 	 * If we have prefetchable memory support, allocate two regions.
@@ -1503,7 +1504,7 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 
 handle_b_res_3:
 	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_1_WINDOW];
-	if (b_res->parent)
+	if (resource_assigned(b_res))
 		goto handle_done;
 	resource_set_range(b_res, pci_cardbus_mem_size, b_res_3_size);
 	b_res->flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
@@ -1619,12 +1620,13 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 	pci_dev_for_each_resource(dev, r) {
 		struct pci_bus *b;
 
-		if (r->parent || !(r->flags & IORESOURCE_PCI_FIXED) ||
+		if (resource_assigned(r) ||
+		    !(r->flags & IORESOURCE_PCI_FIXED) ||
 		    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
 
 		b = dev->bus;
-		while (b && !r->parent) {
+		while (b && !resource_assigned(r)) {
 			assign_fixed_resource_on_bus(b, r);
 			b = b->parent;
 		}
@@ -1680,7 +1682,7 @@ static void pci_claim_device_resources(struct pci_dev *dev)
 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
 		struct resource *r = &dev->resource[i];
 
-		if (!r->flags || r->parent)
+		if (!r->flags || resource_assigned(r))
 			continue;
 
 		pci_claim_resource(dev, i);
@@ -1694,7 +1696,7 @@ static void pci_claim_bridge_resources(struct pci_dev *dev)
 	for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r = &dev->resource[i];
 
-		if (!r->flags || r->parent)
+		if (!r->flags || resource_assigned(r))
 			continue;
 
 		pci_claim_bridge_resource(dev, i);
@@ -1777,7 +1779,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	struct pci_dev *dev = bus->self;
 	int idx, ret;
 
-	if (!b_win->parent)
+	if (!resource_assigned(b_win))
 		return;
 
 	idx = pci_resource_num(dev, b_win);
@@ -1973,7 +1975,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 {
 	resource_size_t add_size, size = resource_size(res);
 
-	if (res->parent)
+	if (resource_assigned(res))
 		return;
 
 	if (!new_size)
@@ -2063,7 +2065,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * window.
 		 */
 		align = pci_resource_alignment(bridge, res);
-		if (!res->parent && align)
+		if (!resource_assigned(res) && align)
 			available[i].start = min(ALIGN(available[i].start, align),
 						 available[i].end + 1);
 
@@ -2512,7 +2514,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 
 		i = pci_resource_num(dev, res);
 
-		if (res->parent) {
+		if (resource_assigned(res)) {
 			release_child_resources(res);
 			pci_release_resource(dev, i);
 		}
-- 
2.39.5


