Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF56EB981
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDVOAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVOAq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 10:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1121BEB;
        Sat, 22 Apr 2023 07:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC0D460DFF;
        Sat, 22 Apr 2023 14:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630A7C433D2;
        Sat, 22 Apr 2023 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682172044;
        bh=5axBpS3Qdng3Tuqp+YaWw72zRqIzBAay+qr148X6owE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBqWynkdo41E+orAEzaFF6zb+NWVn2ShuVOm3eXqlYFYl2n+8jAH+qPG4Q3dBMKep
         zTkOZ5OlQUxNA8s8VXTmQ/HV00gth6xuBNXn4Wv8L2Yf2xKoQRSe5iKDHUG0mE95gq
         isMPFxW3kSHLalPSqSXK/HB7cVj13ClNtwSUG2min38xOSGYTc0LvwjPB4+VwzUKpr
         krh6RPiKl+oONxfohysvcR+1Bxvf8TbgAGbqVKhLaahpo74Pgnwpd4tzon7qIQIfKB
         EbsP6N20VjCvevwvglJvD6NAZFuM6ImMzs3Fx6JiG61EUXhdPputLe3Aqy7WwsjhYS
         EwNB0tj3m7pMQ==
Date:   Sat, 22 Apr 2023 19:30:34 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 15/22] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Message-ID: <20230422140034.GL4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-16-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-16-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:56PM +0900, Yoshihiro Shimoda wrote:
> One of controllers requires vender-specific initialization before

Again, specify the exact controller.

> .ep_init(). To use dw->dbi and dw->bum-lanes in the initialization

num-lanes

- Mani

> code, introduce .ep_pre_init() into struct dw_pcie_ep_ops.
> Also introduce .ep_deinit() to disable the controller by using
> vender-specific de-initialization.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 ++++++
>  drivers/pci/controller/dwc/pcie-designware.h    | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2458ca2bc0e4..a011db7e3064 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -670,6 +670,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct pci_epc *epc = ep->epc;
>  
> +	if (ep->ops->ep_deinit)
> +		ep->ops->ep_deinit(ep);
> +
>  	dw_pcie_edma_remove(pci);
>  
>  	if (ep->intx_mem)
> @@ -783,6 +786,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> +	if (ep->ops->ep_pre_init)
> +		ep->ops->ep_pre_init(ep);
> +
>  	dw_pcie_version_detect(pci);
>  
>  	dw_pcie_iatu_detect(pci);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index c4bdfed7b2e2..ae8ac15e53dc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -336,7 +336,9 @@ struct dw_pcie_rp {
>  };
>  
>  struct dw_pcie_ep_ops {
> +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
> +	void	(*ep_deinit)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
