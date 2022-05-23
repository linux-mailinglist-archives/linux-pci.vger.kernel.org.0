Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690945313CA
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiEWPgo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiEWPgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 11:36:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0582F010
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 08:36:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so26250877lfg.7
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fy8sndVmymYnHbsd90BxGo19Ch5pC4BtvDtl6wCgwzI=;
        b=CIZ7mIEMv1gh2SbkBbFcVFXuXuPPQnihIVDJX+tgvWkOBdGKRt2O7wv/skEgMs9LAb
         R0q8c+rSkW9c0yYHyclcPLwr63PLV0U7Hkk+8vLan1QsV51ahf5WY5H+9gDcwqGZFxgW
         It6kWZBcZzvZP0aapzjK8LPgIze4+MUB3GwssJRXVSlS/SibDCrlpc+HTGpu3ZD2/+am
         oMBWJXFcRoAyHTDuCkk/5eACnwKrcbpvsMRLYpx6saAjs+e3NwtOMFcAsQnKhokh3x3e
         zo/x+il7VyCwPLqGk0ekSYtDzYFk6p3YhlWf5Fo2JRzgmcjopJOabOPlo52bd7+bi2Dg
         BH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fy8sndVmymYnHbsd90BxGo19Ch5pC4BtvDtl6wCgwzI=;
        b=RWvMKA2wdi+6bHzNdMHPiapQm1BtfeFPcPYzNZGQ3fV3Ig+bHAGRbrGPNMI0MqmCjZ
         QJIYVxzfLOyPOfXEIKAXzz/LzM7QOm4f3kvzbT+GplQ2mPKa30x2kU9P8QM0mEXolBR0
         rlayg46GzX3fV+oopMqL7NOPk0lC1OFGX/i1DHdmON+2TAyDYrhwtIq24d+vTqGnvE9Y
         dOL/r/G+V/ObziKOCSg+gc1Sx7Y+WyFg6zjlOAUVTrBZf225rbmpxzcem1UTOOpDUEUv
         cEOkgXJ/udzK2OP3UgN+cnZbrSjO0AuXSt/rMAfCf/g6B++KsTe2XlWES3NM6df7f9Ek
         4BOg==
X-Gm-Message-State: AOAM532XBZE01kl3DsK7ks9I4blGfsGMapjQog5FMZ+rSAY9pPanoCfS
        pzmjQaZU4VikjpMOt3spsgPgQtQvp1tzcw==
X-Google-Smtp-Source: ABdhPJwM+QfBAgrq5Qhp7c49bsGzccLRV/RrGdKF+ztxnpFARSizzfmXG8uB0XN/toLfj+JZR5ABHQ==
X-Received: by 2002:a05:6512:3f26:b0:473:edee:7250 with SMTP id y38-20020a0565123f2600b00473edee7250mr16079456lfa.685.1653320196237;
        Mon, 23 May 2022 08:36:36 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t5-20020a056512208500b0047255d211cfsm2033134lfr.254.2022.05.23.08.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:36:35 -0700 (PDT)
Message-ID: <363d3be3-575d-260f-ece1-0b56b3c134ba@linaro.org>
Date:   Mon, 23 May 2022 18:36:34 +0300
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
 <8ce50a9f-241d-c37a-15e9-1a97d410f61e@linaro.org>
 <YouUCuzjo5u+OEXS@hovoldconsulting.com>
 <0bc58862-75be-aaa0-9983-6ed2fa2079ec@linaro.org>
 <YoupEr0TkgEa1S+/@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YoupEr0TkgEa1S+/@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/05/2022 18:32, Johan Hovold wrote:
> On Mon, May 23, 2022 at 06:17:19PM +0300, Dmitry Baryshkov wrote:
>> On 23/05/2022 17:02, Johan Hovold wrote:
>>> On Mon, May 23, 2022 at 04:39:56PM +0300, Dmitry Baryshkov wrote:
>>>> On 23/05/2022 10:53, Johan Hovold wrote:
>>>>> On Fri, May 20, 2022 at 09:31:10PM +0300, Dmitry Baryshkov wrote:
>>>
>>>>>> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
>>>>>> +{
>>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>> +	struct device *dev = pci->dev;
>>>>>> +	struct platform_device *pdev = to_platform_device(dev);
>>>>>> +	int irq;
>>>>>> +	u32 ctrl;
>>>>>> +
>>>>>> +	irq = platform_get_irq_byname_optional(pdev, split_msi_names[0]);
>>>>>> +	if (irq == -ENXIO)
>>>>>> +		return -ENXIO;
>>>>>
>>>>> You still need to check for other errors and -EPROBE_DEFER here.
>>>>
>>>> I think even the if (irq < 0) return irq; will work here.
>>>
>>> No need to print errors unless -EPROBEDEFER as you do below?
>>
>> There is no separate print for the dw_pcie_parse_split_msi_irq() errors.
> 
> I don't understand what you're referring to here.
> 
> My question is: Why would you not be printing error messages for msi0 as
> you are for msi1..msi7 in the loop below.

Yeah, this seems like a correct idea. Thank you!

> 
>>>>>> +
>>>>>> +	pp->msi_irq[0] = irq;
>>>>>> +
>>>>>> +	/* Parse as many IRQs as described in the DTS. */
>>>>>
>>>>> s/DTS/devicetree/
>>>>>
>>>>>> +	for (ctrl = 1; ctrl < MAX_MSI_CTRLS; ctrl++) {
>>>>>> +		irq = platform_get_irq_byname_optional(pdev, split_msi_names[ctrl]);
>>>>>> +		if (irq == -ENXIO)
>>>>>> +			break;
>>>>>> +		if (irq < 0)
>>>>>> +			return dev_err_probe(dev, irq,
>>>>>> +					     "Failed to parse MSI IRQ '%s'\n",
>>>>>> +					     split_msi_names[ctrl]);
>>>>>> +
>>>>>> +		pp->msi_irq[ctrl] = irq;
>>>>>> +	}
>>>>>> +
>>>>>> +	pp->num_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
> 
> Johan


-- 
With best wishes
Dmitry
