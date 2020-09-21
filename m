Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4C271CDE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIUICw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 04:02:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbgIUICc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5FC9A767C41818FDA2E5;
        Mon, 21 Sep 2020 16:02:29 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:22 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] PCI: mobiveil: simplify the return expression of mobiveil_pcie_init_irq_domain
Date:   Mon, 21 Sep 2020 16:24:47 +0800
Message-ID: <20200921082447.2591877-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 3adec419a45b..a2632d02ce8f 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -480,7 +480,6 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct mobiveil_root_port *rp = &pcie->rp;
-	int ret;
 
 	/* setup INTx */
 	rp->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
@@ -494,11 +493,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 	raw_spin_lock_init(&rp->intx_mask_lock);
 
 	/* setup MSI */
-	ret = mobiveil_allocate_msi_domains(pcie);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mobiveil_allocate_msi_domains(pcie);
 }
 
 static int mobiveil_pcie_integrated_interrupt_init(struct mobiveil_pcie *pcie)
-- 
2.25.1

