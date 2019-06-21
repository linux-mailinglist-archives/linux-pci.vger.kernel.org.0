Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFD4DF7A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 06:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFUEDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 00:03:33 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59664 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfFUEDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 00:03:32 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A5C0B886BF;
        Fri, 21 Jun 2019 16:03:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1561089808;
        bh=DAK5yPtszayhwjnlTmBc3QE84ABr3J9qrB+j9wai8/U=;
        h=From:To:Subject:Date;
        b=CVXLgrRQjsbJfXD/0VBKrS9Y2Ml7wN6I8sMiz3AN1/RrzxW/+MH8Lz8MV2q/05/Tz
         LD5JHSXjt5+aQZKf9yXzapBpXw4ocA1SHfBQMJGEj7BZykMgHdVhPKp4NR7piiloBU
         10kQnDowcLz2X1mPjhO4COv/KfsbZgstTzIu/tq2aUkDKr33PJbqEFEu66uchqgyXN
         oQLt/RON+sdaJf+op30kgTcTyvnsICCV5QHVhNlaT7Yd4aND1d955RtiTfrNqiy9tf
         c/7jt6P3bVgeyA2uBGSHSJdD4Z/oy7zV6DYN5hGF9s1dUHtlrk4xkuRp3YFTlWbhPq
         /BNsJI2dwoTUQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d0c57100001>; Fri, 21 Jun 2019 16:03:28 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 21 Jun 2019 16:03:28 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 21 Jun 2019 16:03:28 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Kirkwood PCI Express and bridges
Thread-Topic: Kirkwood PCI Express and bridges
Thread-Index: AQHVJ+ZHqWcIqP7kgUutSbOlaor9TQ==
Date:   Fri, 21 Jun 2019 04:03:27 +0000
Message-ID: <403548ec3a7543b08ca32e47a1465e70@svr-chch-ex1.atlnz.lc>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,=0A=
=0A=
I'm in the process of updating the kernel version used on our products =0A=
from 4.4 -> 5.1.=0A=
=0A=
We have one product that uses a Kirkwood CPU, IDT PCI bridge and Marvell =
=0A=
Switch ASIC. The Switch ASIC presents as multiple PCI devices.=0A=
=0A=
The hardware setup looks like this=0A=
                                        __________=0A=
[ Kirkwood ] --- [ IDT 5T5 ] ---+---  |          |=0A=
                                 +---  |  Switch  |=0A=
                                 +---  |          |=0A=
                                 +---  |__________|=0A=
=0A=
On the 4.4 based kernel things are fine=0A=
=0A=
[root@awplus flash]# lspci -t=0A=
-[0000:00]---01.0-[01-06]----00.0-[02-06]--+-02.0-[03]----00.0=0A=
                                            +-03.0-[04]----00.0=0A=
                                            +-04.0-[05]----00.0=0A=
                                            \-05.0-[06]----00.0=0A=
=0A=
But on the 5.1 based kernel things get a little weird=0A=
=0A=
[root@awplus flash]# lspci -t=0A=
-[0000:00]---01.0-[01-06]--+-00.0-[02-06]--=0A=
                            +-01.0=0A=
                            +-02.0-[02-06]--=0A=
                            +-03.0-[02-06]--=0A=
                            +-04.0-[02-06]--=0A=
                            +-05.0-[02-06]--=0A=
                            +-06.0-[02-06]--=0A=
                            +-07.0-[02-06]--=0A=
                            +-08.0-[02-06]--=0A=
                            +-09.0-[02-06]--=0A=
                            +-0a.0-[02-06]--=0A=
                            +-0b.0-[02-06]--=0A=
                            +-0c.0-[02-06]--=0A=
                            +-0d.0-[02-06]--=0A=
                            +-0e.0-[02-06]--=0A=
                            +-0f.0-[02-06]--=0A=
                            +-10.0-[02-06]--=0A=
                            +-11.0-[02-06]--=0A=
                            +-12.0-[02-06]--=0A=
                            +-13.0-[02-06]--=0A=
                            +-14.0-[02-06]--=0A=
                            +-15.0-[02-06]--=0A=
                            +-16.0-[02-06]--=0A=
                            +-17.0-[02-06]--=0A=
                            +-18.0-[02-06]--=0A=
                            +-19.0-[02-06]--=0A=
                            +-1a.0-[02-06]--=0A=
                            +-1b.0-[02-06]--=0A=
                            +-1c.0-[02-06]--=0A=
                            +-1d.0-[02-06]--=0A=
                            +-1e.0-[02-06]--=0A=
                            \-1f.0-[02-06]--+-02.0-[03]----00.0=0A=
                                            +-03.0-[04]----00.0=0A=
                                            +-04.0-[05]----00.0=0A=
                                            \-05.0-[06]----00.0=0A=
