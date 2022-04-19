Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3986C507A6E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 21:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355120AbiDSTqE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 15:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiDSTqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 15:46:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D4D4132A
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 12:43:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g13so7302536ejb.4
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=go6T1fc0TY6wvIhs3nqLqYh80BHNHvnkKYmeIA/Ug5g=;
        b=FnR/UqpbQcZweANaWULrc5vOPvEyZDiktgqeeWVBZHnhccMdR712M18FDpAcMnkzc9
         jlIzR3B1e/LNOoK5HMJlQlmrOl3Z/jkhxV/vDRG77/gB3QgeFkd64O2w8FuOg6c11TNG
         pW2tLHdyOLcF6AJxmmnySnf0KTu8HES9wkSp1p6MFrgy4ap4GlnqcvMDc9ejHtObHWQG
         NH3Uut2wV5oTdC3mkmcQUxSW/XATXf1hONToXNyoaZQeLbX7b6UTQZqbUttPvFrD2+bC
         6smkt4/zN1pAbos6YHgDf2ICLsvX2KEwNSZFcaodRGabXBG7f889U53Xu3G6OcHux3I+
         cVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=go6T1fc0TY6wvIhs3nqLqYh80BHNHvnkKYmeIA/Ug5g=;
        b=0uMrKnjMUKrb/ANy4SkOK5NmPWgxUNyAt+56xjTMkjfN60MGR1EaNvK1npFcXrIjN3
         9khPyPnfFc3dkHR5dASC4sAvzcb5Wkw6pzN+7hW9rt5Ov6CfS3Ou/qAoUhoR0qH5a4HD
         ixeBdbJMVF5NK7sNEXeDGHdtUgaXTKFyt2Fms7g01ZxX0ropW5BIC6i4gEj2SpiY0Efw
         Udlrf8Cq/gWqxmAOL5pfrnJ5KkOROoiBiX0CkcmvQZl1dGnc72IfdejiHlA9AN67RVCV
         Wp///FggiIxMntCAHhbvIw0CyXKd+j0X9u0TvMqhagvbk41XMWiNRP0pCfHEPjBof5QW
         T03Q==
X-Gm-Message-State: AOAM533Gplo9WLwuPrGh6Fg4BUyIOAHR003QGghArhMgTiUPr7wuqALi
        ugvgmfa7Ao3H92EDGPHfNiOVag==
X-Google-Smtp-Source: ABdhPJxN+zqmAT7T1BJC0xIRHgTKTkUJwlFx08wQXWb7+EHLMa/kEqxDmWxHQi8JY5CwtSTfjM3hCg==
X-Received: by 2002:a17:906:fa8f:b0:6e4:de0d:45f with SMTP id lt15-20020a170906fa8f00b006e4de0d045fmr14839252ejb.235.1650397395281;
        Tue, 19 Apr 2022 12:43:15 -0700 (PDT)
Received: from [192.168.0.221] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709067f8500b006da68bfdfc7sm5999584ejr.12.2022.04.19.12.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:43:14 -0700 (PDT)
Message-ID: <fce0337a-0c71-a040-0a01-f20b55eb568b@linaro.org>
Date:   Tue, 19 Apr 2022 21:43:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Aw: Re: [RFC/RFT 1/6] dt-bindings: phy: rockchip: add pcie3 phy
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-2-linux@fw-web.de>
 <38e60bb2-123b-09cf-d6ef-3a07c6984108@linaro.org>
 <trinity-597cf8a3-2ad4-41e6-b3c9-b949f8610533-1650390552136@3c-app-gmx-bap70>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-597cf8a3-2ad4-41e6-b3c9-b949f8610533-1650390552136@3c-app-gmx-bap70>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/04/2022 19:49, Frank Wunderlich wrote:
>> The list should be strictly ordered (defined), so:
>>   items:
>>     - const: ...
>>     - const: ...
>>     - const: ...
>>   minItems: 1
>>
>> However the question is - why the clocks have different amount? Is it
>> per different SoC implementation?
> 
> i only know the rk3568, which needs the clocks defined here, don't know about rk3588 yet.
> in rk3568 TPM i have the pcie-part seems missing (at least the specific register definition), so i had used the driver as i got it from the downstream kernel.
> 
> not yet looked if i find a rk3588 TPM and if this part is there as i cannot test it (one of the reasons this is a rfc/rft).

You can skip RK3588 compatible or define it this strictly also for that
chip.

> 
>>> +
>>> +  "#phy-cells":
>>> +    const: 0
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  reset-names:
>>> +    const: phy
>>> +
>>> +  rockchip,phy-grf:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: phandle to the syscon managing the phy "general register files"
>>> +
>>> +  rockchip,pipe-grf:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: phandle to the syscon managing the pipe "general register files"
>>> +
>>> +  rockchip,pcie30-phymode:
>>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
>>> +    description: |
>>> +      use PHY_MODE_PCIE_AGGREGATION if not defined
>>
>> I don't understand the description. Do you mean here a case when the
>> variable is missing?
> 
> yes, if the property is not set, then value is PHY_MODE_PCIE_AGGREGATION = 4

Then just use "default: 4"

> 
>>> +    minimum: 0x0
>>> +    maximum: 0x4
>>
>> Please explain these values. Register values should not be part of
>> bindings, but instead some logical behavior of hardware or its logic.
> 
> it's a bitmask, so maybe
> 
>     description: |
>       bit0: bifurcation for port 0
>       bit1: bifurcation for port 1
>       bit2: aggregation

That's good. I got impression you have a header with these values. If
yes - mention it here.

>       use PHY_MODE_PCIE_AGGREGATION (4) as default

Just use default as I wrote above.

Best regards,
Krzysztof
