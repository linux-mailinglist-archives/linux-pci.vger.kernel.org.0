Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1426F6A15
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEDLfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjEDLfV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:35:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714FA448F;
        Thu,  4 May 2023 04:35:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 814F966056D2;
        Thu,  4 May 2023 12:35:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683200118;
        bh=lNz84nkQPkKr7TAz+egLElMi8V+budLVrygOS7c2k94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sq9Gg07A2+ggbFLIA2eh0yDroW+O7rNKaLQTrhpuhVgPfdsgC2GGb5nlNTUFZrf4Y
         RW5Bsn91z2/l7+bd6kxQRU/3YjMczFDwim5t4RKVaJIB6s7TZkJg82b/fIDMR8vWms
         iPL2epMOl1nVgJ8dX4MA+SgbENgspRuUvZvWsVqhTGVaSlYAw2D+aa+x3BmNf6gqTw
         fNDEsNYix78N1x2Ns8guR6k+3cB4jZ+8ZvvRU+gOzGfB32NrrrqFEhnzrvX9IGamj+
         Icoi2cuhLYeprWoCyLi759E/eYB28LWHmSQCZ9zzRwxkQVWWJJn0qa/rf6gto0aDmA
         P7Uxg+/ISHT2A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     ryder.lee@mediatek.com
Cc:     jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] PCI: mediatek-gen3: Assert MAC reset only if PHY reset also present
Date:   Thu,  4 May 2023 13:35:09 +0200
Message-Id: <20230504113509.184633-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
References: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some SoCs have two PCI-Express controllers: in the case of MT8195,
one of them is using a dedicated PHY, but the other uses a combo PHY
that is shared with USB and in that case the PHY cannot be reset
from the PCIe driver, or USB functionality will be unable to resume.

Resetting the PCIe MAC without also resetting the PHY will result in
a full system lockup at PCIe resume time and the only option to
resume operation is to hard reboot the system (with a PMIC cut-off).

To resolve this issue, check if we've got both a PHY and a MAC reset
and, if not, never assert resets at PM suspend time: in that case,
the link is still getting powered down as both the clocks and the
power domains will go down anyway.

Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 52f52ca5db71..480621ca1450 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -859,17 +859,26 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	return err;
 }
 
-static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
+static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool is_suspend)
 {
+	bool suspend_reset_supported = pcie->mac_reset && pcie->phy_reset;
+
 	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	pm_runtime_put_sync(pcie->dev);
 	pm_runtime_disable(pcie->dev);
-	reset_control_assert(pcie->mac_reset);
+
+	/*
+	 * Assert MAC reset only if we also got a PHY reset, otherwise
+	 * the system will lockup at PM resume time.
+	 */
+	if (is_suspend && suspend_reset_supported)
+		reset_control_assert(pcie->mac_reset);
 
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
-	reset_control_assert(pcie->phy_reset);
+	if (is_suspend && suspend_reset_supported)
+		reset_control_assert(pcie->phy_reset);
 }
 
 static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
@@ -905,7 +914,7 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	return 0;
 
 err_setup:
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, false);
 
 	return err;
 }
@@ -936,7 +945,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	err = pci_host_probe(host);
 	if (err) {
 		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
+		mtk_pcie_power_down(pcie, false);
 		return err;
 	}
 
@@ -954,7 +963,7 @@ static int mtk_pcie_remove(struct platform_device *pdev)
 	pci_unlock_rescan_remove();
 
 	mtk_pcie_irq_teardown(pcie);
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, false);
 
 	return 0;
 }
@@ -1023,7 +1032,7 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 	dev_dbg(pcie->dev, "entered L2 states successfully");
 
 	mtk_pcie_irq_save(pcie);
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, true);
 
 	return 0;
 }
@@ -1039,7 +1048,7 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 
 	err = mtk_pcie_startup_port(pcie);
 	if (err) {
-		mtk_pcie_power_down(pcie);
+		mtk_pcie_power_down(pcie, false);
 		return err;
 	}
 
-- 
2.40.1

