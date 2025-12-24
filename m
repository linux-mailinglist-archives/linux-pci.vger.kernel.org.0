Return-Path: <linux-pci+bounces-43646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429FCDB940
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 08:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A743019BBB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231332D0D7;
	Wed, 24 Dec 2025 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fXN+rH/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com [220.197.32.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ABB13AF2
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766561178; cv=none; b=lB6uKp+C/XCv/tdcE+HLY54fpf64+Vzkr35LEVRFH9Aw6JLCi9pg/o5abZopaTMvRH+Nw1KaG+a/NDyjNW3nwP2iN7nw7YuQ3OzIEJBcx/4h8K5bDHZ2rTJ5vzRrEjXmkbQodnf80CcyPI1FoSWjEZ5CnUYFbgaSfyUMnquyhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766561178; c=relaxed/simple;
	bh=0S5zZNdv9XmmF7RpM1QcN+qhBTJfuOL76Q11ILOMlRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U0cnP+sWOmWG69Id4ZHWNCTfh2WHNg09jSPHzoXqH7HGfqDVD99c5iE2HivmC9YLhr5Y9JxagUa3XttVKWf4cyLK/R/PMHGgMOXSjERTGRgUjXyY/SK4g9yVV+E/xa3snBZCp1rEjC1y5kj4nk7IPJnbnEYsKh1TBAHRSM1Jmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fXN+rH/S; arc=none smtp.client-ip=220.197.32.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e63ea78c;
	Wed, 24 Dec 2025 15:10:48 +0800 (GMT+08:00)
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
Subject: [PATCH 1/5] PCI: dw-rockchip: Add phy_calibrate() to check PHY lock status
Date: Wed, 24 Dec 2025 15:10:06 +0800
Message-Id: <1766560210-100883-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b4f32340d09cckunm34e2a83f3c2a70
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhoZQlZOSU4dSE8YGkxKH0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fXN+rH/SRZfYnwscvqoSqYTEjcehEY+7m0VATktGPyBc5q+Sr8vHX9/FFAUmWt3xIx71RB0HFKIkId26Gc1UrAPnMycD7vMOP6yiv/+4tmSZkGkCnF0QX6r+rXFWCGk/X1gBl2yTev/3jACQHcx9peNbiPQovAZGA56jr9zSsHE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nmApjKhdRDMPDmEy+/sym/t5MR+4fczg/gJfQLzXJfs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Current we keep controller in reset state when initializing PHY which
is the right thing to do. But this case, the PHY is also reset because
it refers to a signal from controller. Now we check PHY lock status
inside .phy_init() callback which may be bogus for certain type of PHY,
because of the fact above. Add phy_calibrate() to better check PHY lock
status if provided.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f8605fe..75d6306 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -705,6 +705,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto deinit_phy;
 
+	ret = phy_calibrate(rockchip->phy);
+	if (ret) {
+		dev_err(dev, "phy lock failed\n");
+		goto assert_controller;
+	}
+
 	ret = rockchip_pcie_clk_init(rockchip);
 	if (ret)
 		goto deinit_phy;
@@ -727,7 +733,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
+assert_controller:
+	reset_control_assert(rockchip->rst);
 deinit_clk:
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
-- 
2.7.4


