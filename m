Return-Path: <linux-pci+bounces-19389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0948BA039B7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 09:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF77163851
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C11DB37A;
	Tue,  7 Jan 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="D40YXh8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m127211.xmail.ntesmail.com (mail-m127211.xmail.ntesmail.com [115.236.127.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC0158868;
	Tue,  7 Jan 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238287; cv=none; b=JQGeSB9cvFkztbQvlamfdub7Fnx+gKqhlrNgH3LV9f6nZUN/BAwvWREB5nz7/FGNhdajfPxnT+fvKJGV2Ex+MSaYj3mdONspslsBBr2tsVQIiWaYqOT2J0IcSpQLcwpcBkBBt+u5vQeNAWHh6cwXPYqJlM3HA9j6zsIK1DY1dqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238287; c=relaxed/simple;
	bh=zISdrXTv3epfRg/hcf/XpyuaONQMLQ3KdnvliLoAmKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GxPh8QuuB05EXo5seSX16XuYP2Vd0zN0hrHe4YQNa6rIohwFBkoU+YJy0jenPCkRJLuHJXKQznDFzVGe4taYCQAoDEd3sRHYxMmsQkTjs8opH9jl25H4K63GC58y/+z9gMUDqMxp4EDb8YGqSlDB85VTeiQ856Lb4uYtOYrN2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=D40YXh8I; arc=none smtp.client-ip=115.236.127.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 7f3b5a6d;
	Tue, 7 Jan 2025 15:49:13 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-pci@vger.kernel.org,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andyshrk@163.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/7] Rockchip: add Rockchip rk3576 EVB1 board
Date: Tue,  7 Jan 2025 15:49:04 +0800
Message-Id: <20250107074911.550057-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8eTFZCGk9IT09PQkgZGkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a943fbd396203afkunm7f3b5a6d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46Pio*SDIUCxMXFCoXSBYZ
	S0JPCk1VSlVKTEhNSUhNSk5OSUpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTE5LNwY+
DKIM-Signature:a=rsa-sha256;
	b=D40YXh8Ig3x9KgSYbaspqwgV1zdkY+BYpjVnsflXf0RtiF9PS7rk4LMbPzJ+aXbBsoBwYk/wbO4SFTZbZzndmTPHjEn0ZvOWDBPHYWGwaXl8LAiy46ajkeI4Xej56HZIiWbzaj9k8SC6s3UJIHdoZuLOFJ5JS3+CScRUonk+MLk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=D2c/SE7vYWcihsMMVqmJdJJhyO1KiFLqRTUcCBMc7GM=;
	h=date:mime-version:subject:message-id:from;

This patch set is for rockchip rk3576 evb1.
Based on the naneng combphy patch from Frank Wang.

This version including the patch adding usb nodes from Frank Wang.

Changes in v4:
- Fix wrong indentation in dt_binding_check report by Rob
- Update the commit msg with sort rule per required by Krzysztof.

Changes in v3:
- Update the subject
- Fix dtb check broken on rk3588
- Update commit message
- Update the subject
- sort for all the board entries instead of two rockchip boards
which suggested by Diederik
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


