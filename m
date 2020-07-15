Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665A4220F2A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgGOO0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 10:26:11 -0400
Received: from mail.nic.cz ([217.31.204.67]:34942 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgGOO0C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 10:26:02 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id C1379140A65;
        Wed, 15 Jul 2020 16:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594823158; bh=nerKxigHkObaiHyzNmlG4HvrbXZtheySdo4ELo3MtiU=;
        h=From:To:Date;
        b=RiKFvyZeKuolRbIZ6r+QCzpKswnOUAAVlUxo/xEZt5U21d6Vv/0XenaIaOSatf+fz
         RoRbs3+oj74UxucsV/ZqHpb1V3jJmAGWF3O/mFgZHx4CExSrvcoOjf/vYFJECPJmYH
         3TW98AiC/tzPomO2p7a0XzSygyWS/V0ozDX4raMQ=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 5/5] PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()
Date:   Wed, 15 Jul 2020 16:25:57 +0200
Message-Id: <20200715142557.17115-6-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715142557.17115-1-marek.behun@nic.cz>
References: <20200715142557.17115-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Move code which belongs to link training (delays and resets) into
advk_pcie_train_link() function, so everything related to link training,
including timings is at one place.

After experiments it can be observed that link training in aardvark
hardware is very sensitive to timings and delays, so it is a good idea to
have this code at the same place as link training calls.

This patch does not change behavior of aardvark initialization.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/pci-aardvark.c | 64 ++++++++++++++-------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 0a5aa6d77f5d..ab39b01474e8 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -253,6 +253,25 @@ static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
 	}
 }
 
+static void advk_pcie_issue_perst(struct advk_pcie *pcie)
+{
+	u32 reg;
+
+	if (!pcie->reset_gpio)
+		return;
+
+	/* PERST does not work for some cards when link training is enabled */
+	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg &= ~LINK_TRAINING_EN;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+
+	/* 10ms delay is needed for some cards */
+	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
+	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+}
+
 static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
 {
 	int ret, neg_gen;
@@ -300,6 +319,21 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	int neg_gen = -1, gen;
 
+	/*
+	 * Reset PCIe card via PERST# signal. Some cards are not detected
+	 * during link training when they are in some non-initial state.
+	 */
+	advk_pcie_issue_perst(pcie);
+
+	/*
+	 * PERST# signal could have been asserted by pinctrl subsystem before
+	 * probe() callback has been called or issued explicitly by reset gpio
+	 * function advk_pcie_issue_perst(), making the endpoint going into
+	 * fundamental reset. As required by PCI Express spec a delay for at
+	 * least 100ms after such a reset before link training is needed.
+	 */
+	msleep(PCI_PM_D3COLD_WAIT);
+
 	/*
 	 * Try link training at link gen specified by device tree property
 	 * 'max-link-speed'. If this fails, iteratively train at lower gen.
@@ -332,31 +366,10 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
 	dev_err(dev, "link never came up\n");
 }
 
-static void advk_pcie_issue_perst(struct advk_pcie *pcie)
-{
-	u32 reg;
-
-	if (!pcie->reset_gpio)
-		return;
-
-	/* PERST does not work for some cards when link training is enabled */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-	reg &= ~LINK_TRAINING_EN;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
-
-	/* 10ms delay is needed for some cards */
-	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
-	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
-	usleep_range(10000, 11000);
-	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
-}
-
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
 
-	advk_pcie_issue_perst(pcie);
-
 	/* Enable TX */
 	reg = advk_readl(pcie, PCIE_CORE_REF_CLK_REG);
 	reg |= PCIE_CORE_REF_CLK_TX_ENABLE;
@@ -433,15 +446,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
 	advk_writel(pcie, reg, PIO_CTRL);
 
-	/*
-	 * PERST# signal could have been asserted by pinctrl subsystem before
-	 * probe() callback has been called or issued explicitly by reset gpio
-	 * function advk_pcie_issue_perst(), making the endpoint going into
-	 * fundamental reset. As required by PCI Express spec a delay for at
-	 * least 100ms after such a reset before link training is needed.
-	 */
-	msleep(PCI_PM_D3COLD_WAIT);
-
 	advk_pcie_train_link(pcie);
 
 	/*
-- 
2.26.2

