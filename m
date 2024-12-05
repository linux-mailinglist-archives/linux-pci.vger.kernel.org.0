Return-Path: <linux-pci+bounces-17739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0350D9E5611
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AD91884B5E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5A218E83;
	Thu,  5 Dec 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UGYudZ49"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com [220.197.31.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B9218EAB;
	Thu,  5 Dec 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403538; cv=none; b=DkFvAeh4L7gSoUbrCFIm9zNWsLSfYEFnjfQZyx5bQtd4XAhFAOYoQuhjeVS5rGgfdrGzBFQf2Rivt1F06WtLkETDgMWd69DKYCzcf9Uh+hEkL57crNEIvH7cjqGxJuMcyqCq1qP3Ml+rrqmxQR72fewHgz0SAOzervI1QgS4s3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403538; c=relaxed/simple;
	bh=Mjh0+Ghq39c3Z8PaPr5TudqH4HaDN6JW/hftro+NnBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bfEiY7C2l0Wg8MpAG74tWjeKvhxg2zSZhMVw75iFzUCv5Bblbr6Zr2eQxxf0BQEAatPiZbIhCJnloek8NUHNbFs6ybelrDdPCwoZF+YLg7tShKNOstNH8zfp1m+ZEzu+ICUgRgN04znBuYz3sPWc+FZNzjuKxofIBzthR5aWvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UGYudZ49; arc=none smtp.client-ip=220.197.31.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cf7c950;
	Thu, 5 Dec 2024 18:36:25 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	Andy Yan <andyshrk@163.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Liang Chen <cl@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Rob Herring <robh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Tim Lunn <tim@feathertop.org>,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/6] Rockchip: add Rockchip rk3576 EVB1 board
Date: Thu,  5 Dec 2024 18:36:17 +0800
Message-Id: <20241205103623.878181-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktDSFYYQhgeSk4aGU1MTxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a93966473a603afkunm4cf7c950
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6PAw*PDIqFQ1KTC4oCyFL
	FQkwCkpVSlVKTEhISEJPQkNMQ0hNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTEk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=UGYudZ49/Tpfn7Cf5rTTiJQdMgDdEGhcTtxG+aVVnUzIlQQDYPHIb+fUCQQ+MVlbRR9Wd0bGmZf9N7HmnLYGba+gM1wJi/c4c4+zFLvIz0n+Tv6L05qq1lnNJc2BcQ9vTeONAYZ4QI45uju0nIXt+hpvj2M8hpjPc4WzgZGoxuI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=HbXkrvngECAti2YdLItTE7lclPMNfzI3QgCujE+EWYI=;
	h=date:mime-version:subject:message-id:from;

This patch set is for rockchip rk3576 evb1.
Based on the naneng combphy patch from Frank Wang.


Kever Yang (6):
  dt-bindings: PCI: dwc: rockchip: Add rk3576 support
  dts: arm64: rockchip: Add rk3576 naneng combphy nodes
  dts: arm64: rockchip: Add rk3576 pcie nodes
  dt-bindings: arm: rockchip: Sort for rk3568 evb
  dt-bindings: arm: rockchip: Add rk3576 evb1 board
  arm64: dts: rockchip: Add rk3576 evb1 board

 .../devicetree/bindings/arm/rockchip.yaml     |  25 +-
 .../bindings/pci/rockchip-dw-pcie.yaml        |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3576-evb1-v10.dts     | 699 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 147 ++++
 5 files changed, 863 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts

-- 
2.25.1


