Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D815978568D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjHWLOI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjHWLOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 07:14:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08354E54;
        Wed, 23 Aug 2023 04:14:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so8739482e87.1;
        Wed, 23 Aug 2023 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692789244; x=1693394044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LFiYT+pIjp+Hsb3mX0ePhlRFgF0GYMvthbRS9/QaYc=;
        b=k5rNDQfd1CgQrGDl2UgR2a+v7kZTRPgc3icHUApqMK8NAZ3zUsojnh1HG6YzHQUlNs
         V4rFz+DITZyCBCNmRe1ytB4Ohfekl2ZpME3zn2o3loBh9BMycx07PrCuD/EoyaZ27ED5
         s10fzT3fAUeJZyB3GCYMIN3SFP29RBr8Pa2pcsYF6a0hlDh8UWSxb0XgygcMhAuBPhfJ
         OcFCCcpZdlEPKU09meWYrb88w7YBJcqJB50eWE4AxDcC/gOeUKzFO3XXH21tFEM329HK
         nc8PD7cyqFokAcyJW0o7xDnH+eO3r3RjFD8vt7oj76fGfnSXtFbfo9nFDjhPwZQRYaaQ
         4fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692789244; x=1693394044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LFiYT+pIjp+Hsb3mX0ePhlRFgF0GYMvthbRS9/QaYc=;
        b=MeK4uo+4VjsdGzUxfnDeHR4po9ogMTz2J52hocljX4zvA7yj/UZzptscAeiSl2IjhW
         ZByO2+rg8cD94Leo/tSgJCwPeKFa67okM6z4E+9eQrVZN/4nJ4SaWwGLTM5uxtpmKzLv
         R+TmEn1Tyb06ZD3KaHCIdC/nBp+WbHFLPtI3K1+u+n0LideQV1a8wf57vc1QrIxyu4Wd
         69R3X2EJ/nxV2ExuDPshzSvHzF0dPYd+in3AOautYmpy0QPNtqqCXhXDia7kDf03IdjI
         gnC5GObAC5IzTwuOWKybpUM2v2FTkmk75XfC5vZ5HT3Y8H3rGs+XYKj53KqRUhwWfWf1
         RxFQ==
X-Gm-Message-State: AOJu0YyiFFm4bTC4kwe5CKiQfRPDzBIE76BCgaK4IPMxAlf7hDBW2hwT
        Xb3on4t8CGvfQ9uJlT7zM8c=
X-Google-Smtp-Source: AGHT+IGEhuX3AJgr7kRRmlBb7GnCKIL6iyJhI2LWkVfTFbXR99qexfNvmCi7FMFQfKH9KGaz7QzKzw==
X-Received: by 2002:ac2:4c52:0:b0:4fe:7e1f:766a with SMTP id o18-20020ac24c52000000b004fe7e1f766amr11911255lfk.24.1692789243814;
        Wed, 23 Aug 2023 04:14:03 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b15-20020ac247ef000000b004ffa0e5d805sm2592714lfp.174.2023.08.23.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:14:03 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:14:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v19 12/19] PCI: dwc: endpoint: Introduce .pre_init() and
 .deinit()
Message-ID: <asg4u7vfyk5scq4wzzpfogdhrnzrlz77gxrn76ak4jfwixj4ej@qztokrh6lyys>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-13-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823091153.2578417-13-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:11:46PM +0900, Yoshihiro Shimoda wrote:
> Renesas R-Car Gen4 PCIe controllers require vendor-specific
> initialization before .init(). To use dw->dbi and dw->num-lanes
> in the initialization code, introduce .pre_init() into struct
> dw_pcie_ep_ops. Also introduce .deinit() to disable the controller
> by using vendor-specific de-initialization.
> 

> Note that the ep_init in the struct dw_pcie_ep_ops should be renamed
> to init later.

Note this message look very little related to the patch itself. If you
want to signify your agreement with Mani then just put that note below
the "---" line.

Anyway. The callbacks execution order looks correct now. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 9a51a723b892..ea8063742fac 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -695,6 +695,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  			      epc->mem->window.page_size);
>  
>  	pci_epc_mem_exit(epc);
> +
> +	if (ep->ops->deinit)
> +		ep->ops->deinit(ep);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
>  
> @@ -798,6 +801,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> +	if (ep->ops->pre_init)
> +		ep->ops->pre_init(ep);
> +
>  	dw_pcie_version_detect(pci);
>  
>  	dw_pcie_iatu_detect(pci);
> @@ -852,7 +858,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  			       ep->page_size);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to initialize address space\n");
> -		return ret;
> +		goto err_ep_deinit;
>  	}
>  
>  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> @@ -898,6 +904,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  err_exit_epc_mem:
>  	pci_epc_mem_exit(epc);
>  
> +err_ep_deinit:
> +	if (ep->ops->deinit)
> +		ep->ops->deinit(ep);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 89999c483c37..77a9c3e70120 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -332,7 +332,9 @@ struct dw_pcie_rp {
>  };
>  
>  struct dw_pcie_ep_ops {
> +	void	(*pre_init)(struct dw_pcie_ep *ep);
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
> +	void	(*deinit)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     unsigned int type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> -- 
> 2.25.1
> 
