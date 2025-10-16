Return-Path: <linux-pci+bounces-38345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33709BE3140
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F338C500932
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C332D7CA;
	Thu, 16 Oct 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lmqywjlz"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15731CA47;
	Thu, 16 Oct 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614170; cv=none; b=EVGMwLESNcRn36TajOUqU5NKzoOSWyE8/oL98VKUow5KTRPUhA3GeMIVeNusiOSh8TdvJu4YjKOytGs1u7twQ/pA9F2u8if8x8HYh85tAqfv1xv/qJ7rWJikvBxoEiTBXcupl0UBBls5Mj3K8CpWdUH/khGczfeB8vsFlvbtjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614170; c=relaxed/simple;
	bh=biv+LobEVL9LfrkYmBdHU8vUgDvx8juh7svBDdA2t6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfJAZmyvdoSmZyYrPBlkmyBFU3QsHqb48Dzi/MX/y0O5gygEu/UcZIwsCC4o2Hzfgf0rkxLi6RqgmVGQRGzKQGYwraiJp9Biy3te/1SopJNizW97TCXwvfvrpHNE5pPm6JnSyskrJKZY3TAb9dcoN/mIOCB1h2QYS/idmkaUz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lmqywjlz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614167;
	bh=biv+LobEVL9LfrkYmBdHU8vUgDvx8juh7svBDdA2t6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lmqywjlz4WIw9EHR5tUKfT76Lp01CmOeLZ3UA/NWmd16eeBeSpfhBwDt3vPyzarWD
	 SiWwOQNOwephpJ8hSwXYwuQCfwRpweWnLxptIMYV+K6muF89F/zls6Q5ldPKYe9qWD
	 es02c2HVNTmRgLufSTzGgZsaSf3MGdJGrftZw4RwQB3dccMuk+zfc952IQKlemNKzU
	 nNAvSBU/4rMu+qpcgMMGNhrdHTdrHD8l4+l4LynJWCMZVJ+yPChEfPfnOUrhMyIqlG
	 WTUfiun9piEtvAN3lltPaaLlvV9DkNQtB/fzOOfnp9RDxWK/G1tnGVQgiuoBpSNXDm
	 2ayH4wIEol42w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D8AF717E35E8;
	Thu, 16 Oct 2025 13:29:25 +0200 (CEST)
Message-ID: <f6f96421-523b-4236-a5f8-c28ffd1c2d4c@collabora.com>
Date: Thu, 16 Oct 2025 13:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] arm64: dts: mediatek: mt7981b: Add labels to
 commonly referenced nodes
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
 <20251016-openwrt-one-network-v1-1-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-1-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> Add labels to various device nodes in the MT7981B DTSI, similar to other
> mediatek dtsi files.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

If you're not using the labels, it makes no sense to have them.

Please add them in the same commit(s) in which you actually assign phandles to the
nodes that need labels.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index 58c99f2a25218..6b024156fa7c5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -14,14 +14,14 @@ cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> -		cpu@0 {
> +		cpu0: cpu@0 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0>;
>   			device_type = "cpu";
>   			enable-method = "psci";
>   		};
>   
> -		cpu@1 {
> +		cpu1: cpu@1 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x1>;
>   			device_type = "cpu";
> @@ -29,7 +29,7 @@ cpu@1 {
>   		};
>   	};
>   
> -	oscillator-40m {
> +	clk40m: oscillator-40m {
>   		compatible = "fixed-clock";
>   		clock-frequency = <40000000>;
>   		clock-output-names = "clkxtal";
> @@ -82,7 +82,7 @@ apmixedsys: clock-controller@1001e000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		pwm@10048000 {
> +		pwm: pwm@10048000 {
>   			compatible = "mediatek,mt7981-pwm";
>   			reg = <0 0x10048000 0 0x1000>;
>   			clocks = <&infracfg CLK_INFRA_PWM_STA>,
> @@ -127,7 +127,7 @@ uart2: serial@11004000 {
>   			status = "disabled";
>   		};
>   
> -		i2c@11007000 {
> +		i2c0: i2c@11007000 {
>   			compatible = "mediatek,mt7981-i2c";
>   			reg = <0 0x11007000 0 0x1000>,
>   			      <0 0x10217080 0 0x80>;
> @@ -142,7 +142,7 @@ i2c@11007000 {
>   			status = "disabled";
>   		};
>   
> -		spi@11009000 {
> +		spi2: spi@11009000 {
>   			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
>   			reg = <0 0x11009000 0 0x1000>;
>   			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> @@ -156,7 +156,7 @@ spi@11009000 {
>   			status = "disabled";
>   		};
>   
> -		spi@1100a000 {
> +		spi0: spi@1100a000 {
>   			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
>   			reg = <0 0x1100a000 0 0x1000>;
>   			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> @@ -170,7 +170,7 @@ spi@1100a000 {
>   			status = "disabled";
>   		};
>   
> -		spi@1100b000 {
> +		spi1: spi@1100b000 {
>   			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
>   			reg = <0 0x1100b000 0 0x1000>;
>   			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> @@ -184,7 +184,7 @@ spi@1100b000 {
>   			status = "disabled";
>   		};
>   
> -		thermal@1100c800 {
> +		thermal: thermal@1100c800 {
>   			compatible = "mediatek,mt7981-thermal",
>   				     "mediatek,mt7986-thermal";
>   			reg = <0 0x1100c800 0 0x800>;
> @@ -231,7 +231,7 @@ pio: pinctrl@11d00000 {
>   			#interrupt-cells = <2>;
>   		};
>   
> -		efuse@11f20000 {
> +		efuse: efuse@11f20000 {
>   			compatible = "mediatek,mt7981-efuse", "mediatek,efuse";
>   			reg = <0 0x11f20000 0 0x1000>;
>   			#address-cells = <1>;
> @@ -246,14 +246,14 @@ thermal_calibration: thermal-calib@274 {
>   			};
>   		};
>   
> -		clock-controller@15000000 {
> +		ethsys: clock-controller@15000000 {
>   			compatible = "mediatek,mt7981-ethsys", "syscon";
>   			reg = <0 0x15000000 0 0x1000>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
>   		};
>   
> -		wifi@18000000 {
> +		wifi: wifi@18000000 {
>   			compatible = "mediatek,mt7981-wmac";
>   			reg = <0 0x18000000 0 0x1000000>,
>   			      <0 0x10003000 0 0x1000>,
> 


