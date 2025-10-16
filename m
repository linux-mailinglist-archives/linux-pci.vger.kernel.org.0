Return-Path: <linux-pci+bounces-38337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6ACBE310A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C235878A0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A031DDBA;
	Thu, 16 Oct 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FydvyZ78"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D031D73F;
	Thu, 16 Oct 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614140; cv=none; b=nHAqlPNANKVXK+2DTE/1VaAh4Da0XiRWyKiHMt5TD+KYmmcQLtijw28Y9LCsfiBRu3qI1LMmiMsOGSGSBsfuUYKd9p6W+/QHWj8ytmOBKien79oK3fwDPDPPMy8wiZw/OXD9N/grsh7z1NDMgWjpz+n6sRYuq5o5ZgxqBDabgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614140; c=relaxed/simple;
	bh=a6EjBxSL+AztzP80wd9ior27gbskV5duRrn8UtU92OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPWQbAu5JBfFBdg7PTDfA7q6DpF2ZiSf8D48K3U+O5hOEIXVAHzNc9RBVaFqNmUGC/sm/ujIU7sIuPraAocJyNVDFEQbN7mjELvBGYr7xYaGnYUhxEgLzQ8/ux/Ot+3AkQ95mVS7BKvoTgdCGqAyOyIRAb5hiyql+GtodU/B1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FydvyZ78; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614137;
	bh=a6EjBxSL+AztzP80wd9ior27gbskV5duRrn8UtU92OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FydvyZ78tjryCDGlhIks+F1YqEJueAtJgd8GtlWtWs6sKRBlhIiAG/XWJMkHcjHSx
	 d50HPq3ja2DGVi/jmj4frdJXmUkYqo3aeWzXztJo1ERWnzkinwgwxsNcQBoyWHIWVG
	 VR0jcXLfK3y45ji4ipPW/X/86cnxGqabJdJb7pAkarYIE0ISOr5T/82wy59BDB7TVc
	 GD+ggRlOAI5J0CdRkTNfb7ORmKKJulmaYkOYL6XfIPMOsl1QLGjqB1YwQgXAidNHN8
	 5KPK3tMDhmma1gHJfL7TpqKXQUyYymAqzRvXt5Wbl4MDx+0E4a533zfopgYCCyhAV+
	 dmkpyRpsMLqWQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 479B417E1407;
	Thu, 16 Oct 2025 13:28:56 +0200 (CEST)
Message-ID: <c9865ab0-cbc2-47b5-b7cf-acb8b9c52695@collabora.com>
Date: Thu, 16 Oct 2025 13:28:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 SPI NOR
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
 <20251016-openwrt-one-network-v1-11-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-11-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> The openwrt one has a SPI NOR flash which from factory is used for:
> * Recovery system
> * WiFi eeprom data
> * ethernet Mac addresses
> 
> Describe this following the same partitions as the openwrt configuration
> uses.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
>   .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 83 ++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> index b6ca628ee72fd..9878009385cc6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> @@ -3,6 +3,7 @@
>   /dts-v1/;
>   
>   #include "mt7981b.dtsi"
> +#include "dt-bindings/pinctrl/mt65xx.h"
>   
>   / {
>   	compatible = "openwrt,one", "mediatek,mt7981b";
> @@ -54,6 +55,25 @@ mux {
>   		};
>   	};
>   
> +	spi2_flash_pins: spi2-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi2";
> +		};
> +
> +		conf-pu {
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
> +			drive-strength = <MTK_DRIVE_8mA>;

drive-strength = <8>;

> +			pins = "SPI2_CS", "SPI2_WP";
> +		};
> +
> +		conf-pd {
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
> +			drive-strength = <MTK_DRIVE_8mA>;

ditto

> +			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
> +		};
> +	};
> +
>   	uart0_pins: uart0-pins {
>   		mux {
>   			function = "uart";
> @@ -62,6 +82,69 @@ mux {
>   	};
>   };
>   
> +&spi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2_flash_pins>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				reg = <0x00000 0x40000>;
> +				label = "bl2-nor";
> +			};
> +
> +			partition@40000 {
> +				reg = <0x40000 0xc0000>;
> +				label = "factory";
> +				read-only;
> +
> +				nvmem-layout {
> +					compatible = "fixed-layout";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					eeprom_factory_0: eeprom@0 {

wifi_calibration:

> +						reg = <0x0 0x1000>;
> +					};
> +
> +					macaddr_factory_4: macaddr@4 {

macaddr_factory_gmac1?

You're not using this in the later commit where you enable ethernet nodes,
did you miss adding that to gmac1 or what is this used for?

> +						reg = <0x4 0x6>;
> +						compatible = "mac-base";
> +						#nvmem-cell-cells = <1>;
> +					};
> +
> +					macaddr_factory_24: macaddr@24 {

macaddr_factory_gmac0 ?


Cheers,
Angelo

