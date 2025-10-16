Return-Path: <linux-pci+bounces-38314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28878BE2C51
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0396586500
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5572DF6FF;
	Thu, 16 Oct 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h6+kTrqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDF32861E;
	Thu, 16 Oct 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609338; cv=none; b=n1buq1ZbVteXJjzsIERPY2i5Vv00KOgjUo+S7lW15uULU/CU5sWGcWZu7umWMPs+2yDFWFgmgFjdZHfzjxJit5/nfYPGs5KhERhsYS2msNMf2t4WqmAb5SWWU9k0M1inDp17fTdzbsFxFd0jlFJmQ+7T/1Irvxznd1saoWn3uS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609338; c=relaxed/simple;
	bh=Dcshxnk+HHcxt2JmE3zv3oNCpRgnSrlJo9TAu9xvBkk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mMzZpDGJxOdf5TZaFqhgN1tKKyYvoMk5f9AczJmErROToXHTVwqnKvnzgVMaToxBKeld9zrDfQaYGgGGFPq+2Dh3ASBIrP88QfnzzMkE/6UysQJbf74nMqLCYR9xEauOac+qa3SxMKawv7vVumYTODrcJkemZt2ZVfeLZQGewcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h6+kTrqJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609334;
	bh=Dcshxnk+HHcxt2JmE3zv3oNCpRgnSrlJo9TAu9xvBkk=;
	h=From:Subject:Date:To:Cc:From;
	b=h6+kTrqJJ10AjrmI1ibLweGmZL6wrs4HbdElHedN+s5t4nz42RHrJWLTc2GcPrtA4
	 OsVvaKEcvqtPAB7HfF7XMtGsfZeuS1TR7Qe8jW3k33ToKQkPsp7PkCu2kAGLBOqL7C
	 FIUQJPIv+f8rlXhod9BenfBX6QQkG2mEZBxGNCaGg6UKRSGkoqRk6YuHsXafKbrPnj
	 nTzmYveT72H81UPHOYeIuviupl3EExjY5ZGFzL12AIFpUpAKyi42TUkyXX+um7pzC4
	 bLp9EDZzdLYW/+R61jOmZPzAjSo89Si/7ujs3DHx2URr6/jpvpgJJkEtnAdsIIKcA6
	 5Y6KGcq77Ys7Q==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE3A417E1271;
	Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 8322F10C9C780; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 00/15] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Date: Thu, 16 Oct 2025 12:08:36 +0200
Message-Id: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXE8GgC/x3MMQqAMAxA0atIZgNtUUGvIg5aowYhlVSsIN7d4
 viG/x+IpEwRuuIBpYsjB8mwZQF+G2Ul5DkbnHG1NbbBcJAkPTEIodCZgu5Ymcm3o7eTqz3k8lB
 a+P6v/fC+HxWOhSBlAAAA
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
 Sjoerd Simons <sjoerd@collabora.com>
X-Mailer: b4 0.14.3

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
Sjoerd Simons (15):
      arm64: dts: mediatek: mt7981b: Add labels to commonly referenced nodes
      arm64: dts: mediatek: mt7981b-openwrt-one: Configure UART0 pinmux
      arm64: dts: mediatek: mt7981b: Add reserved memory for TF-A
      dt-bindings: mfd: syscon: Add mt7981-topmisc
      dt-bindings: pci: mediatek-pcie-gen3: Add MT7981 PCIe compatible
      dt-bindings: phy: mediatek,tphy: Add support for MT7981
      arm64: dts: mediatek: mt7981b: Add PCIe and USB support
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
      dt-bindings: net: mediatek,net: Correct bindings for MT7981
      arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable SPI NOR
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
      arm64: dts: mediatek: mt7981b: Add wifi memory region
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable leds

 Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
 .../devicetree/bindings/net/mediatek,net.yaml      |  16 +-
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   1 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   1 +
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 276 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          | 258 ++++++++++++++++++-
 6 files changed, 538 insertions(+), 15 deletions(-)
---
base-commit: de8df7a4c881bd0df691458680ab1e22d63d60f4
change-id: 20251016-openwrt-one-network-40bc9ac1b25c

Best regards,
-- 
Sjoerd Simons <sjoerd@collabora.com>


