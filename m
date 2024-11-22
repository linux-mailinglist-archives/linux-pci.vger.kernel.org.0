Return-Path: <linux-pci+bounces-17198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18A39D5A5B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E76280C34
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577FF189F4B;
	Fri, 22 Nov 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHOxelGu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0F189F32
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261870; cv=none; b=J2VWAoaVC/BsShEopAiI6FFP6o5lJYrcsU3MD0O2IozxsnRXHRS814PFl9TJD0WSRy0Pc4LAmYPIQWySNFrT3pIfmL7WriVsMmFapchYKfhhMMGIooLaRCCajm4+Ic0VqgLHbN+2Ur3jVyJBziYzzgg70CmXuF3iEFTTQ0dev0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261870; c=relaxed/simple;
	bh=vUyexQXC1vY4+ibo9vbwwaeZrvHZOYuBjyfDgTuUtFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JO9iZcqD6+SjNple+0hJqwRloXPaUlNsNqgeqpOIST4UkUe0yAZ+T9tTzQ1yT+SG+hKRFG0oVYJ6FWey4h/aXVcnDbY5M4Syf5zj+BFKBhlTA+HOA7VJZQ0QZifH9ypRyCH6Vc/U192cMAEYW1PWYSeXS/PZQRx9wnU+uHBE654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHOxelGu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261868; x=1763797868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vUyexQXC1vY4+ibo9vbwwaeZrvHZOYuBjyfDgTuUtFI=;
  b=WHOxelGun7ga+3c2JKZWJwEpDLed7v5BDkzT3HSa0+8O0/HIaXQrO+9H
   Cc61r251PENtvkhM+ElfDQWlu2gKoPqt9T03LhKtbBVYJz8gTWXUCJ0rV
   ixQDqgM7xuEKUMs7l9fdX2bdBIiphhQQNvG22wAqlBK7FBtXP00XOSo1T
   O/9xlL2mIPIVcoS5+KX2C3U8CxrXbFjaVVySLl5EgwQsVX+PGp0RMTnCH
   2bkoHDllAVSvtrT6PjwjcrCwaPXcai4MpBAiI2w7+LJEZkE6f8AwdBpiu
   epVi4Kd2sus/z8BGmI/0felfuSUU4zI5cWN+B+a8J6/GfrWJCSzzTit/T
   Q==;
X-CSE-ConnectionGUID: UQzj5ZRISCe3s87Y0flqdw==
X-CSE-MsgGUID: 8tiEDUhVSuCAfNHkxqs+Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156865"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156865"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:08 -0800
X-CSE-ConnectionGUID: uuFHHS1kRcuftLIwhsxfAg==
X-CSE-MsgGUID: ZnFxHPHLRMChAGnMnWEKuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301676"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:06 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 5/8] PCI: vmd: Replace hardcoded values with enum and defines
Date: Fri, 22 Nov 2024 09:52:12 +0100
Message-Id: <20241122085215.424736-6-szymon.durawa@linux.intel.com>
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

Add enum vmd_resource type to replace hardcoded values. Add defines for
vmd bus start number based on VMD restriction value. No functional
changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 42 ++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 24ca19a28ba7..1cd55c3686f3 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -23,6 +23,10 @@
 #define VMD_MEMBAR1	2
 #define VMD_MEMBAR2	4
 
+#define VMD_RESTRICT_0_BUS_START 0
+#define VMD_RESTRICT_1_BUS_START 128
+#define VMD_RESTRICT_2_BUS_START 224
+
 #define PCI_REG_VMCAP		0x40
 #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
 #define PCI_REG_VMCONFIG	0x44
@@ -34,6 +38,13 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+enum vmd_resource {
+	VMD_RES_CFGBAR = 0, /* VMD Bus0 Config BAR */
+	VMD_RES_MBAR_1, /* VMD Bus0 Resource MemBAR 1 */
+	VMD_RES_MBAR_2, /* VMD Bus0 Resource MemBAR 2 */
+	VMD_RES_COUNT
+};
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -132,7 +143,7 @@ struct vmd_dev {
 	struct vmd_irq_list	*irqs;
 
 	struct pci_sysdata	sysdata;
-	struct resource		resources[3];
+	struct resource		resources[VMD_RES_COUNT];
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
@@ -516,7 +527,7 @@ static inline void vmd_acpi_end(void) { }
 
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
-	u16 bus, max_buses = resource_size(&vmd->resources[0]);
+	u16 bus, max_buses = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
 	u8 dev, functions, fn, hdr_type;
 	char __iomem *base;
 
@@ -564,8 +575,8 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
-	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
-	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[2];
+	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
+	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
 }
 
 static void vmd_detach_resources(struct vmd_dev *vmd)
@@ -655,13 +666,13 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 
 		switch (BUS_RESTRICT_CFG(reg)) {
 		case 0:
-			vmd->busn_start = 0;
+			vmd->busn_start = VMD_RESTRICT_0_BUS_START;
 			break;
 		case 1:
-			vmd->busn_start = 128;
+			vmd->busn_start = VMD_RESTRICT_1_BUS_START;
 			break;
 		case 2:
-			vmd->busn_start = 224;
+			vmd->busn_start = VMD_RESTRICT_2_BUS_START;
 			break;
 		default:
 			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
@@ -782,7 +793,7 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 {
 	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
 
-	vmd->resources[0] = (struct resource){
+	vmd->resources[VMD_RES_CFGBAR] = (struct resource){
 		.name = "VMD CFGBAR",
 		.start = vmd->busn_start,
 		.end = vmd->busn_start + (resource_size(res) >> 20) - 1,
@@ -801,7 +812,8 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
  *
  * Function fills resource buffer inside the VMD structure.
  */
-static void vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
+static void vmd_configure_membar(struct vmd_dev *vmd,
+				 enum vmd_resource resource_number,
 				 u8 membar_number, resource_size_t start_offset,
 				 resource_size_t end_offset)
 {
@@ -837,9 +849,11 @@ static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 {
 	LIST_HEAD(resources);
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
+	pci_add_resource(&resources, &vmd->resources[VMD_RES_CFGBAR]);
+	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_1],
+				offset[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
+				offset[1]);
 
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
@@ -1091,8 +1105,8 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_remove_root_bus(vmd->bus);
 
 	/* CFGBAR is static, does not require releasing memory */
-	kfree(vmd->resources[1].name);
-	kfree(vmd->resources[2].name);
+	kfree(vmd->resources[VMD_RES_MBAR_1].name);
+	kfree(vmd->resources[VMD_RES_MBAR_2].name);
 
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
-- 
2.39.3


