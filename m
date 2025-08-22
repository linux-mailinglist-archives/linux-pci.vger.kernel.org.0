Return-Path: <linux-pci+bounces-34511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41598B30C5B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC29A1BA2762
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 03:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80127FB10;
	Fri, 22 Aug 2025 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpOz4lOG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544F27EFE1;
	Fri, 22 Aug 2025 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832328; cv=none; b=RFTLuAryICat36sKNVaeRcp53nprmhSKN/ktST5gn7IqZ+xloN3xzI2wDM8htvKPKZEH1W/7cgHk49YLrOKP8LyUprDso0jwV+tZj/HK1mqoYDthCD7mMjH2M1EE+rwpGfSM2ws5BGboSGUNYRCuH06jHXTPRFvgU7YGW4GrZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832328; c=relaxed/simple;
	bh=HCA/jM1l6r7szXVC1DKINdKeXRG8b18yaseqXNY6e8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSXnmFj58E42QLXlBSrBGu27bzkoHXZVjVl1/cPWc7+vbV3V+pSDucAomUwZ6AZ2KYPFIvdCPSnQ4mZNxpyeA7XDa7ujpmi2J9J0vQTdD2+A6sNKBJfyNzdviNHExpBUbqCVy1WlU81xwNtTAGE/ZBCTAE1JF86tkH7jbE8TPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpOz4lOG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755832327; x=1787368327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCA/jM1l6r7szXVC1DKINdKeXRG8b18yaseqXNY6e8I=;
  b=YpOz4lOG9AXuR41AfepK6cQ2EGL1N4hnTO1tIWiCbzm8og3uF2wfojSU
   11GvMmKSxllTWdurRh0t5rIiMGKlUR9YbKGP+MnyUXB+IvEUrPqz9H4mI
   IWJOr5w6rmM3kuT127/lwprQ9/3U21FeQUdskJxcdLVvEDZvU2XNBWCMy
   JK64Yc4YYwKDyXD+Y/kGibNW3zqCNPLVmSzOV6hpKJnz/iQimVFRzXgv+
   iTQQdTRZjiyZ/oVF4PdVO3k8WkYc6aGIV2ucKcgo+I8kRmJoVWAq5ubrT
   Ljak2puvDB9z4LNjNz0KC143W4ByqYkNGxU90utb1oS/jmapViluL0C5l
   Q==;
