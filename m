Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511C7390C54
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 00:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhEYWh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 18:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhEYWh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 18:37:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923BC061574;
        Tue, 25 May 2021 15:36:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 29so12814925pgu.11;
        Tue, 25 May 2021 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wn3EG8k3M8Vjrn0xAqTbjN7lE2HqWDMtOWHhAlz2oY0=;
        b=YUOtOr1AVPer3RmRfek2VbOYVLoUuADSgpiS6RErYIwnz5sVKtwCflo6KEXtRSUEes
         obeWF2Rq6vwPsTXrlQYdl+MKtwmhAXQYukJrtn4q+pXNJNoQWVFbs+W4Wasvvus2hky5
         yCZtIxsv6D2xJhTvoX7A4beRiJaYjppiWk0WMQ67un7TyOe8mNelkSi8Wb9poYAEKqeh
         ejyyGZUJxVPcbNPSQALlx8LXEGQeY5YVNDXubq2ZKSdYThHUMY3VJBz4gSfAYEo0bHFs
         YzhSL4xNlpZPL2nLyBhzBJ7hccukBgi0xgygdtylVKLZkC2AHm5TmMbFNaLWUDcCPU01
         K5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wn3EG8k3M8Vjrn0xAqTbjN7lE2HqWDMtOWHhAlz2oY0=;
        b=lM8PFSZ/Or3pBBnJ8ej/E234czJ1PR5WvSDgh7Qx+ajbqUOvv9RkAvEccJdZRcuZSF
         B3hl2WkGGuYiby8YgAvTno0Z6tUMWu20HxzQ0UniemMB160UpL72lKgLZjIlzWnd8rM3
         rUgnMq+dElGi6fjvcHxzUKxd0piBuVltJynSaPk7LFkgK7o62f9xEGqMpoz1khJDh0tu
         ER4ie7s3H5BLXGDN3D7lFde6wiOaLokr/qofHD8MU0HRdbHOWATqJAAQeEyTFtV94Jzi
         0AKnGfQzbIt1YfwnGnrjQyCIZp7Fk3fPGXzv9T6brF8i1lQ1URVYpIbPicuznmozZ8pL
         VIxA==
X-Gm-Message-State: AOAM531Jy5eGecK+hKnbhBPkLXcgxtGNIuH0OchQG5Z4v4hOweb1OFkF
        gDzpF116DGCFxURz5G7AhzE=
X-Google-Smtp-Source: ABdhPJxEkUIBK++KdU+m8mTCWuHu8vAKSq5jd6yKuxNNuc8NGoqmD03GaMJQGv+1pId9Z2BLZCGdkA==
X-Received: by 2002:a63:aa48:: with SMTP id x8mr21127327pgo.359.1621982184997;
        Tue, 25 May 2021 15:36:24 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id o186sm14260694pfg.170.2021.05.25.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:36:24 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        leobras.c@gmail.com, Rob Herring <robh@kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
        <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
        <87eedxbtkn.fsf@stealth>
        <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
        <877djnaq11.fsf@stealth>
        <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
