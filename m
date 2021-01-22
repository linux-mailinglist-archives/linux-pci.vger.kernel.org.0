Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00AC2FF95A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 01:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAVAVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 19:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbhAVAVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 19:21:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE52A23A53;
        Fri, 22 Jan 2021 00:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611274851;
        bh=WPng+ElD3o5SfxZA7J66qTO2rUx0+cjpLBoZzBFKzC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DjRYlDfbj0DdEIJiWdH9iRyOH2UJLthVooVrgUBbU892GvsUbtaV+L0jy+jJX+YDa
         1gpZXwZXh2ChIK+IrWo5ZncfxOa52O3/hxysGqliciSwCJyTAJe/sxJguGEJJQDjNc
         SoUZU4GvVl3scHIBPtyWdHzoqaoX7Hhx3bD2VNzbHSkiErLZ8rN7r2hXjX1Rz/YCP3
         x3a37iI1y97UJR3gEvfhgR2aP+y5m56/8SejTfMBDEVSSmYdzZjwdWyikTqbPwmss7
         qRpK5CmIryRYGl4JriuPG6UTTi5C7mQXp2cr5+RQ8bCFKglUtnR4lNH7AHngqeqto6
         OjQfGVj989YJw==
Date:   Thu, 21 Jan 2021 18:20:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v3 0/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
Message-ID: <20210122002049.GA2708505@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b1cec20-679f-783c-159f-fa6aa9b1d568@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 12:48:07PM -0800, Florian Fainelli wrote:
> On 1/14/2021 12:46 PM, Florian Fainelli wrote:
> > On 1/5/21 1:22 PM, Florian Fainelli wrote:
> >> On 12/23/20 4:05 PM, Florian Fainelli wrote:
> >>>
> >>>
> >>> On 12/16/2020 1:41 PM, Jim Quinlan wrote:
> >>>> v3 -- discard commit from v2; instead rely on the new function
> >>>>       reset_control_rearm provided in a recent commit [1] applied
> >>>>       to reset/next.
> >>>>    -- New commit to correct pcie-brcmstb.c usage of a reset controller
> >>>>       to use reset/rearm verses deassert/assert.
> >>>>
> >>>> v2 -- refactor rescal-reset driver to implement assert/deassert rather than
> >>>>       reset because the reset call only fires once per lifetime and we need
> >>>>       to reset after every resume from S2 or S3.
> >>>>    -- Split the use of "ahci" and "rescal" controllers in separate fields
> >>>>       to keep things simple.
> >>>>
> >>>> v1 -- original
> >>>>
> >>>>
> >>>> [1] Applied commit "reset: make shared pulsed reset controls re-triggerable"
> >>>>     found at git://git.pengutronix.de/git/pza/linux.git
> >>>>     branch reset/shared-retrigger
> >>>
> >>> The changes in that branch above have now landed in Linus' tree with:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=557acb3d2cd9c82de19f944f6cc967a347735385
> >>>
> >>> It would be good if we could get both patches applied via the same tree
> >>> or within the same cycle to avoid having either PCIe or SATA broken on
> >>> these platforms.
> >>
> >> Ping? Can someone apply those patches if you are happy with them? Thank you.
> > 
> > Ping? Can we review and ideally also apply these patches? Thanks
> 
> Is there something going on preventing these patches from being reviewed
> and/or applied?

It mentions a dependency, which makes it harder to apply.  I see that
dependency seems to have been applied, so maybe post an updated
version of the series, including both patches.

The series touches both ATA and PCI, so not immediately obvious where
it should go.  It looks like the ATA part is bigger, but only 2/2 went
to linux-pci, so it's harder to figure this out than it should be.  I
poked around a bit on lore, but I can't find 1/2 at all:

  https://lore.kernel.org/linux-arm-kernel/20201216214106.32851-1-james.quinlan@broadcom.com/

Maybe also include Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
directly in "To:".  I know I look at stuff addressed directly to me
first; the "CC:" flood gets overwhelming fast.  I assume Lorenzo will
look for at least an ack from Nicolas before doing anything.

If you repost, it's nice if you match existing style, e.g.,

  - PCI: brcmstb: use reset/rearm instead of deassert/assert
  + PCI: brcmstb: Use reset/rearm instead of deassert/assert

Bjorn
