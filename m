Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066C9442A0D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhKBJFX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 05:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhKBJFX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 05:05:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC86260E05;
        Tue,  2 Nov 2021 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635843768;
        bh=8wFHPWHGTrkdWQ8Rg0jFwvGD6+TqSh4GdunJr1ZRWp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7wie3SKJW7o//RrH6ZmQkZGKmm6ICJ7+6v08PoPB55oTnGB/U4Wnypac90qNijQy
         3hZbZP+vk6MKSQ/kVRsMtQcJ9tSLg7aTtCeC0r2m03eYBMvH6SMLRaerbW8w+2uTzW
         u0GUwMM/dNMVltQtGNIBtcy3DXhef2iCHdMYJKYema8mS615CO/vXIPtDQzrKMqIfJ
         TWWcyta+9LoScqZz9zHobh1xgfGBlaTJeR2yox4YlXMC9THQAgEQNXf0QFuV2ImxSR
         wvUJm14v9NUMXQmi3/5iZ4wCrPmn6WTSdDCBLJsEOthTy4OLEEuVX+27+N5sbgLMHJ
         ebZ2KwNTcgofQ==
Received: by pali.im (Postfix)
        id 367D5A41; Tue,  2 Nov 2021 10:02:46 +0100 (CET)
Date:   Tue, 2 Nov 2021 10:02:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211102090246.unmbruykfdjabfga@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102084241.GA6134@alpha.franken.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 09:42:41 Thomas Bogendoerfer wrote:
> On Mon, Nov 01, 2021 at 04:04:05PM +0100, Pali Rohár wrote:
> > - The code relies on rc_pci_fixup being called, which only happens
> >   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
> >   this causes a booting failure with a non-obvious cause.
> > - Update rc_pci_fixup to set the class properly, copying the
> >   more modern style from other places
> > - Correct the rc_pci_fixup comment
> > 
> > This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
> > PCI-E fixup") for all other Marvell platforms which use same buggy PCIe
> > controller.
> > [..]
> 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 771ca53af06d..c8d51bd20b84 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -346,6 +346,7 @@ config MIPS_COBALT
> >  	select CEVT_GT641XX
> >  	select DMA_NONCOHERENT
> >  	select FORCE_PCI
> > +	select PCI_QUIRKS
> >  	select I8253
> >  	select I8259
> >  	select IRQ_MIPS_CPU
> 
> this is enabled by default, via drivers/pci/Kconfig

IIRC 'default y' can be disabled but 'select' not.

> 
> config PCI_QUIRKS
>         default y
>         bool "Enable PCI quirk workarounds" if EXPERT
>         help
>           This enables workarounds for various PCI chipset bugs/quirks.
>           Disable this only if your target machine is unaffected by PCI
>           quirks.
> 
> > diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
> > index 44be65c3e6bb..202f3a0bd97d 100644
> > --- a/arch/mips/pci/fixup-cobalt.c
> > +++ b/arch/mips/pci/fixup-cobalt.c
> > @@ -36,6 +36,12 @@
> >  #define VIA_COBALT_BRD_ID_REG  0x94
> >  #define VIA_COBALT_BRD_REG_to_ID(reg)	((unsigned char)(reg) >> 4)
> >  
> > +/*
> > + * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
> > + * is operating as a root complex this needs to be switched to
> > + * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
> > + * the device. Decoding setup is handled by the orion code.
> > + */
> >  static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
> >  {
> >  	if (dev->devfn == PCI_DEVFN(0, 0) &&
> 
> this is not a PCIe controller, so how is this patch related ?

I put that comment into all quirk code which is related to Marvell PCIe
device XX:00.0 and changes PCI class type from PCI_CLASS_MEMORY_OTHER to
PCI_CLASS_BRIDGE_HOST.

From all what I saw, I'm sure that this device with this specific
characteristics is really (non-compliant) Marvell PCIe controller.

But I do not have this hardware to verify it.

> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
