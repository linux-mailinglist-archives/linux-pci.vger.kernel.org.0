Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8452373EB6
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhEEPkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 11:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhEEPkm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 11:40:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40D676112F;
        Wed,  5 May 2021 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620229185;
        bh=ZCUYdqlONn4tcSJ0vwB/AkHctWRyUIU/usgs8uDdJI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBzu/yRe5fmHkCWO5xDGNCnfkxG0ujdJ+o2atVDtlbf+q58KRquJvZ33Qm9Zqngp6
         0pqSTHCagEjHWc0zeZCvD1KgXYUMYjE6EA914b+7US0TZDu56qxvvejAfHio7Qsk9A
         Dh6GvSpVggT72Ya5/ru261twvJ1LmS/s0LctfoTipw4XtDRUlbWwMW7aggZTGZBdmD
         2uXv/l+YrCApSgM1hYQl91wz1xu7IKNrTbN45bS7WGTN2mOwpqPA1HL2FGbkxt5XcD
         ae6AO2xNmS3w4guBZLEzxZgE0DJGz9BVRe0aiskCDZIz8+BboMWQ9oaOA5khS0zzJ6
         RmoYfC1i+raCA==
Received: by pali.im (Postfix)
        id 8241D79D; Wed,  5 May 2021 17:39:42 +0200 (CEST)
Date:   Wed, 5 May 2021 17:39:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: xhci_pci & PCIe hotplug crash
Message-ID: <20210505153942.mntbkmphw3ik3pdg@pali>
References: <20210505120117.4wpmo6fhvzznf3wv@pali>
 <YJKK7SDIaeH1L/fC@kroah.com>
 <20210505123346.kxfpumww5i4qmhnk@pali>
 <20210505124402.GB29101@wunner.de>
 <20210505130240.lmryb26xffzkg4pl@pali>
 <ea58430d088742a1910475a680fb1de5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea58430d088742a1910475a680fb1de5@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 05 May 2021 15:20:11 David Laight wrote:
> From: Pali Rohár
> > Sent: 05 May 2021 14:03
> ...
> > I already figured out that CPU receive external abort also when trying
> > to issue a new PIO transfer for accessing PCI config space while
> > previous transfer has not finished yet. And also there is no way (at
> > least in documentation) which allows to "mask" this external abort. But
> > this issue can be fixed in pci-aardvark.c driver to disallow access to
> > config space while previous transfer is still running (I will send patch
> > for this one).
> 
> My the sound of the above you need to put a global spinlock around
> all PCIe config space accesses.

Kernel already uses raw_spin_lock_irqsave(), see pci_lock_config() macro
in pci/access.c which implements this global lock for config space
access.

But issue is that pci-driver.c does not wait for finishing transfer and
return from function which unlock this spin lock...

Week ago I fixed this issue in U-Boot and similar fix would be needed
also for kernel https://source.denx.de/u-boot/u-boot/-/commit/eccbd4ad8e4e

But this issue is not related to my original report about XHCI & PCI.

> Is this the horrid hardware that can't do a 'normal' PCIe transfer
> while a config space access is in progress?

Issue is different. You cannot do config space PIO transfer while
another config space PIO transfer is in progress.

> If that it true then you have bigger problems.
> Especially if it is an SMP system.

I really hope that memory read or write transfer can be initiated while
config transfer is in progress. Marvell A3720 platform on which can be
found this pci aardvark controller is 2 core CPU SoC.

At least I have not seen any abort when PCIe link is up, card connected
and previous config access transfer finished.

> > So seems that PCIe controller HW triggers these external aborts when
> > device on PCIe bus is not accessible anymore.
> > 
> > If this issue is really caused by MMIO access from xhci driver when
> > device is not accessible on the bus anymore, can we do something to
> > prevent this kernel crash? Somehow mask that external abort in kernel
> > for a time during MMIO access?
> 
> If it is a cycle abort then the interrupted address is probably
> that of the MMIO instruction.
> So you need to catch the abort, emulate the instruction and
> then return to the next one.

Has kernel API & infrastructure for catching these aborts and executing
own driver handler when abort happens?

> This probably requires an exception table containing the address
> of every readb/w/l() instruction.
> 
> If you get a similar error on writes it is likely to be a few
> instructions after the actual writeb/w/l() instruction.
> Write are normally 'posted' and asynchronous.
> 
> If you are really lucky you can get enough state out of the
> abort handler to fixup/ignore the cycle without an
> exception table.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
