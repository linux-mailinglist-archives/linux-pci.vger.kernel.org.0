Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8F2B7EA6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 14:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgKRNvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 08:51:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42896 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgKRNvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 08:51:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id w145so2212385oie.9;
        Wed, 18 Nov 2020 05:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/BvXucMD8YagduuMsyjoy5PjQbQFfc6fjlonLNMZ0Y=;
        b=qMYWdwopgxtHj/00LoZTsGypCOzmACLz+oDOHu5oNjv67hhX2zNah8OfKbS7QyZfnA
         fBbHkiYA7rzmRizfpHxahWm34+8OvI0/cywfH/mBV+zJwMY4jlUCAShZl6Z9s0w3/85X
         gv5J2x8NkJTiQIR0Fk3ikX/klOzTSPDN1OuHflEehPS6k2Fr1femZAJZLsMNL+5eWZRZ
         BgHxvd00IJgq2NPR2p5Y5T2Bhm51GlhIQ7EQr1cqkLlTqtAZWmT8tLjF6B6Hx7C1bS3X
         gigKqDjeaTcEY0swzC6Q/9+jqMahsSWFVqHWGDf5EXBOIPgD5yZgwI9bGU1L9lukYOfQ
         iI3A==
X-Gm-Message-State: AOAM533X5LC7QtFTkTkRaqfHwOpD4u3dhf81oiNyNdWBRcWSjb+6Uq4A
        51saB77PBdiv545vVcBiGC4+LpfJYeGWkI9E2yw=
X-Google-Smtp-Source: ABdhPJwz9rYpsynuWrW4AojT5lRLqDcAXL8oZ2freirUuJIhXvpLwnmhvgHoADdWOz4Np6hx9ncM62eUOU6KuZre4yY=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr74778oif.69.1605707460415;
 Wed, 18 Nov 2020 05:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20201117134214.970-1-chenbaozi@phytium.com.cn>
 <20201117185720.GA1397876@bjorn-Precision-5520> <CAMj1kXEzst3PqpbyfbGwrAXzufrBAmJHmEdBvkibtqSdAKVMDA@mail.gmail.com>
In-Reply-To: <CAMj1kXEzst3PqpbyfbGwrAXzufrBAmJHmEdBvkibtqSdAKVMDA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Nov 2020 14:50:49 +0100
Message-ID: <CAJZ5v0iML=6Eo0PAeGQeD=0g1QUzgX8-FKOUOCojoT2tNMvYjQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2] acpi/irq: Add stacked IRQ domain support to PCI
 interrupt link
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Chen Baozi <chenbaozi@phytium.com.cn>,
        Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 18, 2020 at 2:46 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 at 19:57, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > Nit: please don't just make up random styles for the subject.  Run
> > "git log --oneline" on the file and/or the directory and try to follow
> > the existing convention.  Using random styles adds noise to the
> > system.
> >
> > On Tue, Nov 17, 2020 at 09:42:14PM +0800, Chen Baozi wrote:
> > > Some PCIe designs require software to do extra acknowledgements for
> > > legacy INTx interrupts. If the driver is written only for device tree,
> > > things are simple. In that case, a new driver can be written under
> > > driver/pci/controller/ with a DT node of PCIe host written like:
> > >
> > >   pcie {
> > >     ...
> > >     interrupt-map = <0 0 0  1  &pcie_intc 0>,
> > >                     <0 0 0  2  &pcie_intc 1>,
> > >                     <0 0 0  3  &pcie_intc 2>,
> > >                     <0 0 0  4  &pcie_intc 3>;
> > >
> > >     pcie_intc: legacy-interrupt-controller {
> > >       interrupt-controller;
> > >       #interrupt-cells = <1>;
> > >       interrupt-parent = <&gic>;
> > >       interrupts = <0 226 4>;
> > >     };
> > >   };
> > >
> > > Similar designs can be found on Aardvark, MediaTek Gen2 and Socionext
> > > UniPhier PCIe controller at the moment. Essentially, those designs are
> > > supported by inserting an extra interrupt controller between PCIe host
> > > and GIC and parse the topology in a DT-based PCI controller driver.
> >
> > If I understand correctly, we previously ignored the Resource Source
> > field of an Extended Interrupt Descriptor in the _PRS method of
> > PNP0C0F PCI Interrupt Link devices, and this patch adds support for
> > it.
> >
> > If that's true, this has nothing to do with DT, other than DT being
> > another way to describe the same topology, and the above details
> > really aren't relevant to this patch.
> >
> > > As we turn to ACPI, All the PCIe hosts are described the same ID of
> > > "PNP0A03" and share driver/acpi/pci_root.c. It comes to be a problem
> > > to make this kind of PCI INTx work under ACPI.
> >
> > s/All the PCIe/all the PCIe/
> >
> > But this paragraph should probably just go away in favor of something
> > about implementing Resource Source support.
> >
> > > Therefore, we introduce an stacked IRQ domain support to PCI interrupt
> > > link for ACPI. With this support, we can populate the ResourceSource
> > > to refer to a device object that describes an interrupt controller.
> > > That would allow us to refer to a dedicated driver which implements
> > > the logic needed to manage the interrupt state. With this patch,
> > > those PCI interrupt links can be supported by describing the INTx
> > > in ACPI table as the following example:
> >
> > "Stacked IRQ domain" sounds like a detail of how you're implementing
> > support for the Resource Source field for PCI Interrupt Links.
> >
> > I don't know what the dedicated driver refers to.  This *should* be
> > all generic code the follows the ACPI spec (which is pretty sketchy in
> > this area).  But I assume that there's no special driver needed for
> > devices like \SB.IXIU, and the logic associated with the interrupt
> > controller is in the AML associated with IXIU.  It would probably be
> > useful to mention the relevant methods in the IXIU methods in the
> > example below.
> >
>
> As I understand it, the intent is to provide a driver for \SB.IXIU
> that acknowledges the legacy INTx interrupts in a SoC specific way,
> and I don't see how AML could be involved here.
>
> That also explains why the routines are exported to modules - the IXIU
> driver could be modularized.

OK, but every new symbol export requires an in-the-tree user or the
patch is basically not applicable.
