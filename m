Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170E62B74C
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE0OJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 10:09:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40166 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfE0OJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 10:09:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so15967044wmg.5;
        Mon, 27 May 2019 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LVQmabqaveoCCphB3DhTxUm42/S6gLtLkjhO6CDB9nU=;
        b=kgtqsH9fZ/rbqOeQ5u5aQvsOmd/i26baPpenLVwHu7A+JjKJ6koZc5A5A4ckFaYxWT
         Y1HIxrC3fM8ZrQZSGIMnuCXeGHfGImgBTk8Zi/7ON/ZsbAt1HfXX4A+n5dG9l7mGBqE9
         ts62hpXoZZAkQk/HcpLWFcxIE5iwDjrexlhpSHTyYTW34YkqKw5ytVdjlXQaWU4jZhig
         FlwCNufb9ebITJF+guuN9cF0X886OcvC1aTC0j3g7rR9EQbZJZqv4B70OaMghb/GCcb6
         LaDxr77KaYjy3/6jQm8NyrJfB18zdL1TjmOSYZ8JS4XqY6TmKV0i5npoTNK0hQXI33q0
         g0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LVQmabqaveoCCphB3DhTxUm42/S6gLtLkjhO6CDB9nU=;
        b=q/GHpkJ9cZXJYvpgLHA/JySuwyRUPkXzhYGZHHOe0XCotrjefrv/BZuPv/eVpmkuLo
         8/OPa3UACmhBYK8orjdyQIWck2Q5OOSN5lUICKo8HMKODQxLc450l4cIucUXC8Mk611Q
         aLUUqbHWyQ+Vl9AzGXi36quulIrXBtsV93V2cKylm/65Fj3vXUpCLRBWtOYvj+vORkrB
         H+wF4vSlQyJcmV7jzv/5lQIpNasy3ArMIr6Uq8ekqUPnWvTzHSqGltjnbXASk4wYEZ9Y
         YvEnr/Hu9eQuCdeeZuuAQonVVs2Pw7htwZeieClfg7IWZFewH9jfscq0ySGnjNcbzzU6
         1rbQ==
X-Gm-Message-State: APjAAAWJAoJXRKJ2U5cqc3tsX7slyurzZ3Yc/LIuTzAPEBd/sQp0N3Nt
        hUks8q561BOHyBJ0LEOULFY=
X-Google-Smtp-Source: APXvYqzsW7BY/2y7fqE7i0gqeAmMCKKdIKqWX/pPSvovlJ8F2qxos0lDWm75mPwzO6yfT2dKy+reSw==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr26124553wmc.111.1558966194591;
        Mon, 27 May 2019 07:09:54 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id a124sm7874010wmh.3.2019.05.27.07.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 07:09:53 -0700 (PDT)
Date:   Mon, 27 May 2019 16:09:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     ingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drivers/pci/controller: fix warning PTR_ERR_OR_ZERO can
 be used
Message-ID: <20190527140952.GB7202@ulmo>
References: <20190525085748.GA10926@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20190525085748.GA10926@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2019 at 02:27:48PM +0530, Hariprasad Kelam wrote:
> fix below warnings reported by coccichek
>=20
> /drivers/pci/controller/pci-tegra.c:1132:1-3: WARNING: PTR_ERR_OR_ZERO
> can be used

This has been discussed many times before, but PTR_ERR_OR_ZERO is not
liked by everybody. Most of these are actually in place on purpose. One
of the reasons I hear most frequently cited in opposition to this macro
is that it complicates things when you need to add some new code in, so
PTR_ERR_OR_ZERO() becomes wrong and has to be changed. The original,
with the "return 0;" being explicit doesn't have that problem and you
can easily add things in between.

It's obviously up to Bjorn to decide whether he wants this, but I
vaguely remember discussing this particular instance with him before and
we both agreed that we didn't think this was worth it.

Perhaps it's time to make checkpatch not complain about this anymore? Or
at least make this not a WARNING.

Thierry

> ./drivers/pci/controller/dwc/pcie-qcom.c:703:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pci-meson.c:185:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pci-meson.c:262:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pcie-kirin.c:141:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pcie-kirin.c:177:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/pci/controller/dwc/pci-exynos.c:95:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
>=20
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 4 +---
>  drivers/pci/controller/dwc/pci-meson.c  | 8 ++------
>  drivers/pci/controller/dwc/pcie-kirin.c | 8 ++------
>  drivers/pci/controller/dwc/pcie-qcom.c  | 4 +---
>  drivers/pci/controller/pci-tegra.c      | 4 +---
>  5 files changed, 7 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index cee5f2f..b0b4849 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -92,10 +92,8 @@ static int exynos5440_pcie_get_mem_resources(struct pl=
atform_device *pdev,
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ep->mem_res->elbi_base =3D devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ep->mem_res->elbi_base))
> -		return PTR_ERR(ep->mem_res->elbi_base);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(ep->mem_res->elbi_base);
>  }
> =20
>  static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index e35e9ea..1ca78c2 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -182,10 +182,8 @@ static int meson_pcie_get_mems(struct platform_devic=
e *pdev,
> =20
>  	/* Meson SoC has two PCI controllers use same phy register*/
>  	mp->mem_res.phy_base =3D meson_pcie_get_mem_shared(pdev, mp, "phy");
> -	if (IS_ERR(mp->mem_res.phy_base))
> -		return PTR_ERR(mp->mem_res.phy_base);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(mp->mem_res.phy_base);
>  }
> =20
>  static void meson_pcie_power_on(struct meson_pcie *mp)
> @@ -259,10 +257,8 @@ static int meson_pcie_probe_clocks(struct meson_pcie=
 *mp)
