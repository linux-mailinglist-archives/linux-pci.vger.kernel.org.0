Return-Path: <linux-pci+bounces-38351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7FEBE3714
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 087F73560A2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542D32D432;
	Thu, 16 Oct 2025 12:39:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210BE31D732;
	Thu, 16 Oct 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618340; cv=none; b=OO80No56UcCRZZGuoM66DpVi53ih9y3PRA2jJddGAliVxB9laVgxhz+Um6b0T2CzWdxNR3lhtAe2xTEHQCr0Jlf3A/KrO5r+0ZpaevF8Ldrkrm6WNLmnRWDnWV3AoV5HH8J8CSPO3mZXs0EbMpDORTkx0BVRMolDpZiLAIf5TuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618340; c=relaxed/simple;
	bh=Yo5Cx9awy22Skkmy7tutsrzC+2QYngut3utLLF2nqRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWs5y26WWqiLlPgvXOUoskHn66aI/zYw0cLfyYb+NLepT5W0q9n1qm7d+Srv9Qx7WyvJo3vqZfa+v4/hNNun2LxgzqNgNEUC5nnfKIdCRpiu/x1K0izqe+RN5U1dH9ui54aCp//tUTGJd+Rm3wui3JEza+0GFi3mPxPx9E1o8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9NFk-000000001SH-1ypz;
	Thu, 16 Oct 2025 12:38:44 +0000
Date: Thu, 16 Oct 2025 13:38:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
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
	Bryan Hinton <bryan@bryanhinton.com>
Subject: Re: [PATCH 02/15] arm64: dts: mediatek: mt7981b-openwrt-one:
 Configure UART0 pinmux
Message-ID: <aPDnT4tuSzNDzyAE@makrotopia.org>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-2-de259719b6f2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-openwrt-one-network-v1-2-de259719b6f2@collabora.com>

On Thu, Oct 16, 2025 at 12:08:38PM +0200, Sjoerd Simons wrote:
> Add explicit pinctrl configuration for UART0 on the OpenWrt One board,
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> index 968b91f55bb27..f836059d7f475 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> @@ -22,6 +22,17 @@ memory@40000000 {
>  	};
>  };
>  
> +&pio {
> +	uart0_pins: uart0-pins {
> +		mux {
> +			function = "uart";
> +			groups = "uart0";
> +		};
> +	};
> +};
> +
>  &uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };

As there is only a single possible pinctrl configuration for uart0,
both the pinmux definition as well as the pinctrl properties should go
into mt7981b.dtsi rather than in the board's dts.

