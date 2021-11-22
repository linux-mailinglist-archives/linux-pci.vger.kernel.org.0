Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74D4596F3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhKVVyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 16:54:03 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:61056 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhKVVyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 16:54:00 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id fa3b4a34;
        Mon, 22 Nov 2021 22:50:48 +0100 (CET)
Date:   Mon, 22 Nov 2021 22:50:48 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     pali@kernel.org, luca@lucaceresoli.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kernel-team@android.com,
        alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, joey.gouly@arm.com
In-Reply-To: <87zgpw5jza.wl-maz@kernel.org> (message from Marc Zyngier on Mon,
        22 Nov 2021 14:43:37 +0000)
Subject: Re: [PATCH v2] PCI: apple: Follow the PCIe specifications when
 resetting the port
References: <20211122104156.518063-1-maz@kernel.org>
 <20211122120347.6qyiycqqjkgqvtta@pali> <87zgpw5jza.wl-maz@kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-ID: <d3caf39f58b0528b@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Mon, 22 Nov 2021 14:43:37 +0000
> From: Marc Zyngier <maz@kernel.org>
> 
> On Mon, 22 Nov 2021 12:03:47 +0000,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Monday 22 November 2021 10:41:56 Marc Zyngier wrote:
> > > While the Apple PCIe driver works correctly when directly booted
> > > from the firmware, it fails to initialise when the kernel is booted
> > > from a bootloader using PCIe such as u-boot.
> > > 
> > > That's beacuse we're missing a proper reset of the port (we only
> > > clear the reset, but never assert it).
> > > 
> > > The PCIe spec requirements are two-fold:
> > > 
> > > - #PERST must be asserted before setting up the clocks, and
> > >   stay asserted for at least 100us (Tperst-clk).
> > > 
> > > - Once #PERST is deasserted, the OS must wait for at least 100ms
> > >   "from the end of a Conventional Reset" before we can start talking
> > >   to the devices
> > > 
> > > Implementing this results in a booting system.
> > > 
> > > Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Pali Rohár <pali@kernel.org>
> > 
> > Looks good, but see comment below.
> > 
> > Acked-by: Pali Rohár <pali@kernel.org>
> 
> Thanks for that.
> 
> > 
> > > ---
> > >  drivers/pci/controller/pcie-apple.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > > index 1bf4d75b61be..957960a733c4 100644
> > > --- a/drivers/pci/controller/pcie-apple.c
> > > +++ b/drivers/pci/controller/pcie-apple.c
> > > @@ -539,13 +539,23 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
> > >  
> > >  	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
> > >  
> > > +	/* Engage #PERST before setting up the clock */
> > > +	gpiod_set_value(reset, 0);
> > > +
> > >  	ret = apple_pcie_setup_refclk(pcie, port);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > +	/* The minimal Tperst-clk value is 100us (PCIe CMS r2.0, 2.6.2) */
> > > +	usleep_range(100, 200);
> > > +
> > > +	/* Deassert #PERST */
> > >  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> > >  	gpiod_set_value(reset, 1);
> > 
> > + Luca
> > 
> > Just one comment. PERST# (PCIe Reset) is active-low signal. De-asserting
> > means to really set value to 1.
> > 
> > But there was a discussion that de-asserting should be done by call:
> >   gpiod_set_value(reset, 0);
> > 
> > https://lore.kernel.org/linux-pci/51be082a-ff10-8a19-5648-f279aabcac51@lucaceresoli.net/
> > 
> > Could we make this new pcie-apple.c driver to use gpiod_set_value(reset, 0)
> > for de-asserting, like in other drivers?
> 
> I guess it depends whether you care about the assertion or the signal
> itself. I think we may have a bug in the way the GPIOs are handled at
> the moment, as it makes no difference whether I register the GPIO are
> active high or active low...

That's unfortunate.  But maybe that's an opportunity to fix the
devicetree to use GPIO_ACTIVE_LOW for these GPIOs?
