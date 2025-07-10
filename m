Return-Path: <linux-pci+bounces-31829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14BAFF660
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 03:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406E75A6713
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 01:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AAC26B77D;
	Thu, 10 Jul 2025 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcOPn8gy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2DDA95C;
	Thu, 10 Jul 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752110217; cv=none; b=uINr+Ee6Lqc+p++ZP8tPY7gxGojhFPnUkWgELbai9L1dbr4d3nD1l+4EhGSSLp4wnW+l8JbRCi/pVXmFm9NV12Q/ZSMJimV8d5zonkK5S0J4OCnTT/r/YYACB3vaTOa0xKpzlYw2oJu8qyUIYa4j6S74UF03z2qn4OPNwU4FpsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752110217; c=relaxed/simple;
	bh=DeUXFPOjpXvG8V4k8qJUO9OWQj3zvW7e31e875GRdqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAG0PzaVMyd2ERVK+OUN+T7GRdBHdxBnK6weWV9h3tTbOj0/IV0hm2al9V+EnhsjjtVrdyfVZ5B8qG0ayh310oc8OSq1WlTMKrilj9Fe/r59rOAWz7WxDMOIYi8NAC8osp7DmDJ8jRyKqrRwUwipCpiDUwaHhF0+xojOFN8aboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcOPn8gy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752110216; x=1783646216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DeUXFPOjpXvG8V4k8qJUO9OWQj3zvW7e31e875GRdqA=;
  b=bcOPn8gyV5hV9Jca+Q0hzd3mRA8d0auLmMUzGG+KVg0dM5rye7s8DgFT
   pDxrhlmnnP5ddpUJcOzI5rorLM/1+S2JNChiN40L2LwQnz/75a7muqkCC
   D4uvQkaEKePnGoIP2QQhZDMe6FyiJQCqQV9MixkvRnijFFJ3nRKspbvQZ
   WZjm+c88+wonTPzSYUSDSETD/dm+TExYCBWSEP4PhhfVvf4j0d1991DiO
   CHn37KFm3BXBF9nPEj+EGqXgvi+/0zpBzzyvCYc72dUPIPc8lq5tdrpZ0
   wIr1TLvW3EcdfFORAptNDc5huJJJqDw3CJQNeS6RBlkeFFbdYWSKdwOhl
   g==;
X-CSE-ConnectionGUID: KmKUb2OpRUasR1Qt3rQZXA==
X-CSE-MsgGUID: MIaSK5OsSc+Es5IBLMnLQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54354905"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54354905"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 18:16:55 -0700
X-CSE-ConnectionGUID: XUxjQmV9TzShAhTjnDtn3Q==
X-CSE-MsgGUID: Wnx31L7pRhivcbwfCqbbPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="179635248"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO debox1-desk4.intel.com) ([10.124.221.209])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 18:16:53 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: rafael@kernel.org,
	bhelgaas@google.com,
	andrea.righi@canonical.com,
	vicamo.yang@canonical.com,
	kenny@panix.com,
	nirmal.patel@linux.intel.com
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ASPM: Allow ASPM enablement for devices behind Intel VMD
Date: Wed,  9 Jul 2025 18:16:46 -0700
Message-ID: <20250710011647.990046-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Devices behind Intel's Volume Management Device (VMD) controller reside on
a synthetic PCI hierarchy that is intentionally hidden from ACPI and
firmware. As such, BIOS does not configure ASPM for these devices, and the
responsibility for link power management, including ASPM and LTR, falls
entirely to the VMD driver.

However, the current PCIe ASPM code prevents ASPM configuration when the
ACPI_FADT_NO_ASPM flag is set, disallowing OS management. This leaves ASPM
permanently disabled for these devices, contrary to the platform's design
intent.

Introduce a callback mechanism that allows the VMD driver to enable ASPM
for its domain, bypassing the global ACPI_FADT_NO_ASPM restriction that is
not applicable in this context. This ensures that devices behind VMD can
benefit from ASPM savings as originally intended.

Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef=
@panix.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 28 ++++++++++++++++++++++++++--
 drivers/pci/pci.h            |  8 ++++++++
 drivers/pci/pcie/aspm.c      | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2f..e685586dc18b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -21,6 +21,8 @@
=20
 #include <asm/irqdomain.h>
