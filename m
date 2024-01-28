Return-Path: <linux-pci+bounces-2656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A563D83FAF1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EA7B22517
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 23:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934445976;
	Sun, 28 Jan 2024 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbowVwyy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FD44375;
	Sun, 28 Jan 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484737; cv=none; b=JRNAwe6656LfaaUJGUPwO+MJc/6QqD9WmtoGOOUDO2Z6u/7XiTcTlyJL/iQtNN7b/cnaYqU6c1nf9Ub6S5tAqh46r0utnEXI+W4sOCK7ZVhcGJmGmXVT/kj96G1eyDCKH0anAxkA2yKvEaeIJBiJZrIWzXZViRLCs3RMWLM6xf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484737; c=relaxed/simple;
	bh=zbvixNuPPU6eR4jeUQSZ0UqwT+uwHo8lM70mfjwnmpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJRAT+TKzKfRBCQfAAk1B3OinIXWCTtCN2W1/kXggVUzXVhIZpObWY/d3sInG3ph122RM6DbX5ZyLOfKr7WmT48pA0eBD9e88n65FzpdNceo4ovvTpq1wnxdf857C8skMrX52SjLMIfrFXCBY7k3sC2O+uNWVeTC756XXlY/A64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbowVwyy; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706484735; x=1738020735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zbvixNuPPU6eR4jeUQSZ0UqwT+uwHo8lM70mfjwnmpw=;
  b=KbowVwyyN8cOzKiX42Xa3LbOkjSHuh1VWIKFan+IBBRNkViaA7g/EZK8
   0bPk/D3BBqq79y/bUguzm4YFTMsG1bQ3VFc3SOBKThwuYgwUbxgYKtQEu
   +Hc2B3OGIkKTZ7akqqsE9wkQ8/rWv+WqrlU0DIW0NS8Yre7yYjEu2JQuP
   NB2oOgT+mhNeqXcvk5FE/C4GzbyKlMalCNSezvqpW4nNNxCnvbJnCWiFo
   mtYiCNJO63gqt+Tlitc4MaVjkOU9uJ1wmEBp4xQ3zM6y0g1gxrpDT9nA4
   dBoBdicykOFx6GAP5m2u6YQwNGWjtLAcjYix6M9H+c3mgfmwvHQSUNWOg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="467081105"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="467081105"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="930913778"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="930913778"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:14 -0800
Received: from debox1-desk4.intel.com (sdutta-mobl2.amr.corp.intel.com [10.209.55.52])
	by linux.intel.com (Postfix) with ESMTP id 4F7FC580DE6;
	Sun, 28 Jan 2024 15:32:13 -0800 (PST)
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
Subject: [PATCH 3/5] PCI/ASPM: Add back L1 PM Substate save and restore
Date: Sun, 28 Jan 2024 15:32:10 -0800
Message-Id: <20240128233212.1139663-4-david.e.box@linux.intel.com>
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

Commit 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume") was reverted due to a regression that caused resume from
suspend to fail on certain systems. However, lack of this feature is now
causing systems to fail to enter low power CPU states, drawing more power
from the battery.

The original revert mentioned that we restore L1 PM substate configuration
even though ASPM L1 may already be enabled. This is due the fact that the
pci_restore_aspm_l1ss_state() was called before pci_restore_pcie_state().

Try to enable this functionality again following PCIe r6.0.1, sec 5.5.4
more closely by:

  1) Do not restore ASPM configuration in pci_restore_pcie_state() but
     do that after PCIe capability is restored in pci_restore_aspm_state()
     following PCIe r6.0, sec 5.5.4.

  2) If BIOS reenables L1SS on us, particularly L1.2, we need to clear the
     enables in the right order, downstream before upstream. Defer
     restoring the L1SS config until we are at the downstream component.
     Then update the config for both ends of the link in the prescribed
     order.

  3) Program ASPM L1 PM substate configuration before L1 enables.

  4) Program ASPM L1 PM substate enables last after rest of the fields
     in the capability are programmed.

Reported-by: Koba Ko <koba.ko@canonical.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217321
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216782
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877
Cc: Tasev Nikola <tasev.stefanoska@skynet.be>
Cc: Mark Enriquez <enriquezmark36@gmail.com>
Cc: Thomas Witt <kernel@witt.link>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Co-developed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V1 - Move aspm save/restore calls to pci_save/restore_pcie_state()
   - Move aspm save/restore functions outside of CONFIG_PCIEASPM so that
     L1SS state is always managed.
   - pcie_link_state is now unavailable when CONFIG_PCIEASPM=n, so
     use pcie_downstream_port() to test for the link during restore.
   - Comment and code cleanup suggested by Bjorn and Mika

Previous history before new series:

