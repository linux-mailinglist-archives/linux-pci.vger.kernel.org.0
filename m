Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27561505D23
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbiDRQ5M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 12:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346747AbiDRQ4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 12:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E639433EB8;
        Mon, 18 Apr 2022 09:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A10B3B8104C;
        Mon, 18 Apr 2022 16:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A77EC385AB;
        Mon, 18 Apr 2022 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650300747;
        bh=FqA87CXgaTYslJKT4j5d//cmzCdvUZXSeGEszJTZZjk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MrkJSukFcEJ1Zk/lIRC80aIrInKZSSpKqmq0u5QlxlZaTrIQD21v5v5gzfcGmCjep
         ct6C7k7YyDekrWeXPAPWEaTd5TpLHVNFCwo3/NBmqVf5G6baM2QNZCL9pRaK63cHR2
         X8ZbexAFAFgFgzYYGNrk5TuH1uxiswgGzL02Zre2U2DEAQoRVZ7EdWNC3Rn8n2csaS
         efFeAva1gSESCMNUSVVhLP7ZbK3dTXPIdrEfFWdHfvYCFc6b5b3WPBvjtHRVvXmYTl
         5lFEitQ/UCkh4zgieGEr1NVM9/JvlDzpIyvziiZNerRVaEWxLssdJiH1ajii+02gki
         uwvC9Jg/Oz0iw==
Message-ID: <4a6dd90c-3f8e-ad18-0136-88b75f4d9cf9@kernel.org>
Date:   Mon, 18 Apr 2022 18:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Content-Language: en-US
To:     wangseok.lee@samsung.com, robh+dt <robh+dt@kernel.org>,
        krzk+dt <krzk+dt@kernel.org>, kishon <kishon@ti.com>,
        vkoul <vkoul@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "jesper.nilsson" <jesper.nilsson@axis.com>,
        "lars.persson" <lars.persson@axis.com>
Cc:     bhelgaas <bhelgaas@google.com>,
        linux-phy <linux-phy@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi" <lorenzo.pieralisi@arm.com>, kw <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
References: <CGME20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p4>
 <20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p4>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/04/2022 09:20, Wangseok Lee wrote:
>>> Also, as you know,
>>> exynos driver is designed according to exynos SoC platform,
>>> so both function and variable names start with exynos.
>>
>> That's hardly a problem...
>>
>>> Compared to the existing exynos driver, 
>>> you can see that the structure and type of function are different.
>>
>> No, I cannot see it. You coded the driver that way, you can code it in
>> other way.
>>
>>> For this reason, it is difficult to use the existing exynos driver 
>>> for artpec.
>>
>> Naming of functions and structures is not making it difficult. That's
>> not the reason.
>>
>>> Our idea is to register a new PCIe driver for artpec-8 SoC platform 
>>> and maintain it in the future.
>>
>> We also want to maintain Exynos PCIe driver in the future.
>>
>> Best regards,
>> Krzysztof
> 
> Hi, 
> Sorry for delay response.

Sure, happens, but I don't remember the discussion, so replying that
late will not help your cause.

You know that if you (you as Samsung) worked with upstream, e.g. by
extending the drivers and keeping them in shape, it would be much easier
for you (again you as Samsung) to actually add new features? It's much
better/effective approach than the path of pushing every time new driver
with explanation like "we do not want to maintain older driver, so we
want a new one"...

> I have listed some parts that are different from exynos pcie driver.
> 
> PHY driver
> PHY is different, so register map is also different.
> Three reference clock options are available in ARTPEC-8.
>   It operates by selecting one clock among XO, IO, and SOC PLL.
>   However, the exynos phy driver sets one ref clk though sysreg.

It usually trivial to code such difference in the driver.

> The reset method and type of PHY for initialization are different.
> The overall sysreg configuration is different

Indeed.

> Artpec-8 requires a separate sequence for phy tuning,
> but it does not exist in exynos phy driver.
> Artpec-8 requires pcs resources, but exynos phy driver does not exist.
> 

For the phy driver indeed it might require much effort to create one driver.

> Controller driver
> Sub controller is different, so register map is also different.
> And it is different handles lane control, link control, PHY clocking,
> reset, interrupt control. 
> The number and type of clock resources used are different.
> The overall sysreg configuration is different
> 
> Also artpec-8 is performed in dual mode that supports both RC and EP.
> As described above, the PHY and sub ontroller are different
> and the regiser map is different.
> sysreg is also different. And there are differences such as reset.
> The driver will be much more complicated if both hardwares should be
> supported in the same driver.

Maybe, quite probably. The reluctance to extend any existing code makes
me doubting this, but I admit that there are many differences.

> For these reasons, my opinion is that better to create
> a phy, controller both driver with a new file.
> Please let me know your opinion.

At the end it's mostly the decision of PCIe and phy subsystem
maintainers whether they want to have separate drivers for DWC PCIe
blocks in ARMv8 Samsung SoCs.

In any case, the driver code looks like copied-pasted from some vendor
sources, so you need to bring it to shape.

Best regards,
Krzysztof
