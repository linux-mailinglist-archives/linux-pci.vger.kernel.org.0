Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5E55D000
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiF1GnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiF1GnV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:43:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E17BF66
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:43:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jh14so10229342plb.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s9TUIBPvRcRxZmOZ/UKmL2STsX4RkuAASajSfCd6Jwo=;
        b=k1iqEHVEnLSQedel9PTf1jmE6vwsF2fufvd423d/FatBfr62j4GLx9uTphZocJsD2X
         t9swjbnwfX2TYX27zr3ExGrxMmK6Yvst1YES64DfOUgIubs/+txIaKhbyqxG04K4FF32
         10unYr7lRp3R7tg3DDTOtumvwvuyZbRNtksC4lFzOTu0xPWjZqRYTS2KfjTK9CjrIGVW
         uA/9lK6N0wmW0pEi7MOamzht9CHaRTqaerW6wnyLSGMdmjRzZVzf6eB6UYFvHffKP214
         QELFv2nXLIvPtMH6YFSUzGXvLnbXg8285mEbfXLR7Sb4QuxDCXYTf1q9QBcKe+46I1zx
         CLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s9TUIBPvRcRxZmOZ/UKmL2STsX4RkuAASajSfCd6Jwo=;
        b=NhPh9sahnWEcJoNi9vsbYqZMMszcWsM/khYe1lSwyK/uiIzlqCvpjak1cwvFse+fBf
         Xwcje6WBIWimXiShscdyOOs11hC5yiPNySoj7Zhmf+WJAMeR9CIzFbzvNF74g7c7ejRw
         63znIrOdSifIrX6yW1fghqNDROwtg4DNi435/nDvmVDajl2LsBDA63PS5VxmB/Emm64w
         dnRa6krnvcgpcWnctBejFB5kyiBmY2zzrVdaPct33+tjeu/BbNbeCD6J467P0J4oNL1U
         agJPRP9hziXtm53DEMKWPjYDBpTzJ9qxm44S4lmNJF11W3IuoBK+EcODmjcIxIYRN+fX
         yRWw==
X-Gm-Message-State: AJIora/qjWyZ7ODVreUVB4gc4p8mX+0dm9HY1PC++Ug+/L06zTb0IunK
        /EVXxgshNqdyXAPPJSBzviuD
X-Google-Smtp-Source: AGRyM1vZCMBeqIqeJwz0Z/dkETp7U0TOTadYMxdCF6m7UB503Afk9laZJZeM1ax4GiQzFjSdh7PBsg==
X-Received: by 2002:a17:902:f543:b0:16a:54c6:78d0 with SMTP id h3-20020a170902f54300b0016a54c678d0mr2183859plf.28.1656398599724;
        Mon, 27 Jun 2022 23:43:19 -0700 (PDT)
Received: from thinkpad ([27.111.75.159])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016a522915e5sm8376804plm.83.2022.06.27.23.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:43:19 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:13:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v5 13/18] PCI: dwc: Add start_link/stop_link
 inliners
