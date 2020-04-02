Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2532E19B95C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbgDBAFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 20:05:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42877 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733060AbgDBAFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 20:05:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id s13so1214927lfb.9
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbToDyfvISc0MzdSRiZMdo2xILcDDxUI1mnFelsEDqQ=;
        b=LhCJsl1ZVXkiiIaRr7trZvle/wKMDu6R1ix6l2+VcimCvMksOWsbf+l/PtbMXtJ8v2
         sBNoLpvThmCkpWgEBwz7/3tB2h1PW7GguOPp8ERH8ltg0Zjr3Yf2MSlmXICXAtUFTyLw
         30JJukxFnhYXHNKCnsqG7hVk04lBbvKt7VBEk1mBFCVAJs8nD7B7dAcaac4iBkIbm2KL
         DPe84t0uxAfvrCzlhxUYzPh3wQUHHW+nOhXwalmGsjTBgjwmp5zPoMJ1ZDdLr8LRLw6H
         VFbfIUzWVc6pLlbnXKeOEBEFan5KSXRlDPB7kSCiVrkrd4l4kcXQQEfEsf7Jt6Bz/OVb
         FWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbToDyfvISc0MzdSRiZMdo2xILcDDxUI1mnFelsEDqQ=;
        b=NSfI1euJbGsuFCDr+hqulfrYb10LAvG3ah2d5fpDc3Kbwy0IhkZ2sutQxBgVlBDDYN
         TRPTsXd2G6Oe0PFDEsGmr7saWFy8h4Y6AsxfRq5hqTgyDDWt0xrZt1eKw5Qz8ym47ZU6
         Lh4qGH8mqMebcpsEVO1RMF7T7Twunms+yVy1sMMtgv91lEOOfLajLDwpZricDyCkold8
         ss7yWIpx6U93pfptEZno3VvervkQ87t29aqlcfeSsyamimc/u5Xibv0/Pb/WZOpM+769
         WPDDU5hHnKk46u8P8ObtUdm+Hy3QzOhzWznUfXbTDqpXxwLCd9UCFlQKHVEUp00QJquS
         zbHw==
X-Gm-Message-State: AGi0PubjcaTzP4FnFeJ64opq+afffHwuzDAuZia+YrVy6zJTL4h6IHMv
        77dRqv5bB7Lu7R4ZtCVvywjaSXVpVB90lW+moayXlQ==
X-Google-Smtp-Source: APiQypJHwJ0enCR4HaS8q1uSgcIrkO2prI5+GV2q0nCYRVW7wbZgxHI2ld7yaYHAW9Cx0KGA3Eie4eFU2CzvD8jRPnQ=
X-Received: by 2002:ac2:545a:: with SMTP id d26mr419914lfn.85.1585785900862;
 Wed, 01 Apr 2020 17:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABEDWGzfTDtmq==j-GcK3YYbdPX4-Ms=PDuDEiQusV78bUGvDA@mail.gmail.com>
 <20200401202937.GA130497@google.com> <CABEDWGxTifrvYVF7B2geN7K4Uhor-JcHK95L60T_xQar4XTqBQ@mail.gmail.com>
 <CABEDWGxaZMZxkpG1kQX4kKvgv-sJzvKtgyvhuJLSTEzqp50LNw@mail.gmail.com>
In-Reply-To: <CABEDWGxaZMZxkpG1kQX4kKvgv-sJzvKtgyvhuJLSTEzqp50LNw@mail.gmail.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 1 Apr 2020 17:04:49 -0700
Message-ID: <CABEDWGz44DXbhmrOHcp+ZepyK-MmtCSuL1dPbo39+pCt0aQqPA@mail.gmail.com>
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

