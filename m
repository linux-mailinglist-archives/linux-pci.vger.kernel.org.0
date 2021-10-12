Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8321F42A9BF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJLQn4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhJLQnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF14A61050;
        Tue, 12 Oct 2021 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056913;
        bh=F62u5JCB/OkusKcNy5U8DqRNP/vRfmbS9D4keVux1QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9A7spXJzvKAZe8i8qVyFLX9I+fEnesQ12M3rHJP3RUzqzJmjP+InCC0dpZp56jK2
         VlBVidCd4HOzgLlkxlnvdXQdfrt9bitxFr8aIAw7BQnds1vAzGPOx1HxZZ4QUOq0VW
         PSIsDOGbwrRD8myu1wIGpOfJOA9RAJb2mDKIAFE+tnTGcHtv3OQ2iSG3ggv/Kj3lsE
         KWI0Q26mVDX0Exmy+3FvBpcp49z5wGbIYPobUGf8Hzt2gGizL1HMbFZMVyAW8i4y4J
         9mB0zaMcTjZmIhOlhGyBBXYs+LEOBmPIUbADjWwD8AOJ3QgbrX5TcBTWuwcN8DHW2C
         Uv+yEL+oxdYkw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 04/14] PCI: aardvark: Fix support for MSI interrupts
Date:   Tue, 12 Oct 2021 18:41:35 +0200
Message-Id: <20211012164145.14126-5-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Aardvark hardware supports Multi-MSI and MSI_FLAG_MULTI_PCI_MSI is already
set for the MSI chip. But when allocating MSI interrupt numbers for
Multi-MSI, the numbers need to be properly aligned, otherwise endpoint
devices send MSI interrupt with incorrect numbers.

Fix this issue by using function bitmap_find_free_region() instead of
bitmap_find_next_zero_area().

To ensure that aligned MSI interrupt numbers are used by endpoint devices,
we cannot use Linux virtual irq numbers (as they are random and not
properly aligned). Instead we need to use the aligned hwirq numbers.
Properly map Linux virtual irq numbers and hwirq MSI inner domain numbers
in advk_msi_irq_compose_msi_msg() and advk_pcie_handle_msi().

This change fixes receiving MSI interrupts on Armada 3720 boards and
allows using NVMe disks which use Multi-MSI feature with 3 interrupts.

Without this NVMe disks freeze booting as linux nvme-core.c is waiting
60s for an interrupt.

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
---
 drivers/pci/controller/pci-aardvark.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 389ebba1dd9b..4f232ee1f115 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1106,7 +1106,7 @@ static void advk_msi_irq_compose_msi_msg(struct irq_data *data,
 
 	msg->address_lo = lower_32_bits(msi_msg);
 	msg->address_hi = upper_32_bits(msi_msg);
-	msg->data = data->irq;
+	msg->data = data->hwirq;
 }
 
 static int advk_msi_set_affinity(struct irq_data *irq_data,
@@ -1123,15 +1123,11 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
 	int hwirq, i;
 
 	mutex_lock(&pcie->msi_used_lock);
-	hwirq = bitmap_find_next_zero_area(pcie->msi_used, MSI_IRQ_NUM,
-					   0, nr_irqs, 0);
-	if (hwirq >= MSI_IRQ_NUM) {
-		mutex_unlock(&pcie->msi_used_lock);
-		return -ENOSPC;
-	}
-
-	bitmap_set(pcie->msi_used, hwirq, nr_irqs);
+	hwirq = bitmap_find_free_region(pcie->msi_used, MSI_IRQ_NUM,
+					order_base_2(nr_irqs));
 	mutex_unlock(&pcie->msi_used_lock);
+	if (hwirq < 0)
+		return -ENOSPC;
 
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, hwirq + i,
@@ -1149,7 +1145,7 @@ static void advk_msi_irq_domain_free(struct irq_domain *domain,
 	struct advk_pcie *pcie = domain->host_data;
 
 	mutex_lock(&pcie->msi_used_lock);
-	bitmap_clear(pcie->msi_used, d->hwirq, nr_irqs);
+	bitmap_release_region(pcie->msi_used, d->hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&pcie->msi_used_lock);
 }
 
@@ -1311,6 +1307,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
 	u16 msi_data;
+	int virq;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
 	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
@@ -1326,7 +1323,11 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
 		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
-		generic_handle_irq(msi_data);
+		virq = irq_find_mapping(pcie->msi_inner_domain, msi_data);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_data);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.32.0

