Return-Path: <linux-pci+bounces-38344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D013BE316D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BB63E9EC2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B15F32D427;
	Thu, 16 Oct 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JCQ167QB"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1032D449;
	Thu, 16 Oct 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614164; cv=none; b=srdXG9afrfQBK00itY2lNPM4w1PHA5dKVMKD6J6xL4pynW9tmQ2KuEwwDp7ZcTuqOHVJJuUz13qcBwVpdf9ZD1GlFSHQeHQCsyRRkgFd3s5IZeXQMaIeOCqU4lJ4p1Ig9jR9/FIP8th6KCEOqNCdWLmy0r93GnVzyqQouUc5JlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614164; c=relaxed/simple;
	bh=L5eCza82ytFr8BVqmkmTv1s+8qWAjleYWe5VZvel0wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EF3lW1bjFZza6VkGT5RfSf8S0+QdD4ktV9cxhoMk/gSzhIyvq68yCt77841sf2DjdnXgrwCkCfYd1kHGZaTMuzwFx6r8bL+nuFkfxIfpssXbHVxzxFijMBk606+HEbvgQqfePw35N1X9h8PY6ZK4RiRht48fSYtwkmpcNDSjULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JCQ167QB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614160;
	bh=L5eCza82ytFr8BVqmkmTv1s+8qWAjleYWe5VZvel0wc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JCQ167QBhQIRODWZKKIxlfh6W4KgHrm0lN24lSsjGWAM/Ixkmq6dMcdn3BS2AHXN5
	 qNs9a19o2/vMIqaAT3HHlZOYyXbu9Jv0ztTr5iinHBp9Oq1q4MM2+1JMHfwd/wlTCR
	 3jevnQr9/eHORuUzSQBIM1W0j3LV74fIJKeFKRy1lgH2d21fhAKjyvc14LKa6VUxTb
	 l/IPM4qvirw6rsoNJKEYAxj+iJYJGoW3r5bFfxChz14P8daP6kpKOyE3ap53x2JHRB
	 9jVawUNle5c8C+/aX0z1qxFN2EKlphBLcbGNnentpmgcqDrkdZtfNzeaGCytm3rIam
	 jE6de30OQpJWw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C721B17E15DB;
	Thu, 16 Oct 2025 13:29:19 +0200 (CEST)
Message-ID: <a5f19be8-d063-49bf-951d-cc7f14b64987@collabora.com>
Date: Thu, 16 Oct 2025 13:29:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] arm64: dts: mediatek: mt7981b: Add PCIe and USB
 support
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
 <20251016-openwrt-one-network-v1-7-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-7-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> Add device tree nodes for PCIe controller and USB3 XHCI host
> controller on MT7981B SoC. Both controllers share the USB3 PHY
> which can be configured for either USB3 or PCIe operation.
> 
> The USB3 XHCI controller supports USB 2.0 and USB 3.0 SuperSpeed
> operation. The PCIe controller is compatible with PCIe Gen2
> specifications.
> 
> Also add the topmisc syscon node required for USB/PCIe PHY
> multiplexing.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 82 +++++++++++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index b477375078ccd..13950fe6e8766 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -2,6 +2,7 @@
>   
>   #include <dt-bindings/clock/mediatek,mt7981-clk.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/reset/mt7986-resets.h>
>   
>   / {
> @@ -221,6 +222,57 @@ auxadc: adc@1100d000 {
>   			status = "disabled";
>   		};
>   
> +		xhci: usb@11200000 {
> +			compatible = "mediatek,mt7986-xhci", "mediatek,mtk-xhci";
> +			reg = <0 0x11200000 0 0x2e00>,
> +			      <0 0x11203e00 0 0x0100>;

reg fits in one line.

> +			reg-names = "mac", "ippc";
> +			clocks = <&infracfg CLK_INFRA_IUSB_SYS_CK>,
> +				 <&infracfg CLK_INFRA_IUSB_CK>,
> +				 <&infracfg CLK_INFRA_IUSB_133_CK>,
> +				 <&infracfg CLK_INFRA_IUSB_66M_CK>,
> +				 <&topckgen CLK_TOP_U2U3_XHCI_SEL>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
> +			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u3port0 PHY_TYPE_USB3>;

phys fits in one line.

Other than that, looks good; after applying the proposed changes:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



