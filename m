Return-Path: <linux-pci+bounces-16105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E89BE179
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00CC1C22D48
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CB91922E8;
	Wed,  6 Nov 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuPtxo8Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA31D5AA8
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883625; cv=none; b=O24k4+hBAXuSXUKTE4Y9/8svyF8hDKKtgWPHZbL0U+MmfowKmUZHBCjAuqEeBuCI/ugnyaciapkxUFS0PhICKo+q0+wX71u3gHbnABaWF3URtbMS05+JMQDpAibXZvMZow5Of8iOnRDXe4eHiJKq/WWRrHWzN5SWetbRc8eNSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883625; c=relaxed/simple;
	bh=i4Ev19x4r1KpbvsNuBMn0gkQ2RGKLU2bi+TU9lP0swg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZpvqfP52I4YhgruVhZ/bHIS0XTGYJGHqRdbvNGb+yRqVaysI5vDsz/kVC/t/PkwNj8vyCZMqhbCseNT/adVHKihphkBY5NHGKHjGGUpYo4n7FAvsMoZco6XcOXozp3YAzgz1uUVn+XFLf+8xZ7gDVmsQwOUIqgMEKivOS5Kc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuPtxo8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2688DC4CECD;
	Wed,  6 Nov 2024 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883624;
	bh=i4Ev19x4r1KpbvsNuBMn0gkQ2RGKLU2bi+TU9lP0swg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuPtxo8QtJejlT7FWdhi+ZC8IzeIO6l6ngKU++Yr3bMu61u89/BFVWM6IkuiRj/tm
	 Pcyis3k88IwX3dPVP2WNjsUvuCDp9/kbzDSbJOMjjmgvcJ0ztAF4VQ5OncpJFfKHTI
	 3xIin/lcTQZxfqEXjsC+Qy2VbsLIHiOpgkk4xZpPEA9JR1c9qs8lkr7FRdyfQthBHd
	 6pFnyVA/w6D/J/KXtUrDJdPf84Ax5yJ/fuqknn3rD5/+I+C97Wk/4YOGfuMH2YiPCp
	 Ijt8Pmj9rhEJpOo5qZoKzdp3QlD4QlQS+aypv2rW5yO+gSSEm8kCDhF80YZ1GCuF3/
	 P0Y6ON40TqL9g==
Date: Wed, 6 Nov 2024 10:00:21 +0100
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
	Hui Ma =?utf-8?B?KOmprOaFpyk=?= <Hui.Ma@airoha.com>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	upstream <upstream@airoha.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <ZyswJbwWOaElvpdr@lore-desk>
References: <20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org>
 <f827f7c45094722aa3c254eda32ada157156444a.camel@mediatek.com>
 <Zynlw7wzyeucc2iT@lore-desk>
 <d6faf3f169c33d3c9c392c0cc4ef9efe517fdcdf.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27J7gfKq5EBYskZa"
Content-Disposition: inline
In-Reply-To: <d6faf3f169c33d3c9c392c0cc4ef9efe517fdcdf.camel@mediatek.com>


--27J7gfKq5EBYskZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 2024-11-05 at 10:30 +0100, lorenzo@kernel.org wrote:
> > > On Mon, 2024-11-04 at 23:00 +0100, Lorenzo Bianconi wrote:
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > >=20
> > > >=20
> > > > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB
> > > > signal
> > > > causing occasional PCIe link down issues. In order to overcome
> > > > the
> > > > problem, PCIE_RSTB signals are not asserted/released during
> > > > device
> > > > probe or
> > > > suspend/resume phase and the PCIe block is reset using
> > > > REG_PCI_CONTROL
> > > > (0x88) and REG_RESET_CONTROL (0x834) registers available via the
> > > > clock
> > > > module.
> > > > Introduce flags field in the mtk_gen3_pcie_pdata struct in order
> > > > to
> > > > specify per-SoC capabilities.
> > > >=20
> > > > Tested-by: Hui Ma <hui.ma@airoha.com>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > > Changes in v2:
> > > > - introduce flags field in mtk_gen3_pcie_flags struct instead of
> > > > adding
> > > >   reset callback
> > > > - fix the leftover case in mtk_pcie_suspend_noirq routine
> > > > - add more comments
> > > > - Link to v1:=20
> > > >=20
> https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@=
kernel.org
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek-gen3.c | 59
> > > > ++++++++++++++++++++---------
> > > >  1 file changed, 41 insertions(+), 18 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > index
> > > > 66ce4b5d309bb6d64618c70ac5e0a529e0910511..8e4704ff3509867fc0ff799
> > > > e9fb
> > > > 99e71e46756cd 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > @@ -125,10 +125,18 @@
> > > >=20
> > > >  struct mtk_gen3_pcie;
> > > >=20
> > > > +enum mtk_gen3_pcie_flags {
> > > > +       SKIP_PCIE_RSTB  =3D BIT(0), /* skip PCIE_RSTB signals
> > > > configuration
> > > > +                                  * during device probing or
> > > > suspend/resume
> > > > +                                  * phase in order to avoid hw
> > > > bugs/issues.
> > > > +                                  */
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct mtk_gen3_pcie_pdata - differentiate between host
> > > > generations
> > > >   * @power_up: pcie power_up callback
> > > >   * @phy_resets: phy reset lines SoC data.
> > > > + * @flags: pcie device flags.
> > > >   */
> > > >  struct mtk_gen3_pcie_pdata {
> > > >         int (*power_up)(struct mtk_gen3_pcie *pcie);
> > > > @@ -136,6 +144,7 @@ struct mtk_gen3_pcie_pdata {
> > > >                 const char *id[MAX_NUM_PHY_RESETS];
> > > >                 int num_resets;
> > > >         } phy_resets;
> > > > +       u32 flags;
> > > >  };
> > > >=20
> > > >  /**
> > > > @@ -402,22 +411,33 @@ static int mtk_pcie_startup_port(struct
> > > > mtk_gen3_pcie *pcie)
> > > >         val |=3D PCIE_DISABLE_DVFSRC_VLT_REQ;
> > > >         writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
> > > >=20
> > > > -       /* Assert all reset signals */
> > > > -       val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > > > -       val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > > > PCIE_PE_RSTB;
> > > > -       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > > > -
> > > >         /*
> > > > -        * Described in PCIe CEM specification sections 2.2
> > > > (PERST#
> > > > Signal)
> > > > -        * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > > > -        * The deassertion of PERST# should be delayed 100ms
> > > > (TPVPERL)
> > > > -        * for the power and clock to become stable.
> > > > +        * Airoha EN7581 has a hw bug asserting/releasing
> > > > PCIE_PE_RSTB signal
> > > > +        * causing occasional PCIe link down. In order to
> > > > overcome
> > > > the issue,
> > > > +        * PCIE_RSTB signals are not asserted/released at this
> > > > stage
> > > > and the
> > > > +        * PCIe block is reset using REG_PCI_CONTROL (0x88) and
> > > > +        * REG_RESET_CONTROL (0x834) registers available via the
> > > > clock module.
> > > >          */
> > > > -       msleep(100);
> > > > -
> > > > -       /* De-assert reset signals */
> > > > -       val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > > > PCIE_PE_RSTB);
> > > > -       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > >=20
> > > What will happen if the EN7581 use this reset flow? Will it still
> > > work
> > > after this link down?
> >=20
> > Hi Jianjun Wang,
> >=20
> > This has been described here by Hui Ma:
> >=20
> https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@=
kernel.org
> >=20
> > Setting PCIE_PE_RSTB bit on EN7581 SoC during reset triggers
> > occasional PCIe link
> > down issues caused by a hw problem.
>=20
> Hi Lorenzo,
>=20
> I'm wondering if we can ignore the previous reset and take this one as
> the initial reset?

