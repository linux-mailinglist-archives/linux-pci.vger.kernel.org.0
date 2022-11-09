Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68243622A8F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKIL36 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKIL3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 06:29:54 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B006A11461
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 03:29:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b9so25297149ljr.5
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2022 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsjC+BfITlgbOuQ0UjTm6i/nmFlsoTwcI0vvFKYa8Mk=;
        b=g5QIB/QTDYSCub/jv2G/x7ifqsL+fUsR/1SEcZslagvWACWa+eSZ3RetpER4NSefKR
         X8g0t8pQ4rNnxxb2IerWoBUWGajxuZ97C1HAMQqKUgh/6CzYuluwiOLrV9dgdmBy1UOl
         6VwOr2/iAsvjVzkvRFaS+QWvzlpP5xM2PtMMFIVzUv17Putcl5baRNQBpbRrbP+hQIoJ
         lXW4M45FPlEFLw4WglLXzg9rG2LBy+0OjmAtPU2ShaKa4PxC1+mkOuYfJk2b7GJ8TMj3
         t1kCq+4R8Vv2cmV/BB+TKKRVdd4XLj6nrPgxmNPBAauHWEr7NmPYKh+GGBqpvsC5U2JD
         0uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsjC+BfITlgbOuQ0UjTm6i/nmFlsoTwcI0vvFKYa8Mk=;
        b=ZpZSD+zNGGc2AfzSHBTvYfKwrEXJzGcdGUGsNrnWTBv5ToSjEhBegTFA/sW4bUwWeg
         GzdaGSR30vi4bsmHwak6m3YXKaUOK5Z1PCC9LAPSHjgnrZg2uBHQxfRpRORUUIkXLH0q
         jq5SnKy1mG3LTbCMfxc6EEiouVgHaAmaiqMVD0cxKn3FCRyEaMTLOPMIGfdlAWOrOiyW
         Bkv3mbA+A9smqcSw3OlBf05sTRpHyG/EuR+DuTHT073PFtNOIZm76dknk6Hx58flAQgu
         Y1g6Bf16pmJdKvVZQeG+rxQZgW2+d6ADXLU7RyR9jdoTfDSiZBsGjf5O6qc4ZbiCFn8m
         j8gg==
X-Gm-Message-State: ACrzQf28p2zDo84bxfyFc/MB9sXOcT3IyGl/eUJoE58HK5ryFCOuBdHa
        kj/gmTTh4k+Y31DBd2PcHBuuyw==
X-Google-Smtp-Source: AMsMyM5syeyQ1RIUKqLryabg00DxkLTN4YZ1uMxSEQ8R6AizPWG19LO0FV0igZqmTjyGwAHYUsTnzw==
X-Received: by 2002:a05:651c:1688:b0:277:2256:293d with SMTP id bd8-20020a05651c168800b002772256293dmr21002609ljb.514.1667993388099;
        Wed, 09 Nov 2022 03:29:48 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0049c29389b98sm2187905lfr.151.2022.11.09.03.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 03:29:47 -0800 (PST)
Message-ID: <073854c1-ea76-d432-d950-2f90548e2f71@linaro.org>
Date:   Wed, 9 Nov 2022 12:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH] dt-bindings: PCI: qcom,pcie-ep: correct
 qcom,perst-regs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20221109105555.49557-1-krzysztof.kozlowski@linaro.org>
 <7927fa8f-372d-5c34-2d68-a9533b87c1b0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7927fa8f-372d-5c34-2d68-a9533b87c1b0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/11/2022 12:10, Konrad Dybcio wrote:
> 
> On 09/11/2022 11:55, Krzysztof Kozlowski wrote:
>> qcom,perst-regs is an phandle array of one item with a phandle and its
>> arguments.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> index 977c976ea799..5aa590957ee4 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> @@ -47,8 +47,10 @@ properties:
>>                    enable registers
>>       $ref: "/schemas/types.yaml#/definitions/phandle-array"
>>       items:
>> -      minItems: 3
>> -      maxItems: 3
>> +      - items:
>> +          - description: Syscon to TCSR system registers
>> +          - description: Perst enable offset
>> +          - description: Perst separateion enable offset
> 
> separation?

Indeed, thanks!

Best regards,
Krzysztof

