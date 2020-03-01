Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A244174DE0
	for <lists+linux-pci@lfdr.de>; Sun,  1 Mar 2020 15:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCAO7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Mar 2020 09:59:41 -0500
Received: from mail.rc.ru ([151.236.222.147]:38482 "EHLO mail.rc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgCAO7l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Mar 2020 09:59:41 -0500
X-Greylist: delayed 1771 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 09:59:39 EST
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:55860)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1j8Pba-0006Aa-1m; Sun, 01 Mar 2020 14:30:06 +0000
Date:   Sun, 1 Mar 2020 14:30:04 +0000
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
Message-ID: <20200301143004.GA20720@mail.rc.ru>
References: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
 <20200222165556.GA207281@google.com>
 <CAEdQ38EzZfUJA-8zg-DgczYTwkxqFL-AThxu0_fC2V-GkXGi2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38EzZfUJA-8zg-DgczYTwkxqFL-AThxu0_fC2V-GkXGi2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 03:51:01PM -0800, Matt Turner wrote:
> On Sat, Feb 22, 2020 at 8:55 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> > > Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> > > address limits in resource allocation) broke Alpha systems using
> > > CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> > > 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> > > into the upper addresses just below 4GB.
> > >
> > > I can get a working kernel by ifdef'ing out the code in
> > > drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> > > PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> > > kernels.
> > >
> > > How can we get Nautilus working again?
> >
> > I don't see a resolution in this thread, so I assume this is still
> > broken?  Anybody have any more ideas?
> 
> Indeed, still broken.
> 
> I can add Kconfig logic to unselect ARCH_DMA_ADDR_T_64BIT if
> ALPHA_NAUTILUS, but then generic kernels won't work on Nautilus. It
> doesn't look like we have any way of opting out of
> ARCH_DMA_ADDR_T_64BIT at runtime, and doing enough plumbing to make
> that work is not worth it for such niche hardware. Maybe removing
> Nautilus from the generic kernel build is what I should do until such
> a time that we really fix this?
> 
> Or maybe I could put a hack in pci.c that more or less undoes
> d56dbf5bab8c on Nautilus. #if defined CONFIG_ARCH_DMA_ADDR_T_64BIT &&
> !defined SYS_NAUTILUS.
> 
> Or maybe I just need to take a weekend and try to understand the PCI
> code, instead of applying patches I don't understand and praying :)
> 
> Thoughts? Other suggestions?

Well, it's difficult to debug without hardware in hand.

Actually, I have one of those machines, but I had to write it off
5-6 years ago as it started crashing like crazy, sometimes in SRM
console even before boot. Interestingly enough, the problem might be
not with the motherboard as I thought, but with the video adapter -
yesterday I tried this UP1500 without AGP card, it booted fine and
worked a couple of hours without any problem, which is pretty
encouraging.

So next week I'm going to return the poor guy to service (put it
into enclosure, replace old fans and so on). Then we will see.
