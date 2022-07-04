Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7900565C5C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGDQqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiGDQov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 12:44:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB711159
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 09:44:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so14267271pjl.5
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2022 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FOn3XR9K25niM5eKvSOAP5Ka1f5s3z8cjWTjc29J6Vw=;
        b=VNFZf6iKVZCFmWezSmp8vGS5tRZb9COCNnBiAM1W45GNZWKiAW3cpxylBBnyOMuBvt
         VVmA80IYngieRsOateshqicuJwvioPQOM85hlTezBeHrU9kIkG5XrSurXQeaRzmZNokG
         ScK3yeR1iwvDlpHKnVaYEs/PCgdk5daeiH2WGH5Q+h6sH/mcEVP3xC3Qzy0wqc68/vMe
         f/EdamR4YcZzQlJVEVewGrdMlWrTtQYdTaN4Pr4945W37L1hfOqAIkuZrv0IViqpVUUf
         L3kpimckvcwTHqqn8J75CDZvlisudoAwBMYArH22Ugs89q2a2VYv4kPqMKoWvLFqXOJe
         UyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FOn3XR9K25niM5eKvSOAP5Ka1f5s3z8cjWTjc29J6Vw=;
        b=OOlHBDn1vnUVwry/uCWJlsidpCeUzO+XMGe3Fn/qw7lxiLratZAFWyEUaslmaiaRM4
         ok7lxUFaBSG5RjHcNdLAWk3ED25Imw0oJYD/245DVkBqGS7Ke+uFamzRNOOAGrl7CWtq
         x732mXqt5WbkNmjaIh2H/Pt2gV6l9JzMh7QaKGLekvkSPTdTwSF2z51K45RpYQtXEXYP
         JOel96e0a33BmJJuKeu4Naq5zgXmYmStQryQ8nD5mQMXEPbrL7QOHx46WjyB4UuddGC7
         3hXAQHJUCBOIHsaCnT1ApOry1Yeeki0Ld3svArEuc8kl5meDDCfrC73sIOM5jmBEtL8n
         I3mA==
X-Gm-Message-State: AJIora/H3Ok5GshrcrIKPKyFkKq7Np8uGj4YkP20gdcYQ+0asanD9PG5
        sEWyNeOvk6Z6Yo0Hx8Il+TZg
X-Google-Smtp-Source: AGRyM1vZV7z2XQBHv07Q3eMzp6jJnL1ucfENp+DGLq9JSYw6BmrKFtRwrU9E4fNcTnq4Q8hlDpWkXA==
X-Received: by 2002:a17:90b:3804:b0:1ec:fe8d:8705 with SMTP id mq4-20020a17090b380400b001ecfe8d8705mr37796900pjb.103.1656953084763;
        Mon, 04 Jul 2022 09:44:44 -0700 (PDT)
Received: from thinkpad ([220.158.158.244])
        by smtp.gmail.com with ESMTPSA id g8-20020a62e308000000b005251ff30dccsm21197190pfh.160.2022.07.04.09.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:44:44 -0700 (PDT)
Date:   Mon, 4 Jul 2022 22:14:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v16 4/6] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <20220704164438.GH6560@thinkpad>
References: <20220704152746.807550-1-dmitry.baryshkov@linaro.org>
 <20220704152746.807550-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220704152746.807550-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 06:27:44PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Implement support for such configurations by
> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
> handler.
> 
> Note, that if DT doesn't list an array of MSI interrupts and uses single
> "msi" IRQ, the driver will limit the amount of supported MSI vectors
> accordingly (to 32).
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 63 +++++++++++++++++--
>  1 file changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3ba531da99d4..2bab0c395ea9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -290,6 +290,46 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq;
> +	u32 ctrl, max_vectors;
> +
> +	/* Parse as many IRQs as described in the devicetree. */
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +		char msi_name[] = "msiX";
> +
> +		msi_name[3] = '0' + ctrl;
> +		irq = platform_get_irq_byname_optional(pdev, msi_name);
> +		if (irq == -ENXIO)
> +			break;
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq,
> +					     "Failed to parse MSI IRQ '%s'\n",
> +					     msi_name);
> +
> +		pp->msi_irq[ctrl] = irq;
> +	}
> +
> +	/* If there were no "msiN" IRQs at all, fallback to the standard "msi" IRQ. */
> +	if (ctrl == 0)
> +		return -ENXIO;
> +
> +	max_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
> +	if (pp->num_vectors > max_vectors) {
> +		dev_warn(dev, "Exceeding number of MSI vectors, limiting to %u\n",
> +			 max_vectors);
> +		pp->num_vectors = max_vectors;
> +	}
> +	if (!pp->num_vectors)
> +		pp->num_vectors = max_vectors;
> +
> +	return 0;
> +}
> +
>  static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -298,21 +338,32 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  	int ret;
>  	u32 ctrl, num_ctrls;
>  
> -	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> -	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>  		pp->irq_mask[ctrl] = ~0;
>  
> +	if (!pp->msi_irq[0]) {
> +		ret = dw_pcie_parse_split_msi_irq(pp);
> +		if (ret < 0 && ret != -ENXIO)
> +			return ret;
> +	}
> +
> +	if (!pp->num_vectors)
> +		pp->num_vectors = MSI_DEF_NUM_VECTORS;
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
>  	if (!pp->msi_irq[0]) {
>  		int irq = platform_get_irq_byname_optional(pdev, "msi");
>  
>  		if (irq < 0) {
>  			irq = platform_get_irq(pdev, 0);
>  			if (irq < 0)
> -				return irq;
> +				return dev_err_probe(dev, irq, "Failed to parse MSI irq\n");
>  		}
>  		pp->msi_irq[0] = irq;
>  	}
>  
> +	dev_dbg(dev, "Using %d MSI vectors\n", pp->num_vectors);
> +
>  	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>  
>  	ret = dw_pcie_allocate_domains(pp);
> @@ -410,7 +461,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  				     of_property_read_bool(np, "msi-parent") ||
>  				     of_property_read_bool(np, "msi-map"));
>  
> -		if (!pp->num_vectors) {
> +		/*
> +		 * For the has_msi_ctrl case the default assignment is handled
> +		 * in the dw_pcie_msi_host_init().
> +		 */
> +		if (!pp->has_msi_ctrl && !pp->num_vectors) {
>  			pp->num_vectors = MSI_DEF_NUM_VECTORS;
>  		} else if (pp->num_vectors > MAX_MSI_IRQS) {
>  			dev_err(dev, "Invalid number of vectors\n");
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
