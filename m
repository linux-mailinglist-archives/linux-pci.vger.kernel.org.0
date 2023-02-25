Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48F66A28AE
	for <lists+linux-pci@lfdr.de>; Sat, 25 Feb 2023 11:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBYKAz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Feb 2023 05:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYKAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2023 05:00:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D531DB98
        for <linux-pci@vger.kernel.org>; Sat, 25 Feb 2023 02:00:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so493533wmq.1
        for <linux-pci@vger.kernel.org>; Sat, 25 Feb 2023 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOT0daIqYTUXHjO378HNb59W9he2Y4mmNd7ANSY/Y+o=;
        b=OKaiNDgjPSyLjeH5ZmcvHRIjucbaPGoZiUn22mN1HvjIEj/ahtqbj6yjWyOVWuhipY
         CKo8XEz/yxYWxB+zuYreM3zVwj43/T9e46w6UFoDp+d7TJzFX5X2J3mFQxOXXa3aL4ie
         WJLgW1mk1UjKEzteJYWaCLJLFSk1PJurAsagnLT0EmVzlznEv5qQiXpMtmizfpi/5G8Y
         bWngyqyMC9QO00LOZwrhrfbFnxKHGqEA0KVdtiZcDfsQtJAeRLDQGcJudj4drwwRNVnU
         bX0DqEHlbv2flhWHBGsO/cSwpuGsHkhP0KRXxKkAuioDV2kdIc0VsOtk2MaWCO7iAWjF
         BlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOT0daIqYTUXHjO378HNb59W9he2Y4mmNd7ANSY/Y+o=;
        b=5Jh7j8Es/644usz/Jt/FMe9nzXaPtEZz9I3QQJ0/xKqKGCnvxoO7+8ONL7/AzzJRFQ
         x5ukmrCSMloaP2cTXcBbgOt5QsEz/+krWBEdV0klgfoc0VWQ8gPYT+SGmn4sNy0vM1pz
         nAoxMk+sUix7gdHfJnIptsL8SDC8WTsqjrrZDY+5Dn1+k9XExeeZ1tUg479OiTrEJfEP
         z08+o4AVtQa5YUnPKClM8OsK0gl8+d/3fup1RygOVoP0sJyZDhz8Uhxtk/KgafYe+6Un
         I2+y+3dXa5Qj6PQhwQ+I040JLTz988l4i3XzISh0YWHAGOOBVhM/hBFAu9CPRr/9CQm9
         UWAw==
X-Gm-Message-State: AO0yUKWR2p0STnlKZw2I8d1gkEvjsXPnsxApywxjsnZRNIrP1f5C8RTY
        WY8pUYKy1t7Lzi36Kqk+AnZpKw==
X-Google-Smtp-Source: AK7set/lZdy5+f/JBn8126aa7oflTbLTWZlZXIwwPxt36QIs5XE+jeRYRpMGz9n3f4Az/NyHRN+jiw==
X-Received: by 2002:a05:600c:ac8:b0:3e2:91c:7cb7 with SMTP id c8-20020a05600c0ac800b003e2091c7cb7mr13427963wmr.39.1677319250774;
        Sat, 25 Feb 2023 02:00:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003d9aa76dc6asm5623414wmc.0.2023.02.25.02.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 02:00:50 -0800 (PST)
Message-ID: <28c72c1a-df7d-db05-f32f-23b170b96db5@linaro.org>
Date:   Sat, 25 Feb 2023 11:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: dwc: Add snps,skip-wait-link-up
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEbtx1=EGC+4LfSz+HqGzjJvF2O1vsB7a42ESTqbU8p5N-yUHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/02/2023 23:09, Sajid Dalvi wrote:
> On Fri, Feb 24, 2023 at 3:29 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/02/2023 22:27, Sajid Dalvi wrote:
>>> On Fri, Feb 24, 2023 at 2:40 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 24/02/2023 20:57, Sajid Dalvi wrote:
>>>>> When the Root Complex is probed, the default behavior is to spin in a loop
>>>>> waiting for the link to come up. In some systems the link is not brought up
>>>>> during probe, but later in the context of an end-point turning on.
>>>>> This property will allow the loop to be skipped.
>>>>>
>>>>> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
>>>>> ---
>>>>
>>>> Thank you for your patch. There is something to discuss/improve.
>>>>
>>>>>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 8 ++++++++
>>>>>  1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>>>>> index 1a83f0f65f19..0b8950a73b7e 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>>>>> @@ -197,6 +197,14 @@ properties:
>>>>>        - contains:
>>>>>            const: msi
>>>>>
>>>>> +  snps,skip-wait-link-up:
>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>> +    description:
>>>>> +      When the Root Complex is probed, the default behavior is to spin in a
>>>>> +      loop waiting for the link to come up. In some systems the link is not
>>>>> +      brought up during probe, but later in the context of an end-point turning
>>>>> +      on. This property will allow the loop to be skipped.
>>>>
>>>> I fail to see how probe behavior is related to properties of hardware.
>>>> You describe OS behavior, not hardware. This does not look like
>>>> belonging to DT.
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Thanks for your response Krzysztof.
>>> The hardware configuration of the system determines whether an
>>> endpoint device is available during host init. If it isn't available
>>> on a particular and dedicated pcie interface, we should skip waiting
>>> for the link to be up. For other interfaces, possibly even on the same
>>> system, where a device is present or maybe present we should wait for
>>> the link to come up.
>>
>> Keep discussions public.
>>
>> Your commit and property description mentions probe, which is nothing
>> related to hardware. Why the device would not be available during host
>> init (I understand we do not talk about hotplug as it is already
>> supported by Linux) in a way it is hardware property, not OS?
>>
>> Best regards,
>> Krzysztof
>>
> 
> + everyone else I mistakenly didn't reply to earlier
> 
> If I understand you correctly, the usage of probe is misleading
> because it doesn't have anything to do with the hardware.
> So your recommendation is to replace probe with device init, in the
> description of the property and the commit message?

No, I asked there a question for which we need answer.

device init is also OS task... You need to explain why this is a
property of hardware, not OS behavior.

Best regards,
Krzysztof

