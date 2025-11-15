Return-Path: <linux-pci+bounces-41312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA0C60B0E
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 21:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19A5D358DAC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390123D7C7;
	Sat, 15 Nov 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XqMwBYID"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238D232395;
	Sat, 15 Nov 2025 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240323; cv=none; b=hTHFaiuq5ZKnfAGnHuWu8imoAO5nNwcgYhozk833lmFAWQ4UFw6lMyrdU2+h0mMU0sCBsgTfu3LKdqRlvUySdIy0DpWbiF6bW3xoWanqUXL7KGQ708YbdsOxMq7y+XL1ukdjWvxv1VpF8smnWmR6wYUUBfb5SXTni4R8rkGjnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240323; c=relaxed/simple;
	bh=/iQHhrZOTfas5Ng9jqV3uTT5Sw+mmFyQVwbLKAoWb3c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GhT9DxSOowDtyUOOWQjwwzI8r0qJ5CvdVvMYPWiK3eIY5hiLQMRJA6K6CMVCnSE9uRqaYxuL73nVSnu/qF05uYZrbQLuF8rGkvqEFEwuZgTvib3zL6uywZQRrQsn64s9SwTEbgxb3vpWWiLuaB2CHa0cl23hmgw4wplc9/8E2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XqMwBYID; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763240312;
	bh=/iQHhrZOTfas5Ng9jqV3uTT5Sw+mmFyQVwbLKAoWb3c=;
	h=From:Subject:Date:To:Cc:From;
	b=XqMwBYIDLf6+s2bjI5cw4xZXAA43I54eBTEN6y49LVrVMMVxPFgsWmNkJPaZ5wbTn
	 Bch23EHYym8+6H9jm9E23kayAOh1seAVXJDDQYZT9Tkc7E0Pye8vRVRwGthmGpORN6
	 BsI8L+MkZuqABEa4F31wxfRaC1w38ly2fuHoiGp15qr6bVnRgeXochW7QDvQOhP+Tg
	 UenLuvMp7JX9hVNh02bB3p3WK40XkFNye/8B5ps139YbZVQpz36n8tuLcHJSp1MtWQ
	 N4zhmo4ihRlPV5vUoYzGw119t2meW0uPrJaevl6wKTGEro9IaTf4StU31vZUd0vogX
	 6kvIWdcANggAQ==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84AF017E127F;
	Sat, 15 Nov 2025 21:58:32 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 0C769110527D7; Sat, 15 Nov 2025 21:58:32 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Date: Sat, 15 Nov 2025 21:58:03 +0100
Message-Id: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFzpGGkC/x3MMQqAMAxA0atIZgNtqYJeRRy0Rg1CKqmoIN7d4
 viG/x9IpEwJ2uIBpZMTR8nwZQFhHWQh5CkbnHGVNbbGuJNcemAUQqHjirqhN2NohmBHVwXI5a4
 08/1fu/59P+WhNVBlAAAA
X-Change-ID: 20251016-openwrt-one-network-40bc9ac1b25c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Sjoerd Simons <sjoerd@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

Significant changes in V4:
  * Drop patches that were picked up
  * Improve mediatek,net dt bindings:
    - Move back to V2 version (widening global constraint, constraining
      per compatible)
    - Ensure all compatibles are constraint in the amount of WEDs (2 for
      everything apart from mt7981). Specifically adding constraints for
      mediatek,mt7622-eth and ralink,rt5350-eth
Significant changes in V3:
  * Drop patches that were picked up
  * Re-order patches so changes that don't require dt binding changes
    come first (Requested by Angelo)
  * Specify drive power directly rather then using MTK_DRIVE_...
  * Simply mediatek,net binding changes to avoid accidental changes to
    other compatibles then mediatek,mt7981-eth
Significant changes in V2:
  * https://lore.kernel.org/lkml/20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com/
  * Only introduce labels in mt7981b.dtsi when required
  * Switch Airoha EN8811H phy irq to level rather then edge triggered
  * Move uart0 pinctrl from board dts to soc dtsi
  * Only overwrite constraints with non-default values in MT7981 bindings
  * Make SPI NOR nvmem cell labels more meaningfull
  * Seperate fixing and disable-by-default for the mt7981 in seperate
    patches

This series add various peripherals to the Openwrt One, to make it
actually useful an access point:

* Pcie express (tested with nvme storage)
* Wired network interfaces
* Wireless network interfaces (2.4g, 5ghz wifi)
* Status leds
* SPI NOR for factory data

Unsurprisingly the series is a mix of dt binding updates, extensions of
the mt7981b and the openwrt one dtb. All driver support required is
already available.

Sadly during testing i've found various quirks requiring kernel
arguments. Documenting those here both as note to self and making it
easier for others to test :)

* fw_devlink=permissive: the nvmem fixed-layout doesn't create a layout
  device, so doesn't trigger fw_devlink
* clk_ignore_unused: Needed when building CONFIG_NET_MEDIATEK_SOC as a
  module. If the ethernet related clocks (gp1/gp2) get disabled the
  mac ends up in a weird state causing it not to function correctly.
* pcie_aspm: ASPM is forced to enabled in 6.18-rc1, unfortunately
  enabling ASPM L1.1 ends up triggering unrecoverable AERs.

Patches are against the mediatek trees for-next branch

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
Sjoerd Simons (11):
      dt-bindings: mfd: syscon: Add mt7981-topmisc
      dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
      dt-bindings: phy: mediatek,tphy: Add support for MT7981
      arm64: dts: mediatek: mt7981b: Add PCIe and USB support
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
      dt-bindings: net: mediatek,net: Correct bindings for MT7981
      arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
      arm64: dts: mediatek: mt7981b: Disable wifi by default
      arm64: dts: mediatek: mt7981b: Add wifi memory region
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi

 Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
 .../devicetree/bindings/net/mediatek,net.yaml      |  26 ++-
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   1 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   1 +
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 125 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          | 222 ++++++++++++++++++++-
 6 files changed, 371 insertions(+), 5 deletions(-)
---
base-commit: 67ed5843a67b7ba63d79f2ba3fd21bee151d3138
change-id: 20251016-openwrt-one-network-40bc9ac1b25c

Best regards,
-- 
Sjoerd Simons <sjoerd@collabora.com>


