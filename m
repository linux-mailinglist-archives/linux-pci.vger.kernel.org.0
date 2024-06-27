Return-Path: <linux-pci+bounces-9346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D581A919F8E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 08:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E6C283561
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A603AC01;
	Thu, 27 Jun 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNvqXL4v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA443A28B;
	Thu, 27 Jun 2024 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471029; cv=none; b=QP4N9s/cJMXVO5aqL41LkUKG6UPfcBC8AvIM+MOP5kjet+FrcblTS3ZENfhQfvIN/hgufnnKZTEi/RIpZmJilE94pjDWYkTQ7U255z6vhbYyiKPffS0qtZshTX9XH6AKCo8ciN5QoP9M+qHtMmpmkiCrHc3sH+ZWPd/YNO2oEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471029; c=relaxed/simple;
	bh=Ibr63yKjW5xKaI/BECgFSLEZizZa+Q7V/5SONc3pJTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp3nyXIcwVgYi0Q/7AhRmYSVAvSPN7gFxwWDDTGun+t8eIphBYPq31sCePSaLEnJLzk2N9/RC0m1a/5sKA9fue7gP7zTofNTShOSZ8u1IAkQFL9ZYiH7rjclO3bpStkZhpqho7ztn2F1gFPqepEnFpoQPo9ra2RZ12Kr9pRekQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNvqXL4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41918C2BBFC;
	Thu, 27 Jun 2024 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719471028;
	bh=Ibr63yKjW5xKaI/BECgFSLEZizZa+Q7V/5SONc3pJTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNvqXL4v7P7AHvvv0si7ebvFbzb3MGRBFPPfAjXS7B1wr2J+vbO1WZS8a6e/a+uoU
	 ytrK4yk0LL/M7llObVa+dxKrkSDhcEQMxtn42rVbwqMTTBO1q0jm7sJvrb8wvhiouQ
	 2aiTWv4pMBxnN9zzK9iqiHJroAdWdVaB7GqI+l9SSAPAHZz6VjOgzvzoZRFXdnORvK
	 XB7vRLQcD2Jw9xcZyztcPT5RJHfAZz5v1el/RHaxmOQISqPAzHrxiN7tQOohp6NtRc
	 ku+v010EnJybwRPiHDU/BnlSLJIZ5upDiKpskMEsf0npUd5LnaPpCUkRdPeK9a4mpQ
	 WDdH3JsIl0Yog==
Date: Thu, 27 Jun 2024 08:50:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com
Subject: Re: [PATCH 2/4] PCI: mediatek-gen3: Add mtk_pcie_soc data structure
Message-ID: <Zn0LsfE9xlwuEvuf@lore-desk>
References: <cover.1718980864.git.lorenzo@kernel.org>
 <a49a36c4ca336dee909e16865d6fec0dd83b3f38.1718980864.git.lorenzo@kernel.org>
 <c63ed7fc-f568-48b1-ad5d-a37b4b475016@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D0ojh7sfDISA5znA"
Content-Disposition: inline
In-Reply-To: <c63ed7fc-f568-48b1-ad5d-a37b4b475016@collabora.com>


--D0ojh7sfDISA5znA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Il 21/06/24 16:48, Lorenzo Bianconi ha scritto:
> > Introduce mtk_pcie_soc data structure in order to define multiple
> > callbacks for each supported SoC. This is a preliminary patch to
> > introduce EN7581 pcie support.
> >=20
> > Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/pci/controller/pcie-mediatek-gen3.c | 24 ++++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 975b3024fb08..4859bd875bc4 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -100,6 +100,16 @@
> >   #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
> >   #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
> > +struct mtk_gen3_pcie;
> > +
> > +/**
> > + * struct mtk_pcie_soc - differentiate between host generations
>=20
> mtk_gen3_pcie_pdata ?

ack, I will fix it in v2.

>=20
> > + * @power_up: pcie power_up callback
> > + */
> > +struct mtk_pcie_soc {
> > +	int (*power_up)(struct mtk_gen3_pcie *pcie);
> > +};
> > +
> >   /**
> >    * struct mtk_msi_set - MSI information for each set
> >    * @base: IO mapped register base
> > @@ -131,6 +141,7 @@ struct mtk_msi_set {
> >    * @msi_sets: MSI sets information
> >    * @lock: lock protecting IRQ bit map
> >    * @msi_irq_in_use: bit map for assigned MSI IRQ
> > + * @soc: pointer to SoC-dependent operations
> >    */
> >   struct mtk_gen3_pcie {
> >   	struct device *dev;
> > @@ -151,6 +162,8 @@ struct mtk_gen3_pcie {
> >   	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
> >   	struct mutex lock;
> >   	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
> > +
> > +	const struct mtk_pcie_soc *soc;
> >   };
> >   /* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
> > @@ -904,7 +917,7 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pci=
e)
> >   	usleep_range(10, 20);
> >   	/* Don't touch the hardware registers before power up */
> > -	err =3D mtk_pcie_power_up(pcie);
> > +	err =3D pcie->soc->power_up(pcie);
> >   	if (err)
> >   		return err;
> > @@ -939,6 +952,7 @@ static int mtk_pcie_probe(struct platform_device *p=
dev)
> >   	pcie =3D pci_host_bridge_priv(host);
> >   	pcie->dev =3D dev;
> > +	pcie->soc =3D of_device_get_match_data(dev);
>=20
> device_get_match_data() can also be used here :-)

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> Cheers,
> Angelo
>=20

--D0ojh7sfDISA5znA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZn0LsAAKCRA6cBh0uS2t
rDqZAP9E+w0Rw2ZY2kG1NLWByHxMpjaweBhTMxAc2wIOcJkdYgD+LK8bI4DKDAeb
rCKBejLnONweNsqr8pSXAl3mCPZVygk=
=pZN7
-----END PGP SIGNATURE-----

--D0ojh7sfDISA5znA--

