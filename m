Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF6D4373B8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhJVIhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 04:37:20 -0400
Received: from foss.arm.com ([217.140.110.172]:51392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhJVIhU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 04:37:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75708ED1;
        Fri, 22 Oct 2021 01:35:02 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6EB3F70D;
        Fri, 22 Oct 2021 01:35:00 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:34:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        robh+dt@kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
Message-ID: <20211022083455.GA20345@lpieralisi>
References: <CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2XdYTBvT4R4MEOUB=WQ1g@mail.gmail.com>
 <20211021181145.GA2708516@bhelgaas>
 <CAMhs-H8pTmbG0idbPWjnW4faFj0F4TKwSSK6wzwepbqWSEtx4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8pTmbG0idbPWjnW4faFj0F4TKwSSK6wzwepbqWSEtx4w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 09:23:35PM +0200, Sergio Paracuellos wrote:
> On Thu, Oct 21, 2021 at 8:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Oct 21, 2021 at 07:27:21PM +0200, Sergio Paracuellos wrote:
> > > On Thu, Oct 21, 2021 at 5:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > Since this is a PCIe (not conventional PCI) controller, I vote for
> > > > renaming these from:
> > > >
> > > >   PCI_MT7621
> > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > >   drivers/pci/controller/pci-mt7621.c
> > > >
> > > > to:
> > > >
> > > >   PCIE_MT7621
> > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> > > >   drivers/pci/controller/pcie-mt7621.c
> > > >
> > > > We have a mix of these, with many of the early PCIe drivers being
> > > > named "pci", but I think that was my mistake and there's no reason to
> > > > continue it.
> > >
> > > I see.
> > >
> > > >
> > > > I can do this locally unless somebody objects.
> > >
> > > I have no problem at all. Only one question. Do you mean to change
> > > compatible string also, or only the name of the file? Let me know if I
> > > have to do anything.
> >
> > I didn't change the compatible string, to avoid a DT incompatibility.
> > But I *did* change the Kconfig symbol to PCIE_MT7621, which could
> > require changes to out-of-tree .configs.  I'm open to suggestions
> > either way for both things.
> 
> IMHO, I do think we should not worry about out-of-tree stuff at all.

For Kconfig I tend to agree. For DT I see some "bindings" in the staging
tree are being deleted and published as official DT bindings with this
patchset but I believe we still have to keep the compatible string
backward compatibility regardless because there may be firmware out
there using it.

Rob, what's the standard policy that should be used in this case ?

Thanks,
Lorenzo

> If the correct way to define the Kconfig symbol or the compatible
> string is to change them, just do that. MT7621 SoC is extensively used
> by openWRT community. As far as I have seen until now, the way of
> doing things there is to take the latest long term kernel (now they
> are using 5.4 as stable and 5.10 as testing kernel), apply a bunch of
> patches they have and do a complete build of both kernel, device tree
> and rootfs. So I guess it is not a big problem if we also change
> compatible string since when an update is performed for a device all
> of the stuff is just replaced. Maybe I am wrong and John has a
> different opinion... John, any comments on this?
> 
> Best regards,
>     Sergio Paracuellos
