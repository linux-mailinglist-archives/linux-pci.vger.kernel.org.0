Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4F50C073
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiDVTcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDVTcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 15:32:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3EE1A4326
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 12:10:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu29so15962490lfb.0
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YQMZQSjIRuMSjHIc47XNM/07efC1fXHqPz8fJtRCS8k=;
        b=pbP0vqcqSJiqmC4EYHX7dALEr5BtFi716773PS0DgBtSAuqEuztcUXbhQuQUrGRW4q
         k1JYxfVNuOnwPKgTh2Nc33FVB5uI8DszrysHizrS9MYjPyEEVRI9FYwQOZ2fmC878Snl
         eqdq9nX/Lmw9cMk8u3dE7irQIPpQGFu6FQPmFEmbsUAvr6qMetZ5JlHf8jsMAQEWrfDE
         Yrh8XZUEJzD3fNWMXHFD97J62U9PtbVNx/YT/BChrzlWf9LcgHAP/eLVBcyp0q2kdcSI
         70Wq1YoXzZI7G5I1ya+pXND99kLNM5kNGdzhl7kIatcY8QQgmzD6hjpU5zjuCLE3nIWe
         Azkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YQMZQSjIRuMSjHIc47XNM/07efC1fXHqPz8fJtRCS8k=;
        b=Sgysm6roEg3DeUQ4oj/XDEf0fUtJgf+Ys2l7Wsag3tKG+gy8mmpNZMM/Seqst6T1pr
         jnoZr0iE8OjZATCSMht2XRJNdZsmCre0SiRAg7pwXiSX2MYvOiHQGKy8IQs3KUnjUZhy
         EwxlLCZpbaY6W95XwxMdC/RV5YughRWAd8diDVesR/7S774Ja8ZNdIJl6xniDnd7NBrD
         uujbLB7XNIwIr9D2U0SLPeCIf0xm9+yhP08BnbAVTcpxVmkn0BqGvoXri2TSWfwlmLCs
         9UXzjnFLXWk+w2/7spxNmXioi0AXvfbSxU11xI9GADGT/T0sZ54scgDx9p6x81ENLP9b
         hNYQ==
X-Gm-Message-State: AOAM533a02hL2X86sX6hNs43lVRRlihnmDOb40v1XabM/hiREAqtdoXT
        VvvVxyaPFhhvsy10HkVYpoPFQw==
X-Google-Smtp-Source: ABdhPJwFcetF4SV9iA/ayn0H1FWGhLflhOmEFb0amIvByiecthv5UJbDfEhiTZ1cBU0B7Yy5uizseQ==
X-Received: by 2002:a05:6512:3b9b:b0:471:8e54:2ecf with SMTP id g27-20020a0565123b9b00b004718e542ecfmr4071398lfv.286.1650654573572;
        Fri, 22 Apr 2022 12:09:33 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r4-20020a2e5744000000b0024d9e106768sm305118ljd.89.2022.04.22.12.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 12:09:32 -0700 (PDT)
Message-ID: <5149ef96-0cdd-64cc-091f-bc97c04e7835@linaro.org>
Date:   Fri, 22 Apr 2022 22:09:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/6] dt-bindings: pci/qcom-pcie: specify reg-names
 explicitly
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
 <20220422114841.1854138-4-dmitry.baryshkov@linaro.org>
 <fe9c5691-caa1-79b4-666b-daac8913b546@linaro.org>
 <CAA8EJpr=XE-8fo+99+KjTEffS1jmBibQnbN1T4ZcgkhWCDucpg@mail.gmail.com>
 <338344c8-1812-de27-80f2-df4c2dc3c17b@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <338344c8-1812-de27-80f2-df4c2dc3c17b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 18:51, Krzysztof Kozlowski wrote:
> On 22/04/2022 17:47, Dmitry Baryshkov wrote:
>> On Fri, 22 Apr 2022 at 15:55, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 22/04/2022 13:48, Dmitry Baryshkov wrote:
>>>> Instead of specifying the enum of possible reg-names, specify them
>>>> explicitly. This allows us to specify which chipsets need the "atu"
>>>> regions, which do not. Also it clearly describes which platforms
>>>> enumerate PCIe cores using the dbi region and which use parf region for
>>>> that.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 ++++++++++++++++---
>>>>   1 file changed, 81 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> index 7210057d1511..e78e63ea4b25 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> @@ -35,21 +35,6 @@ properties:
>>>>             - qcom,pcie-ipq6018
>>>>         - const: snps,dw-pcie
>>>>
>>>> -  reg:
>>>> -    minItems: 4
>>>> -    maxItems: 5
>>>
>>> This should stay.
>>>
>>>> -
>>>> -  reg-names:
>>>> -    minItems: 4
>>>> -    maxItems: 5
>>>> -    items:
>>>> -      enum:
>>>> -        - parf # Qualcomm specific registers
>>>> -        - dbi # DesignWare PCIe registers
>>>> -        - elbi # External local bus interface registers
>>>> -        - config # PCIe configuration space
>>>> -        - atu # ATU address space (optional)
>>>
>>> Move one of your lists for specific compatibles here and name last
>>> element optional (minItems: 4).
>>>
>>> You will need to fix the order of regs in DTS to match the one defined here.
>>
>> I see your idea. I wanted to be explicit, which platforms need atu and
>> which do not. You'd prefer not to.
> 
> Opposite, I wish platforms to be specific, which need atu which not.
> However I wish the strictly defined, same order for everyone because it
> looks possible.

Well, the same order is not possible, since for some devices the first, 
address-defining reg is "parf", for others it is "dbi". So, there will 
be two "families" of the devices. Unless we want to change the DT 
address of the unit.

>> Let's probably drop this for now. The bindings proposed in patch 1
>> work for now. I will work on updating reg-names later.
> 
> 
> Best regards,
> Krzysztof


-- 
With best wishes
Dmitry
