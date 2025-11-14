Return-Path: <linux-pci+bounces-41197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F9C5ADE8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 02:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F32E04E1621
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 01:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99C611CA0;
	Fri, 14 Nov 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMZM95nd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593392192EA
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763082107; cv=none; b=TEbIJ6vwGOsrYpibXtJgwVJl9yvgr0kqAUByazCS/ge85MZAFQvjGf2twmDKo6aoWd+tIwMBUHABdN9tYmz90/kVtr7LxYqTW/gIc8bCQaq/sUXHtKBtRgViHr+ak7rcX00dh+s30KqgEw5UoLyAM1hJvumexktvJpAZ+dMMzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763082107; c=relaxed/simple;
	bh=MtUKqYGKde1czohfUDsFsJOWKAWJvM4fSRI6/y+ZFC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgpVks7dDl1GOPoXTcqNK38a5Mn3QyE8jEh7FeKP9NgXoqCXaGe6KlYTS+svha8LNxsofb0KteCmo3aWMTLCvQs/ojSvdCNmGlT6YcHaTA2ecdsLvytNPgST0MfMvtb4lz7J2W8CIhPCFrB5TjHX6oxOMh1y3YuJHuzz45Ayatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMZM95nd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763082105; x=1794618105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MtUKqYGKde1czohfUDsFsJOWKAWJvM4fSRI6/y+ZFC8=;
  b=WMZM95ndSOb/Au7lkIYda6W/G5ukhgonOCUngzE+v+8ZMJZTw8ROgFoQ
   6Gfea/A4ErrmUbuzJL5K7Hkh8hdTa6duz5edaj+vKnYSO7bvk4+BBYsY3
   9j1kg0GrMGJniYvHcm84HUPyEZ/EycwZyJuzN7wWWmlpz8C8ogasvFzz7
   uTU6+fpZCQctGxC2Gw6yECM7dqYCqQ3NTQMV/gsl7WktetkJOjRVOpSpY
   NngQz9TLoIla98LPWRzB05EuRhdWmWUg5YAz6o5A4WEZYh3bsW7/jQFVU
   QAOJ7zt3UIA+naOk/kCOI60g3zG/oah61k/We/a6ye3jAMW0XcFMiLvVS
   A==;
X-CSE-ConnectionGUID: CFGILXb7T5aKXpuHUvfuUw==
X-CSE-MsgGUID: 6jkjWb2PSwOKdGXADR2BXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68802594"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="68802594"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 17:01:44 -0800
X-CSE-ConnectionGUID: RLZJzny8R+aQzdQxRcovSA==
X-CSE-MsgGUID: Tq1km/tyQ8O61U9a8eFeEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="226985894"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 13 Nov 2025 17:01:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arto Merilainen <amerilainen@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 4/8] PCI/IDE: Add Address Association Register setup for downstream MMIO
Date: Thu, 13 Nov 2025 17:02:27 -0800
Message-ID: <20251114010227.567693-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-5-dan.j.williams@intel.com>
References: <20251113021446.436830-5-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

The address ranges for downstream Address Association Registers need to
cover memory addresses for all functions (PFs/VFs/downstream devices)
managed by a Device Security Manager (DSM). The proposed solution is get
the memory (32-bit only) range and prefetchable-memory (64-bit capable)
range from the immediate ancestor downstream port (either the direct-attach
RP or deepest switch port when switch attached).

Similar to RID association, address associations will be set by default if
hardware sets 'Number of Address Association Register Blocks' in the
'Selective IDE Stream Capability Register' to a non-zero value. TSM drivers
can opt-out of the settings by zero'ing out unwanted / unsupported address
ranges. E.g. TDX Connect only supports prefetachable (64-bit capable)
memory ranges for the Address Association setting.

If the immediate downstream port provides both a memory range and
prefetchable-memory range, but the IDE partner port only provides 1 Address
Association Register block then the TSM driver can pick which range to
associate, or let the PCI core prioritize memory.

Note, the Address Association Register setup for upstream requests is still
uncertain so is not included.

Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20251113021446.436830-5-dan.j.williams@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2:

Fix a build error when pci_bus_addr_t is a 32-bit value (0day)

 include/linux/pci-ide.h |  32 +++++++++++
 include/linux/pci.h     |   5 ++
 drivers/pci/ide.c       | 117 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index d0f10f3c89fc..93194338e4d0 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -28,21 +28,53 @@ enum pci_ide_partner_select {
  * @rid_start: Partner Port Requester ID range start
  * @rid_end: Partner Port Requester ID range end
  * @stream_index: Selective IDE Stream Register Block selection
+ * @mem_assoc: PCI bus memory address association for targeting peer partner
+ * @pref_assoc: PCI bus prefetchable memory address association for
+ *		targeting peer partner
  * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
  *		    address and RID association registers
  * @setup: flag to track whether to run pci_ide_stream_teardown() for this
  *	   partner slot
  * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
+ *
+ * By default, pci_ide_stream_alloc() initializes @mem_assoc and @pref_assoc
+ * with the immediate ancestor downstream port memory ranges (i.e. Type 1
+ * Configuration Space Header values). Caller may zero size ({0, -1}) the range
+ * to drop it from consideration at pci_ide_stream_setup() time.
  */
 struct pci_ide_partner {
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
+ * @rid1: IDE RID Association Register 1
+ * @rid2: IDE RID Association Register 2
+ * @addr: Up to two address association blocks (IDE Address Association Register
+ *	  1 through 3) for MMIO and prefetchable MMIO
+ * @nr_addr: Number of address association blocks initialized
+ *
+ * See pci_ide_stream_to_regs()
+ */
+struct pci_ide_regs {
+	u32 rid1;
+	u32 rid2;
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
index 2c8dbae4916c..ba39ca78b382 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -870,6 +870,11 @@ struct pci_bus_region {
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
index da5b1acccbb4..2e0856a4307b 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -155,8 +155,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
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
@@ -197,6 +200,21 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
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
@@ -204,11 +222,16 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
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
@@ -385,6 +408,63 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
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
+	/* convert to u64 range for bitfield size checks */
+	struct range r = { region->start, region->end };
+
+	regs->addr[idx].assoc1 = PREP_PCI_IDE_SEL_ADDR1(r.start, r.end);
+	regs->addr[idx].assoc2 = FIELD_GET(SEL_ADDR_UPPER, r.end);
+	regs->addr[idx].assoc3 = FIELD_GET(SEL_ADDR_UPPER, r.start);
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
+	regs->rid1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
+
+	regs->rid2 = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
+		     FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
+		     FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
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
@@ -398,22 +478,34 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
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
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, regs.rid1);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, regs.rid2);
 
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
@@ -436,7 +528,7 @@ EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
 void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
 {
 	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
-	int pos;
+	int pos, i;
 
 	if (!settings)
 		return;
@@ -444,6 +536,13 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
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

base-commit: a4438f06b1db15ce3d831ce82b8767665638aa2a
prerequisite-patch-id: b494ce8950cbed66695e82312da2670630e370a3
prerequisite-patch-id: 0dc62753148ccead5e13d13a344a73aafcf6b1a7
prerequisite-patch-id: d73d8429dc29238718ade8fc48f0cb96fc777d0d
-- 
2.51.1


