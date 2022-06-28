Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699855DB9D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiF1I2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 04:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245592AbiF1I1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 04:27:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD89DA47E
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 01:27:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i25so11003352wrc.13
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DgEjfAoE6T+reUz3mii+858wYgEoE6WnFO0TC/3rlLE=;
        b=Ftu5oHZ+CenECgEi7VBewvPpq9LIJOkJjiFCsfcBxoTbdeQfv7MLt+JKrCE0GIv1hc
         lYhetcSmRtcokHXLCVa+qhl7nM95LMGmAG6muEh1cHghqGFfTyeqlAVD1eX6XaMwmqV3
         TenqzmGw2in6AVfhGGEvktAkfiwxAbxLuWF5YRj+BUn7u5Fyvfc01N4z6SYA8BG+ek5W
         vj1VS5IYNYThB8EL1IhBHHoxS8TEizerG1t7+A2EC8GuXsWc+jUZ6+SIJdqqeciIkgay
         oXpdzM0yQPk7JjUWDgMcd6jp2Xd499baOItDPtN1qiqNLzEGoWZDLbFudkeq9uPNf/An
         k07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DgEjfAoE6T+reUz3mii+858wYgEoE6WnFO0TC/3rlLE=;
        b=ik1ewEzpxEJrZ5PsBC3vx225uUPiVQwKanSLP0CS2/KcIKWYqqLwvICjWVYkf7eCDO
         EJp3ZDMQOFWk9MlB23Spqnthwh4WRTuPzsgZRHPfFHGYWvwlaH+7f3vT2m79pEPNIODe
         czzwyZFMoEfT4GW9nRoygjQ98/euWnG9F9gioxzjqu4Az4Y/AFbbMg9oOKxL4ekoYjjO
         IBISz+aYi3iPx/FJgMeDm++AD0mj+rlmL+UsjptW1d3xOzOSGRBgjizE90oOeior+sAy
         hRQeLhpqfMXw/vSHgEacv5hm/QEzqR279GNC33Qs+l2g+kAVgKHTaVWxu9vvyFG8wUEs
         x1PA==
X-Gm-Message-State: AJIora+yBJdvNl9Wfzvpc78WY915QtSGJJWLxbMQ1vaBNkIwWdTEz4JZ
        O7/ZGSLnV8DGbe42UEhMJ3Qh3g==
X-Google-Smtp-Source: AGRyM1se0ar4caK08DoLfv6IoOmZZRXL7hoFYJiFY0G+pdv0azeGI/dKk1X+iwDro3Da/Dd5SKTLNA==
X-Received: by 2002:adf:fe83:0:b0:21b:9cc6:4c91 with SMTP id l3-20020adffe83000000b0021b9cc64c91mr17053713wrr.414.1656404852313;
        Tue, 28 Jun 2022 01:27:32 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b003a03ae64f57sm16383538wms.8.2022.06.28.01.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:27:31 -0700 (PDT)
Message-ID: <7ab52c5f-6c48-6381-e0f3-a1d9572dc2a9@linaro.org>
Date:   Tue, 28 Jun 2022 10:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: pci-exynos.c phy_init() usage
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220624173541.GA1543581@bhelgaas>
 <CGME20220624180806eucas1p16a18d9598c0a08770b428cd58916b65d@eucas1p1.samsung.com>
 <c0c802c0-82e1-e7bb-48be-974ac23b5a15@linaro.org>
 <591f696f-b55c-d267-7fcb-74f7fd4a6900@samsung.com>
 <ae8cee69-2ca5-0b27-f6d5-0f9f74871fd8@linaro.org>
 <a7d73302-ce96-4adb-1981-fcde0ff03e87@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a7d73302-ce96-4adb-1981-fcde0ff03e87@samsung.com>
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

On 28/06/2022 10:13, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 27.06.2022 12:47, Krzysztof Kozlowski wrote:
>> On 27/06/2022 12:30, Marek Szyprowski wrote:
>>> On 24.06.2022 20:07, Krzysztof Kozlowski wrote:
>>>> On 24/06/2022 19:35, Bjorn Helgaas wrote:
>>>>> In exynos_pcie_host_init() [1], we call:
>>>>>
>>>>>     phy_reset(ep->phy);
>>>>>     phy_power_on(ep->phy);
>>>>>     phy_init(ep->phy);
>>>>>
>>>>> The phy_init() function comment [2] says it must be called before
>>>>> phy_power_on().  Is exynos doing this backwards?
>>>> Looks like. I don't have Exynos hardware with a PCI, so cannot
>>>> test/fix/verify.
>>>>
>>>> Luckily for Exynos ;-) it's not alone in this pattern:
>>>> drivers/net/ethernet/marvell/sky2.c
>>>> drivers/usb/dwc2/platform.c
>>> I've checked that on the real hardware. Swapping the order of
>>> phy_power_on and phy_init breaks driver operation.
>>>
>>> However pci-exynos is the only driver that uses the phy-exynos-pcie, so
>>> we can simply swap the content of the init and power_on in the phy
>>> driver to adjust the code to the right order. power_on/init and
>>> exit/power_off are also called one after the other in pci-exynos,
>>> without any activity between them, so we can also simply move all
>>> operation to one pair of the callback, like power_on/off.
>>>
>>> Krzysztof, which solution would you prefer?
>> I think the real problem is that the Exynos PCIe phy init
>> (exynos5433_pcie_phy_init) performs parts of power on procedure, so the
>> code is mixed. Probably also the phy init could not happen earlier due
>> to gated clocks (ungated in exynos5433_pcie_phy_power_on).
>>
>> I would prefer to clean it up while ordering init+power_on, so figure
>> out more or less correct procedure.
>>
>> You can also look at Artpec-8 PHY - it seems using correct order
>> (init+reset):
>> https://lore.kernel.org/all/20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7/
> 
> I've played a bit with those register writes in exynos_pcie_phy and 
> frankly speaking the currenly used (power_on + init) is the only 
> sequence that works properly. I'm leaning to move everything to 
> phy_init/exit. I really don't see how to split it into init + power_on 
> callbacks.

I was afraid it will be like this. I imagine that certain (not
explicitly documented) init operations cannot even happen before power
on, so this would be a lot of tries.

I am fine with it. Thanks for doing it.

> 
> While touching this - I would also remove the phy_reset() call in the 
> exynos-pcie driver. It is a left over from the old, obsoleted exynos5440 
> pcie code, not implemented in the current phy driver, also only a few 
> drivers use or implement it. IMHO it doesn't make sense to keep such 
> dead code.

Sure, looks ok.

Best regards,
Krzysztof
