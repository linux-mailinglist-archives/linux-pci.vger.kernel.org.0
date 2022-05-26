Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E553537D
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiEZSmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiEZSmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 14:42:32 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ED32E09B;
        Thu, 26 May 2022 11:42:30 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-e93bbb54f9so3175343fac.12;
        Thu, 26 May 2022 11:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oKw28NxnYTmj8nnF3RkrJ1hAma+ECeEYFG/6pkFnPeI=;
        b=hplNl5tFB52yhZVzxZxEvuyuY4LHYwreuj3+SI/CEAXnUH59EYyzv73QZQVEvXN1Ba
         QYfy2GZYPqILSJ0Hk10iVuH97bDeA84YAHMZPNuExWV3UojxZhnuR1N9fwGC9eoDl5YW
         7q+e55z7B8pBUy/a2mvAr2Cgo8zkU/ht5ZoaAXGrzS4M4d8pEm1WDrTT0BWnrC4Nr5JK
         fNZ0uPYh+TpzTI6gbtIIzaCwghnl9bt6BiwluNAn6iF+ni45EkkgdzcL2/ekkjTJnSOU
         dI3q5ZIGEPDpcsGRQUm2GNTi4ZFmBmW6WZPZEHniuRV1mKVvQ0l+u43FTyvHYA12h/xf
         GbOw==
X-Gm-Message-State: AOAM530l4MTDM8A8jbwhYJgs2bPDtnGQLydvwlK/cen1Z+dTPp02pAtm
        hgg4RGf1GaNAbyrSr6AKIg==
X-Google-Smtp-Source: ABdhPJxME0ElyOy4iLgTJ0+JfOUZSwhRkdJlcW5omiABVC0YMXDrQh8QjrM5G3FbOLPiTKjrL3Fw5w==
X-Received: by 2002:a05:6870:d113:b0:f2:e434:b115 with SMTP id e19-20020a056870d11300b000f2e434b115mr1209789oac.235.1653590550056;
        Thu, 26 May 2022 11:42:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h5-20020aca1805000000b00325cda1ffb9sm838926oih.56.2022.05.26.11.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:42:29 -0700 (PDT)
Received: (nullmailer pid 123322 invoked by uid 1000);
        Thu, 26 May 2022 18:42:28 -0000
Date:   Thu, 26 May 2022 13:42:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 6/8] PCI: dwc: Implement special ISR handler for
 split MSI IRQ setup
Message-ID: <20220526184228.GF54904-robh@kernel.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-7-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:34PM +0300, Dmitry Baryshkov wrote:
> If the PCIe DWC controller uses split MSI IRQs for reporting MSI
> vectors, it is possible to detect, which group triggered the interrupt.
> Provide an optimized version of MSI ISR handler that will handle just a
> single MSI group instead of handling all of them.

A lot more complexity to save 7 register reads...

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 86 ++++++++++++++-----
>  1 file changed, 65 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 98a57249ecaf..2b2de517301a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -52,34 +52,42 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  	.chip	= &dw_pcie_msi_irq_chip,
>  };
>  
> +static inline irqreturn_t dw_handle_single_msi_group(struct pcie_port *pp, int i)
> +{
> +	int pos;
> +	unsigned long val;
> +	u32 status;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> +				   (i * MSI_REG_CTRL_BLOCK_SIZE));
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	val = status;
> +	pos = 0;
> +	while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
> +				    pos)) != MAX_MSI_IRQS_PER_CTRL) {

for_each_set_bit() doesn't work here?

> +		generic_handle_domain_irq(pp->irq_domain,
> +					  (i * MAX_MSI_IRQS_PER_CTRL) +
> +					  pos);
> +		pos++;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  /* MSI int handler */
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
> -	int i, pos;
> -	unsigned long val;
> -	u32 status, num_ctrls;
> +	int i;
> +	u32 num_ctrls;
>  	irqreturn_t ret = IRQ_NONE;
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
>  	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>  
> -	for (i = 0; i < num_ctrls; i++) {
> -		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> -					   (i * MSI_REG_CTRL_BLOCK_SIZE));
> -		if (!status)
> -			continue;
> -
> -		ret = IRQ_HANDLED;
> -		val = status;
> -		pos = 0;
> -		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
> -					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
> -			generic_handle_domain_irq(pp->irq_domain,
> -						  (i * MAX_MSI_IRQS_PER_CTRL) +
> -						  pos);
> -			pos++;
> -		}
> -	}
> +	for (i = 0; i < num_ctrls; i++)
> +		ret |= dw_handle_single_msi_group(pp, i);
>  
>  	return ret;
>  }
> @@ -98,6 +106,38 @@ static void dw_chained_msi_isr(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void dw_split_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	int irq = irq_desc_get_irq(desc);
> +	struct pcie_port *pp;
> +	int i;
> +	u32 num_ctrls;
> +	struct dw_pcie *pci;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	pp = irq_desc_get_handler_data(desc);
> +	pci = to_dw_pcie_from_pp(pp);
> +
> +	/*
> +	 * Unlike generic dw_handle_msi_irq(), we can determine which group of
> +	 * MSIs triggered the IRQ, so process just that group.
> +	 */
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +	for (i = 0; i < num_ctrls; i++) {
> +		if (pp->msi_irq[i] == irq) {
> +			dw_handle_single_msi_group(pp, i);
> +			break;
> +		}
> +	}
> +
> +	WARN_ON_ONCE(i == num_ctrls);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
>  static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  {
>  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> @@ -336,6 +376,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	int ret;
>  	u32 ctrl, num_ctrls;
> +	bool has_split_msi_irq = false;
>  
>  	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>  		pp->irq_mask[ctrl] = ~0;
> @@ -344,6 +385,8 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  		ret = dw_pcie_parse_split_msi_irq(pp);
>  		if (ret < 0 && ret != -ENXIO)
>  			return ret;
> +		else if (!ret)
> +			has_split_msi_irq = true;
>  	}
>  
>  	if (!pp->num_vectors)
> @@ -372,6 +415,7 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>  		if (pp->msi_irq[ctrl] > 0)
>  			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +							 has_split_msi_irq ? dw_split_msi_isr :
>  							 dw_chained_msi_isr,
>  							 pp);
>  
> -- 
> 2.35.1
> 
