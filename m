Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144FA52F20B
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 20:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352407AbiETSHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiETSHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 14:07:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F10D18C052
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:07:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u23so15681169lfc.1
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mAvXka/K4vTJUVKh3HywAZKjh1VdtKdtrBO8nUgt5Kg=;
        b=PCNc9mYnLFMk26nSYKsrGsijruCcAel2lWQCYv9ECe28Fo9kSEsSMMaTSQM6ge+ABP
         osBN3Jq7eGDCxyxDubAUNSy/QdOrMbPd8m8a2jjy1d++mWkBOmHtUZvyKF40o+UgVF+b
         MKXCHwBSiRSfFBklCPeE0Yn/8veTWixIekjBLXWziP7q6nnp39oJpWvCKZGkAcMSuIgY
         H92FAPwmaK1N2DceUhzwqz4cvuvhZuRrXS7j0QTvXhCJTzlsGEZxbUhn53whzDupCLUg
         w1P9Ygz0ed2axHdtch68jpb2AQspu+M/JeD2J9IVTBAdzIy9TN8u6dwg9jPs+zuw0qNM
         18cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mAvXka/K4vTJUVKh3HywAZKjh1VdtKdtrBO8nUgt5Kg=;
        b=viGAUDJmba+069CgAes+Hr9KaCZq0PVWYxp3uw/9xWiyW08lwFxTpzsx6Nqcjq8Iwp
         pukXCkr4+h++YtjlKAf9EH6N+J+61PLQyc0RJb0hnbg59n5dLsdlPnX/ttrhAxdzdMlF
         GlWyuj9i6Ak50KArQqtAzYsxfkxn6b7XRemBkL10Y0bfMuV2dD48d7jgWdcLI5u8394k
         dUIDrCqyTF+ERR7Yg6/NP2ITIQVM9H0dD2BmSPaWEDUrd+ZhzksdF3IVcL0VcgQ/0gMl
         b6AbAzeP0RDgk/h91fQDh2PPiUVY7I8pH1+1CZfGBu8fvwKEs2/5KYf48uQaPZgdj3u9
         QN+w==
X-Gm-Message-State: AOAM530cnFluTxzIL1LGCTdShYmgabUoSniTXVQ5RWMd5L89TFSkHDPU
        LI+reD+8ZxYsidc2VluhfbC+Fw==
X-Google-Smtp-Source: ABdhPJwBww574ZY9b1SAauSjxGUH1kZvIesP7vieS+Ben2OWqZcPw3ilAvLP2FM61MpucttomLTlfQ==
X-Received: by 2002:a05:6512:a92:b0:45c:6b70:c892 with SMTP id m18-20020a0565120a9200b0045c6b70c892mr7719027lfu.124.1653070029620;
        Fri, 20 May 2022 11:07:09 -0700 (PDT)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id q11-20020ac25fcb000000b0047255d211bcsm740429lfg.235.2022.05.20.11.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 11:07:09 -0700 (PDT)
Message-ID: <ad3c5881-9e59-795d-0735-f23ba815a31b@linaro.org>
Date:   Fri, 20 May 2022 21:07:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v10 06/10] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
 <20220513172622.2968887-7-dmitry.baryshkov@linaro.org>
 <YoS/wwkZoaFc76u1@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YoS/wwkZoaFc76u1@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/05/2022 12:43, Johan Hovold wrote:
> On Fri, May 13, 2022 at 08:26:18PM +0300, Dmitry Baryshkov wrote:
>> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
>> separate GIC interrupt. Implement support for such configurations by
>> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
>> handler.
>>
>> Note, that if DT doesn't list an array of MSI interrupts and uses single
>> "msi" IRQ, the driver will limit the amount of supported MSI vectors
>> accordingly (to 32).
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++++++++++-
>>   drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>>   2 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 70f0435907c1..320a968dd366 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -288,6 +288,11 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>>   	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>>   }
>>   
>> +static const char * const split_msi_names[] = {
>> +	"msi0", "msi1", "msi2", "msi3",
>> +	"msi4", "msi5", "msi6", "msi7",
>> +};
>> +
>>   static int dw_pcie_msi_host_init(struct pcie_port *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -300,17 +305,48 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>>   	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>>   		pp->irq_mask[ctrl] = ~0;
>>   
>> +	if (pp->has_split_msi_irq) {
> 
> You don't need to add this configuration parameter as it can be inferred
> from the devicetree (e.g. if "msi0" is specified).
> 
>> +		/*
>> +		 * Parse as many IRQs as described in the DTS. If there are
>> +		 * none, fallback to the single "msi" IRQ.
>> +		 */
>> +		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
>> +			int irq;
>> +
>> +			if (pp->msi_irq[ctrl])
>> +				continue;
>> +
>> +			irq = platform_get_irq_byname(pdev, split_msi_names[ctrl]);
> 
> You need to use platform_get_irq_byname_optional() here or an error will
> still printed if the number of "msi" interrupts is less than 8.
> 
>> +			if (irq == -ENXIO) {
>> +				num_ctrls = ctrl;
>> +				break;
>> +			} else if (irq < 0) {
>> +				return dev_err_probe(dev, irq,
>> +						     "Failed to parse MSI IRQ '%s'\n",
>> +						     split_msi_names[ctrl]);
>> +			}
>> +
>> +			pp->msi_irq[ctrl] = irq;
>> +		}
>> +
>> +		if (num_ctrls == 0)
>> +			num_ctrls = 1;
>> +	}
>> +
>>   	if (!pp->msi_irq[0]) {
>>   		int irq = platform_get_irq_byname_optional(pdev, "msi");
>>   
>>   		if (irq < 0) {
>>   			irq = platform_get_irq(pdev, 0);
>>   			if (irq < 0)
>> -				return irq;
>> +				return dev_err_probe(dev, irq, "Failed to parse MSI irq\n");
>>   		}
>>   		pp->msi_irq[0] = irq;
>>   	}
>>   
>> +	pp->num_vectors = min_t(u32, pp->num_vectors, num_ctrls * MAX_MSI_IRQS_PER_CTRL);
>> +	dev_dbg(dev, "Using %d MSI vectors\n", pp->num_vectors);
> 
> Can you rework the handling of num_vectors == 0 (in dw_pcie_host_init())
> so that the number is always inferred from the number of "msi"
> interrupts without having to pass in num_vectors == MAX_MSI_IRQS?

It wasn't that easy, but I think I ended up doing it properly.

> 
> That is
> 
> 	num_vectors == 0 && "msi" => num_vectors = MSI_DEF_NUM_VECTORS (32)
> 	num_vectors == 0 && "msi0".."msin" => num_vectors = n * MAX_MSI_IRQS_PER_CTRL (n * 32)
> 
>> +
>>   	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>>   
>>   	ret = dw_pcie_allocate_domains(pp);
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 9c1a38b0a6b3..3aa840a5b19c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -179,6 +179,7 @@ struct dw_pcie_host_ops {
>>   
>>   struct pcie_port {
>>   	bool			has_msi_ctrl:1;
>> +	bool			has_split_msi_irq:1;
>>   	u64			cfg0_base;
>>   	void __iomem		*va_cfg0_base;
>>   	u32			cfg0_size;
> 
> Johan


-- 
With best wishes
Dmitry
