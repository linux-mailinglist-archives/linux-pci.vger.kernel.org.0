Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C760E11FBB6
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2019 23:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOWvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Dec 2019 17:51:52 -0500
Received: from condef-04.nifty.com ([202.248.20.69]:40596 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOWvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2019 17:51:52 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 17:51:50 EST
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-04.nifty.com with ESMTP id xBFMet4j014289
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2019 07:40:55 +0900
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xBFMdess006397;
        Mon, 16 Dec 2019 07:39:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xBFMdess006397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576449581;
        bh=i0oU5g5CjQIetP14HFEjJsItIoa4W1ipl4ajrjt0JKk=;
        h=From:To:Cc:Subject:Date:From;
        b=kzgaCKL2ZBe8y8oSOUSe9RJ0JB6GmD83VGhv9bWLKotEPGtum7t/5vwW+zi5G63Ap
         cIkIL9qPJQIqI2aL5+Pyz978Qb2bdtuDRUzISectClQsvBU5DGxzy7gY9eDPqXJLo+
         pqaW+vC0eREcMFcGvWlpmyX1RL1YtMbpjBvd7WCV9Py0se/dy1WvSNm27epozcJ4nf
         qNzxbJHV2osBRhuSF7ultgfZEknKJAOKG0WGx26M+p7lUy+hI/ETa6nz7TzwPraTlU
         q8YObApL6Ko82u/QaHZzd2/3bQrh9ug+pL3REntcZpGj8202ccXoSsgE2Sy3rFrW+Y
         LX2E2jLs05rDQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: uniphier: remove module code from built-in driver
Date:   Mon, 16 Dec 2019 07:39:37 +0900
Message-Id: <20191215223937.19619-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

builtin_platform_driver() and MODULE_* are always odd combination.

This file is not compiled as a module by anyone because
CONFIG_PCIE_UNIPHIER is a bool option.

Let's remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove" code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - update commit description
  - remove Reviewed-by

 drivers/pci/controller/dwc/pcie-uniphier.c | 31 +---------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 8fd7badd59c2..a5401a0b1e58 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -9,11 +9,11 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
@@ -171,12 +171,6 @@ static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
 	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
 }
 
-static void uniphier_pcie_irq_disable(struct uniphier_pcie_priv *priv)
-{
-	writel(0, priv->base + PCL_RCV_INT);
-	writel(0, priv->base + PCL_RCV_INTX);
-}
-
 static void uniphier_pcie_irq_ack(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
@@ -397,14 +391,6 @@ static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
 	return ret;
 }
 
-static void uniphier_pcie_host_disable(struct uniphier_pcie_priv *priv)
-{
-	uniphier_pcie_irq_disable(priv);
-	phy_exit(priv->phy);
-	reset_control_assert(priv->rst);
-	clk_disable_unprepare(priv->clk);
-}
-
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = uniphier_pcie_establish_link,
 	.stop_link = uniphier_pcie_stop_link,
@@ -456,31 +442,16 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
 	return uniphier_add_pcie_port(priv, pdev);
 }
 
-static int uniphier_pcie_remove(struct platform_device *pdev)
-{
-	struct uniphier_pcie_priv *priv = platform_get_drvdata(pdev);
-
-	uniphier_pcie_host_disable(priv);
-
-	return 0;
-}
-
 static const struct of_device_id uniphier_pcie_match[] = {
 	{ .compatible = "socionext,uniphier-pcie", },
 	{ /* sentinel */ },
 };
-MODULE_DEVICE_TABLE(of, uniphier_pcie_match);
 
 static struct platform_driver uniphier_pcie_driver = {
 	.probe  = uniphier_pcie_probe,
-	.remove = uniphier_pcie_remove,
 	.driver = {
 		.name = "uniphier-pcie",
 		.of_match_table = uniphier_pcie_match,
 	},
 };
 builtin_platform_driver(uniphier_pcie_driver);
-
-MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
-MODULE_DESCRIPTION("UniPhier PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
-- 
2.17.1

