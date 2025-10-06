Return-Path: <linux-pci+bounces-37602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D45BBD038
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB573AB5DC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 03:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2427D1C8630;
	Mon,  6 Oct 2025 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf6upqJf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9813B280;
	Mon,  6 Oct 2025 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759723103; cv=none; b=BuiqWFVu6RdNob5jJCXgMquUvkGk9GaupEjrRCbzmksGukHqXRjh2oRrWsYqUuzgGTDb9+pBoRBc/CSG1b3wYfieaC41h2XBnz3nuVyQi/edlKJjlqUnRveco9r4n8PF6CUh39ERVJ2dAOIYYXgRJQK4SsoRiT2x4MwwoDToquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759723103; c=relaxed/simple;
	bh=daJBxd6HVKNES5hXjPzSIqGXw7yQl0iUIqP4BhOvv0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J9/UhnrLb5VllQbIAixmRL7zSsThwJudPK6lx2ZI73SWBCQqN+WTR4yVydojIeB95ciiUtJYof8MP7/+r5nAL95A76gOhQTtFexFQXtUOIA0jN5cF/3h9bYgs0EjgArtIsNg0ZRkRCbJzDGZEFIXUPqzO3CbWgU8vjmfTykeZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf6upqJf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759723101; x=1791259101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=daJBxd6HVKNES5hXjPzSIqGXw7yQl0iUIqP4BhOvv0g=;
  b=Jf6upqJfntxf6ywe/mp7blMp/utXsSGGug5EzUbyyieqIM8FLZWPhH6A
   hTPHROCIGBOgBydPWC+l4bfxymv2/wmqYfUmoLffi/BZ3IJwxZQnXb2Vu
   cS5yy5nrkQAGg+HpbEKWwqN09TpX1IRoQHcAJvjoL2vIjP175gdKFEq/D
   zXCt8/p9PB/VfekBTezuZf+K9wrB5b6S2otDzCuYg271dZcLNKzYx0DuZ
   gRjQgTKyvW46j7pRU2NGaiMya+ZWRNEYC3DuNpweoRsGwakutFGhH/96V
   X6rhDVdHZiykpUlLq6lT2yPHi1C4qu6/78BHyyHdiXao8zvSDDHNrj14c
   Q==;
X-CSE-ConnectionGUID: JvicdcLaSGGu3cEiripP7A==
X-CSE-MsgGUID: oCp1uAoIRlqi+KMn8lj2uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="87360482"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="87360482"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 20:58:20 -0700
X-CSE-ConnectionGUID: Ghiu5MQWQmiSHGwNBy2F9w==
X-CSE-MsgGUID: vkQGKNbETxCKAHyAfJ+K2w==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 05 Oct 2025 20:58:17 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com
Cc: yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	aik@amd.com,
	linux-kernel@vger.kernel.org,
	amerilainen@nvidia.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2] PCI/IDE: Add Address Association Register setup for downstream MMIO
Date: Mon,  6 Oct 2025 11:45:38 +0800
Message-Id: <20251006034538.2240772-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Address Association Register setup for downstream MMIO

The address ranges for RP side Address Association Registers should
cover memory addresses for all PFs/VFs/downstream devices of the DSM
device. A simple solution is to get the aggregated memory range and
prefetchable-memory range from directly connected downstream port
(either an RP or a switch port) and set into 2 Address Association
Register blocks.

Just like RID association, address associations will be set by default
if hardware sets 'Number of Address Association Register Blocks' in the
'Selective IDE Stream Capability Register' to a non-zero value.
Alternatively, TSM drivers can opt-out of the settings by zero'ing out
the probed region.

If the directly connected downstream port provides both memory range
and prefetchable-memory range but the platform only provides 1 Address
Association Register block then setup the former first. This follows the
PCI bridge specification precedent where memory is mandatory and
prefetchable-memory is optional. Priortize the mandatory one. If the
platform can't fit into the default setup, TSM drivers can always change
the setting before setup. E.g. zero'ing out the memory range so that
prefetchable-memory range could be setup.

