Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456969204D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjBJN5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjBJN5C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 08:57:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11927497;
        Fri, 10 Feb 2023 05:56:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43A48B824F5;
        Fri, 10 Feb 2023 13:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812AEC433D2;
        Fri, 10 Feb 2023 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676037415;
        bh=2dZ6EunbSL5EFZ6NLrKfwjy5kso+zkeqpjSc8t7ZulY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eoQjTg7jrk6sYy6f9zPfMrC3tRCHE/iNpxn1nhKGoA5sp2uixYH+T60nGpLkqJmJ+
         8z3V5P6p1gnGGOgHhab8QopkTNyPyEqfp+uh7vnYQQESCHc91PlYKJ8WxaMoTvaUjq
         QnkxQNMp0U3xuvkgVgkC8l5H+9IgFHpT8r8Nk0Of862NiVATpriqChRU0Ob439jgd8
         jfNr3Wm19tIiuCf5IWmS9nDMnQrwrp1zXhwJCiIQQClco1mO2ey+UeI0o5Ex7Ypt6w
         1RIRglUWuBPNcwLu7Q6DxQW88v2jZkvUwFRygVsaNp/N2we6sRQug4N4vc9E5czsPb
         Z2zNB4r0B5jaA==
Date:   Fri, 10 Feb 2023 07:56:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Enriquez <enriquezmark36@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
        tasev.stefanoska@skynet.be, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com, Thomas Witt <kernel@witt.link>
Subject: Re: [PATCH V2] PCI/ASPM: Skip L1SS save/restore if not already
 enabled
Message-ID: <20230210135654.GA2673896@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKd_mfSgzb5Zwb-_hjXMuiFfOw=ZoZn0GrC37=s8DraQTXVRhw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 09:39:56PM +0800, Mark Enriquez wrote:
> I tried the test patch with the "ASPM: can't restore L1SS while L1
> enabled" message on the v6.1 tag.
> 
> I tried setting the ASPM policy to default rather than powersupersave.
> Tested twice.
> The result is I get to see the messages in the kernel log. The system
> resumed successfully in all tests.
> [  330.438136] ACPI: PM: Waking up from system sleep state S3
> [  330.445959] ACPI: EC: interrupt unblocked
> [  330.446174] pcieport 0000:00:1c.0: ASPM: can't restore L1SS while
> L1 enabled (0x0042)
> [  330.446177] pcieport 0000:00:1c.6: ASPM: can't restore L1SS while
> L1 enabled (0x0002)
> [  330.448354] r8169 0000:03:00.0: ASPM: can't restore L1SS while L1
> enabled (0x0142)
> [  330.448368] sdhci-pci 0000:04:00.0: ASPM: can't restore L1SS while
> L1 enabled (0x0102)

That's perfect, thank you very much!  That means we're in dangerous
territory because v6.1 will restore the L1SS state while L1 is
enabled, which the spec doesn't allow for.

If you apply the patch below on vanilla v6.1 (or v6.2-rc, whatever is
more convenient), my hope is that resume will work.

I think we're just going to have to revert for now and give up the
power savings we get from 4ff116d0d5fd.  We'll revisit it later, of
course, to get the power savings back.

commit a6b1e19ca489 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")
parent 830b3c68c1fb
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Feb 10 07:49:18 2023 -0600

    Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"
    
    This reverts commit 4ff116d0d5fd8a025604b0802d93a2d5f4e465d1.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2127aba3550b..92c6f7e5ca2e 100644
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
index b1ebb7ab8805..ce169b12a8f6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -565,14 +565,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
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
