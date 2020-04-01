Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482B719B6F3
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 22:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgDAU3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 16:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbgDAU3l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 16:29:41 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F423206E9;
        Wed,  1 Apr 2020 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585772980;
        bh=OlC+pjNqOImVx3sNog54550MPbIAXh6MRIXiUyGaRI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jxNBn1LV5GLPEow67NIpgB2aB7VhkDJXcRVTRY2eH1Lukq7C++VqWPaYwkY86IVZ0
         U3K5b2fRz9s4Bzr+kORlkX7aEwfQ6bvIU1B7jHl4dxRcdiQmZZaAHkhM+VUSD5Ihgs
         6nMEE0IHmek+AnjoQFG3KSUCaY1FppPihxG5JrG8=
Date:   Wed, 1 Apr 2020 15:29:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] PCI: Warn about MEM resource size being too big
Message-ID: <20200401202937.GA130497@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEDWGzfTDtmq==j-GcK3YYbdPX4-Ms=PDuDEiQusV78bUGvDA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 31, 2020 at 01:36:04PM -0700, Alan Mikhak wrote:
> On Tue, Mar 31, 2020 at 1:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Mar 30, 2020 at 05:19:47PM -0700, Alan Mikhak wrote:
> > > Output a warning for MEM resource size with
> > > non-zero upper 32-bits.
> > >
> > > ATU programming functions limit the size of
> > > the translated region to 4GB by using a u32 size
> > > parameter. Function dw_pcie_prog_outbound_atu()
> > > does not program the upper 32-bit ATU limit
> > > register. This may result in undefined behavior
> > > for resource sizes with non-zero upper 32-bits.
> > >
> > > For example, a 128GB address space starting at
> > > physical CPU address of 0x2000000000 with size of
> > > 0x2000000000 needs the following values programmed
> > > into the lower and upper 32-bit limit registers:
> > >  0x3fffffff in the upper 32-bit limit register
> > >  0xffffffff in the lower 32-bit limit register
> > >
> > > Currently, only the lower 32-bit limit register is
> > > programmed with a value of 0xffffffff but the upper
> > > 32-bit limit register is not being programmed.
> > > As a result, the upper 32-bit limit register remains
> > > at its default value after reset of 0x0. This would
> > > be a problem for a 128GB PCIe space because in
> > > effect its size gets reduced to 4GB.
> > >
> > > ATU programming functions can be changed to
> > > specify a u64 size parameter for the translated
> > > region. Along with this change, the internal
> > > calculation of the limit address, the address of
> > > the last byte in the translated region, needs to
> > > change such that both the lower 32-bit and upper
> > > 32-bit limit registers can be programmed correctly.
> > >
> > > Changing the ATU programming functions is high
> > > impact. Without change, this issue can go
> > > unnoticed. A warning may prompt the user to
> > > look into possible issues.
> >
> > So this is basically a warning, and we could actually *fix* the
> > problem with more effort?  I vote for the fix.
> 
> The fix would impact all PCIe drivers that depend on dwc.

Is that another way of saying "the fix would *fix* all the drivers
that depend on dwc"?

> I would have no way of validating such a fix without
> breaking it for everyone let alone the bandwidth it needs.
> All drivers that depend on dwc seem to be currently happy
> with the u32 size limit. I suggest we add the warning but
> keep this issue in mind for a solution that allows existing
> PCe drivers to phase into the fix on their own individual
> schedules, if they need to.

Obviously it would *nice* to test all the drivers that depend on dwc,
but if you're fixing a problem, you verify the fix on your system, and
the relevant people review it, I don't think exhaustive testing is a
hard requirement, and I certainly wouldn't expect you to do it.

If we want to live with a 32-bit limit, I think we should change the
relevant interfaces to use u32 so there's not a way to venture into
this region of undefined behavior.  I don't think "warning + undefined
behavior" is a very maintainable situation.

> > > This limitation also means that multiple ATUs
> > > would need to be used to map larger regions.
> > >
> > > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 395feb8ca051..37a8c71ef89a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -325,6 +325,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >       struct pci_bus *child;
> > >       struct pci_host_bridge *bridge;
> > >       struct resource *cfg_res;
> > > +     resource_size_t mem_size;
> > >       u32 hdr_type;
> > >       int ret;
> > >
> > > @@ -362,7 +363,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >               case IORESOURCE_MEM:
> > >                       pp->mem = win->res;
> > >                       pp->mem->name = "MEM";
> > > -                     pp->mem_size = resource_size(pp->mem);
> > > +                     mem_size = resource_size(pp->mem);
> > > +                     if (upper_32_bits(mem_size))
> > > +                             dev_warn(dev, "MEM resource size too big\n");
> > > +                     pp->mem_size = mem_size;
> > >                       pp->mem_bus_addr = pp->mem->start - win->offset;
> > >                       break;
> > >               case 0:
> > > --
> > > 2.7.4
> > >
