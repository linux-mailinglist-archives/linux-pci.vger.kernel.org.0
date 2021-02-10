Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA07317337
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 23:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhBJWVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 17:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232500AbhBJWVM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 17:21:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCCA564EAC;
        Wed, 10 Feb 2021 22:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612995631;
        bh=rsv3LzAKCAcMhkki6tOZYMJG5D9/R/RrDICI3ql5P1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Qn5OTpP1DRA6+35K5HFsRkFcYlbUfr+/TZTaDsSs0RjK81IhXm3IM6PQlwq7iHLqS
         LxRLAYa8RDHH7bqkIicHBI5LhTyegpOiQVXc9pGqtqBrUNDuNqfl89SQb6Zg4fKv7J
         qadgAju1vSvzqSxHUPXpYJTzl3pijXgZlpKegvwC236gTf0BDWTL4smht1hgFVxMdl
         kDlEI3c6XK4q5mC3qB+5hSo0KMiiWQd8XtDwOdiOMyqKeXrfNzdwS2EYlm1vPUCNIj
         E4f0Eme18dGIC8qCoI9HGyr0GF08i3m+/4GtKB7kDpiViYy1sZpg5u3UhpSlhZGSqd
         zoVVDbXkO3hcQ==
Date:   Wed, 10 Feb 2021 16:20:29 -0600
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
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Revoke mappings like devmem
Message-ID: <20210210222029.GA612769@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204165831.2703772-3-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I see I already acked this, but if you haven't merged it yet there are
a few typos in the commit log:

On Thu, Feb 04, 2021 at 05:58:31PM +0100, Daniel Vetter wrote:
> Since 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims
> the region") /dev/kmem zaps ptes when the kernel requests exclusive
> acccess to an iomem region. And with CONFIG_IO_STRICT_DEVMEM, this is
> the default for all driver uses.

s/ptes/PTEs/

> Except there's two more ways to access PCI BARs: sysfs and proc mmap
> support. Let's plug that hole.

s/there's two/there are two/

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

s/pci access/PCI access/
s/a specific resources/a specific resource/

> A special consideration is for arch_can_pci_mmap_io() - we need to
> make sure that the ->f_mapping doesn't alias between ioport and iomem
> space. There's only 2 ways in-tree to support mmap of ioports: generic
> pci mmap (ARCH_GENERIC_PCI_MMAP_RESOURCE), and sparc as the single
> architecture hand-rolling. Both approach support ioport mmap through a
> special pfn range and not through magic pte attributes. Aliasing is
> therefore not a problem.

s/There's only 2/There are only two/
s/pci mmap/PCI mmap/
s/Both approach/Both approaches/
s/pfn/PFN/
s/pte/PTE/

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
