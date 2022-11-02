Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E84615DE5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKBIhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiKBIhH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 04:37:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B06257;
        Wed,  2 Nov 2022 01:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 136DB617F1;
        Wed,  2 Nov 2022 08:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18916C433C1;
        Wed,  2 Nov 2022 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667378225;
        bh=ucBWuPnSXLTY3BfZSjQWNwGsvFRMBhdW6KRHpQkASp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKWf5HsVMfB/Eg56Lb8+6tT+CvAN/E3jb7t7THEEPxfGUL6tW/qTUe/TycwQygIEU
         a9BCN+VKiVGV+9S360ANmZYvRLvFRdbxrkNZgIkV3BJVHi0kVFzz1jLXAS/+/Eo3K4
         145oJwAQ9H3u1qhYSa+zVL/tyQYBwXi+VGmSAxosmsdOxBdW8Cp3utQrvPjKN/nzaf
         LioOXth40f3ysgPztmyg7vkuUWT6FQctmzsw7IaR2VwKymwsrS969fQklPy75gEPQS
         hye18VmPL2V+4S1uBZIeJmhN2Opm62qUKJgRZ2D2l3INd4lShba2ovEnSyojznlIHg
         QreTJ+HELv5gA==
Received: by pali.im (Postfix)
        id 03C467FE; Wed,  2 Nov 2022 09:37:01 +0100 (CET)
Date:   Wed, 2 Nov 2022 09:37:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Wait for data link active after retraining
Message-ID: <20221102083701.657batt4mstc4pjd@pali>
References: <20220602065544.2552771-1-nathan@nathanrossi.com>
 <20221002175648.jzxcvka46vylbs2d@pali>
 <CA+aJhH2kbAFYOSkDpxO4_1ZPfJmd11v6tmz2yAL-PO2irQWZ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+aJhH2kbAFYOSkDpxO4_1ZPfJmd11v6tmz2yAL-PO2irQWZ0w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 November 2022 18:31:04 Nathan Rossi wrote:
> On Mon, 3 Oct 2022 at 03:56, Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello!
> >
> > On Thursday 02 June 2022 06:55:44 Nathan Rossi wrote:
> > > From: Nathan Rossi <nathan.rossi@digi.com>
> > >
> > > When retraining the link either the child or the parent device may have
> > > the data link layer state machine of the respective devices move out of
> > > the active state despite the physical link training being completed.
> > > Depending on how long is takes for the devices to return to the active
> > > state, the device may not be ready and any further reads/writes to the
> > > device can fail.
> > >
> > > This issue is present with the pci-mvebu controller paired with a device
> > > supporting ASPM but without advertising the Slot Clock, where during
> > > boot the pcie_aspm_cap_init call would cause common clocks to be made
> > > consistent and then retrain the link. However the data link layer would
> > > not be active before any device initialization (e.g. ASPM capability
> > > queries, BAR configuration) causing improper configuration of the device
> > > without error.
> >
> > There is the known issue in marvell pcie controllers. They completely
> > drop the link for PCIe GEN1 cards when Target Link Speed (Link Control2)
> > in Root Port is configured to 5.0 GT/s or higher value and OS issues
> > Retrain Link (Link Control).
> 
> In the configuration we are having issues with, the downstream device
> is indeed a 2.5GT downstream, and the upstream is configured to
> support 2.5GT and 5GT (Armada 385). So it does make sense that this
> known issue would apply. I tested setting the target speed to 2.5GT
> within mvebu_pcie_setup_hw before the retraining occurs, and it does
> resolve the retraining delay/link drop. So this issue is indeed the
> problem we are having.

I observed exactly same behavior as you described, on Armada 385 and
similar also on Armada 3720.

> Is this behaviour mentioned in any errata?

I have not documented this behavior in any document.

> >
> > I think the proper way should be to workaround root of this issue by
> > programming Target Link Speed in Link Control2 register to required
> > value, instead of hacking couple of other places which are just
> > implication of that issue...
> 
> By programming the Target Link Speed, are you referring to programming
> the value like other controller drivers do with dtb configuration?

No, I mean programming Link Control 2 register in PCIe capabilities
section of PCIe Root Port device (the one which is implemented throw
emulated bridge kernel code).

It should be programmed dynamically after detecting type of upstream
device to the PCIe Root Port (other end of the serdes link).

> Relying on this would be problematic for our design (mixed downstream
> link speed variants).

Yes, due to this reason it should be rather implemented dynamically in
kernel code instead of "hacking" DTS files as it does not really fix it.

> Does it make more sense to set the Target Link
> Speed when the retrain bit is being set in Link Control (e.g. in the
> mvebu_pci_bridge_emul_pcie_conf_write function) essentially preventing
> the retraining from causing the link to drop only when the issue is
> expected to present itself (Link Status at 2.5GT)?
> 
> Thanks,
> Nathan
> 
> >
> > I can reproduce it for example with Qualcomm Atheros ath9k/ath10k wifi
> > cards which have another issue that they go into "broken" state when
> > in-band reset (e.g. pcie hot reset or pcie link down) is issues multiple
> > times without longer delay.
> >
> > These two bugs (first in marvell pcie controller and second in wifi
> > card) cause that setting kernel ASPM cause disappearing card from bus
> > until cpu/board reset (or pcie warm reset; if board supports it at
> > runtime without going to POR).
> >
> > I guess you are just observing result of this issue here.
> >
> > > To ensure the child device is accessible, after the link retraining use
> > > pcie_wait_for_link to perform the associated state checks and any needed
> > > delays.
> > >
> > > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> > > ---
> > >  drivers/pci/pcie/aspm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index a96b7424c9..4b8a1810be 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
> > >               reg16 &= ~PCI_EXP_LNKCTL_CCC;
> > >       pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> > >
> > > -     if (pcie_retrain_link(link))
> > > +     /* Retrain link and then wait for the link to become active */
> > > +     if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))
> > >               return;
> > >
> > >       /* Training failed. Restore common clock configurations */
> > > ---
> > > 2.36.1
