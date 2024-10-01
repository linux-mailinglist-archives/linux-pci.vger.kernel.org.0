Return-Path: <linux-pci+bounces-13693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D298C447
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 19:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978A31F2202F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF001A00FE;
	Tue,  1 Oct 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYTZFTx/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776741C6F54
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802915; cv=none; b=tVrbmLZtMT/3Plz2fX7+iEB+gSTg/IzHUvMeebq8x5mDU+tcpatKHkwuLQWpr+P4Xt8AG3lhgl/kcpxVMeIHzfG2kvfM3XX3OtDUgXC7Qy4NFeggsV8CTFOhr5/D8GlOEqQVf6nKhnaln+TKMcXlGjT33dbIkd1Ck4/XiTjXFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802915; c=relaxed/simple;
	bh=F9k4VZbS9kuyT+dY46dvKKzolIXCmDvataW7QyUZChE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSDDw7axyGF+xZTW9g5nfJ6xjtHuDfY4890YqCX7DhWeFEqZY2Z2FmPW8kjZAMl7j+Pn6PgL/r1YEeXpgQwuWXbyd8kiyGF28ccvV1D8lPqbC66kqrEEsnYEJBMesYiwpTsTyhzhA1DkkstlF4kzWpGBNehg+tIFVfuawwAeJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYTZFTx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A75C4CEC6;
	Tue,  1 Oct 2024 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727802915;
	bh=F9k4VZbS9kuyT+dY46dvKKzolIXCmDvataW7QyUZChE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYTZFTx//clBH30h0txuBjU8fVzOO1H+LDnSJ2R1xf6adKL6r7diYBAFx1IFqrCS5
	 QSc/UrKceRg+JiE3k8XRZDxyif+rlZh3ZpNtgTMYjWy5fqi13BvMrESsPsLuJGHtoY
	 j8Pd1pCaFFlH/+ttJoIdywZ0W+j4z9c2e/aP4n4pAm0fgSe7WQRcn5hHLDtnh0Zr1p
	 RmfZMdnqegvYCTLQUjNj5wZ+ADHnocgNnTbNd2XlN683kpG7dGAa5ldphO96bf31gL
	 hqXgIdHRgh3+VfzTdgt4EYP2QZ6Ho4W2leVmPhA593qvBwKch4QCsi7hQc7i++apvC
	 i/MXhiHGwkj7A==
Date: Tue, 1 Oct 2024 19:15:12 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha
 EN7581 SoC
Message-ID: <ZvwuIBr2V_FFbYYA@lore-desk>
References: <d8941149-9125-4fe2-a1c0-ab29223a0c87@collabora.com>
 <20240930193756.GA187798@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q6lfzaRupebapF3G"
Content-Disposition: inline
In-Reply-To: <20240930193756.GA187798@bhelgaas>


--Q6lfzaRupebapF3G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Sep 23, 2024 at 11:41:41AM +0200, AngeloGioacchino Del Regno wrot=
e:
> > Il 20/09/24 10:26, Lorenzo Bianconi ha scritto:
> > > The PCIe controller available on the EN7581 SoC does not support reset
> > > via the following lines:
> > > - PCIE_MAC_RSTB
> > > - PCIE_PHY_RSTB
> > > - PCIE_BRG_RSTB
> > > - PCIE_PE_RSTB
> > >=20
> > > Introduce the reset callback in order to avoid resetting the PCIe port
> > > for Airoha EN7581 SoC.
> >=20
> > EN7581 doesn't support pulling up/down PERST#?!  That looks
> > definitely odd, as that signal is part of the PCI-Express CEM spec.
> >=20
> > Besides, there's another PERST# assertion at
> > mtk_pcie_suspend_noirq()...
>=20
> I agree, it doesn't smell right that this SoC doesn't have a way to
> assert PERST#.
>=20
> The response at
> https://lore.kernel.org/r/SG2PR03MB63415DB5791C58C7EA69FF01FF682@SG2PR03M=
B6341.apcprd03.prod.outlook.com
> suggests that maybe there's a hardware defect that means asserting
> PERST# doesn't work correctly?  But surely firmware must have a way of
> asserting PERST#, at least at boot time.
>=20
> If this is truly a hardware defect and we really can't assert PERST#,
> please say that this is a defect in the commit log so people don't
> think that lack of PERST# is an acceptable thing.

Hi Bjorn,

I do not have visibility on these hw details.
@Hui: any update on it?

Regards,
Lorenzo

>=20
> Bjorn

--Q6lfzaRupebapF3G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvwuHwAKCRA6cBh0uS2t
rI4xAP0f7H5YYjJOMPtAjiFgwoj5gmwqlZeERbA3WgcVx6T1dAEAl2Q5iAJrmoNd
9XD/DXlqF7zAN2eNFuhJqUUTcR3iggE=
=iw3M
-----END PGP SIGNATURE-----

--Q6lfzaRupebapF3G--

