Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FFE1B7A1C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgDXPjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 11:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgDXPjX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:23 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB4C20700;
        Fri, 24 Apr 2020 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587742762;
        bh=CcgiaaVWBWi9eIao4PtNwtUJq52KoFVJVxIiGe1dx4w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zT/Z/jJgLhT1CRJ6zOE+8vzt9MK92GC/nmu0mRUQONnZjh2SuZpION0eprXc9cXEY
         l5nI91XRHL6lt8iS3LzGKOWkK4fJjLJZWHTMkOaN+zLoxqsQD7miZtMVzu0DiRSzkx
         wX99boP1WHeh3EvQe3uv/gvK3wijiAborRg4Bd08=
Received: by pali.im (Postfix)
        id 73B4A82E; Fri, 24 Apr 2020 17:39:20 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 08/12] PCI: aardvark: Replace custom macros by standard linux/pci_regs.h macros
Date:   Fri, 24 Apr 2020 17:38:54 +0200
Message-Id: <20200424153858.29744-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424153858.29744-1-pali@kernel.org>
References: <20200424153858.29744-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI-E capability macros are already defined in linux/pci_regs.h.
Remove their reimplementation in pcie-aardvark.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 41 ++++++++++++---------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 7a4f395c5812..948e61e76053 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -34,17 +34,6 @@
 #define     PCIE_CORE_CMD_MEM_IO_REQ_EN				BIT(2)
 #define PCIE_CORE_DEV_REV_REG					0x8
 #define PCIE_CORE_PCIEXP_CAP					0xc0
-#define PCIE_CORE_DEV_CTRL_STATS_REG				0xc8
-#define     PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE	(0 << 4)
-#define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
-#define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
-#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
-#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ		0x2
-#define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
-#define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
-#define     PCIE_CORE_LINK_TRAINING				BIT(5)
-#define     PCIE_CORE_LINK_SPEED_SHIFT				16
-#define     PCIE_CORE_LINK_WIDTH_SHIFT				20
 #define PCIE_CORE_ERR_CAPCTL_REG				0x118
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
@@ -223,6 +212,11 @@ static inline u32 advk_readl(struct advk_pcie *pcie, u64 reg)
 	return readl(pcie->base + reg);
 }
 
+static inline u16 advk_read16(struct advk_pcie *pcie, u64 reg)
+{
+	return advk_readl(pcie, (reg & ~0x3)) >> ((reg & 0x3) * 8);
+}
+
 static int advk_pcie_link_up(struct advk_pcie *pcie)
 {
 	u32 val, ltssm_state;
@@ -286,16 +280,16 @@ static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
 	 * Start link training immediately after enabling it.
 	 * This solves problems for some buggy cards.
 	 */
-	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
-	reg |= PCIE_CORE_LINK_TRAINING;
-	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
+	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL);
+	reg |= PCI_EXP_LNKCTL_RL;
+	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL);
 
 	ret = advk_pcie_wait_for_link(pcie);
 	if (ret)
 		return ret;
 
-	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
-	neg_gen = (reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
+	reg = advk_read16(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKSTA);
+	neg_gen = reg & PCI_EXP_LNKSTA_CLS;
 
 	return neg_gen;
 }
@@ -385,13 +379,14 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV;
 	advk_writel(pcie, reg, PCIE_CORE_ERR_CAPCTL_REG);
 
-	/* Set PCIe Device Control and Status 1 PF0 register */
-	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
-		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
-		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
-		(PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ <<
-		 PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT);
-	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
+	/* Set PCIe Device Control register */
+	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
+	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
+	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
+	reg &= ~PCI_EXP_DEVCTL_READRQ;
+	reg |= PCI_EXP_DEVCTL_PAYLOAD; /* Set max payload size */
+	reg |= PCI_EXP_DEVCTL_READRQ_512B;
+	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
 
 	/* Program PCIe Control 2 to disable strict ordering */
 	reg = PCIE_CORE_CTRL2_RESERVED |
-- 
2.20.1

