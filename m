Return-Path: <linux-pci+bounces-38355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F75BE3E90
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B333B3415
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019133EB07;
	Thu, 16 Oct 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SXqJvaEe"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872832D7F4;
	Thu, 16 Oct 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624960; cv=none; b=XirD+fjXI8XeXRgyk7XLoL04pFJ93Cl4r8N2x2rGjJuxGby2qFnwFYUcIRJ0Y3ctAze1gDsRjmxBc5PpU3l8giCGB+HgzP7LlFJWfEF/jX98kSDBV1ke86B7cT/OiPB+PY4h37tutj/kTAit9TtzkTUuG5mAVVErvAv9qpLr5eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624960; c=relaxed/simple;
	bh=/ogrshpBMHpUYx7hds/fD1WgLsoTS+62iSlrqAObxms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKFcc4QZ5LXiy4ZYQkFPct0/JCdj6IMCzoIAC0Z6AZbEqyEkDzkPNwQ+a0VHTbp1MSa0vO+1+9qxQUPlayi2ftVXvjNMr+hYcJj0tsqb7dvnRe21G10lDzQtVfPG5QTVGGxavf1haCqygK8t/nsUJRWfZUv0xWRVr/xS7f8Oxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SXqJvaEe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760624956;
	bh=/ogrshpBMHpUYx7hds/fD1WgLsoTS+62iSlrqAObxms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SXqJvaEeN6DpDXxKAJ2nZHAdiOodqfTfzvKAlonZfsIL8ee+R2Jj9dwe4gQG1/8UT
	 ikbDgKu56YCB82nhg8NnwreSXKB/uSxqzstktVanLw+HYEWmpyhhF4IN5iJR8XYk7q
	 yw+2zrYQbGhkyneR7LvmjtU/tXFnjTlororY9q8M0Bnt7ufMdcclUwHujGfpx52hEX
	 Jt/CYp4aWZeHLgd04du5mXg9WrqSRzEky39IAlZ8Zffdf33kq3S347zBoJBlQKrzo4
	 6MeTDZnuykjPgjSBXEN37VJblWROrGp7oN5suST7x0Ikj708rJ923s8OEOFXcyAWpE
	 4XY5LVyF0CVtg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D939117E0125;
	Thu, 16 Oct 2025 16:29:14 +0200 (CEST)
Message-ID: <5f430ff9-d701-426a-bf93-5290e6912eb4@collabora.com>
Date: Thu, 16 Oct 2025 16:29:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] arm64: dts: mediatek: mt7981b-openwrt-one:
 Configure UART0 pinmux
To: Daniel Golle <daniel@makrotopia.org>, Sjoerd Simons <sjoerd@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 Bryan Hinton <bryan@bryanhinton.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-2-de259719b6f2@collabora.com>
 <aPDnT4tuSzNDzyAE@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aPDnT4tuSzNDzyAE@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 14:38, Daniel Golle ha scritto:
> On Thu, Oct 16, 2025 at 12:08:38PM +0200, Sjoerd Simons wrote:
>> Add explicit pinctrl configuration for UART0 on the OpenWrt One board,
>>
>> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>> index 968b91f55bb27..f836059d7f475 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
>> @@ -22,6 +22,17 @@ memory@40000000 {
>>   	};
>>   };
>>   
>> +&pio {
>> +	uart0_pins: uart0-pins {
>> +		mux {
>> +			function = "uart";
>> +			groups = "uart0";
>> +		};
>> +	};
>> +};
>> +
>>   &uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pins>;
>>   	status = "okay";
>>   };
> 
> As there is only a single possible pinctrl configuration for uart0,
> both the pinmux definition as well as the pinctrl properties should go
> into mt7981b.dtsi rather than in the board's dts.

If there's really one single possible pin configuration for the UART0 pins,
as in, those pins *do not* have a GPIO mode, then yes I agree.

If those pins can be as well configured as GPIOs, this goes to board DTS.

Cheers,
Angelo

