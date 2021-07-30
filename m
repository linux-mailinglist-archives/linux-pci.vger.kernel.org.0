Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E63DBF23
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 21:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhG3Tou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 15:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhG3Tot (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 15:44:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012C860F26;
        Fri, 30 Jul 2021 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627674284;
        bh=dxI61sDpO9sLxBOwYd+sYvdJ3WhWDIoa8/pLRkEcWSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oIwPWX+iQ1dhu8H8h/1dEH080nK4p78Td28/cCuqGFg0anBDEYXC9c3wRDg6sB0Ov
         XC/EZBtHCB6Fknv7ZhbocHEggIpf00ViKbe9IAJi2CZj/iDxKWaVYir+qmQA6ysQrn
         WTUEF5+qCkzdNRMI7zgY2Bl4U1FkjdBeugHjd8R4J+uIfejAYT0LausT4dUBmIoV1l
         kL9lJkARmxOFDEId31r+pz3/CV4uFHHst0fVPJmQsWzLrz7ci1Qzuearpr4Mearjfz
         G2zL+cFCu4qOj1laUnSGUxJsIaZBP5v+BpqAzuiT9QJxvETFVR1Kv4hSmTA3yYArKY
         6xkiUxtJE+SMw==
Date:   Fri, 30 Jul 2021 14:44:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs
 open callback
Message-ID: <20210730194442.GA1091180@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729233235.1508920-2-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 11:32:34PM +0000, Krzysztof Wilczyński wrote:
> Defer invocation of the iomem_get_mapping() to the sysfs open callback
> so that it can be executed as needed when the binary sysfs object has
> been accessed.
> 
> To do that, convert the "mapping" member of the struct bin_attribute
> from a pointer to the struct address_space into a function pointer with
> a signature that requires the same return type, and then updates the
> sysfs_kf_bin_open() to invoke provided function should the function
> pointer be valid.
> 
> Also, convert every invocation of iomem_get_mapping() into a function
> pointer assignment, therefore allowing for the iomem_get_mapping()
> invocation to be deferred to when the sysfs open callback runs.
> 
> Thus, this change removes the need for the fs_initcalls to complete
> before any other sub-system that uses the iomem_get_mapping() would be
> able to invoke it safely without leading to a failure and an Oops
> related to an invalid iomem_get_mapping() access.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-sysfs.c | 6 +++---
>  fs/sysfs/file.c         | 2 +-
>  include/linux/sysfs.h   | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5d63df7c1820..76e5545d0e73 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -965,7 +965,7 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_io->read = pci_read_legacy_io;
>  	b->legacy_io->write = pci_write_legacy_io;
>  	b->legacy_io->mmap = pci_mmap_legacy_io;
> -	b->legacy_io->mapping = iomem_get_mapping();
> +	b->legacy_io->mapping = iomem_get_mapping;
>  	pci_adjust_legacy_attr(b, pci_mmap_io);
>  	error = device_create_bin_file(&b->dev, b->legacy_io);
>  	if (error)
> @@ -978,7 +978,7 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_mem->size = 1024*1024;
>  	b->legacy_mem->attr.mode = 0600;
>  	b->legacy_mem->mmap = pci_mmap_legacy_mem;
> -	b->legacy_io->mapping = iomem_get_mapping();
> +	b->legacy_io->mapping = iomem_get_mapping;
>  	pci_adjust_legacy_attr(b, pci_mmap_mem);
>  	error = device_create_bin_file(&b->dev, b->legacy_mem);
>  	if (error)
> @@ -1195,7 +1195,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
>  		}
>  	}
>  	if (res_attr->mmap)
> -		res_attr->mapping = iomem_get_mapping();
> +		res_attr->mapping = iomem_get_mapping;
>  	res_attr->attr.name = res_attr_name;
>  	res_attr->attr.mode = 0600;
>  	res_attr->size = pci_resource_len(pdev, num);
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 9aefa7779b29..a3ee4c32a264 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -175,7 +175,7 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
>  	struct bin_attribute *battr = of->kn->priv;
>  
>  	if (battr->mapping)
> -		of->file->f_mapping = battr->mapping;
> +		of->file->f_mapping = battr->mapping();
>  
>  	return 0;
>  }
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index a12556a4b93a..d5bcc897583c 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -176,7 +176,7 @@ struct bin_attribute {
>  	struct attribute	attr;
>  	size_t			size;
>  	void			*private;
> -	struct address_space	*mapping;
> +	struct address_space *(*mapping)(void);
>  	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
>  			char *, loff_t, size_t);
>  	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
> -- 
> 2.32.0
> 
