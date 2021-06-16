Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3113A9B2D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFPMzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 08:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhFPMzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 08:55:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A6EC061574;
        Wed, 16 Jun 2021 05:53:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n12so1854276pgs.13;
        Wed, 16 Jun 2021 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f4MrgwtY3/W6oCFjtro8tz651lyRS/Kv4xgNCHNchVM=;
        b=Y4T9AA0WWUCuyhxDCOgE0074vUGHK/oRcYfNE1lHhkqrxCLP9BCCNT973sEJMyUb9w
         kwm+iM8/CpAT43FscZpF68Z3La9iKUPax7GnLBJiTOQVqGnMk2Tw9CR/OYqqiScNehHB
         sFVjcZ5yZRqfiD6PK7VGeuWGvzqQ9vKvEQ5vtv3JJoAuijyu1ZpgWeFbr1OrHIoQGfFa
         wmpV2H/29r0Pe67NLDzzQujobRGpAKW+SkupLPS/j98HxB4t+7h5aikyl4RDyBMlDGT5
         vuRmPeI2Kwb5x+6l0HLTBUnKoenhLKIIsvu8sp1YuP6VQgRqiJ4DaIz3qiiMTXKVJYrR
         0yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=f4MrgwtY3/W6oCFjtro8tz651lyRS/Kv4xgNCHNchVM=;
        b=M/einl4UjFPvg8VRE9xTdlWrTzPudJ/3UulmNIqeIpojVrk1NYikgy5O8OdxywzTdJ
         wkBYGm7gRAo1U4HPrynPWTDDDKdRbXGOzC2qkxPnIHuZhzTn8dPC67VjyLR5YSbKsZFr
         FFYPN4rMf6HWNziIh+6Bfee0XHlW+fY4ZwPSUbz0cuSYMmZQuVETzZxV32TIjJ8IOmPm
         edb8G1Hj2lPcfdjhQ2ky3Hur10MTJy/U/XWXkQCUx7KfteAIkuwKuL3YQqJdpaduR7Ux
         2qncnPRHu3eDBWWYyj41bhUZIgHPc7oew1u4pleoIYZjjh3IhTlNvy3SVTWRdpO9sQLs
         ge9A==
X-Gm-Message-State: AOAM53220969T55HEC4ULtCGc5InnnsPB9+JBCLpx/w81/s1VrsBdpHd
        ZfO91sIL+PxpkVqIy4np/CA=
X-Google-Smtp-Source: ABdhPJzi6fInaHylrnU5udt0FIOIHzxqnDRVrcq83azGckONk8DTBFxG+DNMq+oLtnT+qKE/MYi1YA==
X-Received: by 2002:aa7:9ecd:0:b029:2fc:779:b187 with SMTP id r13-20020aa79ecd0000b02902fc0779b187mr7716240pfq.28.1623848027861;
        Wed, 16 Jun 2021 05:53:47 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id p9sm2211326pfo.106.2021.06.16.05.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:53:47 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable
 memory below 4GB
References: <20210614230457.752811-1-punitagrawal@gmail.com>
        <CAL_JsqLhOFHwBwtMFMnuEaXsDs9sqzUPS=68t+bDnbFsfXgo+Q@mail.gmail.com>
Date:   Wed, 16 Jun 2021 21:53:45 +0900
In-Reply-To: <CAL_JsqLhOFHwBwtMFMnuEaXsDs9sqzUPS=68t+bDnbFsfXgo+Q@mail.gmail.com>
        (Rob Herring's message of "Tue, 15 Jun 2021 15:18:15 -0600")
Message-ID: <878s3at1gm.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Rob Herring <robh+dt@kernel.org> writes:

> On Mon, Jun 14, 2021 at 5:05 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> Alexandru and Qu reported this resource allocation failure on
>> ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
>>
>>   pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
>>   pci 0000:00:00.0: PCI bridge to [bus 01]
>>   pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>>   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>>
>> "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
>> PCI allocation code isn't smart enough to allocate it in a host
>> bridge window marked as 64-bit, even though this should work fine.
>>
>> A DT host bridge description includes the windows from the CPU
>> address space to the PCI bus space.  On a few architectures
>> (microblaze, powerpc, sparc), the DT may also describe PCI devices
>> themselves, including their BARs.
>>
>> Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
>> flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
>> the fact that some DT addresses described 64-bit windows and BARs.
>> That was a problem because the virtio virtual NIC has a 32-bit BAR
>> and a 64-bit BAR, and the driver couldn't distinguish them.
>>
>> 9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
>> fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
>> bridge windows, which exposed the fact that the PCI allocator isn't
>> smart enough to put 32-bit resources in those 64-bit windows.
>>
>> Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
>> that information.
>>
>> Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
>> Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
>> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> Reported-by: Qu Wenruo <wqu@suse.com>
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>
> I think we've beat this one to death.
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for taking a look. Hopefully everybody is happy with this
version and the patch can get merged soon.

I assume Bjorn will pick this up as a fix with Alex's Tested-by tag. Let
me know if any other steps are needed.

Thanks,
Punit

[...]

