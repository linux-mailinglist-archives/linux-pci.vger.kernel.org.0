Return-Path: <linux-pci+bounces-41671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA00C70AD7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 19:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C49522ABFF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0363254B4;
	Wed, 19 Nov 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdRjYlhh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094730E84B;
	Wed, 19 Nov 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577767; cv=none; b=a5lSBn+YE8zT90baTw4X/7bcfReywYOt2UCNLKELiKpMWX00cWEpf56jPnODmYRQWtITuPlTE0gKwcvOqVn9zuG6I5lQ+EZ5TCWlpVSz6G8ruzqJzE3/eDkpiVjblbA77s97T2riNTcOuAY17HYjCG5qVB/DOeGQZdS/goWpQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577767; c=relaxed/simple;
	bh=d+20Uj7V/wB53t3E3ACYXIU/QyzVL9+KYCOlwfL2P6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF6xehNMKnVDSbI7EdebYMczcdJ/UE0vuGENrVdYWxsqM18z8u9pUaxbTs/jwXT9IHehyLsoXwUo396dmDeffQrt0ne2Y6QC5pMowaB0vLJdLQLXp6EYpd6MfHdpIwPw0lw2I8oRCwp8PclpwpPfZuhv/9Hcs11qU9Ymgz3nY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdRjYlhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23360C4CEF5;
	Wed, 19 Nov 2025 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577764;
	bh=d+20Uj7V/wB53t3E3ACYXIU/QyzVL9+KYCOlwfL2P6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdRjYlhhDT9zjqscZl9dlk/VT2v65GFWB3iqHMzaQ4z8NdllYI0b1kSjnUUz5X5As
	 UgF/WhAJt0vsYmMaV6bLjCxpKGQwamYcp2JNPSeQSbN2UxLWnLS6JJqLX2faMrUGzf
	 oYwOaEAMmod6faMCkejLzbEJ2C75HCLHat1HLOPlRK3zKoxUEfNwB/rTVIEkgKBF/c
	 +4Jyd7+usTtI1J7mKfFdwJu9l8vG3vosYdvG2btZbhB3rL5twxTFCkDnirM71iUsP4
	 NOFrrtdQbgWHEnu3hJpo/LU7j1I+c0+3ylyPLfB3tF1pNfrH5xcRU4RgwtxWMHVVPt
	 BRNWVIKBrXAvQ==
Date: Wed, 19 Nov 2025 18:42:37 +0000
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
Subject: Re: [PATCH v4 06/11] dt-bindings: net: mediatek,net: Correct
 bindings for MT7981
Message-ID: <20251119-snowless-thrower-0c4743a2820c@spud>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
 <20251115-openwrt-one-network-v4-6-48cbda2969ac@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWZxw9N+U4ItickZ"
Content-Disposition: inline
In-Reply-To: <20251115-openwrt-one-network-v4-6-48cbda2969ac@collabora.com>


--OWZxw9N+U4ItickZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 09:58:09PM +0100, Sjoerd Simons wrote:
> Different SoCs have different numbers of Wireless Ethernet
> Dispatch (WED) units:
> - MT7981: Has 1 WED unit
> - MT7986: Has 2 WED units
> - MT7988: Has 2 WED units
>=20
> Update the binding to reflect these hardware differences. The MT7981
> also uses infracfg for PHY switching, so allow that property.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OWZxw9N+U4ItickZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR4PnAAKCRB4tDGHoIJi
0qysAP4slbkJvvcDz+LiScI3HC4oFNoFUawshCKoNhDhEg0RZQD+JPTtXG5xiV2r
lqSBXMrX7H73koX9k2vleiv2AUW+EAI=
=X2CE
-----END PGP SIGNATURE-----

--OWZxw9N+U4ItickZ--

