Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1102EACEF9
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2019 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfIHNnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Sep 2019 09:43:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40423 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfIHNnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Sep 2019 09:43:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id t9so11720053wmi.5
        for <linux-pci@vger.kernel.org>; Sun, 08 Sep 2019 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GfU3+s0+ry1VaN8+GjjuqfUgRel0oGwdsijTY+FcD+E=;
        b=nG6KyFZyzSd3lTnGM5OP0RP5rl1BXxFirerAxOlFlCgvkh9kgICw0TRsZNyrZG29rv
         U50N5G0BoU62C/44fOS/2xXU9rtB9fYAQWqPxvprWVYUVpRN+qqdcnldv4sOj4FHRts+
         Trz0KUu8QEiAdo9QNqxJ3X40hDGBW2E0pDWmNj3oZvQpwghUZA2SZAb4vrJ8T5S4nCdD
         wcgN+MLFNgeSK24EQk6mrM+2bGQaVn3uSJR1uZeJxFShK/X4MKZdBJMs8moCLhj7PXuH
         eLPQP1KEVSX+WZj+66OObsiGqJLAO3IPYgBqccEde9zB7MuyRFIXWb5JS5/ozFowccea
         kW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GfU3+s0+ry1VaN8+GjjuqfUgRel0oGwdsijTY+FcD+E=;
        b=BEXqTlC/tRUdxvaGhxQCWjkCM1XHdRbqbFZe+JD5suDQhj0AWDz8YFXJLCpeUynutS
         Bez7ahYt9jab5AwU/0mwaOjH9vQtauuCp2ciC/fL/9vIlNraZnNPK01v7vmPG73z01yf
         TqfaSEzROlUV2d4bcoKnkIz8ssg7GDTPjD1jVtYB/i7tn02d2nLizR5NAf5OofJggydF
         b5J4vQEAeLhDdDY85F3PcrWR2Nix5nA899gdqkZpdklvnb/wizh3ClYfI9FUjQ1a559I
         4ZAg36uZcRHs1QfJAzDfGmM2bTPFTrVL5qUrwkHlm4m7iWmsdkeuqyoGH2NnhP8sW9n2
         D0RA==
X-Gm-Message-State: APjAAAXVgmM25xgVP9TJdRBMxvxKQubGxW1A2uN/PEWPfwS+smOXZ3oZ
        VPat9bGy6N5jwzMEyRyzZHLgkg==
X-Google-Smtp-Source: APXvYqzndw8eyWZ7iSFESAG+kDNagu9LNZEB3kEthX6tLxpNMOHYN2mWWFFVMXcjejH6Fuzlt9wymA==
X-Received: by 2002:a1c:4082:: with SMTP id n124mr15773002wma.154.1567950188213;
        Sun, 08 Sep 2019 06:43:08 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id t203sm14313902wmf.42.2019.09.08.06.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 06:43:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] PCI: amlogic: meson: Add support for G12A
Date:   Sun,  8 Sep 2019 13:42:55 +0000
Message-Id: <1567950178-4466-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the Amlogic G12A SoC using a separate shared PHY.

This adds support for fetching a PHY phandle and call the PHY init,
reset and power on/off calls instead of writing in the PHY register or
toggling the PHY reset line.

The MIPI clock is also made optional since it is used for setting up
the PHY reference clock chared with the DSI controller on AXG.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 101 ++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index ab79990798f8..3fadad381762 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -16,6 +16,7 @@
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
+#include <linux/phy/phy.h>
 
 #include "pcie-designware.h"
 
@@ -96,12 +97,18 @@ struct meson_pcie_rc_reset {
 	struct reset_control *apb;
 };
 
+struct meson_pcie_param {
+	bool has_shared_phy;
+};
+
 struct meson_pcie {
 	struct dw_pcie pci;
 	struct meson_pcie_mem_res mem_res;
 	struct meson_pcie_clk_res clk_res;
 	struct meson_pcie_rc_reset mrst;
 	struct gpio_desc *reset_gpio;
+	struct phy *phy;
+	const struct meson_pcie_param *param;
 };
 
 static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
