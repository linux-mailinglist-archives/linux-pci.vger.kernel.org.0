Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC127DB5D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 00:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgI2WFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 18:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgI2WFB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 18:05:01 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3EF21707
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601417100;
        bh=gr+yVYr0Sl4GMl1N4skHLcJyeSqKKKYU6g2ajzLcwlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ExW/TGW1leHeiEWE/h7OHYoUyi3ABqGJWAtY0Tx+HyURl5xQzk846uyuw2gwbMAPI
         F9V41a3PorEJ8szaXYNcZadLPzDohanMK9RArhP1ol7QrWAAWL69UyN8cvvIMzA/kD
         jQl2JlMnxdPHLe98Kce+UE92qjvJwjbDh0e3dblE=
Received: by mail-oi1-f181.google.com with SMTP id c13so7240814oiy.6
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 15:05:00 -0700 (PDT)
X-Gm-Message-State: AOAM531ok8WdQLJdmQq9NOGSHKXveBBbN8Dvpb87d8QJiCoSoCGSyr+U
        1GCpC2Ri/+lzRoPBC68lIyXpSkVBE2acGf1tJw==
X-Google-Smtp-Source: ABdhPJy7HFSkLbBUm1iGn3/cO4830XaBZgr25Eags1ho3JFqEZMBiYnBZWJoUq2nzONzsiymyBLAEHfF5AsS3XocfSU=
X-Received: by 2002:aca:7543:: with SMTP id q64mr4024058oic.147.1601417099365;
 Tue, 29 Sep 2020 15:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200925211513.1701254-1-kw@linux.com> <20200929202331.GA2567309@bjorn-Precision-5520>
In-Reply-To: <20200929202331.GA2567309@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 17:04:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+7QHzMcZ1aJW36fX99-dveJAxML9_DQtaavAGjxun9Lw@mail.gmail.com>
Message-ID: <CAL_Jsq+7QHzMcZ1aJW36fX99-dveJAxML9_DQtaavAGjxun9Lw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Unify ECAM constants in native PCI Express drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 3:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 25, 2020 at 09:15:13PM +0000, Krzysztof Wilczy=C5=84ski wrote=
:
> > Unify ECAM-related constants into a single set of standard constants
> > defining memory address shift values for the byte-level address that ca=
n
> > be used when accessing the PCI Express Configuration Space, and then
> > move native PCI Express controller drivers to use newly introduced
> > definitions retiring any driver-specific ones.
> >
> > The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> > PCI Express specification (see PCI Base Specification, Revision 5.0,
> > Version 1.0, Section 7.2.2, p. 676), thus most hardware should implemen=
t
> > it the same way.  Most of the native PCI Express controller drivers
> > define their ECAM-related constants, many of these could be shared, or
> > use open-coded values when setting the .bus_shift field of the struct
> > pci_ecam_ops.
> >
> > All of the newly added constants should remove ambiguity and reduce the
> > number of open-coded values, and also correlate more strongly with the
> > descriptions in the aforementioned specification (see Table 7-1
> > "Enhanced Configuration Address Mapping", p. 677).
> >
> > There is no change to functionality.
>
> I like this a lot.  A few minor comments below.
>
> > --- a/drivers/pci/controller/dwc/pcie-al.c
> > +++ b/drivers/pci/controller/dwc/pcie-al.c
> > @@ -76,7 +76,7 @@ static int al_pcie_init(struct pci_config_window *cfg=
)
> >  }
> >
> >  const struct pci_ecam_ops al_pcie_ops =3D {
> > -     .bus_shift    =3D 20,
> > +     .bus_shift    =3D PCIE_ECAM_BUS_SHIFT,
> >       .init         =3D  al_pcie_init,
> >       .pci_ops      =3D {
> >               .map_bus    =3D al_pcie_map_bus,
> > @@ -138,8 +138,6 @@ struct al_pcie {
> >       struct al_pcie_target_bus_cfg target_bus_cfg;
> >  };
> >
> > -#define PCIE_ECAM_DEVFN(x)           (((x) & 0xff) << 12)
> > -
> >  #define to_al_pcie(x)                dev_get_drvdata((x)->dev)
> >
> >  static inline u32 al_pcie_controller_readl(struct al_pcie *pcie, u32 o=
ffset)
> > @@ -228,7 +226,7 @@ static void __iomem *al_pcie_conf_addr_map(struct a=
l_pcie *pcie,
> >       void __iomem *pci_base_addr;
> >
> >       pci_base_addr =3D (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> > -                                      (busnr_ecam << 20) +
> > +                                      PCIE_ECAM_BUS(busnr_ecam) +
> >                                        PCIE_ECAM_DEVFN(devfn));
>
> Apparently this driver lets you limit the number of buses, since it
> does:
>
>   unsigned int busnr_ecam =3D busnr & target_bus_cfg->ecam_mask;
>
> I'm not entirely sure I believe that, but OK.  It's a shame because
> it would be really nice to be able to use PCIE_ECAM_OFFSET() here
> (with a little rework of the al_pcie_conf_addr_map() interface).

It's a bit different than that. It allows for a config window less
than 256MB and will reconfigure the window when the bus number is
outside the window. There's no dts upstream so who knows what the
normal case is. For all I know, Amazon could be using generic ECAM
driver now or only ACPI (note that another oddity is the root bridge
accesses go thru the DBI interface where as other DWC implementations
using generic ECAM use the ECAM space). Maybe Jonathan Chocron can
comment.

I think limiting the bus numbers based on the size of the config
window would have been better and that's aligned with what the generic
ECAM driver does.

Rob
