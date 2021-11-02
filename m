Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D11442B40
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 11:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhKBKDM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 06:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhKBKDL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 06:03:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB50660E73;
        Tue,  2 Nov 2021 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635847237;
        bh=hFHvZyAdEautfrDtjYs1cZTPpjyQldm+fG5o+hHF77c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gf61I0Z1mYypZ5vVL8oeq+Dho3VR+hAu8mdZe8edv/lGbiLyoHIA5NcPLrHeARgHN
         UoZptYkTMaiQufZxy2GOINTBiSye/5al1tFW9UatFtGDv968yaSARMgDlRqcPcn3Ta
         Z8yVP77MaqYFNYR9eMiqivWsMKjfDpSXdoIDBRK9NYGAv81aGJLwmrnTZto1gtp0LE
         PTLkltr+ohsyd8fNSeV8QUcqQjwPIzEFLIcRo9Ncspi+I4WPALxjO+NNZjZBzCzOIj
         LU+xN5nz3iVPXensCwEjWFGSqEJveWjiHgVAgOaqfFPTPwnBejYZSijFMkRCUdCzLf
         bljzzRVKftOxQ==
Received: by pali.im (Postfix)
        id 63C6EA41; Tue,  2 Nov 2021 11:00:34 +0100 (CET)
Date:   Tue, 2 Nov 2021 11:00:34 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211102100034.rhcb3k2jvr6alm6y@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102094700.GA7376@alpha.franken.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 10:47:00 Thomas Bogendoerfer wrote:
> On Tue, Nov 02, 2021 at 10:02:46AM +0100, Pali Rohár wrote:
> > On Tuesday 02 November 2021 09:42:41 Thomas Bogendoerfer wrote:
> > > On Mon, Nov 01, 2021 at 04:04:05PM +0100, Pali Rohár wrote:
> > > > - The code relies on rc_pci_fixup being called, which only happens
> > > >   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
> > > >   this causes a booting failure with a non-obvious cause.
> > > > - Update rc_pci_fixup to set the class properly, copying the
> > > >   more modern style from other places
> > > > - Correct the rc_pci_fixup comment
> > > > 
> > > > This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
> > > > PCI-E fixup") for all other Marvell platforms which use same buggy PCIe
> > > > controller.
> > > > [..]
> > > 
> > > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > > index 771ca53af06d..c8d51bd20b84 100644
> > > > --- a/arch/mips/Kconfig
> > > > +++ b/arch/mips/Kconfig
> > > > @@ -346,6 +346,7 @@ config MIPS_COBALT
> > > >  	select CEVT_GT641XX
> > > >  	select DMA_NONCOHERENT
> > > >  	select FORCE_PCI
> > > > +	select PCI_QUIRKS
> > > >  	select I8253
> > > >  	select I8259
> > > >  	select IRQ_MIPS_CPU
> > > 
> > > this is enabled by default, via drivers/pci/Kconfig
> > 
> > IIRC 'default y' can be disabled but 'select' not.
> 
> overruled only if CONFIG_EXPERT is enabled, which IMHO sounds good enough.

Well, if you think this is not needed (anymore), I can drop it. I just
reapplied original fix 1dc831bf53fd.

> > > config PCI_QUIRKS
> > >         default y
> > >         bool "Enable PCI quirk workarounds" if EXPERT
> > >         help
> > >           This enables workarounds for various PCI chipset bugs/quirks.
> > >           Disable this only if your target machine is unaffected by PCI
> > >           quirks.
> > > 
> > > > diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
> > > > index 44be65c3e6bb..202f3a0bd97d 100644
> > > > --- a/arch/mips/pci/fixup-cobalt.c
> > > > +++ b/arch/mips/pci/fixup-cobalt.c
> > > > @@ -36,6 +36,12 @@
> > > >  #define VIA_COBALT_BRD_ID_REG  0x94
> > > >  #define VIA_COBALT_BRD_REG_to_ID(reg)	((unsigned char)(reg) >> 4)
> > > >  
> > > > +/*
> > > > + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
> > > > + * is operating as a root complex this needs to be switched to
> > > > + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
> > > > + * the device. Decoding setup is handled by the orion code.
> > > > + */
> > > >  static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
> > > >  {
> > > >  	if (dev->devfn == PCI_DEVFN(0, 0) &&
> > > 
> > > this is not a PCIe controller, so how is this patch related ?
> > 
> > I put that comment into all quirk code which is related to Marvell PCIe
> > device XX:00.0 and changes PCI class type from PCI_CLASS_MEMORY_OTHER to
> > PCI_CLASS_BRIDGE_HOST.
> > 
> > >From all what I saw, I'm sure that this device with this specific
> > characteristics is really (non-compliant) Marvell PCIe controller.
> 
> just nitpicking, it's a Galileo PCI bridge and not PCIe.

Marvell acquired Galileo Technology in the past, so it is possible that
this bad design is originated in Galileo. And maybe same for PCIe from
PCI. At least PCI vendor id for all (new) PCIe controllers is this one.

> > But I do not have this hardware to verify it.
> 
> I still have a few Cobalt systems here.

Perfect! It would help if you could provide 'lspci -nn -vv' output from
that system. In case you have very old version of lspci on that system
you could try to run it with '-xxxx' (or '-xxx') which prints hexdump
and I can parse it with local lspci.

> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
