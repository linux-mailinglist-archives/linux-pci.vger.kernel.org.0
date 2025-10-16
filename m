Return-Path: <linux-pci+bounces-38342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E72BE315E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD153E8F61
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD431A815;
	Thu, 16 Oct 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jbXjIVSa"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625E32779E;
	Thu, 16 Oct 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614153; cv=none; b=J42crnTpkaKMla4tafagZTU0IRtdHzQC3DYpQ8y41qF4ABglRwFE4UCa1r/OQaQqV1TiuCSfMjxVbp6EDrR6KYLZbQkl4klEv52VZiUHiaQ5lnvzxM/b7jlrJWfIJK01T26frzNDG0Ih0V2xiR3Ahpq/9YL85bQNavuAogpYl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614153; c=relaxed/simple;
	bh=21rEb7vPr4YCzX6wcTFKFNlZHDkfepoHPuQQ1qzKxZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+0yCTOHhvtuDWEtuKiPSZqlIXNM7KkiQtLMcVezeEa9o06JnFw5VYLxcbZ7Q2kK9HLw0TtGQvaKu+aSzv1VqugDpC2SbRh3NuPIHoPge8CebhuXyJj5+WyNUm3WqVXp1iqeYUxTPB+jSOA4r2McszKez4nwHoxOHZVAIDYu31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jbXjIVSa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614150;
	bh=21rEb7vPr4YCzX6wcTFKFNlZHDkfepoHPuQQ1qzKxZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jbXjIVSadb1Wpv0sC8V5S2EedYtJm644egFOcJPEvxdm558odkg0y7G4peO1qQQjH
	 viHfQyEOzhkRHDlZ5a2ViSf4caPErqt47r9uH18vPosx/n57CzLDwho4sBSONUziOW
	 W04LRrgiPoy9O19wZgzFRK61G3jIUOm9YCRmhYbXwvUhDnjBxU9RPbwf55yTmvyiMQ
	 F0JzOkiZAXQJM17d6b4nloUCb6oq6fXXN2q3tsrVvtyZ1RjyMDQ71KAYE/gyhn0D4C
	 1ORjZwKZrZaUsovIv+JRBiV7k1KfiZKbWX+5TDSckcStEaDXCUP2FhccfqtkU7cjPQ
	 JjzDkUWuO3bzQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B24E17E1583;
	Thu, 16 Oct 2025 13:29:09 +0200 (CEST)
Message-ID: <43b9b071-5da1-42bf-b74a-ccd6877a2040@collabora.com>
Date: Thu, 16 Oct 2025 13:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] arm64: dts: mediatek: mt7981b: Add reserved memory
 for TF-A
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
 <20251016-openwrt-one-network-v1-3-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-3-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> Add memory range handled by ARM Trusted Firmware
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index 6b024156fa7c5..b477375078ccd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -41,6 +41,18 @@ psci {
>   		method = "smc";
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved: secmon@43000000 {
> +			reg = <0 0x43000000 0 0x30000>;
> +			no-map;
> +		};
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		ranges;
> 



