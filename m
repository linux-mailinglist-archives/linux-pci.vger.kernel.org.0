Return-Path: <linux-pci+bounces-17197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4DA9D5A5A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC01F2347A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26E185B7B;
	Fri, 22 Nov 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcvbflXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8D189BBA
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261869; cv=none; b=XQHH8BFoa8rhBhTOFciytuEK06SpODt5cAGsSiBHd8Akvybwi+IiWKOApR+vcty1Ige5eW6ZYMyNcGblJMtrulqqpPI29tTUE32fADBVamEPXdDCzyyqhR0n45Ov4nH7DMhgUAnBvfNCJnMoip1O5B4bkxc6ayjFjeztxyvpLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261869; c=relaxed/simple;
	bh=3Mgp6dlUFfVDt8/DzVLC+bpjwKWY72oDMKYB3Be9j1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdnut2F1CJDTDn5pZYlM34xPJ7WKhaKerwSVZMNTGCE3Sk08K96yX/nNUobrcSo6PScfAkJXQxc2L6sY+KpvKQTW7tXvWaKh3qQdutFMkvQQguX+QbbHdBNOOv90Hv1KnPN8ILQW80JLU3xbPZxmldR3LZiXX8DEtEU33QhA4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcvbflXT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261867; x=1763797867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Mgp6dlUFfVDt8/DzVLC+bpjwKWY72oDMKYB3Be9j1Q=;
  b=UcvbflXTd7+fndADUrFfbJV8SO5bSsruoMzoWOESKvcfKxBanG0vqT4z
   Fj7XOV/dSj7Qg4v40nfYvD9URX2/9OKCQd+n46uPqn/gGKP5d5DxsB6IJ
   2eAZewd0cjwhzp13DMRVjp1e2CLySD1uEtMvwhUxpcWjsYEWZDOqjINR0
   p05jPEyK+f74lyA5DX6vPsggFBBbwv8LBJq0kVVZEtRmn97bCAZdISv2Y
   l+kjoN8Y7gxBMF5llfDEShJ4QDMCVL42SFvFjj1C0KUAcGG8nzkZYg8bn
   B9tPAySXjASzgnPQy92QBnn/ZOIFIEflCir1FPkpvoT0wMVkBMIyDCObd
   A==;
X-CSE-ConnectionGUID: p1oaTlscSTqJu8wxuxTa6g==
X-CSE-MsgGUID: 8cxqTlA+S/yp6+8uqQjIvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156859"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156859"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:04 -0800
X-CSE-ConnectionGUID: GZ/e753/TTeP9/y17Nz+lg==
X-CSE-MsgGUID: 7YS3Gs/uR9qdp1pPOlL7DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301666"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:51:02 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 4/8] PCI: vmd: Add vmd_create_bus()
Date: Fri, 22 Nov 2024 09:52:11 +0100
Message-Id: <20241122085215.424736-5-szymon.durawa@linux.intel.com>
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

Move the VMD bus initialization code to a new helper vmd_create_bus().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 54 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 240be800ae96..24ca19a28ba7 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -832,6 +832,36 @@ static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 	vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
 }
 
+static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
+			  resource_size_t *offset)
+{
+	LIST_HEAD(resources);
+
+	pci_add_resource(&resources, &vmd->resources[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
+
+	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
+				       &vmd_ops, sd, &resources);
+	if (!vmd->bus) {
+		pci_free_resource_list(&resources);
+		vmd_remove_irq_domain(vmd);
+		return -ENODEV;
+	}
+
+	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+				   to_pci_host_bridge(vmd->bus->bridge));
+
+	vmd_attach_resources(vmd);
+	if (vmd->irq_domain)
+		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
+
+	return 0;
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -883,7 +913,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	int ret;
@@ -970,28 +999,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
+	ret = vmd_create_bus(vmd, sd, offset);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
-		pci_free_resource_list(&resources);
-		vmd_remove_irq_domain(vmd);
-		return -ENODEV;
+	if (ret) {
+		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
+		return ret;
 	}
 
-	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
-
-	vmd_attach_resources(vmd);
-	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
-	else
-		dev_set_msi_domain(&vmd->bus->dev,
-				   dev_get_msi_domain(&vmd->dev->dev));
-
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 
-- 
2.39.3


