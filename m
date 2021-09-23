Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8864166C0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbhIWUeW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbhIWUeW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 16:34:22 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25EC061574;
        Thu, 23 Sep 2021 13:32:50 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id t186so3124292vkd.3;
        Thu, 23 Sep 2021 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bia8AKiCbhO3PDl4x/4UbjkZ3U/S/I55zqwh+V2HsW0=;
        b=ak1/sX35Hb6hqJSEwc/zcMKYx0B/hPzGPT2BnIgP7H8RBbHbFG7VZhwf6eova03hA6
         eTdwRZTfApP/Owpz3q8YvLn5+zoUNoMXPNXL2t+9Nkg7PWYneR5jnSKaBf9k8w3fHDoJ
         Z1mrSXh63jpZPHalkLWmtqsreJkyVBDXAczwHrVva+CZiul5TszOGsb3hTRVjKSwrAW3
         L5wrU179LCoBixm5K8kT32MyQTBcLNv5VMqmBwOHk5FJkiBjJKUnwmvzIusgoeXXfIUc
         Ayfjego4V7UdpeLk4uKZ8QQaJ71amzq7ocFsud+4xoXY9RMAK4+rHWbjr72s9XYFY5Ft
         XOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bia8AKiCbhO3PDl4x/4UbjkZ3U/S/I55zqwh+V2HsW0=;
        b=qW+LQCH4778vEh9LicOPRIos0XHJZSFLHndWJU5yoAwJVYNaK5HiGgxkIUmckeU5Xb
         MTbv/k4fFinNME5M1PIkgdpV2c+IIRjwtiNKH67+KUc9tWfTwKOIO+4H+SIqYZilbJWc
         6pMfU8oGxtkMIa0SLRH5J+AbszO+tWFkMQd22cmxMsZTOnOb68ZFyrJvI128YHBWZ95K
         DQhNEiYMj0GsUriI4VLyTowDzXEAdOqp2vT6LI96NmHfq0WrB8/N1SBwvZ5/LPQLsuDk
         LgvBN6CvMl8LlJgdtrxd/mudw8Py9vx2DabrNvCOzRHtlnMKJOVDLzur5dE6Js7of/xi
         VVog==
X-Gm-Message-State: AOAM5302sZQCN9X/PNcHjvV2z5/VnRFnCQ89CtCEHkAUtfG+lGRKKhJ0
        pXcEpvBLTig8BoAJn7mIuDZVFy18FJqybCbq04g=
X-Google-Smtp-Source: ABdhPJwlInHDNJflOm0o81Eaw8eZ0ILeLB8CHPXJRtRocvBH4RORnUAu6SiLXsQsFjPxEP0oTMXIL7H9Poc7bi/MKQI=
X-Received: by 2002:a1f:abc9:: with SMTP id u192mr5612243vke.17.1632429169411;
 Thu, 23 Sep 2021 13:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
 <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
 <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
 <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
 <CAMhs-H8kH7CMXENqDW_6GLTjeMMyk+ynehMmyBr=kFZPFHpM0A@mail.gmail.com>
 <CAK8P3a2WmNsV9fhSEjqwHZAGkwGc9HOurhQsza7JOM2Scts2XQ@mail.gmail.com>
 <CAMhs-H8fRnLavLfdw7jZO0tb8rWqdF81cGHhYT6gGp4UY1gChg@mail.gmail.com>
 <CAK8P3a2MJO--xmAZ_71h1QQ5_b8WXgyo-=LaT7r7yMMBUHoPfQ@mail.gmail.com>
 <CAMhs-H_xdkpinyj-Y1u==ievpGWZ2Ze-_U7aCUcfu0=NKBq2xQ@mail.gmail.com> <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com>
In-Reply-To: <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 23 Sep 2021 22:32:37 +0200
Message-ID: <CAMhs-H9xrXgbuwYe2STzuq0aBwj0onJGc0Oka6+pzgoHb0j8rA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On Thu, Sep 23, 2021 at 7:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 23, 2021 at 4:55 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Thu, Sep 23, 2021 at 3:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > > > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> > > > > > LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
> > > > > > 0x1e160000 + RANGE IO: 0x00000000
> > > >
> > > > Why is my RANGE IO start transformed here to 0x0? Should not be the
> > > > one defined in dts 0x001e160000?
> >
> > >
> > > Can you show the exact property in your device tree? It sounds like the
> > > problem is an incorrect entry in the ranges, unless the chip is hardwired
> > > to the bus address in an unusual way.
> >
> > Here it is:
> >
> > ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
> >                <0x01000000 0 0x1e160000 0x1e160000 0 0x00010000>;  /*
> > io space */
>
> Ok, got it. So the memory space uses a normal zero offset with cpu address
> equal to bus address, but the I/O space has a rather usual mapping of
> bus address equal to the window into the mmio space, with an offset of
> 0x1e160000.
>
> The normal way to do this would be map the PCI port range 0-0x10000
> into CPU address 0x1e160000, like:
>
> ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
>                <0x01000000 0 0x1e160000 0 0 0x00010000>;

