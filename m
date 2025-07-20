Return-Path: <linux-pci+bounces-32602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D00B0B7D7
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 21:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE183A5008
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128141C84A6;
	Sun, 20 Jul 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIAOrmRh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E978F6C;
	Sun, 20 Jul 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753038108; cv=none; b=LSsKFlweaVjE5IR3u7IbBO+Y3mFKV44qJcyzhYjgPjsv+PEol15W62ugK9Fv7/+ZpfxdHd1AkNt3aGXxHhxljVWPgB2NL7JdQpOURyDPosqwwbJeCQNUvZY/SPACxPtOCnnP7WrmHOkVf+PBFBMY0oKEaJMzHMeJUpBafL3n+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753038108; c=relaxed/simple;
	bh=fHbdFA2m9UXbEVt/aNDr7ogjvvtWResK7CxjVQJtUAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwIBacYezslkkztcBZ/j0pHalNceIbEYY8ciuDR/egTnUt0PFM07EvOI8nCnwS4x59Va5Rjn/UE4Ye2Td/8YwgjQwL4hPadqX+kTA8W7/5Cf9zNuK+HTJSrEFG56sK0bcln1c7mLDki1OpO40mFx7S9SwkyKhXHT0cvOn+HgMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIAOrmRh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753038106; x=1784574106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fHbdFA2m9UXbEVt/aNDr7ogjvvtWResK7CxjVQJtUAs=;
  b=hIAOrmRhjWUO00CeXlp8DjPRFk2mEE0TKu/GSoTCXnGTH7yPvnPfKx71
   ojWbrJE0S4ij5yRQ8IECoVu6jdNlPhbwlI6dBwutO34gDRajrvOBdKllI
   hD//s183pL+BDzQ9wLIZTcEJPL5FWTwbQJEL3GCtVSVUV2aeEFKnFx1/H
   bv6Q4N29hytfIKkLz++PktlMi+8gEhscqjYOykKA9XaTzak3h5+pNGmbN
   gpHeW1tkVIDL8zm6f7PBvTrpBBA3RLQKXPj/RLDaSGSJcNFIH5M4oMdSo
   hKIJSIJiVcCKcDYnBXRJ303TOaIVijDC+jfTS2aai/iB2RzR18ueExo3U
   g==;
X-CSE-ConnectionGUID: d7x714UHRA6Hn7fKJkq6sw==
X-CSE-MsgGUID: UQ+poP/DR8ODkaFOQhWpIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="54361648"
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="54361648"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 12:01:45 -0700
X-CSE-ConnectionGUID: w243+E1vRxKq4fgHZ5tncA==
X-CSE-MsgGUID: aw1+1HEOR/ekVYzZ8Dpx+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="158317029"
Received: from ldmartin-desk2.corp.intel.com (HELO debox1-desk4.intel.com) ([10.124.221.227])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 12:01:45 -0700
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
Subject: [PATCH] PCI/ASPM: Allow controller drivers to override default ASPM and CLKPM link state
Date: Sun, 20 Jul 2025 12:01:37 -0700
Message-ID: <20250720190140.2639200-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
visible to firmware and do not receive BIOS-provided default ASPM and CLKPM
configuration. As a result, devices behind such domains operate without
proper power management, regardless of platform intent.

To address this, allow controller drivers to supply an override for the
default link state by setting aspm_dflt_link_state for their associated
pci_host_bridge. During link initialization, if this field is non-zero,
ASPM and CLKPM defaults are derived from its value instead of being taken
from BIOS.

This mechanism enables drivers like VMD to achieve platform-aligned power
savings by statically defining the expected link configuration at
enumeration time, without relying on runtime calls such as
pci_enable_link_state(), which are ineffective when ASPM is disabled
globally.

This approach avoids per-controller hacks in ASPM core logic and provides a
general mechanism for domains that require explicit control over link power
state defaults.

Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef=
@panix.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

Changes from RFC:

  -- Rename field to aspm_dflt_link_state since it stores
     PCIE_LINK_STATE_XXX flags, not a policy enum.
  -- Move the field to struct pci_host_bridge since it's being applied to
     the entire host bridge per Mani's suggestion.
  -- During testing noticed that clkpm remained disabled and this was
     also handled by the formerly used pci_enable_link_state(). Add a
     check in pcie_clkpm_cap_init() as well to enable clkpm during init.

 drivers/pci/controller/vmd.c | 12 +++++++++---
 drivers/pci/pcie/aspm.c      | 13 +++++++++++--
 include/linux/pci.h          |  4 ++++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2f..6f0de95c87fd 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_=
bridge *root_bridge,
 }
=20
 /*
- * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
+ * Enable LTR settings on devices that aren't configured by BIOS.
  */
 static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 {
@@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, vo=
id *userdata)
 	 * PCIe r6.0, sec 5.5.4.
 	 */
 	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
=20
@@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsig=
ned long features)
 	resource_size_t membar2_offset =3D 0x2000;
 	struct pci_bus *child;
 	struct pci_dev *dev;
+	struct pci_host_bridge *vmd_host_bridge;
 	int ret;
=20
 	/*
@@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsi=
gned long features)
 		return -ENODEV;
 	}
=20
+	vmd_host_bridge =3D to_pci_host_bridge(vmd->bus->bridge);
+
+#ifdef CONFIG_PCIEASPM
+	vmd_host_bridge->aspm_dflt_link_state =3D PCIE_LINK_STATE_ALL;
+#endif
+
 	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
+				   vmd_host_bridge);
=20
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a91..6f5b34b172f9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -380,6 +380,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state =
*link, int blacklist)
 	u16 reg16;
 	struct pci_dev *child;
 	struct pci_bus *linkbus =3D link->pdev->subordinate;
+	struct pci_host_bridge *host =3D pci_find_host_bridge(link->pdev->bus);
=20
 	/* All functions should have the same cap and state, take the worst */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
@@ -394,7 +395,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state=
 *link, int blacklist)
 			enabled =3D 0;
 	}
 	link->clkpm_enabled =3D enabled;
-	link->clkpm_default =3D enabled;
+	if (host && host->aspm_dflt_link_state & PCIE_LINK_STATE_CLKPM)
+		link->clkpm_default =3D 1;
+	else
+		link->clkpm_default =3D enabled;
 	link->clkpm_capable =3D capable;
 	link->clkpm_disable =3D blacklist ? 1 : 0;
 }
@@ -794,6 +798,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *=
link, int blacklist)
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus =3D parent->subordinate;
+	struct pci_host_bridge *host;
=20
 	if (blacklist) {
 		/* Set enabled/disable so that we will disable ASPM later */
@@ -866,7 +871,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state =
*link, int blacklist)
 	}
=20
 	/* Save default state */
-	link->aspm_default =3D link->aspm_enabled;
+	host =3D pci_find_host_bridge(parent->bus);
+	if (host && host->aspm_dflt_link_state)
+		link->aspm_default =3D host->aspm_dflt_link_state;
+	else
+		link->aspm_default =3D link->aspm_enabled;
=20
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable =3D link->aspm_support;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..930028bf52b4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -614,6 +614,10 @@ struct pci_host_bridge {
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
=20
+#ifdef CONFIG_PCIEASPM
+	unsigned int    aspm_dflt_link_state;	/* Controller provided link state */
+#endif
+
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,

base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
--=20
2.43.0


