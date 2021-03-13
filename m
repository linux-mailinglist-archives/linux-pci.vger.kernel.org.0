Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3333A189
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 22:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhCMV6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 16:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234182AbhCMV5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Mar 2021 16:57:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 919DF64DE1;
        Sat, 13 Mar 2021 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615672668;
        bh=ibgxwZyW7rbp39bHV36ZaJ/Ipg69CnJHlj1o0MvjNjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jDUWhyX0MJVWi+H7CSxvDWFptcdVNuvMCTKwYp/ka/auZZp7f+ZmSIu6GyPKqSgHp
         tywbwRmQHdkihvj5Kyk/gbg5uCeIYV65F+CE9rmOH7aR9hKgQJgiXJKjTeF9pczV+i
         iUd/wCq6xo/9rXPWaYYQf6yRHa3kO8eoLiiNZpsqGfxKTAL09MNKRVf1/g3eXcYPGi
         xrWIyS8WK3ysdewU0arcPWlrR4M+ajkrTGCW6QpuW0CWUIdr9GVNRORGiWKQ8hanPn
         MFh2OLscEoozgVjruQhP+ntpJFqG7QHc0cvPb4pr1baLzb3YZXS9V/iO9dwwCpS5PW
         j3ZB9Xr+JVsHw==
Date:   Sat, 13 Mar 2021 15:57:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-samsung-soc@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 2/2] PCI: Revoke mappings like devmem
Message-ID: <20210313215747.GA2394467@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204165831.2703772-3-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof, Pali, Oliver]

On Thu, Feb 04, 2021 at 05:58:31PM +0100, Daniel Vetter wrote:
> Since 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims
> the region") /dev/kmem zaps ptes when the kernel requests exclusive
> acccess to an iomem region. And with CONFIG_IO_STRICT_DEVMEM, this is
> the default for all driver uses.
> 
> Except there's two more ways to access PCI BARs: sysfs and proc mmap
> support. Let's plug that hole.

IIUC, the idea is that if a driver calls request_mem_region() on a PCI
BAR, we prevent access to the BAR via sysfs.  I guess I'm OK with that
if it's a real security improvement or something.

But the downside of this implementation is that it depends on
iomem_get_mapping(), which doesn't work until after fs_initcalls,
which means the sysfs files cannot be static attributes of devices
added before that.  PCI devices are typically enumerated in
subsys_initcall.

Krzysztof is converting PCI sysfs files (config, rom, reset, vpd, etc)
to static attributes.  This is a major improvement that could get rid
of pci_create_sysfs_dev_files(), the late_initcall pci_sysfs_init(),
and the "sysfs_initialized" hack.  This would fix a race reported by
Pali [1] (thanks to Oliver for the idea [2]).

EXCEPT that this revoke change means the "resource%d", "legacy_io",
and "legacy_mem" files cannot be static attributes because of
iomem_get_mapping().

Any ideas on how to deal with this?  Having to keep the
pci_sysfs_init() initcall just for these few files seems like the tail
wagging the dog.

[1] https://lore.kernel.org/r/20200716110423.xtfyb3n6tn5ixedh@pali
[2] https://lore.kernel.org/r/CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKGXQzBfqaA@mail.gmail.com

> For revoke_devmem() to work we need to link our vma into the same
> address_space, with consistent vma->vm_pgoff. ->pgoff is already
> adjusted, because that's how (io_)remap_pfn_range works, but for the
> mapping we need to adjust vma->vm_file->f_mapping. The cleanest way is
> to adjust this at at ->open time:
> 
> - for sysfs this is easy, now that binary attributes support this. We
>   just set bin_attr->mapping when mmap is supported
> - for procfs it's a bit more tricky, since procfs pci access has only
>   one file per device, and access to a specific resources first needs
>   to be set up with some ioctl calls. But mmap is only supported for
>   the same resources as sysfs exposes with mmap support, and otherwise
>   rejected, so we can set the mapping unconditionally at open time
>   without harm.
> 
> A special consideration is for arch_can_pci_mmap_io() - we need to
> make sure that the ->f_mapping doesn't alias between ioport and iomem
> space. There's only 2 ways in-tree to support mmap of ioports: generic
> pci mmap (ARCH_GENERIC_PCI_MMAP_RESOURCE), and sparc as the single
> architecture hand-rolling. Both approach support ioport mmap through a
> special pfn range and not through magic pte attributes. Aliasing is
> therefore not a problem.
> 
> The only difference in access checks left is that sysfs PCI mmap does
> not check for CAP_RAWIO. I'm not really sure whether that should be
> added or not.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pci-sysfs.c | 4 ++++
>  drivers/pci/proc.c      | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 0c45b4f7b214..f8afd54ca3e1 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -942,6 +942,7 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_io->read = pci_read_legacy_io;
>  	b->legacy_io->write = pci_write_legacy_io;
>  	b->legacy_io->mmap = pci_mmap_legacy_io;
> +	b->legacy_io->mapping = iomem_get_mapping();
>  	pci_adjust_legacy_attr(b, pci_mmap_io);
>  	error = device_create_bin_file(&b->dev, b->legacy_io);
>  	if (error)
> @@ -954,6 +955,7 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_mem->size = 1024*1024;
>  	b->legacy_mem->attr.mode = 0600;
>  	b->legacy_mem->mmap = pci_mmap_legacy_mem;
> +	b->legacy_io->mapping = iomem_get_mapping();
>  	pci_adjust_legacy_attr(b, pci_mmap_mem);
>  	error = device_create_bin_file(&b->dev, b->legacy_mem);
>  	if (error)
> @@ -1169,6 +1171,8 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
>  			res_attr->mmap = pci_mmap_resource_uc;
>  		}
>  	}
> +	if (res_attr->mmap)
> +		res_attr->mapping = iomem_get_mapping();
>  	res_attr->attr.name = res_attr_name;
>  	res_attr->attr.mode = 0600;
>  	res_attr->size = pci_resource_len(pdev, num);
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 3a2f90beb4cb..9bab07302bbf 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -298,6 +298,7 @@ static int proc_bus_pci_open(struct inode *inode, struct file *file)
>  	fpriv->write_combine = 0;
>  
>  	file->private_data = fpriv;
> +	file->f_mapping = iomem_get_mapping();
>  
>  	return 0;
>  }
> -- 
> 2.30.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
