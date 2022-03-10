Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045344D416C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 07:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbiCJG52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 01:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiCJG51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 01:57:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BA12F166;
        Wed,  9 Mar 2022 22:56:22 -0800 (PST)
X-UUID: 0f88401c93af4acdaeca098eb708ea0c-20220310
X-UUID: 0f88401c93af4acdaeca098eb708ea0c-20220310
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 841881774; Thu, 10 Mar 2022 14:56:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 10 Mar 2022 14:56:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Mar 2022 14:56:12 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <linmq006@gmail.com>
CC:     <bhelgaas@google.com>, <chuanjia.liu@mediatek.com>,
        <jianjun.wang@mediatek.com>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <matthias.bgg@gmail.com>,
        <robh@kernel.org>, <ryder.lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup
Date:   Thu, 10 Mar 2022 14:56:12 +0800
Message-ID: <20220310065612.26452-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220309091953.5630-1-linmq006@gmail.com>
References: <20220309091953.5630-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miaoqian,

> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> Fixes: 87e8657ba99c ("PCI: mediatek: Add new method to get shared pcie-cfg base address")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index ddfbd4aebdec..be8bd919cb88 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1008,6 +1008,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>  					   "mediatek,generic-pciecfg");
>  	if (cfg_node) {
>  		pcie->cfg = syscon_node_to_regmap(cfg_node);
> +		of_node_put(cfg_node);
>  		if (IS_ERR(pcie->cfg))
>  			return PTR_ERR(pcie->cfg);
>  	}

Thanks for this patch.

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Thanks,
Miles
