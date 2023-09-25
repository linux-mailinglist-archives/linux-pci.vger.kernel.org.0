Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB17AD560
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 12:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjIYKJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjIYKIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 06:08:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA2BE;
        Mon, 25 Sep 2023 03:08:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50435a9f800so8146988e87.2;
        Mon, 25 Sep 2023 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695636505; x=1696241305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GpphdekrLRaCUwOFfQuvHY45rvGaKiHHJSOlSQQAnl0=;
        b=eMKJp/fFeHCrRIAFIK17Gmwb+ORRSzZ4Dq5dVO4BpoSPoChkt9aT4OEvzgJPXzJZYr
         Cw2C2uRnBLl8KOeK20ovZT0cO3Z0ivHe0jqyb35IwNz2ojgX26WV7l6WsqdsSTyxY56r
         zY+9nzIW42lwTCU2KuzP2kU7zJHGkWydPAPfX4L8EHnCCFm1EamVnZj+KHd35TTX0N8z
         zTXnLqWnooqoUCvolcJz7Fnm0qPZHYvmhIeURSsyGS60hDGzMry9/2Fdt3rReMcxO4yA
         owncDZ863MlDiZ212d9ph9lkhyE3oaNCXTdtuwPswQGQXvg6zyQ9gPCKmv5pZiJrX8TD
         6p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695636505; x=1696241305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpphdekrLRaCUwOFfQuvHY45rvGaKiHHJSOlSQQAnl0=;
        b=XPUwxs+LGo8hL+nSZGwE26+rtN3ZSOpQJtHi9tggrPUf3hOFysvPx66r49r1rzILtV
         ouBzkhE5RiURqnEAbP/b6mw37ILPRtQszpWqWaDBZ3EDNypOltHX6uaIXMMjYBu+/jpQ
         4bQY+V8GjveZp0jRtHj6d/8OOs484Sc9Y3VhuPvsrcfYcISVvgPL5EGTCbuVWwXVhWYj
         ewmoiIKpmtnGklccVM5IavdHjkuYLcbjipa4csQ/VmawSSvL1wauWEcfWgocjupufOii
         DFy3jwc1oKPLkTLrwax5822DiNQOUCxhztE3/0PMi25b8pHZfRypWcmirL/pVjDI/B/r
         Hmjg==
X-Gm-Message-State: AOJu0YxmaRxxq9jOeOu045sGxEF527/fC1stwYw9XfX1rQlX8FFplnHe
        eK7ZEG0wRtJr4ZN21KObV6c=
X-Google-Smtp-Source: AGHT+IE6v0XUrRelM7c+piL96IhoqA6NMXpTJZh71go6KOd+jktmmbbbSRKUvpcyT8YrBuYJvsVBIg==
X-Received: by 2002:a05:6512:b9b:b0:503:fee:5849 with SMTP id b27-20020a0565120b9b00b005030fee5849mr6739906lfv.53.1695636504575;
        Mon, 25 Sep 2023 03:08:24 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u27-20020ac24c3b000000b0050097974ee0sm1768059lfq.224.2023.09.25.03.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:08:24 -0700 (PDT)
Date:   Mon, 25 Sep 2023 13:08:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v22 08/16] PCI: dwc: endpoint: Introduce .pre_init() and
 .deinit()
Message-ID: <enciy4d6trdw5yaltdk6uytllljod7e54e3fsk7a3ht44j3azc@d5bethiemcxj>
References: <20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com>
 <20230925072130.3901087-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230925072130.3901087-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 25, 2023 at 04:21:22PM +0900, Yoshihiro Shimoda wrote:
> Renesas R-Car Gen4 PCIe controllers require vendor-specific
> initialization before .init().
> 
> To use dw->dbi and dw->num-lanes in the initialization code,
> introduce .pre_init() into struct dw_pcie_ep_ops. While at it,
> also introduce .deinit() to disable the controller by using
> vendor-specific de-initialization.
> 
> Note that the ep_init in the struct dw_pcie_ep_ops should be
> renamed to init later.
> 
> [kwilczynski: commit log]
> Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-13-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index a8bcbc57ef86..d34a5e87ad18 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -637,6 +637,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  			      epc->mem->window.page_size);
>  
>  	pci_epc_mem_exit(epc);
> +
> +	if (ep->ops->deinit)
> +		ep->ops->deinit(ep);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
>  
> @@ -740,6 +743,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> +	if (ep->ops->pre_init)
> +		ep->ops->pre_init(ep);
> +
>  	dw_pcie_version_detect(pci);
>  
>  	dw_pcie_iatu_detect(pci);
> @@ -794,7 +800,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  			       ep->page_size);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to initialize address space\n");
> -		return ret;
> +		goto err_ep_deinit;
>  	}
>  
>  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> @@ -831,6 +837,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> index e10f7e18b13a..8c637392ab08 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,7 +330,9 @@ struct dw_pcie_rp {
>  };
>  
>  struct dw_pcie_ep_ops {

> +	void	(*pre_init)(struct dw_pcie_ep *ep);
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
> +	void	(*deinit)(struct dw_pcie_ep *ep);

Please, note you promised to release sometime in future a cleanup
patch which drops the "ep_" prefix from here and from the
dw_pcie_host_ops structure.)

https://lore.kernel.org/linux-pci/20230802104049.GB57374@thinkpad/

-Serge(y)

>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> -- 
> 2.25.1
> 
