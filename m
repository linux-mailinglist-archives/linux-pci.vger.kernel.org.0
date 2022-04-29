Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0740E5142A1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354777AbiD2Gwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354741AbiD2Gwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 02:52:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29097BCB57
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 23:49:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k23so13644168ejd.3
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ojBbvtb1o01zsnYB75OteAg/TGpNEdw9pesZ19hw8Vk=;
        b=XAh1xUf3hrxIejOXIORrozIl5IMMRTLzxUJgWIEB4uIkZjQ17TYHJ+oTQ2RH40nENk
         cs9hSSbpwsK3GhdSLC+vcYZmvOdsxBCvkmCOJu8LV1VVZokHPIqWhrCtR9dF4mqBqERo
         dF+Eo/oLlfjRMpOn3YIHmZdR1za7luj5DmoVGP8++N5Xm9bq9iDoSCahZcv3eg1YbnR5
         EnBESMaBeHrmXellDZAgKH7qy2VR+67e2yV+ffFYl6iylkY5PqRYc45R+g5/8NKSz3QC
         uJyaddT+LGTNj5efcfxY6E2IpPjRlFUr7C3cIWcc3fx9VWINTNzFoFnpLLsnFkA52CMA
         GFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ojBbvtb1o01zsnYB75OteAg/TGpNEdw9pesZ19hw8Vk=;
        b=uZDKORLQHmizNj/cRtn1rMojLEwYT+jKg9KwkZ4Kh0+GrZcU+9Icfm/RN7JlRGcN32
         JP8NVi4XqXqbqrLzPsfuXbK6oF1wQK9slMUqB0sofBk50A8mjzjUrf1CR0PV2e/shmvf
         4u1crnuVS3kQEux5NeWHIBxxnqOW4jA9iYfeBFfSFmQq4t8hNH02epO9df+55HaHqXki
         AfCHXmHuVncg50YIWRQlsSxCsWGi3qi5eA5Vvip/huKpId059YoZdEQZbdKHCEYa/W59
         u79P5LgaObotnZjv4IQGOyVJgH0PEG7nkuV56HHnbK2xNP85TtiX37vjjUGUf/yA2PHL
         ijog==
X-Gm-Message-State: AOAM530ychRqq4rcpYHwbQbouNLZ30F7mXXxJGLHQuJLg4MKJsdRUKK8
        LShefjWw6WYgFNmM6TlszXmKTA==
X-Google-Smtp-Source: ABdhPJxBiIlo6xZcqio/Vpvr1Nuc0WuzvHNnNXZAE0k+/chdCWeqOZAxBw2MhEeiLlSHJvfCQiL6lw==
X-Received: by 2002:a17:906:2991:b0:6cd:ac19:ce34 with SMTP id x17-20020a170906299100b006cdac19ce34mr35412237eje.746.1651214957738;
        Thu, 28 Apr 2022 23:49:17 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v3-20020aa7d9c3000000b0042617ba63cesm2592560eds.88.2022.04.28.23.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 23:49:17 -0700 (PDT)
Message-ID: <fcc92b14-83fc-c945-a7eb-8907e5ba7922@linaro.org>
Date:   Fri, 29 Apr 2022 08:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 6/7] dt-bindings: pci/qcom,pcie: support additional MSI
 interrupts
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
 <20220428115934.3414641-7-dmitry.baryshkov@linaro.org>
 <6bd8eb4e-81eb-7e87-155b-f48b487e16ae@linaro.org>
 <CAA8EJpq38EudVcb7quuk1u85Cw+hJADxagkV7rN7fP9A-fz-Wg@mail.gmail.com>
 <42588c32-5068-5f12-4cf8-f8b9bd074e88@linaro.org>
 <db2f32e1-beeb-b421-efaa-b68900d99559@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <db2f32e1-beeb-b421-efaa-b68900d99559@linaro.org>
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

On 28/04/2022 16:45, Dmitry Baryshkov wrote:
> On 28/04/2022 17:06, Krzysztof Kozlowski wrote:
>> On 28/04/2022 15:57, Dmitry Baryshkov wrote:
>>> On Thu, 28 Apr 2022 at 15:08, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 28/04/2022 13:59, Dmitry Baryshkov wrote:
>>>>> On Qualcomm platforms each group of 32 MSI vectors is routed to the
>>>>> separate GIC interrupt. Document mapping of additional interrupts.
>>>>>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 ++++++++++++++++++-
>>>>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> index 0b69b12b849e..a8f99bca389e 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> @@ -43,11 +43,20 @@ properties:
>>>>>       maxItems: 5
>>>>>
>>>>>     interrupts:
>>>>> -    maxItems: 1
>>>>> +    minItems: 1
>>>>> +    maxItems: 8
>>>>>
>>>>>     interrupt-names:
>>>>> +    minItems: 1
>>>>>       items:
>>>>>         - const: msi
>>>>> +      - const: msi2
>>>>> +      - const: msi3
>>>>> +      - const: msi4
>>>>> +      - const: msi5
>>>>> +      - const: msi6
>>>>> +      - const: msi7
>>>>> +      - const: msi8
>>>>>
>>>>>     # Common definitions for clocks, clock-names and reset.
>>>>>     # Platform constraints are described later.
>>>>> @@ -623,6 +632,46 @@ allOf:
>>>>>           - resets
>>>>>           - reset-names
>>>>>
>>>>> +    # On newer chipsets support either 1 or 8 msi interrupts
>>>>> +    # On older chipsets it's always 1 msi interrupt
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatibles:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - qcom,pcie-msm8996
>>>>> +              - qcom,pcie-sc7280
>>>>> +              - qcom,pcie-sc8180x
>>>>> +              - qcom,pcie-sdm845
>>>>> +              - qcom,pcie-sm8150
>>>>> +              - qcom,pcie-sm8250
>>>>> +              - qcom,pcie-sm8450-pcie0
>>>>> +              - qcom,pcie-sm8450-pcie1
>>>>> +    then:
>>>>> +      oneOf:
>>>>> +        - properties:
>>>>> +            interrupts:
>>>>> +              minItems: 1
>>>>
>>>> minItems should not be needed here and in places below, because it is
>>>> equal to maxItems.
>>>
>>> Maybe it's a misunderstanding from my side. In the top level we have
>>> the min = 1, max = 8.
>>> How does that interfere with these entries? In other words, if we e.g.
>>> omit minItems here, which setting would preveal: implicit minItems = 8
>>> (from maxItems = 8) or minItems = 1 in the top level?
>>>
>>>>> +              maxItems: 1
>>
>> I don't propose to skip it for the case with maxItems:8, but only here.
>> minItems:1 is set in toplevel. Where is that implicit minItems:8?
> 
> maxItems:8? Maybe I just misunderstand this part of yaml/jsonschema.

The top level defines minItems=1, maxItems=8, so it cannot mean
implicitly "minItems=1, maxItems=8, minItems=maxItems".

There is no other place in the bindings which would implicitly set here
minItems=maxItems.


Best regards,
Krzysztof
