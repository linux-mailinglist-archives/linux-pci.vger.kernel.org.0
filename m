Return-Path: <linux-pci+bounces-38334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0370BE30D5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E721A62360
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACC13164D2;
	Thu, 16 Oct 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DRqiCVfG"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E439316193;
	Thu, 16 Oct 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614135; cv=none; b=REr7wd2LvkiGuPZVxMVs7pPxMGOdceTq2Nfwq/WsKxBwwW9jw8Ay1PROM1JnU8XamLZMihn0zBnaKyZ2KEsKiqKDiBC0FYSMxVlmN8fXKZ/C8/Yn/93YOXrIeK2/tDWmARSwwfsB6hYJHqffBYsoFIk1WTlr3lnjBf1WxY1pryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614135; c=relaxed/simple;
	bh=+wVRuiQnZqQTQ83N4gc5pdZaUVwxqdGkvElu0H8WEmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8MsWxmoaCpjpQSorjR2eXbSO5n+tRpbfGNIqUH/umjL7lh/rl+2Nj0hLuYMiqSLlm5pqWq91qYPJBKLW+vvj8z6oanGBellC7NWkbkblH3xWjM9+zXeC/RUdlpVKsN0BDwJ31GBtTAIN6vTtY69PikUTntELg3p4eEE+w3xrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DRqiCVfG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614131;
	bh=+wVRuiQnZqQTQ83N4gc5pdZaUVwxqdGkvElu0H8WEmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DRqiCVfGvV57D50LE8su2GRqaZLq3rrABrFVgonzCYXAgI/VwlNkQ/zATG7M7A9p+
	 OfBTDu2enhUjXetbR+bDKGwhTMXFe5LrnNN/lO7lOjrQQEDT09nb5gU6WMmlgliWNE
	 K63Q50Mz2OLlil5SmFgu88kZuUqYKJtCTQKPOoI8qzoC6PHm5b7JIrWsiChKes2yvG
	 VcKcmzDmtRqTsxRAKW4PGntbW2jRn6W7QzKLBNiP3cSDm2Zv6BPI/lV0DuvDP5N09k
	 qRm/xBKDUb7UFXvLgZBdvF4zQ+904CjlQCwmHcZkS8H+QfLJHFXUYy+5QSN4DCY/Gb
	 DjyeePEguMP7w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5184A17E05FE;
	Thu, 16 Oct 2025 13:28:50 +0200 (CEST)
Message-ID: <7333fc2b-bc30-41bf-be09-2b9ff7c3599f@collabora.com>
Date: Thu, 16 Oct 2025 13:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 leds
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
 <20251016-openwrt-one-network-v1-15-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-15-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> The Openwrt One has 3 status leds at the front (red, white, green) as
> well as 2 software controlled leds for the LAN jack (amber, green).
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
>   .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 57 ++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> index 4d1653c336e71..0c0878488ae98 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> @@ -43,6 +43,50 @@ reg_5v: regulator-5v {
>   		regulator-boot-on;
>   		regulator-always-on;
>   	};
> +
> +	pwm-leds {

Please keep the nodes ordered by name.

Cheers,
Angelo

> +		compatible = "pwm-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_WHITE>;
> +			default-brightness = <0>;
> +			function = LED_FUNCTION_STATUS;
> +			max-brightness = <255>;
> +			pwms = <&pwm 0 10000>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-brightness = <0>;
> +			function = LED_FUNCTION_STATUS;
> +			max-brightness = <255>;
> +			pwms = <&pwm 1 10000>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&pio 9 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_LAN;
> +			gpios = <&pio 34 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "netdev";
> +		};
> +
> +		led-2 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_LAN;
> +			gpios = <&pio 35 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "netdev";
> +		};
> +	};
>   };
>   
>   &eth {
> @@ -109,6 +153,13 @@ mux {
>   		};
>   	};
>   
> +	pwm_pins: pwm-pins {
> +		mux {
> +			function = "pwm";
> +			groups = "pwm0_0", "pwm1_1";
> +		};
> +	};
> +
>   	spi2_flash_pins: spi2-pins {
>   		mux {
>   			function = "spi";
> @@ -152,6 +203,12 @@ conf {
>   	};
>   };
>   
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pins>;
> +	status = "okay";
> +};
> +
>   &spi2 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&spi2_flash_pins>;
> 



