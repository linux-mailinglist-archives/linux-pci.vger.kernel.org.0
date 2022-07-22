Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38E57E5C1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiGVRmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiGVRmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 13:42:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5714389AA7;
        Fri, 22 Jul 2022 10:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9B20622A1;
        Fri, 22 Jul 2022 17:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B8AC341C6;
        Fri, 22 Jul 2022 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658511734;
        bh=quYbYLH0rHeFJlaVYrPF8bVK2cgDFseKzvrCpw+Lg2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VHV+I3BbDY1+CE3K4k/Dp8KFhccvyDsM/13/YgPHKNojN/gRWo76bFeFNlKxWYgua
         acSNtQ8h/IRIFole4Pzo38a6l1Nb0CY0+MYdIg2A81NQGSoeREf++AH9gy8i6jNQL6
         X+T8+SD4Ad7RhIu5OqyRMVHH4yvgPfPJLdIuLe4WkBjPh70nfFsSMKGFnzHQCfnr2T
         WWEiT8nypPlp00Olw2tHVlBM0lkj9ggNqtEQ4u7cCubkQ9f+W9qyBiA0gchQMd1+yw
         kjiEmC2w27MuKmHoCdrHEU3tnjEBbVT3ACcEMOXcsSrunYsW0V/FojwEveJjVACo3o
         Mv7g3ZSqfn1DQ==
Date:   Fri, 22 Jul 2022 12:42:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ben Chuang <benchuanggli@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, kenny@panix.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220722174212.GA1911979@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJ_xbqJkXK7-O_kyF=Hrqu0gwskVLUfeK9mWSB1qM8XapLgSQ@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> napisał(a):
> > On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
> > > On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
> > > >
> > > > Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> > > > saved and restored during suspend/resume leading to L1 Substates
> > > > configuration being lost post-resume.
> > > >
> > > > Save the L1 Substates control registers so that the configuration is
> > > > retained post-resume.
> > > >
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> > >
> > > Hi Vidya,
> > >
> > > I tested this patch on kernel v5.19-rc6.
> > > The test device is GL9755 card reader controller on Intel i5-10210U RVP.
> > > This patch can restore L1SS after suspend/resume.
> > >
> > > The test results are as follows:
> > >
> > > After Boot:
> > > #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> > >         Capabilities: [110 v1] L1 PM Substates
> > >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > > ASPM_L1.1+ L1_PM_Substates+
> > >                           PortCommonModeRestoreTime=255us
> > > PortTPowerOnTime=3100us
> > >                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > >                            T_CommonMode=0us LTR1.2_Threshold=3145728ns
> > >                 L1SubCtl2: T_PwrOn=3100us
> > >
> > >
> > > After suspend/resume without this patch.
> > > #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> > >         Capabilities: [110 v1] L1 PM Substates
> > >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > > ASPM_L1.1+ L1_PM_Substates+
> > >                           PortCommonModeRestoreTime=255us
> > > PortTPowerOnTime=3100us
> > >                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> > >                            T_CommonMode=0us LTR1.2_Threshold=0ns
> > >                 L1SubCtl2: T_PwrOn=10us
> > >
> > >
> > > After suspend/resume with this patch.
> > > #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
> > >         Capabilities: [110 v1] L1 PM Substates
> > >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > > ASPM_L1.1+ L1_PM_Substates+
> > >                           PortCommonModeRestoreTime=255us
> > > PortTPowerOnTime=3100us
> > >                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > >                            T_CommonMode=0us LTR1.2_Threshold=3145728ns
> > >                 L1SubCtl2: T_PwrOn=3100us
> > >
> > >
> > > Tested-by: Ben Chuang <benchuanggli@gmail.com>
> >
> > Forgot to add mine:
> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > >
> > > Best regards,
> > > Ben Chuang
> > >
> > >
> > > > ---
> > > > Hi,
> > > > Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
> > > > on your laptop (Dell XPS 13) one last time?
> > > > IMHO, the regression observed on your laptop with an old version of the patch
> > > > could be due to a buggy old version BIOS in the laptop.
> > > >
> > > > Thanks,
> > > > Vidya Sagar
> > > >
> > > >  drivers/pci/pci.c       |  7 +++++++
> > > >  drivers/pci/pci.h       |  4 ++++
> > > >  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 55 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index cfaf40a540a8..aca05880aaa3 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> > > >                 return i;
> > > >
> > > >         pci_save_ltr_state(dev);
> > > > +       pci_save_aspm_l1ss_state(dev);
> > > >         pci_save_dpc_state(dev);
> > > >         pci_save_aer_state(dev);
> > > >         pci_save_ptm_state(dev);
> > > > @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
> > > >          * LTR itself (in the PCIe capability).
> > > >          */
> > > >         pci_restore_ltr_state(dev);
> > > > +       pci_restore_aspm_l1ss_state(dev);
> > > >
> > > >         pci_restore_pcie_state(dev);
> > > >         pci_restore_pasid_state(dev);
> > > > @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
> > > >         if (error)
> > > >                 pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> > > >
> > > > +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> > > > +                                           2 * sizeof(u32));
> > > > +       if (error)
> > > > +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> > > > +
> > > >         pci_allocate_vc_save_buffers(dev);
> > > >  }
> > > >
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index e10cdec6c56e..92d8c92662a4 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
> > > >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> > > >  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> > > >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > > > +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > > > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> > > >  #else
> > > >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> > > >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> > > >  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> > > >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > > > +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> > > > +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> > > >  #endif
> > > >
> > > >  #ifdef CONFIG_PCIE_ECRC
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index a96b7424c9bc..2c29fdd20059 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> > > >                                 PCI_L1SS_CTL1_L1SS_MASK, val);
> > > >  }
> > > >
> > > > +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> > > > +{
> > > > +       int aspm_l1ss;
> > > > +       struct pci_cap_saved_state *save_state;
> > > > +       u32 *cap;
> > > > +
> > > > +       if (!pci_is_pcie(dev))
> > > > +               return;
> > > > +
> > > > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > > > +       if (!aspm_l1ss)
> > > > +               return;
> > > > +
> > > > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > > > +       if (!save_state)
> > > > +               return;
> > > > +
> > > > +       cap = (u32 *)&save_state->cap.data[0];
> > > > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> > > > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> > > > +}
> > > > +
> > > > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> > > > +{
> > > > +       int aspm_l1ss;
> > > > +       struct pci_cap_saved_state *save_state;
> > > > +       u32 *cap;
> > > > +
> > > > +       if (!pci_is_pcie(dev))
> > > > +               return;
> > > > +
> > > > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > > > +       if (!aspm_l1ss)
> > > > +               return;
> > > > +
> > > > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > > > +       if (!save_state)
> > > > +               return;
> > > > +
> > > > +       cap = (u32 *)&save_state->cap.data[0];
> > > > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > > > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> > > > +}
> > > > +
> > > >  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> > > >  {
> > > >         pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > > > --
> > > > 2.17.1
> > > >
> 
> Hi,
> 
> With this patch (and also mentioned
> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@canonical.com/)
> applied on 5.10 (chromeos-5.10) I am observing problems after
> suspend/resume with my WiFi card - it looks like whole communication
> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3
> 
> I played a little bit with this code and it looks like the
> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
> why, not a PCI expert).

