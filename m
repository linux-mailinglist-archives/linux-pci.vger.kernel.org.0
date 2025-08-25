Return-Path: <linux-pci+bounces-34682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFEB34C25
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 22:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59043BF231
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02A284684;
	Mon, 25 Aug 2025 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWoz/fFO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686A284B37;
	Mon, 25 Aug 2025 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154154; cv=none; b=FE01sDagoupagEvGv8BRlvza2T/DcopfToKp/i8C+W4OMLc0hYLDBBIlBt0p9ki3FaNfWJt4CJAHi6rxDikoOP0qIwKH9v/MnKmQ43ZJkXxJ12JUYJLvhAot/x+eJngymhQaPVIV0ZwausDDJAwZYb9KWfwViMLgZYS1GKzvloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154154; c=relaxed/simple;
	bh=Hd1/AX70clEjOMSaafYFRMp9Rq2vMcWsM0xWeZ/8yDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni8r6fVnpWfoBETfh95D6FvWghv8QngAPyJldzEUoWrTl9tv0gX8eQBZSbeYCG20ocp66u85+k8ED0PXlnqs+pQgsYvUpGO1KF5QCbFfFFfUegZ8YXHNC6wWpSMiJn3uaSBDMLVTfq4iYorUw3BU+qDCuZ/ynuFGagCWFxOwZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWoz/fFO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756154150; x=1787690150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hd1/AX70clEjOMSaafYFRMp9Rq2vMcWsM0xWeZ/8yDE=;
  b=QWoz/fFO5DGTJ5SbQbMAf7ESHn1zYCSSinZBvEDEdPowyQn9sjglQKrm
   TN3pCSgOLh+Q8xGfwZ5LxMLW+X9/ZQLjpXiG0R/Gj/+LlPmlTThoyCgbo
   /3YDU4pXuTRHWa/cQDaOq7pGWbzmdwg5tvhxTvaz5+OZcaR+Uh84tv2U0
   WxMurqeemnhLUNlVyM017TOzrVrPQpiDqhk1wWf+hqOMXlT74CNgXDUXL
   nBg6KVN9j3r86+r+slher9WIwe34A0Lzt8HjLkO+4shcXrAp/V5pncKMK
   +dlTSLZWmknQtOPn5rtsZjcZdFIzlqqrMWqqPZGvoQ/8oWqDwVQLXxHkV
   w==;
X-CSE-ConnectionGUID: PnpozbEUTeCzzEu8s/fmVQ==
X-CSE-MsgGUID: S3HgjMHUR6avouvKuCyAxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="57394815"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57394815"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:35:49 -0700
X-CSE-ConnectionGUID: HmiRSrrQRP23HQYltdsxwA==
X-CSE-MsgGUID: g0OZAn6jRgaRB4ATXbMAYA==
X-ExtLoop1: 1
Received: from sramkris-mobl1.amr.corp.intel.com (HELO debox1-desk4.hsd1.or.comcast.net) ([10.124.222.235])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:35:48 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: rafael@kernel.org,
	bhelgaas@google.com,
	vicamo.yang@canonical.com,
	kenny@panix.com,
	ilpo.jarvinen@linux.intel.com,
	nirmal.patel@linux.intel.com,
	mani@kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] PCI: vmd: Use pci_host_set_default_pcie_link_state() to set ASPM defaults
Date: Mon, 25 Aug 2025 13:35:23 -0700
Message-ID: <20250825203542.3502368-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825203542.3502368-1-david.e.box@linux.intel.com>
References: <20250825203542.3502368-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that pci_host_set_default_pcie_link_state() exists, set the VMD child
domain with PCIE_LINK_STATE_ALL at bridge creation so core ASPM uses those
defaults during ASPM and CLKPM capability init.

Also remove the unneeded pci_set_power_state_locked(pdev, PCI_D0) and
pci_enable_link_state_locked() calls now that the links are configured
during enumeration.

This aligns VMD behavior with platform expectations without per-controller
ASPM tweaks at runtime.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---
Changes in V3:
  -- Applied tags to changelog

Changes in V2:

  -- Separated VMD changes into new patch.
  -- Changed comment for VMD_FEAT_BIOS_PM_QUIRK to remove ASPM
  -- Removed pci_set_power_state() and pci_enable_link_state_locked()
     calls in vmd_pm_enable_quirk()
  -- Use pci_host_set_default_pcie_link_state()

 drivers/pci/controller/vmd.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b679c7f28f51..b99e01a57ddb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -71,10 +71,9 @@ enum vmd_features {
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		=3D (1 << 4),
=20
 	/*
-	 * Enable ASPM on the PCIE root ports and set the default LTR of the
-	 * storage devices on platforms where these values are not configured by
-	 * BIOS. This is needed for laptops, which require these settings for
-	 * proper power management of the SoC.
+	 * Program default LTR values for storage devices on platforms where
+	 * firmware did not. Required on many laptops for proper SoC power
+	 * management.
 	 */
 	VMD_FEAT_BIOS_PM_QUIRK		=3D (1 << 5),
 };
@@ -733,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_=
bridge *root_bridge,
 }
=20
 /*
- * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
+ * Enable LTR settings on devices that aren't configured by BIOS.
  */
 static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 {
@@ -747,7 +746,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, vo=
id *userdata)
=20
 	pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-		goto out_state_change;
+		return 0;
=20
 	/*
 	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
@@ -755,7 +754,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, vo=
id *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		goto out_state_change;
+		return 0;
=20
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -767,13 +766,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, v=
oid *userdata)
 	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
=20
-out_state_change:
-	/*
-	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
-	 * PCIe r6.0, sec 5.5.4.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
=20
@@ -921,6 +913,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsig=
ned long features)
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
=20
+	pci_host_set_default_pcie_link_state(to_pci_host_bridge(vmd->bus->bridge),
+					     PCIE_LINK_STATE_ALL);
 	vmd_acpi_begin();
=20
 	pci_scan_child_bus(vmd->bus);
--=20
2.43.0


