Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE359605EBF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 13:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJTLXA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 07:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiJTLW6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 07:22:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92E188597
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 04:22:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id by36so25890639ljb.4
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CwcvlpFW5F7tCoE9O6AnR3qrLGqqXwqUy7jHIaT+Uk=;
        b=OWqUr8aT1UoEARhZgIAHCobUZazl0Gifw6uXrpHgubJB4SjRjn8VyeIVskJX9ndWO4
         69EH3x3RuF6lRNO4+KhbraeQ95f4l4MQFwQeZsWNvBdUp+ieA5SX/a8bX80OTLUMFJdG
         jUfJz8MyA+Vn86KTwTiQyxJma4YVGspn2+EGugoa6waOTLQcwG8mRIEwNl0yZWSCBrw0
         SghL4b84//kDDFgy1mboxxjkLLQGzHCrvNhBTtFxfF/3oYjMSqJTS3oHQtm8gNGmHvae
         b6Z8/+1HN2KvUiOo2Vv10VPrRefOT3/t1cp90rbMNI9L9GeuVVQk66oVJunIZ0JJorbF
         twQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CwcvlpFW5F7tCoE9O6AnR3qrLGqqXwqUy7jHIaT+Uk=;
        b=SNWTXybCL7FOkU2VtA/Do62QtoqcOZ+7XyIeZX4bhejdIfA0Iern5gz6K6nhcimYEg
         tjV01rVzberlqFXlW3jFhe6keb7H7RMDppAK/q4mW1hxp3Awl4FZcDe/DCg23hyotKYH
         nKfjdWfjCsDYFhy2b56MpTg9L3eH2bJE6ORdC4vw42hgQ/A9HtchE8YuoQGM6LnxvoP0
         1u+oWCwfxdxGLYQkmIrlh54Sr/qH6HfggIOyUP6QaEMI3zbfplwPS3hgChuHL0WybJ67
         nVurnJhSYjfKnZppyCN7oJ9TGY36j2Z9akp5dEIxsJIQpd7tUxhzcOrBuHyz5qtqNlNJ
         e1xg==
X-Gm-Message-State: ACrzQf15H2gA/qqkfIzXTW4Nvgqv6WzzKYxYULjx0Ql7sj3vN3zjoSSj
        bXtE/qvdsmDm9S1Tr1UJicsQ/5y/M9lnjg==
X-Google-Smtp-Source: AMsMyM5pp4r0GZcuKPJY37g7IstCS83KLDclAUQ/yeKe87f04T6js7bszqlI+QpOlqbTWUs1SHtcIA==
X-Received: by 2002:a05:651c:986:b0:26e:6a48:fcc1 with SMTP id b6-20020a05651c098600b0026e6a48fcc1mr4568151ljq.258.1666264968428;
        Thu, 20 Oct 2022 04:22:48 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651234c700b00492b0d23d24sm2676360lfr.247.2022.10.20.04.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 04:22:48 -0700 (PDT)
Message-ID: <30850757-0e39-bd3d-0d4f-cdb4627b097c@linaro.org>
Date:   Thu, 20 Oct 2022 14:22:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/4] PCI: qcom: Use clk_bulk_ API for 1.0.0 clocks
 handling
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
 <20221020103120.1541862-3-dmitry.baryshkov@linaro.org>
 <Y1EsOGhEqNe9Cxo6@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y1EsOGhEqNe9Cxo6@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10/2022 14:08, Johan Hovold wrote:
> On Thu, Oct 20, 2022 at 01:31:18PM +0300, Dmitry Baryshkov wrote:
>> Change hand-coded implementation of bulk clocks to use the existing
> 
> Let's hope everything is "hand-coded" at least for a few years still
> (job security). ;)
> 
> Perhaps rephrase using "open-coded"?

Yes, thank you.

> 
>> clk_bulk_* API.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 67 ++++++--------------------
>>   1 file changed, 16 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 939f19241356..74588438db07 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -133,10 +133,7 @@ struct qcom_pcie_resources_2_1_0 {
>>   };
>>   
>>   struct qcom_pcie_resources_1_0_0 {
>> -	struct clk *iface;
>> -	struct clk *aux;
>> -	struct clk *master_bus;
>> -	struct clk *slave_bus;
>> +	struct clk_bulk_data clks[4];
>>   	struct reset_control *core;
>>   	struct regulator *vdda;
>>   };
>> @@ -472,26 +469,20 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
>>   	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
>>   	struct dw_pcie *pci = pcie->pci;
>>   	struct device *dev = pci->dev;
>> +	int ret;
>>   
>>   	res->vdda = devm_regulator_get(dev, "vdda");
>>   	if (IS_ERR(res->vdda))
>>   		return PTR_ERR(res->vdda);
>>   
>> -	res->iface = devm_clk_get(dev, "iface");
>> -	if (IS_ERR(res->iface))
>> -		return PTR_ERR(res->iface);
>> -
>> -	res->aux = devm_clk_get(dev, "aux");
>> -	if (IS_ERR(res->aux))
>> -		return PTR_ERR(res->aux);
>> -
>> -	res->master_bus = devm_clk_get(dev, "master_bus");
>> -	if (IS_ERR(res->master_bus))
>> -		return PTR_ERR(res->master_bus);
>> +	res->clks[0].id = "aux";
>> +	res->clks[1].id = "iface";
>> +	res->clks[2].id = "master_bus";
>> +	res->clks[3].id = "slave_bus";
>>   
>> -	res->slave_bus = devm_clk_get(dev, "slave_bus");
>> -	if (IS_ERR(res->slave_bus))
>> -		return PTR_ERR(res->slave_bus);
>> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
>> +	if (ret < 0)
>> +		return ret;
> 
> Are you sure there are no dependencies between these clocks and that
> they can be enabled and disabled in any order?

The order is enforced by the bulk API. Forward to enable, backward to 
disable.

> 
> Are you also convinced that they will always be enabled and disabled
> together (e.g. not controlled individually during suspend)?

 From what I see downstream, yes. They separate host and pipe clocks, 
but for each of these groups all clocks are disabled and enabled in 
sequence.

For the newer platforms the only exceptions are refgen (handled by the 
PHY in our kernels) and ddrss_sf_tbu (only on some platforms), which is 
not touched by these patches.

> 
>> -	ret = clk_prepare_enable(res->aux);
>> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
>>   	if (ret) {
>> -		dev_err(dev, "cannot prepare/enable aux clock\n");
>> +		dev_err(dev, "cannot prepare/enable clocks\n");
> 
> The bulk API already logs an error so you can drop the dev_err().

Ack.

> 
> These comments apply also to the other patches.
> 
> Johan

-- 
With best wishes
Dmitry

