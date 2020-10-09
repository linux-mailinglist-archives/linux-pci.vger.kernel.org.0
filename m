Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC998288C27
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbgJIPFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 11:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388819AbgJIPFT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 11:05:19 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763AC22260;
        Fri,  9 Oct 2020 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602255918;
        bh=YCHli0iAeW9XyP16UomXBcSMi7tx92QZKZ9pJIjsQ2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jOG4FT8ITIYMphuuCq4TWtqD2SxpRNVpYUJkqUmfT1FGAVAAOJBuAq19PAIuYmjhC
         P2GVHBUUwTh6Bx/HpffZ5NvyPH2PRTn8fXbcztJsdc2/qDXs/dH1+NpwDMsLzZ/fN3
         Dd3QRfS40zXC8LMe7BjRRYrMnqL9w7nWErlOpzgw=
Date:   Fri, 9 Oct 2020 10:05:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-pci@vger.kernel.org,
        "Bolen, Austin" <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: spammy dmesg about fluctuating pcie bandwidth on 5.9
Message-ID: <20201009150517.GA3475242@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b40eed-72a4-dde0-3622-2a9a28db1e62@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith]

On Fri, Oct 09, 2020 at 09:32:32AM -0500, Alex G. wrote:
> [+cc Austin]
> 
> Hi Bjorn,
> 
> That log looks like the PCIe registers spitting wrong values, but all I can
> do is speculate. Have we verified we don't have a race condition between
> ASPM and pcie_report_downtraining()?
> 
> I wouldn't be surprised if the cause of the messages is the device (or
> downstream port) faking all f's responses. I don't see how else we'd get
> links reported as x63 32GT/s.

Right, I think you and Keith nailed it: likely we read ~0 from
PCI_EXP_LNKSTA because of some error.  I don't know what the
connection with ASPM would be, although we do have some known problems
with ASPM configuration, especially in "powersave" mode; see [1]

Jason, could you capture the "sudo lspci -vvxxx" output and dmesg log
after the messages start?  You could instrument bw_notification.c so
it shuts up after a few messages if necessary.  The lspci should show
us if a port leading to the device is in DPC or other error condition.

DPC takes down the link (as would an AER event).  It doesn't seem like
these should cause Link Bandwidth Management interrupts, but maybe?

[1] https://lore.kernel.org/r/20201007132808.647589-1-ian.kumlien@gmail.com

> On 10/7/20 12:02 PM, Bjorn Helgaas wrote:
> > [+cc Alex]
> > 
> > On Wed, Oct 07, 2020 at 06:09:06PM +0200, Jason A. Donenfeld wrote:
> > > Hi,
> > > 
> > > Since 5.9 I've been seeing lots of the below in my logs. I'm wondering
> > > if this is a case of "ASPM finally working properly," or if I'm
> > > actually running into aberrant behavior that I should look into
> > > further. I run with `pcie_aspm=force pcie_aspm.policy=powersave` on my
> > > command line. But I wasn't seeing these messages in 5.8.
> > 
> > I'm sorry that you need to use "pcie_aspm=force
> > pcie_aspm.policy=powersave".  Someday maybe we'll get enough of ASPM
> > fixed so we won't need junk like that.  I don't think we're there yet.
> > Do you build with CONFIG_PCIEASPM_POWERSAVE=y?  Do you need
> > "pcie_aspm=force" because the firmware tells us not to use ASPM?
> > 
> > Re: the messages below, they come from Link Bandwidth Management
> > interrupts.  These *should* only happen because of a
> > software-initiated link retrain or because hardware changed the link
> > speed or width because the link was unreliable.  ASPM shouldn't cause
> > these.
> > 
> > So it's possible you have an unreliable slot, but I doubt it because
> > you said v5.8 works fine, and also the Link Bandwidth interrupts
> > should only happen if something *changed*, but all the messages below
> > look the same to me.
> > 
> > Something is also wrong with them -- there's no such thing as a "x63"
> > link.  But maybe these are copy/paste errors?  I don't know where the
> > "b.4" comes from either.  Oh, that probably belongs with
> > "0000:00:1b.4" but got separated by copy/paste.
> > 
> > Obviously you can stop the messages by unsetting CONFIG_PCIE_BW.
> > 
> > The code (drivers/pci/pcie/bw_notification.c) is pretty
> > straightforward and I don't see an obvious problem, but maybe Alex
> > will.
> > 
> > > [79960.801929] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
> > > bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
> > > b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
> > > [79981.679813] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
> > > bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
> > > b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
> > > ...
