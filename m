Return-Path: <linux-pci+bounces-40467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B22C397F8
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 09:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D78934E4919
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F7E2FFF91;
	Thu,  6 Nov 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvHF5V12"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0B288C25;
	Thu,  6 Nov 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416247; cv=none; b=n53Gn9PbhxAyEhgW7n+TOnc2PuAsbsb4hswg3MhcuKvt8Cc3K1cB7BLVeg1HAxpdgAh/0jSHUIAGFQuKmmMMDaogspITJqO/2UhXCqnnNQ2BCvOTRUe414ZURaXg8Krr4iDfe3NXXIlg0mLi/+mtoBAb17vK66pNJPaDaHFIyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416247; c=relaxed/simple;
	bh=ccHkm5qtYzT6iKa2MpQExMHciYd9ipIA4PEh7rQnhmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j47mOUvD5tqvVVb6ld6LetIuZPz8nmzt5FscL3kEZIVM0lBrhaTEem69u2Eu3n45WuG9UvgNlMrjsal6KoyPsm3Z/547tvHWb51mIy2cZwX2ZHbye/QAfHUJOOS6XgCataU6vMbpRUqTnTOjHtwMsQ/QNkUHSqfWMej30HKmo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvHF5V12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA2CC4CEFB;
	Thu,  6 Nov 2025 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762416247;
	bh=ccHkm5qtYzT6iKa2MpQExMHciYd9ipIA4PEh7rQnhmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvHF5V12wKqbRMiQh9lD2BGO6IANaZaFz4LZfCAwGDwOjoG5QFOJu38rdjOPjw8mV
	 haXxY/iWnRM8GboXg478oHWJpF2vHWZzLbOfM/2L2YdtzCSYDa4Tf4zv/kcfmniEiY
	 d/I6gdIPiAsnEkbIkqaIrnWxY1RTzRJCXPgrWt3P5VaSdknfiowbmC+SZQevCd/ldP
	 blDmJLIhXIIJ4mtoBiVRN9A8X3tPOBUdfcXS/Ag+iQHm1J1rmKsbODJ6dnTxLw4NVG
	 Hq8vSt7CDeRJKm8OSn6K2RRO36AAkqGww9DdqxAFgro75BPf3L6XHde6ydlik4vGXv
	 Skifuqv+5A5tg==
Date: Thu, 6 Nov 2025 09:04:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, kernel@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>, 
	Bryan Hinton <bryan@bryanhinton.com>
Subject: Re: [PATCH v3 08/13] dt-bindings: net: mediatek,net: Correct
 bindings for MT7981
Message-ID: <20251106-unbiased-warping-earthworm-f4f66c@kuoka>
References: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
 <20251105-openwrt-one-network-v3-8-008e2cab38d1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-openwrt-one-network-v3-8-008e2cab38d1@collabora.com>

On Wed, Nov 05, 2025 at 10:18:03PM +0100, Sjoerd Simons wrote:
> Different SoCs can have different numbers of Wireless Ethernet
> Dispatch (WED) units, specifically the MT7981 only has a single WED.
> Furthermore the MT7981 uses infracfg for PHY switching. Adjust bindings
> to match both aspects.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
> V2 -> V3: Only update MT7981 constraints rather then defaults
> V1 -> V2: Only overwrite constraints that are different from the default
> ---
>  Documentation/devicetree/bindings/net/mediatek,net.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index b45f67f92e80d..c49871438efc7 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -338,12 +338,14 @@ allOf:
>              - const: netsys0
>              - const: netsys1
>  
> -        mediatek,infracfg: false
> -
>          mediatek,sgmiisys:
>            minItems: 2
>            maxItems: 2
>  
> +        mediatek,wed:
> +          minItems: 1

Drop, 1 mis already minimum.

Anyway, this does not match top-level schema which said minItems 2. You
need to keep these consistent among all variants and top-level.


Best regards,
Krzysztof


