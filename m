Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3103A9AF8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhFPMvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFPMvH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 08:51:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B78CC061574;
        Wed, 16 Jun 2021 05:49:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k22-20020a17090aef16b0290163512accedso3608177pjz.0;
        Wed, 16 Jun 2021 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bPog0RE85xcT70HcJ3zdDfpWRbRDYp7EE1bqB/NOW4w=;
        b=IoLYdCWDuxVy2duzo7zynPackCGDlyDgRI4iDjO6Cemgz1TdwaE2aY+ZivXzTsseNa
         W+XgTj/KD1clC7NM5oxdvDUsquYCWJZfJ2Q3UIHeGj+3dmmjRKyJwm4lhROeriDAhyxs
         +e1beUQpsLF2hQTMfNjAhQtPewD7jHQ7GZlOPjxXTqU1C2rjyzGtey2UpYdP4liGO4/8
         0RyLU5XQ/aP8X6U0up23valVFErA9JUwSfSIv+6zCgaC7CXfuUFN7O0JIpuihbeia5Bw
         XVzFJ4/3dcH+/Hw1f0GbcRGdXqkxv1J8A11JZOJv6OOiD84hUZCBvVxylaqNR3Mthohi
         Qe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=bPog0RE85xcT70HcJ3zdDfpWRbRDYp7EE1bqB/NOW4w=;
        b=FDNygjOCb7Ecdl3os3n/7FxVzHAq1iAXN06tZbI+PL45S7jx0gvErJXw2CVClE2TG3
         1aGN5LJvoWpGXuuxklB+M0uFxDKI/h1xue7V2C1ZZFK8YL4qoctoXyKamnbnmNBdiNsK
         O0T0+j0kja+R9wAtzvCRnOUmyMq3PI6RiKrlYBu1BMgiYyINlG/owS29wR7h1nU/pNLd
         GBCWsOwJTWXGqtdAErThWzwKBPQYrP2vs26Dd8/8O61YX2t3/sunvQy8WchCLWWVc8oV
         9H4f+qM+TTXDtoMSNc3N78C3ZWr4ciOPj1uNAiGINh5aI71O2pESVWfQj9SfJbPw73Gp
         vitA==
X-Gm-Message-State: AOAM533vxpUuS2zcsJfD9wwj3+zOCLsaFReBnZ9IKl65jD6Q0LgBDgNV
        G3aZuks1w85+HnTHoyynPnQ=
X-Google-Smtp-Source: ABdhPJzdXESQ4680mekLsqXH9ZnN3Akl6foU+/ByObUepapyrbdiGCVQt1LepR/Xt7ta2JfYgK3Usw==
X-Received: by 2002:a17:90a:ce18:: with SMTP id f24mr10642746pju.225.1623847739897;
        Wed, 16 Jun 2021 05:48:59 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id t1sm2143043pfe.61.2021.06.16.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:48:58 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     helgaas@kernel.org, robh+dt@kernel.org, maz@kernel.org,
        leobras.c@gmail.com, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable
 memory below 4GB
References: <20210614230457.752811-1-punitagrawal@gmail.com>
        <888ca9e9-a1c0-3992-7c01-bbb7400e8dc0@arm.com>
Date:   Wed, 16 Jun 2021 21:48:56 +0900
In-Reply-To: <888ca9e9-a1c0-3992-7c01-bbb7400e8dc0@arm.com> (Alexandru
        Elisei's message of "Tue, 15 Jun 2021 09:46:12 +0100")
Message-ID: <87eed2t1on.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

Alexandru Elisei <alexandru.elisei@arm.com> writes:

> Hi Punit,
>
> Thank you for working on this!
>
> On 6/15/21 12:04 AM, Punit Agrawal wrote:
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
>
> I've tested the patch on my rockpro64. Kernel built from tag v5.13-rc6:
>
> [=C2=A0=C2=A0=C2=A0 0.345676] pci 0000:01:00.0: 8.000 Gb/s available PCIe=
 bandwidth, limited by
> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT=
/s PCIe
> x4 link)
> [=C2=A0=C2=A0=C2=A0 0.359300] pci_bus 0000:01: busn_res: [bus 01-1f] end =
is updated to 01
> [=C2=A0=C2=A0=C2=A0 0.359343] pci 0000:00:00.0: BAR 14: no space for [mem=
 size 0x00100000]
> [=C2=A0=C2=A0=C2=A0 0.359365] pci 0000:00:00.0: BAR 14: failed to assign =
[mem size 0x00100000]
> [=C2=A0=C2=A0=C2=A0 0.359387] pci 0000:01:00.0: BAR 0: no space for [mem =
size 0x00004000 64bit]
> [=C2=A0=C2=A0=C2=A0 0.359407] pci 0000:01:00.0: BAR 0: failed to assign [=
mem size 0x00004000 64bit]
> [=C2=A0=C2=A0=C2=A0 0.359428] pci 0000:00:00.0: PCI bridge to [bus 01]
> [=C2=A0=C2=A0=C2=A0 0.359862] pcieport 0000:00:00.0: PME: Signaling with =
IRQ 76
> [=C2=A0=C2=A0=C2=A0 0.360190] pcieport 0000:00:00.0: AER: enabled with IR=
Q 76
>
> Kernel built from tag v5.13-rc6 with this patch applied:
>
> [=C2=A0=C2=A0=C2=A0 0.345434] pci 0000:01:00.0: 8.000 Gb/s available PCIe=
 bandwidth, limited by
> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT=
/s PCIe
> x4 link)
> [=C2=A0=C2=A0=C2=A0 0.359081] pci_bus 0000:01: busn_res: [bus 01-1f] end =
is updated to 01
> [=C2=A0=C2=A0=C2=A0 0.359128] pci 0000:00:00.0: BAR 14: assigned [mem 0xf=
a000000-0xfa0fffff]
> [=C2=A0=C2=A0=C2=A0 0.359155] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa=
000000-0xfa003fff 64bit]
> [=C2=A0=C2=A0=C2=A0 0.359217] pci 0000:00:00.0: PCI bridge to [bus 01]
> [=C2=A0=C2=A0=C2=A0 0.359239] pci 0000:00:00.0:=C2=A0=C2=A0 bridge window=
 [mem 0xfa000000-0xfa0fffff]
> [=C2=A0=C2=A0=C2=A0 0.359422] pcieport 0000:00:00.0: enabling device (000=
0 -> 0002)
> [=C2=A0=C2=A0=C2=A0 0.359687] pcieport 0000:00:00.0: PME: Signaling with =
IRQ 76
> [=C2=A0=C2=A0=C2=A0 0.360001] pcieport 0000:00:00.0: AER: enabled with IR=
Q 76
>
> And the NVME on the PCIE expansion card works as expected:
>
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks a lot for the retest and the detailed logs.

Punit

[...]

