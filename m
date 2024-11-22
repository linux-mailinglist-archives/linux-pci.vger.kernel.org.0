Return-Path: <linux-pci+bounces-17200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A469D5A5C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B31281D54
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A418733B;
	Fri, 22 Nov 2024 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICm1e6N1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2C8187855
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261877; cv=none; b=D3s8QYj4HER1LiBsfVtXp//PzteZTFPgRXiQVOis75f+xiZP6L6LprlJd1LMF4jb8hN3xRHVfSHWCE2748jGeExgYjHLkag+m7O4oe+qOB7vi0XeSli+odDA/BEX2SSQPnZ7PAjOnqDvCLv36PfnWi+iQY6zxz/d9GoEVttL9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261877; c=relaxed/simple;
	bh=RUIybfcv5ZJj+gIvsuJgLUORJSbRjrfMSlu4lMTHL10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpS4+ljc15iT9k/Q2nX3oLoorKVfzxxNL9XbL08V4VWbujGP+N8lCk/5YNvRpe1/lPmUNtxeh5x7ERC4Sk6KAh7uNAhcYQE1NeYsPjLQEGS7cFLrVAicLelTweR7UB7srx1Lq7jj+FEzu64xi4XZdt9pN0XuhpGVuhvimFOB5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICm1e6N1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261874; x=1763797874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RUIybfcv5ZJj+gIvsuJgLUORJSbRjrfMSlu4lMTHL10=;
  b=ICm1e6N1mM3q511aLIz6vP1JVp9bVY7ofBn43ssaRviNNu++KPkPpNiV
   p3kim4akuXtmSrl+plpvseHyfTRklPJEL8RHT1/cHH5g9a+5XQIk5oVyr
   N6TxXRdj9uX5WQwqa/c93Qa6JKr4QlaHDwB8oefQRSUkBVqX5j7r5yLoW
   cFa/8Lr8+12Og15Bb8F0ttnXFqBz3Ood0dDXj7KRWVmuZZ9kkYSNrIr76
   mRQ1VFlmQV4r3YithALl/vKlz+Tq9cnUIdEbgZLpR+LjobrTxj5+GpQRz
   IXSZ76qGpNQXMN84hrb8/29vUNG/7C1mbtoDgBWlg0PGG06fib1kY0LiJ
   Q==;
X-CSE-ConnectionGUID: tJPrYc3PTs+ontvAa+IlXg==
X-CSE-MsgGUID: CAbTRuBrSyGxthV/xmTTHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156889"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156889"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:14 -0800
X-CSE-ConnectionGUID: F8ZXgAHhTYu4dGM68prMnA==
X-CSE-MsgGUID: UKqjf98MQweI98Nfmp6V4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301704"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:12 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 7/8] PCI: vmd: Add support for second rootbus under VMD
Date: Fri, 22 Nov 2024 09:52:14 +0100
Message-Id: <20241122085215.424736-8-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
References: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from Intel Arrow Lake VMD enhancement introduces second rootbus
support with fixed root bus number (0x80). It means that all 3 MMIO BARs
exposed by VMD are shared now between both buses (current BUS0 and
new BUS1).

Add new BUS1 enumeration and divide MMIO space to be shared between
both rootbuses. Due to enumeration issues with rootbus hardwired to a
fixed non-zero value, this patch will work with a workaround proposed
in next patch. Without workaround user won't see attached devices for BUS1
rootbus.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 208 ++++++++++++++++++++++++++++++-----
 1 file changed, 180 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 6d8397b5ebee..6cd14c28fd4e 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -26,6 +26,7 @@
 #define VMD_RESTRICT_0_BUS_START 0
 #define VMD_RESTRICT_1_BUS_START 128
 #define VMD_RESTRICT_2_BUS_START 224
+#define VMD_RESTRICT_3_BUS_START 225
 
 #define PCI_REG_VMCAP		0x40
 #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
