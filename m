Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE66C2B9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2019 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfGQVmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jul 2019 17:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfGQVmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jul 2019 17:42:10 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA3E2173E;
        Wed, 17 Jul 2019 21:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563399729;
        bh=7rMuXM9NN6lQ85LB+OriK3p6ENgfakggChsBPX4hfL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFLGAJmgJVB1w5aVi9mReam7V1gb81xeLFCjkn9xznqLGC3HEmqoL7d+ZCxavtWC0
         0SqHxZQEnlmYDbryYN2fr8b29E52RI7YAJmgMTVDUZma5MRHYpCkk4xZ5rj3WZfGk1
         Bhhnqd7o5hrpaYp0cH0Qh2hJOM/lTnoaeeJil6NI=
Date:   Wed, 17 Jul 2019 16:42:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190717214205.GA61126@google.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com>
 <20190423215340.GH14616@google.com>
 <20190424100102.iyxogbsa4l7dyusb@yadro.com>
 <20190424141148.GA244134@google.com>
 <20190424145819.GL2654@lahna.fi.intel.com>
 <20190424172151.GB244134@google.com>
 <CAJZ5v0gZhgMy+oQMpEGM8bsU_57w7i3iCP1nb9PcOHxENfnwAw@mail.gmail.com>
 <20190627110624.nxwloyphithj4rmt@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627110624.nxwloyphithj4rmt@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 27, 2019 at 02:06:24PM +0300, Alexander Fomichev wrote:
> On Wed, Apr 24, 2019 at 11:09:52PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 24, 2019 at 8:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Apr 24, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> > > > On Wed, Apr 24, 2019 at 09:11:48AM -0500, Bjorn Helgaas wrote:
> > > > >   - Maybe the PCI sysfs accessors (pci_mmap_resource(), etc) should
> > > > >     turn off runtime PM?  If we allow mmap of a BAR and then put the
> > > > >     device in D3hot, that seems like a bug that could affect lots of
> > > > >     things.  But maybe that's already done magically elsewhere?
> > > >
> > > > IIRC there is no PM magic happening for MMIO userspace accesses.
> > > >
> > > > What you suggest above sounds like a good way to fix it. We already do
> > > > similar for config space access from userspace (if the device is in
> > > > D3cold) so definitely makes sense to do the same for MMIO. However, I
> > > > don't think we need to disable runtime PM - it should be enough to
> > > > increase the reference count (pm_runtime_get_sync() and friends) during
> > > > the time the MMIO resource is mmapped.
> > >
> > > OK, so if I understand correctly this would be basically adding
> > > pm_runtime_get_sync(dev) in pci_mmap_resource().  I don't know what
> > > the unmap path is, but there would have to be a matching
> > > pm_runtime_put() somewhere.
> > 
> > Right.
> > 
> > > And a similar change in the read/write path for /sys/.../resource<N>;
> > > I think this must be related to the sysfs_create_bin_file() call in
> > > pci_create_attr(), but I don't see the path where the actual
> > > read/write to the device is done.
> > >
> > > And probably something similar should be done in pci_resource_io(),
> > > pci_map_rom(), and pci_unmap_rom().
> > 
> > In general, every path in which there is a memory or IO address space
> > access requires pm_runtime_get_sync()/pm_runtime_put() around it as
> > these accesses are only guaranteed to work in D0.
> 
> Tested a solution based on proposals by Logan, Bjorn, Mika, Rafael (thanks all
> of you, guys), I managed to fix the problem inside the PLX driver code. So no
> additional quirks or other modifications in Linux kernel needed. I think
> my patch can be easily rejected.

Can you fill us in a little bit on the solution?  Are you referring to
an out-of-tree PLX kernel driver?  I assume this is not a userspace
PLX tool because I don't think we have a solution to make sysfs mmap
safe yet.

Did you have to call pm_runtime_get() or similar from your driver?
Did your driver already call some PM interface before that?  (If you
could point us at the source, that would be ideal.)

Rafael, does a PCI driver have to indicate somehow that it's prepared
for runtime PM?  I assume the runtime PM core is designed in such a
way that it doesn't force driver changes (e.g., maybe driver changes
would enable more power savings, but at least things would *work*
unchanged).

Bjorn
