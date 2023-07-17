Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1F756850
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjGQPuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGQPut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 11:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3675F138;
        Mon, 17 Jul 2023 08:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26EA6104F;
        Mon, 17 Jul 2023 15:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6617DC433C8;
        Mon, 17 Jul 2023 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689609047;
        bh=+rMoQPDyuHjq34bQZY45CDuMev7tzbig9uy0a4n0uAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+enAg08ANzgoCr4LR3Ab9k3J4+WeA7DRNZQ5HJ6XuN3YdWRCKI8Zrf71W4HzdL83
         p9NkJt3P3LSG1wyDibJ94Ss0OmIrNrqogQxOc425nlbeInbTjV9EqZmdU4vNNpkr9G
         TAadskU4rxd1pSSDP8czEazIIlHAXfk/je5oPAlhFqzvZQW+wh2nBuP6x07vShAgYP
         bYNed0NNPfal4e3Ka1odzXCX42u6dMAthjS3tKlMx2hmyo/KRFysB9XGsqbge7q2Ud
         F8vjoGh/vcQNWwnqtyk/wqyOjoyshqzs+Jv62krNAqyT6nW3yl5kF/YcuKpyGLKrHy
         cmxNljSBY1KUA==
Date:   Mon, 17 Jul 2023 21:20:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: layerscape: Add support for Link down
 notification
Message-ID: <20230717155031.GA35455@thinkpad>
References: <20230615164113.2270698-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230615164113.2270698-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 15, 2023 at 12:41:11PM -0400, Frank Li wrote:
> Add support to pass Link down notification to Endpoint function driver
> so that the LINK_DOWN event can be processed by the function.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

One nit below. With that,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index de4c1758a6c3..4e4fdd1dfea7 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -88,6 +88,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>  
>  		dev_dbg(pci->dev, "Link up\n");
>  	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
> +		pci_epc_linkdown(pci->ep.epc);

It'd be good to move this call after dev_dbg().

- Mani

>  		dev_dbg(pci->dev, "Link down\n");
>  	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
>  		dev_dbg(pci->dev, "Hot reset\n");
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