Date:   Wed, 26 May 2021 07:36:21 +0900
In-Reply-To: <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
        (Ard Biesheuvel's message of "Tue, 25 May 2021 15:54:30 +0200")
Message-ID: <871r9ubfve.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 25 May 2021 at 15:42, Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> Hi Ard,
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > On Sun, 23 May 2021 at 13:06, Punit Agrawal <punitagrawal@gmail.com> wrote:
>> >>
>> >> Robin Murphy <robin.murphy@arm.com> writes:
>> >>
>> >> > [ +linux-pci for visibility ]
>> >> >
>> >> > On 2021-05-18 10:09, Alexandru Elisei wrote:
>> >> >> After doing a git bisect I was able to trace the following error when booting my
>> >> >> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
>> >> >> [..]
>> >> >> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
>> >> >> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
>> >> >> 0x00fa000000
>> >> >> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
>> >> >> 0x00fbe00000
>> >> >> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
>> >> >> regulator
>> >> >> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
>> >> >> regulator
>> >> >> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
>> >> >> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
>> >> >> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
>> >> >> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
>> >> >> address [0xfbe00000-0xfbefffff])
>> >> >> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
>> >> >> [    0.373973] pci 0000:00:00.0: supports D1
>> >> >> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
>> >> >> [    0.378518] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
>> >> >> reconfiguring
>> >> >> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
>> >> >> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>> >> >> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
>> >> >> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
>> >> >> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
>> >> >> x4 link)
>> >> >> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
>> >> >> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>> >> >> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
>> >> >> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
>> >> >> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
>> >> >> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
>> >> >> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
>> >> >> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
>> >> >> [..]
>> >> >> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
>> >> >> resource flags for
>> >> >> 64-bit memory addresses").
>> >> >
>> >> > FWFW, my hunch is that the host bridge advertising no 32-bit memory
>> >> > resource, only only a single 64-bit non-prefetchable one (even though
>> >> > it's entirely below 4GB) might be a bit weird and tripping something
>> >> > up in the resource assignment code. It certainly seems like the thing
>> >> > most directly related to the offending commit.
>> >> >
>> >> > I'd be tempted to try fiddling with that in the DT (i.e. changing
>> >> > 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see
>> >> > if it makes any difference. Note that even if it helps, though, I
>> >> > don't know whether that's the correct fix or just a bodge around a
>> >> > corner-case bug somewhere in the resource code.
>> >>
>> >> From digging into this further the failure seems to be due to a mismatch
>> >> of flags when allocating resources in pci_bus_alloc_from_region() -
>> >>
>> >>     if ((res->flags ^ r->flags) & type_mask)
>> >>             continue;
>> >>
>> >> Though I am also not sure why the failure is only being reported on
>> >> RK3399 - does a single 64-bit window have anything to do with it?
>> >>
>> >
>> > The NVMe in the example exposes a single 64-bit non-prefetchable BAR.
>> > Such BARs can not be allocated in a prefetchable host bridge window
>> > (unlike the converse, i.e., allocating a prefetchable BAR in a
>> > non-prefetchable host bridge window is fine)
>> >
>> > 64-bit non-prefetchable host bridge windows cannot be forwarded by PCI
>> > to PCI bridges, they simply lack the BAR registers to describe them.
>> > Therefore, non-prefetchable endpoint BARs (even 64-bit ones) need to
>> > be carved out of a host bridge's non-prefetchable 32-bit window if
>> > they need to pass through a bridge.
>>
>> Thank you for the explanation. I also looked at the PCI-to-PCI Bridge
>> spec to understand where some of the limitations are coming from.
>>
>> > So the error seems to be here that the host bridge's 32-bit
>> > non-prefetchable window has the 64-bit attribute set, even though it
>> > resides below 4 GB entirely. I suppose that the resource allocation
>> > could be made more forgiving (and it was in the past, before commit
>> > 9d57e61bf723 was applied). However, I would strongly recommend not
>> > deviating from common practice, and just describe the 32-bit
>> > addressable non-prefetchable resource window as such.
>>
>> IIUC, the host bridge's configuration (64-bit on non-prefetchable
>> window) is based on what the hardware advertises.
>>
>
> What do you mean by 'what the hardware advertises'? The host bridge is
> apparently configured to decode a 32-bit addressable window as MMIO,
> and the question is why this window has the 64-bit attribute set in
> the DT description.

Right - I completely missed the fact that the ranges property is also
encoding the window attributes. Thanks for setting me straight.

git archaeology doesn't provide any explanation - I am wondering if it
is just an oversight.

>> Can you elaborate on what you have in mind to correct the
>> non-prefetchable resource window? Are you thinking of adding a quirk
>> somewhere to address this?
>>
>
> No. Just fix the DT.

After updating the DT to mark the non-prefetchable window as 32-bit
things work as expected.

Let me send a patch to update the DT - I'll include previous authors
who've touched that DT fragment. Hopefully somebody will jump in to
explain the reason it was done that way.

Thanks,
Punit

[...]

