Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29615395FB
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346906AbiEaSNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiEaSNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 14:13:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E3D8CB38;
        Tue, 31 May 2022 11:13:25 -0700 (PDT)
X-UUID: 5cebfa8e456c473590b4d7c84d4833bf-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:b663a94e-8bea-4693-bcb8-9533c8438add,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:b663a94e-8bea-4693-bcb8-9533c8438add,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:6ba2048a-32d7-4fc0-b2ef-8776ac194f8f,C
        OID:82ece6b5264a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 5cebfa8e456c473590b4d7c84d4833bf-20220601
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 370189634; Wed, 01 Jun 2022 02:13:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Jun 2022 02:13:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 02:13:16 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <linmq006@gmail.com>
CC:     <bhelgaas@google.com>, <jianjun.wang@mediatek.com>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <robh@kernel.org>, <ryder.lee@mediatek.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains
Date:   Wed, 1 Jun 2022 02:13:16 +0800
Message-ID: <20220531181316.24452-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220530064807.34534-1-linmq006@gmail.com>
References: <20220530064807.34534-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miaoqian,

>of_get_child_by_name() returns a node pointer with refcount
>incremented, we should use of_node_put() on it when not need anymore.
>Add missing of_node_put() to avoid refcount leak.
>
>Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
>Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>---
>changes in v2:
>- move of_node_put(intc_node) right after irq_domain_add_linear to cover
>normal path and error paths.
>
>v1 link: https://lore.kernel.org/all/20220526110246.53502-1-linmq006@gmail.com/
>---
> drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
>index 3e8d70bfabc6..19a01daad304 100644
>--- a/drivers/pci/controller/pcie-mediatek-gen3.c
>+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>@@ -598,6 +598,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
> 
> 	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
> 						  &intx_domain_ops, pcie);
>+	of_node_put(intc_node);
> 	if (!pcie->intx_domain) {
> 		dev_err(dev, "failed to create INTx IRQ domain\n");
> 		return -ENODEV;
>
> 		

Thanks for this v2 patch. I think we can do similar things like
rtl8365mb_irq_setup() in drivers/net/dsa/realtek/rtl8365mb.c.

When I read the error path, I will go back and see if everything is
released, so I think it is clearer to put of_node_put() in the error
path and before return 0.

How do you think?

i.g.,

static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
{
	struct device *dev = pcie->dev;
	struct device_node *intc_node, *node = dev->of_node;
	int ret;

	raw_spin_lock_init(&pcie->irq_lock);

	/* Setup INTx */
	intc_node = of_get_child_by_name(node, "interrupt-controller");
	if (!intc_node) {
		dev_err(dev, "missing interrupt-controller node\n");
		return -ENODEV;
	}

	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
						  &intx_domain_ops, pcie);
	if (!pcie->intx_domain) {
		dev_err(dev, "failed to create INTx IRQ domain\n");
		ret = -ENODEV;
		goto out_put_node;
	}

	/* Setup MSI */
	mutex_init(&pcie->lock);

	pcie->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
				  &mtk_msi_bottom_domain_ops, pcie);
	if (!pcie->msi_bottom_domain) {
		dev_err(dev, "failed to create MSI bottom domain\n");
		ret = -ENODEV;
		goto err_msi_bottom_domain;
	}

	pcie->msi_domain = pci_msi_create_irq_domain(dev->fwnode,
						     &mtk_msi_domain_info,
						     pcie->msi_bottom_domain);
	if (!pcie->msi_domain) {
		dev_err(dev, "failed to create MSI domain\n");
		ret = -ENODEV;
		goto err_msi_domain;
	}

	of_node_put(intc);
	return 0;

err_msi_domain:
	irq_domain_remove(pcie->msi_bottom_domain);
err_msi_bottom_domain:
	irq_domain_remove(pcie->intx_domain);
out_put_node:
	of_node_put(intc);

	return ret;
}

thanks,
Miles