@@ -38,15 +39,33 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+#define VMD_PRIMARY_BUS0 0x00
+#define VMD_PRIMARY_BUS1 0x80
+#define VMD_BUSRANGE0 0xc8
+#define VMD_BUSRANGE1 0xcc
+#define VMD_MEMBAR1_OFFSET 0xd0
+#define VMD_MEMBAR2_OFFSET1 0xd8
+#define VMD_MEMBAR2_OFFSET2 0xdc
+#define VMD_BUS_END(busr) ((busr >> 8) & 0xff)
+#define VMD_BUS_START(busr) (busr & 0x00ff)
+
+/*
+ * Add VMD resources for BUS1, it will share the same MMIO space with
+ * previous VMD resources.
+ */
 enum vmd_resource {
 	VMD_RES_CFGBAR = 0, /* VMD Bus0 Config BAR */
 	VMD_RES_MBAR_1, /* VMD Bus0 Resource MemBAR 1 */
 	VMD_RES_MBAR_2, /* VMD Bus0 Resource MemBAR 2 */
+	VMD_RES_BUS1_CFGBAR, /* VMD Bus1 Config BAR */
+	VMD_RES_BUS1_MBAR_1, /* VMD Bus1 Resource MemBAR 1 */
+	VMD_RES_BUS1_MBAR_2, /* VMD Bus1 Resource MemBAR 2 */
 	VMD_RES_COUNT
 };
 
 enum vmd_rootbus {
 	VMD_BUS_0 = 0,
+	VMD_BUS_1,
 	VMD_BUS_COUNT
 };
 
@@ -90,6 +109,12 @@ enum vmd_features {
 	 * proper power management of the SoC.
 	 */
 	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
+
+	/*
+	 * Starting from Intel Arrow Lake, VMD devices have their VMD rootports
+	 * connected to additional BUS1 rootport.
+	 */
+	VMD_FEAT_HAS_BUS1_ROOTBUS	= (1 << 6)
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -97,7 +122,8 @@ enum vmd_features {
 #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
 				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
 				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
-				 VMD_FEAT_BIOS_PM_QUIRK)
+				 VMD_FEAT_BIOS_PM_QUIRK |		\
+				 VMD_FEAT_HAS_BUS1_ROOTBUS)
 
 static DEFINE_IDA(vmd_instance_ida);
 
