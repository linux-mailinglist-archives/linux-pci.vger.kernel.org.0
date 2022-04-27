Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234C751200A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiD0RDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbiD0RDP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 13:03:15 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90345640A
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 10:00:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s27so3499473ljd.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4FZ9hDjEcrk8be9d2zNWEXFxSZgfw87crWXMioTKU1A=;
        b=EJP/VS7885RHBzli5b87Pgg7bycneG9Dwxm0Wn3nIHgtxFq8I5f0D/S2PSrNi/AbI2
         haTMVZ+kMsJr5jpDQwG6AeGOmaoXDWJzpOKbk/pPZpVFLznvxat1OIP+blqYTAcQSHDn
         X+X8Dlmnlz1Vwm9lXrC1nVns3MjQtqiuNg/f1P2RCbqqo6+jJPTeQYA8ezXqIKfN2k35
         X21Nk1irP3/8eI1zS83Ilu5EQpEjRrZA2SuOPg0XrC9Do4/U4WayBOBwM2vqVnocsSVw
         SD4Lb0qOFQFg3+cT34W2b2O54Zib1Kw0dd51KK+dMzutAQGAtpGCE7OFO8Q+9GNpdDaG
         cWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4FZ9hDjEcrk8be9d2zNWEXFxSZgfw87crWXMioTKU1A=;
        b=deoL0/5GVmuu7GMZDlHQaK3k57ZVawzfgbPV9oWUcMGTE2sLvt0prUbLGuIv3Eeo/n
         CtZ0+5itCTvFP8yW4klbD655g3NCYs/W+LKdfQaUi6nEsTi4K8chPo78Us2vggdFUbcw
         CzRSmJGA1OGiEgOJ6mswP66M19IkIs6CWD9tOw8yyFpEceWPFWeIomAG9sDGgW5jW9YE
         F+lhZ8YyGKVaDzIGIOrHojerhTRsrJuuiCWe1l0UQ1S/fOoM6a+lhMECJTMF89OlwHwh
         ctFNRltGCc+4lGlkyp9+0dW+scb0v7J95PcMJWJsXLzROg7i7Yw1AEubTZDlUbR+hlgU
         7z2g==
X-Gm-Message-State: AOAM533W9R6duzVdzb9oapakya0DznIVFKIZ1kwbxpSXoH+dYtw6hr7a
        bZxWFY9WRfkgPHE33rKxtbfjNw==
X-Google-Smtp-Source: ABdhPJwyqcNvcyyhVnLvWPxCOWHgdrKf4PO/5x8I28DFcbLJlvVw5CiJMw5DQ4dGrELBoamgx15zAw==
X-Received: by 2002:a2e:a786:0:b0:24f:2db0:b16f with SMTP id c6-20020a2ea786000000b0024f2db0b16fmr789013ljf.416.1651078799095;
        Wed, 27 Apr 2022 09:59:59 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z9-20020a196509000000b0046b8cab5b9esm2102598lfb.293.2022.04.27.09.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:59:58 -0700 (PDT)
Message-ID: <b9d81916-10e6-94f9-78b2-b2198620e66a@linaro.org>
Date:   Wed, 27 Apr 2022 19:59:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/5] PCI: dwc: Convert msi_irq to the array
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220427121653.3158569-1-dmitry.baryshkov@linaro.org>
 <20220427121653.3158569-2-dmitry.baryshkov@linaro.org>
 <20220427141329.GA4161@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220427141329.GA4161@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/04/2022 17:13, Manivannan Sadhasivam wrote:
> On Wed, Apr 27, 2022 at 03:16:49PM +0300, Dmitry Baryshkov wrote:
>> Qualcomm version of DWC PCIe controller supports more than 32 MSI
>> interrupts, but they are routed to separate interrupts in groups of 32
>> vectors. To support such configuration, change the msi_irq field into an
>> array. Let the DWC core handle all interrupts that were set in this
>> array.
>>
> 
> Instead of defining it as an array, can we allocate it dynamically in the
> controller drivers instead? This has two benefits:
> 
> 1. There is no need of using a dedicated flag.
> 2. Controller drivers that don't support MSIs can pass NULL and in the core we
> can use platform_get_irq_byname_optional() to get supported number of MSIs from
> devicetree.

I think using dynamic allocation would make code worse. It would add 
additional checks here and there.

If you don't like this design. I have an alternative suggestion: export 
the dw_chained_msi_irq() and move allocation of all MSIs to the 
pcie-qcom code. Would that be better? I'm not sure whether this 
multi-host-IRQ design is used on other DWC platforms or not.

