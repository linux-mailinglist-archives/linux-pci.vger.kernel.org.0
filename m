Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35A11AACBC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415140AbgDOQBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1414829AbgDOQBV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:01:21 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5CB42076A;
        Wed, 15 Apr 2020 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966480;
        bh=J8J9WMwWS0+Nqarse/8WxRYuf4GlYENWHZo2OGXUjKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSWOREUiD0QyAT3wncvo6YXKZ7r2a12iyRZ9ucG1zxrvP1MBWnntz83T4y1ezzUBP
         m6h48V3XO19PG0nrXOXZNM0sho3LqIXvEk4T5g5X7O3LuFcMxIrtBQnqfK9au5fOUY
         bPUx8zTegC6K8zfTGs1UurAC4imBhSZEJMSaaeEA=
Received: by pali.im (Postfix)
        id 2C50C58E; Wed, 15 Apr 2020 18:01:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/8] PCI: aardvark: Set controller speed from Device Tree max-link-speed
Date:   Wed, 15 Apr 2020 18:00:47 +0200
Message-Id: <20200415160054.951-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415160054.951-1-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

bindings/pci/pci.txt defines standard DT property max-link-speed for
specifying PCI gen of link. Read this property from Device Tree via
of_pci_get_max_link_speed() function and use it for configuring aardvark
PCI controller gen speed. Before this change aardvark PCI gen speed was
configured always to hardcoded value gen2. When Device Tree does not
specify max-link-speed property use by default gen3 value, maximum which
aardvark PCI controller supports.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 32 ++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2a20b649f40c..ad4f0fa57624 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -253,8 +253,30 @@ static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
 	}
 }
 
+static void advk_pcie_setup_link_speed(struct advk_pcie *pcie, int link_speed)
+{
+	u32 reg;
+
+	dev_info(&pcie->pdev->dev, "setup link speed to %d\n", link_speed);
+
+	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg &= ~PCIE_GEN_SEL_MSK;
+
+	if (link_speed == 3)
+		reg |= SPEED_GEN_3;
+	else if (link_speed == 2)
+		reg |= SPEED_GEN_2;
+	else
+		reg |= SPEED_GEN_1;
+
+	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+}
+
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+	int max_link_speed;
 	u32 reg;
 
 	/* Set to Direct mode */
@@ -288,11 +310,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
-	/* Set GEN2 */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-	reg &= ~PCIE_GEN_SEL_MSK;
-	reg |= SPEED_GEN_2;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+	/* Set max link speed */
+	max_link_speed = of_pci_get_max_link_speed(node);
+	if (max_link_speed <= 0 || max_link_speed > 3)
+		max_link_speed = 3;
+	advk_pcie_setup_link_speed(pcie, max_link_speed);
 
 	/* Set lane X1 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-- 
2.20.1

