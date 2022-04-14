Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5F50072B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbiDNHnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiDNHmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:42:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277940931;
        Thu, 14 Apr 2022 00:40:26 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E6CC01C0015;
        Thu, 14 Apr 2022 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649922025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLMGN8W4KzuVPgqbnvRFLH6IcEpJsrhI1QCKS4t1hsA=;
        b=EmAxXWkw4b+7SoVMA9NWRxnSwWeu8qw/PIJHX0OZ/TNgQHMimmtL2oZ1i0BcgJvhconYaB
        bP/jD8JqfjWZTYq3rfZtEbd24xiekZ6NjVW9XvvJCdCTa4SXn+yJW/YikZejDibVM2tag7
        A2bH/YdXxW5VQH9BNA1ytZ7r7ToUoMFTjHc9LEaj3aMjGx6IljT7LKoPdHgFSzDUwajti0
        hf5TP4nqWzAGEXCsKfZZxMR6mBWavlnle454weujPXKlubPCCRSR9SoonQMKUbYNNpPq1Y
        xKKZdU1MgDA3RfqEj+WbIgVkL7g726Qn3//M8LyyfiBf5dQ17TQLdV8TT2QXAg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 1/8] PCI: rcar-gen2: Add support for clocks
Date:   Thu, 14 Apr 2022 09:40:04 +0200
Message-Id: <20220414074011.500533-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414074011.500533-1-herve.codina@bootlin.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI rcar-gen2 does not call any clk_prepare_enable().
This lead to an access failure when the driver tries to access
the IP (at least on a RZ/N1D platform).

Prepare and enable clocks using the bulk version of
clk_prepare_enable() in order to prepare and enable all clocks
attached to this device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/controller/pci-rcar-gen2.c | 28 ++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 35804ea394fd..528bc3780e01 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -8,6 +8,7 @@
  * Author: Valentine Barshak <valentine.barshak@cogentembedded.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -99,6 +100,8 @@ struct rcar_pci {
 	struct resource mem_res;
 	struct resource *cfg_res;
 	int irq;
+	struct clk_bulk_data *clocks;
+	int nclocks;
 };
 
 /* PCI configuration space operations */
@@ -282,6 +285,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	struct rcar_pci *priv;
 	struct pci_host_bridge *bridge;
 	void __iomem *reg;
+	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
 	if (!bridge)
@@ -305,13 +309,25 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	priv->mem_res = *mem_res;
 	priv->cfg_res = cfg_res;
 
+	ret = devm_clk_bulk_get_all(dev, &priv->clocks);
+	if (ret < 0) {
+		dev_err(dev, "failed to get clocks %d\n", ret);
+		return ret;
+	}
+	priv->nclocks = ret;
+
+	ret = clk_bulk_prepare_enable(priv->nclocks, priv->clocks);
+	if (ret)
+		return ret;
+
 	priv->irq = platform_get_irq(pdev, 0);
 	priv->reg = reg;
 	priv->dev = dev;
 
 	if (priv->irq < 0) {
 		dev_err(dev, "no valid irq found\n");
-		return priv->irq;
+		ret = priv->irq;
+		goto disable_clocks;
 	}
 
 	bridge->ops = &rcar_pci_ops;
@@ -320,7 +336,15 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	rcar_pci_setup(priv);
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret < 0)
+		goto disable_clocks;
+
+	return 0;
+
+disable_clocks:
+	clk_bulk_disable_unprepare(priv->nclocks, priv->clocks);
+	return ret;
 }
 
 static const struct of_device_id rcar_pci_of_match[] = {
-- 
2.35.1

