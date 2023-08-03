Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8D576E65F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjHCLHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 07:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjHCLG6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 07:06:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FBB5581
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 04:04:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso7274765ad.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691060656; x=1691665456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IknOCtebfFlx/lc6Pic9PVufpdmEIUXQ1NslxWXqNjg=;
        b=AjINvEoBsPuRLYheOE+ppyjF8/NG41VgLD+FkSWUkqF498KJWN/8lhZqTt9bQIBASR
         pHMm8NtXc6wFt/E4AMZsEP5W47PfYSVvvGFIzNKuSTU//aWWxwVnO8Tvvxxn91IUCrzf
         btZKOa7a19+FgLWB8cKLWXsi1QnqGRNrWvQEW0DjrCiRdwqpjrzgYiLyr51VRgAvf5qo
         8OAs7SGDiyLjXBUbuJMhPPhDL5Q6dpAOmoEqfpFSwmI7sAN9CH5p2ifwk5njFzm55U+3
         HppjXTQ3R85a83NuPBekAOReDTY4G6FYN5O8D596A5R7bKpmfsRCR58MhvuCSVqItra3
         mVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691060656; x=1691665456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IknOCtebfFlx/lc6Pic9PVufpdmEIUXQ1NslxWXqNjg=;
        b=h6d7VdRfezkHIIIhj9euVEUaGxLLhowi6BTX1VlGa17xtb905YBEOAihXu6AqolNHf
         7CsfHQd+IaxYovHLPawCvvvUY4n1BXcMWl9u7gHLUCM7mh1PUn2fodEgG+Ep6+OsVHWK
         xWK0V2a4GlTPdO1ELFvTF3kn1wpBdAa+6buzv/TqCP4qqpjPDwHvpRg/YDtbwroi5hpi
         05zWAArNSFLm7yTSssy15qVQBM6FqA0iJmVrbZDvD88ehtG8Jzrb2N8UOx1B0BquP18x
         qXfqDgCdVjf6Y5BiNAdthAIgWO06aJENUwAeICoX8h8yD2JzNZJCFOK+nVHKudCYsqhF
         /yXQ==
X-Gm-Message-State: ABy/qLZUhRrz59tZ01wkU1tD5rEo0p/2ypeIZeKmqOMCrJvAIazKpmnU
        B9Z9NqCFm9GoWiz0KZ3YyqiBu/RbFDMc5TV0CA==
X-Google-Smtp-Source: APBJJlHTgcWa+M2iIE8yrsVl7pcmIqgqdUzGfLX5FRSuaZ2tRs2ks6b5Tc8aUThyGe7z2El6R/fVtA==
X-Received: by 2002:a17:902:f7ca:b0:1bb:9b48:ea94 with SMTP id h10-20020a170902f7ca00b001bb9b48ea94mr16216769plw.32.1691060655621;
        Thu, 03 Aug 2023 04:04:15 -0700 (PDT)
Received: from thinkpad ([103.28.246.45])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b001b896d0eb3dsm14104942plr.8.2023.08.03.04.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:04:15 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:34:10 +0530
From:   Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 2/2] PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
Message-ID: <20230803110410.GB7313@thinkpad>
References: <20230802094036.1052472-1-dlemoal@kernel.org>
 <20230802094036.1052472-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802094036.1052472-3-dlemoal@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 06:40:36PM +0900, Damien Le Moal wrote:
> linux/pci.h defines the IRQ flags PCI_IRQ_INTX, PCI_IRQ_MSI and
> PCI_IRQ_MSIX. Let's use these flags directly instead of the endpoint
> definitions provided by enum pci_epc_irq_type. This removes the need
> for defining this enum type completely.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

