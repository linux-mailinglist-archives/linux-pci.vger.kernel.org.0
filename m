Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C2D98FD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbfJPSSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 14:18:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33405 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbfJPSSA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 14:18:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so5246333wme.0;
        Wed, 16 Oct 2019 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9iTECzodZ1xBpd+IWFAMIBW1KA6rMKfm4Zte1wZMBIQ=;
        b=j+lmIfSNCk1z9ktnsAnvjaCOXAGz9IAOGGVbKgsGCd5PiXbTuqwDFJdYIBIpPpxX13
         ZWZilwbo10eiT/vvvpu0IBQxROookA1mBl2zot2KDzcOCYkLdlV7oiIGWK6tgz9RUbed
         0HWXZimhXy2P0WjSIl/8OlvMedSEnmSJNl51kCxYYoFgZJaOuwwryUZGb+EtniMwcu7C
         YJQ/hQmUr18Q4PnsJY6NIQHjt6NERZf7iO2LEMSBCdDl1KAYCjM8jYdTmMv35tamBXrI
         IelwUDfMwK9ACjGhNx3zH381snH8apiQlZKcsdskYjPymWvoXXlCijZlCEb96xvovjev
         D+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9iTECzodZ1xBpd+IWFAMIBW1KA6rMKfm4Zte1wZMBIQ=;
        b=qTsZIyY0q/i0X7b7drtIRML24Kfq4CPV3tji6KA/pq/U5NVKlI8pjdxsrhv4C1jlMb
         J/X5rrCwKMKaYzJYg3B0Y7GjJhYXM17PUvFPRKF3amY58h52/OziPSk6miNwJSP54+Ul
         4e/fI/TPRwPuqn/9R0hX9XW3/LOK8rYBVYM6V4fWDOCO2dkwdatF8f1G5StSZjfP5AL7
         rWVjqQygb5UO9AVe5/bpx/I7LlwxdVevD17XNhFJoz9x0GeNC3VMpBsQZOVVmXXRh46B
         FfGzBafSktH2PFEY7tTlRUdgZcwd3PWWoULoVxKTHvFjjCwiRhTRBnyaMGdS8dQ/7/Wd
         4rvg==
X-Gm-Message-State: APjAAAVTXDYk3SApQY0uc7be4UjO81a5CHK4PghNefdtGh0mLO0jGDTi
        /K45cSgArm2MzvhXzROZPPc=
X-Google-Smtp-Source: APXvYqyGvhdCyw7xAWZnovyCqQHE/ARIMXJi0oHHUXJE0Xj7oreERErvAbB3YQ8p4rEderW1OqsilQ==
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr4790809wmc.177.1571249877566;
        Wed, 16 Oct 2019 11:17:57 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id l6sm3575113wmg.2.2019.10.16.11.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 11:17:56 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
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
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com>
Date:   Wed, 16 Oct 2019 20:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/16/19 8:12 PM, Rob Herring wrote:
> On Wed, Oct 16, 2019 at 11:18 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> [+RobH, Robin]
>>
>> On Wed, Oct 16, 2019 at 05:29:50PM +0200, Marek Vasut wrote:
>>
>> [...]
>>
>>>>> The firmware provides all the ranges which are available and usable,
>>>>> that's the hardware description and that should be in the DT.
>>>>
>>>> If the HW (given that those dma-ranges are declared for the PCI host
>>>> controller) can't be programmed to enable those DMA ranges - those
>>>> ranges are neither available nor usable, ergo DT is broken.
>>>
>>> The hardware can be programmed to enable those DMA ranges, just not all
>>> of them at the same time.
>>
>> Ok, we are down to DT bindings interpretation then.
>>
>>> It's not the job of the bootloader to guess which ranges might the next
>>> stage like best.
>>
>> By the time this series:
>>
>> https://patchwork.ozlabs.org/user/todo/linux-pci/?series=132419
>>
>> is merged, your policy will require the host controller driver to
>> remove the DMA ranges that could not be programmed in the inbound
>> address decoders from the dma_ranges list, otherwise things will
>> fall apart.
> 
> I don't think the above series has too much impact on this. It's my
> other series dealing with dma masks that's relevant because for dma
> masks we only ever look at the first dma-ranges entry. We either have
> to support multiple addresses and sizes per device (the only way to
> really support any possible dma-ranges), merge entries to single
> offset/mask or have some way to select which range entry to use.
> 
> So things are broken to some extent regardless unless MAX_NR_INBOUND_MAPS == 1.
> 
>>>>> The firmware cannot decide the policy for the next stage (Linux in
>>>>> this case) on which ranges are better to use for Linux and which are
>>>>> less good. Linux can then decide which ranges are best suited for it
>>>>> and ignore the other ones.
>>>>
>>>> dma-ranges is a property that is used by other kernel subsystems eg
>>>> IOMMU other than the RCAR host controller driver. The policy, provided
>>>> there is one should be shared across them. You can't leave a PCI
>>>> host controller half-programmed and expect other subsystems (that
>>>> *expect* those ranges to be DMA'ble) to work.
>>>>
>>>> I reiterate my point: if firmware is broken it is better to fail
>>>> the probe rather than limp on hoping that things will keep on
>>>> working.
>>>
>>> But the firmware is not broken ?
>>
>> See above, it depends on how the dma-ranges property is interpreted,
>> hopefully we can reach consensus in this thread, I won't merge a patch
>> that can backfire later unless we all agree that what it does is
>> correct.
> 
> Defining more dma-ranges entries than the h/w has inbound windows for
> sounds like a broken DT to me.
> 
> What exactly does dma-ranges contain in this case? I'm not really
> visualizing how different clients would pick different dma-ranges
> entries.

You can have multiple non-continuous DRAM banks for example. And an
entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
separate dma-ranges entry, right ?

-- 
Best regards,
Marek Vasut
