Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182985752F0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiGNQh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 12:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGNQh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 12:37:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980505B046
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 09:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB130B82734
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 16:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3BEC34114;
        Thu, 14 Jul 2022 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657816673;
        bh=LoRMLbsJSiz2uV9HxM9Pd+B6PUot+/R+NJMAeKAqcj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EFrT+sPWfpXWX5sLwfDPAgkB0Sxdt6gKyV9BliUFRBjyYQvEtr74p8ecB1SKcJ5zX
         3RAB4sGCY6a/Zcrq6x/1LTb6grSAaAQaLJo2ZtelqPOYdPzzKCq4yYC8/totmjHe8P
         VdwhjoUH/6X1qii6ShDPRNL52pRUHuhJRpRA68mF6AvBt48V3qqzimDApwC2G6M++E
         sZ1XNq1oKcc0+ZT7rmVORQkGM+X/2uojFxKdtyUMdGSJVV+AiagGmc1IM9bgtxBEmv
         fBPIsR0vZpUe37e0ws3SKPDObJs8xIu29DyU3N7ivAP37+daqkPjD451reYUNmhwnd
         39Co3k2UZgYow==
Date:   Thu, 14 Jul 2022 11:37:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     Zhiqiang.Hou@nxp.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linmq006@gmail.com
Subject: Re: [PATCH] pci: controller: mobiveil: Hold reference returned by
 of_parse_phandle()
Message-ID: <20220714163751.GA930301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704062608.273440-1-windhl@126.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 02:26:08PM +0800, Liang He wrote:
> In ls_g4_pcie_probe(), we should hold the reference returned by
> of_parse_phandle() and use it to call of_node_put() for refcount
> balance.
> 
> Fixes: d29ad70a813b ("PCI: mobiveil: Add PCIe Gen4 RC driver for Layerscape SoCs")
> Co-authored-by: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> index d7b7350f02dd..075aa487f92e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> +++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> @@ -204,13 +204,15 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
>  	struct pci_host_bridge *bridge;
>  	struct mobiveil_pcie *mv_pci;
>  	struct ls_g4_pcie *pcie;
> -	struct device_node *np = dev->of_node;
> +	struct device_node *np = dev->of_node, *parse_np;
>  	int ret;
>  
> -	if (!of_parse_phandle(np, "msi-parent", 0)) {
> +	parse_np = of_parse_phandle(np, "msi-parent", 0);

I don't understand what's going on here.  Where is "msi-parent"
actually used?  If we just need to know whether "msi-parent" exists,
can we use of_property_read_bool() instead?  Or can we call
of_parse_phandle() closer to where it is used?  

> +	if (!parse_np) {
>  		dev_err(dev, "Failed to find msi-parent\n");
>  		return -EINVAL;
>  	}
> +	of_node_put(parse_np);
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>  	if (!bridge)
> -- 
> 2.25.1
> 
