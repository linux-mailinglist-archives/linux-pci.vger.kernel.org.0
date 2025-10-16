Return-Path: <linux-pci+bounces-38338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C31DBE30FE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC85535770D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52831D73F;
	Thu, 16 Oct 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P+k/c9b/"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010403203BB;
	Thu, 16 Oct 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614145; cv=none; b=VME8qgSEzwK+7IcNOat5emKf/F3V2IVF6Bz1eGieKL8eWm7XWtyQtGbM9Qbpsq3JVunWBm6Y+ITX1WFIQg2l7CyjeWHJYZgZD4bpA6bxj00T3utiY0RS2JwCt3q/5t91/n/xiVx6GTi5eBs5jsks2WKGnXjWzIRHjrUAfK9LWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614145; c=relaxed/simple;
	bh=Lyvu6W6BJMbQvMe056uyOaXg7YLenPa5GIWWFX8E/rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9PMfcoQlClM9v0V9OgG6iKCRJ+ruWF6udEYBTRCnEpgMuAk/HO1DDDkhoEW7LfkyNz2uQO5c7oa3ewfPtH/FY6KASzm3qZqzXo8Abi012wYfCZyLGyE4MhWlCt+ppoG6mx03OFnuY1fh6tIyIJG+jtU4stRcoSL2ZOFRFMEmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P+k/c9b/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614141;
	bh=Lyvu6W6BJMbQvMe056uyOaXg7YLenPa5GIWWFX8E/rw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P+k/c9b/tT/S6b/bCGrw20R65X5wNohtsfjdiiULHXkUpfoF6JwbyHE+DAPyAy+S5
	 rW/3Um7K493Cg4w9vhOkhJG+kLzwkiv+o7p5OlsZZhgYUB0OV80ysyhfuUgJiOWnUn
	 HtGkJ40RC3joebArgmYoI5JM/tvaZenM/pyfpOCAL7CmtLI5YK14rtjWJFrwClrDbN
	 vWok5W8/IOYDyXuKXwiPLMF16fTnGxvMZJSohPiKLrw/ZfPW3aNpqSTC22L4b2ZwLr
	 rffLiZiVia1nkAbcRDLMvpGDeoehJsuCrrnWNhSaFR0XcC4tikxYlk5+oDXQ7mj0LH
	 4El5IzVEad9Mg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2992D17E1418;
	Thu, 16 Oct 2025 13:29:00 +0200 (CEST)
Message-ID: <42c6675b-3803-4a9a-a716-42e3f9c8bb49@collabora.com>
Date: Thu, 16 Oct 2025 13:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] arm64: dts: mediatek: mt7981b: Add Ethernet and
 WiFi offload support
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
 <20251016-openwrt-one-network-v1-10-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-10-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> Add device tree nodes for the Ethernet subsystem on MT7981B SoC,
> including:
> - Ethernet MAC controller with dual GMAC support
> - Wireless Ethernet Dispatch (WED)
> - SGMII PHY controllers for high-speed Ethernet interfaces
> - Reserved memory regions for WiFi offload processor
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 133 ++++++++++++++++++++++++++++++
>   1 file changed, 133 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index 13950fe6e8766..c85fa0ddf2da8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi

..snip..

> @@ -347,6 +389,97 @@ ethsys: clock-controller@15000000 {
>   			#reset-cells = <1>;
>   		};
>   
> +		wed: wed@15010000 {
> +			compatible = "mediatek,mt7981-wed",
> +				     "syscon";
> +			reg = <0 0x15010000 0 0x1000>;
> +			interrupt-parent = <&gic>;

That's redundant: gic is already the default interrupt parent for this node.

> +			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> +			memory-region = <&wo_emi0>, <&wo_ilm0>, <&wo_dlm0>,
> +					<&wo_data>, <&wo_boot>;
> +			memory-region-names = "wo-emi", "wo-ilm", "wo-dlm",
> +					      "wo-data", "wo-boot";
> +			mediatek,wo-ccif = <&wo_ccif0>;
> +		};
> +

..snip..

> +
> +		eth_sram: sram@15140000 {
> +			compatible = "mmio-sram";
> +			reg = <0 0x15140000 0 0x40000>;
> +			ranges = <0 0x15140000 0 0x40000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
> +		wo_ccif0: syscon@151a5000 {
> +			compatible = "mediatek,mt7986-wo-ccif", "syscon";
> +			reg = <0 0x151a5000 0 0x1000>;
> +			interrupt-parent = <&gic>;

ditto.

> +			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>   		wifi: wifi@18000000 {
>   			compatible = "mediatek,mt7981-wmac";
>   			reg = <0 0x18000000 0 0x1000000>,
> 

Everything else looks good.

Cheers,
Angelo


