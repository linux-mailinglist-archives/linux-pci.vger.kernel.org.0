Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D589381643
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 08:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEOGYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 02:24:12 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55971 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhEOGYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 02:24:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EB666196D;
        Sat, 15 May 2021 02:22:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 15 May 2021 02:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=E
        5fBYE14mXOiN3y6tENPoQIlOvJknUCMX7Z6yEALJBA=; b=GQDDet/XUzhPHyw27
        IhEaUfLm1kudzIFpcFyYQRDy9+dSk/tqc+M++/eVDacfqzJd3xRMaf1uuJt3WE2D
        8F+zGQEQ37uvuaJzLn/8wrwIpyMVlS0MDvFtsX3j29nOzZWgL0dBBEZoNoZUoWr9
        AU9oj75OLMO1CEQdKEPlWZE3SeQmzrDawHzUJBbig7gZhtAEtiBDnQazohBcKB4i
        NgpORaoKBrndaNlRBye+c1myolZSFtgavgvWib/UViohkOjBffk4/InYpVvywP44
        to2gJTixYCibMd3lU8TjeJwiX6KoQsqEKuMNPAcZwwAzMTKSCz2LTBb0vNbYlguc
        gBnKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=E5fBYE14mXOiN3y6tENPoQIlOvJknUCMX7Z6yEALJ
        BA=; b=mJEl0l4CJTnEF9X5xwntrdurmGQvnBLslV+3KcJlwKydfF86a4A0ss7Ai
        f6WlrffgIymdaGW0jDEgjkJAFQbmFpQJcw4BTVJRTim38veSqAH7zQ8GNO156jpj
        ivIcHG2/aOCHFmXRuytV8B8PCL0+xRUCPgdO5ON2bECkA2WkwpQrKJsXL7McwmtJ
        c8VJjd9Kz3KM67l23y6roXfPrX4ZfS+AL3hjWiwG0/xNeUq8rfLGL4lObhYVowsA
        RqUuKf6NMW3z79dVZ07ovxTizZeURG4ENqr1IRAElUZ+M7xxkqeuCo9vLWCNEmTJ
        shJXX1BQSh0KQgoKvahvQCIHERVFQ==
X-ME-Sender: <xms:wWifYLFx51PLWjXKYbxUKdfTBBCuN-szOiTa_Qjwmqc5Yrbjd5W9gQ>
    <xme:wWifYIWK0j5VKJmNELgyLAWBi9LlE5WUNWNQDyrJL-r-uUuD0vq6gUNuKeQMZDCYy
    kCCablvtlcZ2jjxSC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihunhcu
    jggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrf
    grthhtvghrnhepiefhgffhieekudegjeevgfffveegveegheffhfduieeiffffveffueeg
    veefgfefnecukfhppedukeefrdduheeirdefledrledtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihg
    ohgrthdrtghomh
X-ME-Proxy: <xmx:wWifYNLQFOhfXMEeuWJG9eX6NiXHty9lKneHpNlT8QNexmobbM0dbA>
    <xmx:wWifYJEB9WZYexYQxzjzAmCgCIfH_M56Z4DzVwKGYKOcltL3DHOK9w>
    <xmx:wWifYBW1qWHwY9tx3Ri2dGki_wyo4Sl90jjMuoWCdMYEhaTdgEbewg>
    <xmx:wmifYEQfVXKUp2ftUWAwygrIDpnk0TziOg1RToyRXBVWgnOw0WRl2w>
Received: from [192.168.1.200] (unknown [183.156.39.90])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sat, 15 May 2021 02:22:55 -0400 (EDT)
Subject: Re: [PATCH 3/5] PCI: Improve the mrrs quirk for LS7A
To:     Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>, huangshuai@loongson.cn
References: <20210514080025.1828197-4-chenhuacai@loongson.cn>
 <20210514153959.GA2762101@bjorn-Precision-5520>
 <CAAhV-H4cH40d++SQ+sNXtjh_arC1ASPfRCdLsGtBoTnTWwB6aQ@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <41a47822-8aed-917a-ec6a-e37be5ff2f35@flygoat.com>
Date:   Sat, 15 May 2021 14:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4cH40d++SQ+sNXtjh_arC1ASPfRCdLsGtBoTnTWwB6aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/5/15 11:49, Huacai Chen 写道:
> Hi, Krzysztof and Bjorn
>
> I will improve my spelling, and others see below.
>
> On Fri, May 14, 2021 at 11:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Fri, May 14, 2021 at 04:00:23PM +0800, Huacai Chen wrote:
>>> In new revision of LS7A, some pcie ports support larger value than 256,
>>> but their mrrs values are not dectectable. And moreover, the current
>>> loongson_mrrs_quirk() cannot avoid devices increasing its mrrs after
>>> pci_enable_device(). So the only possible way is configure mrrs of all
>>> devices in BIOS, and add a pci dev flag (PCI_DEV_FLAGS_NO_INCREASE_MRRS)
>>> to stop the increasing mrrs operations.
>> s/mrrs/MRRS/
>> s/dectectable/detectable/
>>
>> This doesn't make sense to me.  MRRS "sets the maximum Read Request
>> size for the Function as a Requester" (PCIe r5.0, sec 7.5.3.4).
>>
>> The MRRS in the Device Control register is a 3-bit RW field (or a RO
>> field with value 000b).  If it's RW, software is allowed to write any
>> 3-bit value to it.  There is no "maximum allowed value" for software
>> to detect.
>>
>> The value software writes is only a *limit* on the Read Request size.
>> The hardware is never obligated to generate Read Requests of that max
>> size.  If software writes 101b (4096 byte max size), and the hardware
>> only supports generating 128-byte Read Requests, there's no issue.
>> It's perfectly fine for the hardware to generate 128-byte requests.
>>
>> Apparently something bad happens if software writes something "too
>> large" to MRRS?  What actually happens?
>>
>> If the problem is that the device generates a large Read Request and
>> in response, it receives a data TLP that is larger than it can handle,
>> that sounds like an MPS issue, not an MRRS issue.
>>
>> Based on the existing loongson_mrrs_quirk(), it looks like this is a
>> long-standing issue.  I'm sorry I missed this when reviewing the
>> driver in the first place.  This all needs a much better explanation
>> of what the real problem is.  The "h/w limitation of 256 bytes maximum
>> read request size" comment just doesn't make sense from the spec point
>> of view.
>>
>> I do know that Linux uses MRRS and MPS in ... highly unusual ways, and
>> maybe we're tripping over that somehow.  If so, we need to figure out
>> exactly how so we can make Linux's use of MPS and MRRS better overall.
> I have discussed with Shuai Huang (the main designer of LS7A), he said
> that some devices (such as Realtek 8169) usually write a large value
> to MRRS in its driver. And that usually larger than LS7A bridge can
> handle, the quirk in this patch is avoid device driver to increase
> MRRS (and BIOS initialize a reasonable value at power on stage).

Based on my experiments on LS2K which have a similar issue, I guess the
problem is Loongson's AXI bus failed to accept reading burst larger then
certain size.

The larger MRRS is legal for PCIe controller but not for upstream bus.
So when you write the value to MRRS register the controller will still
generate oversized TLP and then send illegal response to AXI bus. Thus
we need to limit MRRS in software to avoid such situation.

I'm not a loongson employee so it might be wrong.

Thanks.

- Jiaxun

>
> Huacai
>