=20
+#include "../pci.h"
+
 #define VMD_CFGBAR	0
 #define VMD_MEMBAR1	2
 #define VMD_MEMBAR2	4
@@ -730,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_=
bridge *root_bridge,
 }
=20
 /*
- * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
+ * Enable LTR settings on devices that aren't configured by BIOS.
  */
 static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 {
@@ -770,10 +772,27 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, =
void *userdata)
 	 * PCIe r6.0, sec 5.5.4.
 	 */
 	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
=20
+static long vmd_get_link_state(struct pci_dev *pdev, void *data)
+{
+	struct pci_bus *vmd_bus =3D data;
+	struct pci_bus *bus =3D pdev->bus;
+
+	while (bus) {
+		if (bus =3D=3D vmd_bus)
+			return PCIE_LINK_STATE_ALL;
+
+		if (!bus->self)
+			break;
+
+		bus =3D bus->self->bus;
+	}
+
+	return -ENODEV;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd =3D &vmd->sysdata;
@@ -785,6 +804,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsig=
ned long features)
 	resource_size_t membar2_offset =3D 0x2000;
 	struct pci_bus *child;
 	struct pci_dev *dev;
+	struct pcie_aspm_vmd_link_state vmd_link_state;
 	int ret;
=20
 	/*
@@ -911,6 +931,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsi=
gned long features)
 		return -ENODEV;
 	}
=20
+	vmd_link_state.cb =3D vmd_get_link_state;
+	vmd_link_state.data =3D vmd->bus;
+	pci_register_vmd_link_state_cb(&vmd_link_state);
+
 	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
 				   to_pci_host_bridge(vmd->bus->bridge));
=20
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..dcf7d39c660f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -821,6 +821,12 @@ void pci_configure_aspm_l1ss(struct pci_dev *dev);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
=20
+
+struct pcie_aspm_vmd_link_state {
+	long (*cb)(struct pci_dev *pdev, void *data);
+	void *data;
+};
+
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
@@ -828,6 +834,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, bo=
ol locked);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_configure_ltr(struct pci_dev *pdev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
+void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state=
);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
@@ -835,6 +842,7 @@ static inline void pcie_aspm_pm_state_change(struct pci=
_dev *pdev, bool locked)
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) {=
 }
 static inline void pci_configure_ltr(struct pci_dev *pdev) { }
 static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
+void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state=
) { }
 #endif
=20
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a91..c609d3c309be 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -320,6 +320,27 @@ static int policy_to_clkpm_state(struct pcie_link_stat=
e *link)
 	return 0;
 }
=20
+static struct pcie_aspm_vmd_link_state vmd_state;
+
+void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state)
+{
+	mutex_lock(&aspm_lock);
+	vmd_state.cb =3D state->cb;
+	vmd_state.data =3D state->data;
+	mutex_unlock(&aspm_lock);
+}
+EXPORT_SYMBOL_GPL(pci_register_vmd_link_state_cb);
+
+static long pci_get_vmd_link_state(struct pci_dev *pdev)
+{
+	int state =3D -ENODEV;
+
+	if (vmd_state.cb)
+		state =3D vmd_state.cb(pdev, vmd_state.data);
+
+	return state;
+}
+
 static void pci_update_aspm_saved_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
@@ -794,6 +815,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *=
link, int blacklist)
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus =3D parent->subordinate;
+	int vmd_aspm_default;
=20
 	if (blacklist) {
 		/* Set enabled/disable so that we will disable ASPM later */
@@ -865,8 +887,20 @@ static void pcie_aspm_cap_init(struct pcie_link_state =
*link, int blacklist)
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
 	}
=20
+	/*
+	 * Devices behind Intel VMD operate on a synthetic PCI bus that BIOS
+	 * and ACPI do not enumerate or configure. ASPM for these devices must
+	 * be managed by the VMD driver itself, independent of global ACPI ASPM
+	 * constraints. This callback mechanism allows selective ASPM
+	 * enablement for such domains.
+	 */
+	vmd_aspm_default =3D pci_get_vmd_link_state(parent);
+
 	/* Save default state */
-	link->aspm_default =3D link->aspm_enabled;
+	if (vmd_aspm_default < 0)
+		link->aspm_default =3D link->aspm_enabled;
+	else
+		link->aspm_default =3D vmd_aspm_default;
=20
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable =3D link->aspm_support;

base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
--=20
2.43.0


