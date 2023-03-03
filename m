Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF36A94D3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 11:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCCKGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 05:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCCKGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 05:06:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2E712BE6
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 02:06:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g3so8227928eda.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Mar 2023 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677837978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A52iRvnx5c7MGijeXJmmv5mrghysldEPBrnjdkAkJZ4=;
        b=yr1lGj5AdVK9kPgEvrtJdc3zZz5bDs0BSUoUjg+sHzLPIMJTsPXA3OQ9nUqXxlNLZ+
         ZmLGPmzovNOCnWNSKxurap8WIvGeWrYRu80UjGAyRj8vm7cBTLTgMBajvllO4gZItrnQ
         XPfoX8g7C0Hp0ZZQ1dJQUG0uZXCHumzAVxP+yqxR5oWNsrDatY0vYddtrdgUSGV9PdMm
         4EGZnFcJJ7WNoEGWhA5TE2hgwKollJcggbKcpjnWUHpOs1Mcjtz/9AvkcIE0byxowqAo
         0LgC7WvNUc9Omqt0Nk9AZ7VOjPQlO2n555IuBNXFRTIvxJ/Z+q6BvNFEojv5DTF9Tz/1
         P8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677837978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A52iRvnx5c7MGijeXJmmv5mrghysldEPBrnjdkAkJZ4=;
        b=EYtsZ9gqhypSCfdVdZZKAwJsla7HBX20XtkdhwbV1HD/Suyzz+OFsugXuG3tEfK1DC
         vvvA46Fn+WB2w1VZGwwCJ8+SksCL54062Imx2pUakBr4w4Nv0DXFfzpV38L/k+tDM8jb
         uF8EVLO2e3a/X4gWDSK/ZlFwSCsKOLVchWDehKqx8wn8zvKF50frCUB2bJy8rq7zAgfe
         dxuEfIdGiuQlbhOU0jd6A6bMUool3BYjl6Kp044Tw9M15tVhRDOBTShjnLOB/4Rz1jhs
         rTnPR6XaNVKQeuCyh6ub2lb+m5Wa7G8tiq6eik5YT9RVv3qWglhac8aU7sMsh4KQB/9J
         8kqw==
X-Gm-Message-State: AO0yUKUzw0Q2KsmHzo9fKSuulzTKcIBNqTwfJPfV7UiC3106I9WI1k6+
        6fwjur5Wh4kz+iiDsWlxByqrEw==
X-Google-Smtp-Source: AK7set+ehJpZq1NePXVYHcpcgCL/tQBG+1grBrCeNQPJL4QzQpW6BkSTT9hiFKaiWt2LgNJT6dtWTA==
X-Received: by 2002:aa7:c392:0:b0:4ac:d2b4:5e37 with SMTP id k18-20020aa7c392000000b004acd2b45e37mr1173029edq.39.1677837977750;
        Fri, 03 Mar 2023 02:06:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v5-20020a50d085000000b004af5968cb3bsm969650edd.17.2023.03.03.02.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:06:17 -0800 (PST)
Message-ID: <f175dcae-2729-2bac-d2e8-088537354160@linaro.org>
Date:   Fri, 3 Mar 2023 11:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/16] PCI: samsung: Rename exynos_pcie to samsung_pcie
Content-Language: en-US
To:     Pankaj Dubey <pankaj.dubey@samsung.com>,
        'Shradha Todi' <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121436epcas5p1641de02220bea5edb23bc875b6311270@epcas5p1.samsung.com>
 <20230214121333.1837-9-shradha.t@samsung.com>
 <a4bfad9d-b9df-28a5-6bee-5cbbca4dd23f@linaro.org>
 <146301d94d03$002ba040$0082e0c0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <146301d94d03$002ba040$0082e0c0$@samsung.com>
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

On 02/03/2023 13:32, Pankaj Dubey wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, February 16, 2023 4:37 PM
>> To: Shradha Todi <shradha.t@samsung.com>; lpieralisi@kernel.org;
>> kw@linux.com; robh@kernel.org; bhelgaas@google.com;
>> krzysztof.kozlowski+dt@linaro.org; alim.akhtar@samsung.com;
>> jingoohan1@gmail.com; Sergey.Semin@baikalelectronics.ru;
>> lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com; tglx@linutronix.de;
>> m.szyprowski@samsung.com; jh80.chung@samsung.co;
>> pankaj.dubey@samsung.com
>> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 08/16] PCI: samsung: Rename exynos_pcie to
>> samsung_pcie
>>
>> On 14/02/2023 13:13, Shradha Todi wrote:
>>> The platform specific structure being used is named exynos_pcie.
>>> Changing it to samsung_pcie for making it generic.
>>>
>>> Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
>>> ---
>>>  drivers/pci/controller/dwc/pci-samsung.c | 190
>>> +++++++++++------------
>>>  1 file changed, 95 insertions(+), 95 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-samsung.c
>>> b/drivers/pci/controller/dwc/pci-samsung.c
>>> index d5adf1017a05..be0177fcd763 100644
>>> --- a/drivers/pci/controller/dwc/pci-samsung.c
>>> +++ b/drivers/pci/controller/dwc/pci-samsung.c
>>> @@ -23,7 +23,7 @@
>>>
>>>  #include "pcie-designware.h"
>>>
>>> -#define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
>>> +#define to_samsung_pcie(x)	dev_get_drvdata((x)->dev)
>>>
>>>  /* PCIe APPL registers */
>>>  #define EXYNOS_PCIE_IRQ_PULSE			0x000
>>> @@ -51,7 +51,7 @@
>>>  #define EXYNOS_PCIE_APPL_SLV_ARMISC		0x120
>>>  #define EXYNOS_PCIE_APPL_SLV_DBI_ENABLE	BIT(21)
>>>
>>> -struct exynos_pcie {
>>> +struct samsung_pcie {
>>
>> No, I don't see benefit of this at all. How we call stuff inside driver is not related
>> whether this is for Tesla or Exynos. We could even call it "pony". :) Thus
>> renamings just to support new variant of Samsung device is not a good reason.
>>
> Whole intention of this whole series was to make exynos-pcie driver to support for all Samsung manufactured SoCs be it Exynos series or custom ASIC such as fsd, artpect-v8. 

But the patches does not do it, at least mostly. It only renames which
does not bring any support... what's more, such renames without actual
context - support for the new devices - is a bit pointless.

> 
> While doing so, we feel for better readability and conveying better names for files, structs, internal APIs will help developers for understanding and reusing it. For example we know that clock initialization will remain common (thanks for bulk_clk_xxx APIs) so we kept APIs for handling clocks starting with samsung_clk_xxxx, but if we have to implement two variant of APIs, or struct targeting different platforms it would be good if they have platform specific prefixes. This will help in grep or future code maintenance.

Without context it's impossible to judge whether this makes any sense.

Best regards,
Krzysztof

