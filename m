Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C7934E885
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhC3NKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 09:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232002AbhC3NKW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 09:10:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94240619B4;
        Tue, 30 Mar 2021 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617109821;
        bh=lY2TSn+tuhT6LwclnP/pNn5wtv6gHTHFu7Kq/b3GDPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ7DYVSnq3QA+6f6dn6RzLVApxBCGLyR2YHchgfQ8ZxOJrEqLMgCikcb+0t3MhchB
         IL57sJFU87AnD+QBF2w+yxmIE1PWJuDdPUyMlSM8hThpliv0tIW/Z8qiimWr2t07u1
         R6yE+UioWMk4ULGFlHvuNcdbbckNzDvx6e8BreMpm+UlTFcKSKfAoC/VH8LzpR/I+g
         h00PmShU5hO83a3H6ufhCwJ/HrBgA6DOhHbD9nvxg9v1lHCXTmk8W1kTLDfQc6G/7n
         J+RzIukAwQhUm8N9jfrr6VO3sTAfRWvwQRmzIyu7qAWBlZeDb69w1oTeQjZcyvl+8R
         R4Gsf5rR1WDaQ==
Received: by pali.im (Postfix)
        id 3E220EAA; Tue, 30 Mar 2021 15:10:18 +0200 (CEST)
Date:   Tue, 30 Mar 2021 15:10:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Amey Narkhede' <ameynarkhede03@gmail.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kabel@kernel.org" <kabel@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>
Subject: Re: How long should be PCIe card in Warm Reset state?
Message-ID: <20210330131018.gby4ze3u6mii23ls@pali>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali>
 <20210323161941.gim6msj3ruu3flnf@archlinux>
 <20210323162747.tscfovntsy7uk5bk@pali>
 <20210323165749.retjprjgdj7seoan@archlinux>
 <a8e256ece0334734b1ef568820b95a15@AcuMS.aculab.com>
 <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 30 March 2021 15:04:02 Maciej W. Rozycki wrote:
> On Thu, 25 Mar 2021, David Laight wrote:
> 
> > I can't see the value in the (nice bound) copy of the PCI 2.0 spec I have.
> > But IIRC it is 100ms (it might just me 500ms).
> > While this might seem like ages it can be problematic if targets have
> > to load large FPGA images from serial EEPROMs.
> 
>  AFAICT it is 100ms for the Conventional Reset before Configuration 
> Requests are allowed to be issued in the first place, and then they are 
> allowed to fail with the Configuration Request Retry Status (CRS) status 
> until the device is ready to respond.  Then it is 1.0s before the Root 
> Complex and/or system software is allowed to consider a device broken that 
> does not return a Successful Completion status for a valid Configuration 
> Request.
> 
>  This 1.0s period is analogous to the Trhfa parameter for PCI/PCI-X buses 
> (2^25/2^27 bus clocks respectively; I don't know why the PCIe spec quotes 
> the latter value as 2^26, contrary to what the original PCI-X spec says, 
> but obviously the latter document is what sets the norm), which also has 
> to be respected for the respective bus segments in the presence of PCIe to 
> PCI/PCI-X bridges.

Hello Maciej! Thank you for information.

>  For Function-level reset the timeout is 100ms.
> 
>  This is specified in sections 6.6.1. "Conventional Reset" and 6.6.2. 
> "Function-Level Reset (FLR)" respectively in the copy of PCIe 2.0 base 
> spec I have access to; I imagine other versions may have different section 
> numbers, but will have them named similarly.
> 
>  If I were to implement this stuff, for good measure I'd give it a safety 
> margin beyond what the spec requires and use a timeout of say 2-4s while 
> actively querying the status of the device.  The values given in the spec 
> are only the minimum requirements.

Are you able to also figure out what is the minimal timeout value for PCIe Warm Reset?

Because we are having troubles to "decode" correct minimal timeout value
for this PCIe Warm Reset (not Function-level reset).
