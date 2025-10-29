Return-Path: <linux-pci+bounces-39709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF69C1CA60
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B39EA4E97AB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ECB345753;
	Wed, 29 Oct 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AAAiGt2T"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF8355804;
	Wed, 29 Oct 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760632; cv=none; b=Ysoa+OOKZPb4tsGN+3knBCbBn8aZ78C2JaFie5/BiHTChqqNa/VPqJadXZVsRYfc1R8A51UduNnLjDM0cCIu3KvwFEjjAoRMb7CyMLm0rNb86qjCPlEbn/n/P4p1PLLnNwQprWy63AHSrA0hQ+N/x/meF8s2IKHDGgmj4F2z8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760632; c=relaxed/simple;
	bh=jdsx/CJd6cB/dQ3LDiSdUyMOVx1R7DaDMSkGxWQlgT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAnlKNqhkKzzgtJ34hQwXs2GidP7svFhu2Y9+IIQe+jYvE2NA7izA9DyaVh3+NxVIk8q+6TQEPm2CvR3MtOmdwJHB6CCeGcTYSNstX2eEIHCpN31EsEX1f6+ZAeEIY5vZYkLQMunMzi9h6a1hWGaufDdgR6WHwBD7axIdYqaxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AAAiGt2T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760623;
	bh=jdsx/CJd6cB/dQ3LDiSdUyMOVx1R7DaDMSkGxWQlgT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AAAiGt2TOZOsYoO2hCWH3sctzCNpiRqTFL/UWWsPyc2xVIF+cA+1nYautXz4jsMSY
	 LGfKNeEqWzeII/byWTOE5mmrYvDHkJMaQfBp0p5SdI4jGbSm42EeF5Zg3r1iKiaAJ/
	 pFUCh5McUr9GAvsP5dENNj6NIqjB90vbbV/JFnUy5BDKQkDlP79A4ZaSRcWTM7TTpG
	 xUQouO/tEMPAVC5M3QNuVRmgFA+Fe56WgglqCRWeqtw6gwfw+rbanrM6fs2pn/EdeB
	 Is3HI4FFbeT/LktX4VAqfcavmKxkPr21sbUGZZJFQQnbdz0fw90FycU33k7dKtJeEU
	 Wrz8sBVAkqjQg==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E33E217E1413;
	Wed, 29 Oct 2025 18:57:02 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 24D3C480066; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:47 +0100
Subject: [PATCH v4 8/9] PCI: dw-rockchip: Add system PM support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-8-ce2e1b0692d2@collabora.com>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4458;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=jdsx/CJd6cB/dQ3LDiSdUyMOVx1R7DaDMSkGxWQlgT0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW7wcyuiv0XPuiCdAAHbkyifQT2N6lRaQ
 VIZhBhdz2AZJYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVuAAoJENju1/PI
 O/qaYl0P/2cPDDR+IJUW/2rNJNtHOdWnyG22sL8U4HwYZhEH77BniEAuVQ3J4oleP46F4u2RUjT
 bPFGxWMD8/H3L8edsUbh5zgx/fFnrlH6rlflpZ2oe4WLVBcUb+6hJHvVhjdcrdTp0uYST9lGgc8
 g7Z0uKy0YGLtS+js4wOUbTQlmBzSPyPOKQULL59+ArfK/fY216cBXpT0bp3smzHXniF4kbJtiKf
 AU9Dg2kcH2NEglVsP61XaduwhDLLKbRmT0M+f/6Bdd/oGJaA8STKXJwDx8F0Xube0BI4xUeiULW
 ZLTSr/xwNVjsoT6yPHXMKQdw2ZHc1rhXP6EuHlI5wAddrCy4VMF56qFsWJOOPSvrK3RAP9pdwG1
 taYD1GoSUfFsQhC91v63Z2+L63lj5wzZ8TiQnXWxS4MRdVQyMVlY+6Otf5CZQttORXbK7Lyk1h9
 MAe85fD7vKyfXaWc/zzwHTAvFruiblI+mvlrILvzWZAtw3qp2SwIePndT/OTiYUTJPujShJtM1S
 +oEI6/fOSxKMii90bhCE2Jhcn4XthOKkoVAedtnhn3kqASsGmaH1VP8WKpoir8AQsah8pq1bKaZ
 GOe5xDwhcsDhHS/at8FJJMQ5dzcEd0qEWMSgdZ/eYnkv5O9MwuhMmwxq1Iyt+I+x1RHjNWBpZZy
 EBvgKpu61FCA/ynNvs0ArpQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add system PM support for Rockchip PCIe Designware Controllers.

I've tested this on the Rockchip RK3576 EVB1, the Radxa ROCK 4D
and the ArmSom Sige5 boards.

While I haven't experienced any issues, most of my tests have been done
without any devices attached (i.e. default board without any extras), so
there _might_ still be some problems. As system suspend does not work at
all right now, I think it makes sense to get at least the basic
configurations working as soon as possible as it will allow us to catch
regressions by enabling system suspend in CI systems like KernelCI.

Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 93 +++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d887513a63d6..cc917bb69c85 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -90,6 +90,7 @@ struct rockchip_pcie {
 	struct gpio_desc *rst_gpio;
 	struct regulator *vpcie3v3;
 	struct irq_domain *irq_domain;
+	u32 intx;
 	const struct rockchip_pcie_of_data *data;
 };
 
@@ -770,6 +771,92 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rockchip_pcie_suspend(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &rockchip->pci;
+	int ret;
+
+	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "suspend is not supported in EP mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
+
+	ret = dw_pcie_suspend_noirq(pci);
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+	rockchip_pcie_phy_deinit(rockchip);
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+	reset_control_assert(rockchip->rst);
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
+
+	return 0;
+}
+
+static int rockchip_pcie_resume(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &rockchip->pci;
+	int ret;
+
+	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "resume is not supported in EP mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	if (ret) {
+		dev_err(dev, "clock init failed: %d\n", ret);
+		return ret;
+	}
+
+	if (rockchip->vpcie3v3) {
+		ret = regulator_enable(rockchip->vpcie3v3);
+		if (ret)
+			goto err_disable_clk;
+	}
+
+	ret = rockchip_pcie_phy_init(rockchip);
+	if (ret) {
+		dev_err(dev, "phy init failed: %d\n", ret);
+		goto err_disable_regulator;
+	}
+
+	reset_control_deassert(rockchip->rst);
+
+	rockchip_pcie_writel_apb(rockchip, FIELD_PREP_WM16(0xffff, rockchip->intx),
+				 PCIE_CLIENT_INTR_MASK_LEGACY);
+
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
+	rockchip_pcie_unmask_dll_indicator(rockchip);
+
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
+
+	ret = dw_pcie_resume_noirq(pci);
+	if (ret) {
+		dev_err(dev, "failed to resume: %d\n", ret);
+		goto err_deinit_phy;
+	}
+
+	return 0;
+
+err_deinit_phy:
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+	rockchip_pcie_phy_deinit(rockchip);
+err_disable_regulator:
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
+err_disable_clk:
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+	return ret;
+}
+
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
 	.mode = DW_PCIE_RC_TYPE,
 };
@@ -800,11 +887,17 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
 	{},
 };
 
+static const struct dev_pm_ops rockchip_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend,
+				  rockchip_pcie_resume)
+};
+
 static struct platform_driver rockchip_pcie_driver = {
 	.driver = {
 		.name	= "rockchip-dw-pcie",
 		.of_match_table = rockchip_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &rockchip_pcie_pm_ops,
 	},
 	.probe = rockchip_pcie_probe,
 };

-- 
2.51.0