This change as it is got into the same behaviour:

mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000,
using [bus 00-ff]
mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
mt7621-pci 1e140000.pcie:       IO 0x0000000000..0x000000ffff -> 0x001e160000
                                                   ^^^^^^
                                                    This is the only
change I appreciate in all the trace with the range change.
mt7621-pci 1e140000.pcie: PCIE0 enabled
mt7621-pci 1e140000.pcie: PCIE1 enabled
mt7621-pci 1e140000.pcie: PCIE2 enabled
mt7621-pci 1e140000.pcie: PCI coherence region base: 0x60000000,
mask/settings: 0xf0000002
mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address
[0x1e160000-0x1e16ffff])
pci 0000:00:00.0: [0e8d:0801] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff]
pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x0000ffff]
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot
pci 0000:00:01.0: [0e8d:0801] type 01 class 0x060400
pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x7fffffff]
pci 0000:00:01.0: reg 0x14: [mem 0x00000000-0x0000ffff]
pci 0000:00:01.0: supports D1
pci 0000:00:01.0: PME# supported from D0 D1 D3hot
pci 0000:00:02.0: [0e8d:0801] type 01 class 0x060400
pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x7fffffff]
pci 0000:00:02.0: reg 0x14: [mem 0x00000000-0x0000ffff]
pci 0000:00:02.0: supports D1
pci 0000:00:02.0: PME# supported from D0 D1 D3hot
pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: [1b21:0611] type 00 class 0x010185
pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x10: [io  size 0x0008]
pci 0000:01:00.0: reg 0x14: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x14: [io  size 0x0004]
pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x18: [io  size 0x0008]
pci 0000:01:00.0: reg 0x1c: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x1c: [io  size 0x0004]
pci 0000:01:00.0: reg 0x20: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x20: [io  size 0x0010]
pci 0000:01:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000 Gb/s with 5.0 GT/s
PCIe x1 link)
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:02:00.0: [1b21:0611] type 00 class 0x010185
pci 0000:02:00.0: reg 0x10: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x10: [io  size 0x0008]
pci 0000:02:00.0: reg 0x14: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x14: [io  size 0x0004]
pci 0000:02:00.0: reg 0x18: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x18: [io  size 0x0008]
pci 0000:02:00.0: reg 0x1c: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x1c: [io  size 0x0004]
pci 0000:02:00.0: reg 0x20: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x20: [io  size 0x0010]
pci 0000:02:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x1 link at 0000:00:01.0 (capable of 4.000 Gb/s with 5.0 GT/s
PCIe x1 link)
pci 0000:00:01.0: PCI bridge to [bus 02-ff]
pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff pref]
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
pci 0000:03:00.0: [1b21:0611] type 00 class 0x010185
pci 0000:03:00.0: reg 0x10: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x10: [io  size 0x0008]
pci 0000:03:00.0: reg 0x14: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x14: [io  size 0x0004]
pci 0000:03:00.0: reg 0x18: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x18: [io  size 0x0008]
pci 0000:03:00.0: reg 0x1c: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x1c: [io  size 0x0004]
pci 0000:03:00.0: reg 0x20: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x20: [io  size 0x0010]
pci 0000:03:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x1 link at 0000:00:02.0 (capable of 4.000 Gb/s with 5.0 GT/s
PCIe x1 link)
pci 0000:00:02.0: PCI bridge to [bus 03-ff]
pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff pref]
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000]
pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x80000000]
pci 0000:00:01.0: BAR 0: no space for [mem size 0x80000000]
pci 0000:00:01.0: BAR 0: failed to assign [mem size 0x80000000]
pci 0000:00:02.0: BAR 0: no space for [mem size 0x80000000]
pci 0000:00:02.0: BAR 0: failed to assign [mem size 0x80000000]
pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
pci 0000:00:01.0: BAR 8: assigned [mem 0x60200000-0x602fffff]
pci 0000:00:01.0: BAR 9: assigned [mem 0x60300000-0x603fffff pref]
pci 0000:00:02.0: BAR 8: assigned [mem 0x60400000-0x604fffff]
pci 0000:00:02.0: BAR 9: assigned [mem 0x60500000-0x605fffff pref]
pci 0000:00:00.0: BAR 1: assigned [mem 0x60600000-0x6060ffff]
pci 0000:00:01.0: BAR 1: assigned [mem 0x60610000-0x6061ffff]
pci 0000:00:02.0: BAR 1: assigned [mem 0x60620000-0x6062ffff]
pci 0000:00:00.0: BAR 7: assigned [io  0x0000-0x0fff]
pci 0000:00:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:00:02.0: BAR 7: assigned [io  0x2000-0x2fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
pci 0000:01:00.0: BAR 4: assigned [io  0x0000-0x000f]
pci 0000:01:00.0: BAR 0: assigned [io  0x0010-0x0017]
pci 0000:01:00.0: BAR 2: assigned [io  0x0018-0x001f]
pci 0000:01:00.0: BAR 1: assigned [io  0x0020-0x0023]
pci 0000:01:00.0: BAR 3: assigned [io  0x0024-0x0027]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
pci 0000:02:00.0: BAR 5: assigned [mem 0x60200000-0x602001ff]
pci 0000:02:00.0: BAR 4: assigned [io  0x1000-0x100f]
pci 0000:02:00.0: BAR 0: assigned [io  0x1010-0x1017]
pci 0000:02:00.0: BAR 2: assigned [io  0x1018-0x101f]
pci 0000:02:00.0: BAR 1: assigned [io  0x1020-0x1023]
pci 0000:02:00.0: BAR 3: assigned [io  0x1024-0x1027]
pci 0000:00:01.0: PCI bridge to [bus 02]
pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602fffff]
pci 0000:00:01.0:   bridge window [mem 0x60300000-0x603fffff pref]
pci 0000:03:00.0: BAR 5: assigned [mem 0x60400000-0x604001ff]
pci 0000:03:00.0: BAR 4: assigned [io  0x2000-0x200f]
pci 0000:03:00.0: BAR 0: assigned [io  0x2010-0x2017]
pci 0000:03:00.0: BAR 2: assigned [io  0x2018-0x201f]
pci 0000:03:00.0: BAR 1: assigned [io  0x2020-0x2023]
pci 0000:03:00.0: BAR 3: assigned [io  0x2024-0x2027]
pci 0000:00:02.0: PCI bridge to [bus 03]
pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
pci 0000:00:02.0:   bridge window [mem 0x60500000-0x605fffff pref

# cat /proc/ioports
00000000-0000ffff : pcie@1e140000
  00000000-00000fff : PCI Bus 0000:01
    00000000-0000000f : 0000:01:00.0
      00000000-0000000f : ahci
    00000010-00000017 : 0000:01:00.0
      00000010-00000017 : ahci
    00000018-0000001f : 0000:01:00.0
      00000018-0000001f : ahci
    00000020-00000023 : 0000:01:00.0
      00000020-00000023 : ahci
    00000024-00000027 : 0000:01:00.0
      00000024-00000027 : ahci
  00001000-00001fff : PCI Bus 0000:02
    00001000-0000100f : 0000:02:00.0
      00001000-0000100f : ahci
    00001010-00001017 : 0000:02:00.0
      00001010-00001017 : ahci
    00001018-0000101f : 0000:02:00.0
      00001018-0000101f : ahci
    00001020-00001023 : 0000:02:00.0
      00001020-00001023 : ahci
    00001024-00001027 : 0000:02:00.0
      00001024-00001027 : ahci
  00002000-00002fff : PCI Bus 0000:03
    00002000-0000200f : 0000:03:00.0
      00002000-0000200f : ahci
    00002010-00002017 : 0000:03:00.0
      00002010-00002017 : ahci
    00002018-0000201f : 0000:03:00.0
      00002018-0000201f : ahci
    00002020-00002023 : 0000:03:00.0
      00002020-00002023 : ahci
    00002024-00002027 : 0000:03:00.0
      00002024-00002027 : ahci

>
> Do you know where that mapping is set up? Is this a hardware setting,
> or is there a way to change the inbound I/O port ranges to the
> normal mapping?

The only thing related is the IOBASE register which is the base
address for the IO space window. Driver code is setting this up to pci
IO resource start address [0].

>
> > > > Currently, no. But if they were ideally moved to work in the same way
> > > > mt7621 would be the same case. Mt7621 is device tree based PCI host
> > > > bridge driver that uses pci core apis but is still mips since it has
> > > > to properly set IO coherency units which is a mips thing...
> > >
> > > I don't know what those IO coherency units are, but I would think that
> > > if you have to do some extra things on MIPS but not ARM, then those
> > > should be done from the common PCI host bridge code and stubbed out
> > > on architectures that don't need them.
> >
> > Simple definition here [0]. And we must adjust them in the driver here
> > [1]. Mips code, yes, but cannot be done in another way. Is related
> > with address of the memory resource and must be set up. In any other
> > case the pci subsystem won't work. I initially submitted this driver
> > from staging to arch/mips but I was told that even though it is mips
> > code, as it is device tree based and use common pci core apis, it
> > would be better to move it to 'drivers/pci/controller'. But I still
> > need the mips specific code for the iocu thing.
>
> It does sound like this could be reworked into an architecture
> specific helper that is defined for MIPS but just an empty stub
> for everything else. Or you can just have an #ifdef in your
> driver to at least enable compile-testing it on other architecture
> if not completely sharing it with others. This is certainly a less
> important point compared to the I/O port mapping.

Currently, Kconfig is enabling COMPILE_TEST only for MIPS
architecture, but agreed, this is not important yet :).

