Return-Path: <linux-pci+bounces-16037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A934E9BC927
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399C31F2029C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D901CF2A4;
	Tue,  5 Nov 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSAkGpNh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B35188734
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799047; cv=none; b=ts4jCC95CoXJNQH/zN7VFfmskHStP4Pb5elWoBDUhWHkh70+ho8ZpqZRuppIl0Q2OCh5aOnLDg7kSaTbtYeGcj+y7+01ahJ6SAvbAb+Zz33+DCxOU9uWakFbcmbt7yHK/R1EJYkydNmf0mo833iROZe0QSfzMTnckR/hhwOfoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799047; c=relaxed/simple;
	bh=wD7Ku+dp3TRfaC33XVIacX8vDPJh3iGoX10yurCvEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjhJKIfC3AqNsgbWvWp+0uX+oZAEEUMuSgF8Zg5E8Hs5N2l1ytWWEpnmex3Fn+MRAp3udTq+X/95KbwnDv4Qw21UWjAAdvqtHAgaw7Gj8Px9vakd5djlJTO5CbM5yvWpJjBtUPabLVDKOdimzMxK+06q/zqSExCkWFLK/3CF9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSAkGpNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2ECC4CED0;
	Tue,  5 Nov 2024 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730799046;
	bh=wD7Ku+dp3TRfaC33XVIacX8vDPJh3iGoX10yurCvEc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSAkGpNhRVn3zeOKfWHkwe5uQKY9m7tlGbb8qImA8uEDWbNCc2ZQdM5cKi6iEDua7
	 RJNwXM8FsR5CcS9epTO95fu+uO5Q1A19gZKeU4WPCCPw8wttld0ipr2kuxK3bp1tYk
	 vcR2nrd8vFbOmj8evFhs7vWTvEF3fz/oNMNvQHwfu3fK9qxDHFp96/AQ6ssIjujPuR
	 J6AU39fEcSJn1EBMg/reOC18IOVI/f+Y79EMYNdHLoLRlFi/FcYU4b8SV/vFsKvUVN
	 zATOqvitxI2XuADyMmiWYOotjUMYcyw906uaOIucy7T9+Q21t9qRdEGtpGE5uuzHPk
	 1KpVubyxGK3zA==
Date: Tue, 5 Nov 2024 10:30:43 +0100
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>
Cc: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Hui Ma =?utf-8?B?KOmprOaFpyk=?= <Hui.Ma@airoha.com>,
	upstream <upstream@airoha.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <Zynlw7wzyeucc2iT@lore-desk>
References: <20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org>
 <f827f7c45094722aa3c254eda32ada157156444a.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L6mUGOkmvFBV9Ceu"
Content-Disposition: inline
In-Reply-To: <f827f7c45094722aa3c254eda32ada157156444a.camel@mediatek.com>