v5: https://lore.kernel.org/linux-pci/20231221011250.191599-1-david.e.box@linux.intel.com/
v4: https://lore.kernel.org/linux-pci/20231002070044.2299644-1-mika.westerberg@linux.intel.com/
v3: https://lore.kernel.org/linux-pci/20230925074636.2893747-1-mika.westerberg@linux.intel.com/
v2: https://lore.kernel.org/linux-pci/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
v1: https://lore.kernel.org/linux-pci/20230627062442.54008-1-mika.westerberg@linux.intel.com/ 

 drivers/pci/pci.c       |  19 +++++-
 drivers/pci/pci.h       |   2 +
 drivers/pci/pcie/aspm.c | 136 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 144 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 71229ec39e88..0a8613e77dab 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1560,6 +1560,8 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
 	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
 
+	pci_save_aspm_state(dev);
+
 	return 0;
 }
 
@@ -1567,7 +1569,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	int i = 0;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u16 *cap, val;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
@@ -1582,12 +1584,20 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
+
+	/*
+	 * Restore only the LNKCTL register with the ASPM control field
+	 * clear. ASPM will be restored in pci_restore_aspm_state().
+	 */
+	val = cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
+
+	pci_restore_aspm_state(dev);
 }
 
 static int pci_save_pcix_state(struct pci_dev *dev)
@@ -3497,6 +3507,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
+					    2 * sizeof(u32));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b48e8e4f360f..7b14cdbe2e69 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -98,6 +98,8 @@ void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_aspm_get_l1ss(struct pci_dev *pdev);
+void pci_save_aspm_state(struct pci_dev *pdev);
+void pci_restore_aspm_state(struct pci_dev *pdev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 93718b733af3..3185058e9c41 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -30,6 +30,131 @@ void pci_aspm_get_l1ss(struct pci_dev *pdev)
 	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
 }
 
+static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
+				    u32 clear, u32 set)
+{
+	u32 val;
+
+	pci_read_config_dword(pdev, pos, &val);
+	val &= ~clear;
+	val |= set;
+	pci_write_config_dword(pdev, pos, val);
+}
+
+void pci_save_aspm_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 l1ss = pdev->l1ss;
+	u32 *cap;
+
+	/*
+	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
+	 * is already saved in pci_save_pcie_state().
+	 */
+	if (!l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+}
+
+static void pcie_restore_aspm_l1ss(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
+	struct pci_dev *parent = pdev->bus->self;
+	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
+	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
+
+	/*
+	 * In case BIOS enabled L1.2 after resume, we need to disable it first
+	 * on the downstream component before the upstream. So, don't attempt to
+	 * restore either until we are at the downstream component.
+	 */
+	if (pcie_downstream_port(pdev) || !parent)
+		return;
+
+	if (!pdev->l1ss || !parent->l1ss)
+		return;
+
+	cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
+	if (!cl_save_state || !pl_save_state)
+		return;
+
+	cap = &cl_save_state->cap.data[0];
+	cl_ctl2 = *cap++;
+	cl_ctl1 = *cap;
+	cap = &pl_save_state->cap.data[0];
+	pl_ctl2 = *cap++;
+	pl_ctl1 = *cap;
+
+
+	/*
+	 * Disable L1.2 on this downstream endpoint device first, followed
+	 * by the upstream
+	 */
+	pci_clear_and_set_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_L1_2_MASK, 0);
+	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_L1_2_MASK, 0);
+
+	/*
+	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD
+	 * in PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
+	 * enable bits, even though they're all in PCI_L1SS_CTL1.
+	 */
+	pl_l1_2_enable = pl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	pl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+	cl_l1_2_enable = cl_ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	cl_ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+
+	/* Write back without enables first (above we cleared them in ctl1) */
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, pl_ctl2);
+	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cl_ctl2);
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, pl_ctl1);
+	pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cl_ctl1);
+
+
+	/* Then write back the enables */
+	if (pl_l1_2_enable || cl_l1_2_enable) {
+		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       pl_ctl1 | pl_l1_2_enable);
+		pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
+				       cl_ctl1 | cl_l1_2_enable);
+	}
+}
+
+void pci_restore_aspm_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 *cap, val;
+
+	save_state = pci_find_saved_cap(pdev, PCI_CAP_ID_EXP);
+
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	/* Must match the ordering in pci_save/restore_pcie_state() */
+	val = cap[1] & PCI_EXP_LNKCTL_ASPMC;
+	if (!val)
+		return;
+
+	/*
+	 * We restore L1 substate configuration first before enabling L1
+	 * as the PCIe spec 6.0 sec 5.5.4 suggests.
+	 */
+	pcie_restore_aspm_l1ss(pdev);
+
+	/* Re-enable L0s/L1 */
+	pcie_capability_set_word(pdev, PCI_EXP_LNKCTL, val);
+}
+
 #ifdef CONFIG_PCIEASPM
 
 #ifdef MODULE_PARAM_PREFIX
@@ -434,17 +559,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
-				    u32 clear, u32 set)
-{
-	u32 val;
-
-	pci_read_config_dword(pdev, pos, &val);
-	val &= ~clear;
-	val |= set;
-	pci_write_config_dword(pdev, pos, val);
-}
-
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l12_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
-- 
2.34.1


