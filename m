Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1949544B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 19:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347048AbiATSkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 13:40:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59674 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346978AbiATSkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 13:40:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96E12B81E05;
        Thu, 20 Jan 2022 18:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A8BC340E3;
        Thu, 20 Jan 2022 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642704019;
        bh=3hOpLWRBY9cHHOmcyAbJ95mmCdfVcMmLJ9hEzU1QGr8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iuy7vdiqq62okwRM3xtqhd+rqybWWzYYuqm4jNuNN1yACWWwImg2QwJktgGZQ+hwI
         rqGxUNRfnuJxvyjOZnLYFS5l0Fr3dLP5iZn3IpaJtIUo69/+1pv3VWZFnGg0pjEfrg
         9LgaNUJI2U1TjPvyGzxTBTHtM3lS1zx2LUYCxERFujaY64yKNzsG9lAWc1zRcxrlUU
         mdGuc1nWYdvr82eKCJ3z+mlxR6mK6pg8nIlHkgw8l9WGwQ2cjBRmPaBaRclLRma47Q
         OmHpwRHIg2i1lJU8x03xQ/XL+RC4PQm9BN9KvtbGsZh1UpW6LYOUcNeKStd9reIuQm
         /CtmjBYaS9a9A==
Received: by mail-ed1-f48.google.com with SMTP id r10so1536670edt.1;
        Thu, 20 Jan 2022 10:40:19 -0800 (PST)
X-Gm-Message-State: AOAM531R2/BX1aLqVuyni34DMqGqkqE8J4uj0dZHhSsPhbmHThuStioi
        tO8UlarswnPU3XrF66wB9VSFA0yeVhDMqzV8qw==
X-Google-Smtp-Source: ABdhPJzz7/BlVmNumwwPk+wbTtOxgNZu8/gsMqY7Y0iMYVCeOZu2LKuPqdM97ZlmghXoyGaEGscqg+6agoLtb/FCKgw=
X-Received: by 2002:aa7:da81:: with SMTP id q1mr420456eds.280.1642704017630;
 Thu, 20 Jan 2022 10:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20220105150239.9628-1-pali@kernel.org> <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-9-pali@kernel.org> <YemSgTfl7NiTfcKc@robh.at.kernel.org>
 <20220120165522.v2xitzokcom4phmw@pali>
In-Reply-To: <20220120165522.v2xitzokcom4phmw@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Jan 2022 12:40:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJS=V3qVCzmN0r9yOQNXZcsFgvneySqPy_CXYKsyzUK0g@mail.gmail.com>
Message-ID: <CAL_JsqJS=V3qVCzmN0r9yOQNXZcsFgvneySqPy_CXYKsyzUK0g@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] PCI: mvebu: Use child_ops API
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 10:55 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Thursday 20 January 2022 10:49:05 Rob Herring wrote:
> > On Wed, Jan 12, 2022 at 04:18:11PM +0100, Pali Roh=C3=A1r wrote:
> > > Split struct pci_ops between ops and child_ops. Member ops is used fo=
r
> > > accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops =
for
> > > accessing real PCIe cards.
> > >
> > > There is no need to mix these two struct pci_ops into one as PCI core=
 code
> > > already provides separate callbacks via bridge->ops and bridge->child=
_ops.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-mvebu.c | 82 ++++++++++++++++------------=
--
> > >  1 file changed, 44 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/control=
ler/pci-mvebu.c
> > > index 9ea2f6a7c2b0..1e90ab888075 100644
> > > --- a/drivers/pci/controller/pci-mvebu.c
> > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > @@ -294,11 +294,29 @@ static void mvebu_pcie_setup_hw(struct mvebu_pc=
ie_port *port)
> > >     mvebu_writel(port, mask, PCIE_MASK_OFF);
> > >  }
> > >
> > > -static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
> > > -                            struct pci_bus *bus,
> > > -                            u32 devfn, int where, int size, u32 *val=
)
> > > +static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pci=
e *pcie,
> > > +                                               struct pci_bus *bus,
> > > +                                               int devfn);
> > > +
> > > +static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, =
int where,
> > > +                               int size, u32 *val)
> > >  {
> > > -   void __iomem *conf_data =3D port->base + PCIE_CONF_DATA_OFF;
> > > +   struct mvebu_pcie *pcie =3D bus->sysdata;
> > > +   struct mvebu_pcie_port *port;
> > > +   void __iomem *conf_data;
> > > +
> > > +   port =3D mvebu_pcie_find_port(pcie, bus, devfn);
> > > +   if (!port) {
> > > +           *val =3D 0xffffffff;
> > > +           return PCIBIOS_DEVICE_NOT_FOUND;
> > > +   }
> > > +
> > > +   if (!mvebu_pcie_link_up(port)) {
> > > +           *val =3D 0xffffffff;
> > > +           return PCIBIOS_DEVICE_NOT_FOUND;
> > > +   }
> > > +
> > > +   conf_data =3D port->base + PCIE_CONF_DATA_OFF;
> > >
> > >     mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
> > >                  PCIE_CONF_ADDR_OFF);
> > > @@ -321,11 +339,21 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_p=
cie_port *port,
> > >     return PCIBIOS_SUCCESSFUL;
> > >  }
> > >
> > > -static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
> > > -                            struct pci_bus *bus,
> > > -                            u32 devfn, int where, int size, u32 val)
> > > +static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
> > > +                               int where, int size, u32 val)
> > >  {
> > > -   void __iomem *conf_data =3D port->base + PCIE_CONF_DATA_OFF;
> > > +   struct mvebu_pcie *pcie =3D bus->sysdata;
> > > +   struct mvebu_pcie_port *port;
> > > +   void __iomem *conf_data;
> > > +
> >
> > > +   port =3D mvebu_pcie_find_port(pcie, bus, devfn);
> > > +   if (!port)
> > > +           return PCIBIOS_DEVICE_NOT_FOUND;
> > > +
> > > +   if (!mvebu_pcie_link_up(port))
> > > +           return PCIBIOS_DEVICE_NOT_FOUND;
> > > +
> > > +   conf_data =3D port->base + PCIE_CONF_DATA_OFF;
> >
> > Again, the same setup code in read and write is a sign to use
> > .map_bus(). You can copy it from my version I pointed you to.
> >
> > Rob
>
> I'm planning to do other cleanup in followup patches. But there are too
> many mvebu and aardvark patches on the list waiting, and I do not want
> to send another batch.

It can all be part of this patch.

Rob
