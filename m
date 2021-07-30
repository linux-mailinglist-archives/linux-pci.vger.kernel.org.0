Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3D3DBF24
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhG3Tpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 15:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhG3Tp3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 15:45:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53ADA60F36;
        Fri, 30 Jul 2021 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627674324;
        bh=fXb4gi1vRSfl0nvKyqpj3GrPscvlNkPH3IhDaRd7ga4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IqRL85qGoxjS+GE3eTK2QA5ftQixOCr0QKx1F2pkKYGi3U7IZSJj9wD/SgnzHM/OY
         F7tUmanaCg5egMQeM3qI9tfXMWOuVzufhNlyLTZg3FPpPSUl92G+nINqI/5JWjHXTg
         TpxRshcGy803RRFSYRv+AVLjqfNZdJ4TyS0XgigEjrZOxojf8D8kt8RomrGnavGXKP
         GgpgpDN8PXz4D5GLKA9aZBDDAA/za7Cbgp0OM1k6vtd0qmDvFP1pCFYtRRF2Hq24dn
         KMlxwJ14Py43CZ67cYJuZ5XaqytVCxdbpiMIs1YX9xjH1lu42TRzUe9oUAnTG8eX5P
         jtJdRQBHOoR4w==
Date:   Fri, 30 Jul 2021 14:45:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sysfs: Rename struct bin_attribute member to
 f_mapping
Message-ID: <20210730194523.GA1091516@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729233235.1508920-3-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 11:32:35PM +0000, Krzysztof Wilczyński wrote:
> There are two users of iomem_get_mapping(), the struct file and struct
> bin_attribute.  The former has a member called "f_mapping" and the
> latter has a member called "mapping", and both are poniters to struct
> address_space.

Nit: s/poniters/pointers/

> Rename struct bin_attribute member to "f_mapping" to keep both meaning
> and the usage consistent with other users of iomem_get_mapping().
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-sysfs.c | 6 +++---
>  fs/sysfs/file.c         | 4 ++--
>  include/linux/sysfs.h   | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 76e5545d0e73..f65382915f01 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -965,7 +965,7 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_io->read = pci_read_legacy_io;
>  	b->legacy_io->write = pci_write_legacy_io;
>  	b->legacy_io->mmap = pci_mmap_legacy_io;
> -	b->legacy_io->mapping = iomem_get_mapping;
> +	b->legacy_io->f_mapping = iomem_get_mapping;
>  	pci_adjust_legacy_attr(b, pci_mmap_io);
>  	error = device_create_bin_file(&b->dev, b->legacy_io);
>  	if (error)
> @@ -978,7 +978,7 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_mem->size = 1024*1024;
>  	b->legacy_mem->attr.mode = 0600;
>  	b->legacy_mem->mmap = pci_mmap_legacy_mem;
> -	b->legacy_io->mapping = iomem_get_mapping;
> +	b->legacy_io->f_mapping = iomem_get_mapping;
>  	pci_adjust_legacy_attr(b, pci_mmap_mem);
>  	error = device_create_bin_file(&b->dev, b->legacy_mem);
>  	if (error)
> @@ -1195,7 +1195,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
>  		}
>  	}
>  	if (res_attr->mmap)
> -		res_attr->mapping = iomem_get_mapping;
> +		res_attr->f_mapping = iomem_get_mapping;
>  	res_attr->attr.name = res_attr_name;
>  	res_attr->attr.mode = 0600;
>  	res_attr->size = pci_resource_len(pdev, num);
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index a3ee4c32a264..d019d6ac6ad0 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -174,8 +174,8 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
>  {
>  	struct bin_attribute *battr = of->kn->priv;
>  
> -	if (battr->mapping)
> -		of->file->f_mapping = battr->mapping();
> +	if (battr->f_mapping)
> +		of->file->f_mapping = battr->f_mapping();
>  
>  	return 0;
>  }
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index d5bcc897583c..e3f1e8ac1f85 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -176,7 +176,7 @@ struct bin_attribute {
>  	struct attribute	attr;
>  	size_t			size;
>  	void			*private;
> -	struct address_space *(*mapping)(void);
> +	struct address_space *(*f_mapping)(void);
>  	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
>  			char *, loff_t, size_t);
>  	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
> -- 
> 2.32.0
> 
