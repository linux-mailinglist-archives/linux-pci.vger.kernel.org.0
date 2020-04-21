Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74E1B24C6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 13:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgDULRH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 07:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgDULRG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 07:17:06 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89011C061A41
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2020 04:17:05 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id B5ED014133A;
        Tue, 21 Apr 2020 13:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587467822; bh=FHxCFDkp1b+NmrHEooRA6+dYzOub0DEXhf+/oPuyPJY=;
        h=From:To:Date;
        b=rcu5kChIWjr0kC9IyqEJnYTfnmsTHfZIsUl5988Lr5JEnBL8dF6o5lZRuzbdAElCp
         1Xl/Dt6NnKl+U9Rgi0E5wVF+zmbgK3nqskth0ku/TdyKafF7yI+OVSBMwZHklGq9/b
         oR6PQ2l1VX7v2FgRgodjn1gxIouaiKpFiq9W7ltM=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v2 3/9] PCI: aardvark: improve link training
Date:   Tue, 21 Apr 2020 13:16:55 +0200
Message-Id: <20200421111701.17088-4-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421111701.17088-1-marek.behun@nic.cz>
References: <20200421111701.17088-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the aardvark driver trains link in PCIe gen2 mode. This may
cause some buggy gen 1 cards (such as Compex WLE900VX) to be unstable or
even not detected. Moreover when ASPM code tries to retrain link second
time, these cards may stop responding and link goes down. If gen1 is
used this does not happen.

Unconditionally forcing gen1 is not a good solution since it may have
performance impact on gen2 cards.

To overcome this, read 'max-link-speed' property (as defined in PCI
device tree bindings) and use this as max gen mode. Then iteratively try
link training at this mode or lower until successful. After successful
link training choose final controlled gen based on Negotiated Link Speed
from Link Status register, which should match card speed.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/pci-aardvark.c | 111 ++++++++++++++++++++------
 1 file changed, 86 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 551d98174613..606bae1e7a88 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -40,6 +40,7 @@
 #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
 #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
 #define     PCIE_CORE_LINK_TRAINING				BIT(5)
+#define     PCIE_CORE_LINK_SPEED_SHIFT				16
 #define     PCIE_CORE_LINK_WIDTH_SHIFT				20
 #define PCIE_CORE_ERR_CAPCTL_REG				0x118
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
@@ -201,6 +202,7 @@ struct advk_pcie {
 	struct mutex msi_used_lock;
 	u16 msi_msg;
 	int root_bus_nr;
+	int link_gen;
 	struct pci_bridge_emul bridge;
 };
 
@@ -225,20 +227,16 @@ static int advk_pcie_link_up(struct advk_pcie *pcie)
 
 static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
 {
-	struct device *dev = &pcie->pdev->dev;
 	int retries;
 
 	/* check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (advk_pcie_link_up(pcie)) {
-			dev_info(dev, "link up\n");
+		if (advk_pcie_link_up(pcie))
 			return 0;
-		}
 
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(dev, "link never came up\n");
 	return -ETIMEDOUT;
 }
 
@@ -253,6 +251,84 @@ static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
 	}
 }
 
+static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
+{
+	int ret, neg_gen;
+	u32 reg;
+
+	/* Setup link speed */
+	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg &= ~PCIE_GEN_SEL_MSK;
+	if (gen == 2)
+		reg |= SPEED_GEN_2;
+	else
+		reg |= SPEED_GEN_1;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+
+	/*
+	 * Enable link training. This is not needed in every call to this
+	 * function, just once suffices, but it does not break anything either.
+	 */
+	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg |= LINK_TRAINING_EN;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+
+	/*
+	 * Start link training immediately after enabling it. This solves
+	 * problems for some buggy cards.
+	 */
+	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
+	reg |= PCIE_CORE_LINK_TRAINING;
+	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
+
+	ret = advk_pcie_wait_for_link(pcie);
+	if (ret)
+		return ret;
+
+	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
+	neg_gen = (reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
+
+	return neg_gen;
+}
+
+static void advk_pcie_train_link(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	int neg_gen = -1, gen;
+
+	/*
+	 * Try link training at link gen specified by device tree property
+	 * 'max-link-speed' (defaults to 2, since this controller does not
+	 * support higher gen). If this fails, iteratively train at lower gen.
+	 */
+	for (gen = pcie->link_gen; gen > 0; --gen) {
+		neg_gen = advk_pcie_train_at_gen(pcie, gen);
+		if (neg_gen > 0)
+			break;
+	}
+
+	if (neg_gen < 0)
+		goto err;
+
+	/*
+	 * After successful training if negotiated gen is lower than requested,
+	 * train again on negotiated gen. This solves some stability issues for
+	 * some buggy gen1 cards.
+	 */
+	if (neg_gen < gen) {
+		gen = neg_gen;
+		neg_gen = advk_pcie_train_at_gen(pcie, gen);
+	}
+
+	if (neg_gen == gen) {
+		dev_info(dev, "link up at gen %i\n", gen);
+		return;
+	}
+
+err:
+	dev_err(dev, "link never came up\n");
+}
+
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
@@ -288,12 +364,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
-	/* Set GEN2 */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-	reg &= ~PCIE_GEN_SEL_MSK;
-	reg |= SPEED_GEN_2;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
-
 	/* Set lane X1 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~LANE_CNT_MSK;
@@ -341,20 +411,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	 */
 	msleep(PCI_PM_D3COLD_WAIT);
 
-	/* Enable link training */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-	reg |= LINK_TRAINING_EN;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
-
-	/*
-	 * Start link training immediately after enabling it. This solves
-	 * problems for some buggy cards.
-	 */
-	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
-	reg |= PCIE_CORE_LINK_TRAINING;
-	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
-
-	advk_pcie_wait_for_link(pcie);
+	advk_pcie_train_link(pcie);
 
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
@@ -988,6 +1045,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	}
 	pcie->root_bus_nr = bus->start;
 
+	pcie->link_gen = of_pci_get_max_link_speed(dev->of_node);
+	if (pcie->link_gen < 1 || pcie->link_gen > 2)
+		pcie->link_gen = 2;
+
 	advk_pcie_setup_hw(pcie);
 
 	advk_sw_pci_bridge_init(pcie);
-- 
2.24.1

