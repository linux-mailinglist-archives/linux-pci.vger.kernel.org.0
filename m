Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFFC3DF38E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhHCRHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 13:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237766AbhHCRGz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 13:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE56A60F70;
        Tue,  3 Aug 2021 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628010404;
        bh=qEY8Bu/LLbSKucIMTa8orC3/EQ1DAHCTMNpr7WqWX0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AzU1mF40f+QNzvhYdWd5RSW8m4jScUOe5RDPBs391Y6TUXugBr4IJnGyWD7LS/iDE
         HJSRwEsI3F+KOyRRGYdjd4lQEx4JHPxLnmHGBfrccWDzjFLQ0wE3Rtf3FTjBVCLZ1Z
         C1bXZzZEaTUn1cNTJDrlKDwU/NSocSt9+sHc317pFOUwcMjV+PLjEV40M02c12V/Fb
         hrgbwIkIjwi4wwqfXHD3RbUd+dTcDEvbOrjQleigMROBs/YFRYqMrLS1GFfNdQpRfb
         cjk295OcxHbExULzjtKbr81q5NOT8WjF/njFHc4gsvaqVIt3AhTzQ3OrkDKvAYYpsD
         +bQUUTAdtKC1w==
Date:   Tue, 3 Aug 2021 12:06:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 0/9] PCI/VGA: Rework default VGA device selection
Message-ID: <20210803170642.GA1556172@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7pYbht=N7C8xpytYnn=MefyRfLDRPsY-56ObpBbJUuzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 24, 2021 at 05:30:02PM +0800, Huacai Chen wrote:
> Hi, Bjorn,
> 
> On Sat, Jul 24, 2021 at 8:10 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Jul 23, 2021 at 05:53:36PM +0800, Huacai Chen wrote:
> > > Hi, Bjorn,
> > >
> > > On Fri, Jul 23, 2021 at 5:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > This is a little bit of rework and extension of Huacai's nice work at [1].
> > > >
> > > > It moves the VGA arbiter to the PCI subsystem, fixes a few nits, and breaks
> > > > a few pieces off Huacai's patch to make the main patch a little smaller.
> > > >
> > > > That last patch is still not very small, and it needs a commit log, as I
> > > > mentioned at [2].
> > > >
> > > > All comments welcome!
> > > >
> > > > [1] https://lore.kernel.org/dri-devel/20210705100503.1120643-1-chenhuacai@loongson.cn/
> > > > [2] https://lore.kernel.org/r/20210720221923.GA43331@bjorn-Precision-5520
> > > Thank you for your splitting. Your two questions are answered in the following.
> > >
> > > (1) explain why your initcall ordering is unusual.
> > > The original problem happens on MIPS. vga_arb_device_init() and
> > > pcibios_init() are both wrapped by subsys_initcall(). The order of
> > > functions in the same level depends on the Makefile.
> > >
> > > TOP level Makefile:
> > > drivers-y       := drivers/ sound/
> > > ....
> > > include arch/$(SRCARCH)/Makefile
> > >
> > > drivers/Makefile:
> > > obj-$(CONFIG_ACPI)              += acpi/
> > > ....
> > > obj-y                           += gpu/
> > >
> > > arch/mips/Makefile:
> > > drivers-$(CONFIG_PCI)           += arch/mips/pci/
> > >
> > > This makes pcibios_init() in arch/mips/pci/ placed after
> > > vga_arb_device_init() in drivers/gpu. ACPI-based systems have no
> > > problems because acpi_init() in drivers/acpi is placed before
> > > vga_arb_device_init().
> >
> > Thanks for the above; that was helpful.  To summarize:
> >
> >   - On your system, the AST2500 bridge [1a03:1150] does not implement
> >     PCI_BRIDGE_CTL_VGA [1].  This is perfectly legal but means the
> >     legacy VGA resources won't reach downstream devices unless they're
> >     included in the usual bridge windows.
> >
> >   - vga_arb_select_default_device() will set a device below such a
> >     bridge as the default VGA device as long as it has PCI_COMMAND_IO
> >     and PCI_COMMAND_MEMORY enabled.
> >
> >   - vga_arbiter_add_pci_device() is called for every VGA device,
> >     either at boot-time or at hot-add time, and it will also set the
> >     device as the default VGA device, but ONLY if all bridges leading
> >     to it implement PCI_BRIDGE_CTL_VGA.
> >
> >   - This difference between vga_arb_select_default_device() and
> >     vga_arbiter_add_pci_device() means that a device below an AST2500
> >     or similar bridge can only be set as the default if it is
> >     enumerated before vga_arb_device_init().
> >
> >   - On ACPI-based systems, PCI devices are enumerated by acpi_init(),
> >     which runs before vga_arb_device_init().
> >
> >   - On non-ACPI systems, like your MIPS system, they are enumerated by
> >     pcibios_init(), which typically runs *after*
> >     vga_arb_device_init().
> >
> > So I think the critical change is actually that you made
> > vga_arb_update_default_device(), which you call from
> > vga_arbiter_add_pci_device(), set the default device even if it does
> > not own the VGA resources because an upstream bridge doesn't implement
> > PCI_BRIDGE_CTL_VGA, i.e.,
> >
> >   (vgadev->owns & VGA_RSRC_LEGACY_MASK) != VGA_RSRC_LEGACY_MASK
> >
> > Does that seem right?
>
> Yes, that's right.

