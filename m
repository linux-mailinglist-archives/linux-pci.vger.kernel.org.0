Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482EC417028
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 12:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbhIXKRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbhIXKR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 06:17:27 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1BFC061574;
        Fri, 24 Sep 2021 03:15:54 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 66so5473521vsd.11;
        Fri, 24 Sep 2021 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWzAuoAx0x6C60oqvQg3+s0A8XB5lYSbm0D79M0PHIg=;
        b=akE98d7KNnUB8ou3yG6z1OiQn9dha9VDA4dSwqUy+KIk/72FRJnP3rBi2XdUpxJsmF
         GR6GRtnBoAFtyhiaq94zyrwZ6BjEw8Fc08eqDBBcBogKNLUqQnGnq3DZlGSbXboJs8E9
         8nl0rT0otbFPb/2QwqAzFIEfmsqkfNTRrPEXXPaWQUrNFyhkvBBbkXb1J8bZhXF9/c/H
         1Ggp2RTCUbmo/U01jsEUsWtkDg5A+RkgTX2clcH5W2B8IzED42qdXf2QLil3haZOFqqh
         Xh/DtHeb0NGJE7CEejJ0pdooLznconWoNQDgt4itP8cpI3ditgSz2eVKUWKJ7gzez0MI
         hQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWzAuoAx0x6C60oqvQg3+s0A8XB5lYSbm0D79M0PHIg=;
        b=LKMzfY4LPRVxrb4WPWUuV1oCiei9x56wogFYoMK4R2VQI46Q+GSV6csbbTrLmd96ME
         BWHaTczBEz5zNhPV4gZaDiIm8kfPijBf20tSzLGrUIkuM6IDZV/0bY80QNUrYQfGWvTg
         Uvx5VZ4mPnQcHz+BEaq5KSedN/5h5l6g69iQbpaZG79CSxt9cx0I7k4I7VwuMYNrfd0Y
         X8HReR1oZ1bCs6v7a8DKOlLCxW/2M26nsvqmS520gnvrxscHqB0K8TaVlkffQIN4852W
         GeOXLhMDo9NtXzb5IV0dTqL9VpJzXz9YdrxRjn8sa63vPD1sAlHKP0A1uBOamAloxyx9
         Fz7Q==
X-Gm-Message-State: AOAM532sLpbuUV9IerHFS/mannmSBTSQOrFS0nqPtJWIJgo5uVeHYXop
        a/jIo1d/IBhDxb/61pAi+n/ijM/SgvbdBBu+YtWKaXsaGCg=
X-Google-Smtp-Source: ABdhPJzWegOgiE/K3REHF6d11Pfy37b8qwo5XxjAMWi+6A1LzKFZkPF+rR+COwm5Ux3G2EwymXtmdI8nWV1th49GVco=
X-Received: by 2002:a67:3204:: with SMTP id y4mr8041976vsy.28.1632478553713;
 Fri, 24 Sep 2021 03:15:53 -0700 (PDT)
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
 <CAMhs-H_xdkpinyj-Y1u==ievpGWZ2Ze-_U7aCUcfu0=NKBq2xQ@mail.gmail.com>
 <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com>
 <CAMhs-H9xrXgbuwYe2STzuq0aBwj0onJGc0Oka6+pzgoHb0j8rA@mail.gmail.com> <CAK8P3a1AwaSi_J9p4tKwNKxENHhwofDu=Ma=F29ajSmMXoC7RA@mail.gmail.com>
In-Reply-To: <CAK8P3a1AwaSi_J9p4tKwNKxENHhwofDu=Ma=F29ajSmMXoC7RA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 24 Sep 2021 12:15:42 +0200
Message-ID: <CAMhs-H_wxoJC7ZVnkhXNfAcP-P9BNN99ogszM_iJhErHLq8Rdg@mail.gmail.com>
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

On Fri, Sep 24, 2021 at 10:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 23, 2021 at 10:33 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Thu, Sep 23, 2021 at 7:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Sep 23, 2021 at 4:55 PM Sergio Paracuellos
> > >
> > > Ok, got it. So the memory space uses a normal zero offset with cpu address
> > > equal to bus address, but the I/O space has a rather usual mapping of
> > > bus address equal to the window into the mmio space, with an offset of
> > > 0x1e160000.
> > >
> > > The normal way to do this would be map the PCI port range 0-0x10000
> > > into CPU address 0x1e160000, like:
> > >
> > > ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
> > >                <0x01000000 0 0x1e160000 0 0 0x00010000>;
> >
> > This change as it is got into the same behaviour:
> >
> > mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
> > mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000,
> > using [bus 00-ff]
> > mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
> > mt7621-pci 1e140000.pcie:       IO 0x0000000000..0x000000ffff -> 0x001e160000
> >                                                    ^^^^^^
> >                                                     This is the only
> > change I appreciate in all the trace with the range change.
>
> Oops, my mistake, I mixed up the CPU address and the PCI address.
>
> The correct notation should be
>
> <0x01000000 0 0  0 0x1e160000 0x00010000>;
>
> i.e. bus address 0 to cpu address 0x1e160000, rather than the other
> way around as I wrote it.

Mmmm... Do you mean <0x01000000 0 0  0x1e160000 0 0x00010000>; instead?

In any case both of them ends up in a similar trace (the one listed
here is using your last range as it is):

mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000,
using [bus 00-ff]
mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
mt7621-pci 1e140000.pcie:       IO 0x0000000000..0x1e1600000000ffff ->
0x0000000000
                                                   ^^^^
                                                    This is the part
that change between both traces (t7621-pci 1e140000.pcie:       IO
0x001e160000..0x001e16ffff -> 0x0000000000 in the one I have just put
above)
mt7621-pci 1e140000.pcie: Writing 0x0 in RALINK_PCI_IOBASE
                                                  ^^^
                                                     This is the
current value written in bridge register as IOBASE for the window
which is IORESOURCE_IO -> res.start address (in both traces).

mt7621-pci 1e140000.pcie: PCIE0 enabled
mt7621-pci 1e140000.pcie: PCIE1 enabled
mt7621-pci 1e140000.pcie: PCIE2 enabled
mt7621-pci 1e140000.pcie: PCI coherence region base: 0x60000000,
mask/settings: 0xf0000002
mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
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
pci 0000:01:00.0: reg 0x10: [io  0x0000-0x0007]
pci 0000:01:00.0: reg 0x14: [io  0x0000-0x0003]
pci 0000:01:00.0: reg 0x18: [io  0x0000-0x0007]
pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x0003]
pci 0000:01:00.0: reg 0x20: [io  0x0000-0x000f]
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
pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
pci 0000:02:00.0: reg 0x14: [io  0x0000-0x0003]
pci 0000:02:00.0: reg 0x18: [io  0x0000-0x0007]
pci 0000:02:00.0: reg 0x1c: [io  0x0000-0x0003]
pci 0000:02:00.0: reg 0x20: [io  0x0000-0x000f]
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
pci 0000:03:00.0: reg 0x10: [io  0x0000-0x0007]
pci 0000:03:00.0: reg 0x14: [io  0x0000-0x0003]
pci 0000:03:00.0: reg 0x18: [io  0x0000-0x0007]
pci 0000:03:00.0: reg 0x1c: [io  0x0000-0x0003]
pci 0000:03:00.0: reg 0x20: [io  0x0000-0x000f]
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
pci 0000:00:02.0:   bridge window [mem 0x60500000-0x605fffff pref]

Also, I noticed that all of these messages have disappeared from the trace:

pci 0000:03:00.0: reg 0x20: initial BAR value 0x00000000 invalid

and now the first tested value seems to be valid....

No changes in ioports also:

root@gnubee:~# cat /proc/ioports
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
root@gnubee:~#


>
> > pci 0000:00:02.0: PCI bridge to [bus 03-ff]
> > pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff pref]
> ...
> > pci 0000:00:02.0: PCI bridge to [bus 03]
> > pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
> > pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
> > pci 0000:00:02.0:   bridge window [mem 0x60500000-0x605fffff pref
> >
> > # cat /proc/ioports
> > 00000000-0000ffff : pcie@1e140000
> >   00000000-00000fff : PCI Bus 0000:01
> >     00000000-0000000f : 0000:01:00.0
> >       00000000-0000000f : ahci
> >     00000010-00000017 : 0000:01:00.0
> ...
>
> These are all what I would expect, but that should just be
> based on the PCI_IOBASE value, not the mapping behind that.
>
> > > Do you know where that mapping is set up? Is this a hardware setting,
> > > or is there a way to change the inbound I/O port ranges to the
> > > normal mapping?
> >
> > The only thing related is the IOBASE register which is the base
> > address for the IO space window. Driver code is setting this up to pci
> > IO resource start address [0].
>
> So this line:
>       pcie_write(pcie, entry->res->start, RALINK_PCI_IOBASE);
>
> That does sound like it is the bus address you are writing, not
> the CPU address. Some host bridges allow you to configure both,
> some only one of them, but the sensible assumption here would
> be that this is the bus address if only one is configurable.
>
> If my assumption is correct here, then you must write the value
> that you have read from the DT property, which would be
> 0x001e160000 or 0 in the two versions of the DT property we
> have listed, but in theory any (properly aligned) number ought
> to work here, as long as the BAR values, the RALINK_PCI_IOBASE
> and the io_offset all agree what it is.

RALINK_PCI_IOBASE in that line, is the bridge register you write with
value from the IO resource created from DT property, yes. So I guess
you meant PCI_IOBASE for ralink in this sentence, right?

(Prototype of the function -> static inline void pcie_write(struct
mt7621_pcie *pcie, u32 val, u32 reg))

>
> The line just before this is
>
> pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE)
>
> Can you clarify what this does? I would have expected an
> identity-map for the memory space, which would mean writing
> the third cell from the ranges property (0x60000000)
> into this. Is -1 a special value for identity mapping, or does
> this register do something else?

That was also my understanding at first when I took this code and
started playing with it since the register is the base address for the
memory space window. Setting the value you pointed out worked for me
(and makes sense), but some people seem to have problems with some
cards when accessing PCI memory resources. That's the only reason I
have maintained the original value but I don't really understand what
it means. The same value is used in mt7620 which has a pretty similar
topology but with one only virtual bridge behind the host-bridge [0].
However there is no documentation for mt7621 PCI subsystem and the one
that exists for mt7620 PCI does not clarify much more [1].

Thanks,
     Sergio Paracuellos
>
>           Arnd

[0]: https://elixir.bootlin.com/linux/latest/source/arch/mips/pci/pci-mt7620.c#L342
[1]: https://usermanual.wiki/Pdf/MT7620ProgrammingGuideE220120815.111503371
