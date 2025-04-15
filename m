Return-Path: <linux-pci+bounces-25902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC74A8936A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6B6189A24E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 05:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6082242934;
	Tue, 15 Apr 2025 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aqgjzf0Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49220.qiye.163.com (mail-m49220.qiye.163.com [45.254.49.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB419992D;
	Tue, 15 Apr 2025 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744695266; cv=none; b=LC/E00FEBlX/igYvz5l3YZF/PEh73fTrzBh9+4h6FQ5iFTwvLfUAx500N6Dhb3+5wYEpkdhRuuCShVz5jyHYiA4e6bUAV29EYXav+ZnsdYpD+je0FRBLxdaYx08HnCKjAOTNfRlgDTrGQay5j7fkdi59szur6FsBmYVvW6B4uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744695266; c=relaxed/simple;
	bh=CREyEbOMBnE8kOzvCXQvLRpjV2iEM3D153H6Cn/ujEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAuUu/GyDdZoE8LN7m9BK/4PPV5MsUuyYckT8t7TehR/CQkrNxYhL+LGYk9ASq8w7u3qvbQT/FwnBBiSTCa9rPtNxLpNj3Equ+Pl3C7X/dANCZD24bJ8zSVnG5EqgR2tECeHP+V3cGzOXRNZwuDe5nAbwMkfqeYwBbkA345R7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aqgjzf0Y; arc=none smtp.client-ip=45.254.49.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11e6d9647;
	Tue, 15 Apr 2025 13:18:58 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frank Wang <frank.wang@rock-chips.com>,
	Jamie Iles <jamie@jamieiles.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Johan Jonker <jbx6244@gmail.com>,
	ulf.hansson@linaro.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Yao Zi <ziyao@disroot.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	devicetree@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	linux-watchdog@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	Jimmy Hon <honyuenkwun@gmail.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/7] rockchip: Add rk3562 SoC and evb support
Date: Tue, 15 Apr 2025 13:18:48 +0800
Message-Id: <20250415051855.59740-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkseVk8dTEpJT00eQ0xLTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0hMVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a9637e2e37803afkunm11e6d9647
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6Fjo5CDJNLBopGgwjCjg3
	CDMKCT1VSlVKTE9PTUJPSE9JT09KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9JSEw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=aqgjzf0YeZvYGty2CdsOQnp7mCSRn3ztKgzIpqn882Rkfvdv/XFgXiMTPO8h/TNVg0DJDZO+Xd5aJp7UieaQKqUZiD5gaAaEPOpbmP/J4xAgK0kxtGFaVaAdYbjnM69LaA4Qgln+GGUQSg+yxD20zafuuF/Xwow3Vag5PLsWcMA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=kVuF3/DNXF3QjN/z8vNYlHmSLMpNtBoaruzQNxSDhrk=;
	h=date:mime-version:subject:message-id:from;


Patch series V4 remove patches already landed, and remove dts nodes for
modules still under review.

This patch set adds rk3562 SoC and its evb support.

I have split out patches need driver change for different subsystem.
And all the modules with dt-binding document update in this patch set
do not need any driver change. I put them together to make it clear we
have a new SoC and board to use the new compatible. Please pick up the
patch for your subsystem, or please let me know if the patch has to
send separate.

Test with USB, PCIe, EMMC, SD Card.

This patch set is base on the patch set for rk3576 evb1 support.

V3:
https://lore.kernel.org/linux-rockchip/20250227111913.2344207-1-kever.yang@rock-chips.com/
V2:
https://lore.kernel.org/linux-rockchip/b4df8a73-58a2-4765-a9e4-3513cb2bc720@rock-chips.com/T/


Changes in v4:
- Collect ack tag
- remove gmac and otp nodes
- remove gmac nodes

Changes in v3:
- Rebase the change base on rk3576 pcie patches
- Collect reveiw tag
- Collect the Acked-by tag
- remove i2c/serial/spi alias
- add soc node

Changes in v2:
- Update in sort order
- remove grf in cru
- Update some properties order

Finley Xiao (2):
  arm64: dts: rockchip: add core dtsi for RK3562 Soc
  arm64: dts: rockchip: Add RK3562 evb2 devicetree

Kever Yang (5):
  dt-bindings: PCI: dwc: rockchip: Add rk3562 support
  dt-bindings: watchdog: Add rk3562 compatible
  dt-bindings: rockchip: pmu: Add rk3562 compatible
  dt-bindings: soc: rockchip: Add rk3562 syscon compatibles
  dt-bindings: arm: rockchip: Add rk3562 evb2 board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 .../devicetree/bindings/arm/rockchip/pmu.yaml |    2 +
 .../bindings/pci/rockchip-dw-pcie.yaml        |    9 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml |    7 +
 .../bindings/watchdog/snps,dw-wdt.yaml        |    1 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3562-evb2-v10.dts     |  488 ++++
 .../boot/dts/rockchip/rk3562-pinctrl.dtsi     | 2352 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3562.dtsi      | 1263 +++++++++
 9 files changed, 4126 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3562-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3562.dtsi

-- 
2.25.1


