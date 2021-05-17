Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA283837E3
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbhEQPrU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 11:47:20 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:47636 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344190AbhEQPm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 11:42:56 -0400
Received: from [77.244.183.192] (port=64722 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lifNC-000Exi-Ly; Mon, 17 May 2021 17:41:38 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pci@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 5/5] PCI: dwc: pci-dra7xx: get an optional clock
Date:   Mon, 17 May 2021 17:41:22 +0200
Message-Id: <20210517154122.430544-6-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517154122.430544-1-luca@lucaceresoli.net>
References: <20210517154122.430544-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the clock is provided externally we need to make sure it is enabled
before starting PCI scan.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 05d06806c300..8dd20b394d0c 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -7,6 +7,7 @@
  * Authors: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -90,6 +91,7 @@ struct dra7xx_pcie {
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
 	struct irq_domain	*irq_domain;
+	struct clk              *clk;
 	enum dw_pcie_device_mode mode;
 };
 
@@ -744,6 +746,15 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!link)
 		return -ENOMEM;
 
+	dra7xx->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(dra7xx->clk))
+		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
+				     "clock request failed");
+
+	ret = clk_prepare_enable(dra7xx->clk);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
@@ -931,6 +942,8 @@ static void dra7xx_pcie_shutdown(struct platform_device *pdev)
 
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
+
+	clk_disable_unprepare(dra7xx->clk);
 }
 
 static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
-- 
2.25.1

