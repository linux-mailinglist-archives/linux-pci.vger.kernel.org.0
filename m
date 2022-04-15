Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4F503111
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 01:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354498AbiDOV3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 17:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355472AbiDOV25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 17:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E7DAFDE;
        Fri, 15 Apr 2022 14:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6AD620BE;
        Fri, 15 Apr 2022 21:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D654EC385A4;
        Fri, 15 Apr 2022 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650057935;
        bh=vwSHnKHKO3IOmpaR8ZgMY3Rm4mueE+R5d078hf6Pu6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UPgphip03sbzXT0W362vRLwvBo87HGwgbf+Qs4PKqK+EUiZbVUXITL8h1+XZbUSM4
         ucR+/iiXoUS1KdvQAmWHEE8IQPcG7NY+THUUKWzttQN1N8bYZfr0d6+WkSNdc/GY6D
         e/BFs090rGQF6n+AXTBmV7xqdt9/T5F2A0FmlJ9ImQcuDkjp17Z2r+658ZaM8D6EaV
         lQC45eOilvVFEYJ43XPRriG9Q5jxJW3RWex7H/cORwMAle213xWPxsIPlo/5oiYe3p
         pKL4ubLHIsk5l9DX/VAF169crMRvqrGHSHv8io/gtKCB9wthiCwRlO/X6ZcfV6iNUx
         qr+JP2DvJcXxQ==
Date:   Fri, 15 Apr 2022 16:25:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        chris.packham@alliedtelesis.co.nz, yangyicong@hisilicon.com,
        treding@nvidia.com, jonathanh@nvidia.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220415212533.GA844147@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6DX2C7KVRV=uu_mmPTTjE7=RsXfNPxjbOBLRbf-pXi5A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 15, 2022 at 10:26:19PM +0800, Kai-Heng Feng wrote:
> On Fri, Apr 15, 2022 at 12:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Apr 13, 2022 at 08:19:26AM +0800, Kai-Heng Feng wrote:
> > > On Wed, Apr 13, 2022 at 6:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > ...
> >
> > > >   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
> > > >     must be configured while ASPM L1 is disabled, but I don't think we
> > > >     currently guarantee this: we restore all the upstream component
> > > >     state first, and we don't know the ASPM state of the downstream
> > > >     one.  Maybe we need to:
> > > >
> > > >       * When restoring upstream component,
> > > >           + disable its ASPM
> > > >
> > > >       * When restoring downstream component,
> > > >           + disable its ASPM
> > > >           + restore upstream component's LTR, L1SS
> > > >           + restore downstream component's LTR, L1SS
> > > >           + restore upstream component's ASPM
> > > >           + restore downstream component's ASPM
> > >
> > > Right now L1SS isn't reprogrammed after S3, and that causes WD NVMe
> > > starts to spew lots of AER errors.
> >
> > Right now we don't fully restore L1SS-related state after S3, so maybe
> > there's some inconsistency that leads to the AER errors.

> > Could you collect the "lspci -vv" state before and after S3 so we can
> > compare them?
> >
> > > So yes please restore L1SS upon resume. Meanwhile I am asking vendor
> > > _why_ restoring L1SS is crucial for it to work.
> > >
> > > I also wonder what's the purpose of pcie_aspm_pm_state_change()? Can't
> > > we just restore ASPM bits like other configs?
> >
> > Good question.  What's the context?  This is in the
> > pci_raw_set_power_state() path, not the pci_restore_state() path, so
> > seems like a separate discussion.
> 
> Because this patch alone doesn't restore T_PwrOn and LTR1.2_Threshold.

I assume the post-S3 path is basically this:

  pci_pm_resume_noirq
    pci_pm_default_resume_early
      pci_power_up
        pci_raw_set_power_state(D0)
          pcie_aspm_pm_state_change
            pcie_config_aspm_path
              pcie_config_aspm_link
                pcie_config_aspm_l1ss
                  clear PCI_EXP_LNKCTL_ASPM_L1 etc
                  set PCI_L1SS_CTL1_ASPM_L1_1 etc
                pcie_config_aspm_dev
                  set PCI_EXP_LNKCTL_ASPM_L1 etc
      pci_restore_state
        pci_restore_ltr_state
        pci_restore_aspm_l1ss_state     # after this patch
        pci_restore_pcie_state

Hmm...  I think I see what you're saying.  pcie_aspm_pm_state_change()
fiddles with ASPM and L1SS enable bits.  It likely disables L1,
enables L1SS, enables L1, but never restores the LTR capability or the
T_PwrOn and LTR1.2_Threshold bits you mention.

Then we turn around and overwrite all that stuff (and the LTR cap) in
pci_restore_state().  That all seems fairly broken, and I agree, I
don't know why pcie_aspm_pm_state_change() exists.

> So I forced the pcie_aspm_pm_state_change() calling path to eventually
> call aspm_calc_l1ss_info() which solved the problem for me.

This would update T_PwrOn and LTR1.2_Threshold, so I guess it makes
sense that this would help.  But I think we need to figure out the
reason why pcie_aspm_pm_state_change() exists and get rid of it or at
least better integrate it with pci_restore_state().

If we call pcie_aspm_pm_state_change() after D3cold or reset, things
still aren't going to work because the LTR cap isn't restored or
programmed.
