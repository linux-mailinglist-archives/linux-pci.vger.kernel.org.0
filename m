Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852992A69C1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgKDQ3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 11:29:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgKDQ3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 11:29:35 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8448206D9;
        Wed,  4 Nov 2020 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604507373;
        bh=W/zuUY6HL7tKTX4bDA0QdJfN/9luaS/+K7ahTWi5/TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Erv3SxF4Y8aQZOacF/5r+JUADxTk/dJIQX2wY+3rwkHNnamQwd1SXkLOwCdTWygeQ
         Ouai02QaU3Gvkaigkoqwfg6vAGQjOzIiP3aKNqVT98ZPGHKPGLWMI3WEAuo5a3k85c
         lqs3ooliteVG/lde9sBppUy/yN4dbseO7s9B8KuM=
Received: by pali.im (Postfix)
        id 4797653E; Wed,  4 Nov 2020 17:29:31 +0100 (CET)
Date:   Wed, 4 Nov 2020 17:29:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20201104162931.zplhflhvz53odkux@pali>
References: <20201007161434.GA3247067@bjorn-Precision-5520>
 <20201008195907.GA3359851@bjorn-Precision-5520>
 <20201009080853.bxzyirmaja6detk4@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009080853.bxzyirmaja6detk4@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Krzysztof!

On Friday 09 October 2020 10:08:53 Pali Rohár wrote:
> On Thursday 08 October 2020 14:59:07 Bjorn Helgaas wrote:
> > On Wed, Oct 07, 2020 at 11:14:34AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Oct 07, 2020 at 10:14:00AM +0200, Pali Rohár wrote:
> > > > On Wednesday 07 October 2020 12:47:40 Oliver O'Halloran wrote:
> > > > > On Wed, Oct 7, 2020 at 10:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > >
> > > > > > I'm not really a fan of this because pci_sysfs_init() is a bit of a
> > > > > > hack to begin with, and this makes it even more complicated.
> > > > > >
> > > > > > It's not obvious from the code why we need pci_sysfs_init(), but
> > > > > > Yinghai hinted [1] that we need to create sysfs after assigning
> > > > > > resources.  I experimented by removing pci_sysfs_init() and skipping
> > > > > > the ROM BAR sizing.  In that case, we create sysfs files in
> > > > > > pci_bus_add_device() and later assign space for the ROM BAR, so we
> > > > > > fail to create the "rom" sysfs file.
> > > > > >
> > > > > > The current solution to that is to delay the sysfs files until
> > > > > > pci_sysfs_init(), a late_initcall(), which runs after resource
> > > > > > assignments.  But I think it would be better if we could create the
> > > > > > sysfs file when we assign the BAR.  Then we could get rid of the
> > > > > > late_initcall() and that implicit ordering requirement.
> > > > > 
> > > > > You could probably fix that by using an attribute_group to control
> > > > > whether the attribute shows up in sysfs or not. The .is_visible() for
> > > > > the group can look at the current state of the device and hide the rom
> > > > > attribute if the BAR isn't assigned or doesn't exist. That way we
> > > > > don't need to care when the actual assignment occurs.
> > > > 
> > > > And cannot we just return e.g. -ENODATA (or other error code) for those
> > > > problematic sysfs nodes until late_initcall() is called?
> > > 
> > > I really like Oliver's idea and I think we should push on that to see
> > > if it can be made to work.  If so, we can remove the late_initcall()
> > > completely.
> > > 
> > > > > > But I haven't tried to code it up, so it's probably more complicated
> > > > > > than this.  I guess ideally we would assign all the resources before
> > > > > > pci_bus_add_device().  If we could do that, we could just remove
> > > > > > pci_sysfs_init() and everything would just work, but I think that's a
> > > > > > HUGE can of worms.
> > > > > 
> > > > > I was under the impression the whole point of pci_bus_add_device() was
> > > > > to handle any initialisation that needed to be done after resources
> > > > > were assigned. Is the ROM BAR being potentially unassigned an x86ism
> > > > > or is there some bigger point I'm missing?
> > > 
> > > We can't assign resources for each device as we enumerate it because
> > > we don't know what's in use by other devices yet to be enumerated.
> > > That part is generic, not x86-specific.
> > > 
> > > The part that is x86-specific (or at least specific to systems using
> > > ACPI) is that the ACPI core doesn't reserve resources used by ACPI
> > > devices.  Sometimes those resources are included in the PCI host
> > > bridge windows, and we don't want to assign them to PCI devices.
> > > 
> > > I didn't trace this all the way, but the pcibios_assign_resources()
> > > and pnp_system_init() comments look relevant.  It's a little concerning
> > > that they're both fs_initcalls() and the ordering looks important, but
> > > it would only be by accident of link ordering that pnp_system_init()
> > > happens first.
> > 
> > Pali, what's your thought on this?  Do you plan to work on this
> > yourself?  If not and if you can live with your workaround a while
> > longer, I think Krzysztof might be interested in taking a crack at it.
> > I would just hate to see you guys duplicate each others' work :)
> 
> Hello Bjorn!
> 
> If Krzysztof wants and would be working on this issue I can let it as is
> for now.

Krzysztof, as Bjorn wrote, do you want to take this issue?

> But we should think how to deliver fix for this issue also into stable
> kernels where this race condition is happening.
> 
> I think that my workaround avoid those two race conditions and if proper
> fix (= removal of pci_sysfs_init function) would take a long, what about
> trying to workaround that race condition for now?
> 
> My "fix" is relatively small and simple, so it should not be much hard
> to review it.
> 
> Krzysztof, what do you think?
