Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521CA1023F4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 13:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKSMK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 07:10:56 -0500
Received: from foss.arm.com ([217.140.110.172]:51632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfKSMK4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 07:10:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59DEE1FB;
        Tue, 19 Nov 2019 04:10:55 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE7E03F703;
        Tue, 19 Nov 2019 04:10:53 -0800 (PST)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
References: <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
 <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
 <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
 <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com>
 <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
 <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com>
 <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
 <5a19fcd3-2071-334a-1c4a-59d07f4a387d@gmail.com>
 <20191018095345.GD25918@e121166-lin.cambridge.arm.com>
 <fd53f532-9b78-a64e-6d34-bda5a7639586@gmail.com>
 <ce7d16ab-31b8-0992-b1d7-24f4a652ce5f@arm.com>
 <3f2f3868-676c-edc4-0de1-d42b63186128@gmail.com>
 <931e7132-b680-3e9a-bb1e-af05811907fc@arm.com>
 <32591ef7-9792-4874-512c-ce3bcc3e9998@gmail.com>
 <9db05950-cb22-c99d-7544-05e148ef7e1a@arm.com>
 <6ae07b1a-bcfa-e48a-e260-da20d6663afc@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c986fd32-812e-f953-674c-f689139aa0d9@arm.com>
Date:   Tue, 19 Nov 2019 12:10:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6ae07b1a-bcfa-e48a-e260-da20d6663afc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/10/2019 7:44 pm, Marek Vasut wrote:
[...]
>>>> Say you have a single hardware window, and this DT property (1-cell
>>>> numbers for simplicity:
>>>>
>>>>       dma-ranges = <0x00000000 0x00000000 0x80000000>;
>>>>
>>>> Driver reads one entry and programs the window to 2GB@0, DMA setup
>>>> parses the first entry and sets device masks to 0x7fffffff, and
>>>> everything's fine.
>>>>
>>>> Now say we describe the exact same address range this way instead:
>>>>
>>>>       dma-ranges = <0x00000000 0x00000000 0x40000000,
>>>>                 0x40000000 0x40000000 0x40000000>;
>>>>
>>>> Driver reads one entry and programs the window to 1GB@0, DMA setup
>>>> parses the first entry and sets device masks to 0x3fffffff, and *today*,
>>>> things are suboptimal but happen to work.
>>>>
>>>> Now say we finally get round to fixing the of_dma code to properly
>>>> generate DMA masks that actually include all usable address bits, a user
>>>> upgrades their kernel package, and reboots with that same DT...
>>>>
>>>> Driver reads one entry and programs the window to 1GB@0, DMA setup
>>>> parses all entries and sets device masks to 0x7fffffff, devices start
>>>> randomly failing or throwing DMA errors half the time, angry user looks
>>>> at the changelog to find that somebody decided their now-corrupted
>>>> filesystem is less important than the fact that hey, at least the
>>>> machine didn't refuse to boot because the DT was obviously wrong. Are
>>>> you sure that shouldn't be a problem?
>>>
>>> I think you picked a rather special case here and arrived as a DMA mask
>>> which just fails in this special case. Such special case doesn't happen
>>> here, and even if it did, I would expect Linux to merge those two ranges
>>> or do something sane ? If the DMA mask is set incorrectly, that's a bug
>>> of the DMA code I would think.
>>
>> The mask is not set incorrectly - DMA masks represent the number of
>> address bits the device (or intermediate interconnect in the case of the
>> bus mask) is capable of driving. Thus when DMA is limited to a specific
>> address range, the masks should be wide enough to cover the topmost
>> address of that range (unless the device's own capability is inherently
>> narrower).
> 
> Then the mask should be 0x7fffffff in both cases I'd say.

Yes, *that's my whole point*. It *should* be that for both cases, but 
today it works out not to be because the current code is a bit crap.

>>> What DMA mask would you get if those two entries had a gap inbetween
>>> them ? E.g.:
>>>
>>>    dma-ranges = <0x00000000 0x00000000 0x20000000,
>>>                  0x40000000 0x40000000 0x20000000>;

The gap itself is immaterial - the highest address described by those 
ranges is 0x5fffffff, which requires 31 bits to drive, thus the 
appropriate mask would be 0x7fffffff.

>> OK, here's an real non-simplified example
> 
> I would really like an answer to the simple example above before we
> start inventing convoluted ones.

Sigh... I did say "real". However convoluted it may look to you, this 
window configuration was "invented" ~6 years ago when the Arm Juno SoCs 
were first brought up and has been shipping ever since.

>> (note that these windows are fixed and not programmed by Linux):
>>
>>      dma-ranges = <0x02000000 0x0 0x2c1c0000 0x0 0x2c1c0000 0x0 0x00040000>,
>>                   <0x02000000 0x0 0x80000000 0x0 0x80000000 0x0 0x80000000>,
>>                   <0x43000000 0x8 0x80000000 0x8 0x80000000 0x2 0x00000000>;
>>
>> The DMA masks for the devices behind this bridge *should* be 35 bits,
>> because that's the size of the largest usable address. Currently,
>> however, because of the of_dma code's deficiency they would end up being
>> an utterly useless 30 bits, which isn't even enough to reach the start
>> of RAM. Thus I can't actually have this property in my DT, and as a
>> result I can't enable the IOMMU, because *that* also needs to know the
>> ranges in order to reserve the unusable gaps between the windows once
>> address translation is in play.
> 
> How is this related to this particular patch ? This looks more like some
> DMA internal topic.

It's trying to get across the point that "dma-ranges" is consumed by 
multiple separate parts of the kernel, and implicitly relying on the way 
they currently interact is a mistake which will come back to bite you. 
Changing one consumer (your driver) to allow devices to exist despite 
describing unusable DMA ranges might happen to seem OK today due to 
shortcomings in another consumer (the DMA API layer), but once the DMA 
API layer gets improved (necessarily, as above), your changes will cause 
subtle DMA breakage on R-Car systems with more populated DRAM banks than 
available PCI windows, which is arguably even worse than having PCI 
simply refuse to probe in that situation.

Robin.