>
> > > It is possible that the hardware (or bootloader) designers
> > > misunderstood what the window is about, and hardcoded it so
> > > that the port number on the bus is the same as the physical
> > > address as seen from the CPU. If this is the case and you
> > > can't change it to a sane value, you have to put the 1:1
> > > translation into the DT and would actually get the strange
> > > port numbers 0x1e161000-0x1e16100f from that nonzero offset.
> >
> > Yes, and that pci_add_resource_offset() is called inside
> > devm_of_pci_get_host_bridge_resources() after parsing the ranges and
> > storing them as resources.  To calculate that offset passed around,
> > subtracts: res->start - range.pci_addr [2], so looking into my ranges
> > my offset should be zero. And I have added a trace just to confirm and
> > there are zero:
> >
> > mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
> > OF: IO START returned by pci_address_to_pio: 0x60000000-0x6fffffff
> > PCI: OF: OFFSET -> RES START 0x60000000 - PCI ADDRESS 0x60000000 -> 0x0
> > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> > OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff
> > PCI: OF: OFFSET -> RES START 0x1e160000 - PCI ADDRESS 0x1e160000 -> 0x0
> >
> > But if I define PCI_IOBASE I get my I/O range start set to zero but
> > also the offset?? Why this substract is not getting '0x1e160000' as
> > offset here?
> >
> > LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
> > 0x1e160000 + RANGE IO: 0x00000000
> > OF: IO START returned by pci_address_to_pio: 0x0-0xffff
> > PCI: OF: OFFSET -> RES START 0x0 - PCI ADDRESS 0x1e160000 -> 0x0
>
> I'm not completely following what each of the numbers in your log refer
> to.  The main thing you still need is to have the hardware set up
> so it matches the ranges property, and the io_offset matching that.
>
> With PCI_IOBASE=0x1e160000, there are two possible ways this
> can work:
>
> a) according to the ranges property you listed above:
>     linux port numbers 0-0xffff, pci port numbers 0x1e160000-0x1e16ffff,
>     io_offset=0x1e160000 (possibly negative that number, I can never
>     keep track)
>
> b) the normal way with the ranges according to my reply above, works only
>     if the hardware mapping window can be reprogrammed that way:
>     linux port numbers 0-0xffff, pci port numbers 0-0xffff,
>     io_offset=0

This is what I currently have in the trace above, right? I also have
the same enumeration trace without any change at all defining
PCI_IOBASE as KSEG1 and without any modification in ranges property:

ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
               <0x01000000 0 0x1e160000 0x1e160000 0 0x00010000>;  /*
io space */

So it seems apparently changes do not have effect more than ranges
listed in logs or since I don't have a real pci card which uses IO
bars I cannot be sure about what is or not working at the end :(.
Thomas, do you have such a board with IO bars to test this and see
what works at the end??

>
>          Arnd

Thanks for your time.

Best regards,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=staging-testing#n485