Hi Jianjun Wang,

according to my understanding from Hui Ma's description, EN7581 has a hw is=
sue
with PCIE_PE_RSTB and it can't rely on it.

Regards,
Lorenzo

>=20
> Thanks.
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > > +       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > > > +               /* Assert all reset signals */
> > > > +               val =3D readl_relaxed(pcie->base +
> > > > PCIE_RST_CTRL_REG);
> > > > +               val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB |
> > > > PCIE_BRG_RSTB
> > > > >=20
> > > >=20
> > > > +                      PCIE_PE_RSTB;
> > > > +               writel_relaxed(val, pcie->base +
> > > > PCIE_RST_CTRL_REG);
> > > > +
> > > > +               /*
> > > > +                * Described in PCIe CEM specification sections
> > > > 2.2
> > > > (PERST# Signal)
> > > > +                * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > > > +                * The deassertion of PERST# should be delayed
> > > > 100ms
> > > > (TPVPERL)
> > > > +                * for the power and clock to become stable.
> > > > +                */
> > > > +               msleep(PCIE_T_PVPERL_MS);
> > > > +
> > > > +               /* De-assert reset signals */
> > > > +               val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB |
> > > > PCIE_BRG_RSTB |
> > > > +                        PCIE_PE_RSTB);
> > > > +               writel_relaxed(val, pcie->base +
> > > > PCIE_RST_CTRL_REG);
> > > > +       }
> > > >=20
> > > >         /* Check if the link is up or not */
> > > >         err =3D readl_poll_timeout(pcie->base +
> > > > PCIE_LINK_STATUS_REG,
> > > > val,
> > > > @@ -1160,10 +1180,12 @@ static int mtk_pcie_suspend_noirq(struct
> > > > device *dev)
> > > >                 return err;
> > > >         }
> > > >=20
> > > > -       /* Pull down the PERST# pin */
> > > > -       val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > > > -       val |=3D PCIE_PE_RSTB;
> > > > -       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > > > +       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > > > +               /* Pull down the PERST# pin */
> > > > +               val =3D readl_relaxed(pcie->base +
> > > > PCIE_RST_CTRL_REG);
> > > > +               val |=3D PCIE_PE_RSTB;
> > > > +               writel_relaxed(val, pcie->base +
> > > > PCIE_RST_CTRL_REG);
> > > > +       }
> > > >=20
> > > >         dev_dbg(pcie->dev, "entered L2 states successfully");
> > > >=20
> > > > @@ -1214,6 +1236,7 @@ static const struct mtk_gen3_pcie_pdata
> > > > mtk_pcie_soc_en7581 =3D {
> > > >                 .id[2] =3D "phy-lane2",
> > > >                 .num_resets =3D 3,
> > > >         },
> > > > +       .flags =3D SKIP_PCIE_RSTB,
> > > >  };
> > > >=20
> > > >  static const struct of_device_id mtk_pcie_of_match[] =3D {
> > > >=20
> > > > ---
> > > > base-commit: 3102ce10f3111e4c3b8fb233dc93f29e220adaf7
> > > > change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> > > >=20
> > > > Best regards,
> > > > --
> > > > Lorenzo Bianconi <lorenzo@kernel.org>
> > > >=20
> > > >=20

--27J7gfKq5EBYskZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyswJQAKCRA6cBh0uS2t
rAcUAQCfSbnSXBZoz2p99kl/DLMEJDu8StYkAzJCea9jv4M2zQEA3NVek08N+ECj
QkLXfccmP+v5A3BTdmoXxyivSYp55QU=
=SGcr
-----END PGP SIGNATURE-----

--27J7gfKq5EBYskZa--

