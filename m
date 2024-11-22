Return-Path: <linux-pci+bounces-17201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56F9D5A62
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3B6B23980
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F1317C992;
	Fri, 22 Nov 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzPh83XF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F39189F48
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261881; cv=none; b=O+IAFZAhHg53ddnqnj49to3Mk+kyQLwGLcTsw3MuQl3rVi/VaO5e3c8XkpM1yuvyvXC+fEuxxomkXz+kpwC4Ffyy2sHreUm7gmEFLONjogJ7HcVxyfR1Hl7/wOnyAJNTRmGH5/KgWRqp1uAi5wZFIvkhLILV7xadlf5mxSkrEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261881; c=relaxed/simple;
	bh=76KQkcTQFNUF3vyRhFY4U35pGp30sPnRO2R4D5U950g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLL3aYW1FarAQ5C+1aq+lUAWblnRyj+Xxhm5Mo9gJRALwuxdAMeyiciz6SUqyVlRSDSAaf6qI4rW/9hBBB/mcrn4mAkLwB47onbmcmzh5CogRfGG7inuxpivurWwo39tqTkXv3KDegQVbxkGAFPkm/09b6raxkJo7UrjOr2r4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzPh83XF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261880; x=1763797880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76KQkcTQFNUF3vyRhFY4U35pGp30sPnRO2R4D5U950g=;
  b=HzPh83XFQ20bCm3gkARHLIZi6z9Rk647z/bivicLt02aU+OQn6g6955M
   3qKidHlgUS5QYQdWYOukqmHAFpV0kdQ62Qr0EH7dwnu+l7WwrdY7gMi2j
   /3iG+3jFF7y+l2x18ZLxCWGIWyl3hQvJtrrf2gsOKZpcXq+Bw/pja/KVe
   XCRuDZpnJyrfIhICxq0P5fks+T9Q1tGFvcu9wl8LYdyVou09zGnWq0I3k
   IiEtvahVaT2A8nZb4wqoQoUAZWYxhXnUpPsrop+yZKVk5gqgu5Pn2NvWu
   WH5Ww9a9cXh8zSmUwygv7s/f4zkwI7Wc1j9ZU7KBBIYKLk7xttHK5sn3e
   w==;
X-CSE-ConnectionGUID: 03kmFM5hQn6wqSlPprLjkA==
X-CSE-MsgGUID: 6096okw3QMytpaIz0UHTkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156895"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156895"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:19 -0800
X-CSE-ConnectionGUID: sm5clgXkR+OBblrK6F5Kzw==
X-CSE-MsgGUID: WV1w4qD4TA+OquSW2wZPdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301716"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:17 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 8/8] PCI: vmd: Add workaround for bus number hardwired to fixed non-zero value
Date: Fri, 22 Nov 2024 09:52:15 +0100
Message-Id: <20241122085215.424736-9-szymon.durawa@linux.intel.com>
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

VMD BUS1 rootbus primary number is 0x80 and pci_scan_bridge_extend()
detects that primary bus number doesn't match the bus it's sitting on.
As a result primary  rootbus number is deconfigured in the first pass
of pci_scan_bridge() to be re-assigned to 0x0 in the second pass.

To avoid bus number reconfiguration, BUS1 number has to be the same
as BUS1 primary number.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 6cd14c28fd4e..3b74cb8dd023 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -421,8 +421,22 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
-	unsigned int busnr_ecam = bus->number - vmd->busn_start[VMD_BUS_0];
-	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
+	unsigned char bus_number;
+	unsigned int busnr_ecam;
+	u32 offset;
+
+	/*
+	 * VMD workaraund: for BUS1, bus->number is set to VMD_PRIMARY_BUS1
+	 * (see comment under vmd_create_bus() for BUS1) but original value
+	 * is 225 which is stored in vmd->busn_start[VMD_BUS_1].
+	 */
+	if (vmd->bus1_rootbus && bus->number == VMD_PRIMARY_BUS1)
+		bus_number = vmd->busn_start[VMD_BUS_1];
+	else
+		bus_number = bus->number;
+
+	busnr_ecam = bus_number - vmd->busn_start[VMD_BUS_0];
+	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
 		return NULL;
@@ -1170,6 +1184,18 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		 */
 		vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_BUS1;
 
+		/*
+		 * This is a workaround for pci_scan_bridge_extend() code.
+		 * It detects that non-zero (0x80) primary bus number doesn't
+		 * match the bus it's sitting on. As a result rootbus number is
+		 * deconfigured in the first pass of pci_scan_bridge() to be
+		 * re-assigned to 0x0 in the second pass.
+		 * Update vmd->bus[VMD_BUS_1]->number and
+		 * vmd->bus[VMD_BUS_1]->primary to the same value, which
+		 * bypasses bus number reconfiguration.
+		 */
+		vmd->bus[VMD_BUS_1]->number = VMD_PRIMARY_BUS1;
+
 		WARN(sysfs_create_link(&vmd->dev->dev.kobj,
 				       &vmd->bus[VMD_BUS_1]->dev.kobj,
 				       "domain1"),
-- 
2.39.3


