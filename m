Return-Path: <linux-pci+bounces-38361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE7ABE43C3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FEF19C76D5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C534AAE2;
	Thu, 16 Oct 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQneNmV3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A11E1C22;
	Thu, 16 Oct 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628588; cv=none; b=q+u1CUCPHfJCODH3Zqia2Qr6CPO99Jl5JsnKy28ley6I8MC9GV73G7e2hn2wGbwZ0HX7Tgjzem1PxYCuT/LnDMOEkXyIxCeZon7isdzLKQLOEeR8GXFpYNKEqGligsVneYpk5hYwjh+D30JrljVU7kb45cvu7Eha0wTNfJ7l5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628588; c=relaxed/simple;
	bh=5zk1p7uXJyG52PlTiJ7jqUnfX5vE/Lrp7UbPQeEvOJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsV6dBthZQSa0ik/KHTOud9+vvBH4R27O3BixFVFCVYqh+cJkx0R/lLfKUlQMc0Y/4J+9sSYJVxR80JLFqWJsr7bX8ZXMvhIPsapdrxXTu1vD0Q1UAX2r8PdCJoYvJC9vNCeAUp5gigTphrgn8Onh0w/g/sORorHay29OGtMGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQneNmV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E988C4CEF1;
	Thu, 16 Oct 2025 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628588;
	bh=5zk1p7uXJyG52PlTiJ7jqUnfX5vE/Lrp7UbPQeEvOJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQneNmV3fhnPk6gQ3KzkiuR6069UmCX3IsMiH2yV1uc64GIREVNxD8GqCuiqG7bio
	 5muhMwudzSKyN6C7D1PT5JKk8gK/7ZuusIDrooi9VlwIRctSC5n5CLd3SOzdIzHu1K
	 +5ZpI5+caDru2iwMUIeW9y7TC3G3fb2JYdwgAoxAfTlpwyCTQJ2sBZDgctDGAXTk/k
	 H/ZJsknAWP7DS9JqRd6w6rK0YFXgAsSXnCGUy5hrtRTE8FQty6go27xad5eGL73mKf
	 xAyFB00JW4JZWPtYMMQPUpPq0cPq+OmrWO+5Xc/+H27GeonxjVJsGaV64b16ehpn2J
	 Yj1+MNOa0JZjQ==
Date: Thu, 16 Oct 2025 16:29:40 +0100
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
Subject: Re: [PATCH 04/15] dt-bindings: mfd: syscon: Add mt7981-topmisc
Message-ID: <20251016-pellet-speckled-fab8e8690051@spud>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-4-de259719b6f2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="It0qxNZczVw/gaKL"
Content-Disposition: inline
In-Reply-To: <20251016-openwrt-one-network-v1-4-de259719b6f2@collabora.com>


--It0qxNZczVw/gaKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--It0qxNZczVw/gaKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEPZAAKCRB4tDGHoIJi
0i02AQCtlo1PhEBtOSpa9tHFh/btZnLURhGuXrndCwW9sNu9YAEAgh9CEJPYY+RU
n/3HO7MCmrIAjvCB4YbZBXt04Uzn6Qw=
=0tqc
-----END PGP SIGNATURE-----

--It0qxNZczVw/gaKL--

