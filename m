Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CFD37574E
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhEFPeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235477AbhEFPds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AEF5613F6;
        Thu,  6 May 2021 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315169;
        bh=yN1GVDsVClOczJBW/hcMrhTyF36UkgV7hMJV2qJoxrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxrXFrmgOLLG5cl31a3HZDuTj2XGD0N78K9/16eUsDSmLqb6edR911/rRpLPEtCKA
         NUdpDhPM0L4hVdUuTHkelRXUtS0myrC7wECtiYkKeKmZZwLJLGKQYMK/5qOIisBNKh
         49hoh9odMpOUA6GnACS1dKV4kx50V4eDtoBo8wpSb1rxpT/fvESvS/zXQYlgdZpo9j
         AdVS62Rug9qBYXPZ2YzDcKcyuE7+7UHSmF2wJLBrjRE6KHOCU+Ul7VNl+SBby66YQP
         ellsp8wawVYmHN1+oySrX4HBSZox+iQ8y0NbOYFUaZ3AUEkg+T1efLtbRehf/zbSC9
         m8tpKEYfSeKrg==
Received: by pali.im (Postfix)
        id 120E5BF9; Thu,  6 May 2021 17:32:49 +0200 (CEST)
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
Subject: [PATCH 17/42] PCI: aardvark: Fix support for MSI interrupts
Date:   Thu,  6 May 2021 17:31:28 +0200
Message-Id: <20210506153153.30454-18-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI domain callback .alloc (implemented by advk_msi_irq_domain_alloc()
function) should return zero on success. Returning non-zero value indicates
failure. Fix return value of this function as in many cases it now returns
failure while allocating IRQs.

Aardvark hardware supports Multi-MSI and MSI_FLAG_MULTI_PCI_MSI is already
set. But when allocating MSI interrupt numbers for Multi-MSI, they need to
be properly aligned, otherwise endpoint devices send MSI interrupt with
incorrect numbers. Fix this issue by using function bitmap_find_free_region()
instead of bitmap_find_next_zero_area().

To ensure that aligned MSI interrupt numbers are used by endpoint devices,
we cannot use Linux virtual irq numbers (as they are random and not
properly aligned). So use hwirq numbers allocated by the function
bitmap_find_free_region(), which are aligned. This needs an update in
advk_msi_irq_compose_msi_msg() and advk_pcie_handle_msi() functions to do
proper mapping between Linux virtual irq numbers and hwirq MSI inner domain
numbers.

Also the whole 16-bit MSI number is stored in the PCIE_MSI_PAYLOAD_REG
register, not only lower 8 bits. Fix reading content of this register.

This change fixes receiving MSI interrupts on Armada 3720 boards and allows
using NVMe disks which use Multi-MSI feature with 3 interrupts.

Without this change, NVMe disks just freeze booting Linux on Armada 3720
boards as linux nvme-core.c driver is waiting 60s for an interrupt.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
---
 drivers/pci/controller/pci-aardvark.c | 32 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 366d7480bc1b..498810c00b6d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -118,6 +118,7 @@
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
+#define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
 
 /* LMI registers base address and register offsets */
 #define LMI_BASE_ADDR				0x6000
@@ -861,7 +862,7 @@ static void advk_msi_irq_compose_msi_msg(struct irq_data *data,
 
 	msg->address_lo = lower_32_bits(msi_msg);
 	msg->address_hi = upper_32_bits(msi_msg);
-	msg->data = data->irq;
+	msg->data = data->hwirq;
 }
 
 static int advk_msi_set_affinity(struct irq_data *irq_data,
@@ -878,15 +879,11 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
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
@@ -894,7 +891,7 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
 				    domain->host_data, handle_simple_irq,
 				    NULL, NULL);
 
-	return hwirq;
+	return 0;
 }
 
 static void advk_msi_irq_domain_free(struct irq_domain *domain,
@@ -904,7 +901,7 @@ static void advk_msi_irq_domain_free(struct irq_domain *domain,
 	struct advk_pcie *pcie = domain->host_data;
 
 	mutex_lock(&pcie->msi_used_lock);
-	bitmap_clear(pcie->msi_used, d->hwirq, nr_irqs);
+	bitmap_release_region(pcie->msi_used, d->hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&pcie->msi_used_lock);
 }
 
@@ -1048,6 +1045,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
 	u16 msi_data;
+	int virq;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
 	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
@@ -1057,9 +1055,17 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
+		/*
+		 * msi_idx contains bits [4:0] of the msi_data and msi_data
+		 * contains 16bit MSI interrupt number from MSI inner domain
+		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & 0xFF;
-		generic_handle_irq(msi_data);
+		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
+		virq = irq_find_mapping(pcie->msi_inner_domain, msi_data);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_data);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.20.1

