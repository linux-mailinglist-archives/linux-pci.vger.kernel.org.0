Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34155CB70
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiF0KrX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiF0KrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 06:47:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80AA641B
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 03:47:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z7so12327865edm.13
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gpVEijcIfO7nptFiwPf05a4gNnmGv2qY0uWTrFNUgTE=;
        b=gLbnmqyz8jOdYp6w8FuZjTafZkwT8pkYGKfPXfhmzCzsLWWdOlxokWJ9VO/YONUOrr
         rWZvHjmFf52+M6nlsZhekiBhrM8UTLWKiTh5YUoUw5Y1w+tpzQQ0tHdkcTIcNa9TWXkU
         McdZlCK82F4+VxUg8ehwjvnqEX7Dz/1ZgX91gQLtYDRlv+RbWz56JSGZdcBDGnutIi0H
         dzUUq9hW7gFYnd6nUlw7wunrPCC6tml8u6scRo6Of1W9Tfmj+S8YXksrGOjD2kl5EViE
         pVJ4pHMATa5fzBLDzLos4GAn+GRrDbTlb/ny3uPSM5QUn3a5OdJvgoLZayOnhtyWozZq
         wTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gpVEijcIfO7nptFiwPf05a4gNnmGv2qY0uWTrFNUgTE=;
        b=eZ/G9oaJxEY6rLEK8oZEJ8FcP+Twy5kf6yzAWeTP8zvNoMMeDEWF4Jtr4fKQhJfkxX
         Ku7O5FwU6mkHckyy98vSWf9lO1NEoOc6/cFSudWAgZZRJY10udeQsspUHzJOQ6cBYh0V
         f7jlySumgQwIPn3O59Qv5edZOHv3w+InH/n8rNb1fF11HvDRLrCYSFWMQtlF0BKRi2B6
         yDn9lQIxmMIft2OySeN+A33vIeGHLAk/YCxsfUhKsqt7IN2d3u2HBWHSug9rDhAmkHDi
         mnhlHmI7gitA9/82cGEj9YX0prckYJYso6ebFrejMSLvyV8Xgq/i8JuxPWQgzP6q2Tjn
         3vEg==
X-Gm-Message-State: AJIora+9VBS6ObuJAWvEHO+a1xTwLSmwKzt91B3RKezYWyRON/apA8hW
        YhYlMp9uI0e/W7ZsbNwDCeWkIA==
X-Google-Smtp-Source: AGRyM1vgfrHZrHQCINMERcN9cugijGYyf1GSAlI2ko56v+wgzERvq3ty4zeYUPxhi45eY2G7lU4oBg==
X-Received: by 2002:aa7:c14f:0:b0:435:7b75:fd06 with SMTP id r15-20020aa7c14f000000b004357b75fd06mr15916778edp.352.1656326839504;
        Mon, 27 Jun 2022 03:47:19 -0700 (PDT)
Received: from [192.168.0.248] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b006ffa19b7782sm4831735ejf.74.2022.06.27.03.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 03:47:18 -0700 (PDT)
Message-ID: <ae8cee69-2ca5-0b27-f6d5-0f9f74871fd8@linaro.org>
Date:   Mon, 27 Jun 2022 12:47:17 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <591f696f-b55c-d267-7fcb-74f7fd4a6900@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/06/2022 12:30, Marek Szyprowski wrote:
> Hi,
> 
> On 24.06.2022 20:07, Krzysztof Kozlowski wrote:
>> On 24/06/2022 19:35, Bjorn Helgaas wrote:
>>> In exynos_pcie_host_init() [1], we call:
>>>
>>>    phy_reset(ep->phy);
>>>    phy_power_on(ep->phy);
>>>    phy_init(ep->phy);
>>>
>>> The phy_init() function comment [2] says it must be called before
>>> phy_power_on().  Is exynos doing this backwards?
>> Looks like. I don't have Exynos hardware with a PCI, so cannot
>> test/fix/verify.
>>
>> Luckily for Exynos ;-) it's not alone in this pattern:
>> drivers/net/ethernet/marvell/sky2.c
>> drivers/usb/dwc2/platform.c
> 
> I've checked that on the real hardware. Swapping the order of 
> phy_power_on and phy_init breaks driver operation.
> 
> However pci-exynos is the only driver that uses the phy-exynos-pcie, so 
> we can simply swap the content of the init and power_on in the phy 
> driver to adjust the code to the right order. power_on/init and 
> exit/power_off are also called one after the other in pci-exynos, 
> without any activity between them, so we can also simply move all 
> operation to one pair of the callback, like power_on/off.
> 
> Krzysztof, which solution would you prefer?

I think the real problem is that the Exynos PCIe phy init
(exynos5433_pcie_phy_init) performs parts of power on procedure, so the
code is mixed. Probably also the phy init could not happen earlier due
to gated clocks (ungated in exynos5433_pcie_phy_power_on).

I would prefer to clean it up while ordering init+power_on, so figure
out more or less correct procedure.

You can also look at Artpec-8 PHY - it seems using correct order
(init+reset):
https://lore.kernel.org/all/20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7/
Best regards,
Krzysztof
