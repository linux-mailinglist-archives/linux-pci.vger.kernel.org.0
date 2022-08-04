Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421E589FDC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiHDR2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiHDR2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 13:28:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491FD6301;
        Thu,  4 Aug 2022 10:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8673DB82614;
        Thu,  4 Aug 2022 17:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118A4C433D6;
        Thu,  4 Aug 2022 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659634078;
        bh=dmSrkl/IWyIBVuUL9KetxyU+zq8M3qYRMqtV+KA7yh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S8roUZAIbKjf8HZdyuWka8Q18Md0NJxc9hBf/nnvAtP7nK0VLdaIMmPPf47hurRqE
         /aepD4y2ZkGYe9PFB6o/y5+olcyDOnTyJUmRrujHRrdLkS4UMSq8q+vR/OKZbSKCrx
         zqpnT2jFplije8gd4zRpYULc9nRpw8b6qaZCuG6UGe9vypfer2F4LTJWDWRyVhCKFl
         atLy71cdUoItchEZBhgV8johMg0HCwM7migQv8kgVg/K/XwV6k5Nvx8PIXHc2K9uWA
         ZyQ47wixHJCNZeLiZ9+i4sa9ZCdYS+b6Uma04mf96CZjnZxv7PVvxd55Z77hBhiEXL
         Rhgw1lHx/RaLQ==
Date:   Thu, 4 Aug 2022 12:27:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Cyril Brulebois <kibi@debian.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/7] PCI: brcmstb: Re-submit reverted patchset
Message-ID: <20220804172756.GA944222@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBspR9kc5WE72q8LYJrr0bAOp+xwqzPxEX0Kp4i0RynwFg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 04, 2022 at 01:05:04PM -0400, Jim Quinlan wrote:
> On Mon, Aug 1, 2022 at 6:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jul 26, 2022 at 04:41:09PM -0700, Florian Fainelli wrote:
> > > On 7/26/22 15:03, Bjorn Helgaas wrote:
> > > > On Mon, Jul 25, 2022 at 11:12:49AM -0400, Jim Quinlan wrote:
> > > >> ...
> > > >> Jim Quinlan (7):
> > > >>   PCI: brcmstb: Remove unnecessary forward declarations
> > > >>   PCI: brcmstb: Split brcm_pcie_setup() into two funcs
> > > >>   PCI: brcmstb: Gate config space access on link status
> > > >>   PCI: brcmstb: Add mechanism to turn on subdev regulators
> > > >>   PCI: brcmstb: Add control of subdevice voltage regulators
> > > >>   PCI: brcmstb: Do not turn off WOL regulators on suspend
> > > >>   PCI: brcmstb: Have .map_bus function names end with 'map_bus'
> > > >>
> > > >>  drivers/pci/controller/pcie-brcmstb.c | 476 ++++++++++++++++++--------
> > > >>  1 file changed, 341 insertions(+), 135 deletions(-)
> > > >
> > > > I reworked these and put them on pci/ctrl/brcm for v5.20.  This is a
> > > > proposal, not something set in stone.  But time is of the essence to
> > > > figure out how we want to proceed.
> > > >
> > > > I changed a lot of stuff and it's likely I broke something in the
> > > > process, so please take a look and test this out.  Here's an outline
> > > > of what I changed:
> > > >
> > > >   - Moved the config access "link up" check earlier because it's not
> > > >     related to the power regulator patches.
> > > >
> > > >   - Changed config access "link up" checks to use PCIE_ECAM_REG()
> > > >     instead of hard-coding 0xfff masks.  The 32-bit accessors already
> > > >     mask out the low two bits, so we don't need to do that here.
> > > >
> > > >   - Squashed pci_subdev_regulators_add_bus() directly into
> > > >     brcm_pcie_add_bus() for readability.  Similarly for
> > > >     pci_subdev_regulators_remove_bus().
> > > >
> > > >   - This makes a clear split between:
> > > >
> > > >     * A patch that adds get/enable of regulators, and starting the
> > > >       link after enabling regulators, and
> > > >
> > > >     * A patch that disables/enables regulators for suspend/resume.
> > > >
> > > >   - Since we only support one set of subregulator info (for one Root
> > > >     Port, and brcm_pcie_suspend_noirq() depends on this since it uses
> > > >     the pcie->sr pointer), use pcie->sr always instead of
> > > >     dev->driver_data.
> > > >
> > > >   - Squashed wakeup device checking into the suspend/resume patch so
> > > >     there's not a time when suspend might turn off power to a wakeup
> > > >     device.
> > > >
> > > >   - Renamed brcm_pcie_map_bus32() to brcm7425_pcie_map_bus() so it
> > > >     ends in "_map_bus()" like other drivers.  Also,
> > > >     brcm7425_pcie_map_bus() doesn't actually depend on the 32-bitness.
> > >
> > > Attached is the diff between Jim's and your branch just so it is easier to see what moved around.
> > >
> > > Initial testing on an ARCH_BRCMSTB system with PCIe appears to be good, we don't have any regulator on that board so the dummy ones get picked up which is expected. Same thing with a Raspberry Pi 4B system.
> > >
> > > I could unbind and bind again and there were no reference count leaks on the regulators, so this looks good to me.
> > >
> > > Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> > >
> > > of course, we should have Jim's test results as well as Cyril's ideally to make sure there are no regressions on the CM4 board.
> >
> > Cyril, any chance you could test this to be sure it fixes the problem
> > you reported?  This is in -next and hopefully headed for v5.20/v6.0
> > soon.
> 
> Cyril sent me an email about a week ago saying that he probably
> wouldn't have the bandwidth to test this.
> I immediately ordered an overpriced CM4 via Ebay and it recently
> arrived.  I'm happy to say that this
> patchset tests successfully, w/ or w/o a device in the slot.

Great, thanks a lot for testing this!

> That being said, there is an old device, when paired with the CM4,
> works with RPi Linux but not with upstream Linux.  It is unrelated
> to this patchset; i.e. it fails w/ or w/o this patchset applied.  I
> know the reason for this failure: the current driver
> assumes clkreq# asserted, which is true for all STB boards.  I can add
> a patch for this now or in the next release
> cycle, your choice.

It's too late for v5.20-rc1, but if this would fix a regression or
otherwise exceptional bug, Lorenzo might still consider it for the
v5.20.

Bjorn
