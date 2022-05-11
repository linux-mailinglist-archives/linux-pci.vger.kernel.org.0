Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30580523EC3
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347724AbiEKUTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbiEKUTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:19:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27A23886F
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E3D9B8261D
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 20:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8AFC340EE;
        Wed, 11 May 2022 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652300347;
        bh=Sa6T7LJBhi/czZnpS9eUTgTxfQvG/2aw6fcm3/6bZ7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hk9xxwVW8+JjlYQz8xHt0o3jbpEFr38s6d+wecHaaKU6p1/f5Jr60mlL7kZQu5cpP
         n/UZlfg/btcIoRPlYrqMifg2/gM+iNFbxYdFa1uJr78Xe3stYYBRIrOQ3nQZWPiupM
         5+FvO0W6pRwCHhV85H4S9vc3JuJfSmju8hu8A+JB4mNPSVPJlTk7GiEjOJb1zjVrgP
         dup+MqjB4EsMCwBOPxN0vo0FaZ4tTm541Fb1QN2nO5JsoB5pt6IYD9jLlU2K+QO3RH
         b+taJ8RnN7yS+/CfHYZph2nTOhe1KlZ/kdZmQpMXpmPYxXp/fBRAcf427uLfNQsDut
         xSlSfQTMEtJuQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/4] Revert "PCI: brcmstb: Do not turn off WOL regulators on suspend"
Date:   Wed, 11 May 2022 15:18:53 -0500
Message-Id: <20220511201856.808690-2-helgaas@kernel.org>
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

This reverts commit 11ed8b8624b8085f706864b4addcd304b1e4fc38.

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
 drivers/pci/controller/pcie-brcmstb.c | 53 +++++----------------------
 1 file changed, 9 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 375c0c40bbf8..3edd63735948 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -333,7 +333,6 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	bool			refusal_mode;
 	struct subdev_regulators *sr;
-	bool			ep_wakeup_capable;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1351,21 +1350,9 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
-static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
-{
-	bool *ret = data;
-
-	if (device_may_wakeup(&dev->dev)) {
-		*ret = true;
-		dev_info(&dev->dev, "disable cancelled for wake-up device\n");
-	}
-	return (int) *ret;
-}
-
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
 	brcm_pcie_turn_off(pcie);
@@ -1384,22 +1371,11 @@ static int brcm_pcie_suspend(struct device *dev)
 	}
 
 	if (pcie->sr) {
-		/*
-		 * Now turn off the regulators, but if at least one
-		 * downstream device is enabled as a wake-up source, do not
-		 * turn off regulators.
-		 */
-		pcie->ep_wakeup_capable = false;
-		pci_walk_bus(bridge->bus, pci_dev_may_wakeup,
-			     &pcie->ep_wakeup_capable);
-		if (!pcie->ep_wakeup_capable) {
-			ret = regulator_bulk_disable(pcie->sr->num_supplies,
-						     pcie->sr->supplies);
-			if (ret) {
-				dev_err(dev, "Could not turn off regulators\n");
-				reset_control_reset(pcie->rescal);
-				return ret;
-			}
+		ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
+		if (ret) {
+			dev_err(dev, "Could not turn off regulators\n");
+			reset_control_reset(pcie->rescal);
+			return ret;
 		}
 	}
 	clk_disable_unprepare(pcie->clk);
@@ -1420,21 +1396,10 @@ static int brcm_pcie_resume(struct device *dev)
 		return ret;
 
 	if (pcie->sr) {
-		if (pcie->ep_wakeup_capable) {
-			/*
-			 * We are resuming from a suspend.  In the suspend we
-			 * did not disable the power supplies, so there is
-			 * no need to enable them (and falsely increase their
-			 * usage count).
-			 */
-			pcie->ep_wakeup_capable = false;
-		} else {
-			ret = regulator_bulk_enable(pcie->sr->num_supplies,
-						    pcie->sr->supplies);
-			if (ret) {
-				dev_err(dev, "Could not turn on regulators\n");
-				goto err_disable_clk;
-			}
+		ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
+		if (ret) {
+			dev_err(dev, "Could not turn on regulators\n");
+			goto err_disable_clk;
 		}
 	}
 
-- 
2.25.1

