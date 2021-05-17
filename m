Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92816383C39
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 20:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhEQS3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 14:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235243AbhEQS33 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 14:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEF7A61261;
        Mon, 17 May 2021 18:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621276092;
        bh=xr4By+o4TUcYhY8fMdG2qW3F/z04dvfGfYWvO2UuXis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZGkZwfNGKfPAGRf7t4YDIiybc0B2ozc79Tb5PyfccEIzEER/S56tEvysv9VOQs6rk
         C+tdl114Ly0SfxT612kT5T6PnKmEGAukVad0SAlmtKCE3S0WpSsX/LTN3ssQF1RDTH
         vWxWAWUw0/0Ue0SjHgZ7Kn0NeexBkOC967TVR8238npJxmDCghNf6AV1f+acOy0wye
         XoInqx4FW5E18DvneeFu/75r+8jsTMsZhUdKNoqf/xa1iNqYUvbgEq1L4ODIm+b/hM
         D6M2wDycEU2m8avLYeteiakr207jc3ay6wbla0tTqeD0yYJMUhH1gGxtK0769bViey
         EEw/EO4YYYcQw==
Date:   Mon, 17 May 2021 13:28:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jingfeng Sui <suijingfeng@loongson.cn>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving
 bridge
Message-ID: <20210517182810.GA29638@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6E3vh9+SZg5qOmVbfjENRPi0=UbLqK-YHcCA0mzcx9aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 08:53:43PM +0800, Huacai Chen wrote:
> On Sat, May 15, 2021 at 5:09 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Fri, May 14, 2021 at 11:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, May 14, 2021 at 04:00:25PM +0800, Huacai Chen wrote:
> > > > According to PCI-to-PCI bridge spec, bit 3 of Bridge Control Register is
> > > > VGA Enable bit which modifies the response to VGA compatible addresses.
> > >
> > > The bridge spec is pretty old, and most of the content has been
> > > incorporated into the PCIe spec.  I think you can cite "PCIe r5.0, sec
> > > 7.5.1.3.13" here instead.
> > >
> > > > If the VGA Enable bit is set, the bridge will decode and forward the
> > > > following accesses on the primary interface to the secondary interface.
> > >
> > > *Which* following accesses?  The structure of English requires that if
> > > you say "the following accesses," you must continue by *listing* the
> > > accesses.
> > >
> > > > The ASpeed AST2500 hardward does not set the VGA Enable bit on its
> > > > bridge control register, which causes vgaarb subsystem don't think the
> > > > VGA card behind the bridge as a valid boot vga device.
> > >
> > > s/hardward/bridge/
> > > s/vga/VGA/ (also in code comments and dmesg strings below)
> > >
> > > From the code, it looks like AST2500 ([1a03:2000]) is a VGA device,
> > > since it apparently has a VGA class code.  But here you say the
> > > AST2500 has a Bridge Control register, which suggests that it's a
> > > bridge.  If AST2500 is some sort of combination that includes both a
> > > bridge and a VGA device, please outline that topology.
> > >
> > > But the hardware defect is that some bridges forward VGA accesses even
> > > though their VGA Enable bit is not set?  The quirk should be attached
> > > to broken *bridges*, not to VGA devices.
> > >
> > > If a bridge forwards VGA accesses regardless of how its VGA Enable bit
> > > is set, that means VGA arbitration (in vgaarb.c) cannot work
> > > correctly, so merely setting the default VGA device once in a quirk is
> > > not sufficient.  You would have to somehow disable any future attempts
> > > to use other VGA devices.  Only the VGA device below this defective
> > > bridge is usable.  Any other VGA devices in the system would be
> > > useless.
> > >
> > > > So we provide a quirk to fix Xorg auto-detection.
> > > >
> > > > See similar bug:
> > > >
> > > > https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/
> > >
> > > This patch was never merged.  If we merged a revised version, please
> > > cite the SHA1 instead.
> >
> > This patch has never merged, and I found that it is unnecessary after
> > commit a37c0f48950b56f6ef2ee637 ("vgaarb: Select a default VGA device
> > even if there's no legacy VGA"). Maybe this ASpeed patch is also
> > unnecessary. If it is still needed, I'll investigate the root cause.
>
> I found that vga_arb_device_init() and pcibios_init() are both wrapped
> by subsys_initcall(), which means their sequence is unpredictable. And
> unfortunately, in our platform vga_arb_device_init() is called before
> pcibios_init(), which makes vga_arb_device_init() fail to set a
> default vga device. This is the root cause why we thought that we
> still need a quirk for AST2500.

Does this mean there is no hardware defect here?  The VGA Enable bit
works correctly?

> I think the best solution is make vga_arb_device_init() be wrapped by
> subsys_initcall_sync(), do you think so?

Hmm.  Unfortunately the semantics of subsys_initcall_sync() are not
documented, so I'm not sure exactly *why* such a change would work and
whether we could rely on it to continue working.

pcibios_init() isn't very consistent across arches.  On some,
including alpha, microblaze, some MIPS platforms, powerpc, and sh, it
enumerates PCI devices.  On others (ia64, parisc, sparc, x86), it does
basically nothing.  That makes life a little difficult.

vga_arb_device_init() is a subsys_initcall() and wants to look through
all the PCI devices.  That's a little problematic for arches where
pcibios_init() is also a subsys_initcall() and enumerates PCI devices.

Sorry, that's no answer for you.  Just more questions :)

> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > Signed-off-by: Jingfeng Sui <suijingfeng@loongson.cn>
> > > > ---
> > > >  drivers/pci/quirks.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 47 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 6ab4b3bba36b..adf5490706ad 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include <linux/platform_data/x86/apple.h>
> > > >  #include <linux/pm_runtime.h>
> > > >  #include <linux/switchtec.h>
> > > > +#include <linux/vgaarb.h>
> > > >  #include <asm/dma.h> /* isa_dma_bridge_buggy */
> > > >  #include "pci.h"
> > > >
> > > > @@ -297,6 +298,52 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> > > >  }
> > > >  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> > > >
> > > > +
> > > > +static void aspeed_fixup_vgaarb(struct pci_dev *pdev)
> > > > +{
> > > > +     struct pci_dev *bridge;
> > > > +     struct pci_bus *bus;
> > > > +     struct pci_dev *vdevp = NULL;
> > > > +     u16 config;
> > > > +
> > > > +     bus = pdev->bus;
> > > > +     bridge = bus->self;
> > > > +
> > > > +     /* Is VGA routed to us? */
> > > > +     if (bridge && (pci_is_bridge(bridge))) {
> > > > +             pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &config);
> > > > +
> > > > +             /* Yes, this bridge is PCI bridge-to-bridge spec compliant,
> > > > +              *  just return!
> > > > +              */
> > > > +             if (config & PCI_BRIDGE_CTL_VGA)
> > > > +                     return;
> > > > +
> > > > +             dev_warn(&pdev->dev, "VGA bridge control is not enabled\n");
> > > > +     }
> > >
> > > You cannot assume that a bridge is defective just because
> > > PCI_BRIDGE_CTL_VGA is not set.
> > >
> > > > +     /* Just return if the system already have a default device */
> > > > +     if (vga_default_device())
> > > > +             return;
> > > > +
> > > > +     /* No default vga device */
> > > > +     while ((vdevp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, vdevp))) {
> > > > +             if (vdevp->vendor != 0x1a03) {
> > > > +                     /* Have other vga devcie in the system, do nothing */
> > > > +                     dev_info(&pdev->dev, "Another boot vga device: 0x%x:0x%x\n",
> > > > +                             vdevp->vendor, vdevp->device);
> > > > +                     return;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     vga_set_default_device(pdev);
> > > > +
> > > > +     dev_info(&pdev->dev, "Boot vga device set as 0x%x:0x%x\n",
> > > > +                     pdev->vendor, pdev->device);
> > > > +}
> > > > +DECLARE_PCI_FIXUP_CLASS_FINAL(0x1a03, 0x2000, PCI_CLASS_DISPLAY_VGA, 8, aspeed_fixup_vgaarb);
> > > > +
> > > > +
> > > >  /*
> > > >   * The Mellanox Tavor device gives false positive parity errors.  Disable
> > > >   * parity error reporting.
> > > > --
> > > > 2.27.0
> > > >
