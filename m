Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7715701C4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiGKMKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiGKMKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 08:10:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10C49B4B;
        Mon, 11 Jul 2022 05:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3846CB80ED7;
        Mon, 11 Jul 2022 12:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8895C34115;
        Mon, 11 Jul 2022 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657541445;
        bh=A2vqBbzpMVWKfDpC3m2AhDB490zHtivAEnRyuR6TAjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ue5p6kKSr04mMCumm+ey6QjwRCScrVXkcQFvhov3N8VFxcOvj1Z8hMxH8tMHH8sU+
         HnydaS6OeroOUvNXnn/dJ8URrtOrgMgRd0mQKua7ZsNX7tRDmvHm2ez85poO1yTcbk
         dHVo2Id1iTcVl+nMk6j4bxs1nJqOBVRnOlkNWfEZxMJCqPxj5qMvt6FlVehufTNhTj
         oD0Smi6zULtkbVrVl+oeUv9YyuZGUQpL29jKNepGzajkFEu6Md12wRDVGQUZaQ7kpX
         Kv6nwALF2Afz+F4iwpDKAs5DvNFzZKIXTSB5WDlmwwOM/l4k0AeyZ26qulfxUuiFWT
         alfxwduBeHAVA==
Received: by pali.im (Postfix)
        id 61D32276F; Mon, 11 Jul 2022 14:10:42 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: aardvark: Do static allocation of irq_chip
Date:   Mon, 11 Jul 2022 14:06:26 +0200
Message-Id: <20220711120626.11492-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220711120626.11492-1-pali@kernel.org>
References: <20220711120626.11492-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to allocate struct irq_chip in pci-aardvark.c dynamically
at runtime. Use static allocation like for any other irq_chip usage.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8bea5801d50a..74511f015168 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -274,7 +274,6 @@ struct advk_pcie {
 	u8 wins_count;
 	struct irq_domain *rp_irq_domain;
 	struct irq_domain *irq_domain;
-	struct irq_chip irq_chip;
 	raw_spinlock_t irq_lock;
 	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
@@ -1328,13 +1327,19 @@ static void advk_pcie_irq_unmask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&pcie->irq_lock, flags);
 }
 
+static struct irq_chip advk_irq_chip = {
+	.name = "advk-INTx",
+	.irq_mask = advk_pcie_irq_mask,
+	.irq_unmask = advk_pcie_irq_unmask,
+};
+
 static int advk_pcie_irq_map(struct irq_domain *h,
 			     unsigned int virq, irq_hw_number_t hwirq)
 {
 	struct advk_pcie *pcie = h->host_data;
 
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	irq_set_chip_and_handler(virq, &pcie->irq_chip,
+	irq_set_chip_and_handler(virq, &advk_irq_chip,
 				 handle_level_irq);
 	irq_set_chip_data(virq, pcie);
 
@@ -1394,7 +1399,6 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
-	struct irq_chip *irq_chip;
 	int ret = 0;
 
 	raw_spin_lock_init(&pcie->irq_lock);
@@ -1405,28 +1409,14 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 		return -ENODEV;
 	}
 
-	irq_chip = &pcie->irq_chip;
-
-	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-irq",
-					dev_name(dev));
-	if (!irq_chip->name) {
-		ret = -ENOMEM;
-		goto out_put_node;
-	}
-
-	irq_chip->irq_mask = advk_pcie_irq_mask;
-	irq_chip->irq_unmask = advk_pcie_irq_unmask;
-
 	pcie->irq_domain =
 		irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 				      &advk_pcie_irq_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		ret = -ENOMEM;
-		goto out_put_node;
 	}
 
-out_put_node:
 	of_node_put(pcie_intc_node);
 	return ret;
 }
-- 
2.20.1

