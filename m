Return-Path: <linux-pci+bounces-17063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD39D2169
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9466B21B20
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821919ABBB;
	Tue, 19 Nov 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMqtFtQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D319AA68
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004149; cv=none; b=GjdEodkBoMkkHY761P5XkPZ8YHxW2U0lAqJmSjm4GhZw3NpT8NBOeb9ipc60arNICpTQ4WlCXP/dbWZJF9FUpJOOW0MDGJN9fycigDtJd8ZtJcviuq5KXG04+i9onPdZRqXl/I4j5yra7+OcFORTNStYlBd3fo/MZqSPIuzfbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004149; c=relaxed/simple;
	bh=ejBrNZZPHW9XhE6WU+WW7+dWvdcRTPCPgQ6keHGeN8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjCC/NWV/tEuJ00FiHrDvb0afnAIqMjMbBCKgHArgxG0ZAaRE+fd0JqZaz8q8baTIeckZVzJVbSCi8nSmzUTEmGFiSTZl6eg/CX0uFsqlcNFoZWwIyRvfzs4T0RKYFqAIjRaxwl+cwJjupw/cFvBXqkzAUf7WGrX/tzZEgZjIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMqtFtQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CD0C4CECF;
	Tue, 19 Nov 2024 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732004148;
	bh=ejBrNZZPHW9XhE6WU+WW7+dWvdcRTPCPgQ6keHGeN8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMqtFtQMQ7GJofz2J1aN+IQ8uJX2UE4HAUA443syTNnq6pNXp1NwWZb9+3HTRYbnS
	 4GeVy4YKnB4gMVTyLk1enflzHoqzDpoyUKuPsF6P0JUsCefkkRxIeXtHxpHU80Rb/W
	 oOI1rdKrjVWGWBw1yb+A51Knat6r4STg2kdCPQQqDYsw8176RZMnem9QkKSDDeBx2L
	 9T91sno/xAFl15q+oPDsHvXm/hhC8sq4uEL54uMPwROROHZ+cJezsniWOk2JX1YOql
	 HsJPfHElGMj58qHJCawxtN468ji3lyXZM3xbVY8pxMPG+r8j77klXtWvF725qoCQbn
	 nsU57w3VxIVIw==
Date: Tue, 19 Nov 2024 09:15:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <ZzxJMbWkV1OELEID@lore-desk>
References: <20241113-pcie-en7581-rst-fix-v3-1-23c5082335f7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oWqVrS/inJW1ZEom"
Content-Disposition: inline
In-Reply-To: <20241113-pcie-en7581-rst-fix-v3-1-23c5082335f7@kernel.org>


--oWqVrS/inJW1ZEom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> causing occasional PCIe link down issues. In order to overcome the
> problem, PCIE_RSTB signals are not asserted/released during device probe =
or
> suspend/resume phase and the PCIe block is reset using REG_PCI_CONTROL
> (0x88) and REG_RESET_CONTROL (0x834) registers available in the clock
> module running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
>=20
> Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> specify per-SoC capabilities.
>=20
> Tested-by: Hui Ma <hui.ma@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Jianjun and Bjorn,

any news about this patch? Thanks in advance.

Regards,
Lorenzo

> ---
> Changes in v3:
> - cosmetics
> - Link to v2: https://lore.kernel.org/r/20241104-pcie-en7581-rst-fix-v2-1=
-ffe5839c76d8@kernel.org
>=20
> Changes in v2:
> - introduce flags field in mtk_gen3_pcie_flags struct instead of adding
>   reset callback
> - fix the leftover case in mtk_pcie_suspend_noirq routine
> - add more comments
> - Link to v1: https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1-1=
-1043fb63ffc9@kernel.org
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 60 ++++++++++++++++++++---=
------
>  1 file changed, 42 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index 16a55711a7f3bdc8d6620029e3d2cfdd40b537b7..443072adb9b52a6934a5d1e38=
eb6fca5f86a1e13 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -128,10 +128,18 @@
> =20
>  struct mtk_gen3_pcie;
> =20
> +enum mtk_gen3_pcie_flags {
> +	SKIP_PCIE_RSTB	=3D BIT(0), /* skip PCIE_RSTB signals configuration
> +				   * during device probing or suspend/resume
> +				   * phase in order to avoid hw bugs/issues.
> +				   */
> +};
> +
>  /**
>   * struct mtk_gen3_pcie_pdata - differentiate between host generations
>   * @power_up: pcie power_up callback
>   * @phy_resets: phy reset lines SoC data.
> + * @flags: pcie device flags.
>   */
>  struct mtk_gen3_pcie_pdata {
>  	int (*power_up)(struct mtk_gen3_pcie *pcie);
> @@ -139,6 +147,7 @@ struct mtk_gen3_pcie_pdata {
>  		const char *id[MAX_NUM_PHY_RESETS];
>  		int num_resets;
>  	} phy_resets;
> +	u32 flags;
>  };
> =20
>  /**
> @@ -405,22 +414,34 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pc=
ie *pcie)
>  	val |=3D PCIE_DISABLE_DVFSRC_VLT_REQ;
>  	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
> =20
> -	/* Assert all reset signals */
> -	val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> -	val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> -
>  	/*
> -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> -	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> -	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> -	 * for the power and clock to become stable.
> +	 * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> +	 * causing occasional PCIe link down. In order to overcome the issue,
> +	 * PCIE_RSTB signals are not asserted/released at this stage and the
> +	 * PCIe block is reset configuting REG_PCI_CONTROL (0x88) and
> +	 * REG_RESET_CONTROL (0x834) registers available in the clock module
> +	 * running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
>  	 */
> -	msleep(100);
> -
> -	/* De-assert reset signals */
> -	val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB=
);
> -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> +		/* Assert all reset signals */
> +		val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> +		val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> +		       PCIE_PE_RSTB;
> +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +
> +		/*
> +		 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> +		 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> +		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> +		 * for the power and clock to become stable.
> +		 */
> +		msleep(PCIE_T_PVPERL_MS);
> +
> +		/* De-assert reset signals */
> +		val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> +			 PCIE_PE_RSTB);
> +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	}
> =20
>  	/* Check if the link is up or not */
>  	err =3D readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
> @@ -1179,10 +1200,12 @@ static int mtk_pcie_suspend_noirq(struct device *=
dev)
>  		return err;
>  	}
> =20
> -	/* Pull down the PERST# pin */
> -	val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> -	val |=3D PCIE_PE_RSTB;
> -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> +		/* Pull down the PERST# pin */
> +		val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> +		val |=3D PCIE_PE_RSTB;
> +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	}
> =20
>  	dev_dbg(pcie->dev, "entered L2 states successfully");
> =20
> @@ -1233,6 +1256,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_so=
c_en7581 =3D {
>  		.id[2] =3D "phy-lane2",
>  		.num_resets =3D 3,
>  	},
> +	.flags =3D SKIP_PCIE_RSTB,
>  };
> =20
>  static const struct of_device_id mtk_pcie_of_match[] =3D {
>=20
> ---
> base-commit: ff80d707f3cb5e8d9ec0739e0e5ed42dea179125
> change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--oWqVrS/inJW1ZEom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZzxJMQAKCRA6cBh0uS2t
rODiAQCGocPFNzuQfGPZrdtN1u3PEY2gdZEL4k92plmNdYqaFwD/YOgoQZifIClN
PzTooz0Twz8NFgekhlISf3wT485sFwk=
=oXff
-----END PGP SIGNATURE-----

--oWqVrS/inJW1ZEom--

