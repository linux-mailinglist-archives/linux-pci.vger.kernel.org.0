Return-Path: <linux-pci+bounces-40089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52834C2AA7A
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 09:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B2A1889459
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C702E266C;
	Mon,  3 Nov 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oTTeiws+"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F02E54BF;
	Mon,  3 Nov 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160186; cv=none; b=b8wLE/OgsUAF5xlL4rEIoGK06W/2qf76tzB3sidASlRAlQ2Z2+q1lc4k2vyXudopa9SNbXTrF0iahObWgBs5v0muEgdFBLgXzjA5KJRXOrnGZkfWgslfJj9RCkeaWRyZNwEHCHP3mbIqJlT1Jp8ryoPRmdT0G/jtq/SHjuQ6s/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160186; c=relaxed/simple;
	bh=lCXRosTn4Mj/QrN4xjJ+JLcI6xF053GP6NbQY85J2pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcmCVRfIvEsM13pghxoX7fvWoTD/8xfRRVp1bmY7Zg3KcRy2gdo5bVoJAPmD2hPDsTNZUrdfBOTWHfkv8gpb61A4v9h18w5DcetB8J84XqsDO1kFMwvy3rl0bwqzKHidEV/7hBxko1Re1a1mfJkHrTBvw20Rzlt6XLhri90XPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oTTeiws+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762160182;
	bh=lCXRosTn4Mj/QrN4xjJ+JLcI6xF053GP6NbQY85J2pM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oTTeiws+XDqPYCSAEBmgaVpzZ/YfXq9FkPZ0Ey/u6YtOJFo2pQ8gPQkabyV+BBR12
	 fz6LC96S19XknHxdj2DUI0F8l1O1a0C+GYaQNbF3yBHbiuQGgFIjZzjOEQ0ptxuOBx
	 B5GezsczBTGxMtcz57f7Wg3IQ/dcNXDvkDztQ+Npaqq2vNkVI/Dk3efXhRjprTm6hJ
	 zyFSnD5NUR9X3y7HZ6beHMKygzQMpPftJV1ubpxa/1x1i7ePTI13uaLOVvSx9Rfu9F
	 a543B8xvlujZowXMyWLBxiRQ34JLWQsacceKV0/NMhP71UlICEL3/tdHrujknqESGg
	 YMOzXRu/boqpw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B4BE17E1091;
	Mon,  3 Nov 2025 09:56:21 +0100 (CET)
Message-ID: <781e754e-6603-4ae3-9340-24403a6d8137@collabora.com>
Date: Mon, 3 Nov 2025 09:56:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] arm64: dts: mediatek: Add Openwrt One AP
 functionality
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
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/11/25 14:32, Sjoerd Simons ha scritto:
> Significant changes in V2:
>    * https://lore.kernel.org/lkml/20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com/
>    * Only introduce labels in mt7981b.dtsi when required
>    * Switch Airoha EN8811H phy irq to level rather then edge triggered
>    * Move uart0 pinctrl from board dts to soc dtsi
>    * Only overwrite constraints with non-default values in MT7981 bindings
>    * Make SPI NOR nvmem cell labels more meaningfull
>    * Seperate fixing and disable-by-default for the mt7981 in seperate
>      patches
> 
> This series add various peripherals to the Openwrt One, to make it
> actually useful an access point:
> 
> * Pcie express (tested with nvme storage)
> * Wired network interfaces
> * Wireless network interfaces (2.4g, 5ghz wifi)
> * Status leds
> * SPI NOR for factory data
> 
> Unsurprisingly the series is a mix of dt binding updates, extensions of
> the mt7981b and the openwrt one dtb. All driver support required is
> already available.
> 
> Sadly during testing i've found various quirks requiring kernel
> arguments. Documenting those here both as note to self and making it
> easier for others to test :)
> 
> * fw_devlink=permissive: the nvmem fixed-layout doesn't create a layout
>    device, so doesn't trigger fw_devlink

This should really be fixed in fw_devlink I believe. It's not the first device
that uses nvmem fixed-layout and will not be the last one.

> * clk_ignore_unused: Needed when building CONFIG_NET_MEDIATEK_SOC as a
>    module. If the ethernet related clocks (gp1/gp2) get disabled the
>    mac ends up in a weird state causing it not to function correctly.

I'm sure that this can be resolved by adding resets.

> * pcie_aspm: ASPM is forced to enabled in 6.18-rc1, unfortunately
>    enabling ASPM L1.1 ends up triggering unrecoverable AERs.

That must be resolved in the PCIe driver - either it must disable L1.1 support
or needs some fixes around.

Still, I think if you add resets to the PCIe node you should at least get the
MAC recovered at PM resume time (but being this a router, I really don't think
that this would matter - still, for the sake of completion...)

Overall, this series is good and I'm fine with picking all of the changes: even
if there are some needed quirks, those aren't freezing the boot process and the
worst thing that could ever happen is that in some conditions some devices will
simply not probe.
I guess that the resets, etc, can be added later as a fix - but at least we can
get those devices at least partially up and running .

Can anyone pick the bindings please, so that I can pick everything else?

Cheers,
Angelo

> 
> Patches are against the mediatek trees for-next branch
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
> Sjoerd Simons (15):
>        arm64: dts: mediatek: mt7981b: Configure UART0 pinmux
>        arm64: dts: mediatek: mt7981b: Add reserved memory for TF-A
>        dt-bindings: mfd: syscon: Add mt7981-topmisc
>        dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
>        dt-bindings: phy: mediatek,tphy: Add support for MT7981
>        arm64: dts: mediatek: mt7981b: Add PCIe and USB support
>        arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
>        dt-bindings: net: mediatek,net: Correct bindings for MT7981
>        arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
>        arm64: dts: mediatek: mt7981b-openwrt-one: Enable SPI NOR
>        arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
>        arm64: dts: mediatek: mt7981b: Disable wifi by default
>        arm64: dts: mediatek: mt7981b: Add wifi memory region
>        arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
>        arm64: dts: mediatek: mt7981b-openwrt-one: Enable software leds
> 
>   Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
>   .../devicetree/bindings/net/mediatek,net.yaml      |  13 +-
>   .../bindings/pci/mediatek-pcie-gen3.yaml           |   1 +
>   .../devicetree/bindings/phy/mediatek,tphy.yaml     |   1 +
>   .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 263 +++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi          | 247 ++++++++++++++++++-
>   6 files changed, 519 insertions(+), 7 deletions(-)
> ---
> base-commit: 860a0efbb95de468b17c86ed5cf8d90ee4bc5d7b
> change-id: 20251016-openwrt-one-network-40bc9ac1b25c
> 
> Best regards,


