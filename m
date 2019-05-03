Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8382312C7B
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfECLgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:36:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55565 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECLgC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 07:36:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id y2so6390662wmi.5;
        Fri, 03 May 2019 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W//ALEE5VT6SBWnqaiaie62yFCMzK6hStFCDj6BgZ+c=;
        b=Y5QXW7rdtmdCm/sv2xrJnik0hiFh3yTAI+zx/xqTEQ5Fw2Yau+LZa1tdLABiaicFjE
         vyZi6/nzsDSn1bkb5g7OneLHhaolmCsu/w8ZoFPEcyBGMtIOIB6717REq7tKc1zqrzbX
         XEFJrFVxKKMXe6EhBKKE7L+0Ge72VW2sBdzlsU1/kbagADvJ9zDYjVbWjeydiBJx8jcX
         Olwh73aUM4VrnIWi7PvMxMj76T2BdNxOpBTYWEkjZucXhnGaBZ595P5EhtttFlPkiZVc
         12mfWPMtkQcRE7O3RZPUF6FOj2lyPuaHk2lrDbyJJMdRbp2iJ5UUeSg/ZO5cE2MrLWFL
         Suwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W//ALEE5VT6SBWnqaiaie62yFCMzK6hStFCDj6BgZ+c=;
        b=GFS9kQUI8azDHGIC7t10Qx/hJRyuPMxY6OSSVTE3u4QTn68oWiivmH5ujwaUIpe9bS
         WskQ4u99+6+XEqlC8306hgMB8PEzTUUfVUOCajnnYkcj/Hv4IIV+6fLuR3jk35y8cXps
         nKBEvHahS0MUP8GFoiWF3x/vEwhQOGIVbFm9VKQzyznzJWNP/9mnBOYfMXMdGxMWEA1g
         KiC2c+9ThMgqNYoX1jVr3KgoTmXB6SwFZ2XJfUW7pwE1nOMCbWKyp4at5jQme5eDiflf
         /wt/0m5dvlY95/0uQnZ0wexuhz3YwKN1WjLGxsvW9zH+uJlTOBT5U2pp4BuDw4lS13rZ
         aGIQ==
X-Gm-Message-State: APjAAAX3jSQaypwibvM7wd0fj3fvieiVlNk3mZq1zVbMQaXoAJhX2Tc+
        XJWmSpgVO9gNfnZ9hnG6OFI=
X-Google-Smtp-Source: APXvYqxfIJHgYWHj9BmMQFTrkyOZ9fncFwNHZ9iKptLt7AvkzvbZGfD3e/UN2lbhDj0IRdNJTwnuJA==
X-Received: by 2002:a7b:c762:: with SMTP id x2mr6150087wmk.50.1556883360061;
        Fri, 03 May 2019 04:36:00 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u22sm1446349wmc.12.2019.05.03.04.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:35:59 -0700 (PDT)
Date:   Fri, 3 May 2019 13:35:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 14/16] phy: tegra: Add PCIe PIPE2UPHY support
Message-ID: <20190503113558.GH32400@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-15-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-15-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:50:02AM +0530, Vidya Sagar wrote:
> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
> For each PCIe lane of a controller, there is a P2U unit instantiated at
> hardware level. This driver provides support for the programming required
> for each P2U that is going to be used for a PCIe controller.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * Rebased on top of linux-next top of the tree
>=20
> Changes since [v2]:
> * Replaced spaces with tabs in Kconfig file
> * Sorted header file inclusion alphabetically
>=20
> Changes since [v1]:
> * Added COMPILE_TEST in Kconfig
> * Removed empty phy_ops implementations
> * Modified code according to DT documentation file modifications
>=20
>  drivers/phy/tegra/Kconfig             |   7 ++
>  drivers/phy/tegra/Makefile            |   1 +
>  drivers/phy/tegra/pcie-p2u-tegra194.c | 120 ++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c
>=20
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index a3b1de953fb7..06d423fa85b4 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
> =20
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called phy-tegra-xusb.
> +
> +config PHY_TEGRA194_PCIE_P2U
> +	tristate "NVIDIA Tegra P2U PHY Driver"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 1=
9x SOCs.
> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
> index a93cd9a499b2..1aaca794f40c 100644
> --- a/drivers/phy/tegra/Makefile
> +++ b/drivers/phy/tegra/Makefile
> @@ -5,3 +5,4 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D xusb-teg=
ra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) +=3D xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) +=3D xusb-tegra210.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) +=3D xusb-tegra186.o
> +obj-$(CONFIG_PHY_TEGRA194_PCIE_P2U) +=3D pcie-p2u-tegra194.o
> diff --git a/drivers/phy/tegra/pcie-p2u-tegra194.c b/drivers/phy/tegra/pc=
ie-p2u-tegra194.c
> new file mode 100644
> index 000000000000..a5d85e411088
> --- /dev/null
> +++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
> + *
> + * Copyright (C) 2019 NVIDIA Corporation.
> + *
> + * Author: Vidya Sagar <vidyas@nvidia.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <soc/tegra/bpmp-abi.h>

