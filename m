Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BD5F4DBE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJECft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 22:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJECfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 22:35:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793315FEB;
        Tue,  4 Oct 2022 19:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31EC0B81BEF;
        Wed,  5 Oct 2022 02:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1832C433C1;
        Wed,  5 Oct 2022 02:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664937343;
        bh=nWD4G4yTpfbFxxUWy4D29Qa7I+4ZXc2ps+gnDX/wDbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dA6KCfAypwa4v41fQfvgOc+eVNWZBZIZT3sj9wnfSi0LQKLjNWVXIoiMkyCbSj+Ia
         fSQL44jWULNOjFa8T0XEMEvuOypMCRkyYd9cLuCmY6Pkw6b4guDUN71ninvdeTZSdC
         MPQsof1zOTa/cWa8acQxsbeyl3gIoe1IZTfYqZAyvJPy2z9F0y22strZrrIGAKsTu1
         1Z9WH7yma4dKTt+5DQMKLSW2NGTJ+DnPuK4FV0M2nD/5lFqWbWZxUjZ9sLXMX2b6T3
         k5g0lVxzOO6JDELQ+lJcnna0TZ8bgKGl6/603CgYeIxFBIBWWw15yaYBS+JZgpWIc9
         zUOaF0fNlh6vw==
Date:   Tue, 4 Oct 2022 21:35:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, kai.heng.feng@canonical.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH V4 1/2] PCI/ASPM: Refactor ASPM L1SS control register
 programming
Message-ID: <20221005023542.GA2190062@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36fa13c5-e0f8-022f-77f7-7908e4df98b8@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 03, 2022 at 12:12:22PM +0530, Vidya Sagar wrote:
> On 9/30/2022 3:30 AM, Bjorn Helgaas wrote:
> > On Tue, Sep 13, 2022 at 06:48:21PM +0530, Vidya Sagar wrote:
> > > Refactor the code to extract the command code out to program
> > > Control Registers-1 & 2 of L1 Sub-States capability to a new function
> > > aspm_program_l1ss() and call it for both parent and child devices.
> > > 
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > V4:
> > > * New patch in this series
> > > 
> > >   drivers/pci/pcie/aspm.c | 63 +++++++++++++++++++----------------------
> > >   1 file changed, 29 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index a8aec190986c..ecbe3af4188d 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -455,6 +455,31 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
> > >        pci_write_config_dword(pdev, pos, val);
> > >   }
> > > 
> > > +static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
> > > +{
> > > +     u16 l1ss = dev->l1ss;
> > > +     u32 l1_2_enable;
> > > +
> > > +     /*
> > > +      * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
> > > +      * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
> > > +      */
> > > +     pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
> > > +
> > > +     /*
> > > +      * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
> > > +      * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
> > > +      * enable bits, even though they're all in PCI_L1SS_CTL1.
> > > +      */
> > > +     l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> > > +     ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
> > > +
> > > +     pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
> > > +     if (l1_2_enable)
> > > +             pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
> > > +                                    ctl1 | l1_2_enable);
> > > +}
> > > +
> > >   /* Calculate L1.2 PM substate timing parameters */
> > >   static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> > >                                u32 parent_l1ss_cap, u32 child_l1ss_cap)
> > > @@ -464,7 +489,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> > >        u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
> > >        u32 ctl1 = 0, ctl2 = 0;
> > >        u32 pctl1, pctl2, cctl1, cctl2;
> > > -     u32 pl1_2_enables, cl1_2_enables;
> > > 
> > >        if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> > >                return;
> > > @@ -513,39 +537,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> > >            ctl2 == pctl2 && ctl2 == cctl2)
> > >                return;
> > > 
> > > -     /* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
> > > -     pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> > > -     cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> > > -
> > > -     if (pl1_2_enables || cl1_2_enables) {
> > > -             pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
> > > -                                     PCI_L1SS_CTL1_L1_2_MASK, 0);
> > > -             pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> > > -                                     PCI_L1SS_CTL1_L1_2_MASK, 0);
> > > -     }
> > > -
> > > -     /* Program T_POWER_ON times in both ports */
> > > -     pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
> > > -     pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
> > > -
> > > -     /* Program Common_Mode_Restore_Time in upstream device */
> > > -     pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> > > -                             PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
> > > -
> > > -     /* Program LTR_L1.2_THRESHOLD time in both ports */
> > > -     pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> > > -                             PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> > > -                             PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
> > > -     pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
> > > -                             PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> > > -                             PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
> > > -
> > > -     if (pl1_2_enables || cl1_2_enables) {
> > > -             pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
> > > -                                     pl1_2_enables);
> > > -             pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
> > > -                                     cl1_2_enables);
> > > -     }
> > > +     aspm_program_l1ss(parent,
> > > +                       ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> > > +     aspm_program_l1ss(child,
> > > +                       ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> > 
> > This doesn't seem right to me.  I think the intent is to update
> > LTR_L1.2_THRESHOLD and Common_Mode_Restore_Time, which are encoded in
> > "ctl1".  It does do that, but it looks like it *also* clears
> > everything except PCI_L1SS_CTL1_L1_2_MASK, i.e., the L1.1 Enable bits,
> > the Link Activation bits, and the RsvdP bits, which I don't think we
> > should be clearing.  Am I missing something?
> 
> Agree. Instead of updating some of the register fields with new values while
> keeping other fields intact, this code programs the register fields with
> only new values and also programming all other fields to zero which is
> wrong.
> Thanks for catching this. I missed it as the card with which I had tested
> didn't have L1.1 support.

> I think the following modification should fix this issue.
> 
> 
> @@ -537,10 +537,23 @@ static void aspm_calc_l1ss_info(struct pcie_link_state
> *link,
>             ctl2 == pctl2 && ctl2 == cctl2)
>                 return;
> 
> -       aspm_program_l1ss(parent,
> -                         ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> -       aspm_program_l1ss(child,
> -                         ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> +       pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
> +       pctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE)
> +                );
> +       aspm_program_l1ss(parent, pctl1, ctl2);
> +
> +       cctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
> +       cctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE)
> +                );
> +       aspm_program_l1ss(child, cctl1, ctl2);
>  }
> 
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> 
> But, given that you mentioned we shouldn't be touching Rsvd also, I'm
> wondering if the following can cause any issue?
> With the top of the tree code, the CMRT in ctrl1 register is updated only
> for the upstream device whereas with my change, it gets updated even for the
> downstream device. Although spec says that it is Rsvd for a downstream
> device (i.e. upstream port), I'm wondering if we should really avoid
> touching it?

