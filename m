Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524F2275E88
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWRXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 13:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIWRXu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 13:23:50 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B33F221F0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600881829;
        bh=730KdbTlfAh6bLWtoHtsz8yH6kRXQvyGVrEQq7gSANU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NYwzNX8cDLPLw28QKKLAMaSEmE4trXAkB+v3qLNlHcmSoMjQorgFg/WGV9b+M/k1A
         OVZO8rOgYBw1HNxTQHRKi7RO90FVD9vfWfbz63NPR/Cl/31J70UcF30ocGzLzx7RuN
         KYFT/k4oLeZ8VQvnAw+qq/kVyxY/bL8tNNy4CL8s=
Received: by mail-ot1-f54.google.com with SMTP id o8so494867otl.4
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 10:23:49 -0700 (PDT)
X-Gm-Message-State: AOAM530jotxRtg6yy603yYpy3qP1Ra8guXBgvJ8Ka9I/TBj5hrzLgbda
        VLFcr/3CiFshPe5KGGaPxiOYjICNWMGFaLqk7w==
X-Google-Smtp-Source: ABdhPJxUtzwTOVGogBCfk3/mDj7n+lJEHqswrMVz+ppffanPQR9H7uxwnTsaqk3Xj43eCclj08B5LLHvpJt3+Qf+o1c=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr489792otp.129.1600881828244;
 Wed, 23 Sep 2020 10:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200905204416.GA83847@rocinante> <20200922232715.GA2238688@bjorn-Precision-5520>
In-Reply-To: <20200922232715.GA2238688@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Sep 2020 11:23:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKs2m_echD97C+Q_NFS=yJif0LcgLMdDLnywjz35mboKQ@mail.gmail.com>
Message-ID: <CAL_JsqKs2m_echD97C+Q_NFS=yJif0LcgLMdDLnywjz35mboKQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Unify ECAM constants in native PCI Express drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        PCI <linux-pci@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Robert Richter <rrichter@marvell.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 5:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rob, who's doing a lot of cleanup in these drivers]
>
> On Sat, Sep 05, 2020 at 10:44:16PM +0200, Krzysztof Wilczy=C5=84ski wrote=
:
> > Hello Jonathan,
> >
> > Thank you for the review!  Also, apologies for late reply.
> >
> > On 20-08-28 10:08:43, Jonathan Cameron wrote:
> > [...]
> > >
> > > Might potentially be worth tidying up the masks as well?
> > > Or potentially drop them given I suspect that there are no cases
> > > in which the mask is actually doing anything...
> >
> > Just to confirm - you have the following constants in mind?
> >
> > drivers/pci/controller/pcie-rockchip.h:
> >
> > #define PCIE_ECAM_BUS(x)      (((x) & 0xff) << 20)
> > #define PCIE_ECAM_DEV(x)      (((x) & 0x1f) << 15)
> > #define PCIE_ECAM_FUNC(x)     (((x) & 0x7) << 12)
> >
> > drivers/pci/controller/dwc/pcie-al.c:
> >
> > #define PCIE_ECAM_DEVFN(x)    (((x) & 0xff) << 12)
> >
> > I can move PCIE_ECAM_BUS, PCIE_ECAM_DEV and PCIE_ECAM_FUNC (as
> > PCIE_ECAM_FUN) to the linux/pci-ecam.h file, as these seem useful, but
> > without the masks, and then update other files to use these.  We could
> > then leverage these, for example:
> >
> >       pci_base_addr =3D (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> > -                                      (busnr_ecam << 20) +
> > -                                      PCIE_ECAM_DEVFN(devfn));
> > +                                      PCIE_ECAM_BUS(busnr_ecam) +
> > +                                      PCIE_ECAM_FUN(devfn));
> >
> > What do you think?  Bjorn, would that be acceptable?
>
> It would be nice to use the same style and same macros for all of
> the following, which are all really doing the same thing:
>
>   al_pcie_conf_addr_map()
>     pci_base_addr =3D (void __iomem *)((uintptr_t)pp->va_cfg0_base +
>                                      (busnr_ecam << 20) +
>                                      PCIE_ECAM_DEVFN(devfn));
>
>   rockchip_pcie_rd_other_conf()
>     busdev =3D PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
>                             PCI_FUNC(devfn), where);
>
>   nwl_pcie_map_bus()
>     relbus =3D (bus->number << ECAM_BUS_LOC_SHIFT) |
>                     (devfn << ECAM_DEV_LOC_SHIFT);
>
>     return pcie->ecam_base + relbus + where;
>
>   xilinx_pcie_map_bus()
>     relbus =3D (bus->number << ECAM_BUS_NUM_SHIFT) |
>              (devfn << ECAM_DEV_NUM_SHIFT);
>
>     return port->reg_base + relbus + where;
>
> Maybe that's something like using PCIE_ECAM_ADDR() everywhere?  I'm
> not sure there's value in having the caller do the PCI_SLOT() and
> PCI_FUNC() decomposition, though, i.e., maybe it's something like
> this?
>
>   #define PCIE_ECAM_REG(x)  ((x) & 0xfff)
>
>   #define PCI_ECAM_OFFSET(bus, devfn, where) \
>     PCIE_ECAM_BUS(bus->number) | \
>     PCIE_ECAM_DEVFN(devfn) | \
>     PCIE_ECAM_REG(where)

LGTM. This was on my radar, but not something I've looked at.

There's also aardvark which isn't ECAM, but does the same calculation.
Call it indirect ECAM:

drivers/pci/controller/pci-aardvark.c:#define PCIE_CONF_BUS(bus)
                 (((bus) & 0xff) << 20)
drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_DEV(dev)
                 (((dev) & 0x1f) << 15)
drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_FUNC(fun)
                 (((fun) & 0x7)  << 12)
drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_REG(reg)
                 ((reg) & 0xffc)
drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_ADDR(bus,
devfn, where) \
drivers/pci/controller/pci-aardvark.c-  (PCIE_CONF_BUS(bus) |
PCIE_CONF_DEV(PCI_SLOT(devfn))    | \
drivers/pci/controller/pci-aardvark.c-
PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))

And VMD:
drivers/pci/controller/vmd.c-   char __iomem *addr =3D vmd->cfgbar +
drivers/pci/controller/vmd.c:                        ((bus->number -
vmd->busn_start) << 20) +
drivers/pci/controller/vmd.c-                        (devfn << 12) + reg;
drivers/pci/controller/vmd.c-


And brcm_pcie_cfg_index().

Rob
