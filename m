Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552624EA4DF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 04:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiC2CC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 22:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiC2CCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 22:02:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E52DABC;
        Mon, 28 Mar 2022 19:01:08 -0700 (PDT)
X-UUID: 054e1df1decb452e8c3a3b1391e3a412-20220329
X-UUID: 054e1df1decb452e8c3a3b1391e3a412-20220329
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1275001745; Tue, 29 Mar 2022 10:00:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Mar 2022 10:00:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 10:00:50 +0800
Message-ID: <c074fc33a64bd09b583b0aae58e950b0d826d82e.camel@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Print LTSSM state when PCIe link
 down
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Tue, 29 Mar 2022 10:00:49 +0800
In-Reply-To: <cd9c7d5c-4ab6-2795-2bba-9deedb8198e3@collabora.com>
References: <20220324072548.11408-1-jianjun.wang@mediatek.com>
         <cd9c7d5c-4ab6-2795-2bba-9deedb8198e3@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2022-03-28 at 16:39 +0200, AngeloGioacchino Del Regno wrote:
> Il 24/03/22 08:25, Jianjun Wang ha scritto:
> > Print current LTSSM state when PCIe link down instead of the
> > register
> > value, make it easier to get the link status.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> Hello Jianjun,
> this patch is really helpful when comes to understand the source of
> an issue,
> so I agree with it - and thank you for that.
> 
> Though, I think that you should still print the hex number along with
> the
> meaning of it, check below:
> 
> > ---
> >   drivers/pci/controller/pcie-mediatek-gen3.c | 40
> > ++++++++++++++++++++-
> >   1 file changed, 39 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index 7705d61fba4c..54663f025e27 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> 
> ..snip..
> 
> > @@ -327,8 +358,15 @@ static int mtk_pcie_startup_port(struct
> > mtk_gen3_pcie *pcie)
> >   				 !!(val & PCIE_PORT_LINKUP), 20,
> >   				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
> >   	if (err) {
> > +		const char *ltssm_state;
> > +		int ltssm_index;
> > +
> >   		val = readl_relaxed(pcie->base +
> > PCIE_LTSSM_STATUS_REG);
> > -		dev_err(pcie->dev, "PCIe link down, ltssm reg val:
> > %#x\n", val);
> > +		ltssm_index = PCIE_LTSSM_STATE(val);
> > +		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
> > +			      "Unknown state" : ltssm_str[ltssm_index];
> > +		dev_err(pcie->dev, "PCIe link down, current ltssm
> > state: %s\n",
> 
> There, I think that you should do:
> 
> dev_err(pcie->dev, "PCIe link down, current LTSSM state: %s (%#x)\n",
> 	ltssm_state, val);
> 
> this will be extremely useful in the "Unknown state" case.
> 
> After fixing that,
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Thanks!

> 
> Regards,
> Angelo

