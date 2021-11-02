Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ABD443130
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhKBPFX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 11:05:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:56339 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232743AbhKBPFW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 11:05:22 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mhvJC-0005rk-00; Tue, 02 Nov 2021 16:02:42 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2DAE0C291E; Tue,  2 Nov 2021 16:02:01 +0100 (CET)
Date:   Tue, 2 Nov 2021 16:02:01 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211102150201.GA11675@alpha.franken.de>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102100034.rhcb3k2jvr6alm6y@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 02, 2021 at 11:00:34AM +0100, Pali Rohár wrote:
> > > But I do not have this hardware to verify it.
> > 
> > I still have a few Cobalt systems here.
> 
> Perfect! It would help if you could provide 'lspci -nn -vv' output from
> that system. In case you have very old version of lspci on that system
> you could try to run it with '-xxxx' (or '-xxx') which prints hexdump
> and I can parse it with local lspci.

not sure, if you still needed:

root@raq2:~# lspci -nn -vv
00:00.0 Host bridge [0600]: Marvell Technology Group Ltd. Device [11ab:4146] (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+ INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 0
	Region 1: Memory at 08000000 (32-bit, non-prefetchable) [size=128M]
	Region 2: Memory at 1c000000 (32-bit, non-prefetchable) [size=32M]
	Region 3: Memory at 1f000000 (32-bit, non-prefetchable) [size=16M]
	Region 4: Memory at 14000000 (32-bit, non-prefetchable) [size=4K]
	Region 5: I/O ports at 4000000 [disabled] [size=4K]


root@raq2:~# lspci -xxxx
00:00.0 Host bridge: Marvell Technology Group Ltd. Device 4146 (rev 11)
00: ab 11 46 41 06 00 80 a2 11 00 80 05 08 40 00 00
10: 00 00 00 00 00 00 00 08 00 00 00 1c 00 00 00 1f
20: 00 00 00 14 01 00 00 14 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
