Return-Path: <linux-pci+bounces-43645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B547CDB934
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 08:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7EB73008EBF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640213AF2;
	Wed, 24 Dec 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TmLgWE9U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com [220.197.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DB2701CF
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766560631; cv=none; b=csNOaWZ5K58EYZ/FwDzoHBMcYX1DpewEe4JRm3wo2uO0nBo7WQsjYdMiv8X1XuF3SGfTrq3UPhHOUau+1C9l4uJUetl3M2BV4VKQ463zXxJY+i6QB24FHQWWTvYRQbp3RWKzCVeYAkHq0dIF21dWZ5pXasnH9R9+aSB1PoTZoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766560631; c=relaxed/simple;
	bh=KFn0Jd/TnwN6RtZNHl/yQzK4e8KbiBSVkPiEzMwVhLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dI2fiVNkW3dMePl5bInM/rj7+VVmH/Lap2qn7MId7P7Itwk9gP8oSvgMDgOPMNB3eW6ZGdlu6bLVOfQ+rDxxJJb8wvyBZxlXEBMisfOmZFg9UrcHC3dP6fj9RP8nWiktniw1tDiPbr8mz4si9J7A/v9fJnygnZ3GV3nBcOxWInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TmLgWE9U; arc=none smtp.client-ip=220.197.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e63ea8ca;
	Wed, 24 Dec 2025 15:11:50 +0800 (GMT+08:00)
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
Subject: [PATCH 5/5] phy: rockchip-snps-pcie3: Only check PHY1 status when using it
Date: Wed, 24 Dec 2025 15:10:10 +0800
Message-Id: <1766560210-100883-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b4f3325d609cckunm34e2a83f3c2d9f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIeHlYaHUhJSkJPQx4dSh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TmLgWE9U7J1vkop2lo1vEeOw97p0kk+Be/2U3TnE2Eek1d/kfquCEwnGLLvkp3zlUQmwNK7tTiEHQoh+mbs3GOUGNgpqfdb147CRvHji6dySuTGBQZgeQVYqR7EiwsK+KqGZWGKuxnFfbUdIgpArqyTP5gLb6AVyczeyc3Exk5k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=HVTGJgDhwCKjeXI1BckdM02NnUQgr1hJwOomGYZB9m8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

RK3588_LANE_AGGREGATION and RK3588_BIFURCATION_LANE_2_3 should be
used to check if it need to check PHY1 status. Because in other
cases, only PHY0 could show locked status.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 6cc38e3..36b2142 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -183,6 +183,7 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 	}
 
 	reg = mode;
+	priv->pcie30_phymode = mode;
 	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
 		     RK3588_PCIE30_PHY_MODE_EN | reg);
 
@@ -208,10 +209,13 @@ static int rockchip_p3phy_rk3588_calibrate(struct rockchip_p3phy_priv *priv)
 				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
 				       reg, RK3588_SRAM_INIT_DONE(reg),
 				       0, RK_SRAM_INIT_TIMEOUT_US);
-	ret |= regmap_read_poll_timeout(priv->phy_grf,
-					RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
-					reg, RK3588_SRAM_INIT_DONE(reg),
-					0, RK_SRAM_INIT_TIMEOUT_US);
+	if (priv->pcie30_phymode & (RK3588_LANE_AGGREGATION | RK3588_BIFURCATION_LANE_2_3)) {
+		ret |= regmap_read_poll_timeout(priv->phy_grf,
+						RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
+						reg, RK3588_SRAM_INIT_DONE(reg),
+						0, RK_SRAM_INIT_TIMEOUT_US);
+	}
+
 	if (ret)
 		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
 			reg);
-- 
2.7.4