Looks to me like not all of the above are actually needed. I don't see
anything from delay.h used, and you certainly aren't using anything from
soc/tegra/bpmp-abi.h either.

> +
> +#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
> +#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
> +#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
> +#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
> +#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
> +
> +#define P2U_RX_DEBOUNCE_TIME				0xa4
> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xffff
> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
> +
> +struct tegra_p2u {
> +	void __iomem *base;
> +};
> +
> +static int tegra_p2u_power_on(struct phy *x)
> +{
> +	struct tegra_p2u *phy =3D phy_get_drvdata(x);
> +	u32 val;
> +
> +	val =3D readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
> +	val &=3D ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
> +
> +	val =3D readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
> +
> +	val =3D readl(phy->base + P2U_RX_DEBOUNCE_TIME);
> +	val &=3D ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
> +	val |=3D P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
> +	writel(val, phy->base + P2U_RX_DEBOUNCE_TIME);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops ops =3D {
> +	.power_on	=3D tegra_p2u_power_on,
> +	.owner		=3D THIS_MODULE,

I think it's perhaps best to just stick with single spaces around the =3D
instead of trying to arbitrarily align these. See below for why I think
so.

> +};
> +
> +static int tegra_p2u_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev =3D &pdev->dev;
> +	struct phy *generic_phy;
> +	struct tegra_p2u *phy;
> +	struct resource *res;
> +
> +	phy =3D devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctl");
> +	phy->base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(phy->base))
> +		return PTR_ERR_OR_ZERO(phy->base);
> +
> +	platform_set_drvdata(pdev, phy);

You could use dev_set_drvdata() here since you already use dev (instead
of pdev) everywhere else.

> +
> +	generic_phy =3D devm_phy_create(dev, NULL, &ops);
> +	if (IS_ERR(generic_phy))
> +		return PTR_ERR_OR_ZERO(generic_phy);
> +
> +	phy_set_drvdata(generic_phy, phy);
> +
> +	phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate=
);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR_OR_ZERO(phy_provider);
> +
> +	return 0;
> +}
> +
> +static int tegra_p2u_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

I thought it had already been mentioned that you don't need to implement
this if it's empty?

> +
> +static const struct of_device_id tegra_p2u_id_table[] =3D {
> +	{
> +		.compatible =3D "nvidia,tegra194-p2u",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
> +
> +static struct platform_driver tegra_p2u_driver =3D {
> +	.probe		=3D tegra_p2u_probe,
> +	.remove		=3D tegra_p2u_remove,
> +	.driver		=3D {
> +		.name	=3D "tegra194-p2u",
> +		.of_match_table =3D tegra_p2u_id_table,

Again, I don't think the artificial padding does this any good. For
example, the .driver.name's assignment operator is padded to the same
column as members of the parent structure, so that's confusing to read.
Also, .of_match_table is not padded at all, so it's inconsistent. Just
use single spaces around =3D. That's easy to keep consistent and really
doesn't read that bad.

> +	},
> +};
> +
> +module_platform_driver(tegra_p2u_driver);

It's customary to have no blank line between the closing "};" and the
module_platform_driver() macro.

Thierry

> +
> +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra PIPE2UPHY PHY driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.17.1
>=20

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMJ54ACgkQ3SOs138+
s6FHRw//QSQE5n5EBmd2QXhQm9HCcPNiLPcqZ9zoT97qtU/IOaBbQm5pjW2UMvrp
jdq3ArQqHkQ7Xg4Xv0dzjAeKNwI2Q9PMGMmOY6SDs/f3HtSfgOIRWly79T2SQMLS
EnYVG9+Ay6t7noWu1rKqIlmc3AiEMqw0LgC+ymabUyrdzTdZZic+Q8C3WqO4YNzc
ouphnrxkhJcfRWHo5awWiwuI6hGtkMj0mw/5rBzQlvj3q+c8v9QH7ib8XRvmBQkx
RRvNVtOy644FrswGT+I2s3LYXd/YE9e6I7GIlipxlanimLs8XGXmHsd1QLIGBExh
b9lnOpEJPJbucA3MekPK/vzlJ0OGKE6TEhiEs9CAHGns1Y3TnXMSD9GG0bkw0XY2
oEPPZElmM1IcAFe9+uABzIif/FOmsR9a5gS10sYiiVGvev2DLHHn6BQP3s8yRD2t
hGth+8RRbYNMnjqeSCLNIgQbMBd4DHxk8B34W/y7rMB79/pcI5UwP0td7C+q2q0B
yXZddybe7FtAI69nuDBr7CD5bE2ejc1bItYUq+GCq67dOrPJBQFxGPUx9KdkPCrg
2zGp426JLQiM3rZHveWeZltswCsUolmp6zvc/cg8dSRBsm7tjdgLFPH+0i6DDltP
MEyKiVMslB0YUDBp/S+VMXm94Y3fnQHt0CxgqFN/EsjEhvdZXNU=
=wCXA
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
