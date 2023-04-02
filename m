Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74886D3762
	for <lists+linux-pci@lfdr.de>; Sun,  2 Apr 2023 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDBKrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Apr 2023 06:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjDBKrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Apr 2023 06:47:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB1A1206A
        for <linux-pci@vger.kernel.org>; Sun,  2 Apr 2023 03:47:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ew6so106477777edb.7
        for <linux-pci@vger.kernel.org>; Sun, 02 Apr 2023 03:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680432423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boY93jyd6+T4l8iYNZlZE0N095pRX4NnlYNcBxMegqE=;
        b=KJF9SsfWvwvyR4Yw5C5V1+mHelTyrF51rvwVQmy4cS34/YnHeIMNzaqun0xl6GDRdi
         yCD7Nxe7hxn7VJgirW/NXE9dHznT7Q4+fQq2Lrp+ZET8RipTCo/T+L8x7zqJN+m/lDh9
         cZDJjGN5Q7c8bb5MzjB78EtPkDrxHezKhnJPw4d4ZNrsLyWGqZj4D2nf8OSWYTWOTHrY
         uL7y6P8t3S//PuVzPNZERT9zxrfHouWnW80Yf+LkQM4jLAitXRfilQSjvegdz8c9tle/
         vKbV8EzMR0n9zSGiX6dptsHQVHJG2nPPYST7+x/N3QFgjovOM+wp/Z5FmHInkWg0snZ+
         YGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680432423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boY93jyd6+T4l8iYNZlZE0N095pRX4NnlYNcBxMegqE=;
        b=FhkJGeTWeQGTMGosvTAQTo97dWMwIP2tgo51eMTwV+/Bfy4cm7wBYalcHh/jwQXoOP
         DzpwuB2OAqbwzon1d8p2OW5WkpZAlitoqs+geqGEx5dw6JB2fstsCN/xxWBrL1vieBxM
         9k+tu4jW7iLqLx6hWoN9Bm3zq4QLGry57nlr7y3OzlalmwhiAvPifGvi898qkVBtqThy
         hvVhdo5UTxLz7s8qdIdfSZghljEVgUoSnEMJVJ3RYJVElFQXnTwEGJavAM0+b25vIp4q
         CTC/j9L3hFcHHT1zWju7UpKL6GCsl9REzH95Bv9igNpZPeMoB4CZyuUTW5Tk08OEsqFH
         3C1Q==
X-Gm-Message-State: AAQBX9cm40tYbF/+KicVH9iKMYOUSV0tCnd6737oGi5J6uRjtJ2NiiM2
        GFQNfjGMYdb0JLBgLJFmGklHUg==
X-Google-Smtp-Source: AKy350ZEHhfp/UzJ0URFQoZ1spvf7xAJ6vhppv6/DhrVo837ythU/SyCg9S1R8dhbRGHXfjkskDSVQ==
X-Received: by 2002:aa7:d885:0:b0:4fd:2155:74ef with SMTP id u5-20020aa7d885000000b004fd215574efmr32584061edq.19.1680432423031;
        Sun, 02 Apr 2023 03:47:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id u26-20020a50a41a000000b004fb95f51f54sm3142513edb.12.2023.04.02.03.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 03:47:02 -0700 (PDT)
Message-ID: <8a22aea9-5027-e8a4-db80-ce79f3830e10@linaro.org>
Date:   Sun, 2 Apr 2023 12:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v4 01/10] dt-bindings: memory: tegra: add bpmp ref in
 tegra234-mc node
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     treding@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
 <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org> <ZCLF6ZRH528pu/r3@orome>
 <79d8044f-ce68-463e-66f7-8755e253bc99@linaro.org> <ZCLiCWRYbO98qwCn@orome>
 <0b393600-3f08-c2e8-9b02-664c6a984de1@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0b393600-3f08-c2e8-9b02-664c6a984de1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/03/2023 19:12, Sumit Gupta wrote:
> 
> 
> On 28/03/23 18:18, Thierry Reding wrote:
>> On Tue, Mar 28, 2023 at 01:22:26PM +0200, Krzysztof Kozlowski wrote:
>>> On 28/03/2023 12:48, Thierry Reding wrote:
>>>> On Tue, Mar 28, 2023 at 09:23:04AM +0200, Krzysztof Kozlowski wrote:
>>>>> On 27/03/2023 18:14, Sumit Gupta wrote:
>>>>>> For Tegra234, add the "nvidia,bpmp" property within the Memory
>>>>>> Controller (MC) node to reference BPMP node. This is needed in
>>>>>> the MC driver to pass the client info to the BPMP-FW when memory
>>>>>> interconnect support is available.
>>>>>>
>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>> ---
>>>>>>   .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++++
>>>>>>   1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>> index 935d63d181d9..398d27bb2373 100644
>>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>>> @@ -58,6 +58,10 @@ properties:
>>>>>>     "#interconnect-cells":
>>>>>>       const: 1
>>>>>>   
>>>>>> +  nvidia,bpmp:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>> +    description: phandle of the node representing the BPMP
>>>>>
>>>>> Why do you need this multiple times? Both in parent and all external-mc
>>>>> children?
>>>>
>>>> We've had nvidia,bpmp in the external memory controller node since
>>>> basically the beginning because we've always needed it there. For newer
>>>> chips we now also need it for the memory controller.
>>>>
>>>> Ideally I think we would only have this in the MC and have the EMC
>>>> driver reference it via the EMC's parent (i.e. MC), but that would break
>>>> backwards-compatibility. Reaching into the EMC's DT node from the MC was
>>>> another option that we discussed internally, but it didn't look right
>>>> given how this is also needed by the MC.
>>>>
>>>> One thing we could potentially do is deprecate the nvidia,bpmp phandle
>>>> in the EMC and only keep it as a fallback in the drivers in case the
>>>> parent MC doesn't find it's own in the DT.
>>>
>>> Yes, deprecation would answer to my question.
>>
>> Okay, great. Sumit, you can resolve this by adding a "deprecated: true"
>> to the EMC's nvidia,bpmp property schema. In the driver we can then try
>> to look at the MC's ->bpmp and if it exists reuse that. If it doesn't
>> exist, we can keep the existing lookup as a fallback for device trees
>> that haven't been updated yet.
> 
> We can't use MC's->bpmp in the EMC driver's probe as it will be NULL. 
> This is because MC driver uses "arch_initcall" and gets probed earlier 
> than BPMP. We can do this in another way as below change. This way we 
> can use the existing "nvidia,bpmp" property from EMC node and don't need 
> to move it to the MC node. Please share if this change sounds OK.

Then rather it sounds like time to fix these
orderings/arch_initcall/missing defer.


Best regards,
Krzysztof

