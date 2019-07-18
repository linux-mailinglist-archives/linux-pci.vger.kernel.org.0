Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5E6CAF4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfGRIfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jul 2019 04:35:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57946 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRIfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 04:35:37 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 4a51958d689e3898; Thu, 18 Jul 2019 10:35:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexander Fomichev <fomichev.ru@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>, linux@yadro.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Date:   Thu, 18 Jul 2019 10:35:34 +0200
Message-ID: <4500314.HRFkcFs8Ko@kreacher>
In-Reply-To: <20190717214205.GA61126@google.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com> <20190627110624.nxwloyphithj4rmt@yadro.com> <20190717214205.GA61126@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, July 17, 2019 11:42:05 PM CEST Bjorn Helgaas wrote:
> On Thu, Jun 27, 2019 at 02:06:24PM +0300, Alexander Fomichev wrote:
> > On Wed, Apr 24, 2019 at 11:09:52PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Apr 24, 2019 at 8:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Apr 24, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> > > > > On Wed, Apr 24, 2019 at 09:11:48AM -0500, Bjorn Helgaas wrote:
> > > > > >   - Maybe the PCI sysfs accessors (pci_mmap_resource(), etc) should
> > > > > >     turn off runtime PM?  If we allow mmap of a BAR and then put the
> > > > > >     device in D3hot, that seems like a bug that could affect lots of
> > > > > >     things.  But maybe that's already done magically elsewhere?
> > > > >
> > > > > IIRC there is no PM magic happening for MMIO userspace accesses.
> > > > >
> > > > > What you suggest above sounds like a good way to fix it. We already do
> > > > > similar for config space access from userspace (if the device is in
> > > > > D3cold) so definitely makes sense to do the same for MMIO. However, I
> > > > > don't think we need to disable runtime PM - it should be enough to
> > > > > increase the reference count (pm_runtime_get_sync() and friends) during
> > > > > the time the MMIO resource is mmapped.
> > > >
> > > > OK, so if I understand correctly this would be basically adding
> > > > pm_runtime_get_sync(dev) in pci_mmap_resource().  I don't know what
> > > > the unmap path is, but there would have to be a matching
> > > > pm_runtime_put() somewhere.
> > > 
> > > Right.
> > > 
> > > > And a similar change in the read/write path for /sys/.../resource<N>;
> > > > I think this must be related to the sysfs_create_bin_file() call in
> > > > pci_create_attr(), but I don't see the path where the actual
> > > > read/write to the device is done.
> > > >
> > > > And probably something similar should be done in pci_resource_io(),
> > > > pci_map_rom(), and pci_unmap_rom().
> > > 
> > > In general, every path in which there is a memory or IO address space
> > > access requires pm_runtime_get_sync()/pm_runtime_put() around it as
> > > these accesses are only guaranteed to work in D0.
> > 
> > Tested a solution based on proposals by Logan, Bjorn, Mika, Rafael (thanks all
> > of you, guys), I managed to fix the problem inside the PLX driver code. So no
> > additional quirks or other modifications in Linux kernel needed. I think
> > my patch can be easily rejected.
> 
> Can you fill us in a little bit on the solution?  Are you referring to
> an out-of-tree PLX kernel driver?  I assume this is not a userspace
> PLX tool because I don't think we have a solution to make sysfs mmap
> safe yet.
> 
> Did you have to call pm_runtime_get() or similar from your driver?
> Did your driver already call some PM interface before that?  (If you
> could point us at the source, that would be ideal.)
> 
> Rafael, does a PCI driver have to indicate somehow that it's prepared
> for runtime PM?

Yes, it does.

Please see the comment in local_pci_probe().

> I assume the runtime PM core is designed in such a
> way that it doesn't force driver changes (e.g., maybe driver changes
> would enable more power savings, but at least things would *work*
> unchanged).

Right.



