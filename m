Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52372DC74C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410221AbfJRO0g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 10:26:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44876 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410093AbfJRO0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 10:26:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so6475263wrl.11;
        Fri, 18 Oct 2019 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yLORsBla+gSK0zkUj6PuSi1/ZMG9BCIPlaUEcTHmQ4k=;
        b=CX0TSAunfvTcEpLzWAwPO9hVdAuCWU7jg4MrcqdAZwNo+ycm+JOa8eQxrKyFX1UMtS
         zLFPqtDL3mK7Pa6gcl1cREtIkhVJVVPjhKYKBE4p2UBL3fHcCb+5dI/h1LtHvYoRYWwA
         lt1tYjFaFe22Nwgv4xN+j+0spxlWqLwre6vrpoyqEHqN4Loq+CzN2Lo8vg505iWykGXq
         0W4vVxz/QXriipI2qjE1Zd5hGfhB1NugC7bZ7u/ctdwrCNi03+c1y8QU9T+CNChqSuho
         aFOTsH90wuTerSIgwkOWVQL3X6eaNncFJgiCf9ivyNhQ2yJxFiDhpR+cY5aNZUS5fJ6o
         Ff0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yLORsBla+gSK0zkUj6PuSi1/ZMG9BCIPlaUEcTHmQ4k=;
        b=BhZP7sTItO3ktXGLvkimDNlNT9VnA1ezZvMO8MrOrgQCJ2sscMf3Jp0+LbtYJCLTce
         SOKCqBM9VtOp4xisGCVQ545E32MGm38SnSQfYkla5f5UFYZ9GTssK7HYMqj15ofsSlvU
         Rit5vMI1BP3JvEciluk4R88VxjbhSsGU6RbUWcZdPZFIZNe1eKclj3OnVo4YwMRXIMe+
         wD9N0SjMTB0OwTfPlybxFUXWhVy6mERmpOxE1hVJWCgzuTa4pWsHWV0dbCOMbtBhhP0H
         xLMlJwM362tZwsnnT1b4k5lOaqTl+HACKzNysL5wGV57LLj7qOW5Lxd3HS8xhyJCcQ0x
         bGlQ==
X-Gm-Message-State: APjAAAXrPCA+eAgaJCkeKxvPjgP4Z0xLjqSrAab60s1/8xISrArUyF7l
        YLrXuiqISbFQhyfkzJ85TDV77RZn
X-Google-Smtp-Source: APXvYqwM9Iyq/nrcXi5NyN04IWzMVYiuI9O8G7S3J34cmCtFpEG3oadL7BjEKpNeie0kUk9IW4IAkg==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr7874741wrp.282.1571408793027;
        Fri, 18 Oct 2019 07:26:33 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id b12sm5566524wrt.21.2019.10.18.07.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:26:31 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Robin Murphy <robin.murphy@arm.com>,
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
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <3f2f3868-676c-edc4-0de1-d42b63186128@gmail.com>
Date:   Fri, 18 Oct 2019 16:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ce7d16ab-31b8-0992-b1d7-24f4a652ce5f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/18/19 2:53 PM, Robin Murphy wrote:
> On 18/10/2019 13:22, Marek Vasut wrote:
>> On 10/18/19 11:53 AM, Lorenzo Pieralisi wrote:
>>> On Thu, Oct 17, 2019 at 05:01:26PM +0200, Marek Vasut wrote:
>>>
>>> [...]
>>>
>>>>> Again, just handling the first N dma-ranges entries and ignoring the
>>>>> rest is not 'configure the controller correctly'.
>>>>
>>>> It's the best effort thing to do. It's well possible the next
>>>> generation
>>>> of the controller will have more windows, so could accommodate the
>>>> whole
>>>> list of ranges.
> 
> In the context of DT describing the platform that doesn't make any
> sense. It's like saying it's fine for U-Boot to also describe a bunch of
> non-existent CPUs just because future SoCs might have them. Just because
> the system would probably still boot doesn't mean it's right.

It's the exact opposite of what you just described -- the last release
of U-Boot currently populates a subset of the DMA ranges, not a
superset. The dma-ranges in the Linux DT currently are a superset of
available DRAM on the platform.

>>>> Thinking about this further, this patch should be OK either way, if
>>>> there is a DT which defines more DMA ranges than the controller can
>>>> handle, handling some is better than failing outright -- a PCI which
>>>> works with a subset of memory is better than PCI that does not work
>>>> at all.
>>>
>>> OK to sum it up, this patch is there to deal with u-boot adding multiple
>>> dma-ranges to DT.
>>
>> Yes, this patch was posted over two months ago, about the same time this
>> functionality was posted for inclusion in U-Boot. It made it into recent
>> U-Boot release, but there was no feedback on the Linux patch until
>> recently.
>>
>> U-Boot can be changed for the next release, assuming we agree on how it
>> should behave.
>>
>>> I still do not understand the benefit given that for
>>> DMA masks they are useless as Rob pointed out and ditto for inbound
>>> windows programming (given that AFAICS the PCI controller filters out
>>> any transaction that does not fall within its inbound windows by default
>>> so adding dma-ranges has the net effect of widening the DMA'able address
>>> space rather than limiting it).
>>>
>>> In short, what's the benefit of adding more dma-ranges regions to the
>>> DT (and consequently handling them in the kernel) ?
>>
>> The benefit is programming the controller inbound windows correctly.
>> But if there is a better way to do that, I am open to implement that.
>> Are there any suggestions / examples of that ?
> 
> The crucial thing is that once we improve the existing "dma-ranges"
> handling in the DMA layer such that it *does* consider multiple entries
> properly, platforms presenting ranges which don't actually exist will
> almost certainly start going wrong, and are either going to have to fix
> their broken bootloaders or try to make a case for platform-specific
> workarounds in core code.
Again, this is exactly the other way around, the dma-ranges populated by
U-Boot cover only existing DRAM. The single dma-range in Linux DT covers
even the holes without existing DRAM.

So even if the Linux dma-ranges handling changes, there should be no
problem.

[...]

-- 
Best regards,
Marek Vasut
