Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE801428E5
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgATLKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 06:10:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34147 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgATLKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2020 06:10:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so29103197wrr.1;
        Mon, 20 Jan 2020 03:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XxjuYsKUbDiz7eFcRRQZbuZAsY8EPgVG4WEacTDhas0=;
        b=LJd3ubrDA1YYnW0VwxOlRBHvCGTdtfIP4ItiHLy+GvrIWi7YsinM4uitzU1KHQQAzc
         1Q5YX6vdqVIHPC4FFtcVqHAE7Ik6TvBHlthI8WiC6NjMHHSLSH0i6J7Jhx7CJ4eBTQKB
         6/+Pl+D9VVa5tNVh/F9urbxjy+oN9qUHDk0jUns3haf8Hhgw+4E6ZwgNMXV+5xWPXtIt
         wvxc7Z/P2YhgtxvSuIS8dLShlS8horpvo+wdZp4umZXWBQxELzfD/PDBY4hHCvrZClN7
         0HMMTi1hVlh49R34rvjtBqzD3YlC/oy1tV62/lHrMNVNfhJUN4BALhP7SdG73Zu8YtRJ
         emDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XxjuYsKUbDiz7eFcRRQZbuZAsY8EPgVG4WEacTDhas0=;
        b=SZHeFTT4+ZendNfkBf4fPKMjbWw+/E7ejPLye+EUUIO6Pdk4H7NZPQxlxaYtksog2P
         /zgqPb8JdvTXBQLJAjaFzhjqULewliSSYBz+UMrWRDsWt3j9Yg+oapoVGkqQBimhTTqe
         QSGHRWqOmEPmlKL8tMzGwtLx9cWs5SCOcYlcPl2j29CBWAVW/eD1lTXAd95UdRyzKNvt
         K3HZ0DpYLC6q8s3xXJyW+XHviziqB56QFCgTfryrKDScz1/wh/8dqQIqu/sqbqvhi/Qr
         AsrzgNMR576UgiLmGOLwtcWGyOWfFFgtirj08IpQCIhjXnpfaV+1nFZKWBDYzFwYgIsi
         Oy2w==
X-Gm-Message-State: APjAAAUC56pW0h0H8TMQNqAKKiwHnNbzlQaEjAT9M8vprUJBCpJonxYQ
        HI09GblQF+uYKUDUDs07AaY=
X-Google-Smtp-Source: APXvYqyl4ylVdF+AiTxNgXdRo5YR4lcqdNlGfGwTAN9f+WZTAmstUFIYW9x1D19J+9wxzTq3XXROzQ==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr17055902wrm.13.1579518644845;
        Mon, 20 Jan 2020 03:10:44 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id l6sm22504947wmf.21.2020.01.20.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:10:43 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:10:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bjorn@helgaas.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200120111042.GA203160@ulmo>
References: <20200103174935.5612-1-vidyas@nvidia.com>
 <CABhMZUUHGEEhsJ-+foSsodqtKXyX5ZNPkGgv_VzXz=Qv+NVcUA@mail.gmail.com>
 <9a767725-9671-6402-4e1c-a648f5a7860b@nvidia.com>
 <20200117121736.GA7072@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20200117121736.GA7072@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 12:17:37PM +0000, Lorenzo Pieralisi wrote:
> On Sat, Jan 04, 2020 at 09:14:42AM +0530, Vidya Sagar wrote:
> > On 1/3/2020 11:34 PM, Bjorn Helgaas wrote:
> > > External email: Use caution opening links or attachments
> > >=20
> > >=20
> > > On Fri, Jan 3, 2020 at 11:50 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> > > >=20
> > > > The PCIe controller in Tegra194 SoC is not completely ECAM-complian=
t.
> > >=20
> > > What is the plan for making these SoCs ECAM-compliant?  When was
> > > Tegra194 designed?  Is it shipping to end customers, i.e., would I be
> > > able to buy one?
> > Tegra194 is designed in 2017 and started shipping from 2018 onwards.
> > Nothing much can be done for Tegra194 to make it fully ECAM compliant
> > at this point in time. Tegra194 based development kits are available @
> > https://developer.nvidia.com/embedded/jetson-agx-xavier-developer-kit
> > Currently the BSP has the kernel booting through Device Tree mechanism
> > and there is a plan to support UEFI based boot as well in the future so=
ftware
> > releases for which we need this quirky way of handling ECAM.
> > Tegra194 is going to be the only and last chip with this issue and next=
 chip
