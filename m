Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E951373B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348562AbiD1OtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348552AbiD1OtD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 10:49:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45AC31DEB
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 07:45:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j4so9043028lfh.8
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RVE7bzP/xG8OR9YebvG0SaqOsmIhaNnTjipQbYslYP4=;
        b=rdJrZazOpI13ax3blUu0TE6AS3OMwYw0Grgrz/e6n0eMsnIa95aDF5uTlwbeXcwyaC
         +EDlJddwCcJVnjKcqBn4VUcGUzy34peWzbYvfWM/cNSBUmaw2dfYNU4kIZMZWnydI9tD
         lRXpMSU+kckpVxpgo3khR0c2eidjr/9lulRVIDv5OETIKEEJE36hPE1gwl+vTz6FDs7Z
         WyQqaRvqTr623a5mUOj3zCI9scOn+kJDoDxX6oS1XdrNVeHUPaliQP4n4hVLbzYlpBox
         7YnctWgBpkhdsp+Mhz6l5MwMOpIpiiMvHnctC9Cw3+pUY0r8I1x+4Xi7NeC5QgOK743m
         B/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RVE7bzP/xG8OR9YebvG0SaqOsmIhaNnTjipQbYslYP4=;
        b=cnpsBq3kZa4hkUE0cQYeggwAr1r+ppiFx6ZcaNm1rI+3nhtcvZbYo9plISYGDHjKlI
         72zcBz9mJJCyw4jo0VnmD1ddvN/s5VwLEXEMw7nQR4RjzU8ZgAzPo2Mc/gAkGSiF+Kzr
         eYNpNAtl07hgeZv6mPRoo+D3JvcMaZgD50oHwQu6oXsUn29mTpUEze7VDDNQ+JY9ffGx
         xZPUKdkJaIu3qeTVJWTy97AhfAG3hxUTM1/UW1uVhIVPeadQNWpUppTkKVd4znPrziW3
         zOS48bZUDrFNecxpktmXG5f8H2HX6y650VqO+CTZry46IPmnVC5GmB/MsjyRIdEzmSG8
         ESAQ==
X-Gm-Message-State: AOAM532/YuL2CWCuWeiIOEIkFwgVA1PLglmYhHYtn0ROborMAQkvjfWm
        y/PTfo6i1rPcsiXGSHIOHCkGwA==
X-Google-Smtp-Source: ABdhPJwmsNhConIOCc5mietOAg9DDuZNeiuCIoVtunmtUPJsTcYL5QTkNcmjAp4JHHlnovDvnsiPhg==
X-Received: by 2002:a05:6512:3207:b0:472:24d5:fbb0 with SMTP id d7-20020a056512320700b0047224d5fbb0mr7973276lfe.615.1651157143928;
        Thu, 28 Apr 2022 07:45:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u12-20020a056512128c00b00446499f855dsm20507lfs.78.2022.04.28.07.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 07:45:43 -0700 (PDT)
Message-ID: <db2f32e1-beeb-b421-efaa-b68900d99559@linaro.org>
Date:   Thu, 28 Apr 2022 17:45:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 6/7] dt-bindings: pci/qcom,pcie: support additional MSI
 interrupts
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <42588c32-5068-5f12-4cf8-f8b9bd074e88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 28/04/2022 17:06, Krzysztof Kozlowski wrote:
> On 28/04/2022 15:57, Dmitry Baryshkov wrote:
>> On Thu, 28 Apr 2022 at 15:08, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 28/04/2022 13:59, Dmitry Baryshkov wrote:
>>>> On Qualcomm platforms each group of 32 MSI vectors is routed to the
>>>> separate GIC interrupt. Document mapping of additional interrupts.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 ++++++++++++++++++-
>>>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> index 0b69b12b849e..a8f99bca389e 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> @@ -43,11 +43,20 @@ properties:
>>>>       maxItems: 5
>>>>
>>>>     interrupts:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>>
>>>>     interrupt-names:
>>>> +    minItems: 1
>>>>       items:
>>>>         - const: msi
>>>> +      - const: msi2
>>>> +      - const: msi3
>>>> +      - const: msi4
>>>> +      - const: msi5
>>>> +      - const: msi6
>>>> +      - const: msi7
>>>> +      - const: msi8
>>>>
>>>>     # Common definitions for clocks, clock-names and reset.
>>>>     # Platform constraints are described later.
>>>> @@ -623,6 +632,46 @@ allOf:
>>>>           - resets
>>>>           - reset-names
>>>>
>>>> +    # On newer chipsets support either 1 or 8 msi interrupts
>>>> +    # On older chipsets it's always 1 msi interrupt
>>>> +  - if:
>>>> +      properties:
>>>> +        compatibles:
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,pcie-msm8996
>>>> +              - qcom,pcie-sc7280
>>>> +              - qcom,pcie-sc8180x
>>>> +              - qcom,pcie-sdm845
>>>> +              - qcom,pcie-sm8150
>>>> +              - qcom,pcie-sm8250
>>>> +              - qcom,pcie-sm8450-pcie0
>>>> +              - qcom,pcie-sm8450-pcie1
>>>> +    then:
>>>> +      oneOf:
>>>> +        - properties:
>>>> +            interrupts:
>>>> +              minItems: 1
>>>
>>> minItems should not be needed here and in places below, because it is
>>> equal to maxItems.
>>
>> Maybe it's a misunderstanding from my side. In the top level we have
>> the min = 1, max = 8.
>> How does that interfere with these entries? In other words, if we e.g.
>> omit minItems here, which setting would preveal: implicit minItems = 8
>> (from maxItems = 8) or minItems = 1 in the top level?
>>
>>>> +              maxItems: 1
> 
> I don't propose to skip it for the case with maxItems:8, but only here.
> minItems:1 is set in toplevel. Where is that implicit minItems:8?

maxItems:8? Maybe I just misunderstand this part of yaml/jsonschema.

-- 
With best wishes
Dmitry
