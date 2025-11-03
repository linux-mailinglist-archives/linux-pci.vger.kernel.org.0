Return-Path: <linux-pci+bounces-40086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9FC2A9F2
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BA03AC304
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E952E173E;
	Mon,  3 Nov 2025 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BWIJmt80"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02372E0928;
	Mon,  3 Nov 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159472; cv=none; b=tYaTsJhRu5kkawCneyN8AHIlcvhckOP8TUCrHwNE3BTrRtahdhcjPhK0oQSHPXtMBnCHTcP8tk/ZYo/FU2JtSfcCsA1mpDl63wgxuu6dJMcQyPBvOJQgWO5qO+ndEyK1RB/YpG7YmzObQlCV4Qq3fOkSjQ7odV7aCWOqGIBGhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159472; c=relaxed/simple;
	bh=pcZ33mdM8HReLodUv0lZriPlCCx/Bf24CmKMc0Svvy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmFGmuCTj/4x89Seyw2dqq2wgHQ9OzSJlB3LtseLe2gJP/Fn9CvKDCFBVm+PhVgE0TcavjD9f8G7Pz8AZKwgT4Cm04IZNa0nTSurqbfqCHlRP9E5BRfk3pfXUYI7B/Dv67WvxdwJL5bSmL5RD3b28aT+FhpZZ4yQX/7i8pOPgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BWIJmt80; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762159469;
	bh=pcZ33mdM8HReLodUv0lZriPlCCx/Bf24CmKMc0Svvy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BWIJmt80XBuwFXq8VSpppUMxGRo2XS0HDV66ojU1NOb7prrkEmP7cxOqiD5li7Ofg
	 RgTMmjXCKyLnfQWUzoy5k95p4uyVasN03CIsB8HyhIyk4cDQXGc3j2YhzfsFsv9+17
	 8HAEmCaxNSOjGxMQpErDjoLxCXjsd8QefCQrZwI7u3DiGaEZ4YgihN2UCDGopCuHrk
	 vvQx3qo51DkK9E63L9jbn5O/qC+D2aNqj69rUOM5oCXZz+IDCm3lPdnk7ssUT7l19n
	 53582eSur4BENwCS1yBKOI6W0kugUddjopf79Vi4SvtZzJ7MaT0Tvx05Bw/c+gRfz9
	 FTpwcyHQcGLFA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D772817E1299;
	Mon,  3 Nov 2025 09:44:27 +0100 (CET)
Message-ID: <9cba2013-0f01-40ab-9d3b-10f4bc3f02f3@collabora.com>
Date: Mon, 3 Nov 2025 09:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] arm64: dts: mediatek: mt7981b-openwrt-one:
 Enable wifi
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
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
 <20251101-openwrt-one-network-v2-14-2a162b9eea91@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251101-openwrt-one-network-v2-14-2a162b9eea91@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/11/25 14:32, Sjoerd Simons ha scritto:
> Enable Dual-band WiFI 6 functionality on the Openwrt One
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
> V1 -> V2: Update eeprom node label
> ---
>   .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 24 ++++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  2 +-
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> index 90edb9f493c6d..b13f16d7816bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> @@ -129,6 +129,22 @@ conf-pd {
>   			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
>   		};
>   	};
> +
> +	wifi_dbdc_pins: wifi-dbdc-pins {
> +		mux {
> +			function = "eth";
> +			groups = "wf0_mode1";
> +		};
> +
> +		conf {
> +			pins = "WF_HB1", "WF_HB2", "WF_HB3", "WF_HB4",
> +			       "WF_HB0", "WF_HB0_B", "WF_HB5", "WF_HB6",
> +			       "WF_HB7", "WF_HB8", "WF_HB9", "WF_HB10",
> +			       "WF_TOP_CLK", "WF_TOP_DATA", "WF_XO_REQ",
> +			       "WF_CBA_RESETB", "WF_DIG_RESETB";
> +			drive-strength = <MTK_DRIVE_4mA>;

You forgot to address my comment here. drive-strength = <4>;

Regards,
Angelo

> +		};
> +	};
>   };
>   
>   &spi2 {
> @@ -200,6 +216,14 @@ &usb_phy {
>   	status = "okay";
>   };
>   
> +&wifi {
> +	nvmem-cells = <&wifi_factory_calibration>;
> +	nvmem-cell-names = "eeprom";
> +	pinctrl-names = "dbdc";
> +	pinctrl-0 = <&wifi_dbdc_pins>;
> +	status = "okay";
> +};
> +
>   &xhci {
>   	phys = <&u2port0 PHY_TYPE_USB2>;
>   	vusb33-supply = <&reg_3p3v>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index eb2effb3c1ed2..17dd13d4c0015 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -490,7 +490,7 @@ wo_ccif0: syscon@151a5000 {
>   			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> -		wifi@18000000 {
> +		wifi: wifi@18000000 {
>   			compatible = "mediatek,mt7981-wmac";
>   			reg = <0 0x18000000 0 0x1000000>,
>   			      <0 0x10003000 0 0x1000>,
> 



