Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9027EAE40
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 11:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjKNKoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 05:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKNKoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 05:44:11 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A4185;
        Tue, 14 Nov 2023 02:44:06 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c834c52b5aso50552591fa.1;
        Tue, 14 Nov 2023 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699958645; x=1700563445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0KJu3TSx3LB/G1QM8W+hYXr5cBkUhQuTl/DLn78PSE=;
        b=LRndLjyxuhDLtwL7W9AlYRnlqcCku1d2fPpRkaQm2yBCzyVrhqx+J9LVJQnMYvk4iI
         Nj/ZZibhSIW2M4BhJf5yOhzQCW2we0T+TatQB4zKTK6fk2nU/+hiMuV4/Qkc9/8vxDPj
         1dxgcRjUaChrI9BBQGXyLPEvaPJ5bGeWezC8WYeZbbAOgUA8Mh5FGkKkRAOAXtC92O4W
         u5vfqAGBkzAb+d5KdsIhD+WiEt31S4a31JWIT02PICDkkdK4OKxobO12+ovcpX7ya+cY
         uXvHLFN1wieIZf6SYr5i0f/WB7hjs2jPm+jJy5nU6x61nz4/+5pPRYTT7o3o5M+M742g
         HvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699958645; x=1700563445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0KJu3TSx3LB/G1QM8W+hYXr5cBkUhQuTl/DLn78PSE=;
        b=oXInJsmg6YEggJY15bXY6K356FXtTZqG0apvhTbPFaHr6sS1omXJ56If4gtBOfzLso
         W/lPqydybeyzhxQtrR/JRJNPth9Uigd98PaxDdD5S+8RRT8Q8ZZ/UOu+udSSu/Si7bLW
         h7+1DH02+vrLjTI+IPb9DSuMTgyvzFFEatIfLq2MWK8+9xF8qSwGhiBtimF6hsERDwN8
         uzaRT4rg0oubmToj2BjPYtXnXGZO9AMTGdgWPzkN/RPa0P9F+buxCkhgm7XTG3302Fgx
         PNJnt4T0XbCbnyaazXLQwxcf9MrpVJS1wnrz1o4GvuCEX0sHfVfHXgX9G2GQWpOVBx7H
         Zuqw==
X-Gm-Message-State: AOJu0YymBW7e2p/4lj7jJSwCGCtGO5NJUQeA6hbGCCJOWPA7SnqjjLT5
        t3GsDpm06yTZsiSZZwOWCKY=
X-Google-Smtp-Source: AGHT+IEO+dK7BHJ2Pv37w59mPsithrElzXmj2DpfMg8gWp2aQPiA/jmza9bcx6+Pc7aiCfxk/vDuHw==
X-Received: by 2002:a2e:b794:0:b0:2c5:db3:d3a6 with SMTP id n20-20020a2eb794000000b002c50db3d3a6mr1296790ljo.19.1699958644821;
        Tue, 14 Nov 2023 02:44:04 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k16-20020a2e2410000000b002c83b0bd971sm1184416ljk.2.2023.11.14.02.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:44:04 -0800 (PST)
Date:   Tue, 14 Nov 2023 13:44:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
Message-ID: <hnh5sqt7thqt3is6b5c7mxt4gzzuaokvjkawcnchu4br4a3763@buql76j6s2ep>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:54:52PM +0900, Yoshihiro Shimoda wrote:
> Since the name of dw_pcie_ep_ops indicates that it's for ep obviously,
> rename a member .ep_init to .init.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
> index 6125a838f4b1..1ac1be12a235 100644
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
> index b02f6f14a411..644916a67a38 100644
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
> index 3711347ddc87..d0f50cceede9 100644
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
> index 2f32fcd8933c..f6afa96a97e4 100644
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
> index 5c4518ad1bec..3bc03a93732f 100644
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
> index 193ed88d3c2f..1c017997fb3e 100644
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
