Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBEF7E99EB
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjKMKOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 05:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMKOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 05:14:53 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD37135;
        Mon, 13 Nov 2023 02:14:49 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso58986971fa.1;
        Mon, 13 Nov 2023 02:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699870488; x=1700475288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0RqJAesnLOhzqnQSk9CfR+Rzcd6ShMRpJ1TMCxlV2E=;
        b=LB010XdRBni1jumFepl4RjdbjuUf7DXfN4gArk4S9vKQW0kLr0EqW4a8HhhTZv9+8l
         0QW+9OAluwoMeqR/FIRcaP+UNivWW/TwkZJygFXP6jF1wEwv1IJnER7NQ89sAKdopDji
         VYnXBmQSqJ0cfGA5nmqks3JFiDnlJ/Tt3kyJARow1EFVzfnu4Aq6O33Kds4F3QyuZGBq
         hZ8WWnAXE8+gVewmDcdnY4xXzMQ2QXr/F3R0vauHncDYWb0X59S4V2eDdg7HDL8ktAC2
         GTHzyOVlKKN6DkVMMnfbhvauMuwLo3exvVfuxhorbIQNBjX4XOtUoI6fPUEAjN+lBtux
         SAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870488; x=1700475288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0RqJAesnLOhzqnQSk9CfR+Rzcd6ShMRpJ1TMCxlV2E=;
        b=oaYtrn16+E0rV4dU6NWUI8Q7Los1kU6JpJQaELoZeRQVGUenYhWqMMLjx9EN4fLUYC
         Iq83QVbpkjDFp0zNT0VNbPUF26W+M1buY9Yg/DKYNR8sZM5mfgCsK+ipXwl8m2V4XUMw
         H3OnV6GZf8ZAJo7Hq6XikS6+gSxvfnisIa8/LiFH9JNZX13hK18NCBI7X7wZrtqf2bqa
         Lps6FWXsx4plXNJau8GI6kju0cLvPH7nMkgeRN59yBIEmLuCj+JmqTgzHLn1e/bVUXjY
         hC+hqjCxL7uAIMnn279+It5dFaqgr6KKL706a/dOZoT9cr4RIrM3ACxD7a/MgzFwMDUV
         yMIQ==
X-Gm-Message-State: AOJu0Yx56Xi36T03necxsUa/+jPECgZ8cYE0Z7fi/7aq1rTIYVOMJSsK
        InuddvIotmMxCGHEbm4/0dg=
X-Google-Smtp-Source: AGHT+IHM5/QmkB3bPtVdHeH9fM8wWz3y2IyrjLW/unc08806uxzrYjPHf1mLAGOQOEumUgls4zeWsQ==
X-Received: by 2002:a2e:9348:0:b0:2c5:1ee1:8335 with SMTP id m8-20020a2e9348000000b002c51ee18335mr4325531ljh.28.1699870487295;
        Mon, 13 Nov 2023 02:14:47 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b2-20020a2e8942000000b002bfec05a693sm944182ljk.22.2023.11.13.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:14:46 -0800 (PST)
Date:   Mon, 13 Nov 2023 13:14:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
Message-ID: <ctr22275xmbx2ztoo43fr5b4p4252j2ygqxzeybbmiwcghzho6@gglrclbpj6xj>
References: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
 <20231113013300.2132152-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113013300.2132152-2-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro.

On Mon, Nov 13, 2023 at 10:32:58AM +0900, Yoshihiro Shimoda wrote:
> Since the name of dw_pcie_ep_ops indicates that it's for ep obviously,
> rename a member .ep_init to .init.

Thanks for the series. This change particularly looks good. But since
you are fixing the redundant prefixes anyway, could you also fix the
dw_pcie_host_ops structure too (drop host_ prefixes from the
.host_init() and .host_deinit() fields)? The change was discussed a
while ago here
https://lore.kernel.org/linux-pci/20230802104049.GB57374@thinkpad/
in the context of your long-going patchset.

