Return-Path: <linux-pci+bounces-15310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B379B04DD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9EA28363E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3A212168;
	Fri, 25 Oct 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II6jrq86"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DE21217B
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864854; cv=none; b=kWZI3YLabAxBHs1Sjehcm5H8NAPl00k7mTJEFnmgbUgR6mw9ovMiBoNm+xW/ZuITk9rJWlw84ov4hHxIxXxms/trFwT1RNuHwksIEDa0YVqKj84lz1WIN+mHzw43ZYW6R4t6e1082yA6I1kjddIVQ7wL07s5txtqYPcpoi2HZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864854; c=relaxed/simple;
	bh=31MjEYFO+Jy1g3Vgqg90KvVhsxgswjPjPqnmxPbRY4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJL5t5nIF8ctWk+rD1lBnmHuU3mBfF5rCGOTXRDpY6zgbw4JN0iJvw2InqbyBTJltllcw8wZBu4Kj3diSFRqqNxxtQuYbyLH70mCTEOZOPryy5F4ScUUhQqh8rDcfP1r7P7sugXURFZo7KzhxRpDAKBR1xxpHTtlNvhzxL2rA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II6jrq86; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864852; x=1761400852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31MjEYFO+Jy1g3Vgqg90KvVhsxgswjPjPqnmxPbRY4g=;
  b=II6jrq86+EEbRESJdE7yXNPeRoJ9oiEaZyQ6lM1wVpDeVcxhzuGSdYs2
   pzfnHyFxRy53G05kJ86q2Cgi/Z74Y2sze/CGzHPSzEsMTmmQ6o48Q02+l
   gIoG/5QlaMq0BqiPY+rt8RQ9LoSZvJtW3EiDpuTKCcx0h3iXXiwZIXoi3
   wG1EUjXy9jCx5neGK1LlbT6NS9XPo7bd2P/vaofH3aQCj6yMAAhUdC/gx
   ULdFaZ2blgYGxQWyojhMY6KkLw9b9L7a0Pu8SezJpTF9/QVXwFT4xhss1
   jUWK5SYA8/UwlCKrRBLiTYG1Knzve98Cogl0zCWiPMSzLxeF8Em3jHgLz
   A==;
X-CSE-ConnectionGUID: foa4DhQHSUyzgr4BO0GGbg==
X-CSE-MsgGUID: vDvmMSgNTiqcxqMvaSsnQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29752859"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29752859"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:00:51 -0700
X-CSE-ConnectionGUID: xMBed0hmTGK3TWGuU9lpMw==
X-CSE-MsgGUID: v/SVei/TRBKKwxFG0tvZww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81232301"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:00:50 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [RFC PATCH v1 2/3] PCI: vmd: Add VMD PCH rootbus support
Date: Fri, 25 Oct 2024 17:01:52 +0200
Message-Id: <20241025150153.983306-3-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241025150153.983306-1-szymon.durawa@linux.intel.com>
References: <20241025150153.983306-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from Intel Arrow Lake VMD enhacement introduces separate
rotbus for PCH. It means that all 3 MMIO BARs exposed by VMD are
shared now between CPU IOC and PCH. This patch adds PCH bus
enumeration and MMIO management for devices with VMD enhancement
support.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 176 +++++++++++++++++++++++++++++++++--
 1 file changed, 167 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 7cce7354b5c2..842b70a21325 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -31,6 +31,15 @@
 #define PCI_REG_VMLOCK		0x70
 #define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
 
+#define VMD_PRIMARY_PCH_BUS 0x80
+#define VMD_BUSRANGE0 0xC8
+#define VMD_BUSRANGE1 0xCC
+#define VMD_MEMBAR1_OFFSET 0xD0
+#define VMD_MEMBAR2_OFFSET1 0xD8
+#define VMD_MEMBAR2_OFFSET2 0xDC
+#define VMD_BUS_END(busr) ((busr >> 8) & 0xff)
+#define VMD_BUS_START(busr) (busr & 0x00ff)
+
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
@@ -38,11 +47,15 @@ enum vmd_resource {
 	VMD_RES_CFGBAR = 0,
 	VMD_RES_MBAR_1, /*VMD Resource MemBAR 1 */
 	VMD_RES_MBAR_2, /*VMD Resource MemBAR 2 */
+	VMD_RES_PCH_CFGBAR,
+	VMD_RES_PCH_MBAR_1, /*VMD Resource PCH MemBAR 1 */
+	VMD_RES_PCH_MBAR_2, /*VMD Resource PCH MemBAR 2 */
 	VMD_RES_COUNT
 };
 
 enum vmd_rootbus {
 	VMD_BUS_0 = 0,
+	VMD_BUS_1,
 	VMD_BUS_COUNT
 };
 