@@ -155,6 +181,7 @@ struct vmd_dev {
 	u8			first_vec;
 	char			*name;
 	int			instance;
+	bool			bus1_rootbus;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -532,11 +559,16 @@ static inline void vmd_acpi_end(void) { }
 
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
-	u16 bus, max_buses = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
+	u16 bus, bus_cnt = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
 	u8 dev, functions, fn, hdr_type;
 	char __iomem *base;
 
-	for (bus = 0; bus < max_buses; bus++) {
+	if (vmd->bus1_rootbus) {
+		bus_cnt += resource_size(&vmd->resources[VMD_RES_BUS1_CFGBAR]);
+		bus_cnt += 2;
+	}
+
+	for (bus = 0; bus < bus_cnt; bus++) {
 		for (dev = 0; dev < 32; dev++) {
 			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
 						PCI_DEVFN(dev, 0), 0);
@@ -582,12 +614,24 @@ static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
 	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
+
+	if (vmd->bus1_rootbus) {
+		vmd->resources[VMD_RES_MBAR_1].sibling =
+			&vmd->resources[VMD_RES_BUS1_MBAR_1];
+		vmd->resources[VMD_RES_MBAR_2].sibling =
+			&vmd->resources[VMD_RES_BUS1_MBAR_2];
+	}
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = NULL;
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
+
+	if (vmd->bus1_rootbus) {
+		vmd->resources[VMD_RES_MBAR_1].sibling = NULL;
+		vmd->resources[VMD_RES_MBAR_2].sibling = NULL;
+	}
 }
 
 /*
@@ -660,7 +704,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 	return 0;
 }
 
-static int vmd_get_bus_number_start(struct vmd_dev *vmd)
+static int vmd_get_bus_number_start(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_dev *dev = vmd->dev;
 	u16 reg;
@@ -679,6 +723,19 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 		case 2:
 			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
 			break;
+		case 3:
+			if (!(features & VMD_FEAT_HAS_BUS1_ROOTBUS)) {
+				pci_err(dev, "VMD Bus Restriction detected type %d, but BUS1 Rootbus is not supported, aborting.\n",
+					BUS_RESTRICT_CFG(reg));
+				return -ENODEV;
+			}
+
+			/* BUS0 start number */
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
+			/* BUS1 start number */
+			vmd->busn_start[VMD_BUS_1] = VMD_RESTRICT_3_BUS_START;
+			vmd->bus1_rootbus = true;
+			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
 				BUS_RESTRICT_CFG(reg));
@@ -805,6 +862,30 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 		       (resource_size(res) >> 20) - 1,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
+
+	if (vmd->bus1_rootbus) {
+		u16 bus0_range = 0;
+		u16 bus1_range = 0;
+
+		pci_read_config_word(vmd->dev, VMD_BUSRANGE0, &bus0_range);
+		pci_read_config_word(vmd->dev, VMD_BUSRANGE1, &bus1_range);
+
+		/*
+		 * Resize BUS0 CFGBAR range to make space for BUS1
+		 * owned devices by adjusting range end with value stored in
+		 * VMD_BUSRANGE0 register.
+		 */
+		vmd->resources[VMD_RES_CFGBAR].start = VMD_BUS_START(bus0_range);
+		vmd->resources[VMD_RES_CFGBAR].end = VMD_BUS_END(bus0_range);
+
+		vmd->resources[VMD_RES_BUS1_CFGBAR] = (struct resource){
+			.name = "VMD CFGBAR BUS1",
+			.start = VMD_BUS_START(bus1_range),
+			.end = VMD_BUS_END(bus1_range),
+			.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+			.parent = res,
+		};
+	}
 }
 
 /*
@@ -834,8 +915,9 @@ static void vmd_configure_membar(struct vmd_dev *vmd,
 		flags &= ~IORESOURCE_MEM_64;
 
 	vmd->resources[resource_number] = (struct resource){
-		.name = kasprintf(GFP_KERNEL, "VMD MEMBAR%d",
-				  membar_number / 2),
+		.name = kasprintf(
+			GFP_KERNEL, "VMD MEMBAR%d %s", membar_number / 2,
+			resource_number > VMD_RES_MBAR_2 ? "BUS1" : ""),
 		.start = res->start + start_offset,
 		.end = res->end - end_offset,
 		.flags = flags,
@@ -846,41 +928,80 @@ static void vmd_configure_membar(struct vmd_dev *vmd,
 static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 					  resource_size_t mbar2_ofs)
 {
-	vmd_configure_membar(vmd, 1, VMD_MEMBAR1, 0, 0);
-	vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
+	if (vmd->bus1_rootbus) {
+		u32 bus1_mbar1_ofs = 0;
+		u64 bus1_mbar2_ofs = 0;
+		u32 reg;
+
+		pci_read_config_dword(vmd->dev, VMD_MEMBAR1_OFFSET,
+				      &bus1_mbar1_ofs);
+
+		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET1, &reg);
+		bus1_mbar2_ofs = reg;
+
+		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET2, &reg);
+		bus1_mbar2_ofs |= (u64)reg << 32;
+
+		/*
+		 * Resize BUS MEMBAR1 and MEMBAR2 ranges to make space
+		 * for BUS1 owned devices by adjusting range end with values
+		 * stored in VMD_MEMBAR1_OFFSET and VMD_MEMBAR2_OFFSET registers
+		 */
+		vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0,
+				     bus1_mbar1_ofs);
+		vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
+				     mbar2_ofs, bus1_mbar2_ofs - mbar2_ofs);
+
+		vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_1, VMD_MEMBAR1,
+				     bus1_mbar1_ofs, 0);
+		vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_2, VMD_MEMBAR2,
+				     mbar2_ofs + bus1_mbar2_ofs, 0);
+	} else {
+		vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0);
+		vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
+				     mbar2_ofs, 0);
+	}
 }
 