X-CSE-ConnectionGUID: CCVGPWofRqS2wDUxpmulIA==
X-CSE-MsgGUID: FbevFZVpTtaa6U5a2/1mIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45703255"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="45703255"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:12:06 -0700
X-CSE-ConnectionGUID: yoPoDkTtTkGY2Phh/yEIQw==
X-CSE-MsgGUID: nmSiAo9gQ56haSEkTg68Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168493623"
Received: from mjruhl-desk.amr.corp.intel.com (HELO debox1-desk4.hsd1.or.comcast.net) ([10.124.221.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:12:05 -0700
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
Subject: [PATCH V2 1/2] PCI/ASPM: Add host-bridge API to override default ASPM/CLKPM link state
Date: Thu, 21 Aug 2025 20:11:57 -0700
Message-ID: <20250822031159.4005529-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
defaults. Devices in such domains may therefore run without the intended
power management.

Add a host-bridge mechanism that lets controller drivers supply their own
defaults. A new aspm_default_link_state field in struct pci_host_bridge is
set via pci_host_set_default_pcie_link_state(). During link initialization,
if this field is non-zero, ASPM and CLKPM defaults come from it instead of
BIOS.

This enables drivers like VMD to align link power management with platform
expectations and avoids embedding controller-specific quirks in ASPM core
logic.

Link: https://patchwork.ozlabs.org/project/linux-pci/patch/20250720190140.2=
639200-1-david.e.box%40linux.intel.com/
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

Changes in V1 from RFC:

  -- Rename field to aspm_dflt_link_state since it stores
     PCIE_LINK_STATE_XXX flags, not a policy enum.
  -- Move the field to struct pci_host_bridge since it's being applied to
     the entire host bridge per Mani's suggestion.
  -- During testing noticed that clkpm remained disabled and this was
     also handled by the formerly used pci_enable_link_state(). Add a
     check in pcie_clkpm_cap_init() as well to enable clkpm during init.

Changes in V2:

  -- Host field name changed to aspm_default_link_state.
  -- Added get/set functions for aspm_default_link_state. Only the
     setter is exported. Added a kernel-doc describing usage and
     particulars around meaning of 0.

 drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h     |  9 +++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 919a05b97647..b4f0b4805a35 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -373,6 +373,39 @@ static void pcie_set_clkpm(struct pcie_link_state *lin=
k, int enable)
 	pcie_set_clkpm_nocheck(link, enable);
 }
=20
+/**
+ * pci_host_set_default_pcie_link_state - set controller-provided default =
ASPM/CLKPM mask
+ * @host: host bridge on which to apply the defaults
+ * @state: PCIE_LINK_STATE_XXX flags
+ *
+ * Allows a PCIe controller driver to specify the default ASPM and/or
+ * Clock Power Management (CLKPM) link state mask that will be used
+ * for links under this host bridge during ASPM/CLKPM capability init.
+ *
+ * The value is consumed in pcie_aspm_cap_init() and pcie_clkpm_cap_init()
+ * to override the firmware-discovered defaults.
+ *
+ * Interpretation of aspm_default_link_state:
+ *   - Nonzero: bitmask of PCIE_LINK_STATE_* values to be used as defaults
+ *   - Zero:    no override provided; ASPM/CLKPM defaults fall back to
+ *              values discovered in hardware/firmware
+ *
+ * Note: zero is always treated as "unset", not as "force ASPM/CLKPM off".
+ */
+void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
+					  unsigned int state)
+{
+	host->aspm_default_link_state =3D state;
+}
+EXPORT_SYMBOL_GPL(pci_host_set_default_pcie_link_state);
+
+static u32 pci_host_get_default_pcie_link_state(struct pci_dev *parent)
+{
+	struct pci_host_bridge *host =3D pci_find_host_bridge(parent->bus);
+
+	return host ? host->aspm_default_link_state : 0;
+}
+
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklis=
t)
 {
 	int capable =3D 1, enabled =3D 1;
@@ -394,7 +427,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state=
 *link, int blacklist)
 			enabled =3D 0;
 	}
 	link->clkpm_enabled =3D enabled;
-	link->clkpm_default =3D enabled;
+	if (pci_host_get_default_pcie_link_state(link->pdev) & PCIE_LINK_STATE_CL=
KPM)
+		link->clkpm_default =3D 1;
+	else
+		link->clkpm_default =3D enabled;
 	link->clkpm_capable =3D capable;
 	link->clkpm_disable =3D blacklist ? 1 : 0;
 }
@@ -866,7 +902,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *=
link, int blacklist)
 	}
=20
 	/* Save default state */
-	link->aspm_default =3D link->aspm_enabled;
+	link->aspm_default =3D pci_host_get_default_pcie_link_state(parent);
+	if (!link->aspm_default)
+		link->aspm_default =3D link->aspm_enabled;
=20
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable =3D link->aspm_support;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..8947cbaf9fa6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -620,6 +620,10 @@ struct pci_host_bridge {
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
=20
+#ifdef CONFIG_PCIEASPM
+	unsigned int	aspm_default_link_state;	/* Controller-provided default */
+#endif
+
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
@@ -1849,6 +1853,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int =
state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
+void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
+					  unsigned int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
@@ -1861,6 +1867,9 @@ static inline int pci_enable_link_state(struct pci_de=
v *pdev, int state)
 { return 0; }
 static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int s=
tate)
 { return 0; }
+static inline void
+pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
+				     unsigned int state) { }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false;=
 }

base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
--=20
2.43.0


