Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4C4FDD3A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiDLLCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiDLLAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:00:03 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B0652DD;
        Tue, 12 Apr 2022 02:50:57 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id AD279C953C;
        Tue, 12 Apr 2022 09:41:04 +0000 (UTC)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D013B4000C;
        Tue, 12 Apr 2022 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649756456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLMGN8W4KzuVPgqbnvRFLH6IcEpJsrhI1QCKS4t1hsA=;
        b=CFoXbTCP8qW+mBf6EviV28hbHNhNM0yDmlj6OgshmaDq+VJ9fH6ho67hSEohJZ+NV6TmHG
        qTWY6scDoR7TI1uLaEPrNBnDbzPmN73e8J6n3yXX4Wk9WAbCmz3qof01Q5/pzrNOHHSmCb
        Tm7IxRiB6Z8qbySVOPAAKuSDsKjWt4sIjxw2XraM0Ogui2ot9tkwpzNXy7VWD+OlfChZqu
        dktUZ7ixvUHaa8h+YpZM2THvKJ024WAwDgEyB1w/UbDaXR3aH8daa81uNUPCtJndQrG7Ro
        apd6c270L+B4YIhG3+lcfiH/TLxQjKNsUKX+pf4q/n2Vkpl2uFc+5h0OPiGlkQ==
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
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/6] PCI: rcar-gen2: Add support for clocks
Date:   Tue, 12 Apr 2022 11:40:24 +0200
Message-Id: <20220412094029.287562-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412094029.287562-1-herve.codina@bootlin.com>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

