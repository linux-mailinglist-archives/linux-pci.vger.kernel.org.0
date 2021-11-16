Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E651453B11
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 21:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhKPUnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 15:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhKPUnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 15:43:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F67761B30;
        Tue, 16 Nov 2021 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637095204;
        bh=SqgvuUNAsCwRWZsRjJoxgM4Yn5y7VGBMt/yUh10/rfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SfFx9GSLSUML4INXVyC7DPCQxaMYlGsCUp9HvQIQgFgSWvzpILZVVV8jBeT5SdTnA
         SjCrCbAArtgB68wX0ASQkYvRprf/fosaHLfFQgVrI6XzuhigwaSXeJJhs40HFtZxOK
         f3fdzeHv5WszP5I9+EHsI4PRebT0P2nzr1DEG2MZuM6mCrilIMMW22+H3ocsFSXlhu
         EWUHGYuBtWnZvC7mB0pFq51L0wDO8IG4CBpSpG619rjjXmYwTiMmMqcOOr3WW51AAd
         56L4Yc//N85VcN0oKSdpXJ+0IZ9rjRBNgNF3TNteY1d3jOXBscXn5bDldvHE/ilpIx
         4Q31o9MsggdEw==
Date:   Tue, 16 Nov 2021 14:40:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/8] PCI: brcmstb: Change brcm_phy_stop() to return
 void
Message-ID: <20211116204003.GA1678373@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNy86LG761MYvr-mB0de1TZ_EbJxzw0vFYfgXaa+96k=GA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 03:56:14PM -0500, Jim Quinlan wrote:
> On Thu, Nov 11, 2021 at 4:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Nov 10, 2021 at 05:14:41PM -0500, Jim Quinlan wrote:
> > > We do not use the result of this function so make it void.
> >
> > I don't get it.  Can you expand on this?
> >
> > brcm_phy_cntl() can return -EIO, which means brcm_phy_stop() can
> > return -EIO, which means brcm_pcie_suspend can return -EIO.
> > brcm_pcie_suspend() is the dev_pm_ops.suspend() method.
> >
> > So are you saying we never use the result of dev_pm_ops.suspend()?
> 
> In this situation we are going into suspend.  In doing so, any
> problems with the brcm phy may be erased/forgiven upon resume, since
> clocks are turned off and most power removed/reduced.  An error from
> brcm_phy_stop() that becomes the return value of  brcm_pcie_suspend()
> will bring a halt to the entire suspend IIRC.   In fact, I forced a
> -EIO in this code and it panic'd on suspend.  This is not really the
> behavior I want for what is most likely a recoverable error.
> 
> Perhaps a dev_err(...) will suffice while still returning 0?

Maybe we just need a note about why we want to intentionally ignore
any errors here.

> I noticed that reset_control_rearm() also returns a value, and if that
> is in error it will not be erease/forgiven  by suspend sleep.  I will
> fix this.
> 
> Regards,
> Jim Quinlan
> Broadcom STB
> 
> 
> >
> > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index cc30215f5a43..ff7d0d291531 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -1111,9 +1111,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
> > >       return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> > >  }
> > >
> > > -static inline int brcm_phy_stop(struct brcm_pcie *pcie)
> > > +static inline void brcm_phy_stop(struct brcm_pcie *pcie)
> > >  {
> > > -     return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> > > +     if (pcie->rescal)
> > > +             brcm_phy_cntl(pcie, 0);
> > >  }
> > >
> > >  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> > > @@ -1143,14 +1144,13 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> > >  static int brcm_pcie_suspend(struct device *dev)
> > >  {
> > >       struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > > -     int ret;
> > >
> > >       brcm_pcie_turn_off(pcie);
> > > -     ret = brcm_phy_stop(pcie);
> > > +     brcm_phy_stop(pcie);
> > >       reset_control_rearm(pcie->rescal);
> > >       clk_disable_unprepare(pcie->clk);
> > >
> > > -     return ret;
> > > +     return 0;
> > >  }
> > >
> > >  static int brcm_pcie_resume(struct device *dev)
> > > --
> > > 2.17.1
> > >