It's better to be done in the framework of a separate patch released
within this series.

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
>  drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
>  drivers/pci/controller/dwc/pci-keystone.c         | 2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 2 +-
>  12 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index b445ffe95e3f..f9182cd6fe67 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -436,7 +436,7 @@ dra7xx_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
> -	.ep_init = dra7xx_pcie_ep_init,
> +	.init = dra7xx_pcie_ep_init,
>  	.raise_irq = dra7xx_pcie_raise_irq,
>  	.get_features = dra7xx_pcie_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 74703362aeec..737d4d90fef2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1093,7 +1093,7 @@ imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
> -	.ep_init = imx6_pcie_ep_init,
> +	.init = imx6_pcie_ep_init,
>  	.raise_irq = imx6_pcie_ep_raise_irq,
>  	.get_features = imx6_pcie_ep_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 0def919f89fa..655c7307eb88 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -944,7 +944,7 @@ ks_pcie_am654_get_features(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops ks_pcie_am654_ep_ops = {
> -	.ep_init = ks_pcie_am654_ep_init,
> +	.init = ks_pcie_am654_ep_init,
>  	.raise_irq = ks_pcie_am654_raise_irq,
>  	.get_features = &ks_pcie_am654_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 3d3c50ef4b6f..4e4b687ef508 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -195,7 +195,7 @@ static unsigned int ls_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
>  }
>  
>  static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
> -	.ep_init = ls_pcie_ep_init,
> +	.init = ls_pcie_ep_init,
>  	.raise_irq = ls_pcie_ep_raise_irq,
>  	.get_features = ls_pcie_ep_get_features,
>  	.func_conf_select = ls_pcie_ep_func_conf_select,
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 9b572a2b2c9a..27ff425c0698 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -370,7 +370,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  }
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
> -	.ep_init = artpec6_pcie_ep_init,
> +	.init = artpec6_pcie_ep_init,
>  	.raise_irq = artpec6_pcie_raise_irq,
>  };
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f6207989fc6a..ea99a97ce504 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -794,8 +794,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		list_add_tail(&ep_func->list, &ep->func_list);
>  	}
>  
> -	if (ep->ops->ep_init)
> -		ep->ops->ep_init(ep);
> +	if (ep->ops->init)
> +		ep->ops->init(ep);
>  
>  	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
>  			       ep->page_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index b625841e98aa..97088b7663e0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -74,7 +74,7 @@ dw_plat_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
> -	.ep_init = dw_plat_pcie_ep_init,
> +	.init = dw_plat_pcie_ep_init,
>  	.raise_irq = dw_plat_pcie_ep_raise_irq,
>  	.get_features = dw_plat_pcie_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 55ff76e3d384..cad0e4c24e11 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -332,7 +332,7 @@ struct dw_pcie_rp {
>  
>  struct dw_pcie_ep_ops {
>  	void	(*pre_init)(struct dw_pcie_ep *ep);
> -	void	(*ep_init)(struct dw_pcie_ep *ep);
> +	void	(*init)(struct dw_pcie_ep *ep);
>  	void	(*deinit)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 289bff99d762..3c38e047d5ed 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -325,7 +325,7 @@ keembay_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops keembay_pcie_ep_ops = {
> -	.ep_init	= keembay_pcie_ep_init,
> +	.init	= keembay_pcie_ep_init,
>  	.raise_irq	= keembay_pcie_ep_raise_irq,
>  	.get_features	= keembay_pcie_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 9e58f055199a..2b6f7c144c61 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -796,7 +796,7 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops pci_ep_ops = {
> -	.ep_init = qcom_pcie_ep_init,
> +	.init = qcom_pcie_ep_init,
>  	.raise_irq = qcom_pcie_ep_raise_irq,
>  	.get_features = qcom_pcie_epc_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 3bc45e513b3d..2b7e0f213fb2 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -408,7 +408,7 @@ static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
>  	.pre_init = rcar_gen4_pcie_ep_pre_init,
> -	.ep_init = rcar_gen4_pcie_ep_init,
> +	.init = rcar_gen4_pcie_ep_init,
>  	.deinit = rcar_gen4_pcie_ep_deinit,
>  	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
>  	.get_features = rcar_gen4_pcie_ep_get_features,
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index cba3c88fcf39..40bd468f7e11 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -284,7 +284,7 @@ uniphier_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops uniphier_pcie_ep_ops = {
> -	.ep_init = uniphier_pcie_ep_init,
> +	.init = uniphier_pcie_ep_init,
>  	.raise_irq = uniphier_pcie_ep_raise_irq,
>  	.get_features = uniphier_pcie_get_features,
>  };
> -- 
> 2.34.1
> 
