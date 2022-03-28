Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E434E99E6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbiC1Ol1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbiC1Ol0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 10:41:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC0329B5;
        Mon, 28 Mar 2022 07:39:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5E5A71F437EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648478385;
        bh=YXyvPIqjtVhfNAWNbSeb5m3srTHuOI0T/YuzxaRmNXk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JMjaS2R8roR5S2Vz5q2oR1bkuGDaCYVlxLPQDdmqdbh6f9C1DfRp2/f0xoUibJyo3
         L3V1zJLK8Wls4AmCAlfzEAlXzLKMCwBxbqwwydh+VjOuGYRqOgFajGd7uWvu8BQsxJ
         ZZkWAblHtn+qzqmoQ4ZRZskL9K4JJL1P1znAztuPRoR89cStjTyeil1fUpIVr3aFbp
         sFvQ+DPUbneyQZzgx8rSJq1qQNBYLtGYf+1/upgE3+mHdYoRbr4dha37PXOwj8pvmC
         h1ETCzSffmQ+gLra+jqb+TVnzK5j5tlgaZipCLRIH0tvhS3sLX1oAsomjiPBz2083V
         7Cr7SMtP4KqrQ==
Message-ID: <cd9c7d5c-4ab6-2795-2bba-9deedb8198e3@collabora.com>
Date:   Mon, 28 Mar 2022 16:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: mediatek-gen3: Print LTSSM state when PCIe link down
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220324072548.11408-1-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220324072548.11408-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 24/03/22 08:25, Jianjun Wang ha scritto:
> Print current LTSSM state when PCIe link down instead of the register
> value, make it easier to get the link status.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

Hello Jianjun,
this patch is really helpful when comes to understand the source of an issue,
so I agree with it - and thank you for that.

Though, I think that you should still print the hex number along with the
meaning of it, check below:

> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 40 ++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 7705d61fba4c..54663f025e27 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c

..snip..

> @@ -327,8 +358,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>   				 !!(val & PCIE_PORT_LINKUP), 20,
>   				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
>   	if (err) {
> +		const char *ltssm_state;
> +		int ltssm_index;
> +
>   		val = readl_relaxed(pcie->base + PCIE_LTSSM_STATUS_REG);
> -		dev_err(pcie->dev, "PCIe link down, ltssm reg val: %#x\n", val);
> +		ltssm_index = PCIE_LTSSM_STATE(val);
> +		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
> +			      "Unknown state" : ltssm_str[ltssm_index];
> +		dev_err(pcie->dev, "PCIe link down, current ltssm state: %s\n",

There, I think that you should do:

dev_err(pcie->dev, "PCIe link down, current LTSSM state: %s (%#x)\n",
	ltssm_state, val);

this will be extremely useful in the "Unknown state" case.

After fixing that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo
