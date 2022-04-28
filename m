Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54610513647
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348059AbiD1OKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348058AbiD1OJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 10:09:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C51B6442
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 07:06:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g6so9824082ejw.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RACNLxP1zk+ZiIoBvbIbc9v4CwnmE1QoTxxGj65Nrgc=;
        b=F7h3fHbl1MpSZivsk6cgSnUfM0M8xKfxBojZ6edW7TvbJ6nZQ2YwwmqtMFRfqmBv7I
         xe7tJwsv4qhdn6fQYNpkmZJSQgVVzA/4aVvLseUnEkX7tubaN3LbwbolExAWKdeKxvWh
         qDIBVxPXMn1w0rKaCcdyq6NOArm0L7wd9ypXQbDWqm46QwFsPoSSzzBBUiO96TCfdp+z
         QHPNxE386O3W0RQmrPC0iH71YZryMlOvzQgcWBIR5K3oL3tCAVO4QJSGDXmucrLHjdVY
         a3IAU9tU9xKk8noVCd1lZVb9h29n2vuBQ6YI0gUOaUNVlBELYB/xAZhlUCGYRaXcfKyY
         xJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RACNLxP1zk+ZiIoBvbIbc9v4CwnmE1QoTxxGj65Nrgc=;
        b=tfIe6cxf2RxGolD+aUK5E6HGaz2X9fFKjZdrmhZ8MjctzUQlv0ONmla5LO4OJysGCm
         CZlKjzZkYiTu/ouIkG6C/tcSjFH8CKw6inrtimcwX5rPH/cD/6XUmc0e7m8CGzsnMOXp
         rScYxGqkhGXaFh34C1wvjV7eFIp2qdWZsoHCIpTlqE3ogRqzC5fEnnw+FHXqQsvDOo6i
         ipjb3aMX7/M5RnXauWSC3hMJVlflk0dUHJXMsZ0zFs5JeHNaPGW4/fXS1haL2rk8bzrV
         R6D2MXuv75cAEMhYlUEHH783SVJZJlnDUZ0bJj2GGmmJr2ZVrouv/iVKMwVyVc1JLZZs
         TVAg==
X-Gm-Message-State: AOAM532UUWHay2x8XYx4hVZ/AHqiFh7ujqltqo45ourOSLy64oeatAU2
        SWqte7AF3N4L3/reT7Mx3qsU5A==
X-Google-Smtp-Source: ABdhPJzIZUtk89TlINUaiLpOaf0P+wBVCw2kgmo1CT3zj7wcDQqMugdud2v9KhJSUXxcwvExImMQuA==
X-Received: by 2002:a17:907:7246:b0:6ef:828d:4b49 with SMTP id ds6-20020a170907724600b006ef828d4b49mr33200105ejc.172.1651154774037;
        Thu, 28 Apr 2022 07:06:14 -0700 (PDT)
Received: from [192.168.0.163] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709064b0e00b006f3867ebe45sm10611eju.123.2022.04.28.07.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 07:06:13 -0700 (PDT)
Message-ID: <42588c32-5068-5f12-4cf8-f8b9bd074e88@linaro.org>
Date:   Thu, 28 Apr 2022 16:06:11 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpq38EudVcb7quuk1u85Cw+hJADxagkV7rN7fP9A-fz-Wg@mail.gmail.com>
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

On 28/04/2022 15:57, Dmitry Baryshkov wrote:
> On Thu, 28 Apr 2022 at 15:08, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 28/04/2022 13:59, Dmitry Baryshkov wrote:
>>> On Qualcomm platforms each group of 32 MSI vectors is routed to the
>>> separate GIC interrupt. Document mapping of additional interrupts.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 ++++++++++++++++++-
>>>  1 file changed, 50 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> index 0b69b12b849e..a8f99bca389e 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> @@ -43,11 +43,20 @@ properties:
>>>      maxItems: 5
>>>
>>>    interrupts:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 8
>>>
>>>    interrupt-names:
>>> +    minItems: 1
>>>      items:
>>>        - const: msi
>>> +      - const: msi2
>>> +      - const: msi3
>>> +      - const: msi4
>>> +      - const: msi5
>>> +      - const: msi6
>>> +      - const: msi7
>>> +      - const: msi8
>>>
>>>    # Common definitions for clocks, clock-names and reset.
>>>    # Platform constraints are described later.
>>> @@ -623,6 +632,46 @@ allOf:
>>>          - resets
>>>          - reset-names
>>>
>>> +    # On newer chipsets support either 1 or 8 msi interrupts
>>> +    # On older chipsets it's always 1 msi interrupt
>>> +  - if:
>>> +      properties:
>>> +        compatibles:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,pcie-msm8996
>>> +              - qcom,pcie-sc7280
>>> +              - qcom,pcie-sc8180x
>>> +              - qcom,pcie-sdm845
>>> +              - qcom,pcie-sm8150
>>> +              - qcom,pcie-sm8250
>>> +              - qcom,pcie-sm8450-pcie0
>>> +              - qcom,pcie-sm8450-pcie1
>>> +    then:
>>> +      oneOf:
>>> +        - properties:
>>> +            interrupts:
>>> +              minItems: 1
>>
>> minItems should not be needed here and in places below, because it is
>> equal to maxItems.
> 
> Maybe it's a misunderstanding from my side. In the top level we have
> the min = 1, max = 8.
> How does that interfere with these entries? In other words, if we e.g.
> omit minItems here, which setting would preveal: implicit minItems = 8
> (from maxItems = 8) or minItems = 1 in the top level?
> 
>>> +              maxItems: 1

I don't propose to skip it for the case with maxItems:8, but only here.
minItems:1 is set in toplevel. Where is that implicit minItems:8?


Best regards,
Krzysztof
