Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8BDA190
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 00:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390069AbfJPWd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 18:33:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39530 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfJPWd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 18:33:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so437983wml.4;
        Wed, 16 Oct 2019 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fFsy/S+A3JVEIlpIflx8RMvXgAWH5Nfjh6IG5y2cVWk=;
        b=parB/G0bMCysDJtu3dniFiPbNTTUp3w1ShsLl+wkXRmBaBj5/0Ehn81Iw5VDHpZ7rh
         o78gVJTUR9sGBDg1TtIbZAc4ki+8fQ3HOl/0dV8lVhqMU2apYyaxWvM5vjr+kFvwLkTY
         wddULul72mJu7RMiEG+YLZil5QH8cWTELL+oYq548eAI3Hptwhk62GgMN/TJ6QJTbaqn
         qzkT6CY7dwU/eRkOGOAmr57rPO1FuLHi1y4BEjsz+eJ99iNRfU3LQHXsWDVRLlnEZ7EA
         ETi3IqdWWuMZLaTX8pYLDbwD30yCjHghmIeBokJnfuBfoWOo+W4TVpckXnAR/h1tVHOk
         pyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fFsy/S+A3JVEIlpIflx8RMvXgAWH5Nfjh6IG5y2cVWk=;
        b=YELSbDuOfJKLDLxuG7kC3zpdBjiHpcRQfbPvFQGVVOTuZJKbT2xC7uYTp4JfFJEb54
         GHC9fxPVTOw0krGqJeRYhKnedIWWUA1q4stzeeCvdj7e7y6vvgdcezmxxr29MEtV7g9J
         Gmd8Zdozeo8JDg94cAS1VDlU2u3t48dOnjS7zzPF2/hv21LoVvEO1buTgrsz0iQgNE99
         DSV40gwqknmVY2V2vICpq4JM0TgcFWndWIzHhVjVhtyLYBJKIcTUPQsN8aZ4Km32lmWr
         eqtgdJ3B2x1oySEwlSRZqSktVhyk7miPNUF9CwpqhhrCsLF6jjCQoOSiSO6e1zbKU1Me
         t4uw==
X-Gm-Message-State: APjAAAWA32cSpEPGpTvJzN/QDHKGy/ej0wORPRUDQkWbTMnw/22fV6qe
        Vser60PJlXbaOJvVqvdL2tcG1AcM
X-Google-Smtp-Source: APXvYqwYB+xXJw/nVZmkAS3csKlLbno2K233Zl41ctKUgVW8gmoqqLAvtld2iaG6WucktvPrpar+XQ==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr33015wmj.66.1571265206937;
        Wed, 16 Oct 2019 15:33:26 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id u68sm385929wmu.12.2019.10.16.15.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 15:33:26 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
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
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
Date:   Thu, 17 Oct 2019 00:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/17/19 12:26 AM, Rob Herring wrote:
[...]
>>>> You can have multiple non-continuous DRAM banks for example. And an
>>>> entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
>>>> separate dma-ranges entry, right ?
>>>
>>> Not necessarily. We really only want to define the minimum we have to.
>>> The ideal system is no dma-ranges. Is each bank at a different
>>> relative position compared to the CPU's view of the system. That would
>>> seem doubtful for just DRAM banks. Perhaps DRAM and SRAM could change.
>>
>> Is that a question ? Anyway, yes, there is a bit of DRAM below the 32bit
>> boundary and some more above the 32bit boundary. These two banks don't
>> need to be continuous. And then you could add the SRAM into the mix.
> 
> Continuous is irrelevant. My question was in more specific terms is
> (bank1 addr - bank0 addr) different for CPU's view (i.e phys addr) vs.
> PCI host view (i.e. bus addr)? If not, then that is 1 translation and
> 1 dma-ranges entry.

I don't think it's different in that aspect. Except the bus has this
32bit limitation, where it only sees subset of the DRAM.

Why should the DMA ranges incorrectly cover also the DRAM which is not
present ?

>>> I suppose if your intent is to use inbound windows as a poor man's
>>> IOMMU to prevent accesses to the holes, then yes you would list them
>>> out. But I think that's wrong and difficult to maintain. You'd also
>>> need to deal with reserved-memory regions too.
>>
>> What's the problem with that? The bootloader has all that information
>> and can patch the DT correctly. In fact, in my specific case, I have
>> platform which can be populated with differently sized DRAM, so the
>> holes are also dynamically calculated ; there is no one DT then, the
>> bootloader is responsible to generate the dma-ranges accordingly.
> 
> The problems are it doesn't work:
> 
> Your dma-mask and offset are not going to be correct.
> 
> You are running out of inbound windows. Your patch does nothing to
> solve that. The solution would be merging multiple dma-ranges entries
> to a single inbound window. We'd have to do that both for dma-mask and
> inbound windows. The former would also have to figure out which
> entries apply to setting up dma-mask. I'm simply suggesting just do
> that up front and avoid any pointless splits.

But then the PCI device can trigger a transaction to non-existent DRAM
and cause undefined behavior. Surely we do not want that ?

> You are setting up random inbound windows. The bootloader can't assume
> what order the OS parses dma-ranges, and the OS can't assume what
> order the bootloader writes the entries.

But the OS can assume the ranges are correct and cover only valid
memory, right ? That is, memory into which the PCI controller can safely
access.

-- 
Best regards,
Marek Vasut