--L6mUGOkmvFBV9Ceu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2024-11-04 at 23:00 +0100, Lorenzo Bianconi wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > causing occasional PCIe link down issues. In order to overcome the
> > problem, PCIE_RSTB signals are not asserted/released during device
> > probe or
> > suspend/resume phase and the PCIe block is reset using
> > REG_PCI_CONTROL
> > (0x88) and REG_RESET_CONTROL (0x834) registers available via the
> > clock
> > module.
> > Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> > specify per-SoC capabilities.
> >=20
> > Tested-by: Hui Ma <hui.ma@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - introduce flags field in mtk_gen3_pcie_flags struct instead of
> > adding
> >   reset callback
> > - fix the leftover case in mtk_pcie_suspend_noirq routine
> > - add more comments
> > - Link to v1:=20
> > https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc=
9@kernel.org
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 59
> > ++++++++++++++++++++---------
> >  1 file changed, 41 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index
> > 66ce4b5d309bb6d64618c70ac5e0a529e0910511..8e4704ff3509867fc0ff799e9fb
> > 99e71e46756cd 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -125,10 +125,18 @@
> >=20
> >  struct mtk_gen3_pcie;
> >=20
> > +enum mtk_gen3_pcie_flags {
> > +       SKIP_PCIE_RSTB  =3D BIT(0), /* skip PCIE_RSTB signals
> > configuration
> > +                                  * during device probing or
> > suspend/resume
> > +                                  * phase in order to avoid hw
> > bugs/issues.
> > +                                  */
> > +};
> > +
> >  /**
> >   * struct mtk_gen3_pcie_pdata - differentiate between host
> > generations
> >   * @power_up: pcie power_up callback
> >   * @phy_resets: phy reset lines SoC data.
> > + * @flags: pcie device flags.
> >   */
> >  struct mtk_gen3_pcie_pdata {
> >         int (*power_up)(struct mtk_gen3_pcie *pcie);
> > @@ -136,6 +144,7 @@ struct mtk_gen3_pcie_pdata {
> >                 const char *id[MAX_NUM_PHY_RESETS];
> >                 int num_resets;
> >         } phy_resets;
> > +       u32 flags;
> >  };
> >=20
> >  /**
> > @@ -402,22 +411,33 @@ static int mtk_pcie_startup_port(struct
> > mtk_gen3_pcie *pcie)
> >         val |=3D PCIE_DISABLE_DVFSRC_VLT_REQ;
> >         writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
> >=20
> > -       /* Assert all reset signals */
> > -       val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > -       val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > PCIE_PE_RSTB;
> > -       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > -
> >         /*
> > -        * Described in PCIe CEM specification sections 2.2 (PERST#
> > Signal)
> > -        * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > -        * The deassertion of PERST# should be delayed 100ms
> > (TPVPERL)
> > -        * for the power and clock to become stable.
> > +        * Airoha EN7581 has a hw bug asserting/releasing
> > PCIE_PE_RSTB signal
> > +        * causing occasional PCIe link down. In order to overcome
> > the issue,
> > +        * PCIE_RSTB signals are not asserted/released at this stage
> > and the
> > +        * PCIe block is reset using REG_PCI_CONTROL (0x88) and
> > +        * REG_RESET_CONTROL (0x834) registers available via the
> > clock module.
> >          */
> > -       msleep(100);
> > -
> > -       /* De-assert reset signals */
> > -       val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > PCIE_PE_RSTB);
> > -       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>=20
> What will happen if the EN7581 use this reset flow? Will it still work
> after this link down?

Hi Jianjun Wang,

This has been described here by Hui Ma:
https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@ke=
rnel.org

Setting PCIE_PE_RSTB bit on EN7581 SoC during reset triggers occasional PCI=
e link
down issues caused by a hw problem.

Regards,
Lorenzo

>=20
> > +       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > +               /* Assert all reset signals */
> > +               val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +               val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB
> > |
> > +                      PCIE_PE_RSTB;
> > +               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +
> > +               /*
> > +                * Described in PCIe CEM specification sections 2.2
> > (PERST# Signal)
> > +                * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > +                * The deassertion of PERST# should be delayed 100ms
> > (TPVPERL)
> > +                * for the power and clock to become stable.
> > +                */
> > +               msleep(PCIE_T_PVPERL_MS);
> > +
> > +               /* De-assert reset signals */
> > +               val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB |
> > PCIE_BRG_RSTB |
> > +                        PCIE_PE_RSTB);
> > +               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +       }
> >=20
> >         /* Check if the link is up or not */
> >         err =3D readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG,
> > val,
> > @@ -1160,10 +1180,12 @@ static int mtk_pcie_suspend_noirq(struct
> > device *dev)
> >                 return err;
> >         }
> >=20
> > -       /* Pull down the PERST# pin */
> > -       val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > -       val |=3D PCIE_PE_RSTB;
> > -       writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > +               /* Pull down the PERST# pin */
> > +               val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +               val |=3D PCIE_PE_RSTB;
> > +               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +       }
> >=20
> >         dev_dbg(pcie->dev, "entered L2 states successfully");
> >=20
> > @@ -1214,6 +1236,7 @@ static const struct mtk_gen3_pcie_pdata
> > mtk_pcie_soc_en7581 =3D {
> >                 .id[2] =3D "phy-lane2",
> >                 .num_resets =3D 3,
> >         },
> > +       .flags =3D SKIP_PCIE_RSTB,
> >  };
> >=20
> >  static const struct of_device_id mtk_pcie_of_match[] =3D {
> >=20
> > ---
> > base-commit: 3102ce10f3111e4c3b8fb233dc93f29e220adaf7
> > change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> >=20
> > Best regards,
> > --
> > Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> >=20

--L6mUGOkmvFBV9Ceu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZynlwwAKCRA6cBh0uS2t
rFxWAP9PUHO0llmItHlvgbjEkcGgwOKr6G17jWbaL4PQFfCyCAEAm31MqrwoAdHZ
Hbkh0lxa4mw3Sc4xDrNDcCn9vaLtrwg=
=N7oE
-----END PGP SIGNATURE-----

--L6mUGOkmvFBV9Ceu--

