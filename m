Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8A1DE6E7
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgEVM33 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEVM30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 08:29:26 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0DC061A0E
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 05:29:25 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w18so10433679ilm.13
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJD3j3E6c3pyRvrU9+R7sbQB1f8wU9nKdn/YmVKc7bA=;
        b=eb1n781cW5blEkkA/Ck1RGV6Z8/5JAyLwpXGBV8x5/c3dE9UBqWyAjShh3pwOA02s7
         3NK+fweZlr2oT9cNhbDpPkQIaeuB+ax8fik+Tktn6cNKV1rB9XCKhj31qC/ebSjRXyvI
         BsmH0UnA1tiFSYM1OXcrlBw0qoIZVr5s3mBTY1KKk/6TVT6LfZPfYvUt9oHeZSM6hUa+
         fQnUHG7+8S65UIzls4j9ytk+VTG5s6+DaOQNpwPtJPV1CwWLHhNDQIqY3sMRpBGreKF3
         W/zaHzybtYDjzxzJLZ2vDOLmR3vQEfTRkhCdQeb2SAMt6FRYMlvwt+EJnnYplJ4dJ3Yf
         wQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJD3j3E6c3pyRvrU9+R7sbQB1f8wU9nKdn/YmVKc7bA=;
        b=J5jCvYAjn+wtJPyHJ7rbrvv3pIAvMusx7A37VT4MkPsvQiGo8m6MF8GhnSxP7nueR9
         COSkjFb6jGve6oEg5rdTgTKLBuXaThc5N8SXFxnMlILg1xf/Vj4xj1SAHqWSOz/ZUFJb
         5JnNuZokNKBQJWe7X77OzNqR+PxQyp200aTOczIWwKIjLjdkTUMgMWfnguJWfkxatfTh
         N0nesGR1ybDvvhqTzRd4j3FLJHNHwPCoI4IFdfKe4QcEfCXhbfxVv0iTk22peUf+umcE
         N80gjfAKhvwMJK06A8UTTJ4R/yPy8mOpcIhyxpAqLfNc1jBKi/MxsjYkJttcOoaW5+OZ
         8jrA==
X-Gm-Message-State: AOAM5308a9RABlp6fDdXbefHN1hm814Bia5arco0AvHNLUbh6lpb08Rf
        r4+SmUkKgSsU+h7S5gpyGVr9tFjO67AlwEB9w2DKE2rI
X-Google-Smtp-Source: ABdhPJzQZJ5FgbUMim5E//HF8ZMUniTRQdxkQU1QBD3QOfNhKGwoAlq5mGbq1qhsybdANo8UGbqcFLseCWj/Ujr1Vxg=
X-Received: by 2002:a92:4ca:: with SMTP id 193mr13198203ile.75.1590150564810;
 Fri, 22 May 2020 05:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
 <CANAwSgRXuMQaytB4BXL89JQAmU=XutBXj6iMhfKdZp3JwM9a4g@mail.gmail.com> <eb0acd3d-92d0-db00-78e4-8a17033f7f0a@rock-chips.com>
In-Reply-To: <eb0acd3d-92d0-db00-78e4-8a17033f7f0a@rock-chips.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 22 May 2020 17:59:14 +0530
Message-ID: <CANAwSgSzoc5TaO6ks9kdN7W+xDo1STbtsA0dUpsk8hqP6swkYg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIFBDSTogcm9ja2NoaXA6IEVuYWJsZSBJTyBiYXNlIGFuZCBsaQ==?=
        =?UTF-8?B?bWl0IHJlZ2lzdGVyc+OAkOivt+azqOaEj++8jOmCruS7tueUsWxpbnV4LXJvY2tjaGlwLWJvdW5jZXMr?=
        =?UTF-8?B?c2hhd24ubGluPXJvY2stY2hpcHMuY29tQGxpc3RzLmluZnJhZGVhZC5vcmfku6Plj5HjgJE=?=
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn

On Fri, 22 May 2020 at 08:30, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> =E5=9C=A8 2020/5/21 18:51, Anand Moon =E5=86=99=E9=81=93:
> > Hi Shawn,
> >
> > On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
> >>
> >> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
> >> be set, otherwise accessing to IO base and limit registers would
> >> fail.
> >>
> >> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
> >> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfb=
dfffff]
> >> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]=
 (bus address [0xfbe00000-0xfbefffff])
> >> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bus 00=
-00]), reconfiguring
> >> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x0000000=
0 invalid
> >> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x0000000=
0 invalid
> >> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0=
fffff]
> >> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0xfa0=
07fff pref]
> >> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0xfa0=
0ffff pref]
> >> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
> >> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0=
100]
> >> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0004]
> >> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0=
004]
> >> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
> >> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0=
fffff]
> >> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> >> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe PME i=
nterrupt
> >> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME interr=
upt
> >>
> >> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
> >>          Subsystem: Device 1c00:3853
> >>          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
> >>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >>          Interrupt: pin A routed to IRQ 230
> >>          Region 0: I/O ports at <unassigned> [disabled]
> >>          Region 1: Memory at fa000000 (32-bit, prefetchable) [disabled=
] [size=3D32K]
> >>          Region 2: I/O ports at <unassigned> [disabled]
> >>          [virtual] Expansion ROM at fa008000 [disabled] [size=3D32K]
> >>
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> ---
> >
> > I have old development board Odroid N1 (RK3399),  It has onboard PCIe
> > 2 dual sata bridge.
> > I have tested this patch, but I am still getting following log on
> > Odroid N1 board.
> > Is their any more configuration needed for sata ports ?
>
> Thanks for testing. I made a mistake that it should be bit 19, so
> can you try using BIT(19)?
>

Nop enable this bit dose not solve the issue see at my end.

But as per RK3399 TMR  17.6.7.1.45 Root Complex BAR Configuration Register
their are many bits that are not tuned correctly.
I tried to set some bit to BAR Configuration register. but it dose not
work at my end.
I feel some more core configuration is missing.
If I have some update I will share it with you.

-Anand
