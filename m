Return-Path: <linux-pci+bounces-7235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4808BFE47
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A964286643
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7027E576;
	Wed,  8 May 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJNvrddb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BD59158;
	Wed,  8 May 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174058; cv=none; b=hiDvUU8u5lL+ncs3OfaoAtdXcsu3bySEsOV1UQt4AOZogBH3hSogW7fZRtX7g87pl4w8jNw6qWOG+WiDedCfqVnr9CmnMFPziMHnzkCvMIpjCgmUTH86q+SsYqK+/9qzdpgk4s8OQ12N0TilLc6FGsmkL5iy5scRq0JspiEUO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174058; c=relaxed/simple;
	bh=59kFpa6ALdPCnEsQbbSRjoY4cwSouyaqunrcUlCZnSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sD6dEtK88mtSM9K6/4y9VmF7iel0ntLNXC55mqIGM8vOsH/X0BVZ+FL2Sra7GLCtENyvaRqIdzv3pytPd9pE03jkuPnZUztJReJTG53V0l7z0PBqz64A0CqREKiYQ8eN2TbErfALJEgrO47bJvluj1mWTvrfs064sMxW5yRbLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJNvrddb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C96C113CC;
	Wed,  8 May 2024 13:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174058;
	bh=59kFpa6ALdPCnEsQbbSRjoY4cwSouyaqunrcUlCZnSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LJNvrddbW3WjR20oW37Vi2I9PS/0PPHvqa3ludqYvGCvJj9QSdSehfXcKcQrb37my
	 BFICMtH8A9SwCbJbXyVYGHB7ejDXCCydvqhSI1gA81YHt37CeUvUqUmlf7dn5d0jUS
	 wtZNUgv7U1WeLQy48EZqSoxiHGYEGWCI1tm1LPO3UqwsCPGYZ2R4Vla0Itu2Jp7OEf
	 GJUybLzOiaeLYdmtbuxf/tTButy9lfhyOJl0O5vGbf+1NYDx/Dhrp7YW9GqzIERBAq
	 Q2EoZxDVYXfDGJ7EF9AGysQdtRV499MsRMcvgrvr/lP/JFVUvZ48mhAIIpv0VU081k
	 g2sPF45FbJ4bA==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:40 +0200
Subject: [PATCH v3 09/13] PCI: dw-rockchip: Refactor the driver to prepare
 for EP mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-9-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4770; i=cassel@kernel.org;
 h=from:subject:message-id; bh=59kFpa6ALdPCnEsQbbSRjoY4cwSouyaqunrcUlCZnSs=;
 b=kA0DAAoWyWQxo5nGTXIByyZiAGY7en+h5bfUWCxs6quy4NoAF8nr8mDGpzKJVKFiuiMqzeYKi
 Yh1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmY7en8ACgkQyWQxo5nGTXLE4AD+KKy9
 bsBL4dMFp1VbGzwBKAeqcY5dYaWBSVM91slqJC8BAIz6tZANn/Vjwd1IvbTtcYVn1socgobMoEd
 xwTTdqt4N
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

This refactors the driver to prepare for EP mode.
Add of-match data to the existing compatible, and explicitly define it as
DW_PCIE_RC_TYPE. This way, we will be able to add EP mode in a follow-up
commit in a much less intrusive way, which makes the follup-up commit much
easier to review.

No functional change intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 84 +++++++++++++++++++--------
 1 file changed, 60 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 2a70326cc0bc..3c2e012e3e91 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -49,15 +49,20 @@
 #define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
 struct rockchip_pcie {
-	struct dw_pcie			pci;
-	void __iomem			*apb_base;
-	struct phy			*phy;
-	struct clk_bulk_data		*clks;
-	unsigned int			clk_cnt;
-	struct reset_control		*rst;
-	struct gpio_desc		*rst_gpio;
-	struct regulator                *vpcie3v3;
-	struct irq_domain		*irq_domain;
+	struct dw_pcie				pci;
+	void __iomem				*apb_base;
+	struct phy				*phy;
+	struct clk_bulk_data			*clks;
+	unsigned int				clk_cnt;
+	struct reset_control			*rst;
+	struct gpio_desc			*rst_gpio;
+	struct regulator			*vpcie3v3;
+	struct irq_domain			*irq_domain;
+	const struct rockchip_pcie_of_data	*data;
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
 
@@ -288,13 +286,35 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = rockchip_pcie_start_link,
 };
 
+static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
+{
+	struct dw_pcie_rp *pp;
+	u32 val;
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
 	int ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
 	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
 	if (!rockchip)
 		return -ENOMEM;
@@ -303,9 +323,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	rockchip->pci.dev = dev;
 	rockchip->pci.ops = &dw_pcie_ops;
-
-	pp = &rockchip->pci.pp;
-	pp->ops = &rockchip_pcie_host_ops;
+	rockchip->data = data;
 
 	ret = rockchip_pcie_resource_get(pdev, rockchip);
 	if (ret)
@@ -342,10 +360,21 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto deinit_phy;
 
-	ret = dw_pcie_host_init(pp);
-	if (!ret)
-		return 0;
+	switch (data->mode) {
+	case DW_PCIE_RC_TYPE:
+		ret = rockchip_pcie_configure_rc(rockchip);
+		if (ret)
+			goto deinit_clk;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", data->mode);
+		ret = -EINVAL;
+		goto deinit_clk;
+	}
+
+	return 0;
 
+deinit_clk:
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
@@ -356,8 +385,15 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
 static const struct of_device_id rockchip_pcie_of_match[] = {
-	{ .compatible = "rockchip,rk3568-pcie", },
+	{
+		.compatible = "rockchip,rk3568-pcie",
+		.data = &rockchip_pcie_rc_of_data_rk3568,
+	},
 	{},
 };
 

-- 
2.44.0


