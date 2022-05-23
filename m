Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1353128C
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiEWNkD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 09:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiEWNkC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 09:40:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C9546BC
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 06:39:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j10so2177268lfe.12
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7jVIoyXDoN8BUaXwgx72nxc8bY3gSk2cGnS+pPrO6YI=;
        b=N7Icjhgo9jczhWrqVMUjdJbL2WO6Ll9oe6tZ2viprpIUaf71DwfU0rnyRAXW6XurJR
         AYDGI0z/2rYKfJbxgShe6vWCsGnENWLJFD/B+G+incKjN3f19CBYo3YMLnEDlOPttOdE
         GFW7qmb/C4qP/QJqY4vyVnFIVIDwms9bAfshrjfi/rrGOXT4o+CIA4lAnpmv/sdomKv3
         pjIBw0duxpQgD2bSx2bIQuqQdhXS+c6qxS6VAUIUspTv/7KjfyJjw5fR+RvCY/uvkNN/
         ihvmT1Kbky9MGkJOMzLZJwOmVaJnGNDrNQv/GI6SYtx2zO29PFkBJeokxXADNeVyHvEX
         Fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7jVIoyXDoN8BUaXwgx72nxc8bY3gSk2cGnS+pPrO6YI=;
        b=0sKL/tZBtNs4hGYy+cfaJlDs7KOjHob8o79mXxH92fUB84CaVi4VGI21P/instT/S3
         TI2buG3iD8jXok7AjhQL0FcpTtb7VcE5E5sK8nJVQfiYY1IAUccIAKqBKldWHl31/g/o
         +N3my2GrmU9P10jqye4gJRbyH7gPMt09Hvd6JiAdMjbWCPLticamjK55iyhOkEn8kxvU
         uNKhYtc/d3YuyoHLJve7PsQM3OFrV60yaVxUioyST+si7TK26BVkXBHLrC32BFlGdcBq
         CsC40q3LYn6bA1LSPUqaWt9SgPYSgJnuGy1xRASced6+Lxi5ZnOf0cniQulKxpsiIwjj
         3NnA==
X-Gm-Message-State: AOAM5300P6mKci048i8y/JxJiLnpbcSZE+Jmcmu2EleeVAsT69s+H/JA
        KRKj/PnAshfJSNIU44H946K6FA==
X-Google-Smtp-Source: ABdhPJxm4/cQN0TPD9jcD041vnU1p5Wwv6GY89h3dMAa3runVjnRLnAeAW11yi0gz29FUf7wXL7qDw==
X-Received: by 2002:a05:6512:3f15:b0:477:ce24:4e1f with SMTP id y21-20020a0565123f1500b00477ce244e1fmr13087186lfa.355.1653313198006;
        Mon, 23 May 2022 06:39:58 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d19-20020a2e3313000000b0024b14fa6061sm1840791ljc.1.2022.05.23.06.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:39:57 -0700 (PDT)
Message-ID: <8ce50a9f-241d-c37a-15e9-1a97d410f61e@linaro.org>
Date:   Mon, 23 May 2022 16:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v11 3/7] PCI: dwc: Handle MSIs routed to multiple GIC
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
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
 <20220520183114.1356599-4-dmitry.baryshkov@linaro.org>
 <Yos9fkgxAN1jJ4jO@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yos9fkgxAN1jJ4jO@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/05/2022 10:53, Johan Hovold wrote:
> On Fri, May 20, 2022 at 09:31:10PM +0300, Dmitry Baryshkov wrote:
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
>>   .../pci/controller/dwc/pcie-designware-host.c | 58 +++++++++++++++++--
>>   1 file changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index a076abe6611c..381bc24d5715 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -288,6 +288,43 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>>   	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>>   }
>>   
>> +static const char * const split_msi_names[] = {
>> +	"msi0", "msi1", "msi2", "msi3",
>> +	"msi4", "msi5", "msi6", "msi7",
>> +};
>> +
>> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct device *dev = pci->dev;
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	int irq;
>> +	u32 ctrl;
>> +
>> +	irq = platform_get_irq_byname_optional(pdev, split_msi_names[0]);
>> +	if (irq == -ENXIO)
>> +		return -ENXIO;
> 
> You still need to check for other errors and -EPROBE_DEFER here.

I think even the if (irq < 0) return irq; will work here.

> 
>> +
>> +	pp->msi_irq[0] = irq;
>> +
>> +	/* Parse as many IRQs as described in the DTS. */
> 
> s/DTS/devicetree/
> 
>> +	for (ctrl = 1; ctrl < MAX_MSI_CTRLS; ctrl++) {
>> +		irq = platform_get_irq_byname_optional(pdev, split_msi_names[ctrl]);
>> +		if (irq == -ENXIO)
>> +			break;
>> +		if (irq < 0)
>> +			return dev_err_probe(dev, irq,
>> +					     "Failed to parse MSI IRQ '%s'\n",
>> +					     split_msi_names[ctrl]);
>> +
>> +		pp->msi_irq[ctrl] = irq;
>> +	}
>> +
>> +	pp->num_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
>> +
>> +	return 0;
>> +}
>> +
>>   static int dw_pcie_msi_host_init(struct pcie_port *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -295,22 +332,34 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>>   	struct platform_device *pdev = to_platform_device(dev);
>>   	int ret;
>>   	u32 ctrl, num_ctrls;
>> +	bool has_split_msi_irq = false;
> 
> This one should go in the follow-on patch that starts using it.
> 
>> -	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> -	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>>   		pp->irq_mask[ctrl] = ~0;
>>   
>> +	if (!pp->msi_irq[0]) {
>> +		ret = dw_pcie_parse_split_msi_irq(pp);
>> +		if (ret < 0 && ret != -ENXIO)
>> +			return ret;
>> +	}
>> +
>> +	if (!pp->num_vectors)
>> +		pp->num_vectors = MSI_DEF_NUM_VECTORS;
> 
> This works, but now you override num_vectors unconditionally when using
> split msis (and not just when num_vectors is set to zero) >
> Is it work allowing to use num_vectors as a maximum as in previous
> versions (if only for consistency)?

Let me take a look.

> 
>> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
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
>> +	dev_dbg(dev, "Using %d MSI vectors\n", pp->num_vectors);
>> +
>>   	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>>   
>>   	ret = dw_pcie_allocate_domains(pp);
>> @@ -407,7 +456,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   				     of_property_read_bool(np, "msi-parent") ||
>>   				     of_property_read_bool(np, "msi-map"));
>>   
>> -		if (!pp->num_vectors) {
>> +		/* for the has_msi_ctrl the default assignment is handled inside dw_pcie_msi_host_init() */
>> +		if (!pp->has_msi_ctrl && !pp->num_vectors) {
>>   			pp->num_vectors = MSI_DEF_NUM_VECTORS;
>>   		} else if (pp->num_vectors > MAX_MSI_IRQS) {
>>   			dev_err(dev, "Invalid number of vectors\n");
> 
> Johan


-- 
With best wishes
Dmitry
