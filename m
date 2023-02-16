Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8823D699276
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBPK72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBPK7X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:59:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C7A55E6F
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:59:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lf10so4201870ejc.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUO21HiD9AwPPk2yVyNNeKr/3WbcLbkpbjx6Ehu0Tmw=;
        b=D1XSSLIWGXwR9w6YIJRb6pI0ieOpzo5hYIm3tOAx37MZP8cTkCTkZq8cn6ppUH9GWg
         4DWCxcjbZrfko7IXHSmnybSJYvRQ9t11TWX03SzavoDVS6jD5rGwHzsVlncGeRqnR2L3
         ZDC7tlbaLKIoxfYpDGrr4iKyGU0C+JGf8zLGHWGB0e//hkCkY/MTtACWb1PzscxzpxvF
         znMZ/1FSdFeVYjSSN/lrgldYNS7L/qn4PYC0tFIO3jzdEv0TAuPOKtAJol3qaUD/jGF2
         3UhS0SFOZ+2+WLKGXzGe+VMHCej1NRocgiGu+dne4F6JLyZN9T7G3a98xM73+TRAGaSC
         msIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUO21HiD9AwPPk2yVyNNeKr/3WbcLbkpbjx6Ehu0Tmw=;
        b=1ir0DmrvoXR4qPg9pxS0kPv8uMxyCxm5p+bexdBL3tZdl706b6YC8E1ck6LN0TsgfI
         kxCTDzd7C5/Y68h2GQSdoJY0VTQbJRr4K0v5D6LWbb5ul35copradrfuP/4x6NP5a+Ne
         J0WIFfM+WRki+1hv/PkTeU6MI4ytmn5rEi/xt8jT96yhqOf/hGBsUFUKO9WVmul6OTMv
         IF0TWQ2NbLYiUZbnTRYkI9RWrE3qoJzQgMtNNoiET/Noxrh8rDU7IXNCrR/O2VH2Jb2m
         8zWsEzPjoQ/P30A16p9N+BU47y2ZdmXKnSMwLzqcj3r1PkuIMLfV7WIP58lygX8h/QWW
         JJ3w==
X-Gm-Message-State: AO0yUKWKZY0K++LPKBB3S7HdOgKT90PSNLORdHJbrd/lxbk4X9LEYzg6
        ll026wJXGHHB3Bbuib66HXQ5jg==
X-Google-Smtp-Source: AK7set9kqT0KWfYBEgpPpqbE3mXf//cnTThDSrhMXoaZ2Z562G5Cb5Fwxv17Ew0mW/1P8G+LQlFOxg==
X-Received: by 2002:a17:906:71d0:b0:8ae:f73e:233f with SMTP id i16-20020a17090671d000b008aef73e233fmr6938108ejk.32.1676545157943;
        Thu, 16 Feb 2023 02:59:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t22-20020a170906949600b008b149bdacedsm670578ejx.12.2023.02.16.02.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:59:17 -0800 (PST)
Message-ID: <4e7f3fe5-3a5e-d4c3-d513-642184bbdb23@linaro.org>
Date:   Thu, 16 Feb 2023 11:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/16] PCI: exynos: Rename Exynos PCIe driver to Samsung
 PCIe
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <d0d1db7e-e2a7-dddf-5c28-fed330b44cdb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/02/2023 11:55, Krzysztof Kozlowski wrote:
> On 14/02/2023 13:13, Shradha Todi wrote:
>> The current PCIe controller driver is being used for Exynos5433
>> SoC only. In order to extend this driver for all SoCs manufactured
>> by Samsung using DWC PCIe controller, rename this driver and make
>> it Samsung specific instead of any Samsung SoC name.
>>
>> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
>> ---
>>  MAINTAINERS                              |   4 +-
>>  drivers/pci/controller/dwc/Kconfig       |   6 +-
>>  drivers/pci/controller/dwc/Makefile      |   2 +-
>>  drivers/pci/controller/dwc/pci-samsung.c | 443 +++++++++++++++++++++++
> 
> Rename missing. I am anyway not sure if this is good. What's wrong with
> old name?

OK, looking a bit at your further patches - doesn't it make sense to
split a bit the driver? Maybe keep the core as pci-samsung, but some
other parts in pci-exynso5433?

Best regards,
Krzysztof

