Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86B535BCD
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348190AbiE0Ipn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 04:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiE0Ipl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 04:45:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E059B9D;
        Fri, 27 May 2022 01:45:31 -0700 (PDT)
X-UUID: 78e4fe7e29704432845ff86dfdad2977-20220527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:9dd5d495-a196-4dc8-940e-103f1e332e10,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:98917ab8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 78e4fe7e29704432845ff86dfdad2977-20220527
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2107655323; Fri, 27 May 2022 16:45:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 27 May 2022 16:45:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 27 May 2022 16:45:25 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <linmq006@gmail.com>
CC:     <bhelgaas@google.com>, <jianjun.wang@mediatek.com>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <robh@kernel.org>, <ryder.lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains
Date:   Fri, 27 May 2022 16:45:25 +0800
Message-ID: <20220527084525.7170-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220526110246.53502-1-linmq006@gmail.com>
References: <20220526110246.53502-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miaoqian,

>Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>---
> drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
>index 3e8d70bfabc6..da8e9db0abdf 100644
>--- a/drivers/pci/controller/pcie-mediatek-gen3.c
>+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>@@ -600,6 +600,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
> 						  &intx_domain_ops, pcie);
> 	if (!pcie->intx_domain) {
> 		dev_err(dev, "failed to create INTx IRQ domain\n");
>+		of_node_put(intc_node);
> 		return -ENODEV;
> 	}

Thanks for doing this.

I checked mtk_pcie_init_irq_domains() and there are multiple exit paths like
err_msi_domain and err_msi_bottom_domain and the normal path which also
need of_node_put(intc_node).

Maybe we can move the of_node_put(intc_node) to #54 below and cover
all possible paths?


cheers,
Miles

e.g.,

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
	of_node_put(intc_node);
	if (!pcie->intx_domain) {
		dev_err(dev, "failed to create INTx IRQ domain\n");
		return -ENODEV;
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

	return 0;

err_msi_domain:
	irq_domain_remove(pcie->msi_bottom_domain);
err_msi_bottom_domain:
	irq_domain_remove(pcie->intx_domain);

	return ret;
}
> 
>-- 
>2.25.1


