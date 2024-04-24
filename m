Return-Path: <linux-pci+bounces-6639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2078B0DCF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF351F282E8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94215EFD5;
	Wed, 24 Apr 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AluDLZsB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8308158A3D;
	Wed, 24 Apr 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971828; cv=none; b=GxvuR7+a1B0ns/7HqLiOcixec3eV7tBhySyCNDxmdyvITA/fgj4zZnyhX8iTNKogha6i2+FVBCmQxdIkIHdSHFzlfrMRm/y06thl61WpYOxlUvYM5q2yo3Qs5K8CTa6Tdmbx7fzS5oUmQWLhzL6JFFnGjpqzlIoPIO8PBuBdZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971828; c=relaxed/simple;
	bh=xLwcWQF6UpVKQciGO/RUiXs9OFEWU21J+06lAAMiDbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2VIf+jcMnpM199k+tWF9aJTrer6WnFi74EIPliJDUz8CyZhV5spk5V5INP5CZ+BZHuY3508PCR5cSENkQNtVASLhtSt0ZrpCibsDcVxYUVPwMC3Sihw4QUyQjefNBBNP0zDL/MvI1n4I9K/7SnKDb51xuoznfQHMS+c5DlBYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AluDLZsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EC7C113CE;
	Wed, 24 Apr 2024 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971828;
	bh=xLwcWQF6UpVKQciGO/RUiXs9OFEWU21J+06lAAMiDbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AluDLZsBT0+tZr4GZV5irHKJR9CgTjxedNUVoQmWOdWot/uTePb56irz6woiHXLDY
	 gfY80LsucmF5RELBJCfTsRW4+dm0Rn12CcXdd9n1hWIdOIobMBFlAzszGSwYiTj2aA
	 lFsGV9XyvTJ8Rjta6rerOLgIMwkMbBjgOhokXCgBVqo6jOrmjyioVd3H0z64fUebcG
	 cggkDt13HYa3ETKnO+4HrQJu7aQ0KX42a2GuMWER8WaGAYDyPV6xkothvuubmhudxL
	 Jg/bL/gs62uj0q94y90Jd6RZMrVL51qPGBgJgRxAstTq+Hps9ffwJIK2BsGr/UmY6P
	 G/AUw5WAp+0ng==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:25 +0200
Subject: [PATCH 07/12] PCI: dw-rockchip: Refactor the driver to prepare for
 EP mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-7-b1a02ddad650@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4413; i=cassel@kernel.org;
 h=from:subject:message-id; bh=xLwcWQF6UpVKQciGO/RUiXs9OFEWU21J+06lAAMiDbk=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYLYyj2faHa6qTF3ZU+5Uz2ZTT9sQ8qVyEnfOf+tF
 Xlb8jGjo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNxt2X4nxclv3VCiHnGlGAx
 +e+qAab9L+TnXdBZc13V1l9hoZ/dG0aGbRcZ6uy/5m8/L+5dnX/sLO+a6Ue2CKv+kT302deQo1q
 aAwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

This refactors the driver to prepare for EP mode.
Add of-match data to the existing compatible, and explicitly define it as
DW_PCIE_RC_TYPE. This way, we will be able to add EP mode in a follow-up
patch in a much less intrusive way, which makes the follup-up patches
much easier to review.

No functional change intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 72 +++++++++++++++++++++------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 4023fd86176f..bc1347e84f72 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -58,6 +58,11 @@ struct rockchip_pcie {
 	struct gpio_desc		*rst_gpio;
 	struct regulator                *vpcie3v3;
 	struct irq_domain		*irq_domain;
+	enum dw_pcie_device_mode	mode;
+};
+
+struct rockchip_pcie_of_data {
+	enum dw_pcie_device_mode mode;
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
@@ -195,7 +200,6 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	struct device *dev = rockchip->pci.dev;
-	u32 val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
 	int irq, ret;
 
 	irq = of_irq_get_byname(dev->of_node, "legacy");
@@ -209,12 +213,6 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
-	/* LTSSM enable control mode */
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
-
-	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
-				 PCIE_CLIENT_GENERAL_CONTROL);
-
 	return 0;
 }
 
@@ -288,13 +286,41 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = rockchip_pcie_start_link,
 };
 
+static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
+{
+	struct dw_pcie_rp *pp;
+	u32 val;
+
+	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
+		return -ENODEV;
+
+	/* LTSSM enable control mode */
+	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
+				 PCIE_CLIENT_GENERAL_CONTROL);
+
+	pp = &rockchip->pci.pp;
+	pp->ops = &rockchip_pcie_host_ops;
+
+	return dw_pcie_host_init(pp);
+}
+
 static int rockchip_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie *rockchip;
-	struct dw_pcie_rp *pp;
+	const struct rockchip_pcie_of_data *data;
+	enum dw_pcie_device_mode mode;
 	int ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	mode = (enum dw_pcie_device_mode)data->mode;
+
 	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
 	if (!rockchip)
 		return -ENOMEM;
@@ -303,9 +329,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	rockchip->pci.dev = dev;
 	rockchip->pci.ops = &dw_pcie_ops;
-
-	pp = &rockchip->pci.pp;
-	pp->ops = &rockchip_pcie_host_ops;
+	rockchip->mode = mode;
 
 	ret = rockchip_pcie_resource_get(pdev, rockchip);
 	if (ret)
@@ -342,10 +366,21 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto deinit_phy;
 
-	ret = dw_pcie_host_init(pp);
-	if (!ret)
-		return 0;
+	switch (rockchip->mode) {
+	case DW_PCIE_RC_TYPE:
+		ret = rockchip_pcie_configure_rc(rockchip);
+		if (ret)
+			goto deinit_clk;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", rockchip->mode);
+		ret = -EINVAL;
+		goto deinit_clk;
+	}
 
+	return 0;
+
+deinit_clk:
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
@@ -356,8 +391,15 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct rockchip_pcie_of_data rk3568_pcie_rc_of_data = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
 static const struct of_device_id rockchip_pcie_of_match[] = {
-	{ .compatible = "rockchip,rk3568-pcie", },
+	{
+		.compatible = "rockchip,rk3568-pcie",
+		.data = &rk3568_pcie_rc_of_data,
+	},
 	{},
 };
 

-- 
2.44.0