> > in line in Tegra SoC series will be fully compliant with ECAM.
>=20
> ACPI on ARM64 works on a standard subset of systems, defined by the
> ARM SBSA:
>=20
> http://infocenter.arm.com/help/topic/com.arm.doc.den0029c/Server_Base_Sys=
tem_Architecture_v6_0_ARM_DEN_0029C_SBSA_6_0.pdf

I don't understand what you're saying here. Are you saying that you want
to prevent vendors from upstreaming code that they need to support their
ACPI based platforms? I understand that the lack of support for proper
ECAM means that a platform will not be SBSA compatible, but I wasn't
aware that lack of SBSA compatibility meant that a platform would be
prohibited from implementing ACPI support in an upstream kernel.

> These patches will have to be carried out of tree, the MCFG quirk
> mechanism (merged as Bjorn said more than three years ago) was supposed
> to be a temporary plaster to bootstrap server platforms with teething
> issues, the aim is to remove it eventually not to add more code to it
> indefinitely.

Now, I fully agree that quirks are suboptimal and we'd all prefer if we
didn't have to deal with them. Unfortunately the reality is that
mistakes happen and hardware doesn't always work the way we want it to.
There's plenty of other quirk mechanisms in the kernel, and frankly this
one isn't really that bad in comparison.

> So I am afraid but this quirk (and any other coming our way) will not be
> merged in an upstream kernel anymore - for any queries please put Nvidia
> in touch.

Again, I don't understand what you're trying to achieve here. You seem
to be saying that we categorically can't support this hardware because
it isn't fully SBSA compatible.

Do you have any alternative suggestions on how we can support this in an
upstream kernel?

We realized a while ago that we cannot achieve proper ECAM on Tegra194
because of some issues with the hardware and we've provided this as
feedback to the hardware engineers. As a result, the next generation of
Tegra should no longer suffer from these issues.

As for Tegra194, that chip taped out two years ago and it isn't possible
to make it fully ECAM compliant other than by revising the chip, which,
frankly, isn't going to happen.

So I see two options here: either we find a way of dealing with this, by
either merging this quirk or finding an alternative solution, or we make
the decision that some hardware just can't be supported.

The former is fairly common, whereas I've never heard of the latter.

Thierry

