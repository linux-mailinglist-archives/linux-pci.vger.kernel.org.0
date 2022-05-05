Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87EC51BED8
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 14:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiEEMKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiEEMKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 08:10:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6781408B;
        Thu,  5 May 2022 05:06:27 -0700 (PDT)
X-UUID: e1ddf4c43ef7499faa61a641c0e9ecbe-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:2e9628d8-8aa0-4a87-b548-47385eb62df2,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:c2315216-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: e1ddf4c43ef7499faa61a641c0e9ecbe-20220505
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1038874; Thu, 05 May 2022 20:06:20 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 5 May 2022 20:06:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 May 2022 20:06:19 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 5 May 2022 20:06:18 +0800
Message-ID: <f1f18b7bc0aa126eeba39157da9cfb4c713bea2d.camel@mediatek.com>
Subject: Re: [PATCH v4] PCI: mediatek-gen3: Change driver name to
 mtk-pcie-gen3
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 5 May 2022 20:06:18 +0800
In-Reply-To: <20220505083907.86598-1-nbd@nbd.name>
References: <20220505083907.86598-1-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Felix,

Thanks for the fix.

Reviewed-by: Jianjun Wang <jianjun.wang@mediatek.com>

Thanks.

On Thu, 2022-05-05 at 10:39 +0200, Felix Fietkau wrote:
> driver_register() will refuse to register another driver with the
> same name.
> This change allows pcie-mediatek-gen3 to coexist with pcie-mediatek
> built into
> the kernel.
> 
> Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver
> for MT8192")
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 3e8d70bfabc6..2e665cd7e735 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1021,7 +1021,7 @@ static struct platform_driver mtk_pcie_driver =
> {
>  	.probe = mtk_pcie_probe,
>  	.remove = mtk_pcie_remove,
>  	.driver = {
> -		.name = "mtk-pcie",
> +		.name = "mtk-pcie-gen3",
>  		.of_match_table = mtk_pcie_of_match,
>  		.pm = &mtk_pcie_pm_ops,
>  	},

