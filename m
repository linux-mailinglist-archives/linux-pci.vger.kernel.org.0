Return-Path: <linux-pci+bounces-38359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAEABE43C0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB103A6844
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BD346A1B;
	Thu, 16 Oct 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeVKqESo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E10212542;
	Thu, 16 Oct 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628510; cv=none; b=DA5+Mv6tXyLP1XJuG45KqnfDKg55CNQyqAV27Tr8cFOiHumbxQDGbH4LJ5DGyJDoCUrgzWZQx9kvi4w8tWj5o2h4pvpDWXwa07oZkokC4dY8t0rAwKACRqE0BheJ5Q0fo+zNYS8oBbVtDzFgGbqm0o+w3XZvJ4hC/I82JnEHDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628510; c=relaxed/simple;
	bh=vFeX8GTTbE6dDYs0n6rTwcQeVXZ0OwNNC4fiFan0Fx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoailM51PaAvzrvtiI7If9R9jvalDYKXuULnvtHHfSInJ3WrpIuHazeBRNpWu3jj9S98gFRfe0c7CiBnrk1i5b3WBwWKWa6RuAEmFbRHwEo9uvua8v4ZLnagZsXGmRjdfTqtIDE19tUbq6HFyNP3u0V6LbzqNIti7X8UTKSk8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeVKqESo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A8CC4CEF1;
	Thu, 16 Oct 2025 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628510;
	bh=vFeX8GTTbE6dDYs0n6rTwcQeVXZ0OwNNC4fiFan0Fx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeVKqESo2MhsXZIcjMHwwMffLOQWAkNNh6YaUV/EbfrOh5M0ehVcze+4kRu4KLTS4
	 H9nGr90f5odFULfRsetgro7TrYQ2v5fi7HTaVpUCadugAQN7JetX7NAksTrBqeCxu0
	 d5yFyI/nKpmtcb44KLM/xyDhT22SRgNt1eKk5NJ3hpE52ldX9Yw2zoLVPp1xhr4s4l
	 SK9AvGtt4AI1SDE2fySpmz0Yjv4RlP+RiYv47m9H8GEnrkj9yG3TMDXTLB/coai2ZH
	 pF3xorZ5pOCVdLYmkDKCfAqdz+pFq8eAYVP71vIlGDnfB7AGUGPQ3QNIjyPtLzengl
	 jKKRYiZT676Ig==
Date: Thu, 16 Oct 2025 16:28:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
Subject: Re: [PATCH 06/15] dt-bindings: phy: mediatek,tphy: Add support for
 MT7981
Message-ID: <20251016-constant-drinking-a7847adeabac@spud>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-6-de259719b6f2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nXHt0JSoCeXXUnko"
Content-Disposition: inline
In-Reply-To: <20251016-openwrt-one-network-v1-6-de259719b6f2@collabora.com>


--nXHt0JSoCeXXUnko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:08:42PM +0200, Sjoerd Simons wrote:
> Add a compatible string for Filogic 820, this chip integrates a MediaTek
> generic T-PHY version 2
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/D=
ocumentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index b2218c1519391..ff5c77ef11765 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -80,6 +80,7 @@ properties:
>                - mediatek,mt2712-tphy
>                - mediatek,mt6893-tphy
>                - mediatek,mt7629-tphy
> +              - mediatek,mt7981-tphy
>                - mediatek,mt7986-tphy
>                - mediatek,mt8183-tphy
>                - mediatek,mt8186-tphy
>=20
> --=20
> 2.51.0
>=20

--nXHt0JSoCeXXUnko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEPFQAKCRB4tDGHoIJi
0jX+AP0TA17pIR1hJMPQpqSEQHh7sVBT5R0NG998cvCpK5isZQD+LG7nfGpgLlzy
T0IpdRMx9PsdaHA7MSf4y/3FKHkXvA8=
=WiNI
-----END PGP SIGNATURE-----

--nXHt0JSoCeXXUnko--

