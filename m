Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E09515516
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 22:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380489AbiD2UGT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351229AbiD2UGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 16:06:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8030B32996
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 13:02:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p10so15847515lfa.12
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KQmxhazXdwnOp329/F1Ja7jyqqhUxCgPrYWsGjeTXIc=;
        b=iXmqBaaXqlKaQSe9e+eDS2qIkibjeUzGFeUyCfxVi9CLrBblDdj08s6+qhf8y/kvrK
         28+qhq1ZnMJlMjY0o9tkaSl6NwwE649lA/mMOQfTzF3LOy1sxE+CWrvgdbDY0n53WMbF
         s2EahFFoFkBXooc1kbqtJdr96HYtUdn0lhn6k9veI0zoavK61y0lrP4oZsNKiRVVjZLR
         o+SzC4RIqNPy8GNEGZ5rBzN5kSNhaxtym2oZ6uB1AybXbUfUn0/IPdf9c4zldmPckDNf
         RmhZnJOtjTRc5ZYYH+kg2dFMf4j41EnGdrXPUmlpZnNTP9PW369qqsfvGCsod5QZmvZb
         KgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KQmxhazXdwnOp329/F1Ja7jyqqhUxCgPrYWsGjeTXIc=;
        b=A/MlrGXSpcEFQP0RxoVri4pYbIp+h1lBBq2w398wpE1xiZ1/jtiwWZqKCXSfuV/xeM
         QBEqf713wQT4NEnywX5Bks/kdrEp9ZxA+Ofjf5alDGJF2TYH5C24aU/TXvN+8PdKPACj
         sFmYkMqNfkPTu1LvZcGOANVySPFVOS2zDE8Vcko9vtb/Q07PDtZEriZt1tujfMZmPIDL
         qHaiQHyK5MMPpBGBWaGtWFK8PRgLcWF9zVyVc+KSRWv+U50jE6Oagd8/uCznDcNuuKIl
         XFfIHugzwxL2QgkjsOSyciGuT4axbwtXorMFHS7hsM1ziTNtOrv9G0oQ6G+bUW50V7WW
         +MyQ==
X-Gm-Message-State: AOAM530LoK4L1AFqWHlXz+YcEQ0T1yne5wT/pWPWz4u4meJNvukQXJNd
        5On0pX9ZfKPaXoNmF/4EQNpUAOgqt2f81w==
X-Google-Smtp-Source: ABdhPJzTflMpQAiH/7EilkMJgrNGIiLGV1NMfKNCAQP/p7Nw14KfwZcLtAZpNzfHS0uD61orjYUdDw==
X-Received: by 2002:a19:5f05:0:b0:46b:a5f2:5fab with SMTP id t5-20020a195f05000000b0046ba5f25fabmr647096lfb.8.1651262576888;
        Fri, 29 Apr 2022 13:02:56 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25590000000b0047255d211d4sm11889lfg.259.2022.04.29.13.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:02:56 -0700 (PDT)
Message-ID: <522388b9-310d-25dd-1688-4bb715b594c0@linaro.org>
Date:   Fri, 29 Apr 2022 23:02:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/8] dt-bindings: pci/qcom,pcie: resets are not defined
 for msm8996
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220428143508.GA12269@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220428143508.GA12269@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/04/2022 17:35, Bjorn Helgaas wrote:
> Unlike the other patches in this series, this subject line mentions a
> problem (actually, I don't even know whether it's a *problem* or just
> a statement of fact), but doesn't say what this patch does.
> 
> Based on the patch, I guess this does something like:
> 
>    Require resets except for MSM8996/APQ8096

Ack

> 
> I don't know whether you're changing the prefix convention for this
> file, or just didn't look to see how it was done in the past, but it's
> nice to have some consistency:


Ack

> 
>    $ git log --oneline Documentation/devicetree/bindings/pci/qcom,pcie.txt
>    f52d2a0f0d32 dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
>    dddb4efa5192 dt-bindings: pci: qcom: Document PCIe bindings for SM8450
>    45a3ec891370 PCI: qcom: Add sc8180x compatible
>    320e10986ef7 dt-bindings: PCI: update references to Designware schema
>    9f7368ff1210 dt-bindings: pci: qcom: Document PCIe bindings for IPQ6018 SoC
>    c9f04600026f dt-bindings: PCI: qcom: Document ddrss_sf_tbu clock for sm8250
>    458168247ccc dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
>    d511580ea9c2 dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
>    b11b8cc161de dt-bindings: PCI: qcom: Add ext reset
>    736ae5c91712 dt-bindings: PCI: qcom: Add missing clks
>    5d28bee7c91e dt-bindings: PCI: qcom: Add support for SDM845 PCIe
>    29a50257a9d6 dt-bindings: PCI: qcom: Add QCS404 to the binding
>    f625b1ade245 PCI: qcom: Add missing supplies required for msm8996
>    8baf0151cd4b dt-bindings: PCI: qcom: Add support for IPQ8074
>    90d52d57ccac PCI: qcom: Add support for IPQ4019 PCIe controller
>    d0491fc39bdd PCI: qcom: Add support for MSM8996 PCIe controller
>    845d5ca26647 PCI: qcom: Document PCIe devicetree bindings
> 
> Including both "pci" and "pcie" in the prefix seems like overkill.
> 
> On Thu, Apr 28, 2022 at 02:41:07PM +0300, Dmitry Baryshkov wrote:
>> On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
>> resets. So move the requirement stance under the corresponding if
>> condition.
> 
> s/stance/stanza/
> 
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 16f765e96128..ce4f53cdaba0 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -114,8 +114,6 @@ required:
>>     - interrupt-map
>>     - clocks
>>     - clock-names
>> -  - resets
>> -  - reset-names
>>   
>>   allOf:
>>     - $ref: /schemas/pci/pci-bus.yaml#
>> @@ -504,6 +502,18 @@ allOf:
>>         required:
>>           - power-domains
>>   
>> +  - if:
>> +      not:
>> +        properties:
>> +          compatibles:
>> +            contains:
>> +              enum:
>> +                - qcom,pcie-msm8996
>> +    then:
>> +      required:
>> +        - resets
>> +        - reset-names
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>> -- 
>> 2.35.1
>>


-- 
With best wishes
Dmitry
