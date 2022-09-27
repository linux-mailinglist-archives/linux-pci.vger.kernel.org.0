Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621245EC5D4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiI0OUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiI0OTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C8B9E2EC
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01519619D9
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD86C43470;
        Tue, 27 Sep 2022 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288381;
        bh=YOHpPreByGGoyZO9gaJvQCWGWwT25levFv1BixvDFn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2garZzaK4Pg6GrBqg5oZs3ujiWgC77GzEjxlYtYv4KH5CNh+h9NYIgN8kn41yeTY
         qmRAHheaUVC4fMIMMVY9QjuD5bDDlfEvrqKZZTYaHfD4R9ANGiViR2KnT5YNII8zvU
         iQcLt/jOr788Ym8oCHtOG4dlhgIgocKg5Icknv0Ou1cuC31UpY3uOSBbYCxUuQpgz9
         jlolo890KePtLoF0cMLRBnkUioT8dhzStuMQm75+ZeZrPK7SnXTfP7DWGbh890Zz5f
         t4VuJ+JtyVgoq4sGccG7wN0VaPx2CBt/ghDGJThinNb57oRHukNOu3cCv7I3Chhnt0
         WTAa8MNqq3VFQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 05/10] PCI: aardvark: Add clock support
Date:   Tue, 27 Sep 2022 16:19:21 +0200
Message-Id: <20220927141926.8895-6-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927141926.8895-1-kabel@kernel.org>
References: <20220927141926.8895-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The IP relies on a gated clock. When we will add S2RAM support, this
clock will need to be resumed before any PCIe registers are
accessed. Add support for this clock.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 03e318bc171f..3beafc893969 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -297,6 +298,7 @@ struct advk_pcie {
 	struct timer_list link_irq_timer;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
+	struct clk *clk;
 	struct phy *phy;
 };
 
@@ -1809,6 +1811,29 @@ static int advk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		return of_irq_parse_and_map_pci(dev, slot, pin);
 }
 
+static int advk_pcie_setup_clk(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	int ret;
+
+	pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk) && (PTR_ERR(pcie->clk) == -EPROBE_DEFER))
+		return PTR_ERR(pcie->clk);
+
+	/* Old bindings miss the clock handle */
+	if (IS_ERR(pcie->clk)) {
+		dev_warn(dev, "Clock unavailable (%ld)\n", PTR_ERR(pcie->clk));
+		pcie->clk = NULL;
+		return 0;
+	}
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		dev_err(dev, "Clock initialization failed (%d)\n", ret);
+
+	return ret;
+}
+
 static void advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
@@ -2000,6 +2025,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 			 slot_power_limit / 1000,
 			 (slot_power_limit / 100) % 10);
 
+	ret = advk_pcie_setup_clk(pcie);
+	if (ret)
+		return ret;
+
 	ret = advk_pcie_setup_phy(pcie);
 	if (ret)
 		return ret;
@@ -2122,6 +2151,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	/* Disable phy */
 	advk_pcie_disable_phy(pcie);
 
+	/* Disable clock */
+	clk_disable_unprepare(pcie->clk);
+
 	return 0;
 }
 
-- 
2.35.1

