Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F06544157
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiFICQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 22:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFICQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 22:16:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297EF1C104;
        Wed,  8 Jun 2022 19:16:55 -0700 (PDT)
X-UUID: 476d66d675da4ee4a252b7fb908e3250-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:08e46c2e-7abf-49af-b175-4dac73e3840a,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:154c2ce5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 476d66d675da4ee4a252b7fb908e3250-20220609
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1782568550; Thu, 09 Jun 2022 10:16:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 9 Jun 2022 10:16:47 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 9 Jun 2022 10:16:46 +0800
Message-ID: <f3f38fe193b949956691ed788e23e3c3bd59c2da.camel@mediatek.com>
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Fix refcount leak in
 mtk_pcie_init_irq_domains
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>
CC:     <miles.chen@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Marc Zyngier" <maz@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 9 Jun 2022 10:16:46 +0800
In-Reply-To: <20220608212058.GA424368@bhelgaas>
References: <20220608212058.GA424368@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, 2022-06-08 at 16:20 -0500, Bjorn Helgaas wrote:
> On Wed, Jun 01, 2022 at 08:12:58AM +0400, Miaoqian Lin wrote:
> > of_get_child_by_name() returns a node pointer with refcount
> > incremented, we should use of_node_put() on it when not need
> > anymore.
> > Add missing of_node_put() to avoid refcount leak.
> > 
> > Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> 
> Can we get an ack from Ryder or Jianjun, as well, since they're
> listed
> as maintainers?

Sure, thanks for the reminder.

Acked-by: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> > ---
> > changes in v2:
> > - move of_node_put(intc_node) right after irq_domain_add_linear to
> > cover
> > normal path and error paths.
> > ---
> > changes in v3:
> > - call of_node_put() in error paths with goto, and call
> > of_node_put() before
> >   return 0 in normal path. Since this function has a goto part to
> > handle
> >   resources, so put them together, as suggested by Miles Chen <
> > miles.chen@mediatek.com>
> > 
> > v1 link: 
> > https://lore.kernel.org/all/20220526110246.53502-1-linmq006@gmail.com/
> > v2 link: 
> > https://lore.kernel.org/all/20220530064807.34534-1-linmq006@gmail.com/
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index 3e8d70bfabc6..bceed28446ed 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -600,7 +600,8 @@ static int mtk_pcie_init_irq_domains(struct
> > mtk_gen3_pcie *pcie)
> >  						  &intx_domain_ops,
> > pcie);
> >  	if (!pcie->intx_domain) {
> >  		dev_err(dev, "failed to create INTx IRQ domain\n");
> > -		return -ENODEV;
> > +		ret = -ENODEV;
> > +		goto out_put_node;
> >  	}
> >  
> >  	/* Setup MSI */
> > @@ -623,13 +624,15 @@ static int mtk_pcie_init_irq_domains(struct
> > mtk_gen3_pcie *pcie)
> >  		goto err_msi_domain;
> >  	}
> >  
> > +	of_node_put(intc_node);
> >  	return 0;
> >  
> >  err_msi_domain:
> >  	irq_domain_remove(pcie->msi_bottom_domain);
> >  err_msi_bottom_domain:
> >  	irq_domain_remove(pcie->intx_domain);
> > -
> > +out_put_node:
> > +	of_node_put(intc_node);
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.25.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

