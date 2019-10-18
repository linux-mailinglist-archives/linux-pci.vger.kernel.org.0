Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC7DC57F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbfJRMxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 08:53:50 -0400
Received: from [217.140.110.172] ([217.140.110.172]:38358 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfJRMxu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 08:53:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF453BB;
        Fri, 18 Oct 2019 05:53:30 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16CAA3F6C4;
        Fri, 18 Oct 2019 05:53:28 -0700 (PDT)
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ce7d16ab-31b8-0992-b1d7-24f4a652ce5f@arm.com>
Date:   Fri, 18 Oct 2019 13:53:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fd53f532-9b78-a64e-6d34-bda5a7639586@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/10/2019 13:22, Marek Vasut wrote:
> On 10/18/19 11:53 AM, Lorenzo Pieralisi wrote:
>> On Thu, Oct 17, 2019 at 05:01:26PM +0200, Marek Vasut wrote:
>>
>> [...]
>>
>>>> Again, just handling the first N dma-ranges entries and ignoring the
>>>> rest is not 'configure the controller correctly'.
>>>
>>> It's the best effort thing to do. It's well possible the next generation
>>> of the controller will have more windows, so could accommodate the whole
>>> list of ranges.

In the context of DT describing the platform that doesn't make any 
sense. It's like saying it's fine for U-Boot to also describe a bunch of 
non-existent CPUs just because future SoCs might have them. Just because 
the system would probably still boot doesn't mean it's right.

>>> Thinking about this further, this patch should be OK either way, if
>>> there is a DT which defines more DMA ranges than the controller can
>>> handle, handling some is better than failing outright -- a PCI which
>>> works with a subset of memory is better than PCI that does not work at all.
>>
>> OK to sum it up, this patch is there to deal with u-boot adding multiple
>> dma-ranges to DT.
> 
> Yes, this patch was posted over two months ago, about the same time this
> functionality was posted for inclusion in U-Boot. It made it into recent
> U-Boot release, but there was no feedback on the Linux patch until recently.
> 
> U-Boot can be changed for the next release, assuming we agree on how it
> should behave.
> 
>> I still do not understand the benefit given that for
>> DMA masks they are useless as Rob pointed out and ditto for inbound
>> windows programming (given that AFAICS the PCI controller filters out
>> any transaction that does not fall within its inbound windows by default
>> so adding dma-ranges has the net effect of widening the DMA'able address
>> space rather than limiting it).
>>
>> In short, what's the benefit of adding more dma-ranges regions to the
>> DT (and consequently handling them in the kernel) ?
> 
> The benefit is programming the controller inbound windows correctly.
> But if there is a better way to do that, I am open to implement that.
> Are there any suggestions / examples of that ?

The crucial thing is that once we improve the existing "dma-ranges" 
handling in the DMA layer such that it *does* consider multiple entries 
properly, platforms presenting ranges which don't actually exist will 
almost certainly start going wrong, and are either going to have to fix 
their broken bootloaders or try to make a case for platform-specific 
workarounds in core code.

Robin.

> However, I think the discussion strayed quite far away from the real
> goal of this patch. This patch only handles the case where there are too
> many dma-ranges in the DT which cannot all be programmed into the
> controller. Instead of failing, the patch allows the controller to work
> with smaller range and reports that in the log, which I think is better
> than outright failing.
> 
> [...]
> 
