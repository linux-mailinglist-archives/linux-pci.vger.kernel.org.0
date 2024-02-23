Return-Path: <linux-pci+bounces-3947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48402861E4D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B3FB224C5
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537C14AD03;
	Fri, 23 Feb 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8dcpd8e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89D14A0BE;
	Fri, 23 Feb 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721940; cv=none; b=joiKDMURLHeePyMtX19Dd5xj4SqLJjyo8kmOGhxKEml9Bwl+saw4CV8T25LLqpxBpj5pxIsg10T0HgrGL8vPwkSg4BAsXdLIsyE7A15cuX2Xb61TPnGbZTyQr97jard4xcHBK3lsX3QcEv+buqw9btZ2Lbd0rSf8gu7ZkCo13wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721940; c=relaxed/simple;
	bh=ZfUmjBzp8E1Yoa6olg2QBswrQUhVxgYSSrq94pwX0ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mliQN6AzFUs5LCgothA+VHU2kevyhcMvcBi/ETcFnOGVzDfYTaOUshjkMBWM8pDfbjVqgBJ4j6+biZlLlPUhRwj0TQazdWsuQoMoKHhMGZb882uzunuBCJ9mBGYXI3xSoH27Yuzif1y4Mf7hwXPtOCuPJeTHQEhcQT8j78xgo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8dcpd8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002EDC433C7;
	Fri, 23 Feb 2024 20:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721940;
	bh=ZfUmjBzp8E1Yoa6olg2QBswrQUhVxgYSSrq94pwX0ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8dcpd8ekx0tudIxaOtd1E0+tGQ3N/GZOaojbBM9YLpuO4y010iIocN6wsCnHl8iK
	 hg/ddlPIXk6Om4WNwjFet4ezwdO1RO45dwbv7IR1S7ncp51vLmxStOIcH+IzwrulXV
	 2ciE+A25izcNBL3CS119zqxasvtD0fQpNo/5E4AqzfML8VflRhuJ6xJgEMo+m6Kd02
	 mMBQEzsyC6Isar8WduVLZ5DqIZuecQMFGSJ+MCj712pxeFTbGOT+9V1h5TpZfdRNjT
	 WSoFkXzT/77dT9kVr/4Qvl/i3+BT1EnVRiPXulHKHDRoqZLFQYl0oNBC65AT9JKIHi
	 UNifBM8RXCK6w==
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
Subject: [PATCH v7 3/5] PCI/ASPM: Move pci_save_ltr_state() to aspm.c
Date: Fri, 23 Feb 2024 14:58:49 -0600
Message-Id: <20240223205851.114931-4-helgaas@kernel.org>
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

Even when CONFIG_PCIEASPM is not set, we save and restore the LTR
Capability so that if ASPM L1.2 and LTR were configured by the platform,
ASPM L1.2 will still work after suspend/resume, when that platform
configuration may be lost. See dbbfadf23190 ("PCI/ASPM: Save LTR Capability
for suspend/resume").

Since ASPM L1.2 depends on the LTR Capability, move the save/restore code
to the part of aspm.c that is always compiled regardless of
CONFIG_PCIEASPM.  No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20240128233212.1139663-5-david.e.box@linux.intel.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
[bhelgaas: commit log, reorder to make this a pure move]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c       | 40 ----------------------------------------
 drivers/pci/pci.h       |  5 +++++
 drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c783e0f1f2a9..564e2cf2dde5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1689,46 +1689,6 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
 }
 
-static void pci_save_ltr_state(struct pci_dev *dev)
-{
-	int ltr;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!ltr)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
-		return;
-	}
-
-	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
-}
-
-static void pci_restore_ltr_state(struct pci_dev *dev)
-{
-	struct pci_cap_saved_state *save_state;
-	int ltr;
-	u32 *cap;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state || !ltr)
-		return;
-
-	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
-}
-
 /**
  * pci_save_state - save the PCI configuration space of a device before
  *		    suspending
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9aeba82facc4..ad3add45345c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -567,6 +567,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
+
+/* ASPM-related functionality we need even without CONFIG_PCIEASPM */
+void pci_save_ltr_state(struct pci_dev *dev);
+void pci_restore_ltr_state(struct pci_dev *dev);
+
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index d50c0f83430f..21731b232fb8 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -24,6 +24,46 @@
 
 #include "../pci.h"
 
+void pci_save_ltr_state(struct pci_dev *dev)
+{
+	int ltr;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state) {
+		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
+		return;
+	}
+
+	/* Some broken devices only support dword access to LTR */
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
+}
+
+void pci_restore_ltr_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int ltr;
+	u32 *cap;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state || !ltr)
+		return;
+
+	/* Some broken devices only support dword access to LTR */
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
+}
+
 #ifdef CONFIG_PCIEASPM
 
 #ifdef MODULE_PARAM_PREFIX
-- 
2.34.1