The Address Association Register setup for Endpoint Side is still
uncertain so isn't supported in this patch.

Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 include/linux/ioport.h  |   6 +++
 include/linux/pci-ide.h |  27 ++++++++++
 include/linux/pci.h     |   5 ++
 drivers/pci/ide.c       | 115 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 144 insertions(+), 9 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index b46e42bcafe3..64776795e485 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -336,6 +336,12 @@ static inline bool resource_union(const struct resource *r1, const struct resour
 	return true;
 }
 
+/* Check if this resource is added to a resource tree or detached. */
+static inline bool resource_assigned(struct resource *res)
+{
+	return res->parent;
+}
+
 int find_resource_space(struct resource *root, struct resource *new,
 			resource_size_t size, struct resource_constraint *constraint);
 
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index a30f9460b04a..3d130c8aaaa7 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -24,6 +24,9 @@ enum pci_ide_partner_select {
  * @rid_start: Partner Port Requester ID range start
  * @rid_start: Partner Port Requester ID range end
  * @stream_index: Selective IDE Stream Register Block selection
+ * @mem_assoc: PCI bus memory address association for targeting peer partner
+ * @pref_assoc: (optional) PCI bus prefetchable memory address association for
+ *		targeting peer partner
  * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
  *		    address and RID association registers
  * @setup: flag to track whether to run pci_ide_stream_teardown() for this
@@ -34,11 +37,35 @@ struct pci_ide_partner {
 	u16 rid_start;
 	u16 rid_end;
 	u8 stream_index;
+	struct pci_bus_region mem_assoc;
+	struct pci_bus_region pref_assoc;
 	unsigned int default_stream:1;
 	unsigned int setup:1;
 	unsigned int enable:1;
 };
 
+/**
+ * struct pci_ide_regs - Hardware register association settings for Selective
+ *			 IDE Streams
+ * @rid_1: IDE RID Association Register 1
+ * @rid_2: IDE RID Association Register 2
+ * @addr: Up to two address association blocks (IDE Address Association Register
+ *	  1 through 3) for MMIO and prefetchable MMIO
+ * @nr_addr: Number of address association blocks initialized
+ *
+ * See pci_ide_stream_to_regs()
+ */
+struct pci_ide_regs {
+	u32 rid_1;
+	u32 rid_2;
+	struct {
+		u32 assoc1;
+		u32 assoc2;
+		u32 assoc3;
+	} addr[2];
+	int nr_addr;
+};
+
 /**
  * struct pci_ide - PCIe Selective IDE Stream descriptor
  * @pdev: PCIe Endpoint in the pci_ide_partner pair
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a71f30211a5..ca97590de116 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -877,6 +877,11 @@ struct pci_bus_region {
 	pci_bus_addr_t	end;
 };
 
+static inline pci_bus_addr_t pci_bus_region_size(const struct pci_bus_region *region)
+{
+	return region->end - region->start + 1;
+}
+
 struct pci_dynids {
 	spinlock_t		lock;	/* Protects list, index */
 	struct list_head	list;	/* For IDs added at runtime */
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 851633b240e3..c835d440bfa9 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -157,8 +157,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 {
 	/* EP, RP, + HB Stream allocation */
 	struct stream_index __stream[PCI_IDE_HB + 1];
+	struct pci_bus_region pref_assoc = { 0, -1 };
+	struct pci_bus_region mem_assoc = { 0, -1 };
+	struct resource *mem, *pref;
 	struct pci_host_bridge *hb;
-	struct pci_dev *rp;
+	struct pci_dev *rp, *br;
 	int num_vf, rid_end;
 
 	if (!pci_is_pcie(pdev))
@@ -206,6 +209,21 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 	else
 		rid_end = pci_dev_id(pdev);
 
+	br = pci_upstream_bridge(pdev);
+	if (!br)
+		return NULL;
+
+	/*
+	 * Check if the device consumes memory and/or prefetch-memory. Setup
+	 * downstream address association ranges for each.
+	 */
+	mem = pci_resource_n(br, PCI_BRIDGE_MEM_WINDOW);
+	pref = pci_resource_n(br, PCI_BRIDGE_PREF_MEM_WINDOW);
+	if (resource_assigned(mem))
+		pcibios_resource_to_bus(br->bus, &mem_assoc, mem);
+	if (resource_assigned(pref))
+		pcibios_resource_to_bus(br->bus, &pref_assoc, pref);
+
 	*ide = (struct pci_ide) {
 		.pdev = pdev,
 		.partner = {
@@ -213,11 +231,16 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 				.rid_start = pci_dev_id(rp),
 				.rid_end = pci_dev_id(rp),
 				.stream_index = no_free_ptr(ep_stream)->stream_index,
+				/* Disable upstream address association */
+				.mem_assoc = { 0, -1 },
+				.pref_assoc = { 0, -1 },
 			},
 			[PCI_IDE_RP] = {
 				.rid_start = pci_dev_id(pdev),
 				.rid_end = rid_end,
 				.stream_index = no_free_ptr(rp_stream)->stream_index,
+				.mem_assoc = mem_assoc,
+				.pref_assoc = pref_assoc,
 			},
 		},
 		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
@@ -396,6 +419,61 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
 }
 
+#define SEL_ADDR1_LOWER GENMASK(31, 20)
+#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
+#define PREP_PCI_IDE_SEL_ADDR1(base, limit)			\
+	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |		\
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,		\
+		    FIELD_GET(SEL_ADDR1_LOWER, (base))) |	\
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,		\
+		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
+
+static void mem_assoc_to_regs(struct pci_bus_region *region,
+			      struct pci_ide_regs *regs, int idx)
+{
+	regs->addr[idx].assoc1 =
+		PREP_PCI_IDE_SEL_ADDR1(region->start, region->end);
+	regs->addr[idx].assoc2 = FIELD_GET(SEL_ADDR_UPPER, region->end);
+	regs->addr[idx].assoc3 = FIELD_GET(SEL_ADDR_UPPER, region->start);
+}
+
+/**
+ * pci_ide_stream_to_regs() - convert IDE settings to association register values
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ * @regs: output register values
+ */
+static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
+				   struct pci_ide_regs *regs)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int assoc_idx = 0;
+
+	memset(regs, 0, sizeof(*regs));
+
+	if (!settings)
+		return;
+
+	regs->rid_1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
+
+	regs->rid_2 = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
+		      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
+		      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
+
+	if (pdev->nr_ide_mem && pci_bus_region_size(&settings->mem_assoc)) {
+		mem_assoc_to_regs(&settings->mem_assoc, regs, assoc_idx);
+		assoc_idx++;
+	}
+
+	if (pdev->nr_ide_mem > assoc_idx &&
+	    pci_bus_region_size(&settings->pref_assoc)) {
+		mem_assoc_to_regs(&settings->pref_assoc, regs, assoc_idx);
+		assoc_idx++;
+	}
+
+	regs->nr_addr = assoc_idx;
+}
+
 /**
  * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
  * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
@@ -409,22 +487,34 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
 void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 {
 	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	struct pci_ide_regs regs;
 	int pos;
-	u32 val;
 
 	if (!settings)
 		return;
 
+	pci_ide_stream_to_regs(pdev, ide, &regs);
+
 	pos = sel_ide_offset(pdev, settings);
 
-	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, regs.rid_1);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, regs.rid_2);
 
-	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
-	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
-	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
+	for (int i = 0; i < regs.nr_addr; i++) {
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i),
+				       regs.addr[i].assoc1);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i),
+				       regs.addr[i].assoc2);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i),
+				       regs.addr[i].assoc3);
+	}
 
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
+	/* clear extra unused address association blocks */
+	for (int i = regs.nr_addr; i < pdev->nr_ide_mem; i++) {
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
+	}
 
 	/*
 	 * Setup control register early for devices that expect
@@ -447,7 +537,7 @@ EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
 void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
 {
 	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
-	int pos;
+	int pos, i;
 
 	if (!settings)
 		return;
@@ -455,6 +545,13 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
 	pos = sel_ide_offset(pdev, settings);
 
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+
+	for (i = 0; i < pdev->nr_ide_mem; i++) {
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
+	}
+
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
 	settings->setup = 0;
-- 
2.25.1


