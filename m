Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5373F476
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 08:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjF0GZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjF0GYn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 02:24:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22FE5A
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687847082; x=1719383082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mtTfCR1/kEQGOMkkD9qlOmvJBnauLV2J56E4Cbj9v14=;
  b=NDxMMq+LAIW5RWZEGH6wfme6U/44V1rqPSpptCpiMGWjRZyiOduu8HFR
   +PmiadDGK8DNCfTBTd7O/BY2Nwb1SeJ+AsMG8eKUlweaSw+BPRDSCv2Vs
   7Zbh83fwR6J0nsOuIGPoTKHXRCMQB3ZsPAv1Gx3McT4l2UZvbdMvEgFto
   dbW4StYab0zkgjlNiVO+PZja+eIAlt/6sBLjrCVz+LSCOGJzswSZ/28NI
   o9vC05KqFI7zy/XlEBa4wijsesv9XBiKjc14FaGwj00quCo3dBWemUx9l
   0dG8pclxkqVFqKqvPCuEZzYbad5EfGf5qhWdDQD6OGKQrRYKKqvfLDhZb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="361530290"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="361530290"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="829532973"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="829532973"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2023 23:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B7916370; Tue, 27 Jun 2023 09:24:42 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Date:   Tue, 27 Jun 2023 09:24:42 +0300
Message-Id: <20230627062442.54008-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
due to a regression that caused resume from suspend to fail on certain
systems. However, we never added this capability back and this is now
causing systems fail to enter low power CPU states, drawing more power
from the battery.

The original revert mentioned that we restore L1 PM substate configuration
even though ASPM L1 may already be enabled. This is due the fact that
the pci_restore_aspm_l1ss_state() was called before
pci_restore_pcie_state().

Try to enable this functionality again by:

 1) Moving the restore happen after PCIe capability is restored
    following PCIe r6.0, sec 5.5.4.
 2) Following the PCIe spec more closely to restore L1 PM substate
    configuration (program enable bits last).
 3) Adding denylist that skips the restoring on the ASUS system where
    the original regression happened, just in case.

Reported-by: Koba Ko <koba.ko@canonical.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217321
Cc: Tasev Nikola <tasev.stefanoska@skynet.be>
Cc: Mark Enriquez <enriquezmark36@gmail.com>
Cc: Thomas Witt <kernel@witt.link>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi,

There are several systems out there that are not entering lower package
C-states after the first suspend/resume cycle because we do not restore
L1SS configuration as can be seen in the linked bugzilla entry. Although
they are functioning fine they still empty the battery faster than the
user may expect.

Apologies sending this out during merge window but I will be starting my
vacation next week so wanted to get this out before, and possibly
incorporate any changes during the week still.

 drivers/pci/pci.c       |  7 ++++
 drivers/pci/pci.h       |  4 +++
 drivers/pci/pcie/aspm.c | 76 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 578bf0d3ec3c..bf30561aa32c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1679,6 +1679,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
+	pci_save_aspm_l1ss_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1790,6 +1791,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
+	pci_restore_aspm_l1ss_state(dev);
 	pci_restore_ptm_state(dev);
 
 	pci_aer_clear_status(dev);
@@ -3474,6 +3476,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
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
index d09e8f39e429..f34b55701d63 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -560,10 +560,14 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
+void pci_restore_aspm_l1ss_state(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pci_save_aspm_l1ss_state(struct pci_dev *pdev) { }
+static inline void pci_restore_aspm_l1ss_state(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..52e1a69f818a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -7,6 +7,7 @@
  * Copyright (C) Shaohua Li (shaohua.li@intel.com)
  */
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -751,6 +752,81 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 l1ss = pdev->l1ss;
+	u32 *cap;
+
+	if (!l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
+}
+
+/*
+ * Do not restore L1 substates for the below systems even if BIOS has
+ * enabled it initially. This breaks resume from suspend otherwise on
+ * these.
+ */
+static const struct dmi_system_id aspm_l1ss_denylist[] = {
+	{
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=216782 */
+		.ident = "ASUS UX305FA",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "UX305FA"),
+		},
+	},
+	{ }
+};
+
+void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap, ctl1, ctl2, l1_2_enable;
+	u16 l1ss = pdev->l1ss;
+
+	if (!l1ss)
+		return;
+
+	if (dmi_check_system(aspm_l1ss_denylist)) {
+		pci_dbg(pdev, "skipping restoring L1 substates on this system\n");
+		return;
+	}
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	ctl2 = *cap++;
+	ctl1 = *cap;
+
+	/*
+	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD
+	 * in PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
+	 * enable bits, even though they're all in PCI_L1SS_CTL1.
+	 */
+	l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+
+	/* Write back without enables first (above we cleared them in ctl1) */
+	pci_write_config_dword(pdev, l1ss + PCI_L1SS_CTL1, ctl1);
+	pci_write_config_dword(pdev, l1ss + PCI_L1SS_CTL2, ctl2);
+
+	/* Then write back the enables */
+	if (l1_2_enable)
+		pci_write_config_dword(pdev, l1ss + PCI_L1SS_CTL1,
+				       ctl1 | l1_2_enable);
+}
+
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-- 
2.40.1

