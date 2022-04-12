Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822244FEB2C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 01:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiDLXXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 19:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiDLXWm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 19:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E71DC4;
        Tue, 12 Apr 2022 15:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A105161CB6;
        Tue, 12 Apr 2022 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC8C385A1;
        Tue, 12 Apr 2022 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649803849;
        bh=qT1HHgdYzFd0FlgtfwqtDoefeQb+fd5285v/Cp2+Hwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eSLTP/jAO4DSU/9JfWQCq76W+fOxlgqL0DR5qTTz/mu3MAUA9tJScKEUoxknoeETd
         hKb3gaNKbbuYQZhTI2SjYXA2w/4c5cwIlhODGOh5pVd02JrM5Uw5oxuiqam2snqhPX
         9XGlOVAE1bfwSdw8Hp4mUN0uJL3T+LwNWZZbijg2AxD6cN1hOLC3PlQU7noEBP0ght
         7lJ6XGhH/lCvNHsab8MtwWfIjrmdPAa6o96ZxdjuYSx+qzeBCe7jUXt+G2xJX695U7
         QGDX/ktEK8RD2Hmo5S20z2lLfmF4yu4xWX9FljZllCBEIgRMk82Tg4x+6Z0OUMzoig
         LwrKABckLltVA==
Date:   Tue, 12 Apr 2022 17:50:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220412225047.GA627910@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8cc8c0-31a1-0290-5aa5-0c7b16db1edb@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ricky for rtsx_pci ASPM behavior, Rajat, Prasad for L1 SS stuff,
Victor for interest in disabling ASPM during save/restore]

On Wed, Feb 16, 2022 at 06:41:39PM +0530, Vidya Sagar wrote:
> On 2/16/2022 11:30 AM, Kenneth R. Crudup wrote:
> > On Wed, 16 Feb 2022, Vidya Sagar wrote:
> > 
> > > I see that the ASPM-L1 state of Realtek NIC which was in
> > > disabled state before hibernate got enabled after hibernate.
> > 
> > That's actually my SD-Card reader; there's a good chance the BIOS
> > does "something" to it at boot time, as it's possible to boot from
> > SD-Card on my laptop.
> > 
> > > This patch doesn't do anything to LnkCtl register which has
> > > control for ASPM L1 state.
> > 
> > > Could you please check why ASPM L1 got enabled post hibernation?
> > 
> > I wouldn't know how to do that; if you're still interested in that
> > let me know what to do to determine that.

> I would like Bjorn to take a call on it.
> At this point, there are contradictions in observations.

Remind me what contradictions you see?  I know Kenny saw NVMe errors
on a kernel that included 4257f7e008ea ("PCI/ASPM: Save/restore L1SS
Capability for suspend/resume") in December 2020 [1], and that he did
*not* see those errors on 4257f7e008ea in February 2022 [2].  Is that
what you mean?

> Just to summarize,
> - The root ports in your laptop don't have support for L1SS
> - With the same old code base with which the errors were observed plus my
> patch on top of it, I see that ASPM-L1 state getting enabled for one of the
> endpoints (Realtek SD-Card reader) after system comes out of hibernation
> even though ASPM-L1 was disabled before the system enter into hibernation.
> No errors are reported now.

I assume you refer to [2], where on 4257f7e008ea ("PCI/ASPM:
Save/restore L1SS Capability for suspend/resume"), Kenny saw ASPM L1
disabled before hibernate and enabled afterwards:

  --- pre-hibernate
  +++ post-hibernate
    00:1d.7 PCI bridge [0604]: Intel [8086:34b7]
      Bus: primary=00, secondary=58, subordinate=58
	LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
    58:00.0 RTS525A PCI Express Card Reader [10ec:525a]
  -     LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
  -             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
  +     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk-
  +             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-

Per PCIe r6.0, sec 7.5.3.7, "ASPM L1 must be enabled by software in
the Upstream component on a Link prior to enabling ASPM L1 in the
Downstream component on that Link," so this definitely seems broken,
but wouldn't explain the NVMe issue.

The PCI core (pcie_config_aspm_link()) always enables L1 in the
upstream component before the downstream one, but 58:00.0 uses the
rtsx_pci driver, which does a lot of its own ASPM fiddling, so my
guess is that it's doing something wrong here.

> - With the linux-next top of the tree plus my patch, no change in the ASPM
> states and no errors also reported.

I don't know which report this refers to.

> This points to BIOS being buggy (both old and new with new one being less
> problematic)

I agree that a BIOS change between [1] and [2] seems plausible, but I
don't think we can prove that yet.  I'm slightly queasy because while
Kenny may have updated his BIOS, most people will not have.

I think we should try this patch again with some changes and maybe
some debug logging:

  - I wonder if we should integrate the LTR, L1 SS, and Link Control
    ASPM restore instead of having them spread around through
    pci_restore_ltr_state(), pci_restore_aspm_l1ss_state(), and
    pci_restore_pcie_state().  Maybe a new pci_restore_aspm() that
    would be called from pci_restore_pcie_state()?

  - For L1 PM Substates configuration, sec 5.5.4 says that both ports
    must be configured while ASPM L1 is disabled, but I don't think we
    currently guarantee this: we restore all the upstream component
    state first, and we don't know the ASPM state of the downstream
    one.  Maybe we need to:

      * When restoring upstream component,
          + disable its ASPM

      * When restoring downstream component,
          + disable its ASPM
	  + restore upstream component's LTR, L1SS
	  + restore downstream component's LTR, L1SS
	  + restore upstream component's ASPM
	  + restore downstream component's ASPM

      This seems pretty messy, but seems like what the spec requires.

    - Add some pci_dbg() logging of all these save/restore values to
      help debug any issues.

Bjorn

[1] https://lore.kernel.org/r/20201228040513.GA611645@bjorn-Precision-5520
[2] https://lore.kernel.org/r/3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com
