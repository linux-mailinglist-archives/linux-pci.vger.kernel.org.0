Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBD2196DB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgGIDsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 23:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGIDsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 23:48:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E6C061A0B
        for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2020 20:48:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h16so833813ilj.11
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2020 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PoXF2GGLPW8laIrKv9lAbIzoYTIDe5kkX7RpK7sExqM=;
        b=DOXAU38ucIUEVT80FaDwmauOHmxr/AmoTLUOIRrHMwSw1nCpfIVmDo1QBtw0qIwsvM
         ke1XMCsovleiR71q6wnu02pCJnktk38+82kBqdsaqiw3OMg+P4a136bABKTxSx+N5ZhO
         ndD4L/yEgO5rGTMCIOo2wCJyJGWWetgIFBcbSUokb8gUWJgdNUwDPnrNPbj2704+nIhm
         ra3yfKu0sj3zIxCgSPbsyDidaXxsEBhPJhWn+2hTtDRPDugA5368dBgf72NMMEzwrhqy
         aQhiUiGQ6yKSiVFBCVt3zEgJiWN1PJq1ZPc2cqFFUZzfZTOAGrQxAPg/DG9WNiiTIcjG
         uGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PoXF2GGLPW8laIrKv9lAbIzoYTIDe5kkX7RpK7sExqM=;
        b=sjCgJZuygqOGAKAkK12ma779zUhc64cT978wZXrlGC6bzQ4lhnPJ5UhUo7Zbu+1Dlf
         eA7gAVUwGK8hjIlAC2HoO9Of/mhqJ/ilWbn9l3728qQhRgx0jVZQBmUJF9xZcF+VH//R
         kby890lz3BKnnyispDL5KG6SnSFtpCCnzi5GyjlyxY7pr/zo4KDTDD8n4tIDDQbKPXR4
         bGF+21bf90hU0y6nFzusHLG+1yab0o3v3Gn/7WgcxOPUiwA1XBgBxkjGouzMCzuWai+v
         UdLaeFi+ca9Idmav/EUvn6S+U/T6J1qPZIxMKCMYGv9d9nn+wY8fkWJy6+KwkKoRtsDf
         Nq/w==
X-Gm-Message-State: AOAM5339uZzfDs1Tju3IROUHst4psOev1JwdXJWdjpCmOnBBHZXQaj4L
        lWpIlFb9UKjpa1hpuFzfuni/zX6xO3eCObNxdGg=
X-Google-Smtp-Source: ABdhPJzS/TUePOK8+kbPig83fHDJWHTNS+AI7qk2GzPtsz6/YeX1eaMDd1RMjKyJ7Ieags+tXfOIBkNOK6aAdQIzaVc=
X-Received: by 2002:a92:98c2:: with SMTP id a63mr43300031ill.246.1594266519044;
 Wed, 08 Jul 2020 20:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
 <CANAwSgRXuMQaytB4BXL89JQAmU=XutBXj6iMhfKdZp3JwM9a4g@mail.gmail.com>
 <eb0acd3d-92d0-db00-78e4-8a17033f7f0a@rock-chips.com> <CANAwSgSzoc5TaO6ks9kdN7W+xDo1STbtsA0dUpsk8hqP6swkYg@mail.gmail.com>
 <20200708150135.GA4238@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200708150135.GA4238@e121166-lin.cambridge.arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 9 Jul 2020 09:18:27 +0530
Message-ID: <CANAwSgQO0yNOT6c+Bchfj08w1+aOqKzzTHMmrud-j7-Q=uDFjg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIFBDSTogcm9ja2NoaXA6IEVuYWJsZSBJTyBiYXNlIGFuZCBsaQ==?=
        =?UTF-8?B?bWl0IHJlZ2lzdGVyc+OAkOivt+azqOaEj++8jOmCruS7tueUsWxpbnV4LXJvY2tjaGlwLWJvdW5jZXMr?=
        =?UTF-8?B?c2hhd24ubGluPXJvY2stY2hpcHMuY29tQGxpc3RzLmluZnJhZGVhZC5vcmfku6Plj5HjgJE=?=
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

hi Lorenzo,

On Wed, 8 Jul 2020 at 20:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, May 22, 2020 at 05:59:14PM +0530, Anand Moon wrote:
> > Hi Shawn
> >
> > On Fri, 22 May 2020 at 08:30, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
> > >
> > >
> > > =E5=9C=A8 2020/5/21 18:51, Anand Moon =E5=86=99=E9=81=93:
> > > > Hi Shawn,
> > > >
> > > > On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> =
wrote:
> > > >>
> > > >> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
> > > >> be set, otherwise accessing to IO base and limit registers would
> > > >> fail.
> > > >>
> > > >> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
> > > >> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-=
0xfbdfffff]
> > > >> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xff=
fff] (bus address [0xfbe00000-0xfbefffff])
> > > >> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bu=
s 00-00]), reconfiguring
> > > >> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x000=
00000 invalid
> > > >> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x000=
00000 invalid
> > > >> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0=
xfa0fffff]
> > > >> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0=
xfa007fff pref]
> > > >> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0=
xfa00ffff pref]
> > > >> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0=
100]
> > > >> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size=
 0x0100]
> > > >> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0=
004]
> > > >> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size=
 0x0004]
> > > >> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
> > > >> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0=
xfa0fffff]
> > > >> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 000=
2)
> > > >> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe P=
ME interrupt
> > > >> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME in=
terrupt
> > > >>
> > > >> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
> > > >>          Subsystem: Device 1c00:3853
> > > >>          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoo=
p- ParErr- Stepping- SERR- FastB2B- DisINTx-
> > > >>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >=
TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > > >>          Interrupt: pin A routed to IRQ 230
> > > >>          Region 0: I/O ports at <unassigned> [disabled]
> > > >>          Region 1: Memory at fa000000 (32-bit, prefetchable) [disa=
bled] [size=3D32K]
> > > >>          Region 2: I/O ports at <unassigned> [disabled]
> > > >>          [virtual] Expansion ROM at fa008000 [disabled] [size=3D32=
K]
> > > >>
> > > >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > >> ---
> > > >
> > > > I have old development board Odroid N1 (RK3399),  It has onboard PC=
Ie
> > > > 2 dual sata bridge.
> > > > I have tested this patch, but I am still getting following log on
> > > > Odroid N1 board.
> > > > Is their any more configuration needed for sata ports ?
> > >
> > > Thanks for testing. I made a mistake that it should be bit 19, so
> > > can you try using BIT(19)?
> > >
> >
> > Nop enable this bit dose not solve the issue see at my end.
> >
> > But as per RK3399 TMR  17.6.7.1.45 Root Complex BAR Configuration Regis=
ter
> > their are many bits that are not tuned correctly.
> > I tried to set some bit to BAR Configuration register. but it dose not
> > work at my end.
> > I feel some more core configuration is missing.
> > If I have some update I will share it with you.
>
> What's the status of this discussion and therefore this series ?
>
> Thanks,
> Lorenzo

Well I have looked into the RK3399 TRM  (Rockchip RK3399 TRM V1.3 Part2.pdf=
)
There seems to be some core configuration missing, but I could not
resolve this on my board.

Best Regards
-Anand
