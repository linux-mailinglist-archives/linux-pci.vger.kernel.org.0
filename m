Return-Path: <linux-pci+bounces-16345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7879C22A9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 18:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C605E287127
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24219884C;
	Fri,  8 Nov 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGrGiSKc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692485B1FB
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085456; cv=none; b=RtVwT83POL/VmUXyYa/2Fdh/wl26rcuJ4ZogYL83t0YmbhXrGf0KfB9RnhpG1PhMEr3QUE4d0byxQa7FDSdABK1rOZYQ6IZ81mIe8Z+8DINW6B322qQ5wcZrM/pKFbVfcgCIkdE+a9SW1zq2DqZ762djxO97wiAibDVBfy/1qEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085456; c=relaxed/simple;
	bh=3C86MS26GFsBNxBdX5coV7T2cbUFhcZGxK90XHY+fok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxLjMdE8+van2n/fNUUlAVm9cRQ/7bpmNZ8TCtPNnxIC6evAEa3G1lCeYGQp0/z15aLX08xo6cA25dKFDsirlDZwlshp7v+rnkchE5hTgBfFzcVWqMgTjh/IC2SNkjNilfQh37cPozA3xbGbJnfvZ6JjQtfFHUDbmTw9bLS0IDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGrGiSKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA6AC4CECD;
	Fri,  8 Nov 2024 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731085456;
	bh=3C86MS26GFsBNxBdX5coV7T2cbUFhcZGxK90XHY+fok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGrGiSKcZQbMXZTSBSYdn8vJekAayoGdFG430Qm2ducS0aEnOTZYxlpcVJm0fLPw8
	 fgAXTnS057nIxxw3ZKYg0ZijAGfLdSHZFrFXLY9LJn36/zCUZNaXMTnQrmSNbdFNDi
	 WaNNHswlmqJG1Qv0dr+BDJw3Fh52QrBgayYKvNE8CaTfEKFPPRZ7oHhFlvQ1KdmnEq
	 sfLv0A4E+R3VkkPjUfzwk1bxx3DR7KUNZJubkoiPPGuH76X87DXXZan1aLPEoDVxMy
	 a7azS9OujT0vdtp0R5hNUAC5Qdk8xZ6DlEJQBbK3D7L3PEfVR7nSZdMnbGjvVfTq6d
	 DN2ZB4TvuVhLA==
Date: Fri, 8 Nov 2024 18:04:13 +0100
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Message-ID: <Zy5EjY_oQaRbb5MY@lore-desk>
References: <Zy3OTQ5CwPqtaeLU@lore-desk>
 <20241108163716.GA1664097@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aoE1DOBmsT2pIPHJ"
Content-Disposition: inline
In-Reply-To: <20241108163716.GA1664097@bhelgaas>


--aoE1DOBmsT2pIPHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Nov 08, 2024 at 09:39:41AM +0100, lorenzo@kernel.org wrote:
> > > On Thu, 2024-11-07 at 17:08 +0100, Lorenzo Bianconi wrote:
> > > > > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> > > > > > In order to make the code more readable, move phy and mac
> > > > > > reset lines assert/de-assert configuration in .power_up
> > > > > > callback (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
>=20
> > > > > > +	/*
> > > > > > +	 * The controller may have been left out of reset by the
> > > > > > bootloader
> > > > > > +	 * so make sure that we get a clean start by asserting resets
> > > > > > here.
> > > > > > +	 */
> > > > > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > > > > > +				  pcie->phy_resets);
> > > > > > +	reset_control_assert(pcie->mac_reset);
> > > > > > +	usleep_range(10, 20);
> > > > >=20
> > > > > Unrelated to this patch, but since you're moving it, do you
> > > > > know what this delay is for?  Can we add a #define and a spec
> > > > > citation for it?
> > > >=20
> > > > I am not sure about it, this was already there.  @Jianjun Wang:
> > > > any input on it?
> > >=20
> > > This delay is used to ensure the reset is effective. A delay of
> > > 10us should be sufficient in this scenario.
> >=20
> > ack, so we can introduce a marco like:
> >=20
> > #define PCIE_RESET_TIME_US	10
> > ...
> >=20
> > usleep_range(PCIE_RESET_TIME_US, 2 * PCIE_RESET_TIME_US);
>=20
> Unless this corresponds to a value specified by the PCIe base spec or
> CEM spec, this macro should be internal to pcie-mediatek-gen3.c.

My plan is to add it in pcie-mediatek-gen3.c. Do you think PCIE_RESET_TIME_=
US
is too generic?

Regards,
Lorenzo

--aoE1DOBmsT2pIPHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZy5EjQAKCRA6cBh0uS2t
rGkcAQCmqi+1zEy2XOSZkUGbzq2pUeWEnbeWTrheUkqUYyh/HgEAsizdeFxs3CU9
t94Gy0H3snrTSXOo+4M43gZBzfdn+g0=
=jWRN
-----END PGP SIGNATURE-----

--aoE1DOBmsT2pIPHJ--

