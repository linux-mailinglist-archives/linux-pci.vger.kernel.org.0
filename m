Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34305675B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZLGz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 07:06:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50605 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLGy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 07:06:54 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id d238ae37f2c9a07d; Wed, 26 Jun 2019 13:06:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: mmap/munmap in sysfs
Date:   Wed, 26 Jun 2019 13:06:52 +0200
Message-ID: <2001283.OsK9664mvh@kreacher>
In-Reply-To: <20190626010746.GA22454@kroah.com>
References: <20190625223608.GB103694@google.com> <20190626010746.GA22454@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, June 26, 2019 3:07:46 AM CEST Greg Kroah-Hartman wrote:
> On Tue, Jun 25, 2019 at 05:36:08PM -0500, Bjorn Helgaas wrote:
> > Hi Greg, et al,
> > 
> > Userspace can mmap PCI device memory via the resourceN files in sysfs,
> > which use pci_mmap_resource().  I think this path is unaware of power
> > management, so the device may be runtime-suspended, e.g., it may be in
> > D1, D2, or D3, where it will not respond to memory accesses.
> > 
> > Userspace accesses while the device is suspended will cause PCI
> > errors, so I think we need something like the patch below.  But this
> > isn't sufficient by itself because we would need a corresponding
> > pm_runtime_put() when the mapping goes away.  Where should that go?
> > Or is there a better way to do this?
> > 
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 6d27475e39b2..aab7a47679a7 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1173,6 +1173,7 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
> >  
> >  	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
> >  
> > +	pm_runtime_get_sync(pdev);
> >  	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
> >  }
> >  
> 
> Ugh, we never thought about this when adding the mmap sysfs interface
> all those years ago :(
> 
> I think you are right, this will not properly solve the issue, but I
> don't know off the top of my head where to solve this.  Maybe Rafael has
> a better idea as he knows the pm paths much better than I do?

Well, let me think about this a bit.