"legacy" is still being mentioned in a lot of places (comments, function names).
So we need one more cleanup patch later (not now).

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  9 ++++-----
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  6 +++---
>  drivers/pci/controller/dwc/pci-imx6.c             |  9 ++++-----
>  drivers/pci/controller/dwc/pci-keystone.c         |  9 ++++-----
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  8 ++++----
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         | 13 ++++++-------
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  6 +++---
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  7 +++----
>  drivers/pci/controller/pcie-rcar-ep.c             |  7 +++----
>  drivers/pci/controller/pcie-rockchip-ep.c         |  7 +++----
>  drivers/pci/endpoint/functions/pci-epf-mhi.c      |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c      |  4 ++--
>  drivers/pci/endpoint/functions/pci-epf-test.c     |  6 +++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c     |  7 ++-----
>  drivers/pci/endpoint/pci-epc-core.c               |  2 +-
>  include/linux/pci-epc.h                           | 11 ++---------
>  21 files changed, 62 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..885291bb1e28 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -531,25 +531,24 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>  }
>  
>  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> -				  enum pci_epc_irq_type type,
> -				  u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	struct device *dev = pcie->dev;
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		if (vfn > 0) {
>  			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
>  			return -EINVAL;
>  		}
>  		return cdns_pcie_ep_send_legacy_irq(ep, fn, vfn, 0);
>  
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return cdns_pcie_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
>  
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return cdns_pcie_ep_send_msix_irq(ep, fn, vfn, interrupt_num);
>  
>  	default:
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index b445ffe95e3f..f257a42f3314 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -404,16 +404,16 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
>  }
>  
>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				 enum pci_epc_irq_type type, u16 interrupt_num)
> +				 unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		dra7xx_pcie_raise_legacy_irq(dra7xx);
>  		break;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		dra7xx_pcie_raise_msi_irq(dra7xx, interrupt_num);
>  		break;
>  	default:
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 235ead4c807f..adda8a43d058 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1057,17 +1057,16 @@ static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type,
> -				  u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..58170a4fc574 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -900,20 +900,19 @@ static void ks_pcie_am654_raise_legacy_irq(struct keystone_pcie *ks_pcie)
>  }
>  
>  static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				   enum pci_epc_irq_type type,
> -				   u16 interrupt_num)
> +				   unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		ks_pcie_am654_raise_legacy_irq(ks_pcie);
>  		break;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  		break;
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  		break;
>  	default:
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index de4c1758a6c3..6b65f1bcc550 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -150,16 +150,16 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				enum pci_epc_irq_type type, u16 interrupt_num)
> +				unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
>  							  interrupt_num);
>  	default:
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 9b572a2b2c9a..fc426182443a 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -352,15 +352,15 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type, u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> -		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
> +	case PCI_IRQ_INTX:
> +		dev_err(pci->dev, "EP cannot trigger INTx IRQs\n");
>  		return -EINVAL;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f9182f8d552f..ab87ea3b0986 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -426,7 +426,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  
>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -				enum pci_epc_irq_type type, u16 interrupt_num)
> +				unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index b625841e98aa..c83968aa0149 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -42,17 +42,16 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				     enum pci_epc_irq_type type,
> -				     u16 interrupt_num)
> +				     unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 615660640801..e039081eb947 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -320,7 +320,7 @@ struct dw_pcie_rp {
>  struct dw_pcie_ep_ops {
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> -			     enum pci_epc_irq_type type, u16 interrupt_num);
> +			     unsigned int type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
>  	/*
>  	 * Provide a method to implement the different func config space
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 289bff99d762..8e0e2e28ef67 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -289,19 +289,18 @@ static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				     enum pci_epc_irq_type type,
> -				     u16 interrupt_num)
> +				     unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> -		/* Legacy interrupts are not supported in Keem Bay */
> -		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> +	case PCI_IRQ_INTX:
> +		/* INTx interrupts are not supported in Keem Bay */
> +		dev_err(pci->dev, "INTx IRQ is not supported\n");
>  		return -EINVAL;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 267e1247d548..5f95c33ae293 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -655,14 +655,14 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
>  }
>  
>  static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type, u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "Unknown IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 383ba71d1e8f..42205f0675d0 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1992,20 +1992,19 @@ static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  }
>  
>  static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				   enum pci_epc_irq_type type,
> -				   u16 interrupt_num)
> +				   unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
>  
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return tegra_pcie_ep_raise_msi_irq(pcie, interrupt_num);
>  
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return tegra_pcie_ep_raise_msix_irq(pcie, interrupt_num);
>  
>  	default:
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index cba3c88fcf39..d47236d5678d 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -256,15 +256,14 @@ static int uniphier_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
>  }
>  
>  static int uniphier_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				      enum pci_epc_irq_type type,
> -				      u16 interrupt_num)
> +				      unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return uniphier_pcie_ep_raise_legacy_irq(ep);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
>  						      interrupt_num);
>  	default:
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index f9682df1da61..c21294bc430d 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -402,16 +402,15 @@ static int rcar_pcie_ep_assert_msi(struct rcar_pcie *pcie,
>  }
>  
>  static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> -				  enum pci_epc_irq_type type,
> -				  u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return rcar_pcie_ep_assert_intx(ep, fn, 0);
>  
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return rcar_pcie_ep_assert_msi(&ep->pcie, fn, interrupt_num);
>  
>  	default:
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 0af0e965fb57..95b1c8ef59c3 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -407,15 +407,14 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  }
>  
>  static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> -				      enum pci_epc_irq_type type,
> -				      u16 interrupt_num)
> +				      unsigned int type, u16 interrupt_num)
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_INTX:
>  		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 9c1f5a154fbd..90b49e707392 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -177,7 +177,7 @@ static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
>  	 * MHI supplies 0 based MSI vectors but the API expects the vector
>  	 * number to start from 1, so we need to increment the vector by 1.
>  	 */
> -	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_EPC_IRQ_MSI,
> +	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_IRQ_MSI,
>  			  vector + 1);
>  }
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9aac2c6f3bb9..fad00b1a8335 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -140,9 +140,9 @@ static struct pci_epf_header epf_ntb_header = {
>  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  {
>  	enum pci_epc_interface_type type;
> -	enum pci_epc_irq_type irq_type;
>  	struct epf_ntb_epc *ntb_epc;
>  	struct epf_ntb_ctrl *ctrl;
> +	unsigned int irq_type;
>  	struct pci_epc *epc;
>  	u8 func_no, vfunc_no;
>  	bool is_msix;
> @@ -159,7 +159,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  			ctrl->link_status |= LINK_STATUS_UP;
>  		else
>  			ctrl->link_status &= ~LINK_STATUS_UP;
> -		irq_type = is_msix ? PCI_EPC_IRQ_MSIX : PCI_EPC_IRQ_MSI;
> +		irq_type = is_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
>  		ret = pci_epc_raise_irq(epc, func_no, vfunc_no, irq_type, 1);
>  		if (ret) {
>  			dev_err(&epc->dev,
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1f0d2b84296a..9d39fda5c348 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -602,7 +602,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	switch (reg->irq_type) {
>  	case IRQ_TYPE_LEGACY:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_LEGACY, 0);
> +				  PCI_IRQ_INTX, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
>  		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> @@ -612,7 +612,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSI, reg->irq_number);
> +				  PCI_IRQ_MSI, reg->irq_number);
>  		break;
>  	case IRQ_TYPE_MSIX:
>  		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
> @@ -622,7 +622,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSIX, reg->irq_number);
> +				  PCI_IRQ_MSIX, reg->irq_number);
>  		break;
>  	default:
>  		dev_err(dev, "Failed to raise IRQ, unknown type\n");
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c8b423c3c26e..ba2fe0bb400a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1172,11 +1172,8 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  	func_no = ntb->epf->func_no;
>  	vfunc_no = ntb->epf->vfunc_no;
>  
> -	ret = pci_epc_raise_irq(ntb->epf->epc,
> -				func_no,
> -				vfunc_no,
> -				PCI_EPC_IRQ_MSI,
> -				interrupt_num + 1);
> +	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> +				PCI_IRQ_MSI, interrupt_num + 1);
>  	if (ret)
>  		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5a4a8b0be626..c80d06db4249 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -217,7 +217,7 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
>   * Invoke to raise an legacy, MSI or MSI-X interrupt
>   */
>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		      enum pci_epc_irq_type type, u16 interrupt_num)
> +		      unsigned int type, u16 interrupt_num)
>  {
>  	int ret;
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 5cb694031072..f498f9aa2ab0 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -19,13 +19,6 @@ enum pci_epc_interface_type {
>  	SECONDARY_INTERFACE,
>  };
>  
> -enum pci_epc_irq_type {
> -	PCI_EPC_IRQ_UNKNOWN,
> -	PCI_EPC_IRQ_LEGACY,
> -	PCI_EPC_IRQ_MSI,
> -	PCI_EPC_IRQ_MSIX,
> -};
> -
>  static inline const char *
>  pci_epc_interface_string(enum pci_epc_interface_type type)
>  {
> @@ -79,7 +72,7 @@ struct pci_epc_ops {
>  			    u16 interrupts, enum pci_barno, u32 offset);
>  	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>  	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -			     enum pci_epc_irq_type type, u16 interrupt_num);
> +			     unsigned int type, u16 interrupt_num);
>  	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			       phys_addr_t phys_addr, u8 interrupt_num,
>  			       u32 entry_size, u32 *msi_data,
> @@ -229,7 +222,7 @@ int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			phys_addr_t phys_addr, u8 interrupt_num,
>  			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		      enum pci_epc_irq_type type, u16 interrupt_num);
> +		      unsigned int type, u16 interrupt_num);
>  int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்
