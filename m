Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9D19A000
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgCaUgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 16:36:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 16:36:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id e7so18514423lfq.1
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2020 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mi/0DRDkAum6TzV6/ZOqmtHtRb5Bi7gN5ocmdruvlA=;
        b=lY+or9IMM0v+a4eR3bqqOquIhjMv6zd1VGRJ5G6tJOzkSMw47bVJhZEGQL2Jkz5le2
         ExCm51xLQ/I9QBGica/BnEtXmBQuSbI2l8/f+mNPA8ePvaIy+F9Y0V89fxZCzfvP0zG8
         7f7ygV7mWd8GiPAQLmqr/lE+ENfXKyvabAHA0b+KcREEX3kIOmTxrlKhO/F5SCRoodwl
         q9VxPb9739Y05LN1Yz5vQuM83mybxZ+Tu3+URdsyur2375YDdymFvXmIcBa6TVHymeQV
         ryFr8E9k7B8rfPEtOzK0PEb8goMQscDaunqyVKfbRDQv8j5UQx5bywx0uPMALdoZiKeg
         v41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mi/0DRDkAum6TzV6/ZOqmtHtRb5Bi7gN5ocmdruvlA=;
        b=PBaKJqGDoEwTpn3sgqfyeiL4FlEKnMmw+voNyWnzVp+WJzfG+au9mLMYVqGQy4nppM
         3DyEYH9z9FKymMQUdLzyAUSI3UsEDvC9RIgkZlzMPyegB++bVIcQMr2/R4ZEJ8yQ4VIt
         TaoE2SswXNvGr8b3ZHyW/BzNF3XRmGUZq2bPBBSyHQPbQKC/z/ujRXPZdre5tSJwOfbZ
         q7GB9fS6H8RWUPG66i0QsCqiVkh/x8lJMvzx6v/GXHgNsGEQs6ScJYb4ATycYkO7Gu8h
         cFGga6TYb23XTlLstV502ZBradnkFeYVucHz2By0qYPZBk75EZTCLc8oKA1R1kx5+xuM
         8fow==
X-Gm-Message-State: AGi0PuaEQEq+eS7Gsd4NMeKVHhQsoijv3FhNsJsXqkUxdft+tOG97ZEa
        LbyAmoGUDVxvle4DWM3MdHzCsGCUvMu7FHox+8ZeY4EeBjQ=
X-Google-Smtp-Source: APiQypKL0CnqT/WSQkrPHGw03SMh9fydmwsQsO54VHzAOp6Hm+QlbmqqQBmC1SeoArAR1SsELbPvScFXM7dekGI8wm0=
X-Received: by 2002:a19:4843:: with SMTP id v64mr12135388lfa.171.1585686975165;
 Tue, 31 Mar 2020 13:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <1585613987-8453-1-git-send-email-alan.mikhak@sifive.com> <20200331201225.GA19649@google.com>
In-Reply-To: <20200331201225.GA19649@google.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 31 Mar 2020 13:36:04 -0700
Message-ID: <CABEDWGzfTDtmq==j-GcK3YYbdPX4-Ms=PDuDEiQusV78bUGvDA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Warn about MEM resource size being too big
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 31, 2020 at 1:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> $ git log --oneline drivers/pci/controller/dwc/pcie-designware-host.c
> 7fe71aa84b43 ("PCI: dwc: Use pci_parse_request_of_pci_ranges()")
> 1137e61dcb99 ("PCI: dwc: Fix find_next_bit() usage")
> 0b24134f7888 ("PCI: dwc: Add validation that PCIe core is set to correct mode")
> 3924bc2fd1b6 ("PCI: dwc: Group DBI registers writes requiring unlocking")
> ca98329d3b58 ("PCI: dwc: Export APIs to support .remove() implementation")
> 9d071cade30a ("PCI: dwc: Add API support to de-initialize host")
> fe23274f72f4 ("PCI: dwc: Save root bus for driver remove hooks")
>
> Please make yours match.  Please mention something about the 32-bit
> limit instead of just "being too big".
>
> Wrap the commit log to 75 columns to be consistent with the rest of
> the history.
>

Thanks Bjorn for your comments. Will correct in v2.

> On Mon, Mar 30, 2020 at 05:19:47PM -0700, Alan Mikhak wrote:
> > Output a warning for MEM resource size with
> > non-zero upper 32-bits.
> >
> > ATU programming functions limit the size of
> > the translated region to 4GB by using a u32 size
> > parameter. Function dw_pcie_prog_outbound_atu()
> > does not program the upper 32-bit ATU limit
> > register. This may result in undefined behavior
> > for resource sizes with non-zero upper 32-bits.
> >
> > For example, a 128GB address space starting at
> > physical CPU address of 0x2000000000 with size of
> > 0x2000000000 needs the following values programmed
> > into the lower and upper 32-bit limit registers:
> >  0x3fffffff in the upper 32-bit limit register
> >  0xffffffff in the lower 32-bit limit register
> >
> > Currently, only the lower 32-bit limit register is
> > programmed with a value of 0xffffffff but the upper
> > 32-bit limit register is not being programmed.
> > As a result, the upper 32-bit limit register remains
> > at its default value after reset of 0x0. This would
> > be a problem for a 128GB PCIe space because in
> > effect its size gets reduced to 4GB.
> >
> > ATU programming functions can be changed to
> > specify a u64 size parameter for the translated
> > region. Along with this change, the internal
> > calculation of the limit address, the address of
> > the last byte in the translated region, needs to
> > change such that both the lower 32-bit and upper
> > 32-bit limit registers can be programmed correctly.
> >
> > Changing the ATU programming functions is high
> > impact. Without change, this issue can go
> > unnoticed. A warning may prompt the user to
> > look into possible issues.
>
> So this is basically a warning, and we could actually *fix* the
> problem with more effort?  I vote for the fix.

The fix would impact all PCIe drivers that depend on dwc.
I would have no way of validating such a fix without
breaking it for everyone let alone the bandwidth it needs.
All drivers that depend on dwc seem to be currently happy
with the u32 size limit. I suggest we add the warning but
keep this issue in mind for a solution that allows existing
PCe drivers to phase into the fix on their own individual
schedules, if they need to.

>
> > This limitation also means that multiple ATUs
> > would need to be used to map larger regions.
> >
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 395feb8ca051..37a8c71ef89a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -325,6 +325,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       struct pci_bus *child;
> >       struct pci_host_bridge *bridge;
> >       struct resource *cfg_res;
> > +     resource_size_t mem_size;
> >       u32 hdr_type;
> >       int ret;
> >
> > @@ -362,7 +363,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >               case IORESOURCE_MEM:
> >                       pp->mem = win->res;
> >                       pp->mem->name = "MEM";
> > -                     pp->mem_size = resource_size(pp->mem);
> > +                     mem_size = resource_size(pp->mem);
> > +                     if (upper_32_bits(mem_size))
> > +                             dev_warn(dev, "MEM resource size too big\n");
> > +                     pp->mem_size = mem_size;
> >                       pp->mem_bus_addr = pp->mem->start - win->offset;
> >                       break;
> >               case 0:
> > --
> > 2.7.4
> >
