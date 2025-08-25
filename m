Return-Path: <linux-pci+bounces-34681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B6B34C21
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 22:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A45418891CC
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769828688E;
	Mon, 25 Aug 2025 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXl/ArVY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01801EDA0B;
	Mon, 25 Aug 2025 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154151; cv=none; b=LCkr/09VogjVbQxsPJzU0C1ucfA8h3roV+460ce87U08kMbTfXT7qbbmux/l5tqG2OuDGx8v3E5WNkTDr7gvBynXPCHND0/A8pjg+sszNoIHvwuK/Xdoio7NhHTe4CAIP/0ELJxvy+/kEeovFnP1I96P3J/P4FKmmtfxsQmDHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154151; c=relaxed/simple;
	bh=rybuWV56WOsHDYEx/o918h0eQxDHc9tHDekuS0uJEV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXR01tJU4Pt/y2mtlpwyU4n3jICi2o5Qr+IFPA5LleZy1pL61F4caiI2WKtm2FxXOTA+1/CILbAtOh/8BNCwyb4NriKUddXM+C3JJqkFDuu+xdfWkre+IufCgghoIJ6cg2vSBVJI4zyAXNbzXd2daFgjuv5SjW1SXjpUNtYOYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXl/ArVY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756154148; x=1787690148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rybuWV56WOsHDYEx/o918h0eQxDHc9tHDekuS0uJEV0=;
  b=WXl/ArVYAuErcXTI6BdXXDNd8a2uYeH3Pf7dVn3V42oCfS+H4vIxqvyi
   se/mrJW6901F9Eo2Zhmu9/xv+c0Nk6vNXFq8RQEbYqtZMQV4PQDuISBu4
   d2efgSKnhgcUXrLMeRSotDpX4tNR30tzdeBT8siVvxtd61GjxjLfwPUFY
   KOrQdbN03jhfUzfVUCwq60XSMNqAgDKRiCU87cnMTDU7HTue+pU7w5h9y
   Q3rzVZHpXvsjEjwoL+7yxOSowDIb/gv8zsn2AJmvS1IwhO1UGsMKCw9He
   /ajkPi85H/LxNs+/QQnT2P8fj/d3NHd2LaJPuuQDZlAhvFPvi+zp2Rzje
   w==;
X-CSE-ConnectionGUID: CDlVLZoASdWejnDS6gzPYQ==
X-CSE-MsgGUID: bx4E4QzyQDiHBp64VFjG7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="57394810"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57394810"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:35:47 -0700
X-CSE-ConnectionGUID: MDRUwMczTISPCUW+TVSkWA==
X-CSE-MsgGUID: l1BYhZxFRSWz2hC0offuZQ==
X-ExtLoop1: 1
Received: from sramkris-mobl1.amr.corp.intel.com (HELO debox1-desk4.hsd1.or.comcast.net) ([10.124.222.235])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:35:47 -0700
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
Subject: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default ASPM/CLKPM link state
Date: Mon, 25 Aug 2025 13:35:22 -0700
Message-ID: <20250825203542.3502368-1-david.e.box@linux.intel.com>
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
Tested-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---
Changes in V3:
  -- Changed pci_host_get_default_pcie_link_state() argument name from
     parent to dev.
  -- Applied changelog tags

Changes in V2:

  -- Host field name changed to aspm_default_link_state.
  -- Added get/set functions for aspm_default_link_state. Only the
     setter is exported. Added a kernel-doc describing usage and
     particulars around meaning of 0.

Changes in V1 from RFC:

  -- Rename field to aspm_dflt_link_state since it stores
     PCIE_LINK_STATE_XXX flags, not a policy enum.
  -- Move the field to struct pci_host_bridge since it's being applied to
     the entire host bridge per Mani's suggestion.
  -- During testing noticed that clkpm remained disabled and this was
     also handled by the formerly used pci_enable_link_state(). Add a
     check in pcie_clkpm_cap_init() as well to enable clkpm during init.

 drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h     |  9 +++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 919a05b97647..851ca3d68e55 100644
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
+static u32 pci_host_get_default_pcie_link_state(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host =3D pci_find_host_bridge(dev->bus);
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


