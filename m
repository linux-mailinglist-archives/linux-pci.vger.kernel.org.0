Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BFE22233D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGPNAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgGPNAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 09:00:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F252C061755;
        Thu, 16 Jul 2020 06:00:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so6433944ejc.8;
        Thu, 16 Jul 2020 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wyNClx2HVjapyhGcNIWDV4ScP7ULx68JRSSlXC1OVHE=;
        b=oaTu0FjpuT+NKl2OyV2efLc/8BJZShIrmgwd+Ln6PGwrvNVV7fTDae6ibqI0x/qDX5
         MPcLTueTDTnQup1a5N5Z+oWCtxbGtiaaxiK0cH9nB6iRnUacTEGcMkNpeOOrICGwzMgQ
         wFqs034fsx5Prjed7IRo0lJ42HqJOFOdCIGujWsZjt4sTewXZPJjAzL8lBH/UqwFhqqQ
         HQfkce9DgMNdeKcmtoL1TeknEk0FURozfWrJJZplbuO6CZSF5Muan/RcDP2oHhlmEq7I
         /jwXBhpEBsYlOuf7wbz8mv/ofCwkIfg9pjRenCLLk2hWWCOI/3MlyJyFCf2cFkFIK5C+
         oF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wyNClx2HVjapyhGcNIWDV4ScP7ULx68JRSSlXC1OVHE=;
        b=tNyYZUg2EALsASLtF+LIyCqF2yCMIOe2Gw4PJEFpugbP2TzcOKrBRBseMy2+9XHMCU
         8pGT4JdSnNGHqeehaQrvrDV0xieXOVtt1+xQdT5jEqQKkXOQhsvhaXuRzojffjpbYcZo
         7uOExOO+CrLBSRlvgrXMLJU19YbsA8OsgT99qMGgUs0lOXAt8PLdzEYBrkObd2Tzu3UI
         vV7IMvWYoAqGFVHvygq8xnXbPZYyaRUJHpPLUYzK9OzM8JF/gTsuywgnJmwx4F5oAdOr
         qTNBVVH+q2xkMcAcKwb16EUdc/M76m+woT9t8rdcPTVg8wp+kgyc9Lgye+2danNnXmMT
         rMrA==
X-Gm-Message-State: AOAM533lKyTcwFovG5Z/bNxELLRjmKtJDw/QkXU1OJEyPV5iS9me5JiL
        SyC7REdUuiMpsxeNEd4isUApXlSA
X-Google-Smtp-Source: ABdhPJwvwf2S3xWM/6ktn9Lb82FKyGCGRyt4pmWBKQCMQt+8aR52GW1/E41eRRPoOwri7cOvgCWKMQ==
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr3768793ejk.290.1594904438845;
        Thu, 16 Jul 2020 06:00:38 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id e4sm5050994ejx.76.2020.07.16.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:00:35 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:00:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: tegra: Remove PLL power supplies
Message-ID: <20200716130034.GE535268@ulmo>
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
 <20200623145528.1658337-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20200623145528.1658337-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 04:55:28PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The Tegra PCI controller driver doesn't need to control the PLL power
> supplies directly, but rather uses the pads provided by the XUSB pad
> controller, which in turn is responsible for supplying power to the
> PLLs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Hi Lorenzo,

do you have any comments on this? Can we get this into v5.9?

Thanks,
Thierry

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 235b456698fc..f87a09d21eb0 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2025,7 +2025,7 @@ static int tegra_pcie_get_regulators(struct tegra_p=
cie *pcie, u32 lane_mask)
>  		pcie->supplies[i++].supply =3D "hvdd-pex";
>  		pcie->supplies[i++].supply =3D "vddio-pexctl-aud";
>  	} else if (of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
> -		pcie->num_supplies =3D 6;
> +		pcie->num_supplies =3D 3;
> =20
>  		pcie->supplies =3D devm_kcalloc(pcie->dev, pcie->num_supplies,
>  					      sizeof(*pcie->supplies),
> @@ -2033,14 +2033,11 @@ static int tegra_pcie_get_regulators(struct tegra=
_pcie *pcie, u32 lane_mask)
>  		if (!pcie->supplies)
>  			return -ENOMEM;
> =20
> -		pcie->supplies[i++].supply =3D "avdd-pll-uerefe";
>  		pcie->supplies[i++].supply =3D "hvddio-pex";
>  		pcie->supplies[i++].supply =3D "dvddio-pex";
> -		pcie->supplies[i++].supply =3D "dvdd-pex-pll";
> -		pcie->supplies[i++].supply =3D "hvdd-pex-pll-e";
>  		pcie->supplies[i++].supply =3D "vddio-pex-ctl";
>  	} else if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
> -		pcie->num_supplies =3D 7;
> +		pcie->num_supplies =3D 4;
> =20
>  		pcie->supplies =3D devm_kcalloc(dev, pcie->num_supplies,
>  					      sizeof(*pcie->supplies),
> @@ -2050,11 +2047,8 @@ static int tegra_pcie_get_regulators(struct tegra_=
pcie *pcie, u32 lane_mask)
> =20
>  		pcie->supplies[i++].supply =3D "avddio-pex";
>  		pcie->supplies[i++].supply =3D "dvddio-pex";
> -		pcie->supplies[i++].supply =3D "avdd-pex-pll";
>  		pcie->supplies[i++].supply =3D "hvdd-pex";
> -		pcie->supplies[i++].supply =3D "hvdd-pex-pll-e";
>  		pcie->supplies[i++].supply =3D "vddio-pex-ctl";
> -		pcie->supplies[i++].supply =3D "avdd-pll-erefe";
>  	} else if (of_device_is_compatible(np, "nvidia,tegra30-pcie")) {
>  		bool need_pexa =3D false, need_pexb =3D false;
> =20
> --=20
> 2.27.0
>=20

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8QT3IACgkQ3SOs138+
s6EuqxAAmbuhEZ73eykpJoyukSD0EIbLgRuPnj9vhKPQFXy7MYsbMqCX8t/T41eM
5SoxSB6uAZ73QqLWsx8OnzwJwwTRJYBVUQ19mA7YV31NL4BPER6RnreAX1JGhOt1
pWJrzNvYK1EwQJVwPUh1eal4vg2psQeFJevJmiokHwP7f6ylVOx04tK5jdq0BneH
nes+VllTvszh7dAURzlEg9vZ7sFFo5am4GBCgnL+WmXkMhB2PRcxdZTvpmcvS8FX
OR5Na17hyKDeWldpcpqhErfkkPozXnZ3KeanpIoiMk2sFRXuyM/qP4fYPtNc0oKB
PtjTf1ByAOc6sTSemCYF6OCp6WGulpjdBiJfNKUTIXZig5Stcwetu8OcI5QdiVwP
ztA7wCbbTmYecH+1/jqgNoLzSq/ZDKIze7uwmk9eLimHJa0Vf8c8XojqoTonVjUQ
iEZGKmRnFHfIzgc6hiWGmL54ZVfWdIEPsEydpulEtgQUd/sxaBdXCxLNzS+0eoFl
fX2I7WmvQHfQEb4B6H8/i5iMRVvSIWskivjkYcHvLDFKzn3HmUPlp2z9PnuKrvcp
xEZllBdRf7CRUD/yg5tdfhFtHRL7T4qzn1BZZP2Aam887xC4DR3EYN7UMpUJtSMS
iABYTTAj9cqr8Ev52nwLcGZ4DHGSHx2Nr/63KTDM5dMRuYtEcT0=
=Sp/M
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
