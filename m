Return-Path: <linux-pci+bounces-2655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3283FAEE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBBB1F233A0
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 23:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5A446D1;
	Sun, 28 Jan 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VS6fBcMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9E2D044;
	Sun, 28 Jan 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484736; cv=none; b=F5UwbU1ghKD04eQKx6JBOMEXZLrNA7jU1RMuSE/eOZh4MaYM4+e0V/q+aN5zl/uV+FlAlVzv+IpKC54ufGxiV0ZhN1KmS6OOU3Dd7tnnJn0DmqLuyKkKSRQJVtXVOvHNPPdXTWRhFgYK/CSs6d6vlkN3ks3M+aAz4QH5zWvqya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484736; c=relaxed/simple;
	bh=Gj88eSiw6qEvWoHcGlqiDmWPTw9OEWFwUx0OlE6ZLgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmRPOaSc7dYFXUD75wDTg7kLgGZ/A4QS2K0xZvmMKmDv7J7i60qCZkvIGX3bcETuqSEbQblqm+jBzBHEMIS77clcRGFZYoo17Pbllfg0un82L95R4BSJMBIc1s+oyD1nm3pfdCoR1KppamfD9CncF8L85kBYTQn6h6mFYpZB5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VS6fBcMp; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706484734; x=1738020734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gj88eSiw6qEvWoHcGlqiDmWPTw9OEWFwUx0OlE6ZLgE=;
  b=VS6fBcMpr1XeU3N3/x2th5I2jRtwkquxP265t7ON/HoSp5RC2fQef5FQ
   ZQ6m4BV4ZXvZfdltwlvUbzKH6dOlrLhLcb2YuzA1ccTQc/9MkEk6+Ddev
   Tp0rea29tIBFpH7Q2/Xo5RcQjKAwnZrF+i/yTMFhzEOaasb9YaLCjtr+Z
   ncGP5OIMQS1NPzJ1eUtJPnGxybOzu87SsSpK7LMQ/344+CknMBtc96oIq
   bOa9cpbS9rwmdyE1lwC3+Q7MwF4cS9SifLFzknlC56LTIpCMVKk7/MQjc
   xNrGRvBOTGgwJfwxwhl4YDMsYGOqytaK6x7gRLswhURiIiI8pQIpEjg7u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="467081093"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="467081093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="930913770"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="930913770"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:13 -0800
Received: from debox1-desk4.intel.com (sdutta-mobl2.amr.corp.intel.com [10.209.55.52])
	by linux.intel.com (Postfix) with ESMTP id 8923558047E;
	Sun, 28 Jan 2024 15:32:12 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: mika.westerberg@linux.intel.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com,
	rjw@rjwysocki.net
Cc: tasev.stefanoska@skynet.be,
	enriquezmark36@gmail.com,
	kernel@witt.link,
	wse@tuxedocomputers.com,
	vidyas@nvidia.com,
	kai.heng.feng@canonical.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ricky_wu@realtek.com,
	mario.limonciello@amd.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] PCI: Always build aspm.c
Date: Sun, 28 Jan 2024 15:32:08 -0800
Message-Id: <20240128233212.1139663-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128233212.1139663-1-david.e.box@linux.intel.com>
References: <20240128233212.1139663-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ASPM related tasks, such as save and restore of LTR and L1SS
capabilities, still need to be performed when CONFIG_PCIASPM=n. To prepare
for these changes, wrap the current code in aspm.c with an ifdef and always
build. Also move pci_configure_ltr() and pci_bridge_reconfigure_ltr() into
aspm.c since they only build when CONFIG_PCIEASPM is set.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.c         | 18 ---------
 drivers/pci/pci.h         |  5 ++-
 drivers/pci/pcie/Makefile |  2 +-
 drivers/pci/pcie/aspm.c   | 78 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       | 61 ------------------------------
 5 files changed, 83 insertions(+), 81 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bdbf8a94b4d0..71229ec39e88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1563,24 +1563,6 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 	return 0;
 }
 
-void pci_bridge_reconfigure_ltr(struct pci_dev *dev)
-{
-#ifdef CONFIG_PCIEASPM
-	struct pci_dev *bridge;
-	u32 ctl;
-
-	bridge = pci_upstream_bridge(dev);
-	if (bridge && bridge->ltr_path) {
-		pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
-		if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
-			pci_dbg(bridge, "re-enabling LTR\n");
-			pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
-						 PCI_EXP_DEVCTL2_LTR_EN);
-		}
-	}
-#endif
-}
-
 static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	int i = 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f43873049d52..6771862de921 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -97,7 +97,6 @@ void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
