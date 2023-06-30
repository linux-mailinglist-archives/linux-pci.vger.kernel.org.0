Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAB7439C8
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjF3KnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjF3Kmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:42:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700FF3AB4
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688121722; x=1719657722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/wC3Yr5iTXHPR643WxwyRyrYaQ5orPoTl4rcSv5wmpU=;
  b=NEbOI4pTlH13lzUnnpvfOJsj1NZa8/8ibvNP26J/Ye15PWOz4t0TI3VE
   nYY7ooCw6LeZY/iCB//j1D9/dLYvxtTYu0/uBrMNbfJJsAfqjXEwFaupC
   LFfThi3P1RVhsQZzIPxc55/9l2MiyhIvb1TjNs/UW2aBq9Hb18cMTdqUR
   iInu/EPJVodU2zEK/B8TbavFdiiMuQzRcrccvR3iVjUZt7l4jtnGCWdE/
   q9tparkYWrzoQ0u4NHmYwxi7u0rG2acB0Q/Wj9yBXtVBdfZLZAg+uG8ZK
   iOlOjeY9hBV1MeZkIlqGlBNQZhlnqW1R3uXj8mVcR61qO9jqOsVJ2yWwp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="341948043"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="341948043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 03:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830884874"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="830884874"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2023 03:41:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1F472358; Fri, 30 Jun 2023 13:41:54 +0300 (EEST)
Date:   Fri, 30 Jun 2023 13:41:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Thomas Witt <thomas@witt.link>, Thomas Witt <kernel@witt.link>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230630104154.GS14638@black.fi.intel.com>
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
 <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
 <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 07:24:55AM -0700, David E. Box wrote:
> On Thu, 2023-06-29 at 11:47 +0200, Thomas Witt wrote:
> > On 28/06/2023 12:59, Mika Westerberg wrote:
> > > I wonder if the patch actually helps here now because the reason we want
> > > to add it back is that it allows the CPU to enter lower power states and
> > > thus reducing the power consumption in S2idle too. Do you observe that
> > > when you have the patch applied?
> > 
> > No joy. I did not check what its actually doing, but the computer takes 
> > about 150mA over the charger at idle with screen off and 140mA in 
> > suspend. With mem_sleep set to "deep", it takes about 20mA in suspend. 
> > All with the battery at 100%, at 19.7V.
> > 
> > So I guess I want to keep the "deep" setting in my cmdline.
> 
> It's likely something is not entering the right state. You can try the following
> script to check what the cause may be.
> 
> https://github.com/intel/S0ixSelftestTool

That would be useful insights, indeed.

@Thomas, below is an updated patch. I wonder if you could try it out?
This one restores L1 substates first and then L0s/L1 as the spec
suggests. If this does not work, them I'm not sure what to do because
now we should be doing exactly what the spec is saying (unless I
misinterpret something):

  - Write L1 enables on the upstream component first then downstream
    (this is taken care by the parent child order of the Linux PM).
  - Program L1 SS before L1 enables
  - Program L1 SS enables after rest of the fields in the capability

Applies on top of v6.4.

------8<-----8<-----8<-----8<-----

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..2e947fea5afc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1545,7 +1545,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	int i = 0;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u16 *cap, val;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
@@ -1560,7 +1560,14 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 
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
@@ -1671,6 +1678,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
+	pci_save_aspm_state(dev);
 	pci_save_ptm_state(dev);
 	return pci_save_vc_state(dev);
 }
@@ -1784,6 +1792,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
+	pci_restore_aspm_state(dev);
 
 	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
@@ -3467,6 +3476,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
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
index 2475098f6518..47dbbc006884 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -567,10 +567,14 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
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
index 66d7514ca111..879896fffb1e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -7,6 +7,7 @@
  * Copyright (C) Shaohua Li (shaohua.li@intel.com)
  */
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -751,6 +752,114 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
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
+static void pcie_restore_aspm_l1ss(struct pci_dev *pdev)
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
+	/*
+	 * Must match the ordering in pci_save/restore_pcie_state().
+	 * This is PCI_EXP_LNKCTL.
+	 */
+	val = cap[1] & PCI_EXP_LNKCTL_ASPMC;
+	if (!val)
+		return;
+
+	/*
+	 * We restore L1 substate configuration first before enabling L1
+	 * as the PCIe spec 6.0 sec 5.5.4 suggests.
+	 * */
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
2.39.2

