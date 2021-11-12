Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2934844E5D9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 12:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhKLMA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 07:00:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:60907 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhKLMA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 07:00:26 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1ACBnjBf016776;
        Fri, 12 Nov 2021 05:49:45 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 1ACBnfPp016770;
        Fri, 12 Nov 2021 05:49:41 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 12 Nov 2021 05:49:41 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Marc Zyngier <maz@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, Arnd Bergmann <arnd@arndb.de>,
        kw@linux.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        damien.lemoal@opensource.wdc.com,
        Darren Stevens <darren@stevens-zone.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        robert@swiecki.net, Matthew Leaman <matthew@a-eon.biz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the pci-v5.16 updates
Message-ID: <20211112114941.GK614@gate.crashing.org>
References: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de> <20211110184106.GA1251058@bhelgaas> <87sfw3969l.wl-maz@kernel.org> <8cc64c3b-b0c0-fb41-9836-2e5e6a4459d1@xenosoft.de> <87r1bn88rt.wl-maz@kernel.org> <f40294c6-a088-af53-eeea-4dfbd255c5c9@xenosoft.de> <87pmr7803l.wl-maz@kernel.org> <CAOesGMgHfsFKWOXNOMghO3Xqj2y8M5XA8GjVV5ciOT0A4b+wdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMgHfsFKWOXNOMghO3Xqj2y8M5XA8GjVV5ciOT0A4b+wdg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 02:21:46PM -0800, Olof Johansson wrote:
> On Thu, Nov 11, 2021 at 2:20 AM Marc Zyngier <maz@kernel.org> wrote:
> > Am I right in understanding that the upstream kernel does not support
> > the machine out of the box, and that you actually have to apply out of
> > tree patches to make it work? That these patches have to do with the
> > IRQ routing?
> 
> To my knowledge that has never been needed -- that the base platform
> support is all there.
> 
> This is an old platform, and just like with the power macs, the
> devicetree is indeed supplied from firmware, and as such not easily
> patchable like with ARM platforms.
> 
> Last time this was an issue (to my memory) was when they enabled
> automatic little endian switching in the boot path, that caused some
> issues with a (bad) phandle pointer that had gone undiscovered for 10+
> years.
> 
> > If so, I wonder why upstream should revert a patch to work on a system
> > that isn't supported upstream the first place. I will still try and
> > come up with a solution for you. But asking for the revert of a patch
> > on these grounds is not, IMHO, acceptable. Also, please provide these
> > patches on the list so that I can help you to some extend (and I mean
> > *on the list*, not on a random forum that collects my information).
> 
> Early fixups of DT is the way to go here, if needed -- we do it on
> some other platforms. That can happen in-kernel, and keep the new
> functionality. For that we'd need to figure out what's actually wrong
> with the DT as such right now.

Yup.  The scheme we have now (copy all info from OF, and then take over
everything at once) is not ideal at all, but treating OF systems just
like "bare" systems has advantages as well, including making it easier
to fix up the device tree if it has problems.  This is much superior to
changing all consumers (drivers etc.) to deal with the broken device
trees, so we should do it much more often :-)


Segher
