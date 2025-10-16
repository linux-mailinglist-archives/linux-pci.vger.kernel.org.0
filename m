Return-Path: <linux-pci+bounces-38339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82FBE3128
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E183587F1B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2676320A38;
	Thu, 16 Oct 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e6LvruAJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7E3191D7;
	Thu, 16 Oct 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614146; cv=none; b=tyxJwxaECBBGeYxznYFVX/BW6qA7r/ew7/bkBoSsMoYpo1YqbXYhAQSOV22q9oTIMPLuMOr/v9+SckNDEFe6XBjnQ2Urr3LfwYNa+wO5/wQSoTfOZn+kF82FIcxhqZ13uj2wdrZeIL3P0bQOOY56RSv82pjUfVOzAoFKtMSbrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614146; c=relaxed/simple;
	bh=BPA7Ao4Fqy8fEZQZyIBHfPwMiJe3jfH+OsQSSw5hw/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=borM7RwdjfuAAiy+eQq74aAc3oQdW8Pkz2eD4Uaz7rvaFWckSl2FDlgLxh7VScnGeWDU0JhiC5Z4/8qTb3Hxowpiqdll7yfyHqfLOaxE0y/QZi42IaU50p8m7FMM04keOqcagjUBEB0PAEkaEtOTCgbMzqZBhNMbboY2bBwCr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e6LvruAJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614143;
	bh=BPA7Ao4Fqy8fEZQZyIBHfPwMiJe3jfH+OsQSSw5hw/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e6LvruAJ9tFLUmLLRK0OTnqCIn9iRTA/tk9844dbLHGo023FqNfdQ7u4uWJ5VR7zb
	 xh8wvG0/aWCfKVhLV68YXX8o9v7Rfe1i2YqrXK2gBaW/IRU/BOyREu/uL1l+Yh0vcH
	 hcVR24QYEhVTKXFqifnbFs4a/ZaR7msGw3N7B/3mHbzZra1yexJbu/rJVfjcIk0iaF
	 OAqMi0dss1MNyf6aGxMcTffSfR0lEXwdzq5Gttvrv4F6xl4neer7i4z53MCqrOryyl
	 3Wi3a3O1tU+t00sZNmz5O8eKd+f2UUoYOvdqRPelxqbPCSHbIC7UDFYbdSE6aZ/N3Q
	 BxJZSGGRtLKIA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB39817E153A;
	Thu, 16 Oct 2025 13:29:01 +0200 (CEST)
Message-ID: <a3d6b229-8f33-4e88-8a55-6c5640f688e1@collabora.com>
Date: Thu, 16 Oct 2025 13:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] dt-bindings: net: mediatek,net: Correct bindings
 for MT7981
To: Sjoerd Simons <sjoerd@collabora.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-9-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-9-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> Different SoCs have different numbers of Wireless Ethernet
> Dispatch (WED) units:
> - MT7981: Has 1 WED unit
> - MT7986: Has 2 WED units
> - MT7988: Has 2 WED units
> 
> Update the binding to reflect these hardware differences. The MT7981
> also uses infracfg for PHY switching, so allow that property.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
>   Documentation/devicetree/bindings/net/mediatek,net.yaml | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index b45f67f92e80d..453e6bb34094a 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -112,7 +112,7 @@ properties:
>   
>     mediatek,wed:
>       $ref: /schemas/types.yaml#/definitions/phandle-array
> -    minItems: 2
> +    minItems: 1

If minItems is 1 here

>       maxItems: 2
>       items:
>         maxItems: 1
> @@ -338,12 +338,14 @@ allOf:
>               - const: netsys0
>               - const: netsys1
>   
> -        mediatek,infracfg: false
> -
>           mediatek,sgmiisys:
>             minItems: 2
>             maxItems: 2
>   
> +        mediatek,wed:
> +          minItems: 1

You just need maxItems here.

> +          maxItems: 1
> +
>     - if:
>         properties:
>           compatible:
> @@ -385,6 +387,10 @@ allOf:
>             minItems: 2
>             maxItems: 2
>   
> +        mediatek,wed:
> +          minItems: 2
> +          maxItems: 2
> +
>     - if:
>         properties:
>           compatible:
> @@ -429,6 +435,10 @@ allOf:
>               - const: xgp2
>               - const: xgp3
>   
> +        mediatek,wed:
> +          minItems: 2
> +          maxItems: 2

Analogously, you should be needing just minItems here if I'm not wrong.

Cheers,
Angelo

> +
>   patternProperties:
>     "^mac@[0-2]$":
>       type: object
> 



