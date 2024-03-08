Return-Path: <linux-pci+bounces-4633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7469E875B90
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 01:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA181C20C61
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99ED5250;
	Fri,  8 Mar 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec2gjpDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B07139F
	for <linux-pci@vger.kernel.org>; Fri,  8 Mar 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709858353; cv=none; b=AQyfGhvdZNjKxsoebHYnkaHpmmRkI1TBurZ4seSjj4VK9cCX8ekMKGSuVHFteXKuO5IyH7ZXUmyFgYld7PnAZxO/r+5kAoK3AOsz0B2pXTKNGsgiDiiIpKADT9kXnPinOWqkFBieSlKyLm4B9zf9YtzdGOHbfRWeigMvu9Zvpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709858353; c=relaxed/simple;
	bh=za1GZa/Y9ARoUCQGKPENlXIM90XXuVfLOsAvIFp/1vE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUI5f+0/YE6NOXubTzT4nDmiPTPq0VbUGgqGDJXJQP4fyGDfJkTH+UQN6f282nxolWOev+TJsy9dG3BFYDjdB6xp8/VMnK4+PbFrjTN9wyO5IJ8DwNLAsboKa14zccPuEYupyXjCcckppl8x5i1jSApiqyTZr4Pbt+bNE5+STuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec2gjpDl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709858351; x=1741394351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=za1GZa/Y9ARoUCQGKPENlXIM90XXuVfLOsAvIFp/1vE=;
  b=Ec2gjpDl6pkMxsgSksnPdvkP3mraGn/I0kHGAUhoUVif+PyiRtm2ca99
   zOeRbsd2UF6l1UzfUnfzw5Ey99KGiAZ29FqfDbo77eT16nINaoptrPSCG
   gvybGCoW7yiKC5D54eqFX8H/ufHS/d8gQG+JoP+lyF24o+I0UG7Ge38rY
   y+ex5hVPburhHyJPs8fiXh1+XVILC7qiqk26ZByCoGfFCjP9gVthzt5fg
   Zgj0PobdWmWPfvTMToPn42/kQhPMvcvq/RaQVuPNwCoGgabk5UhkR1B+m
   0VgrNJwArxFvJ+ukXEcIafcmmNrCMmggzGfLuKt/8JMRmmb4m0rNjnJ0O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15705313"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="15705313"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 16:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="14964228"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 16:39:11 -0800
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	<linux-pci@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] PCI: vmd: Disable MSI remap only for low MSI count
Date: Thu,  7 Mar 2024 19:18:25 -0500
Message-Id: <20240308001825.4051-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMD MSI remapping is disabled by default for all the cpus with 28c0 VMD
device. Initially MSI remapping was disabled for 28c0 to improve
performance since VMD had only 64 vectors. Newer cpus with more VMD
vectors doesn't see performance impact anymore. Keep MSI remapping
enabled when vector count is more than active cpu in the system.

Note, pci_msix_vec_count() failure is translated to ENODEV per typical
expectations that drivers may return ENODEV when some driver-known
fundamental detail of the device is missing.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/controller/vmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..09faa77d1b1f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -807,13 +807,20 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
+	vmd->msix_count = pci_msix_vec_count(dev);
+	if (vmd->msix_count < 0)
+		return -ENODEV;
+
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
 	 * acceptable because the guest is usually CPU-limited and MSI
 	 * remapping doesn't become a performance bottleneck.
+	 * There is no need to disable MSI remapping when VMD MSI count is
+	 * more than cpus.
 	 */
 	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
+	    vmd->msix_count >= nr_cpu_ids ||
 	    offset[0] || offset[1]) {
 		ret = vmd_alloc_irqs(vmd);
 		if (ret)
-- 
2.31.1


