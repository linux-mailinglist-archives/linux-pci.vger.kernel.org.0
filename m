Return-Path: <linux-pci+bounces-38360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 618D3BE43BA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 322474EFCC3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1437346A1D;
	Thu, 16 Oct 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALpMVbPj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D133A037;
	Thu, 16 Oct 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628537; cv=none; b=M3RaPQAIgf3FRVz+Neweu3rp+cT7OOltQze/t91YBDJqwEZSmDaDPtNcBtla3c9lrHIL4LRkrzN8mJr/YIFJUfvbEnUZ/bqofc+GB1mj8DIpo/qopJJkgPtgOsGk1g0EAFAhqRtUgk9q8ii750vl5fJrD/x/IgCexU5JdTgCKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628537; c=relaxed/simple;
	bh=I7b9xvQJvn+z4iQPtGIceLHSQFuSSr5cVrsso6sCoFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljERgfCZyd4NY984CeCHPg2BZ22NFOAlwrPOfi8KcgNYXg0+Te/P31kZSXsMLqin4OwVfRUsLq2nQGxEUf1lCSKwrahmsc6RWT4iEEIiChfbQl0n/B87eQ5aJTN9Vle06FTP5SBsP9r6oKgFusj2SCGyYcWCWi1A4v6zE2m84s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALpMVbPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06B8C4CEF1;
	Thu, 16 Oct 2025 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628537;
	bh=I7b9xvQJvn+z4iQPtGIceLHSQFuSSr5cVrsso6sCoFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALpMVbPjjZ7Jz7UCmo6R+Dkwa3Vhis6i3heFLOQbe2U6RH+FkxJ1EufLHcPy0e5Qd
	 W2vXueItqFTsdPnmvv5Z0wepsXRpYHjFC1+mzt9+Z2zP2L+o54HzLOeM7kuE3HkJbw
	 sem59TFWEHReDfHLxnzrww9mrRKyBWVWsli8LIeUMQezfhYArj4hQeYE6KJ28LYWhb
	 IVrE9ozACc48Z3gEzDve2IrcosHk6btmX5GgG78Vk1iz7umIQXjIgHKc8PPLaf6OIk
	 cnM0Bx5EyKpjOmqkr8hXdIkX8XOzHk9+rRfBAHs+Lp+mpy7kBXs9Qku7p87DX2Pyxg
	 yYZjCq5G581hw==
Date: Thu, 16 Oct 2025 16:28:49 +0100
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
Subject: Re: [PATCH 05/15] dt-bindings: pci: mediatek-pcie-gen3: Add MT7981
 PCIe compatible
Message-ID: <20251016-alright-faceless-d108b4404f18@spud>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-5-de259719b6f2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7sD/UBKvAzBhEk0V"
Content-Disposition: inline
In-Reply-To: <20251016-openwrt-one-network-v1-5-de259719b6f2@collabora.com>


--7sD/UBKvAzBhEk0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--7sD/UBKvAzBhEk0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEPMQAKCRB4tDGHoIJi
0irWAP922D9ouq+yqqXAkNPlJfn+p96a/IZunktRHa3vfn1+hQEAvfRsy3Kv/Eya
nlym3bc2N0JsAhT6vmFgMrTqkn2B6A4=
=FZjQ
-----END PGP SIGNATURE-----

--7sD/UBKvAzBhEk0V--

