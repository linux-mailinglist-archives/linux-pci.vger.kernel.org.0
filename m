Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B760602D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJTM3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJTM3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 08:29:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1631D3C4F
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 05:29:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g16so8717298qtu.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIpMO9a3TMJ3e31kasrT8my9ncSnz9zJEo18eTxZYyk=;
        b=ukSxzKBcV+DFRtLpuVpDfi/17STUzj4EVb1xaaIsvxFtW70JA63QhdGU8cVdXKYXbW
         4uSeM66NIMpIFMlLyn/4QSZMfEqHC7MtkhjpMm+zlmJhmlrxm5x+iPESwQTo83yM0EWh
         3mgtr5CY+DaXe1w+nXPBufcaXeV7tTuFNZmCJ7X7TlakvYXTGuODiZyAMof8SW6FvBKX
         b5ffLVLe1Xq+oG+Rv5ohaCPkkC6gWsjtC3M1lyjHXc1ZrB85DlFS9C/9RAHlge9htAty
         SvTf+7NuYi72OGXw8spYtGWlBuWJ9ZsnQQwAAaGsBHWExVDp9+K46unrAqYmjrcpxVdj
         x2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIpMO9a3TMJ3e31kasrT8my9ncSnz9zJEo18eTxZYyk=;
        b=RcHQMEX3FckxtGRkDzxpW6H2bvpSGMamqpmWxS0HyV2ViQY2x53TQqrDIeAylNEmfZ
         nuEQpt0zUjJxaBnqvIqbJjgrMswlPZtaTLrTbhwvin0OBLohSvWawHX6CZTe6p5VWUk5
         S2AAAnkCMhyoVh9XrgKs7vlBJYaIMAgoj/x/2vcMJHvz0gLrHrqYvDNooCNha3CXt7XA
         +jZJZAmICh2ErJa9Eo+BenyJke58TvQYnhZ97gvSyx5pVsRQEAgb5+IsqBSVDvAvwtAQ
         w5e5e7o04I6PBAlvKVcAhnjd4g6K1iLPP3NntKZ/bsEVK3063o9Oeay0h2nTlUC12U8U
         FLLw==
X-Gm-Message-State: ACrzQf10HNEvLPKXiJZ0tt2bbogKU+IZOgaiIN8KOcrdqgoPDXmBSnmw
        W//qTgMr9P40P8d9rm6CT6UpEg==
X-Google-Smtp-Source: AMsMyM6iTZOiG6wgWBnMxFnwJfs0K9Tg8YX2G44KHiB6c0TvGF3AHGkYhfW5BZM2LlbYcCAlE2QePQ==
X-Received: by 2002:a05:622a:312:b0:39c:dc09:49e3 with SMTP id q18-20020a05622a031200b0039cdc0949e3mr10568430qtw.4.1666268944557;
        Thu, 20 Oct 2022 05:29:04 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b640efe6dasm7179583qkp.132.2022.10.20.05.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:29:03 -0700 (PDT)
Message-ID: <972db8bd-e45a-47b1-c2c4-008c279c6b59@linaro.org>
Date:   Thu, 20 Oct 2022 08:29:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P
 interconnects
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221017112449.2146-1-johan+linaro@kernel.org>
 <20221017112449.2146-2-johan+linaro@kernel.org>
 <010b6de2-5df6-77c9-2f04-43f2edc89ff2@linaro.org>
 <Y1D/Vaa/3zKP4Cxj@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1D/Vaa/3zKP4Cxj@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10/2022 03:57, Johan Hovold wrote:
> On Wed, Oct 19, 2022 at 10:37:31AM -0400, Krzysztof Kozlowski wrote:
>> On 17/10/2022 07:24, Johan Hovold wrote:
>>> Add the missing SC8280XP/SA8540P "pcie-mem" and "cpu-pcie" interconnect
>>> paths to the bindings.
>>>
>>> Fixes: 76d777ae045e ("dt-bindings: PCI: qcom: Add SC8280XP to binding")
>>> Fixes: 76c4207f4085 ("dt-bindings: PCI: qcom: Add SA8540P to binding")
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 25 +++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> index 22a2aac4c23f..a55434f95edd 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> @@ -62,6 +62,12 @@ properties:
>>>      minItems: 3
>>>      maxItems: 12
>>>  
>>> +  interconnects:
>>> +    maxItems: 2
>>> +
>>> +  interconnect-names:
>>> +    maxItems: 2
>>> +
>>>    resets:
>>>      minItems: 1
>>>      maxItems: 12
>>> @@ -629,6 +635,25 @@ allOf:
>>>            items:
>>>              - const: pci # PCIe core reset
>>>  
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,pcie-sa8540p
>>> +              - qcom,pcie-sc8280xp
>>> +    then:
>>> +      properties:
>>> +        interconnects:
>>> +          maxItems: 2
>>
>> No need for this.
>>
>>> +        interconnect-names:
>>> +          items:
>>> +            - const: pcie-mem
>>> +            - const: cpu-pcie
>>> +      required:
>>> +        - interconnects
>>> +        - interconnect-names
>>
>> else:
>>   ??
>>
>> Otherwise, you allow any names for other variants.
> 
> Are you suggesting something like moving the names to the common
> constraints for now:
> 
>   interconnects:
>     maxItems: 2
> 
>   interconnect-names:
>     items:
>       - const: pcie-mem
>       - const: cpu-pcie
> 
> and then in the allOf:
> 
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - qcom,pcie-sa8540p
>               - qcom,pcie-sc8280xp
>     then:
>       required:
>         - interconnects
>         - interconnect-names
>     else:
>       properties:
>         interconnects: false
>         interconnect-names: false
> 
> This way we'd catch anyone adding interconnects to a DTS without first
> updating the bindings, but it also seems to go against the idea of
> bindings fully describing the hardware by saying that no other platforms
> have interconnects (when they actually do even if we don't describe it
> just yet).

You can add a comment to the else like "TODO: Not described yet". I
would prefer to have specific but incomplete bindings, instead of loose
one which later might cause people adding whatever names they like.

> Or should we do the above but without the else clause to have some
> constraints in place on the names at least?

This would work as well if you think the names are applicable for other
devices.

Best regards,
Krzysztof

