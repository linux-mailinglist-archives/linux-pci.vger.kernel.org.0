Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5824B0BC9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiBJLEw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 06:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiBJLEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 06:04:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6D91017
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 03:04:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so5189630pjm.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 03:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcIDnjucqFHIEtuPRiIEpKJm0pddeuEQPSaD1O2v22M=;
        b=ihVbyoUymsepvGgJYqBznYehBeetS7pn0LICLU5Pr8mSStejBRoZKpR9KS6bN50o7q
         3XIsIwNrfVe9xH4ZOZonSVmd9sXmxv2sSkXQYksmteB01XkwRpLNi0YAZQ3NSvGhDazG
         i712L6DXIPmfbOqGrM7yZdzS3mgMDH9zATdJ2KYpJtX8DSCb0WjiP/BZJhJGlrYohmQp
         CU8tVxIgpHLgYtCK5hi7Pu41fMSI1niRxCVlD41sC046joWTzgn5L3yiVtTdTftdergt
         wkoJ9ewCIL0xDTD8cXgzjsVawFflWLvhIRT1AliSdwqryc+sZBiFbyWACS8pnSQ5uLGA
         glYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcIDnjucqFHIEtuPRiIEpKJm0pddeuEQPSaD1O2v22M=;
        b=F+ollZ+4Dxw6JErNIiAg6y+XHV/H6jKmuiM7tTLcJyfjudyT6EodEXph3sclHbCQdj
         pv6s55J9TX3FWuOshctIfma26Uqhn/T9ryhYGP6TYQXQZpowN9gt3/0GdBVdroyf9p3M
         hv1EcJq594oO63DJ8s3r1je4kYFySlnD1QRoadYSWvofPa9SiAG3DKEodjdar7xalqU5
         UKpAkeNMZKwL13IGdNkIfaK0SxO/7bL2wzmvrZY+/K5UIlfniYLOnxLYf+AhIIGXLD/3
         CMcTFwZqrK2QWZ8Qn6V8W+2x+HBz5trYd7C5IFuDcx1bf2QICFNfvOA5P46vYjFed1bR
         fPpg==
X-Gm-Message-State: AOAM530vBIta3UPofPrAY+CNpWiCYldgYEGGkRoQ1N5YGhFKIeG+kKMO
        X1M6BAcUZVOapUCguQWpx4V6
X-Google-Smtp-Source: ABdhPJwJhEmm7+OcWCeh1ubNuw99YIEtnig+7YCj2REhxeHzMIT+RE9fylR/O6SVNKk7nrpJgMdJIg==
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr2229659pjb.38.1644491091970;
        Thu, 10 Feb 2022 03:04:51 -0800 (PST)
Received: from thinkpad ([27.111.75.88])
        by smtp.gmail.com with ESMTPSA id 3sm1814409pjk.29.2022.02.10.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 03:04:51 -0800 (PST)
Date:   Thu, 10 Feb 2022 16:34:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: designware-ep: Fix the access to DBI/iATU
 registers before enabling controller
Message-ID: <20220210110446.GD69529@thinkpad>
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 01, 2021 at 02:16:01PM +0900, Kunihiko Hayashi wrote:
> The driver using core_init_notifier, e.g. pcie-tegra194.c, runs according
> to the following sequence:
> 
>     probe()
>         dw_pcie_ep_init()
> 
>     bind()
>         dw_pcie_ep_start()
>             enable_irq()
> 
>     (interrupt occurred)
>     handler()
>         [enable controller]
>         dw_pcie_ep_init_complete()
>         dw_pcie_ep_init_notify()
> 
> After receiving an interrupt from RC, the handler enables the controller
> and the controller registers can be accessed.
> So accessing the registers should do in dw_pcie_ep_init_complete().
> 
> Currently dw_pcie_ep_init() has functions dw_iatu_detect() and
> dw_pcie_ep_find_capability() that include accesses to DWC registers.
> As a result, accessing the registers before enabling the controller,
> the access will fail.
> 
> The function dw_pcie_ep_init() shouldn't have any access to DWC registers
> if the controller is enabled after calling bind(). This moves access codes
> to DBI/iATU registers and depending variables from dw_pcie_ep_init() to
> dw_pcie_ep_init_complete().
> 
> Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Fixes: 6bfc9c3a2c70 ("PCI: designware-ep: Move the function of getting MSI capability forward")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Om Prakash Singh <omp@nvidia.com>
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
>  1 file changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 998b698..00ce83c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

[...]

>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	int ret;
> -	void *addr;
> -	u8 func_no;
>  	struct resource *res;
>  	struct pci_epc *epc;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -683,7 +721,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
>  	const struct pci_epc_features *epc_features;
> -	struct dw_pcie_ep_func *ep_func;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
>  
> @@ -705,8 +742,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		}
>  	}
>  
> -	dw_pcie_iatu_detect(pci);
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
>  		return -EINVAL;
> @@ -714,26 +749,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> -	ep->ib_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ib_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
> -	if (!ep->ib_window_map)
> -		return -ENOMEM;
> -
> -	ep->ob_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ob_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
> -	if (!ep->ob_window_map)
> -		return -ENOMEM;
> -
> -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> -			    GFP_KERNEL);
> -	if (!addr)
> -		return -ENOMEM;
> -	ep->outbound_addr = addr;
> -
>  	if (pci->link_gen < 1)
>  		pci->link_gen = of_pci_get_max_link_speed(np);
>  
> @@ -750,20 +765,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ret < 0)
>  		epc->max_functions = 1;
>  
> -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> -		if (!ep_func)
> -			return -ENOMEM;
> -
> -		ep_func->func_no = func_no;
> -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> -							      PCI_CAP_ID_MSI);
> -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> -							       PCI_CAP_ID_MSIX);
> -
> -		list_add_tail(&ep_func->list, &ep->func_list);
> -	}
> -
>  	if (ep->ops->ep_init)
>  		ep->ops->ep_init(ep);

You also need to move ep_init() as it can have DBI access too.

Thanks,
Mani

>  
> -- 
> 2.7.4
> 