Thanks a lot for testing this!  I'm not quite sure what to make of the
results since v5.10 is fairly old (Dec 2020) and I don't know what
other changes are in chromeos-5.10.

Random observations, no analysis below.  This from your dmesg
certainly looks like PCI reads failing and returning ~0:

  Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
  iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
  iwlwifi 0000:01:00.0: Device gone - attempting removal
  Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.

And then we re-enumerate 01:00.0 and it looks like it may have been
reset (BAR is 0):

  pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
  pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]

lspci diffs from before/after suspend:

   00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal decode])
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
  -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr+ TransPend-
  +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
  -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
  +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
  -               LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
  +               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
  -       Capabilities: [150 v0] Null
  -       Capabilities: [200 v1] L1 PM Substates
  -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
  -                         PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
  -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
  -                          T_CommonMode=40us LTR1.2_Threshold=98304ns
  -               L1SubCtl2: T_PwrOn=60us

The DevSta differences might be BIOS bugs, probably not relevant.
Interesting that ASPM is disabled, maybe didn't get enabled after
re-enumerating 01:00.0?  Strange that the L1 PM Substates capability
disappeared.

   01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
		  LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
  -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
  +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
	  Capabilities: [154 v1] L1 PM Substates
		  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			    PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
  -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
  -                          T_CommonMode=0us LTR1.2_Threshold=98304ns
  +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
  +                          T_CommonMode=0us LTR1.2_Threshold=0ns

Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn't
get reinitialized after re-enumeration?  Looks like we didn't restore
L1SubCtl1.

Bjorn
