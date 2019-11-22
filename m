Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4767107314
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 14:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfKVNZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 08:25:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38084 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 08:25:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so8614562wro.5;
        Fri, 22 Nov 2019 05:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0NHwgBSUws38Es7Xi/rZX05Xqj++OpNble994Q4twz8=;
        b=nOil050ebumEVh6B4CMpHHxn/QX9acBxM3S9OLut6akRaRuTuBPBe5v+ETuUb0xLBk
         6S93YBoJ8ZjLEfTcsfAQDWNhbmhGOJ8ReZDwL+gWlIfb0dJrt4DghYC7C84CbJwYmENQ
         dBeSioVD4jg/Rsah2pbJNu4W08WN8+pkJ4bZyBMRGcSTfDCqCNyzegFTPQ4LR0+9XfR5
         RSMLNr4S5tdnmPAXBTDWBoweI2frennUR3IycN4Ga6wFah55fmDbWRFbazA60VbVwSm4
         8Ir6SxYLMs/lulTCQ4VenlRkOc3/HenQDMs3gyYqF8Paq82JaADF8T0olsWuBDSIH82g
         RBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0NHwgBSUws38Es7Xi/rZX05Xqj++OpNble994Q4twz8=;
        b=ZyEl0yV1hiG1AGGN27UkuhLnQ0+ju+tRliUDHrp05Ay+TUVmQM6X/GDZPcWTiXlkGm
         i9JZ1kUGexlb8SuEvfoIXTMcGqukq1eiafCQz9/K1qsFjKz1a/wBmwmroYLiDFL81nr1
         UtegWoNcyseoxelYf0Rv9zPGBPMgXOJUsJJdIUo/e/HiECA5lYi/DogOZinGKgqY9l5T
         QTSv+Ym/fmsUEN6oh9Y+YGpybzujszapjN9yQYl/fTUnfBSV2m72am1JX9/QrolKyjo8
         t8HPVszEAFtlbrqE39+tJE32kohRmTlbOThfc7pIgRbpITdJTFkwweA6KcRo3gqXXYiI
         vHmQ==
X-Gm-Message-State: APjAAAXu558n4CGs0zua3JgKhg5ouc0xklstHQRVJrXbt7jFZujhcFv0
        o0uM+A1RWA6UaDldOkUoOZs=
X-Google-Smtp-Source: APXvYqy6agudNWkX1IVOAditiOZUSDYrvFhjkwzj3/rM6+m7on3EEcqbwap2TkpnfGhY2DRwUzliEA==
X-Received: by 2002:adf:fbc1:: with SMTP id d1mr18273847wrs.267.1574429135841;
        Fri, 22 Nov 2019 05:25:35 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id g74sm3414148wme.5.2019.11.22.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 05:25:34 -0800 (PST)
Date:   Fri, 22 Nov 2019 14:25:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 6/6] arm64: tegra: Add support for PCIe endpoint mode in
 P2972-0000 platform
Message-ID: <20191122132533.GD1315704@ulmo>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20191122104505.8986-7-vidyas@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2019 at 04:15:05PM +0530, Vidya Sagar wrote:
> Add endpoint mode support for PCIe C5 controller in P2972-0000 platform
> with information about supplies, PHY, PERST GPIO and GPIO that controls
> PCIe reference clock coming from the host system.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/ar=
m64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index 7eb64b816e08..58c3a9677bc8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -43,6 +43,19 @@
> =20
>  		gpio@c2f0000 {
>  			status =3D "okay";
> +			/*
> +			 * Change the below node's status to 'okay' when
> +			 * PCIe C5 controller is enabled to operate in endpoint
> +			 * to allow REFCLK from the host system to flow into
> +			 * the controller.
> +			 */
> +			pex-refclk-sel-high {
> +				gpio-hog;
> +				output-high;
> +				gpios =3D <TEGRA194_AON_GPIO(AA, 5) 0>;
> +				label =3D "pex_refclk_sel_high";
> +				status =3D "disabled";
> +			};

Why don't we put this into the PCIe controller's node as a reference to
that GPIO? Seems like the controller would know exactly when this pin
needs to go high or low, so why does it have to be a hog?

Thierry

>  		};
> =20
>  		pwm@c340000 {
> @@ -144,6 +157,22 @@
>  			    "p2u-5", "p2u-6", "p2u-7";
>  	};
> =20
> +	pcie_ep@141a0000 {
> +		status =3D "disabled";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		nvidia,pex-rst-gpio =3D <&gpio TEGRA194_MAIN_GPIO(GG, 1)
> +					GPIO_ACTIVE_LOW>;
> +
> +		phys =3D <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
> +		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
> +		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
> +
> +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
> +			    "p2u-5", "p2u-6", "p2u-7";
> +	};
> +
>  	fan: fan {
>  		compatible =3D "pwm-fan";
>  		pwms =3D <&pwm4 0 45334>;
> --=20
> 2.17.1
>=20

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3X4c0ACgkQ3SOs138+
s6ExNQ//WK62BmgmHIoNRd5DoXDTiVMFPJTXYrKK2KEpJs39EqwfkZAYEPlfb5Si
4vAm7OchTFGLzcRQRxYlVS5ZHo9eDkHAE7pKUKkgm3Li6QTvGXlt7oRsiVv1luJx
AoqNX99LtHkgEBSLFnVIgpsstcX1Jx3DDkwjO+IINkJf+Et2GLU0Y1ez932QXf6r
eN343fUsKg5+bcIqk2hLnWCCaPe3YR9sYpRJF6psoHPOHgb4o3k7lGKUqwRHCPAB
qAq3iOral1OmZ+GQ06d3/OZHI33QG2UOqOhTTw+Xw67QernnguTI+jBAiTAZD62Y
jdIJ3X6M2t93o7yTwczq4IaTy46lktLeEXWoIWOPQiIuFWQhylfDGjVPv8Qin9JG
Ru9qCZXi1WWIDZGo99ZPB7iIyPPCB4T0cGR+nNH5i+PC4N5/6EfCXjg9gL33HB9n
brPkgl21YRmVt6JU04pKxCjcrajsR570CwfS5VMa4y6pImJiYP6cdfxdJ9Om0hei
sEmduQY1iRmoYthWXBgb3VIpZdd38nhaId4LbWhFHHObI5VZWvI1rgtkf7eq3mUV
tQEqkdpr7cLPdqjvEMf/0rffGC6UVeyeA2y7jSyHkKjrwMADSTysQz2YPtQenUhn
RRey8lUXMdiZ0XueNYIxYxijYYd1JhnVidJEfEK+FVR+59j0UHA=
=aw/J
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
