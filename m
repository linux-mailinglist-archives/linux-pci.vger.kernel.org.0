Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2565375F552
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGXLkY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGXLkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 07:40:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284610E3
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:40:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2632336f75fso2683534a91.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690198813; x=1690803613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pl6d3M0hehvgH0Yirik992Buoa0/dKM8PGZb9G+lsBo=;
        b=qm0Iz3UXFzn+1zi2ybe8UoeKg+fCjjdBbH3ni2uC4J7HA4ooeIQ3bPfPl8irgzTwpW
         j107/e563ckFy9gBEOO6+7DxOBmuDccjSU0VBgexZ0VG81hD9Gk4ve/kZZvNxNYYEWsf
         rS/vVreG7MMLozHv3aD2bEJaYHzq8cAWFfsVSk4tK0rT8UVcVXHpkayOIuJhsO2g1dNI
         z1EkeZtG0vdRSJTiJXKrFBIuMhdhqO0jrJLLOrpf9u+kSMnzZj6bAD4AKs4nfLILIXBC
         F8+TpCbCFwwMql0lsEs8JW/h55RaHjB6Sc4lfogKGOCFwjOJHKtBob6iRZEeUC+cnkFx
         yIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198813; x=1690803613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl6d3M0hehvgH0Yirik992Buoa0/dKM8PGZb9G+lsBo=;
        b=b9SrVrtHCxyVia9IXGM1yKAPb6KyOgA4TrjUzevQscC3AmZwtGDH9nCQHvWtnzwyzk
         WvkXnt3B5/5IGpZRjZbSJBSzSAbViEDFeXj57YkrghGT+vUOXPCbVaStZIqhRLAm4Vgg
         2/fVf8ulkIieGTPAyyG91L8LaUJ1zGm7NxyLLCJCYsg4qNJxNevTqSwndZ3ZR2mLN5AR
         WlidKXvJTRM9JWHoVxxgOks/jAkXBShNy6kIETtMrSdv8tf1GZ7TNXRloyoaULWZ8jvk
         J+6IGKMmXYE6keKdjIgEB5xE9dmqpftrRiY8jLE0sioRRwpNuu/jA2Z8+QbhiuQBpwQZ
         mzzQ==
X-Gm-Message-State: ABy/qLYeuVGUUv2nrqsCjbg+xcCAsr3fEoQzhejAHJfGxZLLCxCbCjFH
        QzA4cBYadLqRz8tarDwvQEkX
X-Google-Smtp-Source: APBJJlGaeMZ0FedkkRHTpEo9sL6WwPNThZ1JW24R4hofjfKiyr+tOUoa0E3BfOpO8B4R4eI5HZA6Jw==
X-Received: by 2002:a17:90a:6fa7:b0:267:f12e:3684 with SMTP id e36-20020a17090a6fa700b00267f12e3684mr7920677pjk.23.1690198813255;
        Mon, 24 Jul 2023 04:40:13 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090ad24d00b00267f9bf21ebsm3060492pjw.0.2023.07.24.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:40:12 -0700 (PDT)
Date:   Mon, 24 Jul 2023 17:10:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Message-ID: <20230724114005.GL6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Since the struct name itself has "ep", there is no need to add the "ep" suffix
to callbacks. You should fix the existing ep_init callback too in a separate
patch.

(this series is just GROWING!!!)

- Mani

>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
