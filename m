Return-Path: <linux-pci+bounces-41040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047BEC55678
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393F83B2698
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788D2E173E;
	Thu, 13 Nov 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUufYB8l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CF2DEA78
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000048; cv=none; b=Y+ohlsKApm3FKT+3hGehF8Fxdmiokg4eofXhncwEayRaHsFv92h2cKWJLVPQockTHnNF+qzfTjO4qRXOjD99hrjGGRoYzl+zt32dR0LeRdSjTDDiENNWlz+6+qX5yn3wpOUrIYkOJ0d/E6ixUtAK0nxAu2oSDifXtJQxVEpBqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000048; c=relaxed/simple;
	bh=jltJSvEtsSZgsLd83tyslY+dT0ke25A/T24A2Lf0ISU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9QPnZShImzVnkQXtST+km7i3DVnVDNEklBTciHUjs+uhmhc4pgHzt1RTjMW6RofHeEgRFGKiO2NI/11oY8n79ih3fl2nlD/k37lIElasKANmybHpKln59kvYSwCx/woVgpJEcj43uukPta30u4ElrwsjgkEzAbTb74VysAVn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUufYB8l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000048; x=1794536048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jltJSvEtsSZgsLd83tyslY+dT0ke25A/T24A2Lf0ISU=;
  b=JUufYB8lzI7H7Pds++wt6f8LpGOKUxnYTBE/1aIbJm6Ii58GSwjgN/gO
   j/k4txKfcybNv0yuPTA+Y5uTxgYcbsPOTdBK2AoruJZXhIpB47b5nu1s9
   PQbNKihqZn+xRUuFhby7w+w3ZzXTGRR4pW5IJ24B+xZ30PRKp6eX1K1Wt
   ZoPYqSODVpgdxwyPtBTqoXtSTewKhjJC1HEkVJpr//TTEJRP9foY/z3Xx
   tZdGEHnIKFjc1Da6Uc0uX/GzMFZZARiGMQYZdTOBBnlwrkYh4QSJGHDJe
   4PpFUErdbQlq3uM+HnohIEfpax+vHD/S71u7LtSHim9FrE3ek97ACj+8P
   A==;
X-CSE-ConnectionGUID: HvWlPWaTTKGpvH2zlmpHag==
X-CSE-MsgGUID: ndWV6n0CROmcIWTFeQeI7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471767"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471767"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:05 -0800
X-CSE-ConnectionGUID: EaV1RFuoQcK3J+i4o75Kmg==
X-CSE-MsgGUID: NuS/OXeiRF64FPcQFkEQvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802495"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arto Merilainen <amerilainen@nvidia.com>
Subject: [PATCH v2 4/8] PCI/IDE: Add Address Association Register setup for downstream MMIO
Date: Wed, 12 Nov 2025 18:14:42 -0800
Message-ID: <20251113021446.436830-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-1-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/pci-ide.h |  32 +++++++++++
 include/linux/pci.h     |   5 ++
 drivers/pci/ide.c       | 115 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 143 insertions(+), 9 deletions(-)

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
index da5b1acccbb4..d7fc741f3a26 100644
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
@@ -385,6 +408,61 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
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
@@ -398,22 +476,34 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
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
@@ -436,7 +526,7 @@ EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
 void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
 {
 	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
-	int pos;
+	int pos, i;
 
 	if (!settings)
 		return;
@@ -444,6 +534,13 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
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
2.51.1


