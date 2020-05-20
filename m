Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7601DB568
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 15:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETNoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 09:44:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:51768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgETNoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 09:44:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B59DCAC46;
        Wed, 20 May 2020 13:44:20 +0000 (UTC)
Message-ID: <4a49e7724e9a12e4f128a5e9ff4181da7af40bd3.camel@suse.de>
Subject: Re: [PATCH 14/15] PCI: brcmstb: Set bus max burst side by chip type
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 20 May 2020 15:44:16 +0200
In-Reply-To: <20200519203419.12369-15-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
         <20200519203419.12369-15-james.quinlan@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-67gf22uKBltY92+BH4yY"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-67gf22uKBltY92+BH4yY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-19 at 16:34 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
>=20
> The proper value of the parameter SCB_MAX_BURST_SIZE varies
> per chip.  The 2711 family requires 128B whereas other devices
> can employ 512.  The assignment is complicated by the fact
> that the values for this two-bit field have different meanings;
>=20
>   Value   Type_Generic    Type_7278
>=20
>      00       Reserved         128B
>      01           128B         256B
>      10           256B         512B
>      11           512B     Reserved
>=20
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-brcmstb.c
> b/drivers/pci/controller/pcie-brcmstb.c
> index 7bf945efd71b..0dfa1bbd9764 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -53,7 +53,7 @@
>  #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
>  #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
>  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
> -#define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
> +
>  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
>  #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
>  #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
> @@ -276,6 +276,7 @@ struct brcm_pcie {
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> +	const struct of_device_id *of_id;
>  };
> =20
>  /*
> @@ -841,7 +842,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	int num_out_wins =3D 0;
>  	u16 nlw, cls, lnksta;
>  	int i, ret, memc;
> -	u32 tmp, aspm_support;
> +	u32 tmp, burst, aspm_support;
> =20
>  	/* Reset the bridge */
>  	brcm_pcie_bridge_sw_init_set(pcie, 1);
> @@ -857,10 +858,20 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	/* Wait for SerDes to be stable */
>  	usleep_range(100, 200);
> =20
> +	/*
> +	 * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
> +	 * is encoded as 0=3D128, 1=3D256, 2=3D512, 3=3DRsvd, for BCM7278 it
> +	 * is encoded as 0=3DRsvd, 1=3D128, 2=3D256, 3=3D512.
> +	 */
> +	if (strcmp(pcie->of_id->compatible, "brcm,bcm2711-pcie") =3D=3D 0)

Would it make sense to use pcie->type here? I know GENERIC !=3D BCM2711, bu=
t we
could define it and avoid adding redundant info in struct brcm_pcie.

Regards,
Nicolas

> +		burst =3D 0x0; /* 128B */
> +	else
> +		burst =3D (pcie->type =3D=3D BCM7278) ? 0x3 : 0x2; /* 512 bytes */
> +
>  	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
> -	u32p_replace_bits(&tmp, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128,
> +	u32p_replace_bits(&tmp, burst,
>  			  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
> =20
> @@ -1200,6 +1211,7 @@ static int brcm_pcie_probe(struct platform_device *=
pdev)
>  	pcie->reg_offsets =3D data->offsets;
>  	pcie->reg_field_info =3D data->reg_field_info;
>  	pcie->type =3D data->type;
> +	pcie->of_id =3D of_id;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pcie->base =3D devm_ioremap_resource(&pdev->dev, res);


--=-67gf22uKBltY92+BH4yY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7FNDAACgkQlfZmHno8
x/5Lpwf/eAOpwSlhLavh+bn9QboXcCi13EVtwNjwBha1uical8dcFXceMgfJOJVm
7x35rF6gyugDp+uKGHdsG9q71U/R4VLiwdGJrsCYYgFa+8RALwAXNqefb3kmyFIt
GSh8WzRkKUSR4/5Py6TfcgxWJ4ATyzSRwXIJ8KTOPEt73GFPgKyQFmfCthpvD8as
iVdWqU6HmzlhsNPPgH98RCZ7d4lIAlN4VjhayR7A3QO2mBoQqtX3xyBGKM5Wzu9w
vfRTV1Wnb3nFeK3ly+iGGCUJG1vWtDIWZFNSNHxmjgqKLiS9Lp7HgrWXAOpUZJ/J
9dDEJKpEi1M3rhu+p8ItSk3hat7sTg==
=pmwt
-----END PGP SIGNATURE-----

--=-67gf22uKBltY92+BH4yY--

