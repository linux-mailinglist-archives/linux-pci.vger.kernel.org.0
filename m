Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2241D9C56
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 23:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437473AbfJPVQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 17:16:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34082 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfJPVQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 17:16:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so5544485wmc.1;
        Wed, 16 Oct 2019 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dbQZ6zwkJ6BU7RnAIAC1ON6mGXq4W0Z0BUmimCYkze0=;
        b=BiCQk+wGqZTAgZ2Hfu/gtGji/wmcg/VbNxgn/hRsv0RGHaEGVv6eZL5ZFAJJbpD6jx
         Ui/YTtjZPrtQwlYffmBMrdQwssTZB8gbLgXi5T5a0f4XEu+WX12aiJDjqCj2tinu1ws3
         6amH/HSkUwAfABmsFYgGf/l5wK93BMQtMHHlFE0txZOVWGNzEeyaxZYetoFZRkyTxrz0
         9RrrSvTCsyOo7NRlPHhmJrtMJRw7H7+lgOYY8VFKuvPaNU2MkwCQB2AnR5BjLQ8UQkXH
         Ol3FwddWYDTTO1fA5sz1LjZTsy1lIKI2CVo6HFVjhipe0iAyEYTv8eFpeQpQqlaXCImA
         wPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dbQZ6zwkJ6BU7RnAIAC1ON6mGXq4W0Z0BUmimCYkze0=;
        b=X1E+RGwq/lticQoVApi4u3LyojUtQgz9wDxvyI2dXdkm8h7zUQTtwyMaAHbe89/adx
         VcFXrnIVR/vX6uf8HDIQ989vRWr1qMTDwHU6nDZxCKNbX1dJZ2BnlRelq7Hmqvozfce0
         9iehh2FwmUTDA9XjAqShTU1LLxL1k5n6/ZQHB0IFGWWLyp1Fc0Ao6+Gcvr5pAAhHi5zy
         uuOHaxu+myTdhSrTVSHjkXxZ/UxtLWa8tR+shgybGBPOVhQnrJA2rd3apbmvGPw4rAag
         Julrr1qO+NZdHUiPtMWRXF+Y7Isy0xH9/GPkloH2GUi35VSLh9bfv9BA+WjrGOJwHru8
         hIjw==
X-Gm-Message-State: APjAAAWU9UhIV0SZQuzYCIZksX2hMrF5Ar9y9j7AAy/bQ8wBW0PXC30z
        /OlbOrYxzPBTYMSVXBSZ1t5vbtIa
X-Google-Smtp-Source: APXvYqzZQ/KrPB3tMbuSW1xK8F4I2WttZmVZjoSORuvHlLvPUhLrcXHZ+8OmYNH/sXYbd1jQ4FPiFw==
X-Received: by 2002:a05:600c:2212:: with SMTP id z18mr5455360wml.154.1571260569355;
        Wed, 16 Oct 2019 14:16:09 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id r13sm102928wrn.0.2019.10.16.14.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 14:16:08 -0700 (PDT)
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
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
Date:   Wed, 16 Oct 2019 23:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/16/19 10:25 PM, Rob Herring wrote:
[...]
>>>>>>> The firmware cannot decide the policy for the next stage (Linux in
>>>>>>> this case) on which ranges are better to use for Linux and which are
>>>>>>> less good. Linux can then decide which ranges are best suited for it
>>>>>>> and ignore the other ones.
>>>>>>
>>>>>> dma-ranges is a property that is used by other kernel subsystems eg
>>>>>> IOMMU other than the RCAR host controller driver. The policy, provided
>>>>>> there is one should be shared across them. You can't leave a PCI
>>>>>> host controller half-programmed and expect other subsystems (that
>>>>>> *expect* those ranges to be DMA'ble) to work.
>>>>>>
>>>>>> I reiterate my point: if firmware is broken it is better to fail
>>>>>> the probe rather than limp on hoping that things will keep on
>>>>>> working.
>>>>>
>>>>> But the firmware is not broken ?
>>>>
>>>> See above, it depends on how the dma-ranges property is interpreted,
>>>> hopefully we can reach consensus in this thread, I won't merge a patch
>>>> that can backfire later unless we all agree that what it does is
>>>> correct.
>>>
>>> Defining more dma-ranges entries than the h/w has inbound windows for
>>> sounds like a broken DT to me.
>>>
>>> What exactly does dma-ranges contain in this case? I'm not really
>>> visualizing how different clients would pick different dma-ranges
>>> entries.
>>
>> You can have multiple non-continuous DRAM banks for example. And an
>> entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
>> separate dma-ranges entry, right ?
> 
> Not necessarily. We really only want to define the minimum we have to.
> The ideal system is no dma-ranges. Is each bank at a different
> relative position compared to the CPU's view of the system. That would
> seem doubtful for just DRAM banks. Perhaps DRAM and SRAM could change.

Is that a question ? Anyway, yes, there is a bit of DRAM below the 32bit
boundary and some more above the 32bit boundary. These two banks don't
need to be continuous. And then you could add the SRAM into the mix.

> I suppose if your intent is to use inbound windows as a poor man's
> IOMMU to prevent accesses to the holes, then yes you would list them
> out. But I think that's wrong and difficult to maintain. You'd also
> need to deal with reserved-memory regions too.

What's the problem with that? The bootloader has all that information
and can patch the DT correctly. In fact, in my specific case, I have
platform which can be populated with differently sized DRAM, so the
holes are also dynamically calculated ; there is no one DT then, the
bootloader is responsible to generate the dma-ranges accordingly.

-- 
Best regards,
Marek Vasut
