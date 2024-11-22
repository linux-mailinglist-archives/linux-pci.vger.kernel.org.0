Return-Path: <linux-pci+bounces-17194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB529D5A54
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D67B231D0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE718595F;
	Fri, 22 Nov 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq1UIM3/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C90178CEC
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261857; cv=none; b=bQh+3eRpiYxc13jIPVVolUTRjZ/Klvmat71heKKPjRi8nBB9X23lhJzPP4NJKOIk02ONTXGtRC93uzAHcHXk4X0wmCsUtQGCa+Puu4l0mpANAWfhNqMyKSgz+WVZJU2zY8rzLZkhh7wIKWty5aKk5RFVv36oY/CcpSd87CUIUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261857; c=relaxed/simple;
	bh=3DKmPqixFjXnSu8i4KQqEtMLJM564Px14iu08s9bNdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKGokiz/wulDFh0tRRaji5YGWooKHB5pnLzBlq7wf7psqwdAUFK4BvCCKMLxHSFBG+1MhI4Qjtx4dCCZXlS29I74FXfTFh4IPhRy5hrHCUTrGlv70NgGNAH95ERTjd8OgD7/BWxYD0IrsmG9VikNyEZQtKQZ1Ro9LNh5RCEBaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq1UIM3/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261856; x=1763797856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3DKmPqixFjXnSu8i4KQqEtMLJM564Px14iu08s9bNdw=;
  b=Dq1UIM3/E5lpPCZHx50z2zCnZ3DzsjdGszqF4i0vkLdOXRHF6g+5P8Bi
   IBamF6+ZRUXhV56OXIosG7vBcfYmVezvGbYkTL8PcwCU0FYbs1lXLwqxC
   yquH7F1EwV5FFjFcc3MPBhcz9Ct6goOVSJWK0nOssGgDTc/WswtHhXW/X
   PcGKp9P70F1flNbOwfm6U0EuHrpQ2Ceiqt9kI08EtiQhoSANBbV6iqbR9
   +xYtGDJH/2++ZYA6Px3uow+GiYZMV/GStchT9aYWuLnbqSt7pBcwe96vh
   kkwSzvWWosEIcJUXmuaieW5pqTDa7YxG9+SjJAsfbFVgBa0YiPiN3sHVt
   A==;
X-CSE-ConnectionGUID: eBG3k4zsRaeav7kAd2h5vg==
X-CSE-MsgGUID: w9UvvzK5QhqpgIoI0TOCow==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156822"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:50:55 -0800
X-CSE-ConnectionGUID: 5MsoUFoiTqygoHubQL1JEw==
X-CSE-MsgGUID: sFwXEtyWQtieqxKXkJvw/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301622"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:50:53 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 1/8] PCI: vmd: Add vmd_bus_enumeration()
Date: Fri, 22 Nov 2024 09:52:08 +0100
Message-Id: <20241122085215.424736-2-szymon.durawa@linux.intel.com>
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

Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 89 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 40 deletions(-)
 mode change 100644 => 100755 drivers/pci/controller/vmd.c

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
old mode 100644
new mode 100755
index a726de0af011..fb66910f9204
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -778,6 +778,54 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	return 0;
 }
 
+static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
+{
+	struct pci_bus *child;
+	struct pci_dev *dev;
+	int ret;
+
+	vmd_acpi_begin();
+
+	pci_scan_child_bus(bus);
+	vmd_domain_reset(vmd_from_bus(bus));
+
+	/*
+	 * When Intel VMD is enabled, the OS does not discover the Root Ports
+	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
+	 * a reset to the parent of the PCI device supplied as argument. This
+	 * is why we pass a child device, so the reset can be triggered at
+	 * the Intel bridge level and propagated to all the children in the
+	 * hierarchy.
+	 */
+	list_for_each_entry(child, &bus->children, node) {
+		if (!list_empty(&child->devices)) {
+			dev = list_first_entry(&child->devices, struct pci_dev,
+					       bus_list);
+			ret = pci_reset_bus(dev);
+			if (ret)
+				pci_warn(dev, "can't reset device: %d\n", ret);
+
+			break;
+		}
+	}
+
+	pci_assign_unassigned_bus_resources(bus);
+
+	pci_walk_bus(bus, vmd_pm_enable_quirk, &features);
+
+	/*
+	 * VMD root buses are virtual and don't return true on pci_is_pcie()
+	 * and will fail pcie_bus_configure_settings() early. It can instead be
+	 * run on each of the real root ports.
+	 */
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	pci_bus_add_devices(bus);
+
+	vmd_acpi_end();
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -787,8 +835,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
-	struct pci_bus *child;
-	struct pci_dev *dev;
 	int ret;
 
 	/*
@@ -928,45 +974,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 
-	vmd_acpi_begin();
-
-	pci_scan_child_bus(vmd->bus);
-	vmd_domain_reset(vmd);
+	vmd_bus_enumeration(vmd->bus, features);
 
-	/* When Intel VMD is enabled, the OS does not discover the Root Ports
-	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
-	 * a reset to the parent of the PCI device supplied as argument. This
-	 * is why we pass a child device, so the reset can be triggered at
-	 * the Intel bridge level and propagated to all the children in the
-	 * hierarchy.
-	 */
-	list_for_each_entry(child, &vmd->bus->children, node) {
-		if (!list_empty(&child->devices)) {
-			dev = list_first_entry(&child->devices,
-					       struct pci_dev, bus_list);
-			ret = pci_reset_bus(dev);
-			if (ret)
-				pci_warn(dev, "can't reset device: %d\n", ret);
-
-			break;
-		}
-	}
-
-	pci_assign_unassigned_bus_resources(vmd->bus);
-
-	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
-
-	/*
-	 * VMD root buses are virtual and don't return true on pci_is_pcie()
-	 * and will fail pcie_bus_configure_settings() early. It can instead be
-	 * run on each of the real root ports.
-	 */
-	list_for_each_entry(child, &vmd->bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(vmd->bus);
-
-	vmd_acpi_end();
 	return 0;
 }
 
-- 
2.39.3