-static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
-			  resource_size_t *offset)
+static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
+			  struct pci_sysdata *sd, resource_size_t *offset)
 {
+	u8 cfgbar = bus_number * 3;
+	u8 membar1 = cfgbar + 1;
+	u8 membar2 = cfgbar + 2;
+	struct pci_bus *vmd_bus;
 	LIST_HEAD(resources);
 
-	pci_add_resource(&resources, &vmd->resources[VMD_RES_CFGBAR]);
-	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_1],
+	pci_add_resource(&resources, &vmd->resources[cfgbar]);
+	pci_add_resource_offset(&resources, &vmd->resources[membar1],
 				offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
+	pci_add_resource_offset(&resources, &vmd->resources[membar2],
 				offset[1]);
 
-	vmd->bus[VMD_BUS_0] = pci_create_root_bus(&vmd->dev->dev,
-						  vmd->busn_start[VMD_BUS_0],
-						  &vmd_ops, sd, &resources);
-	if (!vmd->bus[VMD_BUS_0]) {
+	vmd_bus = pci_create_root_bus(&vmd->dev->dev,
+				      vmd->busn_start[bus_number], &vmd_ops, sd,
+				      &resources);
+
+	if (!vmd_bus) {
 		pci_free_resource_list(&resources);
-		vmd_remove_irq_domain(vmd);
+
+		if (bus_number == VMD_PRIMARY_BUS0)
+			vmd_remove_irq_domain(vmd);
 		return -ENODEV;
 	}
 
-	vmd_copy_host_bridge_flags(
-		pci_find_host_bridge(vmd->dev->bus),
-		to_pci_host_bridge(vmd->bus[VMD_BUS_0]->bridge));
+	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+				   to_pci_host_bridge(vmd_bus->bridge));
 
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev, vmd->irq_domain);
+		dev_set_msi_domain(&vmd_bus->dev, vmd->irq_domain);
 	else
-		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev,
+		dev_set_msi_domain(&vmd_bus->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
+	vmd->bus[bus_number] = vmd_bus;
+
 	return 0;
 }
 
@@ -893,7 +1014,9 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(bus);
-	vmd_domain_reset(vmd_from_bus(bus));
+
+	if (bus->primary == VMD_PRIMARY_BUS0)
+		vmd_domain_reset(vmd_from_bus(bus));
 
 	/*
 	 * When Intel VMD is enabled, the OS does not discover the Root Ports
@@ -961,7 +1084,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * limits the bus range to between 0-127, 128-255, or 224-255
 	 */
 	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
-		ret = vmd_get_bus_number_start(vmd);
+		ret = vmd_get_bus_number_start(vmd, features);
 		if (ret)
 			return ret;
 	}
@@ -1021,7 +1144,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	ret = vmd_create_bus(vmd, sd, offset);
+	ret = vmd_create_bus(vmd, VMD_BUS_0, sd, offset);
 
 	if (ret) {
 		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
@@ -1034,6 +1157,27 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
 
+	if (vmd->bus1_rootbus) {
+		ret = vmd_create_bus(vmd, VMD_BUS_1, sd, offset);
+		if (ret) {
+			pci_err(vmd->dev, "Can't create BUS1: %d\n", ret);
+			return ret;
+		}
+
+		/*
+		 * Primary bus is not set by pci_create_root_bus(), it is
+		 * updated here
+		 */
+		vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_BUS1;
+
+		WARN(sysfs_create_link(&vmd->dev->dev.kobj,
+				       &vmd->bus[VMD_BUS_1]->dev.kobj,
+				       "domain1"),
+		     "Can't create symlink to domain1\n");
+
+		vmd_bus_enumeration(vmd->bus[VMD_BUS_1], features);
+	}
+
 	return 0;
 }
 
@@ -1113,10 +1257,18 @@ static void vmd_remove(struct pci_dev *dev)
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
 
-	/* CFGBAR is static, does not require releasing memory */
+	/* CFGBARs are static, do not require releasing memory */
 	kfree(vmd->resources[VMD_RES_MBAR_1].name);
 	kfree(vmd->resources[VMD_RES_MBAR_2].name);
 
+	if (vmd->bus1_rootbus) {
+		pci_stop_root_bus(vmd->bus[VMD_BUS_1]);
+		sysfs_remove_link(&vmd->dev->dev.kobj, "domain1");
+		pci_remove_root_bus(vmd->bus[VMD_BUS_1]);
+		kfree(vmd->resources[VMD_RES_BUS1_MBAR_1].name);
+		kfree(vmd->resources[VMD_RES_BUS1_MBAR_2].name);
+	}
+
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
@@ -1202,4 +1354,4 @@ module_pci_driver(vmd_drv);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Volume Management Device driver");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION("0.6");
+MODULE_VERSION("0.7");
-- 
2.39.3


