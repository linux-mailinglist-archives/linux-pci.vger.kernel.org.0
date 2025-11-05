Return-Path: <linux-pci+bounces-40417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E86C380BB
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5203BBCE5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755D2D0C8A;
	Wed,  5 Nov 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FYYWj5Er"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65A23F424;
	Wed,  5 Nov 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377518; cv=none; b=TrKMSWY3ddRrbjfsp3aItcVNASoCsA+c+GjtueEstBvS0t2qXd6FDXEf+ef5ekSDVc9HKvlIB1jd1anabnNBxj/HNmQh5wrH+TXwRYp1P8os/JmAlEowhoa3RZUHn1b21+iDo4nxpH9J+KyoZZaxjLYHYX9eDxTE8DbVhk4vWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377518; c=relaxed/simple;
	bh=/ng5O2dKBBjx/PoMHfml7fIWlsGEdTjPoLQQq68Vk1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JlZ3h1E+yV55PKTj+S7/umBnGMuqND9FCaUUGyEEJvLiNEykMwjqkShBHZoQQRDwqlpkCvpSx5574iw52kb2DqF0tNfWvdbbBHTEDHau+eUC9KeDsMDKA4pvGO+yvkE2HuhnHr0cd5AQFmaw801TtUV683VEC5RZONOwjiEJh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FYYWj5Er; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377515;
	bh=/ng5O2dKBBjx/PoMHfml7fIWlsGEdTjPoLQQq68Vk1w=;
	h=From:Subject:Date:To:Cc:From;
	b=FYYWj5ErKAQWBH2zuGZaHzNU61uViaX++wuDgl6qi3m3uq/JVL8lRCK2QpXOCeVXQ
	 cK6bH0vpEageL4dR1k+JzkdBvT3UDR3JFEKn+jOJ+c+YwUlXUL8nDJEUHqzZ0r+mRA
	 oB3wh+vHFKV76nODd5F3Ycl+IOrvH+whHccdpoEReZww8gZWhwCqanfyL6UxsEAODV
	 rkM2Kxf+JQAbXgTHiJjAE8L2l00CXVt9ql3g8xaZmkaivTwHEk+yolMSL+dbsZ27vg
	 OhJ+uySIkR+3pqqAgKBENCEXgrY9ThTbJGfaPWzJwryQDqYT6RrZ4FqOKyzNEaq180
	 AnSWhk/d0T2gA==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DFEF017E04D6;
	Wed,  5 Nov 2025 22:18:34 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 8C1DE10F352D9; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v3 00/13] arm64: dts: mediatek: Add Openwrt One AP
 functionality
Date: Wed, 05 Nov 2025 22:17:55 +0100
Message-Id: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAO/C2kC/x3MSwqAMAwA0atI1gba+gG9irjQGjUIqaSignh3i
 8u3mHkgkjJFaLMHlE6OHCShyDPw6yALIU/J4IyrrLE1hp3k0gODEAodV9ANSzP6ZvB2dJWHVO5
 KM9//tevf9wNgNip4ZQAAAA==
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
Sjoerd Simons (13):
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable SPI NOR
      arm64: dts: mediatek: mt7981b-openwrt-one: Enable software leds
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
 .../devicetree/bindings/net/mediatek,net.yaml      |   6 +-
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   1 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   1 +
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 263 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          | 226 +++++++++++++++++-
 6 files changed, 492 insertions(+), 6 deletions(-)
---
base-commit: d7d7ac9af8cb72e3e3816ae9da3d9ee1bdfa4f9b
change-id: 20251016-openwrt-one-network-40bc9ac1b25c

Best regards,
-- 
Sjoerd Simons <sjoerd@collabora.com>


