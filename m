Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2043AD8B7
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhFSI5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 04:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhFSI5s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Jun 2021 04:57:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 393E9611AC;
        Sat, 19 Jun 2021 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624092938;
        bh=H65t3E3E1UfbQm0vFNUtnZkOHVJMZekG+qInfxOtAWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oy/1bVbpWvijx+yMF4KrmzPASld/lhNxS3J9mB4Fm+Is+yWhyhWxJ0J9dO19gUCbP
         xuzVvs+/1xpO+1FzdWJVlMQGN9NIzTVznZaSBkIzPkeOyP0avkdA+07pO1bTmODqEu
         8hgXAujIIRl1e39BJbLIZvBv2C03EJU1cLc04H7Fyn63HynHUmH24+fZLcqqQ4/Lk0
         5ZEezmOur8J4nsAbntFSxM0cd/P/k7J6B50Ag84D/gRxZ1nII157gdAo8lzTdYzJRh
         ZcoVqbDTLSythnXkRMEYSU/l3bZxmbQjoJbpwofeTz+EZYhCDI+3vBarBjzjogJeQe
         VAJdYP8yWgVhw==
Received: by pali.im (Postfix)
        id BF920655; Sat, 19 Jun 2021 10:55:35 +0200 (CEST)
Date:   Sat, 19 Jun 2021 10:55:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: xhci_pci & PCIe hotplug crash
Message-ID: <20210619085535.rpqitskpptgj7dwk@pali>
References: <20210505120117.4wpmo6fhvzznf3wv@pali>
 <YJKK7SDIaeH1L/fC@kroah.com>
 <20210505123346.kxfpumww5i4qmhnk@pali>
 <20210505124402.GB29101@wunner.de>
 <20210505130240.lmryb26xffzkg4pl@pali>
 <ea58430d088742a1910475a680fb1de5@AcuMS.aculab.com>
 <20210505153942.mntbkmphw3ik3pdg@pali>
 <20210619075358.GA31639@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210619075358.GA31639@wunner.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 19 June 2021 09:53:58 Lukas Wunner wrote:
> On Wed, May 05, 2021 at 05:39:42PM +0200, Pali Rohár wrote:
> > On Wednesday 05 May 2021 15:20:11 David Laight wrote:
> > > From: Pali Rohár
> > > Sent: 05 May 2021 14:03
> > > > So seems that PCIe controller HW triggers these external aborts when
> > > > device on PCIe bus is not accessible anymore.
> > > > 
> > > > If this issue is really caused by MMIO access from xhci driver when
> > > > device is not accessible on the bus anymore, can we do something to
> > > > prevent this kernel crash? Somehow mask that external abort in kernel
> > > > for a time during MMIO access?
> > > 
> > > If it is a cycle abort then the interrupted address is probably
> > > that of the MMIO instruction.
> > > So you need to catch the abort, emulate the instruction and
> > > then return to the next one.
> > 
> > Has kernel API & infrastructure for catching these aborts and executing
> > own driver handler when abort happens?
> 
> Yes, see here for an example:
> 
> https://lore.kernel.org/linux-pci/20210615191405.21878-4-jim2101024@gmail.com/

What I do not see here how to catch and recover from error. It looks
like that in above patch is just implemented catching error, printing
more verbose output and let kernel continue in rebooting / crashing.

At least I do not see how to "catch the abort, emulate the instruction
and then return to the next one" as David wrote.
