Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48C23BA15
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 14:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgHDL7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 07:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgHDL63 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 07:58:29 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3152086A;
        Tue,  4 Aug 2020 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542291;
        bh=99nktUwJy6UmKxOxLJSyDUqszlYQ5GoCmXS2m/hZl2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMSgottE1Dpruui4gxofELhKrtngabO0FunBqvNsARVzfnDVFsx2rhHJDHGC7tMCc
         U6oBTKK3lWrMuLiqbIhU6lYjuAIgpQnWr78uovNF4b0YL4MWYwGfXmvvhy9t+L/shj
         /4N54nK28a/UIgxgIvkRNXNqdLZDLNzpk1AU/GFc=
Received: by pali.im (Postfix)
        id 1ECB07FD; Tue,  4 Aug 2020 13:58:10 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v2 5/5] PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()
Date:   Tue,  4 Aug 2020 13:57:47 +0200
Message-Id: <20200804115747.7078-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804115747.7078-1-pali@kernel.org>
References: <20200804115747.7078-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
index f5c1d231b0e2..fcea300fbcc0 100644
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
2.20.1

