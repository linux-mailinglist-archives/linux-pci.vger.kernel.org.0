Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B8488E40
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiAJBum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiAJBuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C786C06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2073E60F55
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA666C36AF4;
        Mon, 10 Jan 2022 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779438;
        bh=UvzOidBPSHGGbeu2laYbez0lLVWOTPBWyO/DHQqwP9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWYQuroimnIzIjymrn0+nkg0fWO9F+uTxb5kjtrQ9vHG9BA/NWtGWKgJULSmOGG/D
         wx614bABFT7YJD/MZSdHO1SFxEeVEiIqBsVOMJDHjMmjBYMobN79ZLXGGl0stqr4e7
         Op+Qxt/C6Wg6H/dS0nh8q8REdXK12zXS92X8A64ATXcwk3ue5wazE1dKyAxUc8H/Px
         X6lcR6f+gn+XeuRCtgLDFbpgWEEz8YLI+g+GlTfH7EvTcPYl+FWgnZX/qYPZCPbMiF
         NJ0lGxKcFyyiFj6OcNqP5JflM298F7wfy2m5Jk4WctzdRmqzK51A16rjihDsmtdpSS
         MOOdT0iG3T+iw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 07/23] PCI: aardvark: Make msi_domain_info structure a static driver structure
Date:   Mon, 10 Jan 2022 02:50:02 +0100
Message-Id: <20220110015018.26359-8-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make Aardvark's msi_domain_info structure into a private driver structure.
Domain info is same for every potential instatination of a controller.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 441100bacb68..5ab107f65c6c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -275,7 +275,6 @@ struct advk_pcie {
 	raw_spinlock_t irq_lock;
 	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
-	struct msi_domain_info msi_domain_info;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
 	u16 msi_msg;
@@ -1293,20 +1292,20 @@ static struct irq_chip advk_msi_irq_chip = {
 	.name = "advk-MSI",
 };
 
+static struct msi_domain_info advk_msi_domain_info = {
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_MULTI_PCI_MSI,
+	.chip	= &advk_msi_irq_chip,
+};
+
 static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct msi_domain_info *msi_di;
 	phys_addr_t msi_msg_phys;
 
 	mutex_init(&pcie->msi_used_lock);
 
-	msi_di = &pcie->msi_domain_info;
-	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI;
-	msi_di->chip = &advk_msi_irq_chip;
-
 	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
 
 	advk_writel(pcie, lower_32_bits(msi_msg_phys),
@@ -1322,7 +1321,8 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 
 	pcie->msi_domain =
 		pci_msi_create_irq_domain(of_node_to_fwnode(node),
-					  msi_di, pcie->msi_inner_domain);
+					  &advk_msi_domain_info,
+					  pcie->msi_inner_domain);
 	if (!pcie->msi_domain) {
 		irq_domain_remove(pcie->msi_inner_domain);
 		return -ENOMEM;
-- 
2.34.1