@@ -86,6 +99,12 @@ enum vmd_features {
 	 * proper power management of the SoC.
 	 */
 	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
+
+	/*
+	 * Starting from Intel Arrow Lake, VMD devices have their VMD rootports
+	 * connected to CPU IOC and PCH rootbuses.
+	 */
+	VMD_FEAT_HAS_PCH_ROOTBUS	= (1 << 6)
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -93,7 +112,8 @@ enum vmd_features {
 #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
 				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
 				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
-				 VMD_FEAT_BIOS_PM_QUIRK)
+				 VMD_FEAT_BIOS_PM_QUIRK |		\
+				 VMD_FEAT_HAS_PCH_ROOTBUS)
 
 static DEFINE_IDA(vmd_instance_ida);
 
@@ -376,6 +396,11 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 	}
 }
 
+static inline u8 vmd_has_pch_rootbus(struct vmd_dev *vmd)
+{
+	return vmd->busn_start[VMD_BUS_1] != 0;
+}
+
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
@@ -521,6 +546,11 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 	u8 dev, functions, fn, hdr_type;
 	char __iomem *base;
 
+	if (vmd_has_pch_rootbus(vmd)) {
+		max_buses += resource_size(&vmd->resources[VMD_RES_PCH_CFGBAR]);
+		max_buses += 2;
+	}
+
 	for (bus = 0; bus < max_buses; bus++) {
 		for (dev = 0; dev < 32; dev++) {
 			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
@@ -645,7 +675,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 	return 0;
 }
 
-static int vmd_get_bus_number_start(struct vmd_dev *vmd)
+static int vmd_get_bus_number_start(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_dev *dev = vmd->dev;
 	u16 reg;
@@ -664,6 +694,18 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 		case 2:
 			vmd->busn_start[VMD_BUS_0] = 224;
 			break;
+		case 3:
+			if (!(features & VMD_FEAT_HAS_PCH_ROOTBUS)) {
+				pci_err(dev, "VMD Bus Restriction detected type %d, but PCH Rootbus is not supported, aborting.\n",
+					BUS_RESTRICT_CFG(reg));
+				return -ENODEV;
+			}
+
+			/* IOC start bus */
+			vmd->busn_start[VMD_BUS_0] = 224;
+			/* PCH start bus */
+			vmd->busn_start[VMD_BUS_1] = 225;
+			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
 				BUS_RESTRICT_CFG(reg));
@@ -790,6 +832,30 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 		       (resource_size(res) >> 20) - 1,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
+
+	if (vmd_has_pch_rootbus(vmd)) {
+		u16 ioc_range = 0;
+		u16 pch_range = 0;
+
+		pci_read_config_word(vmd->dev, VMD_BUSRANGE0, &ioc_range);
+		pci_read_config_word(vmd->dev, VMD_BUSRANGE1, &pch_range);
+
+		/*
+		 * Resize CPU IOC CFGBAR range to make space for PCH owned
+		 * devices by adjusting range end with value stored in
+		 * VMD_BUSRANGE0 register.
+		 */
+		vmd->resources[VMD_RES_CFGBAR].start = VMD_BUS_START(ioc_range);
+		vmd->resources[VMD_RES_CFGBAR].end = VMD_BUS_END(ioc_range);
+
+		vmd->resources[VMD_RES_PCH_CFGBAR] = (struct resource){
+			.name = "VMD CFGBAR PCH",
+			.start = VMD_BUS_START(pch_range),
+			.end = VMD_BUS_END(pch_range),
+			.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+			.parent = &vmd->resources[VMD_RES_CFGBAR],
+		};
+	}
 }
 
 /**
@@ -822,7 +888,8 @@ static void vmd_configure_membar(struct vmd_dev *vmd,
 	if (!upper_bits)
 		flags &= ~IORESOURCE_MEM_64;
 
-	snprintf(name, sizeof(name), "VMD MEMBAR%d", membar_number/2);
+	snprintf(name, sizeof(name), "VMD MEMBAR%d %s", membar_number / 2,
+		 resource_number > VMD_RES_MBAR_2 ? "PCH" : "");
 
 	res_parent = parent;
 	if (!res_parent)
@@ -840,9 +907,43 @@ static void vmd_configure_membar(struct vmd_dev *vmd,
 static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 					  resource_size_t mbar2_ofs)
 {
-	vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0, NULL);
-	vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
-			     mbar2_ofs, 0, NULL);
+	if (vmd_has_pch_rootbus(vmd)) {
+		u32 pch_mbar1_ofs = 0;
+		u64 pch_mbar2_ofs = 0;
+		u32 reg;
+
+		pci_read_config_dword(vmd->dev, VMD_MEMBAR1_OFFSET,
+				      &pch_mbar1_ofs);
+
+		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET1, &reg);
+		pch_mbar2_ofs = reg;
+
+		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET2, &reg);
+		pch_mbar2_ofs |= (u64)reg << 32;
+
+		/*
+		 * Resize CPU IOC MEMBAR1 and MEMBAR2 ranges to make space
+		 * for PCH owned devices by adjusting range end with values
+		 * stored in VMD_MEMBAR1_OFFSET and VMD_MEMBAR2_OFFSET registers
+		 */
+		vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0,
+				     pch_mbar1_ofs, NULL);
+		vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
+				     mbar2_ofs, pch_mbar2_ofs - mbar2_ofs,
+				     NULL);
+
+		vmd_configure_membar(vmd, VMD_RES_PCH_MBAR_1, VMD_MEMBAR1,
+				     pch_mbar1_ofs, 0,
+				     &vmd->resources[VMD_RES_MBAR_1]);
+		vmd_configure_membar(vmd, VMD_RES_PCH_MBAR_2, VMD_MEMBAR2,
+				     mbar2_ofs + pch_mbar2_ofs, 0,
+				     &vmd->resources[VMD_RES_MBAR_2]);
+	} else {
+		vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0,
+				     NULL);
+		vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
+				     mbar2_ofs, 0, NULL);
+	}
 }
 
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
@@ -854,7 +955,9 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(bus);
-	vmd_domain_reset(vmd_from_bus(bus));
+
+	if (bus->primary == 0)
+		vmd_domain_reset(vmd_from_bus(bus));
 
 	/*
 	 * When Intel VMD is enabled, the OS does not discover the Root Ports
@@ -893,6 +996,47 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 	vmd_acpi_end();
 }
 
+static int vmd_create_pch_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
+			      resource_size_t *offset)
+{
+	LIST_HEAD(resources_pch);
+
+	pci_add_resource(&resources_pch, &vmd->resources[VMD_RES_PCH_CFGBAR]);
+	pci_add_resource_offset(&resources_pch,
+				&vmd->resources[VMD_RES_PCH_MBAR_1], offset[0]);
+	pci_add_resource_offset(&resources_pch,
+				&vmd->resources[VMD_RES_PCH_MBAR_2], offset[1]);
+
+	vmd->bus[VMD_BUS_1] = pci_create_root_bus(&vmd->dev->dev,
+						  vmd->busn_start[VMD_BUS_1],
+						  &vmd_ops, sd, &resources_pch);
+
+	if (!vmd->bus[VMD_BUS_1]) {
+		pci_free_resource_list(&resources_pch);
+		pci_stop_root_bus(vmd->bus[VMD_BUS_1]);
+		pci_remove_root_bus(vmd->bus[VMD_BUS_1]);
+		return -ENODEV;
+	}
+
+	/*
+	 * primary bus is not set by pci_create_root_bus(), it is updated here
+	 */
+	vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_PCH_BUS;
+
+	vmd_copy_host_bridge_flags(
+		pci_find_host_bridge(vmd->dev->bus),
+		to_pci_host_bridge(vmd->bus[VMD_BUS_1]->bridge));
+
+	if (vmd->irq_domain)
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_1]->dev,
+				   vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_1]->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -923,7 +1067,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * limits the bus range to between 0-127, 128-255, or 224-255
 	 */
 	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
-		ret = vmd_get_bus_number_start(vmd);
+		ret = vmd_get_bus_number_start(vmd, features);
 		if (ret)
 			return ret;
 	}
@@ -1016,6 +1160,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
 
+	if (vmd_has_pch_rootbus(vmd)) {
+		ret = vmd_create_pch_bus(vmd, sd, offset);
+		if (ret) {
+			pci_err(vmd->dev, "Can't create PCH bus: %d\n", ret);
+			return ret;
+		}
+
+		vmd_bus_enumeration(vmd->bus[VMD_BUS_1], features);
+	}
+
 	return 0;
 }
 
@@ -1094,6 +1248,10 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_stop_root_bus(vmd->bus[VMD_BUS_0]);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
+	if (vmd_has_pch_rootbus(vmd)) {
+		pci_stop_root_bus(vmd->bus[VMD_BUS_1]);
+		pci_remove_root_bus(vmd->bus[VMD_BUS_1]);
+	}
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
@@ -1179,4 +1337,4 @@ module_pci_driver(vmd_drv);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Volume Management Device driver");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION("0.6");
+MODULE_VERSION("0.7");
-- 
2.39.3


