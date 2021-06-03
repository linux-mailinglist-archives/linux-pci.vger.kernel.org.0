Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8E3998A8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 05:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCDlt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 23:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhFCDlt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 23:41:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBC49613D7;
        Thu,  3 Jun 2021 03:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622691605;
        bh=h84f4QcqcUT3OV28w7fRBCqMqtpRdEKs4jbHMkXo5Zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u83py7wqVPtCPsdyET3sSA4/hg1mZb2BmHtGoxVmpYv60XbMoTnewp8gk9r35V9FD
         EluQS4DTxm5PMmW4HGhlDj4MsksLaj0u+W9MTwYW59uwlOUpH6SXyrcJo2bffQ3c45
         xpFkFLbbS+lwwUrxFkF/S66A4fskCg7ZpZgt/Jr8W7Z8J72WnxNySWi7TPhMmCf7sD
         d3fpyIkVw0pDXZ9mXgAtS0pAO5+BcQ+/82G1phXMHrAtMMYhlEBn5Q05oEnfpYtLMb
         GPUN0AkAeLk4daD4+XQahb6ha6U1kpXwuDFORWe1sQxTv3xLPyPdSKoXC0FZtLCdhF
         kUzL5gVId7sYg==
Date:   Wed, 2 Jun 2021 22:39:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20210603033958.GA2069090@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j-ygPddjuZqq8PMvsN-E8rJQszc+WuUu1MBXVXiQZddg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Pali, Oliver]

On Thu, May 27, 2021 at 02:30:31PM -0700, Dan Williams wrote:
> On Thu, May 27, 2021 at 1:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]
> >
> > On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> > > Close the hole of holding a mapping over kernel driver takeover event of
> > > a given address range.
> > >
> > > Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > > introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> > > kernel against scenarios where a /dev/mem user tramples memory that a
> > > kernel driver owns. However, this protection only prevents *new* read(),
> > > write() and mmap() requests. Established mappings prior to the driver
> > > calling request_mem_region() are left alone.
> > >
> > > Especially with persistent memory, and the core kernel metadata that is
> > > stored there, there are plentiful scenarios for a /dev/mem user to
> > > violate the expectations of the driver and cause amplified damage.
> > >
> > > Teach request_mem_region() to find and shoot down active /dev/mem
> > > mappings that it believes it has successfully claimed for the exclusive
> > > use of the driver. Effectively a driver call to request_mem_region()
> > > becomes a hole-punch on the /dev/mem device.
> >
> > This idea of hole-punching /dev/mem has since been extended to PCI
> > BARs via [1].
> >
> > Correct me if I'm wrong: I think this means that if a user process has
> > mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
> > that region via pci_request_region() or similar, we punch holes in the
> > the user process mmap.  The driver might be happy, but my guess is the
> > user starts seeing segmentation violations for no obvious reason and
> > is not happy.
> >
> > Apart from the user process issue, the implementation of [1] is
> > problematic for PCI because the mmappable sysfs attributes now depend
> > on iomem_init_inode(), an fs_initcall, which means they can't be
> > static attributes, which ultimately leads to races in creating them.
> 
> See the comments in iomem_get_mapping(), and revoke_iomem():
> 
>         /*
>          * Check that the initialization has completed. Losing the race
>          * is ok because it means drivers are claiming resources before
>          * the fs_initcall level of init and prevent iomem_get_mapping users
>          * from establishing mappings.
>          */
> 
> ...the observation being that it is ok for the revocation inode to
> come on later in the boot process because userspace won't be able to
> use the fs yet. So any missed calls to revoke_iomem() would fall back
> to userspace just seeing the resource busy in the first instance. I.e.
> through the normal devmem_is_allowed() exclusion.

I did see that comment, but the race I meant is different.  Pali wrote
up a nice analysis of it [3].

Here's the typical enumeration flow for PCI:

  acpi_pci_root_add                 <-- subsys_initcall (4)
    pci_acpi_scan_root
      ...
        pci_device_add
          device_initialize
          device_add
            device_add_attrs        <-- static sysfs attributes created
    ...
    pci_bus_add_devices
      pci_bus_add_device
        pci_create_sysfs_dev_files
          if (!sysfs_initialized) return;    <-- Ugh :)
          ...
            attr->mmap = pci_mmap_resource_uc
            attr->mapping = iomem_get_mapping()  <-- new dependency
              return iomem_inode->i_mapping
            sysfs_create_bin_file   <-- dynamic sysfs attributes created

  iomem_init_inode                  <-- fs_initcall (5)
    iomem_inode = ...               <-- now iomem_get_mapping() works

  pci_sysfs_init                    <-- late_initcall (7)
    sysfs_initialized = 1           <-- Ugh (see above)
    for_each_pci_dev(dev)           <-- Ugh
      pci_create_sysfs_dev_files(dev)

The race is between the pci_sysfs_init() initcall (intended for
boot-time devices) and the pci_bus_add_device() path (used for all
devices including hot-added ones).  Pali outlined cases where we call
pci_create_sysfs_dev_files() from both paths for the same device.

"sysfs_initialized" is a gross hack that prevents this most of the
time, but not always.  I want to get rid of it and pci_sysfs_init().

Oliver had the excellent idea of using static sysfs attributes to do
this cleanly [4].  If we can convert things to static attributes, the
device core creates them in device_add(), so we don't have to create
them in pci_create_sysfs_dev_files().

Krzysztof recently did some very nice work to convert most things to
static attributes, e.g., [5].  But we can't do this for the PCI BAR
attributes because they support ->mmap(), which now depends on
iomem_get_mapping(), which IIUC doesn't work until after fs_initcalls.

> > So I'm raising the question of whether this hole-punch is the right
> > strategy.
> >
> >   - Prior to revoke_iomem(), __request_region() was very
> >     self-contained and really only depended on the resource tree.  Now
> >     it depends on a lot of higher-level MM machinery to shoot down
> >     mappings of other tasks.  This adds quite a bit of complexity and
> >     some new ordering constraints.
> >
> >   - Punching holes in the address space of an existing process seems
> >     unfriendly.  Maybe the driver's __request_region() should fail
> >     instead, since the driver should be prepared to handle failure
> >     there anyway.
> 
> It's prepared to handle failure, but in this case it is dealing with a
> root user of 2 minds.
> 
> >   - [2] suggests that the hole punch protects drivers from /dev/mem
> >     writers, especially with persistent memory.  I'm not really
> >     convinced.  The hole punch does nothing to prevent a user process
> >     from mmapping and corrupting something before the driver loads.
> 
> The motivation for this was a case that was swapping between /dev/mem
> access and /dev/pmem0 access and they forgot to stop using /dev/mem
> when they switched to /dev/pmem0. If root wants to use /dev/mem it can
> use it, if root wants to stop the driver from loading it can set
> mopdrobe policy or manually unbind, and if root asks the kernel to
> load the driver while it is actively using /dev/mem something has to
> give. Given root has other options to stop a driver the decision to
> revoke userspace access when root messes up and causes a collision
> seems prudent to me.

[3] https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
[4] https://lore.kernel.org/linux-pci/CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKGXQzBfqaA@mail.gmail.com/
[5] https://git.kernel.org/linus/e1d3f3268b0e
