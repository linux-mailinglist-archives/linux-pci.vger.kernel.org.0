Return-Path: <linux-pci+bounces-43581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E43ECD94C8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15E333002156
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C633373D;
	Tue, 23 Dec 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="csgi6Iyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31F13DDAE;
	Tue, 23 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493492; cv=none; b=pePf5YsTtkIbHelid+eKfe+oMpSmjsvZeQNZm1h/VvPA8NJsQ3pqeMWuL0x1L7UZHe9N531vnA0sNHLUnoBlOR7TF1TTIuCSg9K6jhuFdgVg/LYbFobZaq1DamDBEu4f5naMfH+UMMFvfO1TpdGYqg4SXIiuC3fIgnU6ecWPf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493492; c=relaxed/simple;
	bh=MH9fsXSV4/vV6yKbXRdvMNE0YpZl2llUQZEnqF7AiOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dht7wrF4ggaHsNvpo77xgP+mpA3/o1xl8LxDHpNFzLeY/qWqDAbaFhT3DVazL8ZZRg42cEA4MAM1NUOnT3eBfplbe9tVqiyrUZUsj5u6Z9piqOzzyEeU+2hT9At7LLckArCu5GZpC8Y43Py9zPKePYXCOd3YA/3ZLBsVA/lCrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=csgi6Iyz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766493488;
	bh=MH9fsXSV4/vV6yKbXRdvMNE0YpZl2llUQZEnqF7AiOk=;
	h=From:Subject:Date:To:Cc:From;
	b=csgi6IyzSpYebZafa8FL7wsKRbM22ngs+jJ7BpB+XrUjwmC4SFUnLzerEgK+BwpBb
	 1foEC3ridBpWgKVySzNKpRHRh9EbMkOEO5rxhendeaYaVr88Gqc45ULnrvVzt84xkj
	 UOBbeEWDCiPwpOuTKc6VBA2Npm2tEHYDq/0iWb2GzeRrhFlqi2xRvT/UKlUp3zBgEa
	 tkzDHcvGVirvHkvaPaCrNeG7dxFSH/fP5Jiv/m7H3sKrg0FRXYSyzxp4siwvOCOV7A
	 Hwv4/FgWjWWOnbNenW2/rhJ65pLGzM/1uIEOHAxHjx1iNCNiR/xbVXHe2ihq3nCrQQ
	 7AxoU5fIb3/WA==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531:0:f337:3245:2545:b505])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 987B417E0C2E;
	Tue, 23 Dec 2025 13:38:08 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 4202E117A066D; Tue, 23 Dec 2025 13:38:08 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v5 0/8] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Date: Tue, 23 Dec 2025 13:37:50 +0100
Message-Id: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+NSmkC/x3MMQqAMAxA0atIZgNtsYJeRRy0Rg1CKqmoIN7d4
 viG/x9IpEwJ2uIBpZMTR8nwZQFhHWQh5CkbnHHeGltj3EkuPTAKodBxRd2wMmNohmBH5wPkcle
 a+f6vXf++H//+2pFlAAAA
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

Significant changes in V5:
  * Rebase against linux v6.19-rc2, dropping merged patches
  * Drop note about disable pci_aspm in cover letter, not required anymore
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

Patches are against linux v6.19-rc2

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
Sjoerd Simons (8):
      dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
      arm64: dts: mediatek: mt7981b: Add PCIe and USB support
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
      arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
      arm64: dts: mediatek: mt7981b: Disable wifi by default
      arm64: dts: mediatek: mt7981b: Add wifi memory region
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi

 .../bindings/pci/mediatek-pcie-gen3.yaml           |   1 +
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 125 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          | 222 ++++++++++++++++++++-
 3 files changed, 346 insertions(+), 2 deletions(-)
---
base-commit: b927546677c876e26eba308550207c2ddf812a43
change-id: 20251016-openwrt-one-network-40bc9ac1b25c

Best regards,
-- 
Sjoerd Simons <sjoerd@collabora.com>


