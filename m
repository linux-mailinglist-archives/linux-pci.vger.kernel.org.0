Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCFDB0A5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409420AbfJQPBd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 11:01:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46247 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfJQPBd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 11:01:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so2710750wrv.13;
        Thu, 17 Oct 2019 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rPrR6jLmExayGLjzUJ+1X2I2i+nxJQ6cJru8S2n0YGE=;
        b=XKEY2z+9NUaFx+epe00hL3NEtw2A0m77/3pA5mWSX4B1X1zG4vqgw4tnBvWjuo2SCe
         IB7BnhknNc6gHfOOGn6zwOGRIdN+Z9BlDF8MoO4xpz3Rknt6Ic3gWWKrWMNn2XZmUddg
         96zgCy2kr34oLdicP8oT0nKY+zVOuUq9cJLCy0UrKKTrvUXh4rDT4J7Z8o2j7KFZemE0
         yTvMwJ6LEFc6v/pWvrh9a+9bt1fcgj3h3xY7aid3Gbx9TwhLwvjq7p19P6SmE0I8GBcE
         vQQFdSmbnnTkoh8XWs+wkKXSZ4dLE2f0yomSb3snKt66IKbLMF1E8JVEKTJeC4ak5Dps
         7ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rPrR6jLmExayGLjzUJ+1X2I2i+nxJQ6cJru8S2n0YGE=;
        b=migcLxH01HerDTOtmFnOlAFLYf2RTwjfRE5IQOSDn+zLqCvbm4RtxYUb42gDdp8Qz2
         Xsm0lzLkXUFj5oegtCfPA3PSIfmFhEXjNezlcelr5VvFKQy4XlEgqBI5LkXpPZnxckqh
         jMUSczsQJtu9/Jm2qC5YmJof9VTkBsfYoR3OUQ5Plnd29Z8JXyk8AdQfE1wva1fQyJFN
         +nL+70wmricndWKp7PXvVBEEow0DYh80UTGUTiyocybdM6yygjnPfIDB0McZZ3m9+1xk
         4BuxozzOlivznoUpaDzIrueS20N1y5vhWlpeBnAf2RPR8HjJzKZzHDf2mzyRakziI5Wq
         270g==
X-Gm-Message-State: APjAAAVO4a/kv5BWiAjEkYYd2eGGbxUcCZDFNDYK8klNKQohyFmy1pJT
        Ze5B03nb9CaxcGAWCDd9+TKsHSWg
X-Google-Smtp-Source: APXvYqxgirmv6RHXW2ZaXtoOFIbaujB6C4m9d5azJuRjAboLzesmBwnqshGT8rlvyaNzechziWxwBw==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr3310654wrp.391.1571324488434;
        Thu, 17 Oct 2019 08:01:28 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id a9sm3252107wmf.14.2019.10.17.08.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:01:27 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Rob Herring <robh@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
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
 <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com>
 <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5a19fcd3-2071-334a-1c4a-59d07f4a387d@gmail.com>
Date:   Thu, 17 Oct 2019 17:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/17/19 4:36 PM, Rob Herring wrote:
[...]>>>>> The PCI device will trigger transactions to memory only when
instructed
>>>>> to do so by Linux, right?  Hence if Linux takes into account
>>>>> chosen/memory
>>>>> and dma-ranges, there is no problem?
>>>>
>>>> Unless of course the remote device initiates a transfer. And if the
>>>> controller is programmed such that accesses to the missing DRAM in the
>>>> holes are not filtered out by the controller, then the controller will
>>>> gladly let the transaction through. Do we really want to let this
>>>> happen ?
>>>
>>> If you've got devices making random unsolicited accesses then who's to
>>> say they wouldn't also hit valid windows and corrupt memory? If it's
>>> happening at all you've already lost.
>>
>> Not necessarily. If your controller is programmed correctly with just
>> the ranges that are valid, then it will filter out at least the accesses
>> outside of valid memory. If it is programmed incorrectly, as you
>> suggest, then the accesses will go through, causing undefined behavior.
>>
>> And note that there is such weird buggy PCI hardware. A slightly
>> unrelated example are some of the ath9k, which are generating spurious
>> MSIs even if they are in legacy PCI IRQ mode. If the controller is
>> configured correctly, even those buggy cards work, because it can filter
>> the spurious MSIs out. If not, they do not.
> 
> How do those devices work on h/w without inbound window configuration
> or they don't?

With legacy IRQs.

> How do the spurious MSIs only go to invalid addresses and not valid addresses?

They do not, the point was, there is such broken hardware so the
controller should be programmed correctly.

>> That's why I would prefer to configure the controller correctly, not
>> just hope that nothing bad will come out of misconfiguring it slightly.
> 
> Again, just handling the first N dma-ranges entries and ignoring the
> rest is not 'configure the controller correctly'.

It's the best effort thing to do. It's well possible the next generation
of the controller will have more windows, so could accommodate the whole
list of ranges.

Thinking about this further, this patch should be OK either way, if
there is a DT which defines more DMA ranges than the controller can
handle, handling some is better than failing outright -- a PCI which
works with a subset of memory is better than PCI that does not work at all.

>>> And realistically, if the address
>>> isn't valid then it's not going to make much difference anyway - in
>>> probably 99% of cases, either the transaction doesn't hit a window and
>>> the host bridge returns a completer abort, or it does hit a window, the
>>> AXI side returns DECERR or SLVERR, and the host bridge translates that
>>> into a completer abort. Consider also that many PCI IPs don't have
>>> discrete windows and just map the entirety of PCI mem space directly to
>>> the system PA space.
>>
>> And in that 1% of cases, we are OK with failure which could have been
>> easily prevented if the controller was programmed correctly ? That does
>> not look like a good thing.
> 
> You don't need dma-ranges if you want to handle holes in DRAM. Use
> memblock to get this information. Then it will work if you boot using
> UEFI too.

Do you have any further details about this ?

> dma-ranges at the PCI bridge should be restrictions in the PCI bridge,
> not ones somewhere else in the system.

-- 
Best regards,
Marek Vasut
