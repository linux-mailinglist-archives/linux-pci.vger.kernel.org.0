Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4170D9594
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfJPP34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 11:29:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55662 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJPP34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 11:29:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so3388221wma.5;
        Wed, 16 Oct 2019 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZZezWmRmvgxCyivZWNTEIUXasO22MA3WB/UNWt0OUY=;
        b=swcCTDM90osvVdvTPPnH4aoDyB7eMlmOVUOP7pG/OXmyoJ6AZjhmTUdrUmWZK1y5s4
         AvZCkeo4sVBHutzQ1iDZxZDVMoyFAcTfXjuOyUyG/ajkAxiXHSdNlkK6YpH5sQXevpzh
         p6GYK31kZcYF72eYuhFd9jQ+92Yzz7lMrXGv6qsY1BXs416bgJ1/vBc/LHMjx/koRGbz
         NEJ7SmVVtfBjj/wYxJHa+im5+EIa/vS0lEl4EkwG3jpfRVWG253tZTBnlLmyYaSLLUgE
         iFApar2emH3D9A4hh+YAyieGLEhga4oW/YeUe7VThCTQ5AHAvFyR8QFQ3PkvPfDNJkAY
         ktqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZZezWmRmvgxCyivZWNTEIUXasO22MA3WB/UNWt0OUY=;
        b=JwceWu6P3ypWsprU2T6EjQpnLEWgvuaHs0mFEiNwnFzYN0Y8om0h0B7+yCNB8PN5Sz
         S8/RVdSg2tp1X4o6jdawaHYFN3ZX9vJ+4I8gd/bnSZ0dYC5zx6yJrcipUgYHpUq4SsyZ
         q/hMUB6U0c6qnDotbO6u9p7Nj+2nlyjDykyzLAy0FKbscnRjcAHxM7Od/IPGIOjqy2ei
         fOGozwKeqt6aSkLJRnL5UaGR7uabajwLM2EVzGcbjNE9sPEDVkK9f8mqTdudSYa6QfZe
         c1hn/rUOTua9WOxMti/YubO1gBynnM+xWuhmT4pmpTgF9sapvR0tkvC9tTF8keE5f2Uu
         FFgA==
X-Gm-Message-State: APjAAAV5SPNu0W8/FipsjCdfC8cBnRuUIdlea77nlT46xahyFkmlUp3m
        8jdzmXVDXG9oULstnRMQJyBdq7Ou
X-Google-Smtp-Source: APXvYqw8nMKRgYfHyGKpOtwc/VoSSDsPAiehVEbHol3Rom4zqFmfOlQOlLvx6gqm5wxBwlHzVVQh/g==
X-Received: by 2002:a1c:1ad4:: with SMTP id a203mr3819726wma.166.1571239792497;
        Wed, 16 Oct 2019 08:29:52 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id n18sm2689213wmi.20.2019.10.16.08.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:29:51 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
 <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
Date:   Wed, 16 Oct 2019 17:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016152601.GB7457@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/16/19 5:26 PM, Lorenzo Pieralisi wrote:
> On Wed, Oct 16, 2019 at 05:10:02PM +0200, Marek Vasut wrote:
>> On 10/16/19 5:00 PM, Lorenzo Pieralisi wrote:
>>> On Fri, Aug 09, 2019 at 07:57:40PM +0200, Marek Vasut wrote:
>>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>
>>>> In case the "dma-ranges" DT property contains either too many ranges
>>>> or the range start address is unaligned in such a way that populating
>>>> the range into the controller requires multiple entries, a situation
>>>> may occur where all ranges cannot be loaded into the controller.
>>>>
>>>> Currently, the driver refuses to probe in such a situation. Relax this
>>>> behavior, load as many ranges as possible and warn if some ranges do
>>>> not fit anymore.
>>>
>>> Patches (1) and (3) are fine but I do not think this one is.
>>>
>>> Firmware (DT) should provide dma-ranges according to what HW can handle,
>>> more so given that other subsystems (eg IOMMU) rely on the dma-ranges
>>> value to set-up eg DMA - if there is a mismatch between PCI host inbound
>>> regions and software structures describing DMA'able ranges all bets are
>>> off.
>>
>> The firmware provides all the ranges which are available and usable,
>> that's the hardware description and that should be in the DT.
> 
> If the HW (given that those dma-ranges are declared for the PCI host
> controller) can't be programmed to enable those DMA ranges - those
> ranges are neither available nor usable, ergo DT is broken.

The hardware can be programmed to enable those DMA ranges, just not all
of them at the same time.

It's not the job of the bootloader to guess which ranges might the next
stage like best.

>> The firmware cannot decide the policy for the next stage (Linux in
>> this case) on which ranges are better to use for Linux and which are
>> less good. Linux can then decide which ranges are best suited for it
>> and ignore the other ones.
> 
> dma-ranges is a property that is used by other kernel subsystems eg
> IOMMU other than the RCAR host controller driver. The policy, provided
> there is one should be shared across them. You can't leave a PCI
> host controller half-programmed and expect other subsystems (that
> *expect* those ranges to be DMA'ble) to work.
> 
> I reiterate my point: if firmware is broken it is better to fail
> the probe rather than limp on hoping that things will keep on
> working.

But the firmware is not broken ?

-- 
Best regards,
Marek Vasut
