Return-Path: <linux-pci+bounces-18960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10759FAD6F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD407A1832
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC8195FE8;
	Mon, 23 Dec 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Zr0Kezkx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m4920.qiye.163.com (mail-m4920.qiye.163.com [45.254.49.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD719342F;
	Mon, 23 Dec 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952013; cv=none; b=TFOSATi457DjkGJz2QZkq3EgtBu/Q4HFsWXSx5Wkaehu/wilwnRvqFau4Td9J+hQJ/NJSjXb1hcQzl3A4d4os/0Djxdr7ce187kczR/DOaMvokAoPQr8JMr8dL8wmjtlDorahnYB+gm/ZdAa2z6dmWmqqAdMMKB9kVW9j/S1IuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952013; c=relaxed/simple;
	bh=MN/MRSgYCILmaH7LqTJKtKk83Vemn/K60SDnUNvFzt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pA7Eb5+mtXAV2GaxF1o0DijWolnvlydCmV4zjJk/eKp5EwVAtK5KkI7ihYEjrwLjrXxck+ji6iuS8W4IHK3Tc+m8XwGqd01sEBpnMUX+QaETFP89nRL0JKMOd5fP2v3n6FlR5sOnRFRwQ7FkQruma73k0kHAwTjBlnAQsJ2KRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Zr0Kezkx; arc=none smtp.client-ip=45.254.49.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 68ea0131;
	Mon, 23 Dec 2024 19:06:38 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Michael Riesch <michael.riesch@wolfvision.net>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Liang Chen <cl@rock-chips.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	Andy Yan <andyshrk@163.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/7] Rockchip: add Rockchip rk3576 EVB1 board
Date: Mon, 23 Dec 2024 19:06:30 +0800
Message-Id: <20241223110637.3697974-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5LHVZIHx1KShhPTkIeHR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f33294e803afkunm68ea0131
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6Szo6MTIKCAEKN081GRMD
	PxYKCwlVSlVKTEhPQk5JS0tLQ0tIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTkxMNwY+
DKIM-Signature:a=rsa-sha256;
	b=Zr0KezkxrrlHR7mhy/y4gFYBIO5808CgTCfiJ72APnW2QLkyU8OiV13w4eCF25b8MA+TsQXRhp9uXJ4yCdI8avyrV4BS8FyOWmTJeRrmUxkxjZWlSg38mZSi9rLEaQiWiuHnTXY2Nq9GEyWqgotxNEIzpM06QCPBFwJxPeOqtYo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=hkUv9K/cbcAwXcBbSaeyYRD07IQjadduDFOI/Z3WPJc=;
	h=date:mime-version:subject:message-id:from;

This patch set is for rockchip rk3576 evb1.
Based on the naneng combphy patch from Frank Wang.

This version including the patch adding usb nodes from Frank Wang.

Changes in v3:
- Update the subject
- Fix dtb check broken on rk3588
- Update commit message
- Update the subject
- sort for all the board entries instead of two rockchip boards
- update some properties order

Changes in v2:
- Update the clock and reset names to pass the DTB CHECK
- remove required 'msi-map'
- add interrupt name 'msi'
- Update clock and reset names and sequence to pass DTB check
- collect acked-by tag
- collect acked-by tag
- Enable USB nodes

Frank Wang (1):
  arm64: dts: rockchip: add usb related nodes for rk3576

Kever Yang (6):
  arm64: dts: rockchip: Add rk3576 naneng combphy nodes
  dt-bindings: PCI: dw: rockchip: Add rk3576 support
  arm64: dts: rockchip: Add rk3576 pcie nodes
  dt-bindings: arm: rockchip: Sort for boards not in correct order
  dt-bindings: arm: rockchip: Add rk3576 evb1 board
  arm64: dts: rockchip: Add rk3576 evb1 board

 .../devicetree/bindings/arm/rockchip.yaml     |  59 +-
 .../bindings/pci/rockchip-dw-pcie-common.yaml |   4 +-
 .../bindings/pci/rockchip-dw-pcie.yaml        |   4 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3576-evb1-v10.dts     | 722 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 278 +++++++
 6 files changed, 1037 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts

-- 
2.25.1


