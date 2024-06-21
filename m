Return-Path: <linux-pci+bounces-9101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A207D912FB7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 23:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8DB1F22A65
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9B17B435;
	Fri, 21 Jun 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXifCqrS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D76208C4;
	Fri, 21 Jun 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719006201; cv=none; b=tL5NkUwPd41ROYMOdnl9XVb8x8iMEJ2oqIiYcfMhsl1nsfW/ssVmoSyxa6SWXKgP2w8P6Cote7a7MPmvl80Ov+VJ6kBuofMNdXa8eeqD1kiw/sPdcalY0Jr3pTSL8p+ayHtBp7kVdQsMu3piLSU2oevtrcs1n46kFSZR4DYuV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719006201; c=relaxed/simple;
	bh=NlsjIIwZsqiq61/qJDZqhcMAQVsvrEzr61a+FqMM90E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un3lrIcHUSiLCH9BBW6mXVX7H4bqxsNg8q6J5eOirpfsTL6twa/vHWOoIXlzTf7OQXehI/1TDORn2CrMdqfpLgToWAZxnZy08WARU9uoTt95t6EPvyqBkIwaFqOCZysswLW+W17yik8cWn1UadqEWY9/CGv2q3dc65+89qYL2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXifCqrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798CCC2BBFC;
	Fri, 21 Jun 2024 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719006201;
	bh=NlsjIIwZsqiq61/qJDZqhcMAQVsvrEzr61a+FqMM90E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXifCqrSRwwIv9dotfeyYZXEQsNDU8wFIcmMrnZZfV5a2RCPD2xrJa2QoFKyxMi6A
	 udO5ujeYXgHK8v2BY1EXxon4kT4sBqDksklC1yFCBEU4IEBSiAf+z3jO3NMmFnKi9G
	 vY/p5+7PXaFBgzkJbDOvGa3dSfiIiVggDV2q55quJjLqcC/KJKYWnX3viIOS6uhdKX
	 g/DjQUxcouopEMvsw/LlZZP1Qs0qrg/iCKIqOLMRNCMUHKCFlTZYXqPhJRkba+XNI5
	 5Q+poP5dupMfdftHkeFzZxDpfkq1EorXv6ZMBq4azLr4fQk5GdbUCCyMWVV5UdhUzM
	 nWcsUv3l3EhQQ==
Date: Fri, 21 Jun 2024 23:43:17 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 3/4] PCI: mediatek-gen3: rely on reset_bulk APIs for phy
 reset lines
Message-ID: <ZnXz9Rqj-OBecnUh@lore-desk>
References: <e8ab615a56759a4832833211257d83f56bf64303.1718980864.git.lorenzo@kernel.org>
 <20240621175138.GA1395691@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R0v8qdAaXW0oUm/u"
Content-Disposition: inline
In-Reply-To: <20240621175138.GA1395691@bhelgaas>


--R0v8qdAaXW0oUm/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 21, 2024 at 04:48:49PM +0200, Lorenzo Bianconi wrote:
> > Use reset_bulk APIs to manage phy reset lines. This is a preliminary
> > patch in order to add Airoha EN7581 pcie support.
>=20
> If you have occasion to revise this:
>=20
>   s/rely/Rely/ in subject
>   s/phy/PHY/ in subject and commit log
>   s/pcie/PCIe/ in commit log

ack, I will fix them in v2

>=20
> > @@ -912,7 +927,13 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pc=
ie)
> >  	 * The controller may have been left out of reset by the bootloader
> >  	 * so make sure that we get a clean start by asserting resets here.
> >  	 */
> > -	reset_control_assert(pcie->phy_reset);
> > +	reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
> > +				    pcie->phy_resets);
> > +	usleep_range(5000, 10000);
> > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
> > +				  pcie->phy_resets);
> > +	msleep(100);
>=20
> Where did these usleep and msleep numbers come from?  They should use
> a #define that we can connect back to a spec.

I think we can get rid of the first usleep_range() since we need to
deassert the line just to avoid unbalance in deassert_count counter since t=
he
reset line is shared (the line is actually already de-assert). I will add a
comment to clarify it.

>=20
> These delays should also be mentioned in the commit log because it
> appears unrelated to the conversion to the reset_bulk API.  Actually,
> it would be even better if they were in a separate patch, since it
> looks like a logically separate change.

Regarding the msleep(100), it is not documented in the vendor sdk, I think =
it
necessary to complete the reset before initialize the pcie-phy. Since it is
required just for EN7581, I guess we can move it in mtk_pcie_en7581_power_u=
p()
(in patch 4/4) before the phy_init(). What do you think?

Regards,
Lorenzo

>=20
> >  	reset_control_assert(pcie->mac_reset);
> >  	usleep_range(10, 20);
>=20
> Unrelated to this patch, but it would be nice to have an explanation
> of this existing delay, too.
>=20
> Bjorn

--R0v8qdAaXW0oUm/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnXz9QAKCRA6cBh0uS2t
rAXuAQC7ZW1fjIBBpL/XoNuhK6+b6vaF41Z7cth8QCojxqHJxAEAh1ToqvlrHZ+x
Tt36J4vBfXjjJDp88aVO65aDVOcK/gU=
=JtUj
-----END PGP SIGNATURE-----

--R0v8qdAaXW0oUm/u--

