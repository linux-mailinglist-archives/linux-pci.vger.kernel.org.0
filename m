Return-Path: <linux-pci+bounces-38722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C3BF0888
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C27E4ED2C1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0082F6196;
	Mon, 20 Oct 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PrKdhpij"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464F1E9919;
	Mon, 20 Oct 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956079; cv=none; b=J3Tis1OpA9QVXywTUO7ZA7G8QPfBczNsOWVEDJM5sss8WbDkYE5sn3/DfnTQvl4p0xZRVFseFAEPGslDesAb3TYRUJOiWw99l4EivKpQb3pUvr1dfjRdo5bOtu0V6IujEY+wJ706itY376/V34FZWBqGJs4y2CCOrMlyJ9ahu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956079; c=relaxed/simple;
	bh=6m+WN98kS1d8nTe10kT4JXvC5lB5QZtorQfDjhyQM68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGBmvcr7Vbu883wxTGmvCs0aa/4g2lMTXfx13CemPsG0QKEhzaUD2yleSnDrDb6NFtLqQwXe2hpAqLAbgx4TXLcDxCgH8r7xMUBhRA17oLTiB9CXdcungwNBRu25K1Exf20+JGDggYWzsp4mabTq73m7rfGF1AINSauh3euz9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PrKdhpij; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760956075;
	bh=6m+WN98kS1d8nTe10kT4JXvC5lB5QZtorQfDjhyQM68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PrKdhpijyUELPE1uxkgl4X54lfTD0ulhBT7Owo+KYxjXRbfSpS7pyk1Y2SUEpXzW+
	 VXxUFTV1hxOmX0FM0dR0X9nmJ2pNAOe6rltWJ5KlQ/D826or/EnaeKWgyK9P0J9lj2
	 9LoFno0gwutdCnh/WSgidDqko7RBO+lrIzUu3VYf5aMKSKGMh/ncYr9x5Pspoh05vq
	 fMwd21ZhUDZHroxqAJGyDtpXwXNTLkOGCJLeIdBNcloAcQsMxgi54pR5UAaqpuT1HY
	 Pe4fZOJMeEoKwymO9XPJgFFTsKGsZO4f4e58ITi5AQ81jw1Fut2Ho4d05Y7NRsIQD/
	 ZHDCWVYIlj+3g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 88C5C17E0DB7;
	Mon, 20 Oct 2025 12:27:54 +0200 (CEST)
Message-ID: <8a637fc2-7768-4816-bb4f-3af2e32908e4@collabora.com>
Date: Mon, 20 Oct 2025 12:27:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] arm64: dts: mediatek: mt7981b: Add Ethernet and
 WiFi offload support
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
 <20251016-openwrt-one-network-v1-10-de259719b6f2@collabora.com>
 <aPEhiVdgkVLvF9Et@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aPEhiVdgkVLvF9Et@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 18:47, Daniel Golle ha scritto:
> On Thu, Oct 16, 2025 at 12:08:46PM +0200, Sjoerd Simons wrote:
>> Add device tree nodes for the Ethernet subsystem on MT7981B SoC,
>> including:
>> - Ethernet MAC controller with dual GMAC support
>> - Wireless Ethernet Dispatch (WED)
>> - SGMII PHY controllers for high-speed Ethernet interfaces
>> - Reserved memory regions for WiFi offload processor
>>
>> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 133 ++++++++++++++++++++++++++++++
>>   1 file changed, 133 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>> index 13950fe6e8766..c85fa0ddf2da8 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi

..snip..

>> +
>> +			mdio_bus: mdio-bus {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				int_gbe_phy: ethernet-phy@0 {
>> +					compatible = "ethernet-phy-ieee802.3-c22";
>> +					reg = <0>;
>> +					phy-mode = "gmii";
>> +					phy-is-integrated;
>> +					nvmem-cells = <&phy_calibration>;
>> +					nvmem-cell-names = "phy-cal-data";
> 
> Please also define the two LEDs here with their corresponding (only)
> pinctrl options for each of them, with 'status = "disabled";'. This
> makes it easier for boards to make use of the Ethernet PHY leds by just
> referencing the LED and setting the status to 'okay'.
> 

Sorry Daniel, definitely no. The LEDs really are board specific.

Try to convince me otherwise, but for this one I really doubt that you can.

Cheers,
Angelo