On Wed, Apr 1, 2020 at 3:02 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> On Wed, Apr 1, 2020 at 2:01 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
> >
> > On Wed, Apr 1, 2020 at 1:29 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Tue, Mar 31, 2020 at 01:36:04PM -0700, Alan Mikhak wrote:
> > > > On Tue, Mar 31, 2020 at 1:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Mon, Mar 30, 2020 at 05:19:47PM -0700, Alan Mikhak wrote:
> > > > > > Output a warning for MEM resource size with
> > > > > > non-zero upper 32-bits.
> > > > > >
> > > > > > ATU programming functions limit the size of
> > > > > > the translated region to 4GB by using a u32 size
> > > > > > parameter. Function dw_pcie_prog_outbound_atu()
> > > > > > does not program the upper 32-bit ATU limit
> > > > > > register. This may result in undefined behavior
> > > > > > for resource sizes with non-zero upper 32-bits.
> > > > > >
> > > > > > For example, a 128GB address space starting at
> > > > > > physical CPU address of 0x2000000000 with size of
> > > > > > 0x2000000000 needs the following values programmed
> > > > > > into the lower and upper 32-bit limit registers:
> > > > > >  0x3fffffff in the upper 32-bit limit register
> > > > > >  0xffffffff in the lower 32-bit limit register
> > > > > >
> > > > > > Currently, only the lower 32-bit limit register is
> > > > > > programmed with a value of 0xffffffff but the upper
> > > > > > 32-bit limit register is not being programmed.
> > > > > > As a result, the upper 32-bit limit register remains
> > > > > > at its default value after reset of 0x0. This would
> > > > > > be a problem for a 128GB PCIe space because in
> > > > > > effect its size gets reduced to 4GB.
> > > > > >
> > > > > > ATU programming functions can be changed to
> > > > > > specify a u64 size parameter for the translated
> > > > > > region. Along with this change, the internal
> > > > > > calculation of the limit address, the address of
> > > > > > the last byte in the translated region, needs to
> > > > > > change such that both the lower 32-bit and upper
> > > > > > 32-bit limit registers can be programmed correctly.
> > > > > >
> > > > > > Changing the ATU programming functions is high
> > > > > > impact. Without change, this issue can go
> > > > > > unnoticed. A warning may prompt the user to
> > > > > > look into possible issues.
> > > > >
> > > > > So this is basically a warning, and we could actually *fix* the
> > > > > problem with more effort?  I vote for the fix.
> > > >
> > > > The fix would impact all PCIe drivers that depend on dwc.
> > >
> > > Is that another way of saying "the fix would *fix* all the drivers
> > > that depend on dwc"?
> >
> > Thanks Bjorn for your comments.
> >
> > Not at all. I'm not suggesting that. I'm just stating the dilemma.
> >
> > One option is, as you may be alluding, the *fix* would include
> > modification to all drivers that depend on dwc to at least not break
> > the build.. Whoever embarks on such a *fix* would have to take
> > that on before submitting the patch.
> >
> > Another option is to produce an alternate ATU programming
> > API for the Linux PCI sub-system to support u64 size. That
> > way individual driver owners can choose if and when to migrate
> > their drivers to the new API on their own timeline. Such an
> > alternative API can also be generic to support not only
> > Designware PCIe controllers but others.
> >
> > >
> > > > I would have no way of validating such a fix without
> > > > breaking it for everyone let alone the bandwidth it needs.
> > > > All drivers that depend on dwc seem to be currently happy
> > > > with the u32 size limit. I suggest we add the warning but
> > > > keep this issue in mind for a solution that allows existing
> > > > PCe drivers to phase into the fix on their own individual
> > > > schedules, if they need to.
> > >
> > > Obviously it would *nice* to test all the drivers that depend on dwc,
> > > but if you're fixing a problem, you verify the fix on your system, and
> > > the relevant people review it, I don't think exhaustive testing is a
> > > hard requirement, and I certainly wouldn't expect you to do it.
> >
> > That is a relief for whoever commits to take this on.
> >
> > >
> > > If we want to live with a 32-bit limit, I think we should change the
> > > relevant interfaces to use u32 so there's not a way to venture into
> > > this region of undefined behavior.  I don't think "warning + undefined
> > > behavior" is a very maintainable situation.
> >
> > I cannot live with the 32-bit limit. I need a 64-bit solution. I had
> > to implement a solution that suits my needs. I have worked
> > out some of the issue. It is generic enough for my use with PCIe
> > controllers from more than one vendor. But, it requires pulling a
> > lot of code from Designware layer into a separate framework
> > which I believe can become common for Linux PCI subsystem.
> > If it gets in, others who need 64-bit can migrate over to it without
> > being migrated involuntarily.
> >
>
> The "undefined" behavior part of the problem can be fixed
> separately in the function dw_pcie_prog_outbound_atu_unroll()
> by modifying its internal calculation of the limit address and
> programming the ATU upper limit address register.
>
> With the above fix in dw_pcie_prog_outbound_atu_unroll(),
> the total problem reduces to the size issued being reduced
> to 4G max.
>

Bjorn,

Thinking about your comment, I decided to submit a separate
patch to fix the "undefined" behavior portion of these issues by
modifying dw_pcie_prog_outbound_atu_unroll(). Would the warning
plus the patch for dw_pcie_prog_outbound_atu_unroll() make
the remaining 32-bit size limit issue more maintainable?

Regards,
Alan

> > >
> > > > > > This limitation also means that multiple ATUs
> > > > > > would need to be used to map larger regions.
> > > > > >
> > > > > > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
> > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index 395feb8ca051..37a8c71ef89a 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -325,6 +325,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > > > >       struct pci_bus *child;
> > > > > >       struct pci_host_bridge *bridge;
> > > > > >       struct resource *cfg_res;
> > > > > > +     resource_size_t mem_size;
> > > > > >       u32 hdr_type;
> > > > > >       int ret;
> > > > > >
> > > > > > @@ -362,7 +363,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > > > >               case IORESOURCE_MEM:
> > > > > >                       pp->mem = win->res;
> > > > > >                       pp->mem->name = "MEM";
> > > > > > -                     pp->mem_size = resource_size(pp->mem);
> > > > > > +                     mem_size = resource_size(pp->mem);
> > > > > > +                     if (upper_32_bits(mem_size))
> > > > > > +                             dev_warn(dev, "MEM resource size too big\n");
> > > > > > +                     pp->mem_size = mem_size;
> > > > > >                       pp->mem_bus_addr = pp->mem->start - win->offset;
> > > > > >                       break;
> > > > > >               case 0:
> > > > > > --
> > > > > > 2.7.4
> > > > > >
