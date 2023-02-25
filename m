Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8316A28BB
	for <lists+linux-pci@lfdr.de>; Sat, 25 Feb 2023 11:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBYKIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Feb 2023 05:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBYKII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2023 05:08:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAC8C175
        for <linux-pci@vger.kernel.org>; Sat, 25 Feb 2023 02:08:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q16so1609422wrw.2
        for <linux-pci@vger.kernel.org>; Sat, 25 Feb 2023 02:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxbj2MIMz+4fiGqGes7y0064FPaBsDmmrMP3IsQqxSs=;
        b=LvhZaSceahKXLg52CYa4EDK0/dk8k2eAYXSQ6oyqKb/g/tIuX86s3r1Ec0t4zXRLMh
         gQeM1MoN+PIa1YRWvo2+3XGvTunJx9r8zQ8zTJd+knmLp8/jUib1f2fAGiCMSKwsULOu
         1aJKgmHd+ZPcrP36OVhbPPZNlxtpW7akve76tQ7WmEzUq2Uc3YljItrrV5mxq/bvCQvc
         PkYMGe6xgbGE5DK5trknRz14Y8TzqEe1s/wMy3snFbHadCHoRvAC2KLMgOGRGJNZ2sIK
         SoJOD7LbVP3WaZuQ5N1YK3IeYdA3gYGtuiLQBROcyihj21rYLbqGdYzaU4AtoplfrDdp
         h7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxbj2MIMz+4fiGqGes7y0064FPaBsDmmrMP3IsQqxSs=;
        b=okDYY6WkjRUHh/Wv5SRmwOlIxcEB6Dhj55uAxcIiJa5Zda36VzK538e6yS0uSQPxqJ
         JySo0s+nNSuIhOs+BOf2nuDPiz+Zdkn/kADmt8tPsn1M2PK4WascJGhmkFAanbKDe94+
         Ul1/l1mzb+kGJTHU6XxXT919BbFCu9NV8iQefEyuV9L+8JMuMaaigeb+EXOg3TvZv74w
         cj02SejSyKLaguCtiF3/Dtzwen8m4xm/HUl6JyRMKSxgz2j0CEYH6J67I7mBqmtqUrPK
         VW4xl3B4oEuu1x3hkFxGk+MLwJlH4sxQFpeK5l+1tNzWsZkeGfBBKHb9rayg12rhblsf
         65Yg==
X-Gm-Message-State: AO0yUKV9jK5CNCcpYi20Kooc5HfJJYfCgKSmVhrnI+dcnoJq1R+PGdz1
        kH7A4fBaJ3fwn0YjpHRBmNg7Ng==
X-Google-Smtp-Source: AK7set8UA3cUhKwWTYb4UtT8vgIRv9+KBNb7EZHNn5ECYbzxkMy8jErfwAjgtpfsqZs6sjBtl6yIvA==
X-Received: by 2002:a5d:544d:0:b0:2c7:19c1:5557 with SMTP id w13-20020a5d544d000000b002c719c15557mr5129334wrv.64.1677319685025;
        Sat, 25 Feb 2023 02:08:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ja18-20020a05600c557200b003eb0d6f48f3sm5051296wmb.27.2023.02.25.02.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 02:08:04 -0800 (PST)
Message-ID: <80b17309-ec9c-8942-d901-7121bc936471@linaro.org>
Date:   Sat, 25 Feb 2023 11:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: dwc: Add snps,skip-wait-link-up
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sajid Dalvi <sdalvi@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel-team@android.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230224195749.818282-1-sdalvi@google.com>
 <20230224195749.818282-2-sdalvi@google.com>
 <b50ab99f-e307-3a66-9198-85a71b012e5e@linaro.org>
 <CAEbtx1k-7TJPcd3+cueRoKLJcoUQLfF6nfOQFVfzB0YCUrbtqg@mail.gmail.com>
 <2e4964c1-0831-c156-3372-81a56f8d623e@linaro.org>
 <CAEbtx1=EGC+4LfSz+HqGzjJvF2O1vsB7a42ESTqbU8p5N-yUHg@mail.gmail.com>
 <28c72c1a-df7d-db05-f32f-23b170b96db5@linaro.org>
In-Reply-To: <28c72c1a-df7d-db05-f32f-23b170b96db5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/02/2023 11:00, Krzysztof Kozlowski wrote:
> On 24/02/2023 23:09, Sajid Dalvi wrote:
>> On Fri, Feb 24, 2023 at 3:29 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 24/02/2023 22:27, Sajid Dalvi wrote:
>>>> On Fri, Feb 24, 2023 at 2:40 PM Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> On 24/02/2023 20:57, Sajid Dalvi wrote:
>>>>>> When the Root Complex is probed, the default behavior is to spin in a loop
>>>>>> waiting for the link to come up. In some systems the link is not brought up
>>>>>> during probe, but later in the context of an end-point turning on.
>>>>>> This property will allow the loop to be skipped.
>>>>>>
>>>>>> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
>>>>>> ---
>>>>>
>>>>> Thank you for your patch. There is something to discuss/improve.
>>>>>
>>>>>>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 8 ++++++++
>>>>>>  1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>>>>>> index 1a83f0f65f19..0b8950a73b7e 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>>>>>> @@ -197,6 +197,14 @@ properties:
>>>>>>        - contains:
>>>>>>            const: msi
>>>>>>
>>>>>> +  snps,skip-wait-link-up:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>>> +    description:
>>>>>> +      When the Root Complex is probed, the default behavior is to spin in a
>>>>>> +      loop waiting for the link to come up. In some systems the link is not
>>>>>> +      brought up during probe, but later in the context of an end-point turning
>>>>>> +      on. This property will allow the loop to be skipped.
>>>>>
>>>>> I fail to see how probe behavior is related to properties of hardware.
>>>>> You describe OS behavior, not hardware. This does not look like
>>>>> belonging to DT.
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>
>>>> Thanks for your response Krzysztof.
>>>> The hardware configuration of the system determines whether an
>>>> endpoint device is available during host init. If it isn't available
>>>> on a particular and dedicated pcie interface, we should skip waiting
>>>> for the link to be up. For other interfaces, possibly even on the same
>>>> system, where a device is present or maybe present we should wait for
>>>> the link to come up.
>>>
>>> Keep discussions public.
>>>
>>> Your commit and property description mentions probe, which is nothing
>>> related to hardware. Why the device would not be available during host
>>> init (I understand we do not talk about hotplug as it is already
>>> supported by Linux) in a way it is hardware property, not OS?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> + everyone else I mistakenly didn't reply to earlier
>>
>> If I understand you correctly, the usage of probe is misleading
>> because it doesn't have anything to do with the hardware.
>> So your recommendation is to replace probe with device init, in the
>> description of the property and the commit message?
> 
> No, I asked there a question for which we need answer.
> 
> device init is also OS task... You need to explain why this is a
> property of hardware, not OS behavior.

Actually let's be clearer - your cover letter says:
"In some systems the link is not brought up
during probe, but later in the context of an end-point turning on. (...)
to skip this loop."

so this is pure Linux OS stuff. You just want to control driver behavior
from DT. Not at all DT property.

Best regards,
Krzysztof

