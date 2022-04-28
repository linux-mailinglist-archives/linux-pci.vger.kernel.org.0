Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA5512D3B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiD1HrQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbiD1HrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 03:47:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6949D05D
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 00:43:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p10so7065711lfa.12
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 00:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZeQ55rir3pvpzG7mxMHAL9JH9vYFV3iLsewoNK++nCc=;
        b=wLi8paTcv7rTS87NS9wDvpud0PfLTGEK4kxEtD8jhiwaekHwfjYGAuTTOShVU4EkbJ
         vNxxuigmLJdvzQW5QC7PXe3+FD1iuu1REoNdvThrDzkXrYIS/1DngzbKw9aViISPgim4
         7tAkFuvNQuSdBqsdhoTn1aCOjMqTUnFeGfwlC3Bjwci9nPIciuqml7ZQM/Oh5WVqyE1k
         CkvZv7/CgzORgK53M9xL1GXU5u0kvLu25YFpRcJaebE9Fx4zy5uvbaMjI0kmr6a59ulp
         NEHd70tvrPoqDZUoqC/Z6idfmxf28voWlHX0S1ConySw3v9xBBzwYbFpjmvcPnRbNSXm
         5CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZeQ55rir3pvpzG7mxMHAL9JH9vYFV3iLsewoNK++nCc=;
        b=E2QsAcm/3qGnTsbj+nZJDIGHEt2gyaOn5AXXrO5lVsfCaKPcl4ywN0p6cznN8l0MNf
         SiKj79Ae9PrIJ1O/RWe7dY1NbQvn1ofzdL8AM1VvZxWY7ND/XJqfFmDdmUCE9XoaGj2R
         726rbenyXGhZPtkJWejaaArbFJLzFpYGf+UfoFnfj0bOVlqT57+GuwxMvKpSK5eScOHQ
         UkOcv7knBzgO6JvvhD0IOCS0Rn4KmLX9WW/PTnkae2MukbXmTGtibfC34xgy6GhSsM9R
         8DKZhTKqoz7934IRSsdbVqzJ9Z0bmkEn699e4X/5dBdRWQhoXnwZqndTw8ryD+zhldTS
         UoMA==
X-Gm-Message-State: AOAM530PBghnI14RbQvRbwX5pHFBooj12oHuTifQRf43clhxGAHARgy+
        wPP09Js2NY166jKKCE8jPQmpdw==
X-Google-Smtp-Source: ABdhPJwSeVK6hXWCQGEOgF8ZW5yXjQsdw2Zunis7UkM3d/CaIYO/YBx1q9tHCevKT3+0ElIszldAsA==
X-Received: by 2002:a05:6512:34d8:b0:46d:4a1e:7c9a with SMTP id w24-20020a05651234d800b0046d4a1e7c9amr23476156lfr.336.1651131836637;
        Thu, 28 Apr 2022 00:43:56 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f4-20020a193804000000b00471a32f8f72sm2280264lfa.229.2022.04.28.00.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:43:56 -0700 (PDT)
Message-ID: <80132575-1abc-9a2e-dc73-3df72035a7d0@linaro.org>
Date:   Thu, 28 Apr 2022 10:43:54 +0300
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
 <b9d81916-10e6-94f9-78b2-b2198620e66a@linaro.org>
 <20220428060642.GA81644@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220428060642.GA81644@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/04/2022 09:06, Manivannan Sadhasivam wrote:
> On Wed, Apr 27, 2022 at 07:59:57PM +0300, Dmitry Baryshkov wrote:
>> On 27/04/2022 17:13, Manivannan Sadhasivam wrote:
>>> On Wed, Apr 27, 2022 at 03:16:49PM +0300, Dmitry Baryshkov wrote:
>>>> Qualcomm version of DWC PCIe controller supports more than 32 MSI
>>>> interrupts, but they are routed to separate interrupts in groups of 32
>>>> vectors. To support such configuration, change the msi_irq field into an
>>>> array. Let the DWC core handle all interrupts that were set in this
>>>> array.
>>>>
>>>
>>> Instead of defining it as an array, can we allocate it dynamically in the
>>> controller drivers instead? This has two benefits:
>>>
>>> 1. There is no need of using a dedicated flag.
>>> 2. Controller drivers that don't support MSIs can pass NULL and in the core we
>>> can use platform_get_irq_byname_optional() to get supported number of MSIs from
>>> devicetree.
>>
>> I think using dynamic allocation would make code worse. It would add
>> additional checks here and there.
>>
> 
> I take back my suggestion of allocating the memory for msi_irq in controller
> drivers. It should be done in the designware-host instead.
> 
> We already know how many MSIs are supported by the platform using num_vectors.
> So we should just allocate msi_irqs of num_vectors length in
> dw_pcie_host_init() and populate it using platform_get_irq_byname_optional().
> 
> I don't think this can make the code worse.
> 
>> If you don't like this design. I have an alternative suggestion: export the
>> dw_chained_msi_irq() and move allocation of all MSIs to the pcie-qcom code.
>> Would that be better? I'm not sure whether this multi-host-IRQ design is
>> used on other DWC platforms or not.
>>
> 
> No, I think the allocation should belong to designware-host.

Granted that at least tegra and iMX tie all MSI vectors to a single host 
interrupt, I think it's impractical to assume that other hosts would 
benefit from such allocation. Let's move support for split IRQs into the 
pcie-qcom.c. We can make this generic later if any other host would use 
a separate per-"endpoint" (per-group) IRQ.

