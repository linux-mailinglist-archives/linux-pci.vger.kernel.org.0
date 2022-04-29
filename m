Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB151589B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 00:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381586AbiD2WnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 18:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiD2WnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 18:43:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF2DD943
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 15:39:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq30so16418115lfb.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xkOXAm5roOsGjVaXomMUY11MzI4/ZjpjlrOdnkooNJs=;
        b=K0HLTrsFg4ZalCcqldQxY+hSJGSn2IJLNEy9pIbhV6QAh/cXzzVkVDEa1C+B3S9heg
         h42t3wt2fVNI9xJ/oUiGgNB5wonVxJqtxfTjWgD6c396TaauTWXP4ohT7MOjys1QxEZ8
         Tr1DAuiGzaLA9ZdjN5W8c7tp+Mz3I8GpFslrqgaaywTvNZc6dA4XlY8Rfi4NkSaww8+F
         DTdUYQ1K69tQrPyNsgUR2jftQvLcbT/b3yonCNUApWbW6ExsSE1lNuUlm15TZFZnvEp/
         /XxltRPF5lJb8e9vPdfU+XN483GETjRzeqPvhB8Y3MPo1ErVQSaHOkYysspx2iSWppoZ
         wu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xkOXAm5roOsGjVaXomMUY11MzI4/ZjpjlrOdnkooNJs=;
        b=kqXSpreiDpUqqQGz9cRDcmrJ5oeoJE9+gwKy0W/weqKZVVQJqCdt+Qd0Fpxe1bsJym
         CNPAE9DZytMwZrhzWpE1oXRXYYoluUGtcn2rkEIkfypby4wX60E3nZwwNX5urgQF21rR
         rBha3MAwoXB3MlXkTGGL/TzoR0h+f9JIEyBtnlWlcxwDINuD58Ts5Fmw86oZxfyrMMYd
         1k/ybF41huTP4F8G0IlECssJrCEXwtCM3lKJKBQg9jzCdEpd6ROm5Lwgn74TRMhpyQmQ
         QazQ6ts8bLGmVmIR3mvfO0HE6u2zTQAn81EREWvzwOJUUo4ZWHPp/IxZKg1Zg1Jbb/85
         G4wA==
X-Gm-Message-State: AOAM530e8j8baTZCbQgNBU++Lxx+3OkUZV6zf1HNCkPP69WQ5HCp15AS
        yx6xfVHOCzFwRIuMXTu5ob9jBw==
X-Google-Smtp-Source: ABdhPJxYgkIlFyj3FweIICDgn67fmbCknHaZIGCN3b3jwZvkbUlxtqSW8Kz6sKoBmJl+NKFAkBIb6A==
X-Received: by 2002:a05:6512:3051:b0:470:8f74:4373 with SMTP id b17-20020a056512305100b004708f744373mr1003597lfb.149.1651271998230;
        Fri, 29 Apr 2022 15:39:58 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25590000000b0047255d211d4sm41041lfg.259.2022.04.29.15.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:39:57 -0700 (PDT)
Message-ID: <43c6c850-e3c2-1998-8c72-bb987f20370b@linaro.org>
Date:   Sat, 30 Apr 2022 01:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/7] PCI: qcom: Revert "PCI: qcom: Add support for
 handling MSIs from 8 endpoints"
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
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
References: <20220429220700.GA110578@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429220700.GA110578@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/04/2022 01:07, Bjorn Helgaas wrote:
> On Sat, Apr 30, 2022 at 12:42:44AM +0300, Dmitry Baryshkov wrote:
>> I have replied with my Tested-by to the patch at [2], which has landed
>> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
>> Add support for handling MSIs from 8 endpoints"). However lately I
>> noticed that during the tests I still had 'pcie_pme=nomsi', so the
>> device was not forced to use higher MSI vectors.
>>
>> After removing this option I noticed that hight MSI vectors are not
>> delivered on tested platforms. Additional research pointed to
>> a patch in msm-4.14 ([1]), which describes that each group of MSI
>> vectors is mapped to the separate interrupt.
>>
>> Without these changes specifying num_verctors can lead to missing MSI
>> interrupts and thus to devices malfunction.
>>
>> Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
> 
> 20f1bfb8dd62 hasn't been merged upstream yet, so I think Lorenzo can
> just drop it from his pci/qcom branch so we don't need to clutter the
> git history with the revert.

I'm fine with either way.

> 
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index c940e67d831c..375f27ab9403 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1593,7 +1593,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	pci->dev = dev;
>>   	pci->ops = &dw_pcie_ops;
>>   	pp = &pci->pp;
>> -	pp->num_vectors = MAX_MSI_IRQS;
>>   
>>   	pcie->pci = pci;
>>   
>> -- 
>> 2.35.1
>>


-- 
With best wishes
Dmitry
