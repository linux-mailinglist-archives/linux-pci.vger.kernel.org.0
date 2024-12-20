Return-Path: <linux-pci+bounces-18894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92779F8FFD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 11:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F4161A3B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983851C1AC7;
	Fri, 20 Dec 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SaqqE/3s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com [220.197.31.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378721B415C;
	Fri, 20 Dec 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689767; cv=none; b=Pa+FaP2Gl6nZxoVv6Kz8SFluMV74UOz+9GcQ9/OyzHtlo/Ycb98MtxluGNmm4wE5dMTjYo7keYPnT8K56KMm9TW1CjcwWcA5QtLJO/D6OekGP8Li8RILFYCeMRRlStPNQ9bM7dNFMj8BvaVs/Xnz9RpR8sd79cQOGISyOqyR2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689767; c=relaxed/simple;
	bh=S6lp8lEH5jeFLH5Z21fUTJ6D46qdtviZznpELraTqm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDD9/Y1KfHa1HHQFlUy47cl5ub8Z0kvQOnjikcVf7WsrkvmfDtmpHhX8Z4UenGcBtRNS6Q+NxoHjT6oH3ROWVC9ZOAH+e4XW3himm8wpfwjaqsqSvaExbeimnMgAGcywcIaP6D4rfTgDuL+FHtmK/8n/AldRcbugxO2v292zbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SaqqE/3s; arc=none smtp.client-ip=220.197.31.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 655ee8f1;
	Fri, 20 Dec 2024 18:15:52 +0800 (GMT+08:00)
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
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andyshrk@163.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	devicetree@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>,
	Elon Zhang <zhangzj@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/7] Rockchip: add Rockchip rk3576 EVB1 board
Date: Fri, 20 Dec 2024 18:15:44 +0800
Message-Id: <20241220101551.3505917-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlOHlZCThlKS0xMSBgdT0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93e391058303afkunm655ee8f1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6NDo4EjILSQgSGjMfM1Er
	PREKCTZVSlVKTEhPTUNCTE5PTU5KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEpDNwY+
DKIM-Signature:a=rsa-sha256;
	b=SaqqE/3shmWWw7PqQray8gEJWsYwpQMnGYHf8Yp0HDwxlSpSSc94j7efTau8U9/htSdpHm3YFeFTS5aaBl8nP4A7IHdU9AXEDuR55kfU5OIYIirzbzam9kSez0n0qILJhSVFkJTUPG5NcYQr7YX+CFX2Al/ilHJKG46pt0x9u78=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=OBokeCxfnTm6eAu/h7mtemhN/Nfn+T+42ptXe6cPst4=;
	h=date:mime-version:subject:message-id:from;

This patch set is for rockchip rk3576 evb1.
Based on the naneng combphy patch from Frank Wang.

This version including the patch adding usb nodes from Frank Wang.

Changes in v2:
- update the clock and reset names to pass the DTB CHECK
- remove required 'msi-map'
- add interrupt name 'msi'
- Update clock and reset names and sequence to pass DTB check
- collect acked-by tag
- Enable USB nodes

Frank Wang (1):
  arm64: dts: rockchip: add usb related nodes for rk3576

Kever Yang (6):
  dts: arm64: rockchip: Add rk3576 naneng combphy nodes
  dt-bindings: PCI: dwc: rockchip: Add rk3576 support
  dts: arm64: rockchip: Add rk3576 pcie nodes
  dt-bindings: arm: rockchip: Sort for rk3568 evb
  dt-bindings: arm: rockchip: Add rk3576 evb1 board
  arm64: dts: rockchip: Add rk3576 evb1 board

 .../devicetree/bindings/arm/rockchip.yaml     |  25 +-
 .../bindings/pci/rockchip-dw-pcie-common.yaml |   1 +
 .../bindings/pci/rockchip-dw-pcie.yaml        |   4 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3576-evb1-v10.dts     | 727 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 278 +++++++
 6 files changed, 1023 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts

-- 
2.25.1


