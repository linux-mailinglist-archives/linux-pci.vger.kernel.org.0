Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D93B0656
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 15:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFVOAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 10:00:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51426 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhFVOAU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 10:00:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15MDvjYl047754;
        Tue, 22 Jun 2021 08:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624370265;
        bh=hImJfigCmsEVHzwdi+4+Ips8EJWR2vad49KDXJ4mVbA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kZ1g3snyZ3LQAU3tYEXX8g5S2RtOqWyjadnWgDr1eLXcqjvERxmU5v8CJ5QZbC1q3
         Q2sMILTQlK7b1hl/DBbTwIRfeLyJOzXkWbTpZzIOFxIzRaJGz2r3YRrJPDWEe0zfEQ
         WKHJiRkbDTCBk5JoHbcKz4Bthbm4jkHwBTIQwa+o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15MDvjff084614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jun 2021 08:57:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 22
 Jun 2021 08:57:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 22 Jun 2021 08:57:45 -0500
Received: from [10.250.232.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15MDvcFU052190;
        Tue, 22 Jun 2021 08:57:41 -0500
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linus.walleij@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali> <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
 <18a104a9-2cb8-7535-a5b2-f5f049adff47@lucaceresoli.net>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4d4c0d4d-41b4-4756-5189-bffa15f88406@ti.com>
Date:   Tue, 22 Jun 2021 19:27:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <18a104a9-2cb8-7535-a5b2-f5f049adff47@lucaceresoli.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Luca, Pali,

On 22/06/21 7:01 pm, Luca Ceresoli wrote:
> Hi,
> 
> On 22/06/21 14:16, Pali Rohár wrote:
>> On Tuesday 22 June 2021 12:56:04 Lorenzo Pieralisi wrote:
>>> [Adding Linus for GPIO discussion, thread:
>>> https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net]
>>>
>>> On Tue, Jun 22, 2021 at 01:06:27PM +0200, Pali Rohár wrote:
>>>> Hello!
>>>>
>>>> On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
>>>>> Nothing happened after a few weeks... I understand that knowing the
>>>>> correct reset timings is relevant, but unfortunately I cannot help much
>>>>> in finding out the correct values.
>>>>>
>>>>> However I'm wondering what should happen to this patch. It *does* fix a
>>>>> real bug, but potentially with an incorrect or non-optimal usleep range.
>>>>> Do we really want to ignore a bugfix because we are not sure about how
>>>>> long this delay should be?
>>>>
>>>> As there is no better solution right now, I'm fine with your patch. But
>>>> patch needs to be approved by Lorenzo, so please wait for his final
>>>> answer.
>>>
>>> I am not a GPIO expert and I have a feeling this is platform specific
>>> beyond what the PCI specification can actually define architecturally.
>>
>> In my opinion timeout is not platform specific as I wrote in email:
>> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
>>
>> My experiments already proved that some PCIe cards needs to be in reset
>> state for some minimal time otherwise they cannot be enumerated. And it
>> does not matter to which platform you connect those (endpoint) cards.
>>
>> I do not think that timeout itself is platform specific. GPIO controls
>> PERST# pin and therefore specified sleep value directly drives how long
>> is card on the other end of PCIe slot in Warm Reset state. PCIe CEM spec
>> directly says that PERST# signal controls PCIe Warm Reset.
>>
>> What is here platform specific thing is that PERST# signal is controlled
>> by GPIO. But value of signal (high / low) and how long is in signal in
>> which state for me sounds like not an platform specific thing, but as
>> PCIe / CEM related.
> 
> That's exactly my understanding of this matter. At least for the dra7xx
> controller it works exactly like this, PERSTn# is nothing but a GPIO
> output from the SoC that drives the PERSTn# input of the external chip
> without affecting the controller directly.
> 

While the patch itself is correct, this kind-of changes the behavior on
already upstreamed platforms. Previously the driver expected #PERST to
be asserted be external means (or default power-up state) and only takes
care of de-asserting the #PERST line.

There are 2 platforms that will be impacted due to this change
1) arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi (has an inverter on
GPIO line)
2) arch/arm/boot/dts/am571x-idk.dts (directly connected to #PERST)

For 1), gpiod_set_value(reset, 0) will assert the PERST line due to the
inverter (and GPIO_ACTIVE_LOW)
For 2), gpiod_set_value(reset, 0) will assert the PERST line because we
have GPIO_ACTIVE_HIGH

So this patch should have to be accompanied with DT changes (and this
patch also breaks old DT compatibility).

Thanks
Kishon
