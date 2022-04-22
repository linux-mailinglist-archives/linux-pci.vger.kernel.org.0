Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03FF50BC1E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449504AbiDVPy3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448102AbiDVPy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 11:54:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD29140B9
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 08:51:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so17253060ejn.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cz3+sah/zpqCzimPE3ANH7Z5ZXDqOyXDNUXTlP3XsBc=;
        b=dbzEeE8PdyShzDof20Q8pvdW3YV4GPnLux30KOoQziRaealnVmZQbZ2lf5YyKwvFHb
         MpqLJIdfIBlNmhLWAT7sRDvwWXH5nqdX3/RBb2OUuBt/PSkUa4adZ8+rzMaiPgjU5lPy
         nQzsKB077hDpDo7EgfRccgHRCjkysA1VGY74mS6WClttIcvdogz1UWPtY/N6C3ikEYKW
         o/3ReRiIsqqmekl1lT4GFeSZcvIZxZlWz3laVYVhPub5m19g5DyXJ2zhcYaJwsPifasJ
         wRYahkIxH4cClFt39go6AWNYJTus0eg9iJLaly6g1evKlqWK5Wn6Xd18cPNB9Q5JQsOm
         2mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cz3+sah/zpqCzimPE3ANH7Z5ZXDqOyXDNUXTlP3XsBc=;
        b=CznOM5jaSbA1EzQjy743SRjob/Kvm8NdzPqhZd4Dny0ej+F3LPNuriNH6CUhvp3N2d
         2CUvEb4B5xP1NN8jWbZHQi49WEVtTufMD+3/sViYMsLUVk3knYfCsh2MoHR+UYXm2IbC
         ex6LKCLLeOidFF0cndytxpse+Ip0ff1X0TcIOP4lkjeIM1EbbIFlz930uH4GUaS2f+wa
         ff2tNaQY7nv4Rm/EKTnVX/h9pJQ1GPodQwDz1YUwVHu5zpRaugDwCSzMMSuARY5n2MT1
         Si48wM+eTfdoONGenAyd2Z42pRwvrRCOOaPi50crmEVZii83Z35Mp8+NqBV1ufbfBeNZ
         Isrg==
X-Gm-Message-State: AOAM532ABQuNoVeu7oTp/0hVUXVVwXmYAypE083+Mywf2nZqgg/r1viK
        V5AWgYuHccWgQ+j0dvAeATSysg==
X-Google-Smtp-Source: ABdhPJxWmRux1ijuYLwW2X+knXfCBFZooOH5VHQHfdpGiTWmPug4O2Fb3TKtOK1RyI/3QzamwF3qSw==
X-Received: by 2002:a17:906:5d07:b0:6ef:f147:caee with SMTP id g7-20020a1709065d0700b006eff147caeemr4890150ejt.292.1650642693128;
        Fri, 22 Apr 2022 08:51:33 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm1071387edj.0.2022.04.22.08.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:51:32 -0700 (PDT)
Message-ID: <338344c8-1812-de27-80f2-df4c2dc3c17b@linaro.org>
Date:   Fri, 22 Apr 2022 17:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/6] dt-bindings: pci/qcom-pcie: specify reg-names
 explicitly
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpr=XE-8fo+99+KjTEffS1jmBibQnbN1T4ZcgkhWCDucpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 17:47, Dmitry Baryshkov wrote:
> On Fri, 22 Apr 2022 at 15:55, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/04/2022 13:48, Dmitry Baryshkov wrote:
>>> Instead of specifying the enum of possible reg-names, specify them
>>> explicitly. This allows us to specify which chipsets need the "atu"
>>> regions, which do not. Also it clearly describes which platforms
>>> enumerate PCIe cores using the dbi region and which use parf region for
>>> that.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 ++++++++++++++++---
>>>  1 file changed, 81 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> index 7210057d1511..e78e63ea4b25 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> @@ -35,21 +35,6 @@ properties:
>>>            - qcom,pcie-ipq6018
>>>        - const: snps,dw-pcie
>>>
>>> -  reg:
>>> -    minItems: 4
>>> -    maxItems: 5
>>
>> This should stay.
>>
>>> -
>>> -  reg-names:
>>> -    minItems: 4
>>> -    maxItems: 5
>>> -    items:
>>> -      enum:
>>> -        - parf # Qualcomm specific registers
>>> -        - dbi # DesignWare PCIe registers
>>> -        - elbi # External local bus interface registers
>>> -        - config # PCIe configuration space
>>> -        - atu # ATU address space (optional)
>>
>> Move one of your lists for specific compatibles here and name last
>> element optional (minItems: 4).
>>
>> You will need to fix the order of regs in DTS to match the one defined here.
> 
> I see your idea. I wanted to be explicit, which platforms need atu and
> which do not. You'd prefer not to.

Opposite, I wish platforms to be specific, which need atu which not.
However I wish the strictly defined, same order for everyone because it
looks possible.

> Let's probably drop this for now. The bindings proposed in patch 1
> work for now. I will work on updating reg-names later.


Best regards,
Krzysztof
