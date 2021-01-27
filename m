Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D652306091
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhA0QHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 11:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343499AbhA0QFj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 11:05:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51F4D2085B;
        Wed, 27 Jan 2021 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611763499;
        bh=yYsgLRUmRxGz/ZaXcE1r1SS47EHfehsiLZXwPGcjmtM=;
        h=From:To:Cc:Subject:Date:From;
        b=PhkGhScATQZIN0Y0VqjdzclS5aAOBbWGTAap4ciSZujfO02W4vpSvZkFW7MTZbyEk
         R0Y9kCdiKt07WjPtX+tHi0+JhKRbot9GdFKtEHQFRM7p7q4TWqRn4f+SJoBdSK3BT/
         v4G/rDp5yomdcDgv0uu0dLpqh3lhvY8rmm3ktNksAcNVCfSjplSQToDEc1zY/CFSWU
         g0f4vVlY9hVEUvtokw6kNVH84YFiHe7jQ/rPX9PQKiw7pHrb8SBCb6UQpqVeaOTBx2
         oCwcDMUBYq2cn8HtcAlGoPsPE6jOywpwFliPkF9+2sPprTY+6sa/rc+3ZpUNuspGgm
         E4UT2bJNn5AZQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "Kenneth R . Crudup" <kenny@panix.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Revert "PCI/ASPM: Save/restore L1SS Capability for suspend/resume"
Date:   Wed, 27 Jan 2021 10:04:49 -0600
Message-Id: <20210127160449.2990506-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 4257f7e008ea394fcecc050f1569c3503b8bcc15.

Kenneth reported that after 4257f7e008ea, he sees a torrent of disk I/O
errors on his NVMe device, and possibly other devices, until a reboot.

Link: https://lore.kernel.org/linux-pci/20201228040513.GA611645@bjorn-Precision-5520/
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
This is tentative, pending a better fix for the issue.

 drivers/pci/pci.c       |  7 -------
 drivers/pci/pci.h       |  4 ----
 drivers/pci/pcie/aspm.c | 44 -----------------------------------------
 3 files changed, 55 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d213..790393d1e318 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1558,7 +1558,6 @@ int pci_save_state(struct pci_dev *dev)
 		return i;
 
 	pci_save_ltr_state(dev);
-	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -1665,7 +1664,6 @@ void pci_restore_state(struct pci_dev *dev)
 	 * LTR itself (in the PCIe capability).
 	 */
 	pci_restore_ltr_state(dev);
-	pci_restore_aspm_l1ss_state(dev);
 
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
@@ -3353,11 +3351,6 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
-	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
-					    2 * sizeof(u32));
-	if (error)
-		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
-
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5c59365092fa..a7bdf0b1d45d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -582,15 +582,11 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
-void pci_save_aspm_l1ss_state(struct pci_dev *dev);
-void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
-static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
-static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a08e7d6dc248..ac0557a305af 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -734,50 +734,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
-void pci_save_aspm_l1ss_state(struct pci_dev *dev)
-{
-	int aspm_l1ss;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
-	if (!aspm_l1ss)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
-
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
-	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
-}
-
-void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
-{
-	int aspm_l1ss;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
-	if (!aspm_l1ss)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
-
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
-	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
-}
-
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-- 
2.25.1

