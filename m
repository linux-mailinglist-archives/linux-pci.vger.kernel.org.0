Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163DA37574F
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhEFPeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235518AbhEFPds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E928E61448;
        Thu,  6 May 2021 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315170;
        bh=NhWFiT9mS26VGMqexxlpc1KWY2pibRPWZ7Iothabwro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4HqXv5Fl3bn1sgm2DgGNCqnCa4vXQpacap8ZrEH9+w+rgSIDq6zonuTS3ecUClg4
         B6Q7Q1f6flHxARIDFesxi8vL+H0ovy84kZbaMhcFEA2863B4FOf+ReICL4Vaao/Cj1
         MqkzMZv8XJ6c7EI7bAQHNOaCljmB3PULSrr2J8sjZVZ4B8bmlCKXjyeufdCy5lkn4w
         GIVFUuQ/RQWkygOJXO9bVPC/WXrSB75SRqco8K/EYOm24f8eAP7FJw7qeFOiG1/EmA
         362kkX6KNVlK4tH/nIM11KnX4W/jFyPGlVUE0qjzSNYWJzMqSaOKm5a70vGMLd4zBJ
         gSlj9G5zZLHLw==
Received: by pali.im (Postfix)
        id A23D5732; Thu,  6 May 2021 17:32:49 +0200 (CEST)
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
Subject: [PATCH 19/42] PCI: aardvark: Fix setting MSI address
Date:   Thu,  6 May 2021 17:31:30 +0200
Message-Id: <20210506153153.30454-20-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI address for receiving MSI interrupts needs to be correctly set before
enabling processing of MSI interrupts.

Move code for setting PCIE_MSI_ADDR_LOW_REG and PCIE_MSI_ADDR_HIGH_REG
registers with MSI address from advk_pcie_init_msi_irq_domain() function to
advk_pcie_setup_hw() function before enabling PCIE_CORE_CTRL2_MSI_ENABLE.

As part of this change, also remove unused variable msi_msg, which was used
only for MSI doorbell address. MSI address can be any address which does
not conflict with PCI space. So change it to the address of the main struct
advk_pcie.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
---
 drivers/pci/controller/pci-aardvark.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 5e0243b2c473..199015215779 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -195,7 +195,6 @@ struct advk_pcie {
 	struct msi_domain_info msi_domain_info;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
-	u16 msi_msg;
 	int link_gen;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
@@ -325,6 +324,7 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
 
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
+	phys_addr_t msi_addr;
 	u32 reg;
 
 	/* Enable TX */
@@ -381,6 +381,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg |= LANE_COUNT_1;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
 
+	/* Set MSI address */
+	msi_addr = virt_to_phys(pcie);
+	advk_writel(pcie, lower_32_bits(msi_addr), PCIE_MSI_ADDR_LOW_REG);
+	advk_writel(pcie, upper_32_bits(msi_addr), PCIE_MSI_ADDR_HIGH_REG);
+
 	/* Enable MSI */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_MSI_ENABLE;
@@ -862,10 +867,10 @@ static void advk_msi_irq_compose_msi_msg(struct irq_data *data,
 					 struct msi_msg *msg)
 {
 	struct advk_pcie *pcie = irq_data_get_irq_chip_data(data);
-	phys_addr_t msi_msg = virt_to_phys(&pcie->msi_msg);
+	phys_addr_t msi_addr = virt_to_phys(pcie);
 
-	msg->address_lo = lower_32_bits(msi_msg);
-	msg->address_hi = upper_32_bits(msi_msg);
+	msg->address_lo = lower_32_bits(msi_addr);
+	msg->address_hi = upper_32_bits(msi_addr);
 	msg->data = data->hwirq;
 }
 
@@ -960,7 +965,6 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	struct device_node *node = dev->of_node;
 	struct irq_chip *bottom_ic, *msi_ic;
 	struct msi_domain_info *msi_di;
-	phys_addr_t msi_msg_phys;
 
 	mutex_init(&pcie->msi_used_lock);
 
@@ -978,13 +982,6 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 		MSI_FLAG_MULTI_PCI_MSI;
 	msi_di->chip = msi_ic;
 
-	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
-
-	advk_writel(pcie, lower_32_bits(msi_msg_phys),
-		    PCIE_MSI_ADDR_LOW_REG);
-	advk_writel(pcie, upper_32_bits(msi_msg_phys),
-		    PCIE_MSI_ADDR_HIGH_REG);
-
 	pcie->msi_inner_domain =
 		irq_domain_add_linear(NULL, MSI_IRQ_NUM,
 				      &advk_msi_domain_ops, pcie);
-- 
2.20.1