I'm not sure it's worth bothering about at this point.  It feels a
little OCD right now.

> If the answer is yes, I think it is better to drop the modifications done to
> aspm_calc_l1ss_info() function and just proceed with rest of the
> modifications given the way it is differentiating between upstream and
> downstream devices while updating the registers.
> What are your comments on this?

I thought we had some indication that Common_Mode_Restore_Time and
LTR_L1.2_THRESHOLD should be programmed *before* setting the L1.2
enable bits, even though they're all in PCI_L1SS_CTL1.

The first place that comment appears is
https://lore.kernel.org/linux-pci/20220907210540.GA140988@bhelgaas/,
but I can't remember if it actually solved a problem or if it was just
more OCD reading of the spec, which says "This field must only be
modified when the ASPM L1.2 Enable bit is Clear".

I'm inclined to keep the aspm_program_l1ss() changes unless we think
they're risky, because I think it is a small step forward, at least in
terms of reducing the number of config accesses.

On pci/aspm, I currently have your v4 patches plus these tweaks:

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index dc2e21c7a9d4..016d222b07c7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -537,10 +537,21 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	    ctl2 == pctl2 && ctl2 == cctl2)
 		return;
 
-	aspm_program_l1ss(parent,
-			  ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
-	aspm_program_l1ss(child,
-			  ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
+	pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
+		   PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+		   PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
+	pctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
+			  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+			  PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
+	aspm_program_l1ss(parent, pctl1, ctl2);
+
+	cctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
+		   PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+		   PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
+	cctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
+			  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+			  PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
+	aspm_program_l1ss(child, cctl1, ctl2);
 }
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
@@ -727,9 +738,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
 	u16 l1ss = dev->l1ss;
 	u32 *cap;
 
-	if (!pci_is_pcie(dev))
-		return;
-
 	if (!l1ss)
 		return;
 
@@ -748,9 +756,6 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
 	u32 *cap, ctl1, ctl2;
 	u16 l1ss = dev->l1ss;
 
-	if (!pci_is_pcie(dev))
-		return;
-
 	if (!l1ss)
 		return;
 
