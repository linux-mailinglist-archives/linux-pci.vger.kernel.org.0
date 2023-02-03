Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D068A64F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjBCWsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 17:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBCWsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 17:48:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A54ED2;
        Fri,  3 Feb 2023 14:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0255BB82C23;
        Fri,  3 Feb 2023 22:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731AEC433D2;
        Fri,  3 Feb 2023 22:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675464512;
        bh=bxfdW6NyxXA0iJxpF8h7WEQLM5dseUh1XQnylYGTSwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phy3flK0u/jdz7OLVAYPz/biXMUALXEoAHVMvMNFJFQQQeNR//nSEq+VtK15bWaii
         pJpDm+pEK92+3W2HQq7EGtucQFmHLJy2YhwSCVbk96oZai+MpS3z8kmORZFGFEfwsg
         rQmnWtgLGOzVu1oRiyJU2W0gdfU8mKuXtoIocPTUrHqUKfoVGmarJyEQI1jR1okq0Z
         xeAdHd5HjKE34Q6Fo994ZWeRqbH3u9fH6FfdVuO/Ns/x06fhQ0IOoR/sGnnexsbUc7
         UPH43wtAeU25EdnODF2ohALwZy9SVchm3uK5dTbHqwoxGOPIdw0HC9lfgP9ED3GGCN
         PKVaFe2exquVg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Witt <kernel@witt.link>, Vidya Sagar <vidyas@nvidia.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"
Date:   Fri,  3 Feb 2023 16:48:19 -0600
Message-Id: <20230203224820.2056582-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203224820.2056582-1-helgaas@kernel.org>
References: <20230203224820.2056582-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 4ff116d0d5fd8a025604b0802d93a2d5f4e465d1.

Thomas Witt reported that 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates
Control Register programming") broke suspend/resume.

4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume") uses a function added by 5e85eba6f50d, so revert it first.

Note that reverting 4ff116d0d5fd means L1 Substates config will be lost on
suspend/resume.  As far as we know the box will use more power but will
still *work* correctly.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216877
Reported-by: Thomas Witt <kernel@witt.link>
Tested-by: Thomas Witt <kernel@witt.link>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c       |  7 -------
 drivers/pci/pci.h       |  4 ----
 drivers/pci/pcie/aspm.c | 37 -------------------------------------
 3 files changed, 48 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fba95486caaf..5641786bd020 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1665,7 +1665,6 @@ int pci_save_state(struct pci_dev *dev)
 		return i;
 
 	pci_save_ltr_state(dev);
-	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -1772,7 +1771,6 @@ void pci_restore_state(struct pci_dev *dev)
 	 * LTR itself (in the PCIe capability).
 	 */
 	pci_restore_ltr_state(dev);
-	pci_restore_aspm_l1ss_state(dev);
 
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
@@ -3465,11 +3463,6 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
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
index 9ed3b5550043..9049d07d3aae 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -566,14 +566,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
-void pci_save_aspm_l1ss_state(struct pci_dev *dev);
-void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
-static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
-static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53a1fa306e1e..915cbd939dd9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -757,43 +757,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
-void pci_save_aspm_l1ss_state(struct pci_dev *dev)
-{
-	struct pci_cap_saved_state *save_state;
-	u16 l1ss = dev->l1ss;
-	u32 *cap;
-
-	if (!l1ss)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
-
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL2, cap++);
-	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, cap++);
-}
-
-void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
-{
-	struct pci_cap_saved_state *save_state;
-	u32 *cap, ctl1, ctl2;
-	u16 l1ss = dev->l1ss;
-
-	if (!l1ss)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
-	if (!save_state)
-		return;
-
-	cap = (u32 *)&save_state->cap.data[0];
-	ctl2 = *cap++;
-	ctl1 = *cap;
-	aspm_program_l1ss(dev, ctl1, ctl2);
-}
-
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-- 
2.25.1

