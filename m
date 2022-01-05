Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6E48560B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbiAEPmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:42:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45030 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiAEPmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:42:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2523B81C13;
        Wed,  5 Jan 2022 15:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74594C36AE0;
        Wed,  5 Jan 2022 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641397324;
        bh=GKAQ42RZcdIIQCU3yp/+Sv3dVSkX4wU6K9fG42E3/sQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tr24Vi/ZRTDrbc3akawKgrama59YeUezddflSt+YoYZkifCc3g8bnkdbdkquvsv4+
         RTeGFD5Jti5CrYVDsLQbULCeKKuO4mzFcqVeZfXhfHpv5i/P68VvANYVzJW/hSoNDZ
         zkCs/CA9I2W8inBNmGCyLW9+Lo/HpdOzIOa27Lsk9JYmiT6RTP5oClJrhVSrJAT+Vo
         Ceo8Q6jg9AoeJKQDnw9YB9SR3HwgHdqGNs1fdiT8OM0ouZt5HVtvHqwg69+zmEI8lI
         r0Y8B0yq3BrpCk5U+1kyU7xA1UlYEYiY1cyxGFTw7iBR62OcF8gixchUM3piiMIBfB
         ScqPE0GA34klw==
Received: by mail-ed1-f46.google.com with SMTP id j6so163571022edw.12;
        Wed, 05 Jan 2022 07:42:04 -0800 (PST)
X-Gm-Message-State: AOAM533YBeFiP0Tiy3tEOZ3/QqvzIUdzxmoW1h5a22vI2bSfXWAKqfnG
        iQi+zLgziV3931P9+TP42rxXJmyhH+7+h1eWZA==
X-Google-Smtp-Source: ABdhPJwSTFNkL54cksD1y2ff7+zMlmVqgaahzlxZU86O4ZotYRJ6oJLBDkT3nMMfJ8/zPYxf0Xq+7PbpQdFcqCTVfA0=
X-Received: by 2002:aa7:dc05:: with SMTP id b5mr52817117edu.46.1641397322789;
 Wed, 05 Jan 2022 07:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20220105150239.9628-1-pali@kernel.org> <20220105150239.9628-9-pali@kernel.org>
In-Reply-To: <20220105150239.9628-9-pali@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 5 Jan 2022 09:41:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1hoAUVOzyOGZ1vVMsChhHJJpzk5HNU4Gi=Luy_8LArA@mail.gmail.com>
Message-ID: <CAL_Jsq+1hoAUVOzyOGZ1vVMsChhHJJpzk5HNU4Gi=Luy_8LArA@mail.gmail.com>
Subject: Re: [PATCH 08/11] PCI: mvebu: Use child_ops API
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

On Wed, Jan 5, 2022 at 9:03 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Split struct pci_ops between ops and child_ops. Member ops is used for
> accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops for
> accessing real PCIe cards.
>
> There is no need to mix these two struct pci_ops into one as PCI core cod=
e
> already provides separate callbacks via bridge->ops and bridge->child_ops=
.

I had similar patches including mvebu that I never got around to
sending out. I pushed the branch out now at least[1].

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-mvebu.c | 82 ++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/=
pci-mvebu.c
> index 9ea2f6a7c2b0..1e90ab888075 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -294,11 +294,29 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_p=
ort *port)
>         mvebu_writel(port, mask, PCIE_MASK_OFF);
>  }
>
> -static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
> -                                struct pci_bus *bus,
> -                                u32 devfn, int where, int size, u32 *val=
)
> +static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *p=
cie,
> +                                                   struct pci_bus *bus,
> +                                                   int devfn);
> +
> +static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int =
where,
> +                                   int size, u32 *val)
>  {
> -       void __iomem *conf_data =3D port->base + PCIE_CONF_DATA_OFF;
> +       struct mvebu_pcie *pcie =3D bus->sysdata;
> +       struct mvebu_pcie_port *port;
> +       void __iomem *conf_data;
> +
> +       port =3D mvebu_pcie_find_port(pcie, bus, devfn);
> +       if (!port) {
> +               *val =3D 0xffffffff;
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +       }
> +
> +       if (!mvebu_pcie_link_up(port)) {
> +               *val =3D 0xffffffff;
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +       }
> +
> +       conf_data =3D port->base + PCIE_CONF_DATA_OFF;
>
>         mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
>                      PCIE_CONF_ADDR_OFF);
> @@ -321,11 +339,21 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_=
port *port,
>         return PCIBIOS_SUCCESSFUL;
>  }
>
> -static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
> -                                struct pci_bus *bus,
> -                                u32 devfn, int where, int size, u32 val)
> +static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
> +                                   int where, int size, u32 val)
>  {
> -       void __iomem *conf_data =3D port->base + PCIE_CONF_DATA_OFF;
> +       struct mvebu_pcie *pcie =3D bus->sysdata;
> +       struct mvebu_pcie_port *port;
> +       void __iomem *conf_data;
> +
> +       port =3D mvebu_pcie_find_port(pcie, bus, devfn);
> +       if (!port)
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       if (!mvebu_pcie_link_up(port))
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       conf_data =3D port->base + PCIE_CONF_DATA_OFF;

The same code in read and write is a hint to use .map_bus().

>
>         mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
>                      PCIE_CONF_ADDR_OFF);
> @@ -347,6 +375,11 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_p=
ort *port,
>         return PCIBIOS_SUCCESSFUL;
>  }
>
> +static struct pci_ops mvebu_pcie_child_ops =3D {
> +       .read =3D mvebu_pcie_child_rd_conf,
> +       .write =3D mvebu_pcie_child_wr_conf,
> +};
> +
>  /*
>   * Remove windows, starting from the largest ones to the smallest
>   * ones.
> @@ -862,25 +895,12 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, =
u32 devfn,
>  {
>         struct mvebu_pcie *pcie =3D bus->sysdata;
>         struct mvebu_pcie_port *port;
> -       int ret;
>
>         port =3D mvebu_pcie_find_port(pcie, bus, devfn);
>         if (!port)
>                 return PCIBIOS_DEVICE_NOT_FOUND;

It would be nice to go from 'bus' to 'bridge' ptr directly, but I
still had this in my version. I guess a standard RP struct as part of
decoupling host bridges from RPs would solve this issue.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=
=3Dpci-child-bus-ops
