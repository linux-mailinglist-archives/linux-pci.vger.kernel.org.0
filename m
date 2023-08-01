Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E976A581
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 02:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjHAAXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 20:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjHAAXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 20:23:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E41FD3;
        Mon, 31 Jul 2023 17:22:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso1771786e87.0;
        Mon, 31 Jul 2023 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690849352; x=1691454152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LLMd6bbDLLF7RHNDTiK52e0HGQhaXIugL3c8lHXTjo=;
        b=dUCu736n3nmgS3GRm8HGZOvSjjgZ+PmGRf28Xnf1ANdktNwzEYrJ/tnizzrM/rdL+J
         Ytdvrb1Miiejpfind+vInzwOzME+EYCYLyFkvF+RnZ+ZL7ooZDwwqUebuRrUB+RcsAq2
         9zRHmerAkBLl0/aCMifDuUSSIM/7d2dMN2fSybbKKZeKisea/uCfvpRzWITsq8vXN/9W
         xJTK/joM7x8MB19fLwTpNLzwJaibiQTXpDv4Tai/QnUdhuLL94+A7vmEbXj+9owRY69m
         QHNx2yDD9ch7bddn1QtxAG1FdPEiTSoO0g/6T7xeq5nXnVfIP1iK7TjIjEttVqAUzIdk
         7+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690849352; x=1691454152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LLMd6bbDLLF7RHNDTiK52e0HGQhaXIugL3c8lHXTjo=;
        b=GPA2HgOkP1/lRgLZCTkgv/V1XYHVcPzAfX16dZQh00+uqfJFP91eBEV1ykG3VdSPzg
         u/FZfFNsSr1lCi4xVj4QveJ1gZ+tRIRLu9r+YMtXVCn5Rpo1fxDNCfXeMlbGt8NM9y/u
         DvlUFC8cV7r3hRaKs2PxXG4e17I6BBO9hTCXWFPmElmGH8xOljQITqczOHif655Z16CL
         lBuisqq7/D3aHH1HKgYXREj+J//Wn+CKaL3lc0qFI/XEJZpgby6O51wGXIH1S0gDIERe
         a19FiZM9Q/YQ6EJQ7Nz0GwtsNZvdFY5alAZapDHE1pgJq70uEJdzlRyeEcxM13kWaRot
         w1VQ==
X-Gm-Message-State: ABy/qLb8O3DxfslXhmmVwQGO1xE7+F5dBwEqNQksfFzghbooAOtBLloj
        jyeJN7JyjMfB4tUl9whOOWw=
X-Google-Smtp-Source: APBJJlEzb1QLoylSRXp1D4jCBKYmrrC3aEuVEscD8Ow9tAno8B0f1Y/IOVBpa1PhyZVHwCGZvPnYMA==
X-Received: by 2002:ac2:5b9c:0:b0:4fb:8f79:631 with SMTP id o28-20020ac25b9c000000b004fb8f790631mr1027381lfn.46.1690849351803;
        Mon, 31 Jul 2023 17:22:31 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id d5-20020ac24c85000000b004fc863a0bf6sm2299066lfl.223.2023.07.31.17.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 17:22:31 -0700 (PDT)
Date:   Tue, 1 Aug 2023 03:22:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Message-ID: <tv2zdgteqgbk4pxa5mh7eihbtif3hokjemy7gui6uof6rkxj4s@ffxyoqfs5fsj>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:45PM +0900, Yoshihiro Shimoda wrote:
> Renesas R-Car Gen4 PCIe controllers require vender-specific
> initialization before .ep_init(). To use dw->dbi and dw->num-lanes
> in the initialization code, introduce .ep_pre_init() into struct
> dw_pcie_ep_ops. Also introduce .ep_deinit() to disable the controller
> by using vender-specific de-initialization.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 ++++++
>  drivers/pci/controller/dwc/pcie-designware.h    | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 14c641395c3b..52b3e7f67513 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -684,6 +684,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct pci_epc *epc = ep->epc;
>  

> +	if (ep->ops->ep_deinit)
> +		ep->ops->ep_deinit(ep);
> +

This doesn't seem like a correct place to call the de-initialization
callback. I also don't see you adding the de-initialization to the
cleanup-on-error path of the dw_pcie_ep_init() method. You need to add
it there it. Afterwards you'll see a correct place for it in the
dw_pcie_ep_exit() function.

-Serge(y)

>  	dw_pcie_edma_remove(pci);
>  
>  	if (ep->intx_mem)
> @@ -797,6 +800,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> index 6821446d7c66..c3aeafd0f4c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -332,7 +332,9 @@ struct dw_pcie_rp {
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
