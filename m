Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4875939CB39
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 23:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFEVao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 17:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEVao (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 17:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0738613DF;
        Sat,  5 Jun 2021 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622928536;
        bh=PsQ26Njl5e5FiSGX655DWgdW2M0w8QvbGjtn0uJSYSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kagaz4poB4OhfnoV+a9yMJItRJdi0D/+Glja7ztcCJaEHY5WLHyC+PMQTKaHdZc0X
         7gCs8oceFvbUiBh3f7JfPZ6xhLSQVrGNXc6W60y2C8iQ2ai85FilZuwR0QByhVP9fV
         +qupwNqv8k4wkIqdsy/quJQLM6ymsWCogOZvgxP0P+iBTv5Cs3OWCNoKdpJSOavL6V
         ukL0YFrl3z/STVdkJf8PJXVXUCz/MhH9H0jSgVTKNyCTta71EJDZP9sH2gjYqTFRxz
         aCSgw/FgoZMENx5ivnSLcoNIXP5WE08ZrxwKrULQloRFPI2ZYmjY9AskNFfQ0Hq+Mw
         nVpx5pdVv059Q==
Date:   Sat, 5 Jun 2021 16:28:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2 4/4] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20210605212854.GA2324905@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6t_UpcW3iCYw9iG3NXhZin4Sk-zsORNcrcg8Q=8jiJcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 04, 2021 at 05:59:35PM +0800, Huacai Chen wrote:
> On Sat, May 29, 2021 at 4:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Rob, previous discussion at
> > https://lore.kernel.org/r/20210514080025.1828197-5-chenhuacai@loongson.cn]
> >
> > On Fri, May 28, 2021 at 03:15:03PM +0800, Huacai Chen wrote:
> > > From: Jianmin Lv <lvjianmin@loongson.cn>
> > >
> > > In LS7A, multifunction device use same PCI PIN (because the PIN register
> > > report the same INTx value to each function) but we need different IRQ
> > > for different functions, so add a quirk to fix it for standard PCI PIN
> > > usage.
> >
> > This seems to say that PCI_INTERRUPT_PIN reports the same value for
> > all functions, but the functions actually use *different* IRQs.
> >
> > That would be a hardware defect, and of course, we can work around
> > such things.  It's always better if you can assure us that the defect
> > will be fixed in future designs so we don't have to update the
> > workaround with more device IDs.
>
> Yes, you are right, and new hardware will not need this workaround.
> 
> > But Jiaxun suggests [1] that the FDT says all the interrupts go to the
> > same IRQ.
> >
> > So I don't know what's going on here.  We can certainly work around a
> > problem, but of course, this quirk would apply for both FDT and
> > ACPI-based systems, and the FDT systems seem to work without it.
>
> Emmm, I have discussed with Jiaxun, and maybe you missed something. He
> means that ACPI systems need this workaround, and FDT systems don't
> need this. But this workaround doesn't break FDT systems, because FDT
> systems simply ignore the workaround (interrupts are specified in .dts
> file).

I'm definitely missing something :)

Part of my confusion is because generally both ACPI and DT describe
fixed parts of the platform.  Usually neither describes PCI devices
because PCI includes ways to discover devices and discover the
resources (memory, IRQs, etc) they use.

So the general picture is that ACPI and DT describe the parts of
interrupt routing that can not be discovered from the hardware itself.
The PCI IRQ pin *can* be discovered from the hardware, so I expected
both ACPI and DT to rely on it.

But this quirk applies to [0014:7a09], [0014:7a19], and [0014:7a29],
which look like they are PCIe Root Ports, and your DT ([2]) *does*
seem to describe them with interrupt descriptions.  So I assume the
reason DT systems don't care about this quirk is because they use this
IRQ info from DT and ignore the PCI_INTERRUPT_PIN?

If DT systems ignore the quirk, as you said above, I assume that means
that DT overwrites dev->pin sometime *after* the quirk executes?  Or
there's some DT check that means we ignore dev->pin?  Can you point me
to whatever this mechanism is?

The quirk is not specific to ACPI or DT, so it's not clear to me how
it stays out of DT's way.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/loongson/ls7a-pch.dtsi?id=v5.12#n229

> > [1] https://lore.kernel.org/r/933330cb-9d86-2b22-9bed-64becefbe2d1@flygoat.com
> >
> > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/pci/quirks.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 10b3b2057940..6ab4b3bba36b 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -242,6 +242,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > >                       DEV_LS7A_LPC, loongson_system_bus_quirk);
> > >
> > > +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> > > +{
> > > +     dev->pin = 1 + (PCI_FUNC(dev->devfn) & 3);
> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
> > > +
> > >  static void loongson_mrrs_quirk(struct pci_dev *dev)
> > >  {
> > >       struct pci_bus *bus = dev->bus;
> > > --
> > > 2.27.0
> > >
