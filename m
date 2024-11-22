Return-Path: <linux-pci+bounces-17195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A19D5A53
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1531F2347A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA917AE00;
	Fri, 22 Nov 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTXoCA4G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2C166F26
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261859; cv=none; b=YWC6sc5kzf2IEJnwm6TSQ4BfFZaKovfPsJ+sJm+wxLyIARb3psWZLAGLTngZmaYMns7d2S19JYojJiKO/kKKEIfwAJPYeAfYI/AhOgnBoAN2ZmHqnK58SDXevO80qkgufFRf33LdXX3i7nbadE3jiDxJjWFXt0/BTG1G/rApNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261859; c=relaxed/simple;
	bh=diyyFkRFsnHMtBwhlD2nl8ygTX7RBDpPre7ieomvH5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2cp5cDg/dCKeCUnYVnlAByYnSHibJyOpmAxSOEvHkh7NpVOYd63vmSjrS/rT83UH75sJzty127qIfW/cdfsSM9lR07NKbmGy7W2kvMVxQmnYnjXij4Y/VOazEj3mbap0OQjKaGOdRfenkGn4l7xEBFXGOGcAb23CHETxsHbkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTXoCA4G; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261859; x=1763797859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=diyyFkRFsnHMtBwhlD2nl8ygTX7RBDpPre7ieomvH5o=;
  b=eTXoCA4GD7Ph2WVv5aCWUSaCnbrSbk72ySYpH+gjNBKvZO+2IgjdNTwW
   DTlRGu/623K0IFPrwy4Ep3XSiZpGcTD2TkNWFwxGw0nwJiGOiSruzdUje
   ZhMiB98GjC+39vTnFuke9CpQTExH4DpH9dbEwmyRipdAWziGh7d3lok8T
   IXoIH+mRGw1XGR/vQVCu/cTonaVYcLB52geTHorUM32AFWMQlC0XESX7X
   3xayQ5hNt2ECRerVWVWw9Snl8x/+syv5oEETzGylx7rxySFaHUTaw2N0h
   gkT473OFF/MJ54TkcMbtBqa4YJX1MqWxar5/+JCWvoyRy8giZz5aqvARo
   w==;
X-CSE-ConnectionGUID: mh/42Pt1Tna1rRNx/5f+ww==
X-CSE-MsgGUID: 8XOyLJddRryD6J2im2rJIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156831"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156831"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:50:58 -0800
X-CSE-ConnectionGUID: gZUw4heTSAGqlYBkBVUTDg==
X-CSE-MsgGUID: sNXxoAD3RiqQJO7uwE9lfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301635"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:50:56 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 2/8] PCI: vmd: Add vmd_configure_cfgbar()
Date: Fri, 22 Nov 2024 09:52:09 +0100
Message-Id: <20241122085215.424736-3-szymon.durawa@linux.intel.com>
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

Move the VMD CFGBAR initialization code to a new helper
vmd_configure_cfgbar(). No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index fb66910f9204..bb09114068f5 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -778,6 +778,18 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	return 0;
 }
 
+static void vmd_configure_cfgbar(struct vmd_dev *vmd)
+{
+	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
+
+	vmd->resources[0] = (struct resource){
+		.name = "VMD CFGBAR",
+		.start = vmd->busn_start,
+		.end = vmd->busn_start + (resource_size(res) >> 20) - 1,
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -864,13 +876,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			return ret;
 	}
 
-	res = &vmd->dev->resource[VMD_CFGBAR];
-	vmd->resources[0] = (struct resource) {
-		.name  = "VMD CFGBAR",
-		.start = vmd->busn_start,
-		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
-		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
-	};
+	vmd_configure_cfgbar(vmd);
 
 	/*
 	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
-- 
2.39.3