-void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
@@ -571,11 +570,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pci_configure_ltr(struct pci_dev *pdev);
+void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pci_configure_ltr(struct pci_dev *pdev) { }
+static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..6461aa93fe76 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -6,7 +6,7 @@ pcieportdrv-y			:= portdrv.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
-obj-$(CONFIG_PCIEASPM)		+= aspm.o
+obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 060f4b3c8698..6d077e237a65 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -24,6 +24,8 @@
 
 #include "../pci.h"
 
+#ifdef CONFIG_PCIEASPM
+
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
@@ -943,6 +945,81 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
+void pci_bridge_reconfigure_ltr(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	u32 ctl;
+
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge && bridge->ltr_path) {
+		pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
+		if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
+			pci_dbg(bridge, "re-enabling LTR\n");
+			pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
+						 PCI_EXP_DEVCTL2_LTR_EN);
+		}
+	}
+}
+
+void pci_configure_ltr(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+	struct pci_dev *bridge;
+	u32 cap, ctl;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	/* Read L1 PM substate capabilities */
+	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+
+	pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &cap);
+	if (!(cap & PCI_EXP_DEVCAP2_LTR))
+		return;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_DEVCTL2, &ctl);
+	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
+		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
+			pdev->ltr_path = 1;
+			return;
+		}
+
+		bridge = pci_upstream_bridge(pdev);
+		if (bridge && bridge->ltr_path)
+			pdev->ltr_path = 1;
+
+		return;
+	}
+
+	if (!host->native_ltr)
+		return;
+
+	/*
+	 * Software must not enable LTR in an Endpoint unless the Root
+	 * Complex and all intermediate Switches indicate support for LTR.
+	 * PCIe r4.0, sec 6.18.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
+		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_LTR_EN);
+		pdev->ltr_path = 1;
+		return;
+	}
+
+	/*
+	 * If we're configuring a hot-added device, LTR was likely
+	 * disabled in the upstream bridge, so re-enable it before enabling
+	 * it in the new device.
+	 */
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge && bridge->ltr_path) {
+		pci_bridge_reconfigure_ltr(pdev);
+		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_LTR_EN);
+		pdev->ltr_path = 1;
+	}
+}
+
 /* Recheck latencies and update aspm_capable for links under the root */
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
@@ -1447,3 +1524,4 @@ bool pcie_aspm_support_enabled(void)
 {
 	return aspm_support_enabled;
 }
+#endif /* CONFIG_PCIEASPM */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed6b7f48736a..0b8c2c9cc9dd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2159,67 +2159,6 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 	}
 }
 
-static void pci_configure_ltr(struct pci_dev *dev)
-{
-#ifdef CONFIG_PCIEASPM
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-	struct pci_dev *bridge;
-	u32 cap, ctl;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	/* Read L1 PM substate capabilities */
-	dev->l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_LTR))
-		return;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
-	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
-		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
-			dev->ltr_path = 1;
-			return;
-		}
-
-		bridge = pci_upstream_bridge(dev);
-		if (bridge && bridge->ltr_path)
-			dev->ltr_path = 1;
-
-		return;
-	}
-
-	if (!host->native_ltr)
-		return;
-
-	/*
-	 * Software must not enable LTR in an Endpoint unless the Root
-	 * Complex and all intermediate Switches indicate support for LTR.
-	 * PCIe r4.0, sec 6.18.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
-		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
-					 PCI_EXP_DEVCTL2_LTR_EN);
-		dev->ltr_path = 1;
-		return;
-	}
-
-	/*
-	 * If we're configuring a hot-added device, LTR was likely
-	 * disabled in the upstream bridge, so re-enable it before enabling
-	 * it in the new device.
-	 */
-	bridge = pci_upstream_bridge(dev);
-	if (bridge && bridge->ltr_path) {
-		pci_bridge_reconfigure_ltr(dev);
-		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
-					 PCI_EXP_DEVCTL2_LTR_EN);
-		dev->ltr_path = 1;
-	}
-#endif
-}
-
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_PASID
-- 
2.34.1


