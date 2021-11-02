Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48F5442E96
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 13:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhKBNBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 09:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhKBNBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 09:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E81060FC2;
        Tue,  2 Nov 2021 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635857926;
        bh=OUCokjO7+C7SROhm1TS/JkjlURAcNxesDjm7SJuNHyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvByu1jlpOaZfJZ9/lhMkD7r/i1V6DqIaZNSrH+aRbco+j0uLWR+8XFYyvDCpms+M
         a09BgfnYuYE7teS1Y9AFmR/Jm2flrxFYGzGGYqhpho5gmjWRCqH/55GT87PVHnB6pb
         ofGIWP4QC0YZUgHaM4uaZpfIFsL87BKaeFDmUF6uAHXv7u33unkYsqV6mgUo/Ha8RJ
         Ct+pMiUTwYeX1K85xx9esizrk9IotGCiOKnn7jxTY43OcA//EAGWpbnfLeU3UvwqAU
         5eeGRZpYZQZX8syoIgHxPxZKGQYOBGhJZb4MQ/nEnOS6R2Ke3MdHg7Gr36mZK3Mh00
         rXf6PsqsHuvRw==
Received: by pali.im (Postfix)
        id B99C3A41; Tue,  2 Nov 2021 13:58:43 +0100 (CET)
Date:   Tue, 2 Nov 2021 13:58:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211102125843.sqsusis4krnmhorq@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
 <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 12:35:41 Maciej W. Rozycki wrote:
> On Tue, 2 Nov 2021, Pali Rohár wrote:
> 
> > > > >From all what I saw, I'm sure that this device with this specific
> > > > characteristics is really (non-compliant) Marvell PCIe controller.
> > > 
> > > just nitpicking, it's a Galileo PCI bridge and not PCIe.
> > 
> > Marvell acquired Galileo Technology in the past, so it is possible that
> > this bad design is originated in Galileo. And maybe same for PCIe from
> > PCI. At least PCI vendor id for all (new) PCIe controllers is this one.
> 
>  Umm, PCIe is so different hardware-wise from PCI

Yes hardware is different. But software is same and fully backward
compatible. And base part of config space is same for both PCI an PCIe.
So it is possible to copy+paste HDL code which fills initial values into
config space from old PCI IPs to new PCIe IPs.

> I doubt there's any 
> chance for errata to be carried across.  Plus the MIPS SysAD bus is so 
> different from other CPU buses.  And we're talking 20+ years old Galileo 
> devices here.
> 
>  None of the Galileo system controllers I came across had the class code 
> set incorrectly.

In kernel there is quirk only for one device with id:
PCI_VENDOR_ID_MARVELL (0x11ab) PCI_DEVICE_ID_MARVELL_GT64111 (0x4146)

So for some reasons quirk is needed... Anyway, patch for this quirk just
adds comment as there is no explanation for it. It does not modify quirk
code.

So it is possible that Marvell (or rather Galileo at that time) included
some config space fixup in some products and 0x4146 did not have it.
Just guessing... We can really only guess what could happen at that time
20 years ago...

Running git blame told me that this class code quirk was introduce in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c4ed38a0c6e2e5c4906296758f816ee71373792f

But there is also no information...

> > > > But I do not have this hardware to verify it.
> > > 
> > > I still have a few Cobalt systems here.
> > 
> > Perfect! It would help if you could provide 'lspci -nn -vv' output from
> > that system. In case you have very old version of lspci on that system
> > you could try to run it with '-xxxx' (or '-xxx') which prints hexdump
> > and I can parse it with local lspci.
> 
>  For the record here's one from a core card used with a Malta (as with 
> arch/mips/pci/fixup-malta.c); it has a newer 64120A chip (marked as an 
> engineering sample BTW):
> 
> 00:00.0 Host bridge: Marvell Technology Group Ltd. GT-64120/64120A/64121A System Controller (rev 11)
> 00: ab 11 20 46 47 01 80 22 11 00 00 06 00 20 00 00
> 10: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
> 20: 00 00 e0 1b 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
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
> The lack of a quirk with a platform does not mean it cannot have a certain 
> PCI/e device.

This is 11ab:4620 device an there is no PCIe capability in its config
space (you can inspect it via 'lspci -F dump.txt -nn -vv' but there is
nothing interesting).

>  As I recall various Atlas/Malta core cards had any of the three device 
> variants covered by this vendor:device ID and later batches were actually 
> indeed marked Marvell rather than Galileo.
> 
>   Maciej