Message-ID: <20220628064313.GF23601@thinkpad>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143428.8334-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143428.8334-14-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:34:23PM +0300, Serge Semin wrote:
> There are several places in the generic DW PCIe code where the
> platform-specific PCIe link start/stop methods are called after making
> sure the ops handler and the callbacks are specified. Instead of repeating
> the same pattern over and over let's define the static-inline methods in
> the DW PCIe header file and use them in the relevant parts of the driver.
> 
> Note returning a negative error from the EP link start procedure if the
> start_link pointer isn't specified doesn't really make much sense since
> it's perfectly normal to have such a platform. Moreover even
> pci_epc_start() doesn't fail if no epc->ops->start callback is spotted. As
> a side-effect of this modification we can set the generic DW PCIe and
> Layerscape EP platform drivers free from the empty start_link callbacks
> and as such entirely dummy dw_pcie_ops instances.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 12 ------------
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 ++------
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++------
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 10 ----------
>  drivers/pci/controller/dwc/pcie-designware.h      | 14 ++++++++++++++
>  5 files changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 39f4664bd84c..ad99707b3b99 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -32,15 +32,6 @@ struct ls_pcie_ep {
>  	const struct ls_pcie_ep_drvdata *drvdata;
>  };
>  
> -static int ls_pcie_establish_link(struct dw_pcie *pci)
> -{
> -	return 0;
> -}
> -
> -static const struct dw_pcie_ops dw_ls_pcie_ep_ops = {
> -	.start_link = ls_pcie_establish_link,
> -};
> -
>  static const struct pci_epc_features*
>  ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  {
> @@ -106,19 +97,16 @@ static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
>  
>  static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
>  	.ops = &ls_pcie_ep_ops,
> -	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
>  };
>  
>  static const struct ls_pcie_ep_drvdata ls2_ep_drvdata = {
>  	.func_offset = 0x20000,
>  	.ops = &ls_pcie_ep_ops,
> -	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
>  };
>  
>  static const struct ls_pcie_ep_drvdata lx2_ep_drvdata = {
>  	.func_offset = 0x8000,
>  	.ops = &ls_pcie_ep_ops,
> -	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
>  };
>  
>  static const struct of_device_id ls_pcie_ep_of_match[] = {
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7ad349c32082..15b8059544e3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -435,8 +435,7 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	if (pci->ops && pci->ops->stop_link)
> -		pci->ops->stop_link(pci);
> +	dw_pcie_stop_link(pci);
>  }
>  
>  static int dw_pcie_ep_start(struct pci_epc *epc)
> @@ -444,10 +443,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	if (!pci->ops || !pci->ops->start_link)
> -		return -EINVAL;
> -
> -	return pci->ops->start_link(pci);
> +	return dw_pcie_start_link(pci);
>  }
>  
>  static const struct pci_epc_features*
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2f13eec4812d..c49a3bde7a2a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -409,8 +409,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  
>  	dw_pcie_setup_rc(pp);
>  
> -	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
> -		ret = pci->ops->start_link(pci);
> +	if (!dw_pcie_link_up(pci)) {
> +		ret = dw_pcie_start_link(pci);
>  		if (ret)
>  			goto err_free_msi;
>  	}
> @@ -427,8 +427,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  
>  err_stop_link:
> -	if (pci->ops && pci->ops->stop_link)
> -		pci->ops->stop_link(pci);
> +	dw_pcie_stop_link(pci);
>  
>  err_free_msi:
>  	if (pp->has_msi_ctrl)
> @@ -444,8 +443,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
>  	pci_stop_root_bus(pp->bridge->bus);
>  	pci_remove_root_bus(pp->bridge->bus);
>  
> -	if (pci->ops && pci->ops->stop_link)
> -		pci->ops->stop_link(pci);
> +	dw_pcie_stop_link(pci);
>  
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 0c5de87d3cc6..abf1afac6064 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -36,15 +36,6 @@ static const struct of_device_id dw_plat_pcie_of_match[];
>  static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
>  };
>  
> -static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
> -{
> -	return 0;
> -}
> -
> -static const struct dw_pcie_ops dw_pcie_ops = {
> -	.start_link = dw_plat_pcie_establish_link,
> -};
> -
>  static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -140,7 +131,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pci->dev = dev;
> -	pci->ops = &dw_pcie_ops;
>  
>  	dw_plat_pcie->pci = pci;
>  	dw_plat_pcie->mode = mode;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7d6e9b7576be..8ba239292634 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -365,6 +365,20 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>  	dw_pcie_writel_dbi(pci, reg, val);
>  }
>  
> +static inline int dw_pcie_start_link(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->start_link)
> +		return pci->ops->start_link(pci);
> +
> +	return 0;
> +}
> +
> +static inline void dw_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->stop_link)
> +		pci->ops->stop_link(pci);
> +}
> +
>  #ifdef CONFIG_PCIE_DW_HOST
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
