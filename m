Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1837575F
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhEFPfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235641AbhEFPdv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A13B613ED;
        Thu,  6 May 2021 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315173;
        bh=/5yIPTKEkWgY56kimWV9XM50Ciagid7BtB2KRODStO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jseQYHW2AX00bNRe4SOUilGmTtv0OoLzecty/ZBtsQrArq/n3dhHzEcZfvSA+gPif
         iHOqLDm6J+2aOTGDbqYAIrfFpc/XcU/II14gWpEwtfQwkH9UF/J6nvTUBgmCEfPcbD
         UuRFMWAAmRX/SFOWU64K2XBs6Rwl7Qz+6MZRECtaxK8yhydg5Thl05xxzhYaS/cte6
         YnE5NL/8gkuNchVcP2Zy8gfHIovErlfDfcPHGi89LhuDmzdh5uU1F8848BwX3BpeeS
         ysxAF3/7oMREC+Q3OVnye88vOnSLag9o+iFbaZHOEidJyIBAUhLePcWaZdIE5dGeG4
         QE5XnJ5JSHehA==
Received: by pali.im (Postfix)
        id B56988A1; Thu,  6 May 2021 17:32:52 +0200 (CEST)
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
Subject: [PATCH 29/42] PCI: aardvark: Reset PCIe card and disable PHY when unbinding driver
Date:   Thu,  6 May 2021 17:31:40 +0200
Message-Id: <20210506153153.30454-30-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When unbinding driver, assert PERST# signal which prepares PCIe card for
power down. Then disable link training and PHY.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
---
 drivers/pci/controller/pci-aardvark.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 4b531675db81..b1e6a8a839e0 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1494,6 +1494,18 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	/* Free config space for emulated root bridge */
 	pci_bridge_emul_cleanup(&pcie->bridge);
 
+	/* Assert PERST# signal which prepares PCIe card for power down */
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	/* Disable link training */
+	val = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	val &= ~LINK_TRAINING_EN;
+	advk_writel(pcie, val, PCIE_CORE_CTRL0_REG);
+
+	/* Disable phy */
+	advk_pcie_disable_phy(pcie);
+
 	return 0;
 }
 
-- 
2.20.1

