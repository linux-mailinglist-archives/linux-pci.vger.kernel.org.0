Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070A544B967
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 00:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhKIXpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 18:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhKIXpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 18:45:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8590A61027;
        Tue,  9 Nov 2021 23:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636501376;
        bh=BwdL6hKGsFQi16znK9Djy6H4M5eAcr9CGcEAo/TTtmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbUOFEr9QtwRK33Lo40XrXne0+MJgcYe+xl1Lv0/HUAFE37h+cwtP2FAQPxHgba9M
         24wW9ylW93f8LLb5cMT5bigrSpdNZCNTqVW1W+MAxp3l4MYvj4/asVgWs5jK0COFwb
         8aQDKaEF1Yw4Gh4fONSAnK6SuzJu9I49UPGkP9+pokTMCDPtwcHr50upqjdEvoUwEE
         NzimRktO0d3T8aBi16Cc0MaluilpydOEbiR6exi9QuzHh1OaP53dZQ/dwt7Pf95zkY
         7QtPdRdzI/MZ2jERqxm8kBjwSq8GhtdqX0wwiWy1uF5NOg2n7eo8q7yDop8NiLbyAB
         zMGd8OoxMTR4w==
Received: by pali.im (Postfix)
        id 2BDB7795; Wed, 10 Nov 2021 00:42:54 +0100 (CET)
Date:   Wed, 10 Nov 2021 00:42:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211109234253.gppjkiew7e2ufz3a@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
 <20211102150201.GA11675@alpha.franken.de>
 <20211102151334.2pispbz6zfewworr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102151334.2pispbz6zfewworr@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 16:13:34 Pali Rohár wrote:
> On Tuesday 02 November 2021 16:02:01 Thomas Bogendoerfer wrote:
> > On Tue, Nov 02, 2021 at 11:00:34AM +0100, Pali Rohár wrote:
> > > > > But I do not have this hardware to verify it.
> > > > 
> > > > I still have a few Cobalt systems here.
> > > 
> > > Perfect! It would help if you could provide 'lspci -nn -vv' output from
> > > that system. In case you have very old version of lspci on that system
> > > you could try to run it with '-xxxx' (or '-xxx') which prints hexdump
> > > and I can parse it with local lspci.

Thomas, one more question, do you have also GT-64115 system which has
PCI device id 0x4611? Based on Maciej quote, GT-64115 probably also
reports itself as "Memory controller" instead of "Host Bridge". So lspci
output from GT-64115 could be also interesting.

> > not sure, if you still needed:
> > 
> > root@raq2:~# lspci -nn -vv
> > 00:00.0 Host bridge [0600]: Marvell Technology Group Ltd. Device [11ab:4146] (rev 11)
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> > 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+ INTx-
> > 	Latency: 64, Cache Line Size: 32 bytes
> > 	Interrupt: pin A routed to IRQ 0
> > 	Region 1: Memory at 08000000 (32-bit, non-prefetchable) [size=128M]
> > 	Region 2: Memory at 1c000000 (32-bit, non-prefetchable) [size=32M]
> > 	Region 3: Memory at 1f000000 (32-bit, non-prefetchable) [size=16M]
> > 	Region 4: Memory at 14000000 (32-bit, non-prefetchable) [size=4K]
> > 	Region 5: I/O ports at 4000000 [disabled] [size=4K]
> > 
> > 
> > root@raq2:~# lspci -xxxx
> > 00:00.0 Host bridge: Marvell Technology Group Ltd. Device 4146 (rev 11)
> > 00: ab 11 46 41 06 00 80 a2 11 00 80 05 08 40 00 00
> 
>                                  ^^ ^^ ^^
>                            Here is class code
> 
> So it confirms that PCI Class code is 0580 which is Memory Controller.
> And not Host Bridge as it should be.
> 
> If I put this hexdump into dump.txt and run 'lspci -F dump.txt -nn' then I see:
> 00:00.0 Memory controller [0580]: Marvell Technology Group Ltd. Device [11ab:4146] (rev 11)
> 
> In your output above is "Host bridge" which means that quirk was applied:
> 00:00.0 Host bridge [0600]: Marvell Technology Group Ltd. Device [11ab:4146] (rev 11)
> 
> (I guess in 'lspci -nn -vv -b' should be Memory controller as lspci with
> '-b' should not see that quirk change)
> 
> > 10: 00 00 00 00 00 00 00 08 00 00 00 1c 00 00 00 1f
> > 20: 00 00 00 14 01 00 00 14 00 00 00 00 00 00 00 00
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 
> > Thomas.
> > 
> > -- 
> > Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> > good idea.                                                [ RFC1925, 2.3 ]
