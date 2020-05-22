Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED81DF1ED
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgEVWh1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 18:37:27 -0400
Received: from elvis.franken.de ([193.175.24.41]:34928 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgEVWh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 18:37:27 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jcGI0-00019h-00; Sat, 23 May 2020 00:37:16 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9BF9CC0183; Sat, 23 May 2020 00:36:56 +0200 (CEST)
Date:   Sat, 23 May 2020 00:36:56 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v10 5/5] MIPS: Loongson64: Switch to generic PCI driver
Message-ID: <20200522223656.GA22313@alpha.franken.de>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-1-jiaxun.yang@flygoat.com>
 <20200514131650.3587281-5-jiaxun.yang@flygoat.com>
 <20200522142550.GB15261@alpha.franken.de>
 <20200522152210.GA15567@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522152210.GA15567@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 04:22:11PM +0100, Lorenzo Pieralisi wrote:
> On Fri, May 22, 2020 at 04:25:50PM +0200, Thomas Bogendoerfer wrote:
> > On Thu, May 14, 2020 at 09:16:41PM +0800, Jiaxun Yang wrote:
> > > We can now enable generic PCI driver in Kconfig, and remove legacy
> > > PCI driver code.
> > > 
> > > Radeon vbios quirk is moved to the platform folder to fit the
> > > new structure.
> > > 
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > --
> > > v9: Fix licenses tag
> > > ---
> > >  arch/mips/Kconfig                  |   1 +
> > >  arch/mips/loongson64/Makefile      |   2 +-
> > >  arch/mips/loongson64/vbios_quirk.c |  29 ++++++++
> > >  arch/mips/pci/Makefile             |   1 -
> > >  arch/mips/pci/fixup-loongson3.c    |  71 ------------------
> > >  arch/mips/pci/ops-loongson3.c      | 116 -----------------------------
> > >  6 files changed, 31 insertions(+), 189 deletions(-)
> > >  create mode 100644 arch/mips/loongson64/vbios_quirk.c
> > >  delete mode 100644 arch/mips/pci/fixup-loongson3.c
> > >  delete mode 100644 arch/mips/pci/ops-loongson3.c
> > 
> > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> This patch (so the series) does not apply to v5.7-rc1 which is our
> baseline. I reiterate the point, isn't it better to take the whole
> series through the MIPS tree ?

sounds better then

> Failing that, the series has to
> be rebased (or split differently so that it can be taken through
> different trees), just let me know.

so let's take via mips-next. So can I add your Acked-by to the
first three patches ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
