Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB265DADD4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394185AbfJQNGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 09:06:44 -0400
Received: from [217.140.110.172] ([217.140.110.172]:42638 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfJQNGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 09:06:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFBA81993;
        Thu, 17 Oct 2019 06:06:23 -0700 (PDT)
Received: from [10.1.197.57] (unknown [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB1C83F6C4;
        Thu, 17 Oct 2019 06:06:22 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
 <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com>
 <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com>
 <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com>
 <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
 <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
 <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
 <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
Date:   Thu, 17 Oct 2019 14:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/10/2019 11:55, Marek Vasut wrote:
> On 10/17/19 9:06 AM, Geert Uytterhoeven wrote:
> 
> [...]
> 
>>>>>> I suppose if your intent is to use inbound windows as a poor man's
>>>>>> IOMMU to prevent accesses to the holes, then yes you would list them
>>>>>> out. But I think that's wrong and difficult to maintain. You'd also
>>>>>> need to deal with reserved-memory regions too.
>>>>>
>>>>> What's the problem with that? The bootloader has all that information
>>>>> and can patch the DT correctly. In fact, in my specific case, I have
>>>>> platform which can be populated with differently sized DRAM, so the
>>>>> holes are also dynamically calculated ; there is no one DT then, the
>>>>> bootloader is responsible to generate the dma-ranges accordingly.
>>>>
>>>> The problems are it doesn't work:
>>>>
>>>> Your dma-mask and offset are not going to be correct.
>>>>
>>>> You are running out of inbound windows. Your patch does nothing to
>>>> solve that. The solution would be merging multiple dma-ranges entries
>>>> to a single inbound window. We'd have to do that both for dma-mask and
>>>> inbound windows. The former would also have to figure out which
>>>> entries apply to setting up dma-mask. I'm simply suggesting just do
>>>> that up front and avoid any pointless splits.
>>>
>>> But then the PCI device can trigger a transaction to non-existent DRAM
>>> and cause undefined behavior. Surely we do not want that ?
>>
>> The PCI device will trigger transactions to memory only when instructed
>> to do so by Linux, right?  Hence if Linux takes into account chosen/memory
>> and dma-ranges, there is no problem?
> 
> Unless of course the remote device initiates a transfer. And if the
> controller is programmed such that accesses to the missing DRAM in the
> holes are not filtered out by the controller, then the controller will
> gladly let the transaction through. Do we really want to let this happen ?

If you've got devices making random unsolicited accesses then who's to 
say they wouldn't also hit valid windows and corrupt memory? If it's 
happening at all you've already lost. And realistically, if the address 
isn't valid then it's not going to make much difference anyway - in 
probably 99% of cases, either the transaction doesn't hit a window and 
the host bridge returns a completer abort, or it does hit a window, the 
AXI side returns DECERR or SLVERR, and the host bridge translates that 
into a completer abort. Consider also that many PCI IPs don't have 
discrete windows and just map the entirety of PCI mem space directly to 
the system PA space.

I don't believe this is a valid argument for anything whichever way round.

Robin.