> Thanks,
> Lorenzo
>=20
> > - Vidya Sagar
> > >=20
> > > I do not want to add these quirks indefinitely, and the first quirks
> > > were added over three years ago.
> > >=20
> > > > With the current hardware design limitations in place, ECAM can be =
enabled
> > > > only for one controller (C5 controller to be precise) with bus numb=
ers
> > > > starting from 160 instead of 0. A different approach is taken to av=
oid this
> > > > abnormal way of enabling ECAM  for just one controller and to also =
enable
> > > > configuration space access for all the other controllers. In this a=
pproach,
> > > > MCFG quirks are added for each controller with a 30MB PCIe aperture
> > > > resource for each controller in the disguise of ECAM region. But, t=
his
> > > > region actually contains DesignWare core's internal Address Transla=
tion
> > > > Unit (iATU) using which the ECAM ops access configuration space in =
the
> > > > otherwise standard way of programming iATU registers in DesignWare =
core
> > > > based IPs for a respective B:D:F.
> > > >=20
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > ---
> > > >   drivers/acpi/pci_mcfg.c                    | 13 +++
> > > >   drivers/pci/controller/dwc/pcie-tegra194.c | 95 +++++++++++++++++=
+++++
> > > >   include/linux/pci-ecam.h                   |  1 +
> > > >   3 files changed, 109 insertions(+)
> > > >=20
> > > > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > > > index 6b347d9920cc..a42918ecc19a 100644
> > > > --- a/drivers/acpi/pci_mcfg.c
> > > > +++ b/drivers/acpi/pci_mcfg.c
> > > > @@ -116,6 +116,19 @@ static struct mcfg_fixup mcfg_quirks[] =3D {
> > > >          THUNDER_ECAM_QUIRK(2, 12),
> > > >          THUNDER_ECAM_QUIRK(2, 13),
> > > >=20
> > > > +       { "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_=
ops,
> > > > +         DEFINE_RES_MEM(0x38200000, (30 * SZ_1M))},
> > > > +       { "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_=
ops,
> > > > +         DEFINE_RES_MEM(0x30200000, (30 * SZ_1M))},
> > > > +       { "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_=
ops,
> > > > +         DEFINE_RES_MEM(0x32200000, (30 * SZ_1M))},
> > > > +       { "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_=
ops,
> > > > +         DEFINE_RES_MEM(0x34200000, (30 * SZ_1M))},
> > > > +       { "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_=
ops,
> > > > +         DEFINE_RES_MEM(0x36200000, (30 * SZ_1M))},
> > > > +       { "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_=
ops,
> > > > +         DEFINE_RES_MEM(0x3a200000, (30 * SZ_1M))},
> > > > +
> > > >   #define XGENE_V1_ECAM_MCFG(rev, seg) \
> > > >          {"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> > > >                  &xgene_v1_pcie_ecam_ops }
> > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/p=
ci/controller/dwc/pcie-tegra194.c
> > > > index cbe95f0ea0ca..91496978deb7 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > @@ -21,6 +21,8 @@
> > > >   #include <linux/of_irq.h>
> > > >   #include <linux/of_pci.h>
> > > >   #include <linux/pci.h>
> > > > +#include <linux/pci-acpi.h>
> > > > +#include <linux/pci-ecam.h>
> > > >   #include <linux/phy/phy.h>
> > > >   #include <linux/pinctrl/consumer.h>
> > > >   #include <linux/platform_device.h>
> > > > @@ -895,6 +897,99 @@ static struct dw_pcie_host_ops tegra_pcie_dw_h=
ost_ops =3D {
> > > >          .set_num_vectors =3D tegra_pcie_set_msi_vec_num,
> > > >   };
> > > >=20
> > > > +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> > > > +struct tegra194_pcie_acpi  {
> > > > +       void __iomem *dbi_base;
> > > > +       void __iomem *iatu_base;
> > > > +};
> > > > +
> > > > +static int tegra194_acpi_init(struct pci_config_window *cfg)
> > > > +{
> > > > +       struct device *dev =3D cfg->parent;
> > > > +       struct tegra194_pcie_acpi *pcie;
> > > > +
> > > > +       pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > > +       if (!pcie)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       pcie->dbi_base =3D cfg->win;
> > > > +       pcie->iatu_base =3D cfg->win + SZ_256K;
> > > > +       cfg->priv =3D pcie;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static inline void atu_reg_write(struct tegra194_pcie_acpi *pcie, =
int index,
> > > > +                                u32 val, u32 reg)
> > > > +{
> > > > +       u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> > > > +
> > > > +       writel(val, pcie->iatu_base + offset + reg);
> > > > +}
> > > > +
> > > > +static void program_outbound_atu(struct tegra194_pcie_acpi *pcie, =
int index,
> > > > +                                int type, u64 cpu_addr, u64 pci_ad=
dr, u64 size)
> > > > +{
> > > > +       atu_reg_write(pcie, index, lower_32_bits(cpu_addr),
> > > > +                     PCIE_ATU_LOWER_BASE);
> > > > +       atu_reg_write(pcie, index, upper_32_bits(cpu_addr),
> > > > +                     PCIE_ATU_UPPER_BASE);
> > > > +       atu_reg_write(pcie, index, lower_32_bits(pci_addr),
> > > > +                     PCIE_ATU_LOWER_TARGET);
> > > > +       atu_reg_write(pcie, index, lower_32_bits(cpu_addr + size - =
1),
> > > > +                     PCIE_ATU_LIMIT);
> > > > +       atu_reg_write(pcie, index, upper_32_bits(pci_addr),
> > > > +                     PCIE_ATU_UPPER_TARGET);
> > > > +       atu_reg_write(pcie, index, type, PCIE_ATU_CR1);
> > > > +       atu_reg_write(pcie, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> > > > +}
> > > > +
> > > > +static void __iomem *tegra194_map_bus(struct pci_bus *bus,
> > > > +                                     unsigned int devfn, int where)
> > > > +{
> > > > +       struct pci_config_window *cfg =3D bus->sysdata;
> > > > +       struct tegra194_pcie_acpi *pcie =3D cfg->priv;
> > > > +       u32 busdev;
> > > > +       int type;
> > > > +
> > > > +       if (bus->number < cfg->busr.start || bus->number > cfg->bus=
r.end)
> > > > +               return NULL;
> > > > +
> > > > +       if (bus->number =3D=3D cfg->busr.start) {
> > > > +               if (PCI_SLOT(devfn) =3D=3D 0)
> > > > +                       return pcie->dbi_base + where;
> > > > +               else
> > > > +                       return NULL;
> > > > +       }
> > > > +
> > > > +       busdev =3D PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLO=
T(devfn)) |
> > > > +                PCIE_ATU_FUNC(PCI_FUNC(devfn));
> > > > +
> > > > +       if (bus->parent->number =3D=3D cfg->busr.start) {
> > > > +               if (PCI_SLOT(devfn) =3D=3D 0)
> > > > +                       type =3D PCIE_ATU_TYPE_CFG0;
> > > > +               else
> > > > +                       return NULL;
> > > > +       } else {
> > > > +               type =3D PCIE_ATU_TYPE_CFG1;
> > > > +       }
> > > > +
> > > > +       program_outbound_atu(pcie, PCIE_ATU_REGION_INDEX0, type,
> > > > +                            cfg->res.start + SZ_128K, busdev, SZ_1=
28K);
> > > > +       return (void __iomem *)(pcie->dbi_base + SZ_128K + where);
> > > > +}
> > > > +
> > > > +struct pci_ecam_ops tegra194_pcie_ops =3D {
> > > > +       .bus_shift      =3D 20,
> > > > +       .init           =3D tegra194_acpi_init,
> > > > +       .pci_ops        =3D {
> > > > +               .map_bus        =3D tegra194_map_bus,
> > > > +               .read           =3D pci_generic_config_read,
> > > > +               .write          =3D pci_generic_config_write,
> > > > +       }
> > > > +};
> > > > +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> > > > +
> > > >   static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
> > > >   {
> > > >          unsigned int phy_count =3D pcie->phy_count;
> > > > diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> > > > index a73164c85e78..6156140dcbb6 100644
> > > > --- a/include/linux/pci-ecam.h
> > > > +++ b/include/linux/pci-ecam.h
> > > > @@ -57,6 +57,7 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; =
/* Cavium ThunderX 1.x */
> > > >   extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene =
PCIe v1 */
> > > >   extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene =
PCIe v2.x */
> > > >   extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs =
PCIe */
> > > > +extern struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
> > > >   #endif
> > > >=20
> > > >   #ifdef CONFIG_PCI_HOST_COMMON
> > > > --
> > > > 2.17.1
> > > >=20
> >=20

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4lirAACgkQ3SOs138+
s6F1cBAAn8y05JYXccjfVL+DYYtcbgaCO7D/qPsPJkWlyrn2JmFDubM5AcUPc7Bg
yvKwMaVDB5UVOJo3lwJH4yrHk9VkyK15+rcddyqTswLjYQH2AQH9bY+4QQvS1j2M
IuF2p3n5HLvmOzZaJ5vJDjiwkemXX5H1cyK2wTfaJFguiWRYEZypeJwiTnaOHgPX
yqE3LN+gcYC4syvN/QYnJgwgfXzS7SqvVPsWo7376BScBDrYO77jM5kVTRYkRa2u
hyvwdSSbijY/AsWSSumV1MuXXzDIRzRvTqiMuzoCyJPcVN3VaJH6TBJS+Ea3jJ/e
xX2/V2TUAc+0M/sZ1n+xwOAfFNvPu0PzB9rRptcm6vHx53/gIvlc3UVjkPGBmEYZ
uMXUgz3G94gsBQIxtsvVymuswmLYn4Gww4DzMfxhIiYUa3XM4+K3cwR3sSDPW6vT
kGoIBjRhgH7dwqHyQUzNuuxTaF8+zWRaS9oNpkLYgbtgAkUeZ93SQJ9TlR9GmEqS
g6YIEfIN0hnernQUfbZrX/0D8esQ5OsnhopaH7DMLG9YYdwo9rAASSw8wsuoYf8T
zF1TFJYpNf8hVCAFIhE1RJlQyu/p3RqkdrOVmcUi2SEwJqDoKrarWKrlKmsxTC78
qbKEIsVapIH0IhfP+0pO8yIqUi0AvRyh54tJE64oGgCmbYJlxyY=
=yRk/
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
