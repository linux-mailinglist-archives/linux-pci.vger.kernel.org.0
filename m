Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2A573C69
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 20:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiGMSQ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiGMSQ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 14:16:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65D186DB;
        Wed, 13 Jul 2022 11:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1326CB81DE4;
        Wed, 13 Jul 2022 18:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0B3C34114;
        Wed, 13 Jul 2022 18:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657736183;
        bh=2XzMMJPcdXGQ5Lndj24ZCZkAUIcCzngtFiV/c9u+2R4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lkyfo/hRcCu4s5Vee3n0J7W4pxj7b5wQw8izpXdopfy9+TYfHzIGQMNMb8f8DgeLs
         ZPh6oVka4B1CD92ES+G3BY+iNtAf9uNvnRsvlqLS7tLoNxtvnTVibpiv0mzc+OKQjL
         LOipYAnsF/8tYUGN81K+6ZTvfTSKnZA4VUoJolHjKOgG7KjGvJ+zPiNWt2S7T/odcI
         3oLQ7jlaBf7uytW0ENUZbYmGKFILkpMtZSViRsQaabyM9dPnfBLQ9H0utzU2DEAOnb
         +w7r7x0ZzZlpkORLogKQUKYl3YfkXt+5QCjGqIXKfgp1GHenDtvHh+1kEPVZxeEVHA
         GqO+WHrnWJAHg==
Date:   Wed, 13 Jul 2022 13:16:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, benchuanggli@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220713181621.GA840944@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73afa23f-73a0-81ed-c194-fbbd864a097f@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kai-Heng]

On Wed, Jul 13, 2022 at 11:29:42PM +0530, Vidya Sagar wrote:
> Hi,
> @Kenneth, Could you please verify it on your laptop one last time?
> 
> @Bjorn, Could you please review this change in the meanwhile?

Seems like this may be related to Kai-Heng's patch:
https://lore.kernel.org/r/20220509073639.2048236-1-kai.heng.feng@canonical.com
since he specifically mentioned L1SS.

I applied Kai-Heng's patch for v5.20 yesterday, but I haven't worked
out the connection to this patch.  But if you want Kenneth to test
this, it should probably be on top of Kai-Heng's patch so we're
testing something close to the eventual result.

> On 7/5/2022 11:30 AM, Vidya Sagar wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> > saved and restored during suspend/resume leading to L1 Substates
> > configuration being lost post-resume.
> > 
> > Save the L1 Substates control registers so that the configuration is
> > retained post-resume.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> > ---
> > Hi,
> > Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
> > on your laptop (Dell XPS 13) one last time?
> > IMHO, the regression observed on your laptop with an old version of the patch
> > could be due to a buggy old version BIOS in the laptop.
> > 
> > Thanks,
> > Vidya Sagar
> > 
> >   drivers/pci/pci.c       |  7 +++++++
> >   drivers/pci/pci.h       |  4 ++++
> >   drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 55 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfaf40a540a8..aca05880aaa3 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
> >                  return i;
> > 
> >          pci_save_ltr_state(dev);
> > +       pci_save_aspm_l1ss_state(dev);
> >          pci_save_dpc_state(dev);
> >          pci_save_aer_state(dev);
> >          pci_save_ptm_state(dev);
> > @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
> >           * LTR itself (in the PCIe capability).
> >           */
> >          pci_restore_ltr_state(dev);
> > +       pci_restore_aspm_l1ss_state(dev);
> > 
> >          pci_restore_pcie_state(dev);
> >          pci_restore_pasid_state(dev);
> > @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
> >          if (error)
> >                  pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> > 
> > +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> > +                                           2 * sizeof(u32));
> > +       if (error)
> > +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> > +
> >          pci_allocate_vc_save_buffers(dev);
> >   }
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index e10cdec6c56e..92d8c92662a4 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
> >   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >   #else
> >   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> >   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> >   static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> >   static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> > +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> >   #endif
> > 
> >   #ifdef CONFIG_PCIE_ECRC
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b7424c9bc..2c29fdd20059 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> >                                  PCI_L1SS_CTL1_L1SS_MASK, val);
> >   }
> > 
> > +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> > +{
> > +       int aspm_l1ss;
> > +       struct pci_cap_saved_state *save_state;
> > +       u32 *cap;
> > +
> > +       if (!pci_is_pcie(dev))
> > +               return;
> > +
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> > +
> > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!save_state)
> > +               return;
> > +
> > +       cap = (u32 *)&save_state->cap.data[0];
> > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> > +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> > +}
> > +
> > +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> > +{
> > +       int aspm_l1ss;
> > +       struct pci_cap_saved_state *save_state;
> > +       u32 *cap;
> > +
> > +       if (!pci_is_pcie(dev))
> > +               return;
> > +
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> > +
> > +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!save_state)
> > +               return;
> > +
> > +       cap = (u32 *)&save_state->cap.data[0];
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> > +}
> > +
> >   static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> >   {
> >          pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > --
> > 2.17.1
> > 
