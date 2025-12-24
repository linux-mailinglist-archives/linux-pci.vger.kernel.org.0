Return-Path: <linux-pci+bounces-43643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D4CDB924
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 08:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 532E53007DB9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 07:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830D288522;
	Wed, 24 Dec 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gh5/+vL0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15597.qiye.163.com (mail-m15597.qiye.163.com [101.71.155.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E06283FE2
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766560557; cv=none; b=emXuBrK6YiwhnMeCKAy0QJWBRU9NR4tydCbmvTqquoFuLzmOIMkho9F9ef4Haap+v3wIyd1zQHgy3NTv6aHlVdQ6K362JR9GqwdGWsclW1fF8TVaxYQZhcDbO9R9e6mBLC1oNblFMTmlCk0a8v8lg1h3FjkyB3spO5bXM2gPZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766560557; c=relaxed/simple;
	bh=1Oj7VerpPDFpeCkHc2JYUV+IBPSrZImoEVTPIWjDZD8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=d0tkBfOWE6FM20GYMZscp6CGQPMsqDygbbrN3ahyTlnZ1w3+oBVAS7UCisazhqALZbUrxSmfR66Imb0fg1uGVRuuN0iaBA5wMiej31HOaoz2wrCAv2UfYUEfeUzqOEex72PGTT+G5cKsi+TtoQQ4WFR2ncr6G8WCr5rQfBMBiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gh5/+vL0; arc=none smtp.client-ip=101.71.155.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e63ea73d;
	Wed, 24 Dec 2025 15:10:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/5] Add calibration for Synopsys PCIe PHY and Controller
Date: Wed, 24 Dec 2025 15:10:05 +0800
Message-Id: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b4f31f8b109cckunm34e2a83f3c29b2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJCTlYaHk8dGkkfGENOSUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gh5/+vL0A5QZWNvpxrXt6g0tTM1y0jo5WlymP6ICW55+k3ArpRsLM/B+hts7Ac5bMMaVC4/fmDxwoWIsASG7NH0tfsQTkUNg2yu/6Wf1ZZoBYCyNEMo+GbZ+XgRWmgf8oan41gK77RSep4OsoV6sXnV5hgYBbsYvvBlVusNrcV8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=yBptviF9T5YX5SPBqB7UXmBB5g56SIiXZoIROiFrrzw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


Currently, when pcie-dw-rockchip uses the Synopsys PHY, it relies on
the phy_init() callback of the phy-rockchip-snps-pcie3 driver to
perform calibration. This is incorrect because the controller is
still held in reset at that time, preventing the PHY from accurately
reflecting the actual PLL lock and calibration status.

To fix this, this series:
1. Calls phy_calibrate() in the pcie-dw-rockchip driver (if supported)
   after the controller is out of reset, ensuring the PHY can
   properly synchronize with the controller state.
2. Adds the necessary calibration support in the Synopsys PHY driver
   to implement this callback.

Please review and test.



Shawn Lin (5):
  PCI: dw-rockchip: Add phy_calibrate() to check PHY lock status
  phy: rockchip-snps-pcie3: Add phy_calibrate() support
  phy: rockchip-snps-pcie3: Increase sram init timeout
  phy: rockchip-snps-pcie3: Check more sram init status for RK3588
  phy: rockchip-snps-pcie3: Only check PHY1 status when using it

 drivers/pci/controller/dwc/pcie-dw-rockchip.c  |  9 +++-
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 61 +++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.7.4


