Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1957AD23F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjIYHrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 03:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjIYHrD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 03:47:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5FE180
        for <linux-pci@vger.kernel.org>; Mon, 25 Sep 2023 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695628002; x=1727164002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MF/rDoSTx+oSvWD13qeJfnKKvfQFvkx3L7u1m5XzdHI=;
  b=A4TV4PWdtyrMG/1FrADxEeDMhTtIicNbVSiLcyN+Zn1aepQTGpSu+gHF
   E7mQs44tOXPCubtxevI25YmTTIdk129+ScuvZ9tH7MWtOFqSMsCs1ajVZ
   zAvxrtUzbWqcT53LTnPwBaCxjh5NFaSV+rIZHVziF4a4/1ZV0gFJRM06K
   qN3pK5ftzlMcv2SGda2E4GvHMsy6uKzk2hZtnnMtj+5aRPXsSaLAIH1ra
   6CA38WBAh18/CbV+hcvnHXPcSN01wpKmnnWCSnGC3su/fiBwEeivEoSRu
   jxK30T2InVEFwEW6awdM6Y+v/l1zt/b91K10W+uQ3tAm0wjTz2f+dtDum
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360575200"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360575200"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079121984"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="1079121984"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2023 00:46:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5D34A2E9; Mon, 25 Sep 2023 10:46:36 +0300 (EEST)
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
        Werner Sembach <wse@tuxedocomputers.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?q?=E5=90=B3=E6=98=8A=E6=BE=84=20Ricky?= 
        <ricky_wu@realtek.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI/ASPM: Add back L1 PM Substate save and restore
Date:   Mon, 25 Sep 2023 10:46:36 +0300
Message-Id: <20230925074636.2893747-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
the pci_restore_aspm_l1ss_state() was called before pci_restore_pcie_state().

Try to enable this functionality again following PCIe r6.0.1, sec 5.5.4
more closely by:

  1) Do not restore ASPM configuration in pci_restore_pcie_state() but
     do that after PCIe capability is restored in pci_restore_aspm_state()
     following PCIe r6.0, sec 5.5.4.

  2) ASPM is first enabled on the upstream component and then downstream
     (this is already forced by the parent-child ordering of Linux
     Device Power Management framework).

  3) Program ASPM L1 PM substate configuration before L1 enables.

  4) Program ASPM L1 PM substate enables last after rest of the fields
     in the capability are programmed.

  5) Add denylist that skips restoring on the ASUS and TUXEDO systems
     where these regressions happened, just in case. For the TUXEDO case
     we only skip restore if the BIOS is involved in system suspend
     (that's forcing "mem_sleep=deep" in the command line). This is to
     avoid possible power regression when the default suspend to idle is
     used, and at the same time make sure the devices continue working
     after resume when the BIOS is involved.

Reported-by: Koba Ko <koba.ko@canonical.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217321
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216782
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877
Cc: Tasev Nikola <tasev.stefanoska@skynet.be>
Cc: Mark Enriquez <enriquezmark36@gmail.com>
Cc: Thomas Witt <kernel@witt.link>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi all,

Previous versions of the patch can be found:

v2: https://lore.kernel.org/linux-pci/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
v1: https://lore.kernel.org/linux-pci/20230627062442.54008-1-mika.westerberg@linux.intel.com/ 

Changes from v2:

  - Added tested by tag from Kai-Heng Feng.

  - Dropped the two unneeded (u32 *) casts.

  - Dropped unnecessary comment.

Changes from v1:

  - We move ASPM enables from pci_restore_pcie_state() into
    pci_restore_aspm_state() to make sure they are clear when L1SS bits
    are programmed (as per PCIe spec).

  - The denylist includes the TUXEDO system as well but only if suspend
    is done via BIOS (e.g mem_sleep=deep is forced by user). This way
    the PCIe devices should continue working after S3 resume, and at the
    same time allow better power savings. If the default s2idle is used
    then we restore L1SS to allow the CPU enter lower power states. This
    is the best I was able to come up to make everyone happy.

 drivers/pci/pci.c       |  18 ++++-
 drivers/pci/pci.h       |   4 ++
 drivers/pci/pcie/aspm.c | 145 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..7c72d40ec0ff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1576,7 +1576,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	int i = 0;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u16 *cap, val;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
@@ -1591,7 +1591,14 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
+	/*
+	 * Restoring ASPM L1 substates has special requirements
+	 * according to the PCIe spec 6.0. So we restore here only the
+	 * LNKCTL register with the ASPM control field clear. ASPM will
+	 * be restored in pci_restore_aspm_state().
+	 */
+	val = cap[i++] & ~PCI_EXP_LNKCTL_ASPMC;
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val);
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
@@ -1702,6 +1709,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
+	pci_save_aspm_state(dev);
 	pci_save_ptm_state(dev);
 	return pci_save_vc_state(dev);
 }
@@ -1815,6 +1823,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
+	pci_restore_aspm_state(dev);
 
 	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
@@ -3507,6 +3516,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
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
index 39a8932dc340..11cec757a624 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -567,10 +567,14 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pci_save_aspm_state(struct pci_dev *pdev);
+void pci_restore_aspm_state(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pci_save_aspm_state(struct pci_dev *pdev) { }
+static inline void pci_restore_aspm_state(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1bf630059264..8945cf5651f5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -7,6 +7,7 @@
  * Copyright (C) Shaohua Li (shaohua.li@intel.com)
  */
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -17,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
 #include "../pci.h"
@@ -712,6 +714,149 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
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
+static int aspm_l1ss_suspend_via_firmware(const struct dmi_system_id *not_used)
+{
+	return pm_suspend_via_firmware();
+}
+
+/*
+ * Do not restore L1 substates for the below systems even if BIOS has enabled
+ * it initially. This breaks resume from suspend otherwise on these.
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
+	{
+		/*
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216877
+		 *
+		 * This system needs to use suspend to mem instead of its
+		 * default (suspend to idle) to avoid draining the battery.
+		 * However, the BIOS gets confused if we try to restore the
+		 * L1SS registers so avoid doing that if the user forced
+		 * suspend to mem. The default suspend to idle on the other
+		 * hand needs restoring L1SS to allow the CPU to enter low
+		 * power states. This entry should handle both.
+		 */
+		.callback = aspm_l1ss_suspend_via_firmware,
+		.ident = "TUXEDO InfinityBook S 14 v5",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "L140CU"),
+		},
+	},
+	{ }
+};
+
+static bool aspm_l1ss_skip_restore(const struct pci_dev *pdev)
+{
+	const struct dmi_system_id *dmi;
+
+	dmi = dmi_first_match(aspm_l1ss_denylist);
+	if (dmi) {
+		/* If the callback returns zero we can restore L1SS */
+		if (dmi->callback && !dmi->callback(dmi))
+			return false;
+
+		pci_dbg(pdev, "skipping restoring L1 substates on this system\n");
+		return true;
+	}
+
+	return false;
+}
+
+static void pcie_restore_aspm_l1ss(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap, ctl1, ctl2, l1_2_enable;
+	u16 l1ss = pdev->l1ss;
+
+	if (!l1ss)
+		return;
+
+	if (aspm_l1ss_skip_restore(pdev))
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state)
+		return;
+
+	cap = &save_state->cap.data[0];
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
+void pci_restore_aspm_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 *cap, val, tmp;
+
+	save_state = pci_find_saved_cap(pdev, PCI_CAP_ID_EXP);
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
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &tmp);
+	/* Re-enable L0s/L1 */
+	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, tmp | val);
+}
+
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-- 
2.40.1

