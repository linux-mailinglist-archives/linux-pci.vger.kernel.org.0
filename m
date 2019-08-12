Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDDC89B5E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 12:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfHLKXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 06:23:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42750 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfHLKXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 06:23:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so7370293wrq.9;
        Mon, 12 Aug 2019 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MTiHtsvt5NhSEME25nXCrgva1MRgamkEFmaJPkZIx4w=;
        b=AjCxPLPCs5zOInkjESEXueg3dRHlkj8W/McUs0U+BiyZAAx3fiOpO9n7YUlq2uSzbL
         PDxlVAbxxKpuwXFHPWbT40/Wc07o90dvUFYO80VwftE8WJt8wZWrIN40BII0iXOCnKbf
         slnbwe8jSQt3acptM9RdKLs+g+9oG2aBRyE+1Pd1c31vH8rXAFDs43+cybT/ayVay+97
         08apvAHi52MImdRLZlosiTvpat+YkfT74LsMmhHLVciaj+ow7AL6VoRxbdBez7fn7Yoc
         vl+oZJEN9rUY7DYOYuiij1AC00ipPTh4iZjBpN/h4wQKY0otnT54HY/rcm0PzJqAi71d
         Szww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MTiHtsvt5NhSEME25nXCrgva1MRgamkEFmaJPkZIx4w=;
        b=qL9G6FZd5gjFEm7d9itmIDVh3bzWsGPX1k4Ydrzph6zSNnKMjHXi6bR38fA1TDb6Ee
         yZoe6/VS1Qm9HnjiMcUH0yBRhxoHIHiRp9l+wUm1UcrYTzD3Nydn6oYBEuVmzh0svz0+
         34vvX4wVoYNzqd60p5xRVrNV7a4xjVGwiBA8J7xZQH37y4n9UbrwH9f0iSLdp9PNobzP
         tExAP5fke0jBqlT0AYGOOsEUgcM30idFWJjuV+gk0wzk2y8Yb5xJEawYmUL3EeAEVQOK
         MwEYrdx4Cy+02hjomBdXnwoAgNG46Ze+QRECmFnFl7tMjYKPAr2sf/WLa2mCwWksNj5Y
         yFxw==
X-Gm-Message-State: APjAAAVoz5DSvy/0Plyk03YdjVQC6Td2rj8mwimHoUXb2nT9vvTOhMtC
        YYQiafX3WJqFhXb6+3mQEGI=
X-Google-Smtp-Source: APXvYqw8ewrkG14Pe2lRIqxXus+F0QYZWt3csjZLIT7tSFq3ITwXIBiyhaMB3csWtIQ680aBgkgtJg==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr18996501wrw.127.1565605382076;
        Mon, 12 Aug 2019 03:23:02 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id l3sm24553705wrb.41.2019.08.12.03.23.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:23:00 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:23:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V15 12/13] phy: tegra: Add PCIe PIPE2UPHY support
Message-ID: <20190812102300.GM8903@ulmo>
References: <20190809044609.20401-1-vidyas@nvidia.com>
 <20190809044609.20401-13-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GeONROBiaq1zPAtT"
Content-Disposition: inline
In-Reply-To: <20190809044609.20401-13-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--GeONROBiaq1zPAtT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 10:16:08AM +0530, Vidya Sagar wrote:
> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
> For each PCIe lane of a controller, there is a P2U unit instantiated at
> hardware level. This driver provides support for the programming required
> for each P2U that is going to be used for a PCIe controller.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> V15:
> * None
>=20
> V14:
> * None
>=20
> V13:
> * None
>=20
> V12:
> * None
>=20
> V11:
> * Replaced PTR_ERR_OR_ZERO() with PTR_ERR() as the check for zero is alre=
ady
>   present in the code.
>=20
> V10:
> * Used _relaxed() versions of readl() & writel()
>=20
> V9:
> * Made it dependent on ARCH_TEGRA_194_SOC directly instead of ARCH_TEGRA
>=20
> V8:
> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-p=
2u.c
>=20
> V7:
> * None
>=20
> V6:
> * Addressed review comments from Thierry
>=20
> V5:
> * None
>=20
> V4:
> * Rebased on top of linux-next top of the tree
>=20
> V3:
> * Replaced spaces with tabs in Kconfig file
> * Sorted header file inclusion alphabetically
>=20
> V2:
> * Added COMPILE_TEST in Kconfig
> * Removed empty phy_ops implementations
> * Modified code according to DT documentation file modifications
>=20
>  drivers/phy/tegra/Kconfig            |   7 ++
>  drivers/phy/tegra/Makefile           |   1 +
>  drivers/phy/tegra/phy-tegra194-p2u.c | 120 +++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c

Acked-by: Thierry Reding <treding@nvidia.com>

--GeONROBiaq1zPAtT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RPgMACgkQ3SOs138+
s6G6QRAApZ8Wo+dLU8yIc2xUpt31Zb4Mt89cHlgrBXMadX3WQGRdKFxNtS63hucq
6bj/FGGojkXhuiFBY4vaRnhhWFEeUi8khH+gCiKHEq4f8ENNpPRF3nC11/ISDQlt
rYB0lB0edwd7ZVso8KVs8LAXPO/qg3hF2UsriGDYyHIzhgNrpAqGtue+RbgfoXic
uzcPDzhaXgcSls0JkMrQrqdb3I7dH/VrPXs4Y9FdbnHb4OaaSpDRiyR1M0e+j5Rs
uBA3+qz84CGVEzUCmLakD52NbtEW1SJj2x3LfKe2LzjlR03p8p8q0+L7UbCP3OdM
SNOB+VD+FCCQ2uH0aJMn1U4t/pAp16NuDSWlJxXXx8Pn/auq1nyYgluYyyArWNJO
K1Y93Tr3DmEwzv67v8nXQqP7nyFj/Rn0XapYHt9JmjpBsFuZC9vh9lJ+m0lplJir
LYFt0sZYyP/aYr6EmNwPE4fOsgW9++yXP68WqaS7YmL+Mr7Xek+ojJqi6t65J6K+
QxIczmLN+hnkAr8RDjO1f5fClz2pIJRCt//HVwk2nMAr6aiSf4oKg0dAoxOW1q04
7d5Mfcivnqus2gm2w2g4qtnUH1hQ4zxUjDMbaNsYJTxtjwnUS01lA8M2F1eJpqJX
yTihfhNjw1i2pqoK4FD694YSFT3e/4toB0LG86K4ej9qfFcHcqI=
=HGLV
-----END PGP SIGNATURE-----

--GeONROBiaq1zPAtT--
