Return-Path: <linux-pci+bounces-34512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A145BB30C5F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 05:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27013AB4E0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFF280A3B;
	Fri, 22 Aug 2025 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHUXoF7W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9F27FD7D;
	Fri, 22 Aug 2025 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832331; cv=none; b=DSM/8CwJElQMznKe1jR578npxpU5S8qkhb1Y7iQPOp/qRjzdsquUp1IeT1P0bJzXtiulbUrUFDxE3EUJVVzF8Dzlw0Ijz74mZJ6sWZ2nwmsOQ8d6otBwpjP239wTmV008w6wrq0Rd8CtvbItEa3Ty+3VErXVyqY/v21yPF7nHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832331; c=relaxed/simple;
	bh=dzlqa+5rz7zLNbwgKVmH/0yIcaGBtdw6VXx3JofaAlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JocSsUlYNOeSswd6gHiIjrISFGDCLWHYBiSxckpzDL9Z1WqrhThZfJ0bG9W0ws5dt3NMoTb+GhdhNgh3C6bmogKPfCJGkpZna8YAjnQv4snxPfM903UJyWPWYBsfclROZDrrhvt1At6fzRRYSR8TA1iuPKewCuYljB90Iy1hwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHUXoF7W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755832330; x=1787368330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzlqa+5rz7zLNbwgKVmH/0yIcaGBtdw6VXx3JofaAlU=;
  b=oHUXoF7Wz4kcBjCuzflCeTvGZdrJ5hQck3MwbxE9JWsw1wxInRQRZTd0
   1ceq4dN4ZqKE4qmTD8MocDSOyBZTNvmyvTcZZcNIxd3VlQPZlRnSya+iP
   nwmRIv8MBifcI1TPR6Gh7gjaCLbqH9DZsdX7j6IznMxNv4eApfYmCresn
   r5z1SOloQeUobGMqe6yY09IcMumzxMgpYVM0941vAoUBB8c/U3Y25rwAt
   Xri5fSniKd8xgFN/LjcuVk+d/uzTOO0FaGfHCvfgTT5SVlhJ6va2IslCj
   4pUb5yI/6y0gKSHF8k109Ffgai883EgDPvJytzMlXoBAxOjPQcbiwrbNU
   g==;
X-CSE-ConnectionGUID: qe5PdUJnRe+g+7Vwibbqgg==
X-CSE-MsgGUID: aElwpcUFRfW6ZaBsbrPBNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45703266"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="45703266"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:12:10 -0700
X-CSE-ConnectionGUID: vlz1/d64RDmJPID7ENvaRQ==
X-CSE-MsgGUID: mM4usX8gTBygnDC1QK/bMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168493631"
Received: from mjruhl-desk.amr.corp.intel.com (HELO debox1-desk4.hsd1.or.comcast.net) ([10.124.221.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:12:09 -0700
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
Subject: [PATCH V2 2/2] PCI: vmd: Use pci_host_set_default_pcie_link_state() to set ASPM defaults
Date: Thu, 21 Aug 2025 20:11:58 -0700
Message-ID: <20250822031159.4005529-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822031159.4005529-1-david.e.box@linux.intel.com>
References: <20250822031159.4005529-1-david.e.box@linux.intel.com>
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
---
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


