Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137955E84B5
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiIWVOp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWVOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 17:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000336DD3;
        Fri, 23 Sep 2022 14:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A06E616C6;
        Fri, 23 Sep 2022 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C2FC433D6;
        Fri, 23 Sep 2022 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663967681;
        bh=5eV5oae5IogxFEibo+YbsDwpSJMyOm4+PnytOZievbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FD8sRLDPNfI7jbxrFwUDZleTafq1KSpS/ZiCWDfez7aZyBEW0XceQwkmHD+h2QxZ0
         P6VEmsq73Mo4MQZMXQbQHz3HHdjg9PpD3auNrgVEiWmkl4L7Vzgz//hazhgEIqKMSf
         YhSflMFtnz7gVlbDsmF64sOQXt6+wglTsRHQzrb5RyP4be7yxAeErGQDIga7PczSAs
         ucUEqKwHgcFPbnBz814coUGwHpGxSNm/YSRx0T82YOLJU9yIy/hLlqzizEmUwWoXIW
         od/IRxWTgGW9gNdaYFQbfUAV6/o15NcqOT1uY0Y/qrr3HayWvWl1FllyEx6Jn07Lug
         7gEIOX/bGHApQ==
Date:   Fri, 23 Sep 2022 16:14:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] PCI: fu740: do not use clock name when requesting clock
Message-ID: <20220923211439.GA1418979@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907054020.745672-1-uwu@icenowy.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 07, 2022 at 01:40:20PM +0800, Icenowy Zheng wrote:
> The DT binding of FU740 PCIe does not enforce a clock-names property,
> and there exist some device tree that has a clock name that does not
> stick to the one used by Linux DT (e.g. the one shipped with current
> U-Boot mainline).
> 
> Drop the name in the clock request, instead just pass NULL (because
> this device should have only a single clock).

If you rework this for any reason, please capitalize the subject line
to match the convention:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/pci/controller/dwc/pcie-fu740.c

> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 0c90583c078b..edb218a37a4f 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -315,7 +315,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get pwren-gpios\n");
>  
>  	/* Fetch clocks */
> -	afp->pcie_aux = devm_clk_get(dev, "pcie_aux");
> +	afp->pcie_aux = devm_clk_get(dev, NULL);
>  	if (IS_ERR(afp->pcie_aux))
>  		return dev_err_probe(dev, PTR_ERR(afp->pcie_aux),
>  					     "pcie_aux clock source missing or invalid\n");
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
