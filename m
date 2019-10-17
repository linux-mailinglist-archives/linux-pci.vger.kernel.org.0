Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4FDAEF0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437366AbfJQOAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 10:00:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40751 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437275AbfJQOAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 10:00:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so2653638wmj.5;
        Thu, 17 Oct 2019 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ho9hHtEoiD9z6LT1AaMW0OmfFWET0fxL0uTws2EXWjQ=;
        b=kErgLvLhHRktTMtS+eHbAIQIdS7k9ZWfrceiJIvnEjKXQtAc7HKT1Yq5CWT+Pvey51
         ar2hIF9A4vkWIDQzBsV8JCLt0jINOCJlo8AiU8LkCYeIKSF150vfML29yaNGXtewy/JZ
         gll/8QGpO7tPpg8zBC9jYhH0786DiCCrabZWFJ5SalV9WvKXT7b39Lwe7iiOUpJHmqxX
         S+2wy/a83IS6ahUwBuZPEFogq+oWfJ5mQWGh+4XEGfUy9mFDvM+W5Br7t9e0aLZn355X
         jDuyzfrr/XPRROj4y1ilJevgVANOGemfiyixhKU4UZp7s6Ny3JC9PNVfNxm6VzsArTvv
         unmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ho9hHtEoiD9z6LT1AaMW0OmfFWET0fxL0uTws2EXWjQ=;
        b=clX6uo2rA8HYmRNpwEg7C34NqZx+HRxVMkqiJxxUHuFHwl8TcwWx8pCWqVe93aFW4L
         mGpPU9SI0UUop0gjQMkbmkv/BEqDOzQv1z3i4kBQ06EUqfaa22DOmgFlvsiS4EgvZz4b
         eZXempqKIbQ/Tr/Jdy72YwIOo8DytNbkuJlrImFFBOxrSOvPCCMBDt7o/75Pn55t0nT0
         c3tGSX/U+R3ITXkwtguX7cbmIp9A72xw4SOkcBzonFgAK/ybqK/t4FQ24lXRFiDE57qw
         HnUNHhmYpf+hhvRdGsvGTYtveO1rsUxbsRXlrQLbjUSUFIVi0gu0rJAE2uMMfNou7j7r
         9/mQ==
X-Gm-Message-State: APjAAAW9HLyTglF4ZZT4XeMb7ZrFSu49n7dahgpPBCcJYElWgGlbHbth
        wCSDlHsU5XFqOZfSewLx6GVH58ff
X-Google-Smtp-Source: APXvYqwpsm5tjoaUumTd5mK/xxgwcOCR3HgqvuMXb4xu6XunKiv/jZe6HB9RwVpYe1KZX4d53143Mw==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr2996195wmh.54.1571320811671;
        Thu, 17 Oct 2019 07:00:11 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id l11sm2319389wmh.34.2019.10.17.07.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 07:00:11 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Robin Murphy <robin.murphy@arm.com>,
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
 <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com>
Date:   Thu, 17 Oct 2019 16:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/17/19 3:06 PM, Robin Murphy wrote:
> On 17/10/2019 11:55, Marek Vasut wrote:
>> On 10/17/19 9:06 AM, Geert Uytterhoeven wrote:
>>
>> [...]
>>
>>>>>>> I suppose if your intent is to use inbound windows as a poor man's
>>>>>>> IOMMU to prevent accesses to the holes, then yes you would list them
>>>>>>> out. But I think that's wrong and difficult to maintain. You'd also
>>>>>>> need to deal with reserved-memory regions too.
>>>>>>
>>>>>> What's the problem with that? The bootloader has all that information
>>>>>> and can patch the DT correctly. In fact, in my specific case, I have
>>>>>> platform which can be populated with differently sized DRAM, so the
>>>>>> holes are also dynamically calculated ; there is no one DT then, the
>>>>>> bootloader is responsible to generate the dma-ranges accordingly.
>>>>>
>>>>> The problems are it doesn't work:
>>>>>
>>>>> Your dma-mask and offset are not going to be correct.
>>>>>
>>>>> You are running out of inbound windows. Your patch does nothing to
>>>>> solve that. The solution would be merging multiple dma-ranges entries
>>>>> to a single inbound window. We'd have to do that both for dma-mask and
>>>>> inbound windows. The former would also have to figure out which
>>>>> entries apply to setting up dma-mask. I'm simply suggesting just do
>>>>> that up front and avoid any pointless splits.
>>>>
>>>> But then the PCI device can trigger a transaction to non-existent DRAM
>>>> and cause undefined behavior. Surely we do not want that ?
>>>
>>> The PCI device will trigger transactions to memory only when instructed
>>> to do so by Linux, right?  Hence if Linux takes into account
>>> chosen/memory
>>> and dma-ranges, there is no problem?
>>
>> Unless of course the remote device initiates a transfer. And if the
>> controller is programmed such that accesses to the missing DRAM in the
>> holes are not filtered out by the controller, then the controller will
>> gladly let the transaction through. Do we really want to let this
>> happen ?
> 
> If you've got devices making random unsolicited accesses then who's to
> say they wouldn't also hit valid windows and corrupt memory? If it's
> happening at all you've already lost.

Not necessarily. If your controller is programmed correctly with just
the ranges that are valid, then it will filter out at least the accesses
outside of valid memory. If it is programmed incorrectly, as you
suggest, then the accesses will go through, causing undefined behavior.

And note that there is such weird buggy PCI hardware. A slightly
unrelated example are some of the ath9k, which are generating spurious
MSIs even if they are in legacy PCI IRQ mode. If the controller is
configured correctly, even those buggy cards work, because it can filter
the spurious MSIs out. If not, they do not.

That's why I would prefer to configure the controller correctly, not
just hope that nothing bad will come out of misconfiguring it slightly.

> And realistically, if the address
> isn't valid then it's not going to make much difference anyway - in
> probably 99% of cases, either the transaction doesn't hit a window and
> the host bridge returns a completer abort, or it does hit a window, the
> AXI side returns DECERR or SLVERR, and the host bridge translates that
> into a completer abort. Consider also that many PCI IPs don't have
> discrete windows and just map the entirety of PCI mem space directly to
> the system PA space.

And in that 1% of cases, we are OK with failure which could have been
easily prevented if the controller was programmed correctly ? That does
not look like a good thing.

> I don't believe this is a valid argument for anything whichever way round.
-- 
Best regards,
Marek Vasut
