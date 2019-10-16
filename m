Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76809D96EB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393818AbfJPQT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 12:19:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37010 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJPQT2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 12:19:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so3437285wmc.2;
        Wed, 16 Oct 2019 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DePY+vd4CjRqNFClvgu0HEDLinybeEc/aYWJ2h0z7BU=;
        b=E1iBpF2AGWUiFRx3XaIfiOP0Gt8lL91/ccFuACx91vHthjRam+9ld0bu/ojzEkqtgB
         YqteocE9aoljJs/8AsW90LoWzAUGPlJ2pLBBG9QGer1+qmWjjaubAfx2qHUx+xeBI4ni
         vW4YS5M/XA21+hrlJAVp4caPOuJe1B9m/T4aC2UNLW1mTsDo8Pp+ICVomxoCeCIVlIHk
         MZzLsQsQr1ON5NGgaJZPBiTY87sMBvCt3TV7adw//O4wM8wkob+yGvGhehFZ163adqcG
         JAryEidJaWF33Ye6mqvBlZFaPaJkakMI77atgkDo/ATylRLBdDKKv81aTOye0IO2i3Wl
         qk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DePY+vd4CjRqNFClvgu0HEDLinybeEc/aYWJ2h0z7BU=;
        b=lBDU3kK84Sm/CuP7W9hvgvQbNE4TKRhPTU3xvRQ9ZFHbF1qFewriAcc1mp757KcQNd
         +SwpbjmoGux0dsRrS9fc+OFc+VOpAAcBzOWkoW3dgk9jPxv4MhHBZvm1vloyEB7qo1xa
         JdDNrUOAWvUOe9ZSL3gpvXvm+5jH808gtnxBDGieBRYJrtMm8pmkyT6TFptCKD4lMs9R
         cSVsfS7U8J3xySuc8+bBQDti0bbx4LZDXUe2qR8blQbC/QrCCwIHqWAptyffQzxVh9tG
         ycsd77AdvJu2LLVQUax358Na6+BH5koua+MqCdxfgEE5iaZv9ruUAjZM97lFtNeSbw2f
         erCg==
X-Gm-Message-State: APjAAAU9R+PeLTKASizFGVnGVzb4H3DFUQ77s9tMnKiyecibNlkdrd/7
        lZ1FvDLfzzYEmgkNSl/jmmI=
X-Google-Smtp-Source: APXvYqzZfR0uIAdhsAhB1DocvPRZKquR4DWTYHM+2m9sDni/Be1CRMbNuYHuyf9JeRQcV75hbzbVNw==
X-Received: by 2002:a1c:9e07:: with SMTP id h7mr4246374wme.96.1571242764842;
        Wed, 16 Oct 2019 09:19:24 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r13sm38495943wrn.0.2019.10.16.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:19:22 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:19:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 1/2] PCI: tegra: Fix CLKREQ dependency programming
Message-ID: <20191016161920.GA2526111@ulmo>
References: <20191005164212.3646-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20191005164212.3646-1-vidyas@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2019 at 10:12:11PM +0530, Vidya Sagar wrote:
> Corrects the programming to provide REFCLK to the downstream device
> when there is no CLKREQ sideband signal routing present from root port
> to the endpont.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index f89f5acee72d..cbe95f0ea0ca 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -40,8 +40,6 @@
>  #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
>  #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
>  #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
> -#define APPL_PINMUX_CLKREQ_OUT_OVRD_EN		BIT(9)
> -#define APPL_PINMUX_CLKREQ_OUT_OVRD		BIT(10)
> =20
>  #define APPL_CTRL				0x4
>  #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
> @@ -1193,8 +1191,8 @@ static int tegra_pcie_config_controller(struct tegr=
a_pcie_dw *pcie,
> =20
>  	if (!pcie->supports_clkreq) {
>  		val =3D appl_readl(pcie, APPL_PINMUX);
> -		val |=3D APPL_PINMUX_CLKREQ_OUT_OVRD_EN;
> -		val |=3D APPL_PINMUX_CLKREQ_OUT_OVRD;
> +		val |=3D APPL_PINMUX_CLKREQ_OVERRIDE_EN;
> +		val &=3D ~APPL_PINMUX_CLKREQ_OVERRIDE;
>  		appl_writel(pcie, val, APPL_PINMUX);
>  	}

If we do support CLKREQ, do we have to explicitly set the OVERRIDE bit?
Or clear the OVERRIDE_EN bit? Is it always guaranteed that the defaults
(OVERRIDE_EN =3D 0) is applied at this point?

That's an issue that's orthogonal to this patch, though, so for this
one:

Acked-by: Thierry Reding <treding@nvidia.com>

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nQwMACgkQ3SOs138+
s6E8BQ/9G0VANNqYdS++3CnPnN8WpRzZ5X80eDfGsloeyXEpgMYt6+9yOAtm0JTO
3LKUqhWTtoxqnN9FqF6rTVhrfI+m7Wm2clBufTkX9OfDuRkFN4OD9bXBvWcNm43T
esUpA3PPPPPcjN+b2vGG7iSc95ZkbJdf6+9RpehqEe308SFcftIwHgMww4AFVVv8
3zATGvVSqU9oOK8J5TTVvKjlJ6JatSniwIUWj6GM8JdKduvD3qcua5BHOmRqgYJh
J+OApeTRDjRdeSRyPQuiTN8ByBp01Z228OBGoRsdTqnypLq5lNV5WGT4P9bywFVV
4+D99VAgL1qtSNlaJqxLUBiNjTDIGrkK6Z/pc1sgUVQdotLPjD47Vfh8URTskzz4
u2k2IRuowNPRpKV/7zto23j7PS10tOKCfTi63/+RVj+rahp4ACGAJy1Mn9dU3Zai
3zorkVVE02mUOsj5VKB9JQIetrqoxt+LLf+cjOZDfr8H+ehtDWIsb9b4QWFXlm5Q
4xgpPD9Uuw6pSfEd+qCT7VkudCwqYFsvyGjHVSfaL0/nHadHy+8cLGDb0tWBXUTY
8pMI8klIWZ0OUn2j/KPTj+x+dWalfEmS/5Ez/fM8IZpxOzQSHgd1VJAwmZTuChUR
vJhRao5glT/alH6W+G/yhGIKVpWDL1ZTeF35/ibVHqKOxi1JxV0=
=schF
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
