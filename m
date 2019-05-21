Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAACC24D66
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEULAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 07:00:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38996 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEULAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 07:00:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so582814wmk.4;
        Tue, 21 May 2019 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXK0l/dJDi4Wtgp8nyxTdsDiyMt/NG7NKTcUG3fu8Eo=;
        b=jtYDSnZwGjfr/2PZkilboV/Yx/zWbI6/QLXFQp7ymRKEmMSg7Azb8r8MzH2KzJjNfa
         i6j8JZr2VQroVZaCScAPIyc10VNsZK9m24pV4kvfVzbwga6JVHvsYpd/NEh4OVsO6v7E
         pcxhYXzTUdBIJTm6uTh/euaxGB9DEZU1td9MmIsVr0HzT37mMMHCTgqXgJkE/ad0lSar
         ELgGaFKIwcIlD4VQQO1rSYR0INPKmvcqQdAPrWcyAaHRw+ActMTn7fFmcjPlwM0Bq+Qy
         JiN2ttDFgiCVpo/uwWRRgbpDlR881yMDKxyni+NlP6wRCC52QAXWxN99XBRkzbnYMDa6
         oTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXK0l/dJDi4Wtgp8nyxTdsDiyMt/NG7NKTcUG3fu8Eo=;
        b=gaiPkHqJ9Ava5yUl89o4leJwBwNDBXHlhfFZWUTc4C9rbEZGnyZ9AlFsHh0EPst/jZ
         3wA/qwnk94YXQEnEqnXWOGaJTzsgQasX2MUshVcqzqBzYqkql/ZkmAKfuYvIZYodWdwW
         AL2ixSqsdo7tyAkm658EyvPVNpjev/+6rLOi04Jmh/hUfZUfwr75p/jUm5xIZkYPz2Qd
         AEx/B8rB0+kjtCo3MU3RWKixFgVhHYeZU4oTbg14SVkdQALfegnYzj5I1wctFjBwBwKE
         6K+D48BkjcPfQ4NyuHmZgpDqvQ3sIK/A2MKQGNY1FCBjxFH6tpkBoRz2BG2GY++CxGZu
         C+cw==
X-Gm-Message-State: APjAAAV4F7DPcBVkmssWSF7/knDFz11yXlCac4R6gNGfXtuwKiS850dt
        rzWSTfrwtg4ONo61/UWRT7tyo0tB6dY=
X-Google-Smtp-Source: APXvYqyeIQVKV3k9pdyoSXqvWOBE9HiJtJqgDEyc04cN48x2WpyAJGVJZwxJplQ8EOtCL6mEB3EklQ==
X-Received: by 2002:a1c:6c1a:: with SMTP id h26mr2811263wmc.89.1558436413733;
        Tue, 21 May 2019 04:00:13 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id t6sm5373178wmt.34.2019.05.21.04.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 04:00:12 -0700 (PDT)
Date:   Tue, 21 May 2019 13:00:11 +0200
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
Subject: Re: [PATCH V7 13/15] phy: tegra: Add PCIe PIPE2UPHY support
Message-ID: <20190521110011.GL29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-14-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ucfHZChuBC0NsER/"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-14-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ucfHZChuBC0NsER/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:44PM +0530, Vidya Sagar wrote:
> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
> For each PCIe lane of a controller, there is a P2U unit instantiated at
> hardware level. This driver provides support for the programming required
> for each P2U that is going to be used for a PCIe controller.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * Addressed review comments from Thierry
>=20
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
>  drivers/phy/tegra/pcie-p2u-tegra194.c | 109 ++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
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

The Kconfig symbol and driver are named inconsistently. That's not
inherently wrong, but I think it unnecessarily complicates things. Why
not just do something like:

	config PHY_TEGRA194_P2U

and name the driver...

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

=2E.. phy-tegra194-p2u here? Or perhaps even leave away the 194 and make
it just phy-tegra-p2u. That would make it consistent with the
phy-tegra-xusb driver.

Looks good otherwise.

Thierry

> diff --git a/drivers/phy/tegra/pcie-p2u-tegra194.c b/drivers/phy/tegra/pc=
ie-p2u-tegra194.c
> new file mode 100644
> index 000000000000..fae2afe1a1aa
> --- /dev/null
> +++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
> + *
> + * Copyright (C) 2019 NVIDIA Corporation.
> + *
> + * Author: Vidya Sagar <vidyas@nvidia.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
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
> +	.power_on =3D tegra_p2u_power_on,
> +	.owner =3D THIS_MODULE,
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
> +static const struct of_device_id tegra_p2u_id_table[] =3D {
> +	{
> +		.compatible =3D "nvidia,tegra194-p2u",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
> +
> +static struct platform_driver tegra_p2u_driver =3D {
> +	.probe =3D tegra_p2u_probe,
> +	.driver =3D {
> +		.name =3D "tegra194-p2u",
> +		.of_match_table =3D tegra_p2u_id_table,
> +	},
> +};
> +module_platform_driver(tegra_p2u_driver);
> +
> +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra PIPE2UPHY PHY driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.17.1
>=20

--ucfHZChuBC0NsER/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj2jsACgkQ3SOs138+
s6HX1BAAle2u+c/p0OdUxLkzn9KLUBAt0Da+73TQ8Ms7YJd8K/5HeU4xMfXquhwp
3BVFMk/c84AkgOJTmGYpnC52Z0Z+S40954SZkiB3CxnBVugDXmypAp0GahpsknUj
CrGCxYoEc6DWcum9Gk1xXvJZGsGLWBz6JcZa8c+18q+6Re7th83vIQPkiv97o/Cv
KeFAuqrOVFn5QoTnmXcqVVvrmH9Isfo/G5LcQ3nCJZoGyEcqumYkPqFTL1Jln/qR
RE1PiENhNmldKhesqKjFVkDp/nwB6YAaUpPIZ05wEBA5oLqsUkujQAAnBAuolkcn
zJkuUkyvnXUM3flWQ8PVmoBLWfL5wyQ70h/+zyGOvDLqDeMzfTTCW+exHMvJfW2D
jjzZfkNM+PGentTd4m09Y03h92ayNA1Z3YoUZr4SJWY/M35ZUByCOMluXmDjZ5Q2
R1EeF24gj+0WC7GWC9wB/v1qYcacMnij4QSX+tADhxAnChEWIfQv0L8YD8YxDlv1
VUOAPfSgh8UE6jcjxdGLIm5R8nPtppX4yuoK4uWsk0KGYwIh5tlPAxK0zhMdEiMN
1KCRlm9XjFHp4pSsoMHGWq3/hy87NC0dZi7BgedKrjDUQJmNg9Qm6H6kEmED1Gxu
0Z8rcygx19P5kSngS/YE+m0EWqp3Y45Jhr86MZzWPQOk4zZY6T4=
=thc2
-----END PGP SIGNATURE-----

--ucfHZChuBC0NsER/--
