Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315B2488E3C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiAJBue (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiAJBud (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA4C06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62616B8107B
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1933C36AE3;
        Mon, 10 Jan 2022 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779430;
        bh=MKqNKxvNTCA8XCEb+Ovg5zwNUI0UU8J1M2c+3ktk92I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aoJU1OLDCSWKx/h7PhfJIDlmd02R/PyqXNztYQtj+SyEHfiP6EnzuITl1YrRivFPi
         Ucuh5+ZEQkyQeJlVTTENkZwFX8Gzni8bNJKEvocwXsdjdM1gn8mhHeeSO1cn9PS+wr
         qws+9vEgJR+SYrmNc79606ykrSRnLfxvkuw7jRZ51ebwv+9ChSY+2vJ/DtjMilVjVB
         8woJZ3KtZDZHgpaR/BxAhfMGfyHB2ZvtlTi8fIZVTB+dwztmLPy4j7dDhX8Oil95xA
         BzChKgceSUxEj8xLeJPmCn9RKEbAOhMhg+zdwuIpU3uQ+iF77VyW+YCkbK/VEXdVtq
         NGmKgiV838aGg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 03/23] PCI: aardvark: Fix support for MSI interrupts
Date:   Mon, 10 Jan 2022 02:49:58 +0100
Message-Id: <20220110015018.26359-4-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
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
 drivers/pci/controller/pci-aardvark.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fd95ad64c887..346d38835539 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1189,7 +1189,7 @@ static void advk_msi_irq_compose_msi_msg(struct irq_data *data,
 
 	msg->address_lo = lower_32_bits(msi_msg);
 	msg->address_hi = upper_32_bits(msi_msg);
-	msg->data = data->irq;
+	msg->data = data->hwirq;
 }
 
 static int advk_msi_set_affinity(struct irq_data *irq_data,
@@ -1206,15 +1206,11 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
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
@@ -1232,7 +1228,7 @@ static void advk_msi_irq_domain_free(struct irq_domain *domain,
 	struct advk_pcie *pcie = domain->host_data;
 
 	mutex_lock(&pcie->msi_used_lock);
-	bitmap_clear(pcie->msi_used, d->hwirq, nr_irqs);
+	bitmap_release_region(pcie->msi_used, d->hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&pcie->msi_used_lock);
 }
 
-- 
2.34.1

