Return-Path: <linux-pci+bounces-38358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DABE43B1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607125821CD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F000134AB1D;
	Thu, 16 Oct 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/6ZxPhY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081634AB11;
	Thu, 16 Oct 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628477; cv=none; b=NI31g+rXdWLeZDIHZrRW2WIsNY6djkU3uk19PsOrcNrtxkKVPYEHnPGxXFgTzT3wFiYPF6RV4EE45jsQbam4JpOgrntI3DBnrPWqUcuY1dqZnN0zhRaVCiQoGw1QCxzGGJRvzvn5rTsVJfi2rQGJa7V5zdkNrlRxX864GL5mF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628477; c=relaxed/simple;
	bh=OkslPl/BfgU+xJGaHNwPTb7HL57jgw9At+2ouWVRKQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed92z1Iw5asW7WsS7SMsv61IeaLyYcA2d5WB9x4fT12W3bJ9BAm0dQuNE3NkCDKBIb3OD1C4EWBHb11clDDcYli6crkd/FJGzXQcI9Yuo0f/NUlzSt0uUj10/nDLRe5q5LXIlAkJA8nwaKvInQMY819gc7AvQhGW/PRWYGnjwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/6ZxPhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8377EC4CEF1;
	Thu, 16 Oct 2025 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628477;
	bh=OkslPl/BfgU+xJGaHNwPTb7HL57jgw9At+2ouWVRKQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/6ZxPhY+IJgaqAqHS4IHGqJR8EHzqAgmlKKH3OmylShBjDYAJC4YOdSX1W7nPSer
	 /YpcYNlThilc8xv3hD/XhYJE3PvzUVLFCqpNa61XTEESU38234B4gpuxx1Gn3RJqtB
	 md44x2aLYUv0QTarqnJ+62MALgYpoUwrJj8KopDSfUAbohnEMW0RSNeYCQAW+iITS3
	 1NPp00+ffS7+z0VfCASHpzLz9wX5iuT28sKloVVoE+/mKtio5HLphfvVj6Vrim2OzA
	 t2msJry2Zyz8pu3cdiPw5Wg2jOBDOdBhzxsXXid8xF7qMcI5ev3MADZ6h59X7Izx6B
	 6m2XKt2uVkSxA==
Date: Thu, 16 Oct 2025 16:27:49 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: Re: [PATCH 09/15] dt-bindings: net: mediatek,net: Correct bindings
 for MT7981
Message-ID: <20251016-squealer-neurology-5bf32360e5bf@spud>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-9-de259719b6f2@collabora.com>
 <a3d6b229-8f33-4e88-8a55-6c5640f688e1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KThuiYHY98QAsVsP"
Content-Disposition: inline
In-Reply-To: <a3d6b229-8f33-4e88-8a55-6c5640f688e1@collabora.com>


--KThuiYHY98QAsVsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 01:29:01PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> > Different SoCs have different numbers of Wireless Ethernet
> > Dispatch (WED) units:
> > - MT7981: Has 1 WED unit
> > - MT7986: Has 2 WED units
> > - MT7988: Has 2 WED units
> >=20
> > Update the binding to reflect these hardware differences. The MT7981
> > also uses infracfg for PHY switching, so allow that property.
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > ---
> >   Documentation/devicetree/bindings/net/mediatek,net.yaml | 16 ++++++++=
+++++---
> >   1 file changed, 13 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/=
Documentation/devicetree/bindings/net/mediatek,net.yaml
> > index b45f67f92e80d..453e6bb34094a 100644
> > --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> > +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> > @@ -112,7 +112,7 @@ properties:
> >     mediatek,wed:
> >       $ref: /schemas/types.yaml#/definitions/phandle-array
> > -    minItems: 2
> > +    minItems: 1
>=20
> If minItems is 1 here
>=20
> >       maxItems: 2
> >       items:
> >         maxItems: 1
> > @@ -338,12 +338,14 @@ allOf:
> >               - const: netsys0
> >               - const: netsys1
> > -        mediatek,infracfg: false
> > -
> >           mediatek,sgmiisys:
> >             minItems: 2
> >             maxItems: 2
> > +        mediatek,wed:
> > +          minItems: 1
>=20
> You just need maxItems here.
>=20
> > +          maxItems: 1
> > +
> >     - if:
> >         properties:
> >           compatible:
> > @@ -385,6 +387,10 @@ allOf:
> >             minItems: 2
> >             maxItems: 2
> > +        mediatek,wed:
> > +          minItems: 2
> > +          maxItems: 2
> > +
> >     - if:
> >         properties:
> >           compatible:
> > @@ -429,6 +435,10 @@ allOf:
> >               - const: xgp2
> >               - const: xgp3
> > +        mediatek,wed:
> > +          minItems: 2
> > +          maxItems: 2
>=20
> Analogously, you should be needing just minItems here if I'm not wrong.

Yeah, you don't need to duplicate constraints that are copies of the
outermost one set in the definition. I dunno how it is actually done by
the schema tools, but I like to think of it that every constraint that's
possible is applied at the same time.

pw-bot: changes-requested

>=20
> Cheers,
> Angelo
>=20
> > +
> >   patternProperties:
> >     "^mac@[0-2]$":
> >       type: object
> >=20
>=20
>=20

--KThuiYHY98QAsVsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEO9QAKCRB4tDGHoIJi
0hB8AP0WbwLBXfaFxwsMo5BvlMRztESdk8TuK8HVUS2Q6TWmTgD/WTWk4/gsETsu
K0xG+ZNiHz8uOyLf4AObjEBnftGY1gA=
=Hk7g
-----END PGP SIGNATURE-----

--KThuiYHY98QAsVsP--

