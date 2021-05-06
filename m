Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2D375769
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhEFPfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235730AbhEFPd4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DE07616EA;
        Thu,  6 May 2021 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315175;
        bh=ghapb+8oJP9gj5A73iBbcuKAnKFz+Keg3CDg5iz9MEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8P8TDdbEUPvkU0OkVC6L2OvsSvneY0lKfmp3NdonzS4GBLtOK40hdUSJqwRsoZF1
         waa8XISVltL1qDT0+U+GlKRFNhSnOZGVjHC8xpsUVuuSI95c0QZe5hrCaG//WjGT5L
         RgAcsHSZiiGY4Mbf7SzININ6+VCiDiUwZiHoVeo7xREGbnOGNrXV5kkavHwGMiXMKO
         +039AZJTln4dFqABX5ocSY2GZk76BfON4BAbQgeBTUzIhbMEcqL9ZkbAtO3rQK/NGe
         xVYnLrHGEqN/+zHJT/Y6UvpFb1lF5hwgHRqve1v1yFVNf0iR3QDJM9BjVV/S3v3a9E
         2CS0t3hZym7pw==
Received: by pali.im (Postfix)
        id D94B0732; Thu,  6 May 2021 17:32:54 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 36/42] PCI: aardvark: Replace custom PCIE_CORE_ERR_CAPCTL_* macros by linux/pci_regs.h macros
Date:   Thu,  6 May 2021 17:31:47 +0200
Message-Id: <20210506153153.30454-37-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Advanced Error Reporting Capability registers start at aardvark offset
0x100.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d8fb43604154..d99462d99ed8 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -33,11 +33,7 @@
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define PCIE_CORE_DEV_REV_REG					0x8
 #define PCIE_CORE_PCIEXP_CAP					0xc0
-#define PCIE_CORE_ERR_CAPCTL_REG				0x118
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK			BIT(7)
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV			BIT(8)
+#define PCIE_CORE_PCIERR_CAP					0x100
 #define     PCIE_CORE_INT_A_ASSERT_ENABLE			1
 #define     PCIE_CORE_INT_B_ASSERT_ENABLE			2
 #define     PCIE_CORE_INT_C_ASSERT_ENABLE			3
@@ -370,12 +366,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
 
-	/* Set Advanced Error Capabilities and Control PF0 register */
-	reg = PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX |
-		PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN |
-		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK |
-		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV;
-	advk_writel(pcie, reg, PCIE_CORE_ERR_CAPCTL_REG);
+	/* Enable generation and checking of ECRC on Root Bridge */
+	reg = advk_readl(pcie, PCIE_CORE_PCIERR_CAP + PCI_ERR_CAP);
+	reg |= PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE;
+	advk_writel(pcie, reg, PCIE_CORE_PCIERR_CAP + PCI_ERR_CAP);
 
 	/* Set PCIe Device Control register */
 	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
-- 
2.20.1

