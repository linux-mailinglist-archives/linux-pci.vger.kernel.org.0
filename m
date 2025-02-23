Return-Path: <linux-pci+bounces-22131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D8A40F20
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 14:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D101892A23
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361D206F2E;
	Sun, 23 Feb 2025 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEmd8SjX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE731E480;
	Sun, 23 Feb 2025 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740317971; cv=none; b=pErEExO5HDW9o5itdWzdJb+RY4N2Jjny4CywqxZwxVhfdAQ4enWnU2EXWLYGJD2wF9dcdziPZVEVVDqit4WSnipthCEWQ5kwPwNOAdiakv7FT4vClJmd/3jp5H0DQx5qtXt8LDZiIPlG3AfxDYptODqF+N8HOmUF+pdWJ+mnPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740317971; c=relaxed/simple;
	bh=VYHAAbUCUiGYFAjtyjDhjex55dizi9CWqp4qfEujigE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFUou9/o91LjgM8c00ms/o+cBYxIiQDU3CjZ0UXqM5/8IL95eqWpLriskrgCz2XRWffVtAnR9n+5FCksyQJhEWFdUJrdpx9lUYKyFWzg2YZHV8Rl4w+iGH6zIBGVyL12pOAdDpk1ACByzVwWftZz2vwzOXlDASgq8egOihLNcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEmd8SjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847C3C4CEDD;
	Sun, 23 Feb 2025 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740317970;
	bh=VYHAAbUCUiGYFAjtyjDhjex55dizi9CWqp4qfEujigE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEmd8SjXchvYTXVG5atKw3xbjW2JO9AMH5ttIiw9mLwE6biRdEUFCrohtDDXFK9Vx
	 ds4iJbPcOuDT+4z0DP4fZHkZOpXQYLavo5thpJ2/BOpXfkHOScg0R4YAXuKszdvh8R
	 TAduUGcDDNMtHzy4ZOTYSU3YFuB25on7Ho9rUXGiiHYVmvILEkmL7QGVBU2SS8Bte+
	 Ah8UFr4MrzET2ns/pTHERSxJ7sQha7I1cSu6IBAbnT2sSND86o18wSUypcIcV6p+a9
	 k8H17kVJtKplzHYusTyMDcZ7p9gVq4QN+sJRaXdaJRd92LDokt92gIU9NuNDQaVqDY
	 OmibVSyXn+bbQ==
Date: Sun, 23 Feb 2025 14:39:28 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add
 mediatek,pbus-csr phandle array property
Message-ID: <Z7slEJgCQMqp_I6p@lore-desk>
References: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
 <20250222-en7581-pcie-pbus-csr-v3-1-e0cca1f4d394@kernel.org>
 <20250223-hulking-goldfish-of-symmetry-cbfed4@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LboHElsNia9vOOZK"
Content-Disposition: inline
In-Reply-To: <20250223-hulking-goldfish-of-symmetry-cbfed4@krzk-bin>


--LboHElsNia9vOOZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Feb 22, 2025 at 11:43:44AM +0100, Lorenzo Bianconi wrote:
> > Introduce the mediatek,pbus-csr property for the pbus-csr syscon node
> > available on EN7581 SoC. The airoha pbus-csr block provides a configura=
tion
> > interface for the PBUS controller used to detect if a given address is
> > accessible on PCIe controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml     | 17 +++++++++=
++++++++
> >  1 file changed, 17 insertions(+)
> >=20
>=20
> You got review tag, so if you decided to skip it, this should be
> mentioned why.
>=20
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Since I modified the patch with respect to the previous version, I was thin=
king
you want to review it again before applying the Reviewed-by tag. Added it n=
ow.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--LboHElsNia9vOOZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7slEAAKCRA6cBh0uS2t
rPy9AQCgBZ/Fs6+vlGg02YKCLsxEfSZgokp+F0deZxshMw9y8AEAwEhLv/Dps1LX
LD5v1+vVobF58lYLVJoLkG/UfUOe7QA=
=W+YN
-----END PGP SIGNATURE-----

--LboHElsNia9vOOZK--

