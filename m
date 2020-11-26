Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43D2C5310
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgKZLdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389236AbgKZLdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:33:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5867C0613D4;
        Thu, 26 Nov 2020 03:33:49 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so1785336wrn.3;
        Thu, 26 Nov 2020 03:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oAp7l2oWg98H/3nN+/gja5ac6cZTg55oVNc6+bd9Y8g=;
        b=ldT3bEM41UWe6TTWL9bxl052rCL3TPOdm8HuFhOvt2+LKYRGFypE4TA+ZjaocRm7XE
         MHfm6JjAuhpxmHgm03OSRCY7VNOOf8g9/KKQ48oXIYkyWEXKlkdyBVjNK77ljx3PGPli
         RjqprgfX5MaBbmOVax5W0M8UjF3OOzho5fo4BtvG5BB4EIgC4C7UFqGvoY0EtaTmgSVB
         X4xxTlP0Aixg3LyJ7LeeO27+tUZnn3GKGDkLQqUXZgBkOxIMMohnG8PmLfmN6Wk5zuhL
         GDjBke1X4IXHxMQPUsCcus4xGe/OKmfCRZwp+bSBJ4lDdF0WkVZgnTQMo4gLYpi+Crrw
         dPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oAp7l2oWg98H/3nN+/gja5ac6cZTg55oVNc6+bd9Y8g=;
        b=bUzDuCe6tGjWUXa02dV4Oh95QXEfzym9PxW0BbJmdWZ9awesF4iY4v6Fi5su5AQxxR
         oHd/z4KGntzMOVShgi5eVOvPTHQm18Z35iq500Z7lj4dKa2HB/8ITmrbNSZVIocT2+w+
         uS050iZt8JL9+BaplyUpZbRnXAPSq07Z7a1qS48Sh0Fjf2B5//t9pyb2C7NMG6r08oEH
         A35Z9AkhT5D0KhF/vMsRswaHKobYDuUWuXv1YClnL/2KvMnqY7PvA0SvvJbw2RGxPC1b
         aqd3uv5nALHeQRhYVtyElaatN3cHTT+jw/rgYymCbBqB1LFy2m5KEesjwYVdsD9zwuUm
         tuVA==
X-Gm-Message-State: AOAM531n77FaekketH/JEy8Z7kb2RQXvlKVJNBPDDjzQdAWbU6o0dvv6
        5KbscTBpAJEL+/l3jmuCw7AOn09o+ZQ=
X-Google-Smtp-Source: ABdhPJz9FXNNd02JNmM5/k3QQCoSOtOwyl2X1FLjP1GNgOMRjKhqcv4Dlz2enaqY6KKeRmTfYyB6eg==
X-Received: by 2002:adf:e544:: with SMTP id z4mr3394843wrm.83.1606390428668;
        Thu, 26 Nov 2020 03:33:48 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id t11sm8392397wmf.35.2020.11.26.03.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:33:47 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:33:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 2/6] PCI: tegra: Map configuration space as nGnRnE
Message-ID: <X7+SmtN+8T4HQb/M@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1uHNs3U+2+JtnK0v"
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-3-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--1uHNs3U+2+JtnK0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 10:49:33PM +0530, Vidya Sagar wrote:
> As specified in the comment for pci_remap_cfgspace() define in
> arch/arm64/include/asm/io.h file, PCIe configuration space should be
> mapped as nGnRnE. Hence changing to dev_pci_remap_cfgspace() from
> devm_ioremap_resource() for mapping DBI space as that is nothing but
> the root port's own configuration space.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * None
>=20
> V3:
> * None
>=20
> V2:
> * Changed 'Strongly Ordered' to 'nGnRnE'
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index b172b1d49713..7a0c64436861 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2108,7 +2108,9 @@ static int tegra_pcie_dw_probe(struct platform_devi=
ce *pdev)
>  	}
>  	pcie->dbi_res =3D dbi_res;
> =20
> -	pci->dbi_base =3D devm_ioremap_resource(dev, dbi_res);
> +	pci->dbi_base =3D devm_pci_remap_cfgspace(dev,
> +						dbi_res->start,
> +						resource_size(dbi_res));
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
> =20

Similarly to patch 1/6, this is no longer required because it's already
part of one of Rob's earlier patches, so this, too, can be dropped.

Thierry

--1uHNs3U+2+JtnK0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/kpoACgkQ3SOs138+
s6FSExAAr30Qy/vBX5DBl5fVA3FJkfeNDnUmzkwemY51MjQZsvbjc7NdbLfDrcaf
0UgdOICWxs+07FnROnyM3rQbOy3HDwqOV6AGlq+68P3FigHd5tdBRxNTi+8827gU
562X/fULH4g9qYmUyPuGl6Q5FrJNRedwfYR7s79eoVYkxxvfLMk0KSFemLUxPf8M
koduuwGmB2tQje3PgkmU6a/nA3wrrVwD6FC9KDhA5YPG6a1LRku/t1e6bpUBnyzk
TwE4s5OzWNZXR07BFQTLrIBE3dSHVSDMVQOKmtOtquBtlJ1bpVOFyY9gSwYx9LV3
1nnHtU+COmdj2d78yuR1Fbkzi1l5dfcmhe1tYX45FJfTVFnGUOrACKesKj0bZqbh
3DfiT7sVgS69EJKpqSJWUPRezeAMxCgvUqvrdZi3vXwZY1LPuOkqexM0rHkWnWZN
1OZI/zsdZJ8Pf49YUMNE1JG0G4PpgvEtkVdFUDVDsHi4MbevbZ6v4UJya5iPHVlW
LM3SBqPhnnM6dKg5bPoVqAETHbS7T6HTe6YL8R98hN0dIhF8T3GkMiRD4m92MCiJ
kYdYvsMyf0WGQT5GKIDcwmPd1OQrZzUcOrYP7tNOFBg3xhjzMGQGHqcCdd0itmXh
P3478M5nngyTcz7vgocQDQ14FUWnruLmDH88NfY0FGvbLZirNtI=
=qdzW
-----END PGP SIGNATURE-----

--1uHNs3U+2+JtnK0v--
