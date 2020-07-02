Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071E8211F38
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgGBIxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 04:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGBIxW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 04:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A99F20772;
        Thu,  2 Jul 2020 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593680002;
        bh=GU8qixS9fAOtO82Uw0rNTtOko0myo+qCuTOuTEd/SAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ItUuoES1h0v3eTLIL64lDR8a3BGKgy4TOglPFVMlBMrYuUlVEQnGkwsHH6OScxBJ
         PtEFCb45jL+7ZwDWZmKtFMlBKirPOiRefYa+jvwW/a7wk4i9GbrHt5cJOnIIO3SWnS
         nCG7vSDhamWHFnzMchw/prFqbBFczWERopXPolRM=
Date:   Thu, 2 Jul 2020 10:53:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200702085325.GA1090194@kroah.com>
References: <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
 <20200630153816.GD1785141@kroah.com>
 <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
 <20200630170012.GB1894898@kroah.com>
 <CACK8Z6Fcrb8PtmbUJLn8RgiGnC8eqTC9GjsgjPmQgU212WPU0Q@mail.gmail.com>
 <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
 <20200702073226.GB1073011@kroah.com>
 <24f56c0ed6d10ef565cf83d47d0538d37ac0d8ef.camel@gmail.com>
 <20200702085212.GA1089671@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702085212.GA1089671@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 02, 2020 at 10:52:12AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 02, 2020 at 06:40:09PM +1000, Oliver O'Halloran wrote:
> > On Thu, 2020-07-02 at 09:32 +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 02, 2020 at 03:23:23PM +1000, Oliver O'Halloran wrote:
> > > > Yep, that's a problem. If we want to provide a useful mechanism to
> > > > userspace then the default behaviour of the kernel can't undermine
> > > > that mechanism. If that means we need another kernel command line
> > > > parameter then I guess we just have to live with it.
> > > 
> > > I really do not want yet-another-kernel-command-line-option if we can
> > > help it at all.  Sane defaults are the best thing to do here.  Userspace
> > > comes up really early, put your policy in there, not in blobs passed
> > > from your bootloader.
> > 
> > Userspace comes up early, but builtin drivers will bind before init is
> > started. e.g.
> > 
> > # dmesg | egrep '0002:01:00.0|/init'
> > [    0.976800][    T1] pci 0002:01:00.0: [8086:1589] type 00 class 0x020000
> > [    0.976923][    T1] pci 0002:01:00.0: reg 0x10: [mem 0x220000000000-0x2200007fffff 64bit pref]
> > [    0.977004][    T1] pci 0002:01:00.0: reg 0x1c: [mem 0x220002000000-0x220002007fff 64bit pref]
> > [    0.977068][    T1] pci 0002:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
> > [    0.977122][    T1] pci 0002:01:00.0: BAR3 [mem size 0x00008000 64bit pref]: requesting alignment to 0x10000
> > [    0.977401][    T1] pci 0002:01:00.0: PME# supported from D0 D3hot
> > [    1.011929][    T1] pci 0002:01:00.0: BAR 0: assigned [mem 0x220000000000-0x2200007fffff 64bit pref]
> > [    1.012085][    T1] pci 0002:01:00.0: BAR 6: assigned [mem 0x3fe100000000-0x3fe10007ffff pref]
> > [    1.012127][    T1] pci 0002:01:00.0: BAR 3: assigned [mem 0x220002000000-0x220002007fff 64bit pref]
> > [    4.399588][   T12] i40e 0002:01:00.0: enabling device (0140 -> 0142)
> > [    4.410891][   T12] i40e 0002:01:00.0: fw 5.1.40981 api 1.5 nvm 5.03 0x80002469 1.1313.0 [8086:1589] [15d9:0000]
> > [    4.647524][   T12] i40e 0002:01:00.0: MAC address: 0c:c4:7a:b7:fc:74
> > [    4.647685][   T12] i40e 0002:01:00.0: FW LLDP is enabled
> > [    4.653918][   T12] i40e 0002:01:00.0 eth0: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
> > [    4.655552][   T12] i40e 0002:01:00.0: PCI-Express: Speed 8.0GT/s Width x8
> > [    4.656071][   T12] i40e 0002:01:00.0: Features: PF-id[0] VSIs: 34 QP: 80 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
> > [   13.803709][    T1] Run /init as init process
> > [   13.963242][  T711] i40e 0002:01:00.0 enP2p1s0f0: renamed from eth0
> > 
> > Building everything into the kernel is admittedly pretty niche. I only
> > do it to avoid re-building the initramfs for my test kernels. It does
> > seem relatively common on embedded systems, but I'm not sure how many
> > of those care about PCIe. It would be nice to provide *something* to
> > cover that case for the people who care.
> 
> Those people who care should not build those drivers into their kernel :)

That being said, that is the _last_ thing to worry about in this type of
patchset, lots of work needs to be done before we can care about this.
In fact, that should just be a totally separate patch after all of the
real work is done here first.

thanks,

greg k-h
