Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E985E39A9D1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCSNc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 14:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFCSNc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 14:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1D17610A1;
        Thu,  3 Jun 2021 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743907;
        bh=m8rkykkBoxDLwWKp0oejBKMXl5zMihJTaVOApT6nu/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L+m4DiKpPpuu7WvUuI/q8QuBg4aC569BDDVlyi1IUJKflH1JwW1sg8wfWLGR3Gq59
         7ovmlRWVZIEHHSbcvfI1ZZ3p/Rc4I3DhYTtPUCnnsIigmjhabFw8CadhCMmSlnNz4t
         J0CO1QFDZYst5z1N97DJ4ox83PR9DcLK79iLN4RTuFbD1VF9EUOePRA/U1vhqk7mHm
         KXYMDsjV+6MPv2EAmZAT09xbj5dEKZPVzOUSV8LQJAdRanmjBLgqS38DGCkBQPP0Y8
         +r8R/dVyRUmaJf1syCwCHrcGaD8Enm188cRe5OnrQzOYZF2/r9MgUVDz9ecQfNC+93
         lNPuy6n5YdQzA==
Date:   Thu, 3 Jun 2021 13:11:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20210603181144.GA2129146@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i0y_4cMGEpNVShLUyUk3nyWH203Ry3S87BqnDJE0Rmxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 09:15:35PM -0700, Dan Williams wrote:
> On Wed, Jun 2, 2021 at 8:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Pali, Oliver]
> >
> > On Thu, May 27, 2021 at 02:30:31PM -0700, Dan Williams wrote:
> > > On Thu, May 27, 2021 at 1:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]
> > > >
> > > > On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> > > > > Close the hole of holding a mapping over kernel driver takeover event of
> > > > > a given address range.
> > > > >
> > > > > Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > > > > introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> > > > > kernel against scenarios where a /dev/mem user tramples memory that a
> > > > > kernel driver owns. However, this protection only prevents *new* read(),
> > > > > write() and mmap() requests. Established mappings prior to the driver
> > > > > calling request_mem_region() are left alone.
> > > > >
> > > > > Especially with persistent memory, and the core kernel metadata that is
> > > > > stored there, there are plentiful scenarios for a /dev/mem user to
> > > > > violate the expectations of the driver and cause amplified damage.
> > > > >
> > > > > Teach request_mem_region() to find and shoot down active /dev/mem
> > > > > mappings that it believes it has successfully claimed for the exclusive
> > > > > use of the driver. Effectively a driver call to request_mem_region()
> > > > > becomes a hole-punch on the /dev/mem device.
> > > >
> > > > This idea of hole-punching /dev/mem has since been extended to PCI
> > > > BARs via [1].
> > > >
> > > > Correct me if I'm wrong: I think this means that if a user process has
> > > > mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
> > > > that region via pci_request_region() or similar, we punch holes in the
> > > > the user process mmap.  The driver might be happy, but my guess is the
> > > > user starts seeing segmentation violations for no obvious reason and
> > > > is not happy.
> > > >
> > > > Apart from the user process issue, the implementation of [1] is
> > > > problematic for PCI because the mmappable sysfs attributes now depend
> > > > on iomem_init_inode(), an fs_initcall, which means they can't be
> > > > static attributes, which ultimately leads to races in creating them.
> > >
> > > See the comments in iomem_get_mapping(), and revoke_iomem():
> > >
> > >         /*
> > >          * Check that the initialization has completed. Losing the race
> > >          * is ok because it means drivers are claiming resources before
> > >          * the fs_initcall level of init and prevent iomem_get_mapping users
> > >          * from establishing mappings.
> > >          */
> > >
> > > ...the observation being that it is ok for the revocation inode to
> > > come on later in the boot process because userspace won't be able to
> > > use the fs yet. So any missed calls to revoke_iomem() would fall back
> > > to userspace just seeing the resource busy in the first instance. I.e.
> > > through the normal devmem_is_allowed() exclusion.
> >
> > I did see that comment, but the race I meant is different.  Pali wrote
> > up a nice analysis of it [3].
> >
> > Here's the typical enumeration flow for PCI:
> >
> >   acpi_pci_root_add                 <-- subsys_initcall (4)
> >     pci_acpi_scan_root
> >       ...
> >         pci_device_add
> >           device_initialize
> >           device_add
> >             device_add_attrs        <-- static sysfs attributes created
> >     ...
> >     pci_bus_add_devices
> >       pci_bus_add_device
> >         pci_create_sysfs_dev_files
> >           if (!sysfs_initialized) return;    <-- Ugh :)
> >           ...
> >             attr->mmap = pci_mmap_resource_uc
> >             attr->mapping = iomem_get_mapping()  <-- new dependency
> >               return iomem_inode->i_mapping
> >             sysfs_create_bin_file   <-- dynamic sysfs attributes created
> >
> >   iomem_init_inode                  <-- fs_initcall (5)
> >     iomem_inode = ...               <-- now iomem_get_mapping() works
> >
> >   pci_sysfs_init                    <-- late_initcall (7)
> >     sysfs_initialized = 1           <-- Ugh (see above)
> >     for_each_pci_dev(dev)           <-- Ugh
> >       pci_create_sysfs_dev_files(dev)
> >
> > The race is between the pci_sysfs_init() initcall (intended for
> > boot-time devices) and the pci_bus_add_device() path (used for all
> > devices including hot-added ones).  Pali outlined cases where we call
> > pci_create_sysfs_dev_files() from both paths for the same device.
> >
> > "sysfs_initialized" is a gross hack that prevents this most of the
> > time, but not always.  I want to get rid of it and pci_sysfs_init().
> >
> > Oliver had the excellent idea of using static sysfs attributes to do
> > this cleanly [4].  If we can convert things to static attributes, the
> > device core creates them in device_add(), so we don't have to create
> > them in pci_create_sysfs_dev_files().
> >
> > Krzysztof recently did some very nice work to convert most things to
> > static attributes, e.g., [5].  But we can't do this for the PCI BAR
> > attributes because they support ->mmap(), which now depends on
> > iomem_get_mapping(), which IIUC doesn't work until after fs_initcalls.
> 
> Ah, sorry, yes, I see the race now. And yes, anything that gets in the
> way of the static attribute conversion needs fixing. How about
> something like this?

