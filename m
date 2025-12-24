Return-Path: <linux-pci+bounces-43644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08539CDB930
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 08:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6CF23007DB4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE132C923;
	Wed, 24 Dec 2025 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Tv3tSZax"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3279.qiye.163.com (mail-m3279.qiye.163.com [220.197.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949D13AF2
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766560598; cv=none; b=TBdEDTVopDciR5DI7jcp6brI2v7Ugbagge/e3Sl5mdur9POv1CQ3ES5TTfH1T2AIdfH4gtZwxyydXsYHSJoKazDDVaIMcacPnU0KBYxRj//A1emB/Qkc720MVfzJkLhp5JiH5h1FGzWZW1KfsUTKs5pH4dCJiCdQDm64KBykn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766560598; c=relaxed/simple;
	bh=lfNDnCsoN1tqAsnTEyanVRQyYzxMeipX0JPno+H7XQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hTB4AZ/qc6/vj3yauFXF0KGzac4La+Kf2T3RXdmgB7SPqjVHhyHPl7av37r4aY2REtqKaaAw2vbiDQe/3tOWDJ/RXXkVm+IFJn90T9ahiz3AbPnvKUG1/qtc0RRflSuuBqA7iHwP2ZDAJMl+HyLctttME9TJn4tqi5YFXUhcDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Tv3tSZax; arc=none smtp.client-ip=220.197.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e63ea82c;
	Wed, 24 Dec 2025 15:11:17 +0800 (GMT+08:00)
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
Subject: [PATCH 2/5] phy: rockchip-snps-pcie3: Add phy_calibrate() support
Date: Wed, 24 Dec 2025 15:10:07 +0800
Message-Id: <1766560210-100883-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b4f32a5b809cckunm34e2a83f3c2be2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kaS1YZHk9KH05DSR8aGUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Tv3tSZaxMHEy9BOFvIFMxzUDWyTJ64TcHJ8vgBsz8fFxpnFgARWslNOBshhY9P/F35yKvHF3lko8xu3DvViIhdESRLQDUk83dv2qv94z1NDPHS4QWy5mMMcY8dq+fMBTMgbU6I8pfjAKYsdBvzZAyxWmCDWQag+VkoLf/WCaI98=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=vWydjYAjyArRvwPuW57TVayxZhgNNvCwYu5K9yYelnw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Move calibration from phy_init() to phy_calibrate().

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 39 ++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 4e8ffd1..9933cda 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -71,6 +71,7 @@ struct rockchip_p3phy_priv {
 
 struct rockchip_p3phy_ops {
 	int (*phy_init)(struct rockchip_p3phy_priv *priv);
+	int (*phy_calibrate)(struct rockchip_p3phy_priv *priv);
 };
 
 static int rockchip_p3phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
@@ -97,8 +98,6 @@ static int rockchip_p3phy_rk3568_init(struct rockchip_p3phy_priv *priv)
 {
 	struct phy *phy = priv->phy;
 	bool bifurcation = false;
-	int ret;
-	u32 reg;
 
 	/* Deassert PCIe PMA output clamp mode */
 	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9, GRF_PCIE30PHY_DA_OCM);
@@ -124,25 +123,34 @@ static int rockchip_p3phy_rk3568_init(struct rockchip_p3phy_priv *priv)
 
 	reset_control_deassert(priv->p30phy);
 
+	return 0;
+}
+
+static int rockchip_p3phy_rk3568_calibrate(struct rockchip_p3phy_priv *priv)
+{
+	int ret;
+	u32 reg;
+
 	ret = regmap_read_poll_timeout(priv->phy_grf,
 				       GRF_PCIE30PHY_STATUS0,
 				       reg, SRAM_INIT_DONE(reg),
 				       0, 500);
 	if (ret)
-		dev_err(&priv->phy->dev, "%s: lock failed 0x%x, check input refclk and power supply\n",
-		       __func__, reg);
+		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
+			reg);
+
 	return ret;
 }
 
 static const struct rockchip_p3phy_ops rk3568_ops = {
 	.phy_init = rockchip_p3phy_rk3568_init,
+	.phy_calibrate = rockchip_p3phy_rk3568_calibrate,
 };
 
 static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 {
 	u32 reg = 0;
 	u8 mode = RK3588_LANE_AGGREGATION; /* default */
-	int ret;
 
 	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_PHY0_LN0_CON1,
 		     priv->rx_cmn_refclk_mode[0] ? RK3588_RX_CMN_REFCLK_MODE_EN :
@@ -184,6 +192,14 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 
 	reset_control_deassert(priv->p30phy);
 
+	return 0;
+}
+
+static int rockchip_p3phy_rk3588_calibrate(struct rockchip_p3phy_priv *priv)
+{
+	int ret;
+	u32 reg;
+
 	ret = regmap_read_poll_timeout(priv->phy_grf,
 				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
 				       reg, RK3588_SRAM_INIT_DONE(reg),
@@ -200,6 +216,7 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 
 static const struct rockchip_p3phy_ops rk3588_ops = {
 	.phy_init = rockchip_p3phy_rk3588_init,
+	.phy_calibrate = rockchip_p3phy_rk3588_calibrate,
 };
 
 static int rockchip_p3phy_init(struct phy *phy)
@@ -234,10 +251,22 @@ static int rockchip_p3phy_exit(struct phy *phy)
 	return 0;
 }
 
+static int rockchip_p3phy_calibrate(struct phy *phy)
+{
+	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
+	int ret = 0;
+
+	if (priv->ops->phy_calibrate)
+		ret = priv->ops->phy_calibrate(priv);
+
+	return ret;
+}
+
 static const struct phy_ops rockchip_p3phy_ops = {
 	.init = rockchip_p3phy_init,
 	.exit = rockchip_p3phy_exit,
 	.set_mode = rockchip_p3phy_set_mode,
+	.calibrate = rockchip_p3phy_calibrate,
 	.owner = THIS_MODULE,
 };
 
-- 
2.7.4


