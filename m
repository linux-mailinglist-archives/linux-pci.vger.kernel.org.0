Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5C100BA7
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKRSm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 13:42:57 -0500
Received: from foss.arm.com ([217.140.110.172]:38618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfKRSm5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 13:42:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DFAB1FB;
        Mon, 18 Nov 2019 10:42:57 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05C363F703;
        Mon, 18 Nov 2019 10:42:55 -0800 (PST)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Marek Vasut <marek.vasut@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
 <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
 <fef9502f-d51c-b922-afb3-8891267ae6c3@gmail.com>
 <20191026203627.GA47056@e119886-lin.cambridge.arm.com>
 <9c46a2d2-00bd-3854-8060-fc7389751f3f@gmail.com>
 <20191107141906.GB43905@e119886-lin.cambridge.arm.com>
 <3424b83c-4693-0259-ac3d-ea10a3f98377@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <82c69634-ffb5-0b20-2254-55e5cfbef035@arm.com>
Date:   Mon, 18 Nov 2019 18:42:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3424b83c-4693-0259-ac3d-ea10a3f98377@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/11/2019 3:48 pm, Marek Vasut wrote:
> On 11/7/19 3:19 PM, Andrew Murray wrote:
>> On Thu, Nov 07, 2019 at 12:37:44AM +0100, Marek Vasut wrote:
>>> On 10/26/19 10:36 PM, Andrew Murray wrote:
>>> [...]>> But this still leaves me with one open question -- how do I
>>> figure out
>>>>> what to program into the PCI controller inbound windows, so that the
>>>>> controller correctly filters inbound transfers which are targetting
>>>>> nonexisting memory ?
>>>>
>>>> Your driver should program into the RC->CPU windows, the exact ranges
>>>> described in the dma-ranges. Whilst also respecting the alignment and
>>>> max-size rules your controller has (e.g. the existing upstream logic
>>>> and also the new logic that recalculates the alignment per entry).
>>>>
>>>> As far as I can tell from looking at your U-Boot patch, I think I'd expect
>>>> a single dma-range to be presented in the DT, that describes
>>>> 0:0xFFFFFFFF => 0:0xFFFFFFFF. This is because 1) I understand your
>>>> controller is limited to 32 bits. And 2) there is a linear mapping between
>>>> PCI and CPU addresses (given that the second and third arguments on
>>>> pci_set_region are both the same).
>>>>
>>>> As you point out, this range includes lots of things that you don't
>>>> want the RC to touch - such as non-existent memory. This is OK, when
>>>> Linux programs addresses into the various EP's for them to DMA to host
>>>> memory, it uses its own logic to select addresses that are in RAM, the
>>>> purpose of the dma-range is to describe what the CPU RAM address looks
>>>> like from the perspective of the RC (for example if the RC was wired
>>>> with an offset such that made memory writes from the RC made to
>>>> 0x00000000 end up on the system map at 0x80000000, we need to tell Linux
>>>> about this offset. Otherwise when a EP device driver programs a DMA
>>>> address of a RAM buffer at 0x90000000, it'll end up targetting
>>>> 0x110000000. Thankfully our dma-range will tell Linux to apply an offset
>>>> such that the actual address written to the EP is 0x10000000.).
>>>
>>> I understand that Linux programs the endpoints correctly. However this
>>> still doesn't prevent the endpoint from being broken and from sending a
>>> transaction to that non-existent memory.
>>
>> Correct.
>>
>>> The PCI controller can prevent
>>> that and in an automotive SoC, I would very much like the PCI controller
>>> to do just that, rather than hope that the endpoint would always work.
>>
>> OK I understand - At least when working on the assumption that your RC will
>> block RC->CPU transactions that are not described in any of it's windows.
>> Thus you want to use the dma-ranges as a means to configure your controller
>> to do this.
> 
> Yes
> 
>> What actually happens if you have a broken endpoint that reads/writes to
>> non-existent memory on this hardware? Ideally the RC would generate a
>> CA or UR back to the endpoint - does something else happen? Lockup, dead RC,
>> performance issues?
> 
> The behavior is undefined.
> 
>> Using built-in features of the RC to prevent it from sending transactions
>> to non-existent addresses is clearly helpful. But of course it doesn't stop
>> a broken EP from writing to existent addresses, so only provides limited
>> protection.
> 
> Correct.
> 
>> Despite the good intentions here, it doesn't seem like dma-ranges is
>> designed for this purpose and as the hardware has limited ranges it will
>> only be best-effort.
> So what other options do we have ?

If you really want to sacrifice DMA efficiency for a perceived increase 
in theoretical robustness by setting very conservative windows, then 
ultimately it's your choice, go ahead. It's just that you *need* to make 
that choice in the bootloader, not in Linux. If Linux gets passed 
dma-ranges that aren't actually reflected by the hardware, such that 
this patch is needed, then it *will* go wrong eventually, and you'll 
only get an "I told you so" from me.

The bootloader knows what platform it's running on, so it has no excuse 
for emitting more ranges than there are available windows on that platform.

Robin.
