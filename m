Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5246CD9A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhLHGWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhLHGWe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE8DC061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DFA2B81FA7
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DDAC341C3;
        Wed,  8 Dec 2021 06:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944340;
        bh=F7/9hMSn/5w53CuvPOke3ZDQdmIbrVlnLeXuF34W4wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjBCIjVG7MiaYSUPsdemeoYGPMqj1xA1BlAnDZd6v+2XdpWSA587h5TuIsD3CNGI3
         /S0YPp+kOdw0DvqjQaI4lph6QxjuErSlI9+r47yb1UaXdR3DiXzWoZkFeSVjSPMvBV
         H7nGTk1lE/Ld30BhztNyVTv02EbB1scoaDpNRB3pQjxfTfpY4/hQxhBIdJ/jI1Ow5t
         vYQ77+oGFAC/v0kH5/0TGxVUBHXBRdM92rwGYaVnqgjjIuo2Fo2MreyFD+l9K3DZIi
         VvReiN6fhFViNDPmhGx91mGRIYz9WcI10CnvS7Io0yxThKESS3NJa8cu/ppj97jIi/
         UYvG1IJGWZ7PQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 03/17] PCI: aardvark: Fix support for MSI interrupts
Date:   Wed,  8 Dec 2021 07:18:37 +0100
Message-Id: <20211208061851.31867-4-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
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

This change fixes receiving MSI interrupts on Armada 3720 boards and
allows using NVMe disks which use Multi-MSI feature with 3 interrupts.

Without this NVMe disks freeze booting as linux nvme-core.c is waiting
60s for an interrupt.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e7edbc1fd4aa..681d93a15be1 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1194,7 +1194,7 @@ static void advk_msi_irq_compose_msi_msg(struct irq_data *data,
 
 	msg->address_lo = lower_32_bits(msi_msg);
 	msg->address_hi = upper_32_bits(msi_msg);
-	msg->data = data->irq;
+	msg->data = data->hwirq;
 }
 
 static int advk_msi_set_affinity(struct irq_data *irq_data,
@@ -1211,15 +1211,11 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
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
@@ -1237,7 +1233,7 @@ static void advk_msi_irq_domain_free(struct irq_domain *domain,
 	struct advk_pcie *pcie = domain->host_data;
 
 	mutex_lock(&pcie->msi_used_lock);
-	bitmap_clear(pcie->msi_used, d->hwirq, nr_irqs);
+	bitmap_release_region(pcie->msi_used, d->hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&pcie->msi_used_lock);
 }
 
@@ -1414,7 +1410,9 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
 		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
-		generic_handle_irq(msi_data);
+
+		if (generic_handle_domain_irq(pcie->msi_inner_domain, msi_data) == -EINVAL)
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_data);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.32.0

