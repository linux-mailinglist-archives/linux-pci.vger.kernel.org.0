Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26352219094
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 21:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGHTcf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 15:32:35 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:60910 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgGHTcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 15:32:33 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id AD8A030C0C3;
        Wed,  8 Jul 2020 12:32:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com AD8A030C0C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1594236752;
        bh=iwvBHnllAMckovF6ltNCNQi+jMXHwnBrRf5LtKVSL+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0EKLcHQ5Z1R/ITr8Ih3nM8B1LZaI+ITi4KvYf3RWk95zPjHFGrPFrEcZcsNgWHqn
         ntbi0S0EIfREPyTNxs/KviXhZC6HXcDbqCQUJBiyYMI1gZqz5WeYnXOxpXo6lVWanP
         fGhgB7TNoTUHgOE7wOqjepHQ6wkWH+94pcZ2r+Mk=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 2E814140069;
        Wed,  8 Jul 2020 12:32:31 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 05/12] PCI: brcmstb: Add suspend and resume pm_ops
Date:   Wed,  8 Jul 2020 15:31:58 -0400
Message-Id: <20200708193219.47134-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708193219.47134-1-james.quinlan@broadcom.com>
References: <20200708193219.47134-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
and resume.  Now the PCIe driver may do so as well.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index b7a222fde3c4..7c148eb65170 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -979,6 +979,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
 }
 
+static int brcm_pcie_suspend(struct device *dev)
+{
+	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+
+	brcm_pcie_turn_off(pcie);
+	clk_disable_unprepare(pcie->clk);
+
+	return 0;
+}
+
+static int brcm_pcie_resume(struct device *dev)
+{
+	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	void __iomem *base;
+	u32 tmp;
+	int ret;
+
+	base = pcie->base;
+	clk_prepare_enable(pcie->clk);
+
+	/* Take bridge out of reset so we can access the SERDES reg */
+	brcm_pcie_bridge_sw_init_set(pcie, 0);
+
+	/* SERDES_IDDQ = 0 */
+	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
+	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+
+	/* wait for serdes to be stable */
+	udelay(100);
+
+	ret = brcm_pcie_setup(pcie);
+	if (ret)
+		return ret;
+
+	if (pcie->msi)
+		brcm_msi_set_regs(pcie->msi);
+
+	return 0;
+}
+
 static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 {
 	brcm_msi_remove(pcie);
@@ -1110,12 +1151,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, brcm_pcie_match);
 
+static const struct dev_pm_ops brcm_pcie_pm_ops = {
+	.suspend_noirq = brcm_pcie_suspend,
+	.resume_noirq = brcm_pcie_resume,
+};
+
 static struct platform_driver brcm_pcie_driver = {
 	.probe = brcm_pcie_probe,
 	.remove = brcm_pcie_remove,
 	.driver = {
 		.name = "brcm-pcie",
 		.of_match_table = brcm_pcie_match,
+		.pm = &brcm_pcie_pm_ops,
 	},
 };
 module_platform_driver(brcm_pcie_driver);
-- 
2.17.1