=0A=
=0A=
I'll start bisecting to see where things started going wrong. I just =0A=
wondered if this rings any bells for anyone.=0A=
=0A=
The startup output also seems to be quite unhappy=0A=
=0A=
Detected board: alliedtelesis,SBx81GC40=0A=
Booting into Linux kernel ...=0A=
** 143 printk messages dropped **=0A=
pci 0000:01:19.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:01:1a.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:01:1a.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:01:1b.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:01:1b.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:01:1c.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:01:1c.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:01:1d.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:01:1d.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:01:1e.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:01:1e.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:01:1f.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:01:1f.0: PME# supported from D0 D3hot D3cold=0A=
PCI: bus1: Fast back to back transfers disabled=0A=
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:06.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:08.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:09.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:0a.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:0b.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:0c.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:0d.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:0e.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:0f.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:10.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:11.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:12.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:13.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:14.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:15.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:16.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:17.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:18.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:19.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:1a.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:1b.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:1c.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:1d.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:1e.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:01:1f.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:02:02.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:02:02.0: enabling Extended Tags=0A=
pci 0000:02:02.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:02:03.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:02:03.0: enabling Extended Tags=0A=
pci 0000:02:03.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:02:04.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:02:04.0: enabling Extended Tags=0A=
pci 0000:02:04.0: PME# supported from D0 D3hot D3cold=0A=
pci 0000:02:05.0: [111d:803c] type 01 class 0x060400=0A=
pci 0000:02:05.0: enabling Extended Tags=0A=
pci 0000:02:05.0: PME# supported from D0 D3hot D3cold=0A=
PCI: bus2: Fast back to back transfers disabled=0A=
pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:02:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring=
=0A=
pci 0000:03:00.0: [11ab:e023] type 00 class 0x058000=0A=
pci 0000:03:00.0: reg 0x10: [mem 0xd0000000-0xd00fffff 64bit pref]=0A=
pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x03ffffff 64bit]=0A=
PCI: bus3: Fast back to back transfers disabled=0A=
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03=0A=
pci 0000:04:00.0: [11ab:e023] type 00 class 0x058000=0A=
pci 0000:04:00.0: reg 0x10: [mem 0xd0000000-0xd00fffff 64bit pref]=0A=
pci 0000:04:00.0: reg 0x18: [mem 0x00000000-0x03ffffff 64bit]=0A=
PCI: bus4: Fast back to back transfers disabled=0A=
pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04=0A=
pci 0000:05:00.0: [11ab:e023] type 00 class 0x058000=0A=
pci 0000:05:00.0: reg 0x10: [mem 0xd0000000-0xd00fffff 64bit pref]=0A=
pci 0000:05:00.0: reg 0x18: [mem 0x00000000-0x03ffffff 64bit]=0A=
PCI: bus5: Fast back to back transfers disabled=0A=
pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05=0A=
pci 0000:06:00.0: [11ab:e023] type 00 class 0x058000=0A=
pci 0000:06:00.0: reg 0x10: [mem 0xd0000000-0xd00fffff 64bit pref]=0A=
pci 0000:06:00.0: reg 0x18: [mem 0x00000000-0x03ffffff 64bit]=0A=
PCI: bus6: Fast back to back transfers disabled=0A=
pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06=0A=
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 06=0A=
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 06=0A=
pci 0000:00:01.0: BAR 8: no space for [mem size 0x1c000000]=0A=
pci 0000:00:01.0: BAR 8: failed to assign [mem size 0x1c000000]=0A=
pci 0000:00:01.0: BAR 6: assigned [mem 0xe0000000-0xe00007ff pref]=0A=
pci 0000:01:01.0: BAR 2: no space for [mem size 0x08000000]=0A=
pci 0000:01:01.0: BAR 2: failed to assign [mem size 0x08000000]=0A=
pci 0000:01:00.0: BAR 8: no space for [mem size 0x10000000]=0A=
pci 0000:01:00.0: BAR 8: failed to assign [mem size 0x10000000]=0A=
pci 0000:01:00.0: BAR 9: no space for [mem size 0x00400000 64bit pref]=0A=
pci 0000:01:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit pref]=
=0A=
pci 0000:01:01.0: BAR 0: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:01:01.0: BAR 0: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:02.0: BAR 8: no space for [mem size 0x04000000]=0A=
pci 0000:02:02.0: BAR 8: failed to assign [mem size 0x04000000]=0A=
pci 0000:02:03.0: BAR 8: no space for [mem size 0x04000000]=0A=
pci 0000:02:03.0: BAR 8: failed to assign [mem size 0x04000000]=0A=
pci 0000:02:04.0: BAR 8: no space for [mem size 0x04000000]=0A=
pci 0000:02:04.0: BAR 8: failed to assign [mem size 0x04000000]=0A=
pci 0000:02:05.0: BAR 8: no space for [mem size 0x04000000]=0A=
pci 0000:02:05.0: BAR 8: failed to assign [mem size 0x04000000]=0A=
pci 0000:02:02.0: BAR 9: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:02:02.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:03.0: BAR 9: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:02:03.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:04.0: BAR 9: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:02:04.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:05.0: BAR 9: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:02:05.0: BAR 9: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:03:00.0: BAR 2: no space for [mem size 0x04000000 64bit]=0A=
pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]=0A=
pci 0000:03:00.0: BAR 0: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:02.0: PCI bridge to [bus 03]=0A=
pci 0000:04:00.0: BAR 2: no space for [mem size 0x04000000 64bit]=0A=
pci 0000:04:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]=0A=
pci 0000:04:00.0: BAR 0: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:04:00.0: BAR 0: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:03.0: PCI bridge to [bus 04]=0A=
pci 0000:05:00.0: BAR 2: no space for [mem size 0x04000000 64bit]=0A=
pci 0000:05:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]=0A=
pci 0000:05:00.0: BAR 0: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:05:00.0: BAR 0: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:04.0: PCI bridge to [bus 05]=0A=
pci 0000:06:00.0: BAR 2: no space for [mem size 0x04000000 64bit]=0A=
pci 0000:06:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]=0A=
pci 0000:06:00.0: BAR 0: no space for [mem size 0x00100000 64bit pref]=0A=
pci 0000:06:00.0: BAR 0: failed to assign [mem size 0x00100000 64bit pref]=
=0A=
pci 0000:02:05.0: PCI bridge to [bus 06]=0A=
pci 0000:01:00.0: PCI bridge to [bus 02-06]=0A=
pci 0000:00:01.0: PCI bridge to [bus 01-06]=0A=
