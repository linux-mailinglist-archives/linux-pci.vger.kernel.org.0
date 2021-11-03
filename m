Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7321444432
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 16:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKCPF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 11:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231204AbhKCPFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 11:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3767F6103B;
        Wed,  3 Nov 2021 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635951799;
        bh=cw6rpwEx5q/ntjpJ1uyg4chlz0n+39ZDTckn9Jrff1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLa36mY7gyJ6uT8N0fEJIc8RC6xwHHEBr11tSeQEm/U/X8V5SendSB4JiyzoNt2ua
         NQfokxE5NuhN9zS+JtnBhQ27FFaP+sx3KXjeRHZmbMTEcQyxeqtjP+gqlGyMag/dvy
         snQXjO/l13Jh4c8ph68Mh71cUYQObCXd+1gGLjetXcIOYvukguUT7zSDF4Hhu0w/a/
         3XiQnb3in8vVX2nlDoRUxgteJ6vZTGhbGIkD31PELhkiq4Emjz4a58vDgIGk3F1MjY
         MUG8QzvlGg0kGIKEJXSfnDluL7UxFSwMy+zJYMPmSJD3mBjz85fKG8msVoe7g5SwZJ
         90P+ChnEa7MWw==
Received: by pali.im (Postfix)
        id D26476FC; Wed,  3 Nov 2021 16:03:16 +0100 (CET)
Date:   Wed, 3 Nov 2021 16:03:16 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211103150316.6vjtycnak5nkkiuz@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
 <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
 <20211102125843.sqsusis4krnmhorq@pali>
 <alpine.DEB.2.21.2111021312160.57165@angie.orcam.me.uk>
 <20211102144929.c5wt5pbl42ocrxly@pali>
 <alpine.DEB.2.21.2111031430500.57165@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2111031430500.57165@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 03 November 2021 14:49:07 Maciej W. Rozycki wrote:
> On Tue, 2 Nov 2021, Pali Rohár wrote:
> 
> > Hello Maciej! Thank you very much for the explanation!
> 
>  You are welcome!
> 
> > I'm surprised that Marvell copied this 20 years old MIPS Galileo PCI
> > logic into followup ARM SoC PCIe IPs (and later also into recent ARM64
> > A3720 SoC PCIe IP), removed configuration of PCI class code via
> > strapping pins and let default PCI class code value to Memory device,
> > even also when PCIe controller is running in Root Complex mode. And so
> > correction can be done only from "CPU bus".
> 
>  Still the bootstrap firmware (say U-boot, as I can see it mentioned in 
> your reference) can write the correct value to the class code register.  
> Or can it?

Yes, it can. And I have already sent patches to do it.
