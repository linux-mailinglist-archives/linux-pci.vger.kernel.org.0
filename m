Return-Path: <linux-pci+bounces-3945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7812861E49
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569351F23BDC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 20:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A57E1487CD;
	Fri, 23 Feb 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWR+aED1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DA1482F2;
	Fri, 23 Feb 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721937; cv=none; b=soW36vjrVbVZDfDOpzsULQDVydvOMWDXII41rHRMOlpYZDHKZqTCw3GhHP2xNRxWGva6herb21T8zew0WMZV2qkIJMo6CaVtYGaoBpGaBXmpYdgHwfQvp3tzjB/6Wevj8BSbaSRwrph4m7nFqyRMf9RSvlAJYlQdxeWmbsSs2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721937; c=relaxed/simple;
	bh=sCYWCUutUwF8t97LLETKaSh/tWIJHSaDRVQHK3LTBl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6rwURJEu3m5m921Tpfo/5B34SB5tZefp6Y0R4kO1I3exGPeXFFDSjyrB88ZRqQPOBk9deDr+YOb5SuPoHI4KoxSzdu/2PP8t4T5hoiBoNaTi18v8C8S0r9UUxkHv1g927ej16G9Tvl3PtnaMOJVJnt0Ok7ZChaocbywtMnylWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWR+aED1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBEFC4166B;
	Fri, 23 Feb 2024 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721936;
	bh=sCYWCUutUwF8t97LLETKaSh/tWIJHSaDRVQHK3LTBl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWR+aED1oIMzpkVtL+tpBdAgf2q8MZ2OrZgsyavI4HZcn0morX0ROVSa7nIBv2JAT
	 4c4wg+qUsNNrojwieSiW5q4SdsGIgxdOJVOgyhIsCn5IeDPcuih1EYt+P58pZEx4JC
	 Up4YpkxjOuooCtyVow/dmNvu+Uofg2Lhwusy98DPvtf2EyJCNHc+c/FB9wjVpo2P8W
	 vzRuNasQZZl5rZv010ucp8UjVa60Ajfmle86JfgXR/LDbWMNLldiHjoyQtqBs3oGRQ
	 gH04CPBGSKX55JlWE2eGDIS3EcR0XWrGwZJBcXoGX7fHu7JCDsyX9ngRy2oj3KiH2b
	 YLCvl4A+7obLw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 1/5] PCI/ASPM: Move pci_configure_ltr() to aspm.c
Date: Fri, 23 Feb 2024 14:58:47 -0600
Message-Id: <20240223205851.114931-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223205851.114931-1-helgaas@kernel.org>
References: <20240223205851.114931-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David E. Box" <david.e.box@linux.intel.com>

The Latency Tolerance Reporting (LTR) mechanism supports the ASPM L1.2
state and is only configured when CONFIG_PCIEASPM is set.

Move pci_configure_ltr() and pci_bridge_reconfigure_ltr() into aspm.c since
they only build when CONFIG_PCIEASPM is set.  No functional change
intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20240128233212.1139663-2-david.e.box@linux.intel.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
[bhelgaas: commit log, split build change from function moves]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c       | 18 ----------
 drivers/pci/pci.h       |  5 ++-
 drivers/pci/pcie/aspm.c | 75 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c     | 61 ---------------------------------
 4 files changed, 79 insertions(+), 80 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..c783e0f1f2a9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1626,24 +1626,6 @@ static int pci_save_pcie_state(struct pci_dev *dev)
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
index 2336a8d1edab..9aeba82facc4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -97,7 +97,6 @@ void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
-void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
@@ -573,11 +572,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
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
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5a0066ecc3c5..d1538f73f2f9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -938,6 +938,81 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b7335be56008..b809c0b0e0e5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2209,67 +2209,6 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
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


