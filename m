Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE454D4C6D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 16:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiCJOzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 09:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347925AbiCJOvc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 09:51:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA71405C7;
        Thu, 10 Mar 2022 06:48:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BE0E51F45961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646923723;
        bh=ggeM4JSgsp6obEP3ZgCxoHKKLd674MO15iyeV5s6blM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LC+uup07MAznJo/9jsdRQEAgzrweUQitMhy9VfKgqhVvUFrKPUwUeFujX49LAduGQ
         gKp5GxqiLUeHMDkj+SSLrdjZ06fiCcc/wXoWXOWkaNshHeHS1IIpHTVhdH4Aw9qmRz
         +K8kUscNY15sdTmSi6/uKqCywjRfviOFJOg1dNF436U/TOeJVpjESuMspVqftyMeYp
         S2z/nCcmDGQ36Hvdc35p20o9txpYRCa0w+5iYoo79IxkU1Fr8+OVgZf5pe7CapOeyz
         HtK3ZYr6kN6wgycaNP4QE5q+hWpszYIdBJLeKx6QFWWCECxtyhFtwmu1pkFJ7FGW2S
         HhkKz0ft4OALQ==
Message-ID: <57251e6c-a5e7-2388-f30e-365c56b52a42@collabora.com>
Date:   Thu, 10 Mar 2022 15:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] PCI: mediatek: Fix refcount leak in
 mtk_pcie_subsys_powerup
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220309091953.5630-1-linmq006@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220309091953.5630-1-linmq006@gmail.com>
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

Il 09/03/22 10:19, Miaoqian Lin ha scritto:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> Fixes: 87e8657ba99c ("PCI: mediatek: Add new method to get shared pcie-cfg base address")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pci/controller/pcie-mediatek.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index ddfbd4aebdec..be8bd919cb88 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1008,6 +1008,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>   					   "mediatek,generic-pciecfg");
>   	if (cfg_node) {
>   		pcie->cfg = syscon_node_to_regmap(cfg_node);
> +		of_node_put(cfg_node);
>   		if (IS_ERR(pcie->cfg))
>   			return PTR_ERR(pcie->cfg);
>   	}
> 


