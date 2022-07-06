Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1318F568C36
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiGFPGX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGFPGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 11:06:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90717AAB
        for <linux-pci@vger.kernel.org>; Wed,  6 Jul 2022 08:06:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j23so2104513lji.13
        for <linux-pci@vger.kernel.org>; Wed, 06 Jul 2022 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8AO+J2LE63gF/pEN0vFhWdC06z7hhSAJ2kzbzBHJQYc=;
        b=Yu53js0MAGepvew3Gnozocl206vgIuj1V+C5/ECHoEY/DsvpqGEjcqt9GF843uMUbq
         pQ+tva9G6ED+y3/e+AW1/Ps8GTtgDscD/JVWR9FPTXdrGy1qaglB5p2jZT/BklBtWKdB
         b4f3q9wxnYksxsCI/Qh1Nc2PvsultWSf+E75bmnz+hFZoQCKo93Bp7HMq6ol62rfOzvf
         Tny/uz1AzSMVNa5L5yvbYaLDLDKxZqQxJ6eRjmA45XDrLad4VXyCyv3ppg9S6vtL89UN
         0XPd9vLhnjdD+fLgTl4RgVSv19MpSZqBHxwd291COOaZp5Hv4g1Rz9Db2zssJiWuYbVl
         4XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8AO+J2LE63gF/pEN0vFhWdC06z7hhSAJ2kzbzBHJQYc=;
        b=tdbbhOanBZv1scNhSJvbNV9KRkTZmX/YdV5g1yifl/pBtSr1nMfG7FMRWZ+uhZvzuJ
         vR30MVI+lzF5lcs5dTrLy3tywv4xQhhoLA1agiiA4YHaGpzfcLRDtVRB85GeX87tlhva
         jO0Nq4pos48fWkfMD7ySI42z0AS39E5xExh3/L7qloBoG4yvGJIS+Sn/v2VQxYHpdirx
         q7WicvwPv0j5CKZYLMEoARDhXluBdGpCRJg515a21rPz4PC0isGUAMppYJeT3Vz6JDZF
         4VjSZArSYdlwNZQPsglW35nSMTimkSAaHoH+fvNAfSub5JOfWGEE2wpKC+VFBuh8FcgS
         I9Sg==
X-Gm-Message-State: AJIora9ReyQI4iOdnjTRtab6UmAPjMYZx/NpTivwczM7HVIwELg8mKgG
        japr3NBO3VDwBT+erTPZm8i4dQ==
X-Google-Smtp-Source: AGRyM1vvRukpDW59hhuCkomJfS5xKDFgaLXYid6bqitubs0npzp+fQmvLDn1pZEU+L4JkcWZYMhIxA==
X-Received: by 2002:a2e:a26c:0:b0:25a:6dad:8bf5 with SMTP id k12-20020a2ea26c000000b0025a6dad8bf5mr23877254ljm.136.1657119979530;
        Wed, 06 Jul 2022 08:06:19 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id g1-20020a0565123b8100b0047f9d9a4186sm6330501lfv.165.2022.07.06.08.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:06:18 -0700 (PDT)
Message-ID: <bce8c598-9075-d643-59b5-c2397a55b52f@linaro.org>
Date:   Wed, 6 Jul 2022 17:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 02/11] dt-bindings: pci: tegra: Convert to json-schema
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Thierry Reding <treding@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-3-vidyas@nvidia.com>
 <20220630210449.GA3283899-robh@kernel.org>
 <e971a557-3387-efcf-87ec-983b998c5e93@nvidia.com>
 <2829e71b-1769-ce24-f810-d63e619aa5f0@linaro.org>
 <398a9370-6c2d-319c-2e23-038588fbf004@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <398a9370-6c2d-319c-2e23-038588fbf004@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/07/2022 12:46, Vidya Sagar wrote:
> 
> 
> On 7/6/2022 3:36 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 06/07/2022 11:53, Vidya Sagar wrote:
>>>>> +  nvidia,bpmp:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>> +    description: |
>>>>> +      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
>>>>> +      are the controller IDs for each controller:
>>>>> +
>>>>> +        0: C0
>>>>> +        1: C1
>>>>> +        2: C2
>>>>> +        3: C3
>>>>> +        4: C4
>>>>> +        5: C5
>>>>> +    items:
>>>>> +      - items:
>>>>> +          - minimum: 0
>>>>> +            maximum: 0xffffffff
>>>>
>>>> That's already the limit. Just a description is fine.
>>>>
>>>>> +          - enum: [ 0, 1, 2, 3, 4, 5 ]
>>>>
>>>> maximum: 5
>>>
>>> Setting the maximum to '5' is resulting in the following error.
>>>
>>> pcie-ep@141a0000: nvidia,bpmp:0:0: 4294967295 is greater than the
>>> maximum of 5
>>>
>>> Could you please help me understand why I'm seeing this error?
>>
>> Trim your replies.
>>
>> Why adding minimum:5 to the phandle? Rob said add a description. Nothing
>> about minimum.
> 
> I'm sorry I didn't understand the review comment clearly.
> There is one description added above already. Are you (and Rob) saying 
> that one more description is needed?

You have description of entire property. The property consists of
phandles ("items", with only one item) and each phandle of two items
(second nested "items"). The first item in phandle is actual phandle, so
it does not need any constraints/schema, just a description. This was
missing.

Something like this:
https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42

except that in your case second item (in the nested items) have actual
schema, not description, which is good.



Best regards,
Krzysztof