> 
> Thanks,
> Mani
> 
>>>
>>> Thanks,
>>> Mani
>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>    drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>>>>    drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
>>>>    .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
>>>>    drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>>>>    drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
>>>>    drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
>>>>    drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
>>>>    7 files changed, 24 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>>>> index dfcdeb432dc8..0919c96dcdbd 100644
>>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>>>> @@ -483,7 +483,7 @@ static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>>>    		return pp->irq;
>>>>    	/* MSI IRQ is muxed */
>>>> -	pp->msi_irq = -ENODEV;
>>>> +	pp->msi_irq[0] = -ENODEV;
>>>>    	ret = dra7xx_pcie_init_irq_domain(pp);
>>>>    	if (ret < 0)
>>>> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
>>>> index 467c8d1cd7e4..4f2010bd9cd7 100644
>>>> --- a/drivers/pci/controller/dwc/pci-exynos.c
>>>> +++ b/drivers/pci/controller/dwc/pci-exynos.c
>>>> @@ -292,7 +292,7 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
>>>>    	}
>>>>    	pp->ops = &exynos_pcie_host_ops;
>>>> -	pp->msi_irq = -ENODEV;
>>>> +	pp->msi_irq[0] = -ENODEV;
>>>>    	ret = dw_pcie_host_init(pp);
>>>>    	if (ret) {
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index 2fa86f32d964..5d90009a0f73 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -257,8 +257,11 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>>>>    static void dw_pcie_free_msi(struct pcie_port *pp)
>>>>    {
>>>> -	if (pp->msi_irq)
>>>> -		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
>>>> +	u32 ctrl;
>>>> +
>>>> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>>>> +		if (pp->msi_irq[ctrl])
>>>> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
>>>>    	irq_domain_remove(pp->msi_domain);
>>>>    	irq_domain_remove(pp->irq_domain);
>>>> @@ -368,13 +371,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>    			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>>>>    				pp->irq_mask[ctrl] = ~0;
>>>> -			if (!pp->msi_irq) {
>>>> -				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
>>>> -				if (pp->msi_irq < 0) {
>>>> -					pp->msi_irq = platform_get_irq(pdev, 0);
>>>> -					if (pp->msi_irq < 0)
>>>> -						return pp->msi_irq;
>>>> +			if (!pp->msi_irq[0]) {
>>>> +				int irq = platform_get_irq_byname_optional(pdev, "msi");
>>>> +
>>>> +				if (irq < 0) {
>>>> +					irq = platform_get_irq(pdev, 0);
>>>> +					if (irq < 0)
>>>> +						return irq;
>>>>    				}
>>>> +				pp->msi_irq[0] = irq;
>>>>    			}
>>>>    			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>>>> @@ -383,10 +388,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>    			if (ret)
>>>>    				return ret;
>>>> -			if (pp->msi_irq > 0)
>>>> -				irq_set_chained_handler_and_data(pp->msi_irq,
>>>> -							    dw_chained_msi_isr,
>>>> -							    pp);
>>>> +			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>>>> +				if (pp->msi_irq[ctrl] > 0)
>>>> +					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
>>>> +									 dw_chained_msi_isr,
>>>> +									 pp);
>>>>    			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
>>>>    			if (ret)
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>>> index 7d6e9b7576be..9c1a38b0a6b3 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>>> @@ -187,7 +187,7 @@ struct pcie_port {
>>>>    	u32			io_size;
>>>>    	int			irq;
>>>>    	const struct dw_pcie_host_ops *ops;
>>>> -	int			msi_irq;
>>>> +	int			msi_irq[MAX_MSI_CTRLS];
>>>>    	struct irq_domain	*irq_domain;
>>>>    	struct irq_domain	*msi_domain;
>>>>    	u16			msi_msg;
>>>> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
>>>> index 1ac29a6eef22..297e6e926c00 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-keembay.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
>>>> @@ -338,7 +338,7 @@ static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
>>>>    	int ret;
>>>>    	pp->ops = &keembay_pcie_host_ops;
>>>> -	pp->msi_irq = -ENODEV;
>>>> +	pp->msi_irq[0] = -ENODEV;
>>>>    	ret = keembay_pcie_setup_msi_irq(pcie);
>>>>    	if (ret)
>>>> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
>>>> index 1569e82b5568..cc7776833810 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
>>>> @@ -172,7 +172,7 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
>>>>    	}
>>>>    	pp->ops = &spear13xx_pcie_host_ops;
>>>> -	pp->msi_irq = -ENODEV;
>>>> +	pp->msi_irq[0] = -ENODEV;
>>>>    	ret = dw_pcie_host_init(pp);
>>>>    	if (ret) {
>>>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> index b1b5f836a806..e75712db85b0 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> @@ -2271,7 +2271,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
>>>>    	disable_irq(pcie->pci.pp.irq);
>>>>    	if (IS_ENABLED(CONFIG_PCI_MSI))
>>>> -		disable_irq(pcie->pci.pp.msi_irq);
>>>> +		disable_irq(pcie->pci.pp.msi_irq[0]);
>>>>    	tegra194_pcie_pme_turnoff(pcie);
>>>>    	tegra_pcie_unconfig_controller(pcie);
>>>> -- 
>>>> 2.35.1
>>>>
>>
>>
>> -- 
>> With best wishes
>> Dmitry


-- 
With best wishes
Dmitry
