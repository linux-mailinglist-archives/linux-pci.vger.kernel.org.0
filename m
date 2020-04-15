Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6691AACDE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410154AbgDOQEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410141AbgDOQD7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:03:59 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD8B21556;
        Wed, 15 Apr 2020 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966638;
        bh=1azI/ODf7w/ChnN2OTEWjI3fh/QSCsJ6Hav0dp8KUI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8zu15N9M/eHM+gXL+DeTLVeiuE28AuOZrQHF6S8D7gQK5kjVtysUTQSnfMafVOQs
         wxhqxQfCf8Hi3tJ/3GrfnzVZSv+3fEr20pi4FZOJRBgE038vudWyke3D3JXjaW3M6t
         naG/aiy5sF30zfcKRMRHm7jMJVR1GHEOP91X2+pQ=
Received: by pali.im (Postfix)
        id F329858E; Wed, 15 Apr 2020 18:03:56 +0200 (CEST)
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
Subject: [PATCH 5/8] PCI: aardvark: Set final controller speed based on negotiated link speed
Date:   Wed, 15 Apr 2020 18:03:45 +0200
Message-Id: <20200415160348.1146-1-pali@kernel.org>
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

Some Compex WLE900VX gen1 cards are unstable or even not detected when
aardvark PCI controller speed is set to gen2. Moreover when ASPM code tries
to retrain link second time then these cards stop responding and link goes
down. If aardvark PCI controller is set to gen1 then these cards work fine
without any problem.

Unconditionally forcing aardvark controller to gen1 speed (either via DT
property max-link-speed or hardcoded value in driver itself) is not a
solution as it would have performance impact for fast gen2 sata cards.

To overcome this problem, try all 3 possible speeds (gen3, gen2, gen1)
supported by aardvark PCI controller with respect to max-link-speed setting
and after successful link training choose final controller speed based on
Negotiated Link Speed from Link Status register, which should match card
speed.

I tested this change with Compex cards WLE200NX (pcie 1.0, gen1, ath9k),
WLE900VX (pcie 1.1, gen1, ath10k) and WLE1216V5-20 (pcie 2.0, gen2, ath10k)
on Turris MOX. Tomasz Maciej Nowak tested JJPlus JWX6051 (ath9k), Intel
622ANHMW, MT76 U7612E-H1 and Compex WLE1216V2-20 cards on Espressobin.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 35 +++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 02c69fc9aadf..a83bbc86e428 100644
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
@@ -276,7 +277,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
-	int max_link_speed;
+	int max_link_speed, neg_link_speed;
 	u32 reg;
 
 	/* Set to Direct mode */
@@ -378,7 +379,37 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg |= PCIE_CORE_LINK_TRAINING;
 	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
 
-	advk_pcie_wait_for_link(pcie);
+	do {
+		if (advk_pcie_wait_for_link(pcie) < 0) {
+			max_link_speed--;
+		} else {
+			reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
+
+			neg_link_speed =
+				(reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
+			dev_info(dev, "negotiated link speed %d\n",
+				neg_link_speed);
+
+			if (neg_link_speed == max_link_speed)
+				break;
+
+			if (neg_link_speed > 0 && neg_link_speed <= 3)
+				max_link_speed = neg_link_speed;
+			else
+				max_link_speed--;
+		}
+
+		if (max_link_speed == 0)
+			break;
+
+		/* Set new decreased max link speed */
+		advk_pcie_setup_link_speed(pcie, max_link_speed);
+
+		/* And start link training again */
+		reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
+		reg |= PCIE_CORE_LINK_TRAINING;
+		advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
+	} while (1);
 
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
-- 
2.20.1

