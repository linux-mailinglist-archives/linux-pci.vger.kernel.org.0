Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B378523EBE
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiEKUTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbiEKUTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C93238D64
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5996261ABC
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 20:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E75AC34100;
        Wed, 11 May 2022 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652300349;
        bh=O9vXyBkgjhKGytiLDz8Po4yJ0qkZZ2JEoGMTus1K/jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgZ0k6TliYjcvSTtp2OtgL33LCI0q2Ix5+mgpG2Kj55Is/keyVU0FQ8VvzIX8m9NL
         W/3rKvPXXIeDakPOK4iU0/iMrz8/2tsTRhxqzmRc9sa1QXJK6WsfhMcd+gzbvAbtd7
         II6nFcvQX0l4EsjZ6bB7rWFS1QjGeUXxmvGbYG1N+XXJcjxLGcdhzdy4sV7DAMUr+J
         nNHIiXAlKIQwHVjSKRWDH6bAr1BhH9jmU/EDYYmGUAXXhhWAFAiLftVcxTMpkZhRQJ
         wQIp0mediek2FYGJtiS/dRMKhE374IdOCwYpWGLL6bhvRo3xtyAfH0ZYdOC5MYGxTl
         gyDdLfUif2BLg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/4] Revert "PCI: brcmstb: Add control of subdevice voltage regulators"
Date:   Wed, 11 May 2022 15:18:54 -0500
Message-Id: <20220511201856.808690-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511201856.808690-1-helgaas@kernel.org>
References: <20220511201856.808690-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 93e41f3fca3d4a0f927b784012338c37f80a8a80.

This is part of a revert of the following commits:

  11ed8b8624b8 ("PCI: brcmstb: Do not turn off WOL regulators on suspend")
  93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
  67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev regulators")
  830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")

Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
into two funcs"), which appeared in v5.17-rc1, broke booting on the
Raspberry Pi Compute Module 4.  Apparently 830aa6f29f07 panics with an
Asynchronous SError Interrupt, and after further commits here is a black
screen on HDMI and no output on the serial console.

This does not seem to affect the Raspberry Pi 4 B.

Reported-by: Cyril Brulebois <kibi@debian.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215925
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 83 ++-------------------------
 1 file changed, 5 insertions(+), 78 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 3edd63735948..fd464d38fecb 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -196,8 +196,6 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
-static int brcm_pcie_linkup(struct brcm_pcie *pcie);
-static int brcm_pcie_add_bus(struct pci_bus *bus);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -331,8 +329,6 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
-	bool			refusal_mode;
-	struct subdev_regulators *sr;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -501,34 +497,6 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 	return 0;
 }
 
-static int brcm_pcie_add_bus(struct pci_bus *bus)
-{
-	struct device *dev = &bus->dev;
-	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
-	int ret;
-
-	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
-		return 0;
-
-	ret = pci_subdev_regulators_add_bus(bus);
-	if (ret)
-		return ret;
-
-	/* Grab the regulators for suspend/resume */
-	pcie->sr = bus->dev.driver_data;
-
-	/*
-	 * If we have failed linkup there is no point to return an error as
-	 * currently it will cause a WARNING() from pci_alloc_child_bus().
-	 * We return 0 and turn on the "refusal_mode" so that any further
-	 * accesses to the pci_dev just get 0xffffffff
-	 */
-	if (brcm_pcie_linkup(pcie) != 0)
-		pcie->refusal_mode = true;
-
-	return 0;
-}
-
 static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
 {
 	struct device *dev = &bus->dev;
@@ -857,18 +825,6 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	/* Accesses to the RC go right to the RC registers if slot==0 */
 	if (pci_is_root_bus(bus))
 		return PCI_SLOT(devfn) ? NULL : base + where;
-	if (pcie->refusal_mode) {
-		/*
-		 * At this point we do not have link.  There will be a CPU
-		 * abort -- a quirk with this controller --if Linux tries
-		 * to read any config-space registers besides those
-		 * targeting the host bridge.  To prevent this we hijack
-		 * the address to point to a safe access that will return
-		 * 0xffffffff.
-		 */
-		writel(0xffffffff, base + PCIE_MISC_RC_BAR2_CONFIG_HI);
-		return base + PCIE_MISC_RC_BAR2_CONFIG_HI + (where & 0x3);
-	}
 
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
@@ -897,7 +853,7 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = brcm_pcie_add_bus,
+	.add_bus = pci_subdev_regulators_add_bus,
 	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
@@ -1370,14 +1326,6 @@ static int brcm_pcie_suspend(struct device *dev)
 		return ret;
 	}
 
-	if (pcie->sr) {
-		ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn off regulators\n");
-			reset_control_reset(pcie->rescal);
-			return ret;
-		}
-	}
 	clk_disable_unprepare(pcie->clk);
 
 	return 0;
@@ -1395,17 +1343,9 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (pcie->sr) {
-		ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn on regulators\n");
-			goto err_disable_clk;
-		}
-	}
-
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
-		goto err_regulator;
+		goto err_disable_clk;
 
 	ret = brcm_phy_start(pcie);
 	if (ret)
@@ -1437,9 +1377,6 @@ static int brcm_pcie_resume(struct device *dev)
 
 err_reset:
 	reset_control_rearm(pcie->rescal);
-err_regulator:
-	if (pcie->sr)
-		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
@@ -1571,17 +1508,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	ret = pci_host_probe(bridge);
-	if (!ret && !brcm_pcie_link_up(pcie))
-		ret = -ENODEV;
-
-	if (ret) {
-		brcm_pcie_remove(pdev);
-		return ret;
-	}
-
-	return 0;
-
+	return pci_host_probe(bridge);
 fail:
 	__brcm_pcie_remove(pcie);
 	return ret;
@@ -1590,8 +1517,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 MODULE_DEVICE_TABLE(of, brcm_pcie_match);
 
 static const struct dev_pm_ops brcm_pcie_pm_ops = {
-	.suspend_noirq = brcm_pcie_suspend,
-	.resume_noirq = brcm_pcie_resume,
+	.suspend = brcm_pcie_suspend,
+	.resume = brcm_pcie_resume,
 };
 
 static struct platform_driver brcm_pcie_driver = {
-- 
2.25.1

