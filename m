Return-Path: <linux-pci+bounces-16268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682CB9C0BD2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A5284F25
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875FC212D22;
	Thu,  7 Nov 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7JZeh+I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D321219F
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997460; cv=none; b=EGDeYcF4M12dLsabunNyJxuZDCdyyWL28g4YgBFIMQwdbmYMNZDjiRUtpzFHXJ6oaywI8PwkZMU4pi3gLsfBARSWAfDThuS5A2oyO8rmi/1VHar1TjltlMvHlXk4/h2vhPHrtSUYtFO+ttZVwzr+MvgBGw2EB0+mLLhrJmwqO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997460; c=relaxed/simple;
	bh=LOjqdLJXd4OpI4uxoxe81wuTDGMChDa9G9O5Hv18mqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1KylpbkBsClvr6fvYbYvZJaQEfYqDRbaEwioEm3ySfrfwHpoQYzUeLLNMsV1vvOdiJFHMK/elG4UDVaES4bU4/wqf518ibqKILInUmqZ9j7ZS3fV4mFjBJKUwMLXCXXLD219tL14BktPC14eMQyQ97RmwFA2x01rHIj5nun0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7JZeh+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7414BC4CECC;
	Thu,  7 Nov 2024 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730997458;
	bh=LOjqdLJXd4OpI4uxoxe81wuTDGMChDa9G9O5Hv18mqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7JZeh+IeOQECb17zMO1os2mGY6G+f6EoIue5B4gZosgSMwIpCGGbBLQ+Uj44FyKB
	 kx2qRP2QsXarPtPq83HZfuTIw0oKgoaMBvwTFSaytiqZWeSv9ynVCkznF7QUw2+nA0
	 KRMDLUUIwF19Qe5it6+LiYDv99TmVVPvhyWScNXKhZh+1Nn+T/pSEnJbq2SJdbPQSG
	 P6DAdIN3UVCP7BqNE5tZmty2KfOibSFfVi4HKOpbQncHTKGzJlZQaCGa4uUND3i9j5
	 FoJsKWmfl8SLKxBEMX1OKtRDkamva2Bbpq0y7jEtNi41LT0qPcfpT0v+fkriLLNU2G
	 foC8On6Dsg00A==
Date: Thu, 7 Nov 2024 17:37:36 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Message-ID: <Zyzs0E6c6FZNK6j9@lore-desk>
References: <ZyzmFyRYDHX0W6bB@lore-desk>
 <20241107162136.GA1618287@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jWe0TsNLQ5QwO6hz"
Content-Disposition: inline
In-Reply-To: <20241107162136.GA1618287@bhelgaas>


--jWe0TsNLQ5QwO6hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 07, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2024 at 05:08:55PM +0100, Lorenzo Bianconi wrote:
> > > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> > > > In order to make the code more readable, move phy and mac reset lin=
es
> > > > assert/de-assert configuration in .power_up callback
> > > > (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
> > ...
>=20
> > > Is there a requirement that the PHY and MAC reset ordering be
> > > different for EN7581 vs other chips?
> > >=20
> > > EN7581:
> > >=20
> > >   assert PHY reset
> > >   assert MAC reset
> > >   power on PHY
> > >   deassert PHY reset
> > >   deassert MAC reset
> > >=20
> > > others:
> > >=20
> > >   assert PHY reset
> > >   assert MAC reset
> > >   deassert PHY reset
> > >   power on PHY
> > >   deassert MAC reset
> > >=20
> > > Is there one order that would work for both?
> >=20
> > EN7581 requires to run phy_init()/phy_power_on() before deassert PHY re=
set
> > lines.
>=20
> And the other chips require the PHY power-on to be *after* deasserting
> PHY reset?

I am not sure about it, this is the only Airoha device I have.

Regards,
Lorenzo

--jWe0TsNLQ5QwO6hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyzs0AAKCRA6cBh0uS2t
rOdGAP9wZ3x/72rt3z5VA+CvmxyOE+smiIxqdLcxqQ5DYJYKKQD+OzuuGmCFKK6b
otItaue3hFQPfCMyI9kM/cMtpP5dYQI=
=M/rn
-----END PGP SIGNATURE-----

--jWe0TsNLQ5QwO6hz--

