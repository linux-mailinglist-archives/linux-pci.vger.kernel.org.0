Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8F543D93
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 22:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiFHU1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 16:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiFHU1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 16:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2A3CED0D;
        Wed,  8 Jun 2022 13:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E50261CCD;
        Wed,  8 Jun 2022 20:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5E5C3411C;
        Wed,  8 Jun 2022 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654720062;
        bh=NCiPRBT7x1o9zpYHvyH0ripFKIBsNwF5rD+sMS2o2ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XOK89JgFopwc52G1Bm+P5zjfJlTK8R0rOn7zvZPox+88OfzC5EACYFXoJf+TjkJDU
         sU4SsfQ5hbn7S8SwrxbORRsVXd3aKGc5A8BQI6D7FkRfdNb2g0jO7Nt0gQ+bimPXBg
         5SZnd7ZajIbNhw4hH0OxiL0UHCoknuYh9e3R/hy6LHJreJ1Yt/f0O26n94J22xIuQA
         fpH9hlaLJr6uuPgd6miEk/zhTCfmpI07SCAklgbyVM9sj9d0zcJBgEPIN3dNJHfHNY
         uKu1OiJU6Tw6AQAYr3di+5Jndp91+djpYGmPp/nLLBEgLM2aXidXTi72GwC2ELu0qg
         Fi/CDsJCmp5FA==
Date:   Wed, 8 Jun 2022 15:27:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: microchip: Fix refcount leak in
 mc_pcie_init_irq_domains
Message-ID: <20220608202740.GA419783@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605055123.59127-1-linmq006@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 05, 2022 at 09:51:23AM +0400, Miaoqian Lin wrote:
> of_get_next_child() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> This function only call of_node_put() in normal path,
> missing it in some error paths.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied with Rob's reviewed-by to pci/ctrl/microchip for v5.20,
thanks!

> ---
>  drivers/pci/controller/pcie-microchip-host.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index dd5dba419047..7263d175b5ad 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -904,6 +904,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
>  						   &event_domain_ops, port);
>  	if (!port->event_domain) {
>  		dev_err(dev, "failed to get event domain\n");
> +		of_node_put(pcie_intc_node);
>  		return -ENOMEM;
>  	}
>  
> @@ -913,6 +914,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
>  						  &intx_domain_ops, port);
>  	if (!port->intx_domain) {
>  		dev_err(dev, "failed to get an INTx IRQ domain\n");
> +		of_node_put(pcie_intc_node);
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.25.1
> 
