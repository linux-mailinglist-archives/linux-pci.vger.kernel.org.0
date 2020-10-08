Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF58287CAC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 21:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgJHT7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 15:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgJHT7K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Oct 2020 15:59:10 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591F822226;
        Thu,  8 Oct 2020 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602187149;
        bh=KWdIgJ4CVgfBZIUsekfpN9Om9ak7TjpRtxfSQOUshhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yeDUnG4Hm2+POoWDHW6sZ+B2vjjBat3MDJRzdmhfVOHzqGI1AYTMYmIJwU5pUD02v
         Yexa4A2DUPZSSqSUhHndLXs3/BAGxb1DJm6gIRsDTsPH/weOSFLukxnZgUf0Lv2ydt
         L8kt0htX3o6qDBG7gv19Pnzi4eAho+hgRV1Xz+cE=
Date:   Thu, 8 Oct 2020 14:59:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20201008195907.GA3359851@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007161434.GA3247067@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 11:14:34AM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 07, 2020 at 10:14:00AM +0200, Pali Rohár wrote:
> > On Wednesday 07 October 2020 12:47:40 Oliver O'Halloran wrote:
> > > On Wed, Oct 7, 2020 at 10:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > I'm not really a fan of this because pci_sysfs_init() is a bit of a
> > > > hack to begin with, and this makes it even more complicated.
> > > >
> > > > It's not obvious from the code why we need pci_sysfs_init(), but
> > > > Yinghai hinted [1] that we need to create sysfs after assigning
> > > > resources.  I experimented by removing pci_sysfs_init() and skipping
> > > > the ROM BAR sizing.  In that case, we create sysfs files in
> > > > pci_bus_add_device() and later assign space for the ROM BAR, so we
> > > > fail to create the "rom" sysfs file.
> > > >
> > > > The current solution to that is to delay the sysfs files until
> > > > pci_sysfs_init(), a late_initcall(), which runs after resource
> > > > assignments.  But I think it would be better if we could create the
> > > > sysfs file when we assign the BAR.  Then we could get rid of the
> > > > late_initcall() and that implicit ordering requirement.
> > > 
> > > You could probably fix that by using an attribute_group to control
> > > whether the attribute shows up in sysfs or not. The .is_visible() for
> > > the group can look at the current state of the device and hide the rom
> > > attribute if the BAR isn't assigned or doesn't exist. That way we
> > > don't need to care when the actual assignment occurs.
> > 
> > And cannot we just return e.g. -ENODATA (or other error code) for those
> > problematic sysfs nodes until late_initcall() is called?
> 
> I really like Oliver's idea and I think we should push on that to see
> if it can be made to work.  If so, we can remove the late_initcall()
> completely.
> 
> > > > But I haven't tried to code it up, so it's probably more complicated
> > > > than this.  I guess ideally we would assign all the resources before
> > > > pci_bus_add_device().  If we could do that, we could just remove
> > > > pci_sysfs_init() and everything would just work, but I think that's a
> > > > HUGE can of worms.
> > > 
> > > I was under the impression the whole point of pci_bus_add_device() was
> > > to handle any initialisation that needed to be done after resources
> > > were assigned. Is the ROM BAR being potentially unassigned an x86ism
> > > or is there some bigger point I'm missing?
> 
> We can't assign resources for each device as we enumerate it because
> we don't know what's in use by other devices yet to be enumerated.
> That part is generic, not x86-specific.
> 
> The part that is x86-specific (or at least specific to systems using
> ACPI) is that the ACPI core doesn't reserve resources used by ACPI
> devices.  Sometimes those resources are included in the PCI host
> bridge windows, and we don't want to assign them to PCI devices.
> 
> I didn't trace this all the way, but the pcibios_assign_resources()
> and pnp_system_init() comments look relevant.  It's a little concerning
> that they're both fs_initcalls() and the ordering looks important, but
> it would only be by accident of link ordering that pnp_system_init()
> happens first.

Pali, what's your thought on this?  Do you plan to work on this
yourself?  If not and if you can live with your workaround a while
longer, I think Krzysztof might be interested in taking a crack at it.
I would just hate to see you guys duplicate each others' work :)

Bjorn