@@ -123,10 +130,12 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
 {
 	struct meson_pcie_rc_reset *mrst = &mp->mrst;
 
-	mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
-	if (IS_ERR(mrst->phy))
-		return PTR_ERR(mrst->phy);
-	reset_control_deassert(mrst->phy);
+	if (!mp->param->has_shared_phy) {
+		mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
+		if (IS_ERR(mrst->phy))
+			return PTR_ERR(mrst->phy);
+		reset_control_deassert(mrst->phy);
+	}
 
 	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
 	if (IS_ERR(mrst->port))
@@ -180,6 +189,9 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
 	if (IS_ERR(mp->mem_res.cfg_base))
 		return PTR_ERR(mp->mem_res.cfg_base);
 
+	if (mp->param->has_shared_phy)
+		return 0;
+
 	/* Meson SoC has two PCI controllers use same phy register*/
 	mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
 	if (IS_ERR(mp->mem_res.phy_base))
@@ -188,19 +200,33 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
 	return 0;
 }
 
-static void meson_pcie_power_on(struct meson_pcie *mp)
+static int meson_pcie_power_on(struct meson_pcie *mp)
 {
-	writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
+	int ret = 0;
+
+	if (mp->param->has_shared_phy)
+		ret = phy_power_on(mp->phy);
+	else
+		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
+
+	return ret;
 }
 
-static void meson_pcie_reset(struct meson_pcie *mp)
+static int meson_pcie_reset(struct meson_pcie *mp)
 {
 	struct meson_pcie_rc_reset *mrst = &mp->mrst;
-
-	reset_control_assert(mrst->phy);
-	udelay(PCIE_RESET_DELAY);
-	reset_control_deassert(mrst->phy);
-	udelay(PCIE_RESET_DELAY);
+	int ret = 0;
+
+	if (mp->param->has_shared_phy) {
+		ret = phy_reset(mp->phy);
+		if (ret)
+			return ret;
+	} else {
+		reset_control_assert(mrst->phy);
+		udelay(PCIE_RESET_DELAY);
+		reset_control_deassert(mrst->phy);
+		udelay(PCIE_RESET_DELAY);
+	}
 
 	reset_control_assert(mrst->port);
 	reset_control_assert(mrst->apb);
@@ -208,6 +234,8 @@ static void meson_pcie_reset(struct meson_pcie *mp)
 	reset_control_deassert(mrst->port);
 	reset_control_deassert(mrst->apb);
 	udelay(PCIE_RESET_DELAY);
+
+	return 0;
 }
 
 static inline struct clk *meson_pcie_probe_clock(struct device *dev,
@@ -250,9 +278,11 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 	if (IS_ERR(res->port_clk))
 		return PTR_ERR(res->port_clk);
 
-	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
-	if (IS_ERR(res->mipi_gate))
-		return PTR_ERR(res->mipi_gate);
+	if (!mp->param->has_shared_phy) {
+		res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
+		if (IS_ERR(res->mipi_gate))
+			return PTR_ERR(res->mipi_gate);
+	}
 
 	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
 	if (IS_ERR(res->general_clk))
@@ -524,6 +554,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 
 static int meson_pcie_probe(struct platform_device *pdev)
 {
+	const struct meson_pcie_param *match_data;
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct meson_pcie *mp;
@@ -537,6 +568,20 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
+	match_data = of_device_get_match_data(dev);
+	if (!match_data) {
+		dev_err(dev, "failed to get match data\n");
+		return -ENODEV;
+	}
+	mp->param = match_data;
+
+	if (mp->param->has_shared_phy) {
+		mp->phy = devm_phy_get(dev, "pcie");
+		if (IS_ERR(mp->phy)) {
+			return PTR_ERR(mp->phy);
+		}
+	}
+
 	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(mp->reset_gpio)) {
 		dev_err(dev, "get reset gpio failed\n");
@@ -555,8 +600,17 @@ static int meson_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	meson_pcie_power_on(mp);
-	meson_pcie_reset(mp);
+	ret = meson_pcie_power_on(mp);
+	if (ret) {
+		dev_err(dev, "phy power on failed, %d\n", ret);
+		return ret;
+	}
+
+	ret = meson_pcie_reset(mp);
+	if (ret) {
+		dev_err(dev, "reset failed, %d\n", ret);
+		return ret;
+	}
 
 	ret = meson_pcie_probe_clocks(mp);
 	if (ret) {
@@ -575,9 +629,22 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static struct meson_pcie_param meson_pcie_axg_param = {
+	.has_shared_phy = false,
+};
+
+static struct meson_pcie_param meson_pcie_g12a_param = {
+	.has_shared_phy = true,
+};
+
 static const struct of_device_id meson_pcie_of_match[] = {
 	{
 		.compatible = "amlogic,axg-pcie",
+		.data = &meson_pcie_axg_param,
+	},
+	{
+		.compatible = "amlogic,g12a-pcie",
+		.data = &meson_pcie_g12a_param,
 	},
 	{},
 };
-- 
2.17.1

