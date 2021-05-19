Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB538851D
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 05:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhESDGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 23:06:54 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47755 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237253AbhESDGy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 23:06:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A21A31714;
        Tue, 18 May 2021 23:05:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 18 May 2021 23:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=T
        BZbIeiXei48R2ujZlKNovHhDr0fOQIvpPQ4YZ4PyCI=; b=WNV25eFhdJOZLe7Xf
        UNh6vUtdjgazMlEBBi6WonPwlx5Yvm5QHBBopB1OQCkCNAZFo5yF0gH12O/38SjZ
        CqKJb4PDvXEESQ4LKq99v8Pb1gaqARVsSzSVS4jnL7lOsRE35kdDsbDES+kd+cCv
        LH8Yn91qTmXbES2fSeVbGnY8IfKOu37qxMeASCX7bs8hGgQXRUUf+aCDfxpsbfO8
        MOoUxDGMDdQVcfw7XOju60MGxAt7Hmn6ZIT/3mA1FH9SN3xPMPWj+UJg0vgGuM3Z
        r+bigHTwXpUZUdLCRr3Fzbv61mOIIVYScFbQ1Pc4ZH9gbB9KD51McX/Izj1clkA7
        Xh51w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=TBZbIeiXei48R2ujZlKNovHhDr0fOQIvpPQ4YZ4Py
        CI=; b=Y577nCH5Q8XImRA2Hg0E3kF0FgPGcktyhKGX/eyxgeqPYJdZ5aOtMAkKh
        1t5TgTNSmXYabIo4MZcLuaVGQLIwzYKNJX2J7R/6++3ecgNqyMcvy6x6wmVzoCsr
        U33Dr4Xw8SPHifFzNpfxcXy1Dw6ySM2OvEbzQximMRZ7SqHk8UpuWmwfhA3z1PFh
        nfXHZN/0U5EPFxuclDwQlqv/NXr0SCaYfl2RgOxQ4wuMrUwF7WUzdg3OiXm+mU6n
        /9R89joP5nNEn9aZwP1ADLHpWbPmejcO+g6jeA7S0WfsF/jF0GGhP6XZiMjWlzzI
        UBmmj1UjPh0sdjaydIwORwOZ/kwUA==
X-ME-Sender: <xms:eoCkYKYhTwakHMAFnjxjniNFTy4XGub9w1rqbsiBkbwLUD1Re0J_RQ>
    <xme:eoCkYNaT6gh0J2cjQWlc_1s6VTRhfxntY3cPvWF7k-ABbe6Dbt1HLqJ8tv-Ws5fJ2
    -2c7xEfEwFRRRWgGek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeikedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtudffieefhffhiedujeehhfelgfeihfduueehjeehhfdvudev
    hffhgfeijeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedutddurd
    ekgedrudejtddrheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:eoCkYE-OW2HI-sms-uq7FGNzykrEx0E1MmguXhFTrYtHVcdMNaw4qA>
    <xmx:eoCkYMr9ja2W8Dyl8m0JvygMLTzS7odsr673ElR_0fN0kiDt2cqkLA>
    <xmx:eoCkYFpP9NVTrdLGIMVq3iV540qtSabt8suPHX1jtksIgD8ec7y0yA>
    <xmx:e4CkYGnccEeAUSok4ryHPiQxdGceoeGAIp147zHuyDYkZl0Fmx7fXA>
Received: from [192.168.22.245] (unknown [101.84.170.55])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 23:05:27 -0400 (EDT)
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
To:     Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>
References: <CAAhV-H61Uc5D7+1pMR5xSJeBVXHwPttTtaPg6_gwJoYBywHjPA@mail.gmail.com>
 <20210518135925.GA116106@bjorn-Precision-5520>
 <CAAhV-H7DfZffubU_rxoMXdbk_j9p0LwA5S7wF7qvAPOJn=YEdw@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <933330cb-9d86-2b22-9bed-64becefbe2d1@flygoat.com>
Date:   Wed, 19 May 2021 11:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7DfZffubU_rxoMXdbk_j9p0LwA5S7wF7qvAPOJn=YEdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/5/19 10:26, Huacai Chen 写道:
> Hi, Bjorn,
>
> On Tue, May 18, 2021 at 9:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Rob, beginning of thread
>> https://lore.kernel.org/r/20210514080025.1828197-5-chenhuacai@loongson.cn]
>>
>> On Sat, May 15, 2021 at 11:52:53AM +0800, Huacai Chen wrote:
>>> On Fri, May 14, 2021 at 10:52 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>>> 在 2021/5/14 16:00, Huacai Chen 写道:
>>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
>>>>>
>>>>> In LS7A, multifunction device use same pci PIN and different
>>>>> irq for different function, so fix it for standard pci PIN
>>>>> usage.
>>>> Hmm, I'm unsure about this change.
>>>> The PCIe port, or PCI-to-PCI bridge on LS7A only have a single
>>>> upstream interrupt specified in DeviceTree, how can this quirk
>>>> work?
>>> LS7A will be shared by MIPS-based Loongson and LoongArch-based
>>> Loongson, LoongArch use ACPI rather than FDT, so this quirk is needed.
>> Can you expand on this a little bit?
>>
>> Which DT binding are you referring to?  Is it in the Linux source
>> tree?
> I referring to arch/mips/boot/dts/loongson/ls7a-pch.dtsi, it is
> already in Linux source tree.
>
>> I think Linux reads Interrupt Pin for both FDT and ACPI systems, and
>> apparently that register contains the same value for all functions of
>> this multi-function device.
>>
>> The quirk will be applied for both FDT and ACPI systems, but it sounds
>> like you're saying this is needed *because* LoongArch uses ACPI.
> Jiaxun said that FDT system doesn't need this quirk, maybe he know more.

For FDT system, the IRQ routine of PCI ports looks like:

                 interrupt-map-mask = <0 0 0 0>;
                 interrupt-map = <0 0 0 0 &pic 41 IRQ_TYPE_LEVEL_HIGH>;

It means they are all going to the same parent IRQ no matter what we read
from pin register. And it's the actual hardware behavior AFAIK.

Thanks.

- Jiaxun

>
> Huacai
>> Bjorn

