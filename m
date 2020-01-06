Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A42131276
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAFNDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 08:03:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55945 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAFNDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 08:03:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so14862602wmj.5;
        Mon, 06 Jan 2020 05:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8GI+fkA1y42UGVxNrVQWD5XfAcMVjkAxvyUEI9AIOk=;
        b=IDMf9BrlhhP6zdH8G8vu3nv5nR0+x2eipT+s/hzJAi2grFqcm7pgsZ8kLyjH5LpHBE
         3iGzdBfKx1R832ExYtz3dX0PJxrfZg8FmLFg/xhW5vi/YOMEVwjjl2BSrb7WUhJb9lHJ
         fVfZ5pk4/JH4w3ZYRnm5G1n8wZdSV9b1wlDgjtWCJDxbCabvX15GjEfw4LNtzzUr1ujy
         G7CH3tLp8gZdmqrReHcUeGCuw2nUINr7E5N7Z2txcYBuG1qptTLQIwbmgvptLkamVV8K
         oG9mprNaqTMo1Kd7F7aZJGx0AEV8Q8HIGDHPNhiQYjun59Na46r0qeu727xCKAmkADiq
         8qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8GI+fkA1y42UGVxNrVQWD5XfAcMVjkAxvyUEI9AIOk=;
        b=AH0uTEflmJZWwsOPhbY36DYFteEuxW8T83Mf2rLeQ5jbZKcWEK8/OsjLzB/R0XvM66
         2oKWDNqGF5SgkBjnwd3ur8hqrauZ39VU1IYJmKR14ihRorEbVYC+w6nYCO9lTj/iUbFg
         tqJdxW+nqN/1s9cAxqAcWEQsvwzEcfFZd8Bhe1Uf0HvgA2n9J4tvTZDdz/dHsa005s/p
         hRqY6XN5aPXNaDMVE4gnhGW4EUcp8r8Yomfybt62y9cYjbtlquaENAq8m5FpdXoCufG+
         Y+S63N/zQflgQZFNPI1u68OMRBPr1hu8fs4O6HUC4MC8b6+fn95EbX4Xv2QgXu48E8NM
         vkAw==
X-Gm-Message-State: APjAAAWuopLRlpJtwnurPEnc7faU2KiPIcn/wCyFG6eyaXczdzklSFPz
        e6fM/0GZ+88BKqTVw4g5ekY=
X-Google-Smtp-Source: APXvYqxV85cN6XfSONWL5wpazI7NzUpWYQj5b+2RCtV9KdhuUAw+P8D2rs7n5IfIuXN6C9dM4w808A==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr36873421wmi.101.1578315781745;
        Mon, 06 Jan 2020 05:03:01 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id y139sm24047581wmd.24.2020.01.06.05.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:03:00 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:02:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 3/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20200106130259.GB1955714@ulmo>
References: <20200103124404.20662-1-vidyas@nvidia.com>
 <20200103124404.20662-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20200103124404.20662-4-vidyas@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2020 at 06:14:02PM +0530, Vidya Sagar wrote:
