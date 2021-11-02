Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C81443156
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 16:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhKBPQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 11:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhKBPQL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 11:16:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D3C960F24;
        Tue,  2 Nov 2021 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635866016;
        bh=BB+R/uffB4V5gOFeD0uput1lLasOetsv77SLC1aQ4KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oea2cXP0x/vG+90qMT5cqaYMw/jruITLkn/ngexh6Bs/p3B8J+sDonHOvvogcpz7i
         9QA+pK2OlRC7ZNhuP9WIQ/PxRXEaXdpDIchYSuMPp7R60WaH1I1g+roBXKuK5yhuK1
         EipGwOvnxrpo7zyXUAR7h1yy9D4k5BkW+Qd5hwQZJJNWH1ImMacnjz9olkfBSell59
         XS9ZPfXUAd3f7zrGmgo7JgRzIdgqWcXJ/VxTZX+3+y947c5s1nDkd/UvjnJXfIONun
         LEYH/lxywQvkU5O7xUQo3eFm1uab5WRQ0O77L/fGAWdkrfMmk/u7f+F+nJoY5WdVB6
         G2o5u/O/N0x5A==
Received: by pali.im (Postfix)
        id 4B64CA41; Tue,  2 Nov 2021 16:13:34 +0100 (CET)
Date:   Tue, 2 Nov 2021 16:13:34 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211102151334.2pispbz6zfewworr@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
 <20211102150201.GA11675@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102150201.GA11675@alpha.franken.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 16:02:01 Thomas Bogendoerfer wrote:
> On Tue, Nov 02, 2021 at 11:00:34AM +0100, Pali Rohár wrote:
> > > > But I do not have this hardware to verify it.
> > > 
> > > I still have a few Cobalt systems here.
> > 
> > Perfect! It would help if you could provide 'lspci -nn -vv' output from
> > that system. In case you have very old version of lspci on that system
> > you could try to run it with '-xxxx' (or '-xxx') which prints hexdump
> > and I can parse it with local lspci.
> 
> not sure, if you still needed:
> 
> root@raq2:~# lspci -nn -vv
> 00:00.0 Host bridge [0600]: Marvell Technology Group Ltd. Device [11ab:4146] (rev 11)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+ INTx-
> 	Latency: 64, Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 0
> 	Region 1: Memory at 08000000 (32-bit, non-prefetchable) [size=128M]
> 	Region 2: Memory at 1c000000 (32-bit, non-prefetchable) [size=32M]
> 	Region 3: Memory at 1f000000 (32-bit, non-prefetchable) [size=16M]
> 	Region 4: Memory at 14000000 (32-bit, non-prefetchable) [size=4K]
> 	Region 5: I/O ports at 4000000 [disabled] [size=4K]
> 
> 
> root@raq2:~# lspci -xxxx
> 00:00.0 Host bridge: Marvell Technology Group Ltd. Device 4146 (rev 11)
> 00: ab 11 46 41 06 00 80 a2 11 00 80 05 08 40 00 00

                                 ^^ ^^ ^^
                           Here is class code

So it confirms that PCI Class code is 0580 which is Memory Controller.
And not Host Bridge as it should be.

If I put this hexdump into dump.txt and run 'lspci -F dump.txt -nn' then I see:
00:00.0 Memory controller [0580]: Marvell Technology Group Ltd. Device [11ab:4146] (rev 11)

In your output above is "Host bridge" which means that quirk was applied:
00:00.0 Host bridge [0600]: Marvell Technology Group Ltd. Device [11ab:4146] (rev 11)

(I guess in 'lspci -nn -vv -b' should be Memory controller as lspci with
'-b' should not see that quirk change)

> 10: 00 00 00 00 00 00 00 08 00 00 00 1c 00 00 00 1f
> 20: 00 00 00 14 01 00 00 14 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
