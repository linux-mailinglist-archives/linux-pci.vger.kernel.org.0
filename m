Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74F285A32
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgJGIOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 04:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgJGIOE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 04:14:04 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CBB2076C;
        Wed,  7 Oct 2020 08:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602058443;
        bh=G6wo9pRH97NvVw3CieOpfHR9XdQR26XJkAPylVPt2tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kj8+eaKiCxKooT7aHfCi18I6OkpyQmWSDLq6PbSjhW9ufLJGdvMkgx66f8Zist++X
         lTLK0/v+r0ZIS1CmjSPnPJFJtId6qMPsuwC1UXbPal60EEPVC495wq1vbStQcsAUjy
         Fwx2yXpkc7vUCOkys3zSTO6JddWOP5iPs02wQuC8=
Received: by pali.im (Postfix)
        id DFF224F1; Wed,  7 Oct 2020 10:14:00 +0200 (CEST)
Date:   Wed, 7 Oct 2020 10:14:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20201007081400.tmoisrk2be5gkkhh@pali>
References: <20200909112850.hbtgkvwqy2rlixst@pali>
 <20201006222222.GA3221382@bjorn-Precision-5520>
 <CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKGXQzBfqaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKGXQzBfqaA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 07 October 2020 12:47:40 Oliver O'Halloran wrote:
> On Wed, Oct 7, 2020 at 10:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > I'm not really a fan of this because pci_sysfs_init() is a bit of a
> > hack to begin with, and this makes it even more complicated.
> >
> > It's not obvious from the code why we need pci_sysfs_init(), but
> > Yinghai hinted [1] that we need to create sysfs after assigning
> > resources.  I experimented by removing pci_sysfs_init() and skipping
> > the ROM BAR sizing.  In that case, we create sysfs files in
> > pci_bus_add_device() and later assign space for the ROM BAR, so we
> > fail to create the "rom" sysfs file.
> >
> > The current solution to that is to delay the sysfs files until
> > pci_sysfs_init(), a late_initcall(), which runs after resource
> > assignments.  But I think it would be better if we could create the
> > sysfs file when we assign the BAR.  Then we could get rid of the
> > late_initcall() and that implicit ordering requirement.
> 
> You could probably fix that by using an attribute_group to control
> whether the attribute shows up in sysfs or not. The .is_visible() for
> the group can look at the current state of the device and hide the rom
> attribute if the BAR isn't assigned or doesn't exist. That way we
> don't need to care when the actual assignment occurs.

And cannot we just return e.g. -ENODATA (or other error code) for those
problematic sysfs nodes until late_initcall() is called?

> > But I haven't tried to code it up, so it's probably more complicated
> > than this.  I guess ideally we would assign all the resources before
> > pci_bus_add_device().  If we could do that, we could just remove
> > pci_sysfs_init() and everything would just work, but I think that's a
> > HUGE can of worms.
> 
> I was under the impression the whole point of pci_bus_add_device() was
> to handle any initialisation that needed to be done after resources
> were assigned. Is the ROM BAR being potentially unassigned an x86ism
> or is there some bigger point I'm missing?
> 
> Oliver