>  		return PTR_ERR(res->general_clk);
> =20
>  	res->clk =3D meson_pcie_probe_clock(dev, "pcie", 0);
> -	if (IS_ERR(res->clk))
> -		return PTR_ERR(res->clk);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(res->clk);
>  }
> =20
>  static inline void meson_elb_writel(struct meson_pcie *mp, u32 val, u32 =
reg)
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/contro=
ller/dwc/pcie-kirin.c
> index 9b59929..87cfdb4 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -138,10 +138,8 @@ static long kirin_pcie_get_clk(struct kirin_pcie *ki=
rin_pcie,
>  		return PTR_ERR(kirin_pcie->apb_sys_clk);
> =20
>  	kirin_pcie->pcie_aclk =3D devm_clk_get(dev, "pcie_aclk");
> -	if (IS_ERR(kirin_pcie->pcie_aclk))
> -		return PTR_ERR(kirin_pcie->pcie_aclk);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(kirin_pcie->pcie_aclk);
>  }
> =20
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> @@ -174,10 +172,8 @@ static long kirin_pcie_get_resource(struct kirin_pci=
e *kirin_pcie,
> =20
>  	kirin_pcie->sysctrl =3D
>  		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
> -	if (IS_ERR(kirin_pcie->sysctrl))
> -		return PTR_ERR(kirin_pcie->sysctrl);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(kirin_pcie->sysctrl);
>  }
> =20
>  static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 0ed235d..6c421e6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -700,10 +700,8 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom=
_pcie *pcie)
>  		return PTR_ERR(res->ahb_reset);
> =20
>  	res->phy_ahb_reset =3D devm_reset_control_get_exclusive(dev, "phy_ahb");
> -	if (IS_ERR(res->phy_ahb_reset))
> -		return PTR_ERR(res->phy_ahb_reset);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(res->phy_ahb_reset);
>  }
> =20
>  static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 464ba25..3cd5069 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1129,10 +1129,8 @@ static int tegra_pcie_resets_get(struct tegra_pcie=
 *pcie)
>  		return PTR_ERR(pcie->afi_rst);
> =20
>  	pcie->pcie_xrst =3D devm_reset_control_get_exclusive(dev, "pcie_x");
> -	if (IS_ERR(pcie->pcie_xrst))
> -		return PTR_ERR(pcie->pcie_xrst);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
>  }
> =20
>  static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
> --=20
> 2.7.4
>=20

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzr77AACgkQ3SOs138+
s6E3XxAAl/LQJibF57zkjZJ/Sz1qW4r8QI3T/YJg7wQMj+JhzSbD+wvrPqHaE5x0
rhnQ3Qsr1U8uvz0Brnsnvl83bMvTc17pIRsekAwinfFwT5cKU/eH3A6xTgnHFThq
8zYBXySXZytLkVXwne0g+7ZG19FbCGhENKX1GxRFJwqKwuFXK7+eThuQtnD+SupS
vTqd4PZmTFwW+N+tY/OLAf8+UsI9uciASHnjkDI/DeQnG+xAfUzCxu3PYMYP2Wd8
YD+Lai4w89C0Q6h7sC3U2XTN050gDrFYQ0vAMZGykGGM8hjlW7yEvAKoV027uTVr
ghCypTYX1l3IlJXyPfk8T8dkWxijj5wzl+vFvCMdmMD4lpOqQGOvi8AOw8RaLYzS
r3WE1AJfo1iMCuz7lu66Z0bSQWHtPv2rfb9rK2OWOYH5JkPOuT64fdhDCz0USb8/
Xy4bARALpHhK32oNi7G6pxNmOClCrzl+ri/JNpagTmj0jh9GmeAntW+t2XwCEppH
70Z+PcA8gq2elvyx5gnA2TkbskGo2O8UH8XEDExr2hVdm8GG8N+LgEtIBbdTuecu
IKCZ9vk2X1jQ+hJAP6Cz0YSu8E2yrdBQ5Hb6pnlPz6yVzUYkuNdTPW9CDN9BU8Ve
91Y/9Oy5llAhtP9kKzXGY8wh27C0MI2m0V2+ErpsgSGszupKXRY=
=2ftq
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
