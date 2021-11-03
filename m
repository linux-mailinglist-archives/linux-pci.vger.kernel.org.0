Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647304443D9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 15:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhKCOvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 10:51:49 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:36726 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhKCOvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 10:51:47 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1824992009D; Wed,  3 Nov 2021 15:49:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1526892009B;
        Wed,  3 Nov 2021 14:49:07 +0000 (GMT)
Date:   Wed, 3 Nov 2021 14:49:07 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
In-Reply-To: <20211102144929.c5wt5pbl42ocrxly@pali>
Message-ID: <alpine.DEB.2.21.2111031430500.57165@angie.orcam.me.uk>
References: <20211101150405.14618-1-pali@kernel.org> <20211102084241.GA6134@alpha.franken.de> <20211102090246.unmbruykfdjabfga@pali> <20211102094700.GA7376@alpha.franken.de> <20211102100034.rhcb3k2jvr6alm6y@pali> <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
 <20211102125843.sqsusis4krnmhorq@pali> <alpine.DEB.2.21.2111021312160.57165@angie.orcam.me.uk> <20211102144929.c5wt5pbl42ocrxly@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Nov 2021, Pali Rohár wrote:

> Hello Maciej! Thank you very much for the explanation!

 You are welcome!

> I'm surprised that Marvell copied this 20 years old MIPS Galileo PCI
> logic into followup ARM SoC PCIe IPs (and later also into recent ARM64
> A3720 SoC PCIe IP), removed configuration of PCI class code via
> strapping pins and let default PCI class code value to Memory device,
> even also when PCIe controller is running in Root Complex mode. And so
> correction can be done only from "CPU bus".

 Still the bootstrap firmware (say U-boot, as I can see it mentioned in 
your reference) can write the correct value to the class code register.  
Or can it?

 I guess you can try it and report your findings back.  You can poke at 
PCI/e registers directly from U-boot (`pci write.w', etc.) as with any 
reasonable firmware monitor, no need to write code; I guess you probably 
know that already.

 I have no such hardware and I have no incentive to chase documentation 
for it even if public copies are available for the affected devices.  
Also you say it's IP rather than actual discrete chips as it used to be 
with the Galileo system controllers, so it could be up to the customer to 
get the IP wired/configured correctly.

> Maciej, if I had known that you have this kind of information I would
> have written you year ago :-)

 Well, I have all kinds of information.

  Maciej
