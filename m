Return-Path: <linux-pci+bounces-17199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C622B9D5A5D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E80B238B4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D8185B4D;
	Fri, 22 Nov 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qi6r3NiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31A18A6C3
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261873; cv=none; b=t6fplfUYO4UEOgeegRojNGWGi9qDiUlAQ26S/hQM8aejPjcCoz9ICLc51JOfzaUFQlkDQB6zNoLRvz99xR433fTG82TvmUHUUSSdqkMabWumBzHRJ7yihA+5ogfkSAXL1riHDAy5iPc7Uv1CCasr+QAn9yEBC16k/i8MDcGdxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261873; c=relaxed/simple;
	bh=u6dNy0VKAxxVzrmtq1KTAiKG4i0N9UITP4zAQjTiv08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9+ursdYiB79BUb7OuekgmyFWc38QbHJ5kqjkHny+4foL/e7LZVpFBfgR8L0/k/YYW2RVsGsUJHc6k49o6+L87GEnUCpp2u1GPuRXZfCNVB7Jn0hEK8Af/b/PFR+E9dnV5EmkPSMvf5UTLlevP+RGMuBL5h+5SvkawzD+N+tMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qi6r3NiC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261871; x=1763797871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6dNy0VKAxxVzrmtq1KTAiKG4i0N9UITP4zAQjTiv08=;
  b=Qi6r3NiC1egWOkXsmIGCStJ6FhODQWz5U1UNK63bI5e/nYMp9qRoq3vF
   4fahmgoNC4p/IHLRLoRGOrD4By+ORNPXZm5MObVVL9hOmC0d7bjbycgVu
   k6equlqZdAJj1F0X/i8AcwqXz/ZNnxelT5XWwFj5D21wWqoX6J6fQRGR6
   N5i36UQBWr67N/uawg726T7tKQYCTEDl/7H/F/2fFWM9H/FZANJfWFRDy
   IPkF8GbJrZI7YP/CQF+Ni6NyGylmjFml65RfnK5Qg7dRkXy52NBgRfkDz
   GVQYQb89WyhtJbZtWHGWPpgfGw9ZyWHrTj5MKL7vA2KVbuHeRthE3/T0G
   Q==;
X-CSE-ConnectionGUID: vYbGXeDqRNecx1Scv8qF/Q==
X-CSE-MsgGUID: GftnSFBoSUOdFQwMharirw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156881"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156881"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:11 -0800
X-CSE-ConnectionGUID: 2lcGcvThTO+OycOq6hulig==
X-CSE-MsgGUID: CDRy7n1pSxSlHBftfkPBxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301694"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:09 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 6/8] PCI: vmd: Convert bus and busn_start to an array
Date: Fri, 22 Nov 2024 09:52:13 +0100
Message-Id: <20241122085215.424736-7-szymon.durawa@linux.intel.com>
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

Convert bus and busn_start from scalar to an array to support
multiple VMD buses in the future. No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 49 +++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1cd55c3686f3..6d8397b5ebee 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -45,6 +45,11 @@ enum vmd_resource {
 	VMD_RES_COUNT
 };
 
+enum vmd_rootbus {
+	VMD_BUS_0 = 0,
+	VMD_BUS_COUNT
+};
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -145,8 +150,8 @@ struct vmd_dev {
 	struct pci_sysdata	sysdata;
 	struct resource		resources[VMD_RES_COUNT];
 	struct irq_domain	*irq_domain;
-	struct pci_bus		*bus;
-	u8			busn_start;
+	struct pci_bus		*bus[VMD_BUS_COUNT];
+	u8			busn_start[VMD_BUS_COUNT];
 	u8			first_vec;
 	char			*name;
 	int			instance;
@@ -389,7 +394,7 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
-	unsigned int busnr_ecam = bus->number - vmd->busn_start;
+	unsigned int busnr_ecam = bus->number - vmd->busn_start[VMD_BUS_0];
 	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
@@ -666,13 +671,13 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
 		switch (BUS_RESTRICT_CFG(reg)) {
 		case 0:
-			vmd->busn_start = VMD_RESTRICT_0_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_0_BUS_START;
 			break;
 		case 1:
-			vmd->busn_start = VMD_RESTRICT_1_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_1_BUS_START;
 			break;
 		case 2:
-			vmd->busn_start = VMD_RESTRICT_2_BUS_START;
+			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
 			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
@@ -795,8 +800,9 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 
 	vmd->resources[VMD_RES_CFGBAR] = (struct resource){
 		.name = "VMD CFGBAR",
-		.start = vmd->busn_start,
-		.end = vmd->busn_start + (resource_size(res) >> 20) - 1,
+		.start = vmd->busn_start[VMD_BUS_0],
+		.end = vmd->busn_start[VMD_BUS_0] +
+		       (resource_size(res) >> 20) - 1,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
 }
@@ -855,22 +861,24 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
 				offset[1]);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
+	vmd->bus[VMD_BUS_0] = pci_create_root_bus(&vmd->dev->dev,
+						  vmd->busn_start[VMD_BUS_0],
+						  &vmd_ops, sd, &resources);
+	if (!vmd->bus[VMD_BUS_0]) {
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
 	}
 
-	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
+	vmd_copy_host_bridge_flags(
+		pci_find_host_bridge(vmd->dev->bus),
+		to_pci_host_bridge(vmd->bus[VMD_BUS_0]->bridge));
 
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev, vmd->irq_domain);
 	else
-		dev_set_msi_domain(&vmd->bus->dev,
+		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
 	return 0;
@@ -1020,10 +1028,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return ret;
 	}
 
-	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
-			       "domain"), "Can't create symlink to domain\n");
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj,
+			       &vmd->bus[VMD_BUS_0]->dev.kobj, "domain"),
+	     "Can't create symlink to domain\n");
 
-	vmd_bus_enumeration(vmd->bus, features);
+	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
 
 	return 0;
 }
@@ -1100,9 +1109,9 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
-	pci_stop_root_bus(vmd->bus);
+	pci_stop_root_bus(vmd->bus[VMD_BUS_0]);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
-	pci_remove_root_bus(vmd->bus);
+	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
 
 	/* CFGBAR is static, does not require releasing memory */
 	kfree(vmd->resources[VMD_RES_MBAR_1].name);
-- 
2.39.3