> 
> Thanks,
> Mani
> 
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>>   drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
>>   .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
>>   drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>>   drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
>>   drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
>>   7 files changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index dfcdeb432dc8..0919c96dcdbd 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -483,7 +483,7 @@ static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>   		return pp->irq;
>>   
>>   	/* MSI IRQ is muxed */
>> -	pp->msi_irq = -ENODEV;
>> +	pp->msi_irq[0] = -ENODEV;
>>   
>>   	ret = dra7xx_pcie_init_irq_domain(pp);
>>   	if (ret < 0)
>> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
>> index 467c8d1cd7e4..4f2010bd9cd7 100644
>> --- a/drivers/pci/controller/dwc/pci-exynos.c
>> +++ b/drivers/pci/controller/dwc/pci-exynos.c
>> @@ -292,7 +292,7 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
>>   	}
>>   
>>   	pp->ops = &exynos_pcie_host_ops;
>> -	pp->msi_irq = -ENODEV;
>> +	pp->msi_irq[0] = -ENODEV;
>>   
>>   	ret = dw_pcie_host_init(pp);
>>   	if (ret) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 2fa86f32d964..5d90009a0f73 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -257,8 +257,11 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>>   
>>   static void dw_pcie_free_msi(struct pcie_port *pp)
>>   {
>> -	if (pp->msi_irq)
>> -		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
>> +	u32 ctrl;
>> +
>> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>> +		if (pp->msi_irq[ctrl])
>> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
>>   
>>   	irq_domain_remove(pp->msi_domain);
>>   	irq_domain_remove(pp->irq_domain);
>> @@ -368,13 +371,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>>   				pp->irq_mask[ctrl] = ~0;
>>   
>> -			if (!pp->msi_irq) {
>> -				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
>> -				if (pp->msi_irq < 0) {
>> -					pp->msi_irq = platform_get_irq(pdev, 0);
>> -					if (pp->msi_irq < 0)
>> -						return pp->msi_irq;
>> +			if (!pp->msi_irq[0]) {
>> +				int irq = platform_get_irq_byname_optional(pdev, "msi");
>> +
>> +				if (irq < 0) {
>> +					irq = platform_get_irq(pdev, 0);
>> +					if (irq < 0)
>> +						return irq;
>>   				}
>> +				pp->msi_irq[0] = irq;
>>   			}
>>   
>>   			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>> @@ -383,10 +388,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   			if (ret)
>>   				return ret;
>>   
>> -			if (pp->msi_irq > 0)
>> -				irq_set_chained_handler_and_data(pp->msi_irq,
>> -							    dw_chained_msi_isr,
>> -							    pp);
>> +			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>> +				if (pp->msi_irq[ctrl] > 0)
>> +					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
>> +									 dw_chained_msi_isr,
>> +									 pp);
>>   
>>   			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
>>   			if (ret)
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 7d6e9b7576be..9c1a38b0a6b3 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -187,7 +187,7 @@ struct pcie_port {
>>   	u32			io_size;
>>   	int			irq;
>>   	const struct dw_pcie_host_ops *ops;
>> -	int			msi_irq;
>> +	int			msi_irq[MAX_MSI_CTRLS];
>>   	struct irq_domain	*irq_domain;
>>   	struct irq_domain	*msi_domain;
>>   	u16			msi_msg;
>> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
>> index 1ac29a6eef22..297e6e926c00 100644
>> --- a/drivers/pci/controller/dwc/pcie-keembay.c
>> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
>> @@ -338,7 +338,7 @@ static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
>>   	int ret;
>>   
>>   	pp->ops = &keembay_pcie_host_ops;
>> -	pp->msi_irq = -ENODEV;
>> +	pp->msi_irq[0] = -ENODEV;
>>   
>>   	ret = keembay_pcie_setup_msi_irq(pcie);
>>   	if (ret)
>> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
>> index 1569e82b5568..cc7776833810 100644
>> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
>> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
>> @@ -172,7 +172,7 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
>>   	}
>>   
>>   	pp->ops = &spear13xx_pcie_host_ops;
>> -	pp->msi_irq = -ENODEV;
>> +	pp->msi_irq[0] = -ENODEV;
>>   
>>   	ret = dw_pcie_host_init(pp);
>>   	if (ret) {
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index b1b5f836a806..e75712db85b0 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -2271,7 +2271,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
>>   
>>   	disable_irq(pcie->pci.pp.irq);
>>   	if (IS_ENABLED(CONFIG_PCI_MSI))
>> -		disable_irq(pcie->pci.pp.msi_irq);
>> +		disable_irq(pcie->pci.pp.msi_irq[0]);
>>   
>>   	tegra194_pcie_pme_turnoff(pcie);
>>   	tegra_pcie_unconfig_controller(pcie);
>> -- 
>> 2.35.1
>>


-- 
With best wishes
Dmitry
