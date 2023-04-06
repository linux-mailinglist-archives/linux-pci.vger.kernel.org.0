Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED16B6DA060
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbjDFSzQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbjDFSyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:54:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F056EB8
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 11:54:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l17so3723387ejp.8
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680807291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDe1sENHqqI/d/KCYB866ORqPLaZkKZCUTL+XlVCWbo=;
        b=GrEl3QNbr2/uGDQCngerqAbT5bLfc3Oi/elT80KjhVGsTIWcS68iCzgd6AIdBIRERf
         HYUDsB+topW4/Q+7irLZP6nqRsXRYwNykBW5UCU0cX3MJ9y6K4jlTuo6yK++CkY8EFEi
         r6WEdLlqPwG2BzpizhLACUbmBY+M4CExpBqXKkSEHmRP1ABRTtCUlhZChB19NeUA7rCN
         qJ01j5LiaZHrnep3fdBdi/lPQkold1m+9vq7SU+odeUJ+lA2Otc/UZrSKHWKgqUYDXBW
         FNCjFb2F9euUCFsDc6lXIptHsFLlRxIoNkQ9WaF0ZBwyKe/5lgpSQX3IrNXvkKLnxw+z
         yk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDe1sENHqqI/d/KCYB866ORqPLaZkKZCUTL+XlVCWbo=;
        b=4ZUy3Y+qioTrQdyeayuHxbdlwrLXftcRJYa+to6h/NMAMQh6/GubGLKdq0EdpWc7vY
         ggYm29OMI40rup/c1PtOp38D/9cq/OA8I5v8OrOw62mRtD/bDE+jpPmQwYAtLwy7Yv+/
         avcfuPN8zMmlSR2/NspRys2F3b53IT/MQHpMb5oCLcDMfVHgWkDGR2+9HSZKf2mewrBJ
         M24skeMcQ1JSin/YFgiFHIT7jvT/f5KooUDpjPLLHG2HaffyJnloTcRdh9pQ8sAXkYSy
         h4bbFVAKpbJQ+/2AxmXkU3Hj+t5XKF6P+Xnjr+yQ4zK6AQKalr17gmYT6WcaZEqwIXqO
         1w1Q==
X-Gm-Message-State: AAQBX9dloyuSgPhF/aJ8qa8eFMOmgsHPgzqjT9sbnQJA+tZbQ3QrrtzY
        9ifo9bO1lkxWi1tG9Y0RFXq42w==
X-Google-Smtp-Source: AKy350ajwH+Cn7PtrIjxFg1bz46Gzc/hHXKaVxIUMBaYwk71/qH7AUYBzRT+hwieHQjP5df2rvE1rA==
X-Received: by 2002:a17:906:2e86:b0:931:b4d3:fc7f with SMTP id o6-20020a1709062e8600b00931b4d3fc7fmr7688208eji.30.1680807291091;
        Thu, 06 Apr 2023 11:54:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906838700b009484e17e7f5sm1135463ejx.100.2023.04.06.11.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:54:50 -0700 (PDT)
Message-ID: <b6eb826a-2379-d799-24f4-ea7375e0e636@linaro.org>
Date:   Thu, 6 Apr 2023 20:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230406124625.41325-1-jim2101024@gmail.com>
 <20230406124625.41325-2-jim2101024@gmail.com>
 <ebde318b-53be-6779-4f0c-a614c01a0b0a@linaro.org>
 <9e98496b-73a0-78a5-e890-7d7e4be1f469@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9e98496b-73a0-78a5-e890-7d7e4be1f469@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/04/2023 20:53, Florian Fainelli wrote:
> On 4/6/23 11:34, Krzysztof Kozlowski wrote:
>> On 06/04/2023 14:46, Jim Quinlan wrote:
>>> Regarding "brcm,enable-l1ss":
>>>
>>>    The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- requires
>>>    the driver probe to configure one of three clkreq# modes:
>>>
>>>    (a) clkreq# driven by the RC
>>>    (b) clkreq# driven by the EP for ASPM L0s, L1
>>>    (c) bidirectional clkreq#, as used for L1 Substates (L1SS).
>>>
>>>    The HW can tell the difference between (a) and (b), but does not know
>>>    when to configure (c).  Further, the HW will cause a CPU abort on boot if
>>>    guesses wrong regarding the need for (c).  So we introduce the boolean
>>>    "brcm,enable-l1ss" property to indicate that (c) is desired.  This
>>>    property is already present in the Raspian version of Linux, but the
>>>    driver implementaion that will follow adds more details and discerns
>>>    between (a) and (b).
>>>
>>> Regarding "brcm,completion-timeout-msecs"
>>>
>>>    Our HW will cause a CPU abort if the L1SS exit time is longer than the
>>>    completion abort timeout.  We've been asked to make this configurable, so
>>>    we are introducing "brcm,completion-abort-msecs".
>>>
>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>> ---
>>>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> index 7e15aae7d69e..ef4ccc05b258 100644
>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>> @@ -64,6 +64,18 @@ properties:
>>>   
>>>     aspm-no-l0s: true
>>>   
>>> +  brcm,enable-l1ss:
>>> +    description: Indicates that the downstream device is L1SS
>>> +      capable and L1SS is desired, e.g. by setting
>>> +      CONFIG_PCIEASPM_POWER_SUPERSAVE=y.  Note that CLKREQ#
>>
>> How does CONFIG_PCIEASPM_POWER_SUPERSAVE apply to *BSD?
> 
> In other words, there should be no OS/Linux specific comments in a 
> Device Tree binding, which would be a friendlier and nicer way of 
> providing the same feedback.

I want to give also the answer also why there should be no OS/Linux
specific comments, so the reader can stop a bit and think about it :)

Best regards,
Krzysztof

