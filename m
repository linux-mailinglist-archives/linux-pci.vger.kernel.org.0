Return-Path: <linux-pci+bounces-17196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FD9D5A55
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504BFB23180
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83418133F;
	Fri, 22 Nov 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZouATo1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799D17DFE0
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261863; cv=none; b=AzIdTNEifsYBCqXX1GXzmZe2INHy3C5FLf+vx0m5UTw8TXOTKESA3hg1opNmC5VcbBHgzrRhRbuXIsFVP+0yLDcOfnWq/X0YjERr5nZnMOS01uLQuRyX4GwAam72UascrylCF8w9Puobh4bmByQ2fQ5TdESVFCSUMHyK7ROOYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261863; c=relaxed/simple;
	bh=qtEgykn61K7e2fFHwpoVA/qTyRjaiMysvp9hNjuT8HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLvRzZSdWkzRr56PyJ8JU3fdplrrT6eunlNrvfazzz3mJL9tlmvmwFPLqn89nnd75f4z49yYEgecvb60omp+dlXRf0/7uXNUPagw4P0ZfBKTn9tV++wqcnVnaeXnxFFMzzdKLIs/G5R0SydfO3KB4yHrlC15jCrwcsJjwkos7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZouATo1v; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261862; x=1763797862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qtEgykn61K7e2fFHwpoVA/qTyRjaiMysvp9hNjuT8HA=;
  b=ZouATo1vOAAE46nWImi2pnawdNM/NqhR+G8pcBYX4aB3iz2xITJ6n9t0
   MZ/lLQ8R0EjCBQgbAz8qeTt1xYr0mMrGqxnKdgURgFxBJa4CDo+FO1lOv
   myw4aY3EfQqPB5cTeBBhockDuKZeWNRpmT2A61tBBZycBh+zYGs+lvQrR
   S54imXOJi7GWPFM5n3TjPuLFCMGnIGaOVwS9qshySB9grDuZc5YJbJPrh
   f3h2YdBGsm2W2zxjPwnZFkRwzH6qNYHoYjGEm4tuhfPWrAZsQTuyznbIN
   xyq7+myWVsd1nRPcCSvjrFEaq4hH8zmpCB/dE3CvPeWCCCHmLQS6bo8xi
   A==;
X-CSE-ConnectionGUID: KSSFpPdGSOKDhtIf2JSV6g==
X-CSE-MsgGUID: fUguWWQFTGS7JOMJRNetWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156845"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156845"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:01 -0800
X-CSE-ConnectionGUID: 9F4bmDhBR1WPq44FGfcHnA==
X-CSE-MsgGUID: k1ysoP0dTYSKiml1htL4GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301651"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:50:59 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 3/8] PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()
Date: Fri, 22 Nov 2024 09:52:10 +0100
Message-Id: <20241122085215.424736-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
References: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the MEMBAR1 and MEMBAR2 registry initialization code to new helpers
vmd_configure_membar() and vmd_configure_membar1_membar2(). No functional
changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 80 ++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index bb09114068f5..240be800ae96 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -790,6 +790,48 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 	};
 }
 
+/*
+ * vmd_configure_membar - Configure VMD MemBAR register, which points
+ * to MMIO address assigned by the OS or BIOS.
+ * @vmd: the VMD device
+ * @resource_number: resource buffer number to be filled in
+ * @membar_number: number of the MemBAR
+ * @start_offset: 4K aligned offset applied to start of VMD’s MEMBAR MMIO space
+ * @end_offset: 4K aligned offset applied to end of VMD’s MEMBAR MMIO space
+ *
+ * Function fills resource buffer inside the VMD structure.
+ */
+static void vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
+				 u8 membar_number, resource_size_t start_offset,
+				 resource_size_t end_offset)
+{
+	u32 upper_bits;
+	unsigned long flags;
+
+	struct resource *res = &vmd->dev->resource[membar_number];
+
+	upper_bits = upper_32_bits(res->end);
+	flags = res->flags & ~IORESOURCE_SIZEALIGN;
+	if (!upper_bits)
+		flags &= ~IORESOURCE_MEM_64;
+
+	vmd->resources[resource_number] = (struct resource){
+		.name = kasprintf(GFP_KERNEL, "VMD MEMBAR%d",
+				  membar_number / 2),
+		.start = res->start + start_offset,
+		.end = res->end - end_offset,
+		.flags = flags,
+		.parent = res,
+	};
+}
+
+static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
+					  resource_size_t mbar2_ofs)
+{
+	vmd_configure_membar(vmd, 1, VMD_MEMBAR1, 0, 0);
+	vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -841,9 +883,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct resource *res;
-	u32 upper_bits;
-	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
@@ -890,36 +929,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 *
 	 * The only way we could use a 64-bit non-prefetchable MEMBAR is
 	 * if its address is <4GB so that we can convert it to a 32-bit
-	 * resource.  To be visible to the host OS, all VMD endpoints must
+	 * resource. To be visible to the host OS, all VMD endpoints must
 	 * be initially configured by platform BIOS, which includes setting
-	 * up these resources.  We can assume the device is configured
+	 * up these resources. We can assume the device is configured
 	 * according to the platform needs.
 	 */
-	res = &vmd->dev->resource[VMD_MEMBAR1];
-	upper_bits = upper_32_bits(res->end);
-	flags = res->flags & ~IORESOURCE_SIZEALIGN;
-	if (!upper_bits)
-		flags &= ~IORESOURCE_MEM_64;
-	vmd->resources[1] = (struct resource) {
-		.name  = "VMD MEMBAR1",
-		.start = res->start,
-		.end   = res->end,
-		.flags = flags,
-		.parent = res,
-	};
-
-	res = &vmd->dev->resource[VMD_MEMBAR2];
-	upper_bits = upper_32_bits(res->end);
-	flags = res->flags & ~IORESOURCE_SIZEALIGN;
-	if (!upper_bits)
-		flags &= ~IORESOURCE_MEM_64;
-	vmd->resources[2] = (struct resource) {
-		.name  = "VMD MEMBAR2",
-		.start = res->start + membar2_offset,
-		.end   = res->end,
-		.flags = flags,
-		.parent = res,
-	};
+	vmd_configure_membar1_membar2(vmd, membar2_offset);
 
 	sd->vmd_dev = vmd->dev;
 	sd->domain = vmd_find_free_domain();
@@ -1060,6 +1075,11 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_stop_root_bus(vmd->bus);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus);
+
+	/* CFGBAR is static, does not require releasing memory */
+	kfree(vmd->resources[1].name);
+	kfree(vmd->resources[2].name);
+
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
-- 
2.39.3


