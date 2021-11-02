Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7451442E43
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 13:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhKBMiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 08:38:17 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:36538 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBMiR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 08:38:17 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3024692009D; Tue,  2 Nov 2021 13:35:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 29DCA92009B;
        Tue,  2 Nov 2021 12:35:41 +0000 (GMT)
Date:   Tue, 2 Nov 2021 12:35:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
In-Reply-To: <20211102100034.rhcb3k2jvr6alm6y@pali>
Message-ID: <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
References: <20211101150405.14618-1-pali@kernel.org> <20211102084241.GA6134@alpha.franken.de> <20211102090246.unmbruykfdjabfga@pali> <20211102094700.GA7376@alpha.franken.de> <20211102100034.rhcb3k2jvr6alm6y@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Nov 2021, Pali Rohár wrote:

> > > >From all what I saw, I'm sure that this device with this specific
> > > characteristics is really (non-compliant) Marvell PCIe controller.
> > 
> > just nitpicking, it's a Galileo PCI bridge and not PCIe.
> 
> Marvell acquired Galileo Technology in the past, so it is possible that
> this bad design is originated in Galileo. And maybe same for PCIe from
> PCI. At least PCI vendor id for all (new) PCIe controllers is this one.

 Umm, PCIe is so different hardware-wise from PCI I doubt there's any 
chance for errata to be carried across.  Plus the MIPS SysAD bus is so 
different from other CPU buses.  And we're talking 20+ years old Galileo 
devices here.

 None of the Galileo system controllers I came across had the class code 
set incorrectly.

> > > But I do not have this hardware to verify it.
> > 
> > I still have a few Cobalt systems here.
> 
> Perfect! It would help if you could provide 'lspci -nn -vv' output from
> that system. In case you have very old version of lspci on that system
> you could try to run it with '-xxxx' (or '-xxx') which prints hexdump
> and I can parse it with local lspci.

 For the record here's one from a core card used with a Malta (as with 
arch/mips/pci/fixup-malta.c); it has a newer 64120A chip (marked as an 
engineering sample BTW):

00:00.0 Host bridge: Marvell Technology Group Ltd. GT-64120/64120A/64121A System Controller (rev 11)
00: ab 11 20 46 47 01 80 22 11 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
20: 00 00 e0 1b 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
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

The lack of a quirk with a platform does not mean it cannot have a certain 
PCI/e device.

 As I recall various Atlas/Malta core cards had any of the three device 
variants covered by this vendor:device ID and later batches were actually 
indeed marked Marvell rather than Galileo.

  Maciej
