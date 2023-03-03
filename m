Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7470B6A9554
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 11:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCCKfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 05:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCCKfx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 05:35:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA642CFD5
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 02:35:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cy23so8263861edb.12
        for <linux-pci@vger.kernel.org>; Fri, 03 Mar 2023 02:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677839750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze3EqNSXK099m87RCLoSDBMLakr/T6S1B5LWvJ2yAWs=;
        b=Sl6eBmlYVeo+www7Qqnrv+jZKj1mxXNNrnC3B933eeNdcY8vH288MHs3BC/shgvXoW
         rPqyNF0o9CUq+5Xp8d5AuFjCA+tDdhugohmyn54ZdLrynzd1TG9kTbxaHCQbXMbDoJXz
         vDL1FMReWmxo5tAi9pzmWVs9nVF+H1wUpfq6y2vogFa3ETw+6q7zsGPVr8XoEt3fnf3R
         YSn8K+zvFYf+ycv+aZ0MWpwtxiGOr1mnO3NyUVurvBQMQPM3mjdHrIvXfuMF1JQXCP4z
         3PbT22gomJ5ZIttZTSQRZr/Gr7HI19zZPacncxzMQDKi3JY5sWEkPOIGJ/2M7LUMVw2m
         +vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677839750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ze3EqNSXK099m87RCLoSDBMLakr/T6S1B5LWvJ2yAWs=;
        b=YjZFG7uJI62EkB3VX6RoYc/l9N1GSik0/0jJzaZLGJlRHxdUqktYR4/uk5dbbqmLm5
         NhInsPyAnqNBuv+AAJvYaPtR6yVKuxiVCjDfHMskLeAGLuuAePYk+oP40BW0yK058bfb
         gMAzJRgu9HoFT4EwnnoxQgbp0r4IYOz/FEoNWOxtLjK0zE3TcGs1naMTJ0ztDu8x3OAn
         ALzPJE0gZJWYOkLZ1COGaWAmFOzD2bJr7KhNBB0oDOpgB+pxzr7FqefUcvwDuWsrs6RF
         muUwb4Pd7eZUepgNm8GbnAvMWmiioDVNCzjkany1mDkKtWSCFspAlA0EdmxylcStrzNT
         oc6w==
X-Gm-Message-State: AO0yUKWMpUexOH3OIG0c5dEL39s6eUnAVD4vcsoR5ZSAzbA6hC0dvMbu
        QSOx3Zcj6SFiM8UwOMMhlBoxkA==
X-Google-Smtp-Source: AK7set+YW7hYpKA3lpcL/dUA/royLMxXd7p/cWUk/XidAXP9MdbG5CBb4pNf71EG4BgZRngyg8UbVQ==
X-Received: by 2002:aa7:c2da:0:b0:4bf:33e8:21ff with SMTP id m26-20020aa7c2da000000b004bf33e821ffmr1240428edp.30.1677839749740;
        Fri, 03 Mar 2023 02:35:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b008ba9e67ea4asm802590eja.133.2023.03.03.02.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:35:49 -0800 (PST)
Message-ID: <c97f3cd8-9d38-8385-5911-e718811451e6@linaro.org>
Date:   Fri, 3 Mar 2023 11:35:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/16] PCI: exynos: Rename Exynos PCIe driver to Samsung
 PCIe
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc@epcas5p2.samsung.com>
 <20230214121333.1837-3-shradha.t@samsung.com>
 <d0d1db7e-e2a7-dddf-5c28-fed330b44cdb@linaro.org>
 <4e7f3fe5-3a5e-d4c3-d513-642184bbdb23@linaro.org>
 <139601d94d06$9bd85990$d3890cb0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <139601d94d06$9bd85990$d3890cb0$@samsung.com>
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

On 02/03/2023 13:57, Shradha Todi wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 16 February 2023 16:29
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
>> Subject: Re: [PATCH 02/16] PCI: exynos: Rename Exynos PCIe driver to
>> Samsung PCIe
>>
>> On 16/02/2023 11:55, Krzysztof Kozlowski wrote:
>>> On 14/02/2023 13:13, Shradha Todi wrote:
>>>> The current PCIe controller driver is being used for Exynos5433 SoC
>>>> only. In order to extend this driver for all SoCs manufactured by
>>>> Samsung using DWC PCIe controller, rename this driver and make it
>>>> Samsung specific instead of any Samsung SoC name.
>>>>
>>>> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
>>>> ---
>>>>  MAINTAINERS                              |   4 +-
>>>>  drivers/pci/controller/dwc/Kconfig       |   6 +-
>>>>  drivers/pci/controller/dwc/Makefile      |   2 +-
>>>>  drivers/pci/controller/dwc/pci-samsung.c | 443
>>>> +++++++++++++++++++++++
>>>
>>> Rename missing. I am anyway not sure if this is good. What's wrong
>>> with old name?
>>
>> OK, looking a bit at your further patches - doesn't it make sense to split a bit
>> the driver? Maybe keep the core as pci-samsung, but some other parts in
>> pci-exynso5433?
>>
> 
> Ok agreed. So here is what I am planning, keeping in mind the next set of platform support which I am planning to send out (say FSD, ARTPEC-v8):
> 1: We will move samsung pci driver inside dwc/samsung/

I don't think we need one more directory...

> 2: pci-samsung.c shall contain common APIs, helper functions, etc
> 3: Platform specific driver will have their own files such as pcie-exynos.c, pcie-fsd.c, pcie-artpec-v8.c 

This sounds reasonable, although depends whether common driver part is
more or less common. If it is more common, then you will need only one
pci_driver and it should be in common object.


> Let me know what you think of this.
> I am not very keen on renaming Exynos SoC file as pcie-exyons5433.c as in future we may end up adding PCIe support for other Exynos which being
> in same family (Exynos Series) will be very similar in design. Custom ASIC (manufactured by Samsung Foundry) is primarily driven by various
> vendors and will have separate design in terms of integration of IPs in SoC and we need to have support for all such SoCs manufactured under Samsung umbrella.

Best regards,
Krzysztof