I think that means I screwed up.  I somehow had it in my head that the
hot-add path would never set the default VGA device.  But that is
false.

I still think we should move vgaarb.c to drivers/pci/ and get it more
tightly integrated into the PCI core.

BUT that's a lot of churn and obscures the simple change that fixes
the problem for you.  So I think the first step should be the change
to vga_arb_update_default_device() so it sets the default device even
when the upstream bridge doesn't implement PCI_BRIDGE_CTL_VGA.

That should be a relatively small change, and I think it's better to
make the fix before embarking on major restructuring.

> > [1] https://lore.kernel.org/r/CAAhV-H4pn53XC7qVvwM792ppkQRnjWpPDwmrhBv8twgQu0eabQ@mail.gmail.com
> >
> > > (2) explain the approach, which IIUC is basically to add the
> > > vga_arb_select_default_device() functionality to
> > > vga_arbiter_add_pci_device().
> > > vga_arb_select_default_device() has only one chance to be called, we
> > > want to make it be called every time a new vga device is added. So
> > > rename it to vga_arb_update_default_device() and move the callsite to
> > > vga_arbiter_add_pci_device().
> > >
> > > I think you know all the information which you need now. And you can
> > > reorganize the commit message based on the existing one. As English is
> > > not my first language, the updated commit message written by me may
> > > still not be as good as you want.:)
> > >
> > > Huacai
> > >
> > > > Bjorn Helgaas (4):
> > > >   PCI/VGA: Move vgaarb to drivers/pci
> > > >   PCI/VGA: Replace full MIT license text with SPDX identifier
> > > >   PCI/VGA: Use unsigned format string to print lock counts
> > > >   PCI/VGA: Remove empty vga_arb_device_card_gone()
> > > >
> > > > Huacai Chen (5):
> > > >   PCI/VGA: Move vga_arb_integrated_gpu() earlier in file
> > > >   PCI/VGA: Prefer vga_default_device()
> > > >   PCI/VGA: Split out vga_arb_update_default_device()
> > > >   PCI/VGA: Log bridge control messages when adding devices
> > > >   PCI/VGA: Rework default VGA device selection
> > > >
> > > >  drivers/gpu/vga/Kconfig           |  19 ---
> > > >  drivers/gpu/vga/Makefile          |   1 -
> > > >  drivers/pci/Kconfig               |  19 +++
> > > >  drivers/pci/Makefile              |   1 +
> > > >  drivers/{gpu/vga => pci}/vgaarb.c | 269 ++++++++++++------------------
> > > >  5 files changed, 126 insertions(+), 183 deletions(-)
> > > >  rename drivers/{gpu/vga => pci}/vgaarb.c (90%)
> > > >
> > > > --
> > > > 2.25.1
> > > >
