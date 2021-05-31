Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE593957B2
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhEaJBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 05:01:36 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60810 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230257AbhEaJBd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 05:01:33 -0400
Received: from [77.244.183.192] (port=63376 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lndm4-0005h2-Np; Mon, 31 May 2021 10:59:52 +0200
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
Subject: [PATCH v2 4/4] PCI: dra7xx: Get an optional clock
Date:   Mon, 31 May 2021 10:59:34 +0200
Message-Id: <20210531085934.2662457-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531085934.2662457-1-luca@lucaceresoli.net>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
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

Changes v1 -> v2:
 - Update commit subject as suggested by Bjorn
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index a8daa356f7e6..11f392b7a9a2 100644
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
 
@@ -745,6 +747,15 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
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
@@ -932,6 +943,8 @@ static void dra7xx_pcie_shutdown(struct platform_device *pdev)
 
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
+
+	clk_disable_unprepare(dra7xx->clk);
 }
 
 static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
-- 
2.25.1

