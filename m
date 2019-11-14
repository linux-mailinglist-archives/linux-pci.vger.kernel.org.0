Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9BFC662
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 13:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKNMee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 07:34:34 -0500
Received: from condef-10.nifty.com ([202.248.20.75]:62562 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNMee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2019 07:34:34 -0500
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-10.nifty.com with ESMTP id xAECSBSA001602
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2019 21:28:11 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xAECR7jJ000853;
        Thu, 14 Nov 2019 21:27:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xAECR7jJ000853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573734429;
        bh=9TSKJqihdLxzzA14xKVF4zpxiUSO4ACCxImJ7e5ZBeo=;
        h=From:To:Cc:Subject:Date:From;
        b=nyXT2As5MHTHfqOrIp9o1kyhAFrBnQrqX5MU4L6ulbeKtAcvXGHIwUFS2rrI1jXaP
         HmYp4HnnM0gvS17ztD+LbBjQvcITVD4UVpQP0uCRR2bY+hU/wcQ4ytbkH+vFoPnzuK
         D84XJUweb6v3K5ybcZjKJ56SDHMezOrtTlPha1xPjCXih7x2lkehI1qehcL7ttskvx
         yt/8uHbqa4GRgC79VmmgBtwkSfdWO05FNogy/ll/PR0v4r+PUfle2g4vSPtF7hQ2CM
         o+gQLe3+kwd2Vc0ZDMWOP20qH6MbLpU0+JB0m+EfndVxCLbTCOo+ytkHSJUIr9hs9y
         dJEJHy8Ce5pww==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: uniphier: remove module code from built-in driver
Date:   Thu, 14 Nov 2019 21:26:54 +0900
Message-Id: <20191114122654.1490-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

builtin_platform_driver() and MODULE_* are always odd combination.

The MODULE_* tags are never populated since CONFIG_PCIE_UNIPHIER is
a bool option.

You can see similar cleanups by:
  git log --grep='explicitly non-modular'

Following those commits, remove all the MODULE_* tags and the driver
detach code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---

 drivers/pci/controller/dwc/pcie-uniphier.c | 31 +---------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 3f30ee4a00b3..8c92b660a0f6 100644
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
@@ -161,12 +161,6 @@ static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
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
@@ -387,14 +381,6 @@ static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
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
@@ -446,31 +432,16 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
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

