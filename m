Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530D844BD6F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 09:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhKJI7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 03:59:05 -0500
Received: from elvis.franken.de ([193.175.24.41]:40496 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhKJI7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 03:59:05 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mkjOu-0001M7-00; Wed, 10 Nov 2021 09:56:12 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0C332C2C40; Wed, 10 Nov 2021 09:55:44 +0100 (CET)
Date:   Wed, 10 Nov 2021 09:55:43 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211110085543.GC5976@alpha.franken.de>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
 <20211102150201.GA11675@alpha.franken.de>
 <20211102151334.2pispbz6zfewworr@pali>
 <20211109234253.gppjkiew7e2ufz3a@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211109234253.gppjkiew7e2ufz3a@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 10, 2021 at 12:42:53AM +0100, Pali Rohár wrote:
> On Tuesday 02 November 2021 16:13:34 Pali Rohár wrote:
> > On Tuesday 02 November 2021 16:02:01 Thomas Bogendoerfer wrote:
> > > On Tue, Nov 02, 2021 at 11:00:34AM +0100, Pali Rohár wrote:
> > > > > > But I do not have this hardware to verify it.
> > > > > 
> > > > > I still have a few Cobalt systems here.
> > > > 
> > > > Perfect! It would help if you could provide 'lspci -nn -vv' output from
> > > > that system. In case you have very old version of lspci on that system
> > > > you could try to run it with '-xxxx' (or '-xxx') which prints hexdump
> > > > and I can parse it with local lspci.
> 
> Thomas, one more question, do you have also GT-64115 system which has
> PCI device id 0x4611? Based on Maciej quote, GT-64115 probably also
> reports itself as "Memory controller" instead of "Host Bridge". So lspci
> output from GT-64115 could be also interesting.

The only systems with GT64-xxx chips I have are Cobalt systems, but none of
them has a GT-64115 chip (Raq1 comes with GT-64011 and Raq2 with GT-64111).

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
