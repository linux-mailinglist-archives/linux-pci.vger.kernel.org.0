Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6136E092
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhD1UyU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 16:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhD1UyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 16:54:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDF506140C;
        Wed, 28 Apr 2021 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619643201;
        bh=99aQgYpV6yLmeDba8HvEXO8wySN1Y1aGrrXQa8Wgmo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xtx+Tiuq+haypYskR8nkuJ8Ed/d9pf2Y1vPEY3G8ri86MjENkLr5+qDqPjxwReQ6t
         rO1SyNNyzeLQ4dUw6Ulje/pcBdcalOSjxHSxyXoHbaKjyPss4kDfWTZZPmQj4Ifod/
         kwJCfnWfN7+A4HJ3jKjOh7d8N1s5IwIk4NmzUAG2OBA6tKUlKhuJIX5MWUA6xWO/jy
         Is6llTCoAJzJedVqYiNIlrGWEmAyGlYlftd/Zq14MsIGl7RirwTOZ/wx+t0inw6fxT
         G/g31r4Cxtr4acCme3yN9TMs5O4hHT3tZfHqcU12hKQ861xqI9O4KiCFbdBrMfCxZT
         OU5G9qBcTKglA==
Date:   Wed, 28 Apr 2021 15:53:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v5 0/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
Message-ID: <20210428205319.GA429792@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyN4UB3Sb14RJ9Jb2rXn_u-iwHzny1LYXEq3=VddWWxPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Amjad, Philipp: possible issue with 557acb3d2cd9 ("reset: make
shared pulsed reset controls re-triggerable") below; report at
https://lore.kernel.org/linux-ide/20210428200058.GA366202@bjorn-Precision-5520/]

On Wed, Apr 28, 2021 at 04:34:00PM -0400, Jim Quinlan wrote:
> On Wed, Apr 28, 2021 at 4:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Mar 12, 2021 at 03:45:53PM -0500, Jim Quinlan wrote:
> > > v5 -- Improved (I hope) commit description (Bjorn).
> > >    -- Rnamed error labels (Krzyszt).
> > >    -- Fixed typos.
> > >
> > > v4 -- does not rely on a pending commit, unlike v3.
> > >
> > > v3 -- discard commit from v2; instead rely on the new function
> > >       reset_control_rearm provided in a recent commit [1] applied
> > >       to reset/next.
> > >    -- New commit to correct pcie-brcmstb.c usage of a reset controller
> > >       to use reset/rearm verses deassert/assert.
> > >
> > > v2 -- refactor rescal-reset driver to implement assert/deassert rather than
> > >       reset because the reset call only fires once per lifetime and we need
> > >       to reset after every resume from S2 or S3.
> > >    -- Split the use of "ahci" and "rescal" controllers in separate fields
> > >       to keep things simple.
> > >
> > > v1 -- original
> > >
> > > Jim Quinlan (2):
> > >   ata: ahci_brcm: Fix use of BCM7216 reset controller
> > >   PCI: brcmstb: Use reset/rearm instead of deassert/assert
> > >
> > >  drivers/ata/ahci_brcm.c               | 46 +++++++++++++--------------
> > >  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++----
> > >  2 files changed, 36 insertions(+), 29 deletions(-)
> >
> > Tripped over these errors while build testing with the .config below.
> > This is on the pci/brcmstb branch from
> > git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> >
> > Dropping the pci/brcmstb branch while we get this figured out.  This will
> > remove the following commits:
> >
> >   a24fd1d6469f ("PCI: brcmstb: Use reset/rearm instead of deassert/assert")
> >   92b9cb55a9b6 ("ata: ahci_brcm: Fix use of BCM7216 reset controller")
> >   b5d9209d5083 ("PCI: brcmstb: Fix error return code in brcm_pcie_probe()")
> 
> Hi Bjorn,
> 
> I believe the problem is that the commit
> 
> 557acb3d2cd9c82de19f944f6cc967a347735385
> "reset: make shared pulsed reset controls re-triggerable"
> 
> defined reset_control_rearm() for the CONFIG_RESET_CONTROLLER=y  case
> but forgot to define  an empty function for the unset case.  Your test
> .config has this CONFIG unset.
> 
> Would you like me to resubmit this with an additional commit that
> fixes this?

The fix could be a patch along those lines, or it could be a Kconfig
change that makes this config impossible.  I didn't look deeper to see
what makes sense.  But I don't think the fix should be "manually avoid
this configuration."

It looks like 557acb3d2cd9 ("reset: make shared pulsed reset controls
re-triggerable") appeared in v5.11, so if a patch is the right thing,
it should probably be marked for stable ("v5.11+").

Bjorn
