Return-Path: <linux-pci+bounces-43647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B049CDB943
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 08:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 535FE300FF91
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 07:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA76329E7B;
	Wed, 24 Dec 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Iw7nSt9c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49222.qiye.163.com (mail-m49222.qiye.163.com [45.254.49.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3D29B8E6
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766561220; cv=none; b=naOYv622SYAuu4hh3z8lthZ1h8LJj2vTwrSwDNf6wH6Lx98I3Or8koMyPghyW/CV4LXPQ12kaFYiCqjqheJKO71DZu7d6yEfPreSs4m+7f7BEomfdiw5Nh1rqCf6oB3LYGWJi+Qfb8oR0ETjx3JiCMx/NrJoLi92rIHPY+aNCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766561220; c=relaxed/simple;
	bh=PjLI15XN12wsaXPRrw2CwjVgxe+yUNCi9+EIO/HsSYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IicalFAMNhFuDL4jubwyldICQHo9NhkzmwTbt7mjCBYc7Z9r1l4HduiZsxdkHV9SQV7B2cDYl6uH9u+MtQWotzO3OEGm7EWdJRQHI20M/pZn1rHDyc8iTvpzOXzO9y829n9vjf69wCaMf2VfkPpKLb4fBOEKcjKktlhSfdX17yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Iw7nSt9c; arc=none smtp.client-ip=45.254.49.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e63ea865;
	Wed, 24 Dec 2025 15:11:30 +0800 (GMT+08:00)
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
Subject: [PATCH 3/5] phy: rockchip-snps-pcie3: Increase sram init timeout
Date: Wed, 24 Dec 2025 15:10:08 +0800
Message-Id: <1766560210-100883-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b4f32d62409cckunm34e2a83f3c2c91
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwaSVYdHxlNHxodTkhCHU9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Iw7nSt9c8tEvWpg3gLwe519KZpMrPBz68S4FVjIBrBAp2Wa42cM5yDF9pXLp0zDKByT1ktPlT2XL2KCWjM+q67asrzvRHNJfcVet3Vsvi0u1R2BgwDhjji9nQFY9+vAnHqgOBLDl/OQs2GBPk06q64kDPUBDCIrH/eJja40Tx/c=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=l291mjngOoC5Xss5l2K9o++sUJT3eCPCttg5zs+CEfo=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Per massive test, 500us is not enough for all chips, increase it
to 20000us for worse case recommended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 9933cda..f5a5d0af 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -19,6 +19,9 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
+/* Common definition */
+#define RK_SRAM_INIT_TIMEOUT_US			20000
+
 /* Register for RK3568 */
 #define GRF_PCIE30PHY_CON1			0x4
 #define GRF_PCIE30PHY_CON6			0x18
@@ -28,6 +31,7 @@
 #define GRF_PCIE30PHY_WR_EN			(0xf << 16)
 #define SRAM_INIT_DONE(reg)			(reg & BIT(14))
 
+
 #define RK3568_BIFURCATION_LANE_0_1		BIT(0)
 
 /* Register for RK3588 */
@@ -134,7 +138,7 @@ static int rockchip_p3phy_rk3568_calibrate(struct rockchip_p3phy_priv *priv)
 	ret = regmap_read_poll_timeout(priv->phy_grf,
 				       GRF_PCIE30PHY_STATUS0,
 				       reg, SRAM_INIT_DONE(reg),
-				       0, 500);
+				       0, RK_SRAM_INIT_TIMEOUT_US);
 	if (ret)
 		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
 			reg);
@@ -203,11 +207,11 @@ static int rockchip_p3phy_rk3588_calibrate(struct rockchip_p3phy_priv *priv)
 	ret = regmap_read_poll_timeout(priv->phy_grf,
 				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
 				       reg, RK3588_SRAM_INIT_DONE(reg),
-				       0, 500);
+				       0, RK_SRAM_INIT_TIMEOUT_US);
 	ret |= regmap_read_poll_timeout(priv->phy_grf,
 					RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
 					reg, RK3588_SRAM_INIT_DONE(reg),
-					0, 500);
+					0, RK_SRAM_INIT_TIMEOUT_US);
 	if (ret)
 		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
 			reg);
-- 
2.7.4


