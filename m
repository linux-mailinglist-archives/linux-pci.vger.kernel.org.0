Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A787AA58B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 01:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjIUXUY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjIUXUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 19:20:22 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 11:07:29 PDT
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E46FAF942
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 11:07:29 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jNxxqrngYWkeLjNxxqqZsH; Thu, 21 Sep 2023 19:59:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695319197;
        bh=Jy4yrl1sGF1TARfomG4wY5m/s9IFzHDGcTcBivxyLOM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R/GMDO51rXJCXspAXvO6D8ktPA7l4Cx6HvaJdkZ8Jib3GXRDdbTES4LcpDgC1K7Gy
         iVPWNtSbjmHKqo27fko5suLlO8XEsvvqR8vaHgFl1siAMZXjb9QQoN8SrACQCN+Uka
         06feaIThbzixPjiv5gEQRKcrFxrB2KKFpsHzVwLuknGXDvGzlM5QOV4MMEUqXpv+Ix
         pqPRGgCm+XTHqccjHWC1VD7YP3EMA+C9eIudi8SxwJTcm4tg/XUDvFhFLqPmM5hzxV
         Z4pT92e+AY0LLgp0kFM3cmzinTsjrtqbsVTq9WpXRMnJS9d540YGM62kakloKgds/A
         3oaNWLWsLoWFQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 21 Sep 2023 19:59:57 +0200
X-ME-IP: 86.243.2.178
Message-ID: <925da248-f582-6dd5-57ab-0fadc4e84f9e@wanadoo.fr>
Date:   Thu, 21 Sep 2023 19:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] PCI: layerscape-ep: set 64-bit DMA mask
To:     Frank Li <Frank.Li@nxp.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230921153702.3281289-1-Frank.Li@nxp.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230921153702.3281289-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 21/09/2023 à 17:37, Frank Li a écrit :
> From: Guanhua Gao <guanhua.gao@nxp.com>
> 
> Set DMA mask and coherent DMA mask to enable 64-bit addressing.
> 
> Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/pci/controller/dwc/pci-layerscape-ep.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index de4c1758a6c33..6fd0dea38a32c 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -249,6 +249,11 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>   
>   	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
>   
> +	/* set 64-bit DMA mask and coherent DMA mask */
> +	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> +		if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32)))

As stated in [1], dma_set_mask() with a 64-bit mask will never
fail if dev->dma_mask is non-NULL.

So, if it fails, the 32 bits case will also fail for the same reason.
There is no need for the 2nd test.


See [1] for Christoph Hellwig comment about it.

CJ


[1]: https://lkml.org/lkml/2021/6/7/398

> +			return -EIO;
> +
>   	platform_set_drvdata(pdev, pcie);
>   
>   	ret = dw_pcie_ep_init(&pci->ep);