That looks like it would solve our problem, thanks a lot!  Obvious in
retrospect, like all good ideas :)

Krzysztof noticed a couple other users of iomem_get_mapping()
added by:

  71a1d8ed900f ("resource: Move devmem revoke code to resource framework")
  636b21b50152 ("PCI: Revoke mappings like devmem")

I *could* extend your patch below to cover all these, but it's kind of
outside my comfort zone, so I'd feel better if Daniel V (who wrote the
commits above) could take a look and do a follow-up.

If I could take the resulting patch via PCI, we might even be able to
get the last static attribute conversions in this cycle.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index beb8d1f4fafe..c8bc249750d6 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1195,7 +1195,7 @@ static int pci_create_attr(struct pci_dev *pdev,
> int num, int write_combine)
>                 }
>         }
>         if (res_attr->mmap)
> -               res_attr->mapping = iomem_get_mapping();
> +               res_attr->mapping = iomem_get_mapping;
>         res_attr->attr.name = res_attr_name;
>         res_attr->attr.mode = 0600;
>         res_attr->size = pci_resource_len(pdev, num);
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 9aefa7779b29..a3ee4c32a264 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -175,7 +175,7 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
>         struct bin_attribute *battr = of->kn->priv;
> 
>         if (battr->mapping)
> -               of->file->f_mapping = battr->mapping;
> +               of->file->f_mapping = battr->mapping();
> 
>         return 0;
>  }
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index d76a1ddf83a3..fbb7c7df545c 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -170,7 +170,7 @@ struct bin_attribute {
>         struct attribute        attr;
>         size_t                  size;
>         void                    *private;
> -       struct address_space    *mapping;
> +       struct address_space *(*mapping)(void);
>         ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
>                         char *, loff_t, size_t);
>         ssize_t (*write)(struct file *, struct kobject *, struct
> bin_attribute *,
