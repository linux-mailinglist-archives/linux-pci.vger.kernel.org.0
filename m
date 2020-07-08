Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5210218AA8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgGHPBo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 11:01:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgGHPBo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jul 2020 11:01:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33951FB;
        Wed,  8 Jul 2020 08:01:42 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDC1C3F237;
        Wed,  8 Jul 2020 08:01:41 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:01:35 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: rockchip: =?utf-8?Q?E?=
 =?utf-8?B?bmFibGUgSU8gYmFzZSBhbmQgbGltaXQgcmVnaXN0ZXJz44CQ6K+35rOo5oSP?=
 =?utf-8?B?77yM6YKu5Lu255SxbGludXgtcm9ja2NoaXAtYm91bmNlcytzaGF3bi5saW49?=
 =?utf-8?B?cm9jay1jaGlwcy5jb21AbGlzdHMuaW5mcmFkZWFkLm9yZ+S7o+WPkeOAkQ==?=
Message-ID: <20200708150135.GA4238@e121166-lin.cambridge.arm.com>
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
 <CANAwSgRXuMQaytB4BXL89JQAmU=XutBXj6iMhfKdZp3JwM9a4g@mail.gmail.com>
 <eb0acd3d-92d0-db00-78e4-8a17033f7f0a@rock-chips.com>
 <CANAwSgSzoc5TaO6ks9kdN7W+xDo1STbtsA0dUpsk8hqP6swkYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgSzoc5TaO6ks9kdN7W+xDo1STbtsA0dUpsk8hqP6swkYg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 05:59:14PM +0530, Anand Moon wrote:
> Hi Shawn
> 
> On Fri, 22 May 2020 at 08:30, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >
> >
> > 在 2020/5/21 18:51, Anand Moon 写道:
> > > Hi Shawn,
> > >
> > > On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > >>
> > >> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
> > >> be set, otherwise accessing to IO base and limit registers would
> > >> fail.
> > >>
> > >> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
> > >> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
> > >> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
> > >> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > >> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
> > >> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
> > >> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
> > >> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0xfa007fff pref]
> > >> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0xfa00ffff pref]
> > >> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
> > >> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0100]
> > >> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0004]
> > >> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0004]
> > >> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
> > >> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
> > >> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> > >> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> > >> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> > >>
> > >> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
> > >>          Subsystem: Device 1c00:3853
> > >>          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >>          Interrupt: pin A routed to IRQ 230
> > >>          Region 0: I/O ports at <unassigned> [disabled]
> > >>          Region 1: Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32K]
> > >>          Region 2: I/O ports at <unassigned> [disabled]
> > >>          [virtual] Expansion ROM at fa008000 [disabled] [size=32K]
> > >>
> > >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > >> ---
> > >
> > > I have old development board Odroid N1 (RK3399),  It has onboard PCIe
> > > 2 dual sata bridge.
> > > I have tested this patch, but I am still getting following log on
> > > Odroid N1 board.
> > > Is their any more configuration needed for sata ports ?
> >
> > Thanks for testing. I made a mistake that it should be bit 19, so
> > can you try using BIT(19)?
> >
> 
> Nop enable this bit dose not solve the issue see at my end.
> 
> But as per RK3399 TMR  17.6.7.1.45 Root Complex BAR Configuration Register
> their are many bits that are not tuned correctly.
> I tried to set some bit to BAR Configuration register. but it dose not
> work at my end.
> I feel some more core configuration is missing.
> If I have some update I will share it with you.

What's the status of this discussion and therefore this series ?

Thanks,
Lorenzo
