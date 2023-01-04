Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB165D6C7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 16:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjADPDF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 10:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjADPCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 10:02:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE90126;
        Wed,  4 Jan 2023 07:02:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A4261738;
        Wed,  4 Jan 2023 15:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB433C433F2;
        Wed,  4 Jan 2023 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672844568;
        bh=qxY2BbfKlE0QFSBqOhdFOmLlzC/+Cca9PIR3VqNP+Q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tKx4WOtL3mjSj0RspNWDz+lQk45OFXNyfaeEbcMX65rhq1HQf3Z06ixaoru6BfeU5
         P7eRUfuUer9LHi0XfUNwyFW94/L3P8mItih2Ry1zlx8bGl6uBjnnFFOtaKaYvLgb4G
         SUJ03FVJR5B4jlSZSQ1G3wvUAZ0tAfTAaSu21SF2HY3e0Tk10VR9nd11edNiwmmUGI
         SnU5zNf/3y1ajJdn0QiAOF9uIZGWliljrNKeJS0xdJ7hkMP7tfaO0LXvfTKUQNq+/b
         43nyT+KjG7D30vTYr7pFydhGfd5Lamf9X5iGdZXIZb6TNxmSjaEZZPJi5upjEeIm1C
         smSNRX3CF+4bQ==
Date:   Wed, 4 Jan 2023 09:02:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Witt <thomas@witt.link>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Thomas Witt <kernel@witt.link>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 216877] New: Regression in PCI powermanagement breaks
 resume after suspend
Message-ID: <20230104150246.GA1068896@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba98ad17-53b0-1f76-70f7-10d37d279f9d@witt.link>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 09:44:25AM +0100, Thomas Witt wrote:
> On 04/01/2023 01:30, Bjorn Helgaas wrote:
> > On Mon, Jan 02, 2023 at 11:15:16AM -0600, Bjorn Helgaas wrote:
> > > On Mon, Jan 02, 2023 at 02:02:51PM +0000, bugzilla-daemon@kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=216877
> > > > 
> > > >              Bug ID: 216877
> > > >             Summary: Regression in PCI powermanagement breaks resume after
> > > >                      suspend
> > > >      Kernel Version: 6.0.0-rc1

BTW, if the bisect is correct, I think the regression actually is in
v6.1-rc1, where 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates
Control Register programming") appeared. 

> > > > Created attachment 303512
> > > >    --> https://bugzilla.kernel.org/attachment.cgi?id=303512&action=edit
> > > > output of git bisect log
> > > > 
> > > > After commit 5e85eba6f50dc288c22083a7e213152bcc4b8208 "PCI/ASPM:
> > > > Refactor L1 PM Substates Control Register programming" my Laptop
> > > > does not resume PCI devices back from suspend.
> > 
> > Thomas, could you try the debug patch below on top of v6.2-rc1?
> 
> Thank you for that patch Bjorn, but as far as I can see it does not change
> anything.

Thanks for testing it.  Maybe Vidya will have more ideas.  The patch
below (based on v6.2-rc1) would revert 5e85eba6f50d and 4ff116d0d5fd.
If 5e85eba6f50d is the culprit, it should fix the regression.  It
would also potentially break L1 substates after resume, so we'd like
to avoid reverting it if possible.

But the "Unable to change power state from D3hot to D0, device
inaccessible" symptom suggests that the device is still in D3, which
would be more like a wakeup issue than an ASPM issue. 

Your bisect log said 3e347969a577 ("PCI/PM: Reduce D3hot delay with
usleep_range()") was "good", but it would be worth double-checking,
e.g., see if reverting it from v6.2-rc1 makes any difference.

Bjorn

commit 61de2691d549 ("Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming"")
parent 1b929c02afd3
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Jan 4 08:38:53 2023 -0600

    Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming"
    
    This reverts 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates Control
    Register programming") and 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates
    Capability for suspend/resume").

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
index 53a1fa306e1e..4b4184563a92 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -470,31 +470,6 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 	pci_write_config_dword(pdev, pos, val);
 }
 
-static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
-{
-	u16 l1ss = dev->l1ss;
-	u32 l1_2_enable;
-
-	/*
-	 * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
-	 * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
-	 */
-	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
-
-	/*
-	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
-	 * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
-	 * enable bits, even though they're all in PCI_L1SS_CTL1.
-	 */
-	l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
-	ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
-
-	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
-	if (l1_2_enable)
-		pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
-				       ctl1 | l1_2_enable);
-}
-
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
@@ -504,6 +479,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
 	u32 pctl1, pctl2, cctl1, cctl2;
+	u32 pl1_2_enables, cl1_2_enables;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
@@ -552,21 +528,39 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	    ctl2 == pctl2 && ctl2 == cctl2)
 		return;
 
-	pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
-		   PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-		   PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
-	pctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
-			  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-			  PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
-	aspm_program_l1ss(parent, pctl1, ctl2);
+	/* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
+	pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
 
-	cctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
-		   PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-		   PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
-	cctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
-			  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-			  PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
-	aspm_program_l1ss(child, cctl1, ctl2);
+	if (pl1_2_enables || cl1_2_enables) {
+		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
+					PCI_L1SS_CTL1_L1_2_MASK, 0);
+		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+					PCI_L1SS_CTL1_L1_2_MASK, 0);
+	}
+
+	/* Program T_POWER_ON times in both ports */
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
+	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
+
+	/* Program Common_Mode_Restore_Time in upstream device */
+	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
+
+	/* Program LTR_L1.2_THRESHOLD time in both ports */
+	pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
+	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
+
+	if (pl1_2_enables || cl1_2_enables) {
+		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
+					pl1_2_enables);
+		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
+					cl1_2_enables);
+	}
 }
 
 static void aspm_l1ss_init(struct pcie_link_state *link)
@@ -757,43 +751,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
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