> Add support for the endpoint mode of Synopsys DesignWare core based
> dual mode PCIe controllers present in Tegra194 SoC.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed Bjorn's review comments
> * Made changes as part of addressing review comments for other patches
>=20
>  drivers/pci/controller/dwc/Kconfig         |  30 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 782 ++++++++++++++++++++-
>  2 files changed, 796 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
[...]
> @@ -411,11 +466,66 @@ static irqreturn_t tegra_pcie_rp_irq_handler(struct=
 tegra_pcie_dw *pcie)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t tegra_pcie_ep_irq_handler(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie_ep *ep =3D &pcie->pci.ep;
> +	int spurious =3D 1;
> +	u32 val, tmp;
> +
> +	val =3D appl_readl(pcie, APPL_INTR_STATUS_L0);
> +	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
> +		val =3D appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
> +		appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
> +		if (val & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE) {
> +			/* clear any stale PEX_RST interrupt */
> +			if (!kfifo_put(&pcie->event_fifo, EP_HOT_RST_DONE)) {
> +				dev_err(pcie->dev, "EVENT FIFO is full\n");
> +				return IRQ_HANDLED;
> +			}
> +			wake_up(&pcie->wq);
> +		}

Overall this patch looks a little cluttered. A few blank lines before
and after (or between) block statements would help make this more
readable, in my opinion.

> +		if (val & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
> +			tmp =3D appl_readl(pcie, APPL_LINK_STATUS);
> +			if (tmp & APPL_LINK_STATUS_RDLH_LINK_UP) {
> +				dev_info(pcie->dev, "Link is up with Host\n");

Do we want this to be an info message? Looks to me like this is mostly
useful for debug purposes, as a quick way to check if the link is up.
For production use, this would perhaps be better to expose as a sysfs
attribute so that userspace can query it at runtime rather than search
through kernel logs.

> +				dw_pcie_ep_linkup(ep);
> +			}
> +		}
> +		spurious =3D 0;
> +	}
> +
> +	if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
> +		val =3D appl_readl(pcie, APPL_INTR_STATUS_L1_15);
> +		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
> +		if (val & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED) {
> +			if (!kfifo_put(&pcie->event_fifo, EP_BME_CHANGE)) {
> +				dev_err(pcie->dev, "EVENT FIFO is full\n");
> +				return IRQ_HANDLED;
> +			}
> +			wake_up(&pcie->wq);
> +		}
> +		spurious =3D 0;
> +	}
> +
> +	if (spurious) {
> +		dev_warn(pcie->dev, "Random interrupt (STATUS =3D 0x%08X)\n",
> +			 val);
> +		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t tegra_pcie_irq_handler(int irq, void *arg)
>  {
>  	struct tegra_pcie_dw *pcie =3D arg;
> =20
> -	return tegra_pcie_rp_irq_handler(pcie);
> +	if (pcie->mode =3D=3D DW_PCIE_RC_TYPE)
> +		return tegra_pcie_rp_irq_handler(pcie);
> +	else if (pcie->mode =3D=3D DW_PCIE_EP_TYPE)
> +		return tegra_pcie_ep_irq_handler(pcie);
> +
> +	return IRQ_NONE;
>  }

We already know at probe time whether the controller is in root complex
or endpoint mode, right? Couldn't we just install the correct handler
rather than multiplex here? It's not a very big deal, but given that
these are interrupts, avoiding the additional indirection might be a
good idea.

[...]
> @@ -986,6 +1115,42 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie=
_dw *pcie)
>  	pcie->enable_cdm_check =3D
>  		of_property_read_bool(np, "snps,enable-cdm-check");
> =20
> +	if (pcie->mode =3D=3D DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	/* Endpoint mode specific DT entries */
> +	name =3D devm_kasprintf(pcie->dev, GFP_KERNEL,
> +			      "tegra_pcie_%u_pex_rst_gpio", pcie->cid);
> +	if (!name) {
> +		dev_err(pcie->dev, "Failed to create PERST GPIO string\n");
> +		return -ENOMEM;
> +	}
> +	pcie->pex_rst_gpiod =3D devm_gpiod_get_from_of_node(pcie->dev, np,

If np =3D=3D pcie->dev.of_node, you can simply use devm_gpiod_get() here,
can't you?

[...]
> +static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
> +{
> +	u32 val =3D 0;

The initialization here seems unnecessary.

[...]
> +static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u1=
6 irq)
> +{
> +	/* Tegra194 supports only INTA */
> +	if (irq > 1)
> +		return -EINVAL;
> +
> +	appl_writel(pcie, 1, APPL_LEGACY_INTX);
> +	mdelay(1);

Spinning for 1 ms these days is quite a lot. Does this have to be a busy
loop or could you use something like usleep_range(1000, 2000) to allow
the CPU to do something else in the meantime?

Also, does the legacy INTX pulse have to be a whole millisecond wide? Or
could this be shorter? A one millisecond pulse implies a maximum of 1000
interrupts per second, which seems a bit low.

> @@ -1440,6 +2178,12 @@ static int tegra_pcie_dw_probe(struct platform_dev=
ice *pdev)
>  	int ret;
>  	u32 i;
> =20
> +	match =3D of_match_device(of_match_ptr(tegra_pcie_dw_of_match), dev);
> +	if (!match)
> +		return -EINVAL;
> +
> +	data =3D (struct tegra_pcie_dw_of_data *)match->data;

of_device_get_match_data()?

> +
>  	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
>  		return -ENOMEM;
> @@ -1449,6 +2193,7 @@ static int tegra_pcie_dw_probe(struct platform_devi=
ce *pdev)
>  	pci->ops =3D &tegra_dw_pcie_ops;
>  	pp =3D &pci->pp;
>  	pcie->dev =3D &pdev->dev;
> +	pcie->mode =3D (enum dw_pcie_device_mode)data->mode;
> =20
>  	ret =3D tegra_pcie_dw_parse_dt(pcie);
>  	if (ret < 0) {
> @@ -1462,6 +2207,9 @@ static int tegra_pcie_dw_probe(struct platform_devi=
ce *pdev)
>  		return ret;
>  	}
> =20
> +	if (pcie->pex_refclk_sel_gpiod)
> +		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 1);
> +
>  	pcie->pex_ctl_supply =3D devm_regulator_get(dev, "vddio-pex-ctl");
>  	if (IS_ERR(pcie->pex_ctl_supply)) {
>  		ret =3D PTR_ERR(pcie->pex_ctl_supply);
> @@ -1570,11 +2318,24 @@ static int tegra_pcie_dw_probe(struct platform_de=
vice *pdev)
> =20
>  	platform_set_drvdata(pdev, pcie);
> =20
> -	ret =3D tegra_pcie_config_rp(pcie);
> -	if (ret && ret !=3D -ENOMEDIUM)
> -		goto fail;
> -	else
> -		return 0;
> +	switch (pcie->mode) {
> +	case DW_PCIE_RC_TYPE:
> +		ret =3D tegra_pcie_config_rp(pcie);
> +		if (ret && ret !=3D -ENOMEDIUM)
> +			goto fail;
> +		else
> +			return 0;
> +		break;
> +
> +	case DW_PCIE_EP_TYPE:
> +		ret =3D tegra_pcie_config_ep(pcie, pdev);
> +		if (ret < 0)
> +			goto fail;
> +		break;
> +
> +	default:
> +		dev_err(dev, "Invalid PCIe device type %d\n", pcie->mode);
> +	}
> =20
>  fail:
>  	tegra_bpmp_put(pcie->bpmp);
> @@ -1593,6 +2354,8 @@ static int tegra_pcie_dw_remove(struct platform_dev=
ice *pdev)
>  	pm_runtime_put_sync(pcie->dev);
>  	pm_runtime_disable(pcie->dev);
>  	tegra_bpmp_put(pcie->bpmp);
> +	if (pcie->pex_refclk_sel_gpiod)
> +		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
> =20
>  	return 0;
>  }
> @@ -1697,13 +2460,6 @@ static void tegra_pcie_dw_shutdown(struct platform=
_device *pdev)
>  	__deinit_controller(pcie);
>  }
> =20
> -static const struct of_device_id tegra_pcie_dw_of_match[] =3D {
> -	{
> -		.compatible =3D "nvidia,tegra194-pcie",
> -	},
> -	{},
> -};
> -

No need to move this around if you use of_device_get_match_data().

Thierry

>  static const struct dev_pm_ops tegra_pcie_dw_pm_ops =3D {
>  	.suspend_late =3D tegra_pcie_dw_suspend_late,
>  	.suspend_noirq =3D tegra_pcie_dw_suspend_noirq,
> --=20
> 2.17.1
>=20

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4TMAEACgkQ3SOs138+
s6FjPw//XT+57TF5ONpPw6K3J7ACQCLYQBoonnQLrysQyLyKegarIe5lPQuP3CL8
g1yJbPO9/UhcFSnnnKN4pJK4n1ps/qa2ksYXwnQpcpdQOKYkw1HyEeBsOt8bq+F2
yAOg0tgbopoJcAMhLqalnBkO+5jeIFbL4GtYLczdE7fN3qaNENV2KF/XoY8M3Pge
DJVaSgx5ZR1vnbxUETxyhv0HhVEv6DGnpfd5kxiTBxpmxaF5wDLnwWamSfy2f6Az
BXX1tYjzXhznORtXF3dewbIeg6QBRRqTrzfPdRAG5pjORWDEg2udIocH/7K1K9/j
Lvgqqyyf0SeUekTZhposrlvJfoBsYOrw1RzVrcV2fMs6vMSMLtTY3p6g6Lo2XxWw
4AfV79c3HGEsymUgwE4BqFUBeWJJJc351+CjNZk2F/niftEj95Wys3p890ujXG0d
YNRaY70/UULt4cFq/IclqwS8JESvxi5weJS703TUW7mYwwMDIkD8m21xn51rU59J
+rElY5MxqoDkNmeeH+6mOuYdW5mi3JOfQ5aHa3fn2dBo6lHKqEi0zA7dke8XBBgY
ORfBbsdWw/Cv1ij1AP6R6MYUk6wGTxHvZg5nZXLyCFPV3b0N7Qmg5+WeAA2ICHvL
hQ1hmgP851CffTmGKTrYEjsBtmazxVpAMU1r3CEQpVviLNqjFz8=
=ZsFl
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
