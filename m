Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64CE54689B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344358AbiFJOoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349710AbiFJOnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 10:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF7D1D5182;
        Fri, 10 Jun 2022 07:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0672361F08;
        Fri, 10 Jun 2022 14:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2990DC34114;
        Fri, 10 Jun 2022 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654872230;
        bh=ECJYoM+HpBA74A7MH8CfZXrhqApacRnZb+zOBnW0CNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vd/gBeofU3RArtn+8b5DQL0LE9Y3N57CFiteF51JsbSPGCh/gQjj+4D2kcnQbRNuk
         7e2qPLgHdr+fRHB5+gEi7jLME6cEdjInmVjYHVKw2FEP7BzwkhGp6WmzA9tiwB8wIp
         ZSm//wYv0WpINGmPAbbgBM5cZJqxGsMvbYm+NznYj89k1s/rN24s/JtegbNmMeg+wK
         41tXw7OMfDTdODsl638xuJL6haBPdrO++9n9PjpkDumMFUQMVAgLSqTWqK7Jcs/oqH
         miz5tie15AP2FsgE9J5tw/fl+Q0QSO4L5snja66FjdcarWPL6rpm1bnr8o9BIyni2D
         tOLHFrRh2jsHQ==
Date:   Fri, 10 Jun 2022 09:43:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wang Wenhu <lonehugo@hotmail.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, bhelgaas@google.com,
        gregkh@linuxfoundation.org, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, mdf@kernel.org, trix@redhat.com,
        yilun.xu@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-pci@vger.kernel.org,
        wenhu.wang@hotmail.com
Subject: Re: [PATCH v2] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c files
Message-ID: <20220610144348.GA595923@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB7725A0E10A2460E52EB7EBF1D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 06:41:54AM -0700, Wang Wenhu wrote:
> It is recommended in the "Conditional Compilation" chapter of kernel
> coding-style documentation that preprocessor conditionals should not
> be used in .c files wherever possible.
> 
> As for the micro CONFIG_HAVE_IOREMAP_PROT, now it's a proper chance
> to eliminate it in .c files as we add a no-op function defination
> in the header file if the micro is not enabled.

s/micro/macro/ (twice)
s/defination/definition/

> The main trigger for this patch is an UIO driver series and as Greg
> commented we'd better not use such preprocessor contionals.

s/contionals/conditionals/

> See: https://lore.kernel.org/lkml/YqHy1uXwCLlJmftr@kroah.com/
> For there is little work to do with the UIO driver, I try to push
> this commit independently.
> 
> Signed-off-by: Wang Wenhu <lonehugo@hotmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci/

Thanks for cleaning this up!

> ---
> v2: specify no-op function definition with static inline
> ---
>  drivers/char/mem.c          | 2 --
>  drivers/fpga/dfl-afu-main.c | 2 --
>  drivers/pci/mmap.c          | 2 --
>  drivers/uio/uio.c           | 2 --
>  include/linux/mm.h          | 8 ++++++++
>  mm/memory.c                 | 4 ----
>  6 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 84ca98ed1dad..40186a441e38 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -354,9 +354,7 @@ static inline int private_mapping_ok(struct vm_area_struct *vma)
>  #endif
>  
>  static const struct vm_operations_struct mmap_mem_ops = {
> -#ifdef CONFIG_HAVE_IOREMAP_PROT
>  	.access = generic_access_phys
> -#endif
>  };
>  
>  static int mmap_mem(struct file *file, struct vm_area_struct *vma)
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 7f621e96d3b8..833e14806c7a 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -797,9 +797,7 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  }
>  
>  static const struct vm_operations_struct afu_vma_ops = {
> -#ifdef CONFIG_HAVE_IOREMAP_PROT
>  	.access = generic_access_phys,
> -#endif
>  };
>  
>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
> diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
> index b8c9011987f4..1dcfabf80453 100644
> --- a/drivers/pci/mmap.c
> +++ b/drivers/pci/mmap.c
> @@ -35,9 +35,7 @@ int pci_mmap_page_range(struct pci_dev *pdev, int bar,
>  #endif
>  
>  static const struct vm_operations_struct pci_phys_vm_ops = {
> -#ifdef CONFIG_HAVE_IOREMAP_PROT
>  	.access = generic_access_phys,
> -#endif
>  };
>  
>  int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 43afbb7c5ab9..c9205a121007 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -719,9 +719,7 @@ static int uio_mmap_logical(struct vm_area_struct *vma)
>  }
>  
>  static const struct vm_operations_struct uio_physical_vm_ops = {
> -#ifdef CONFIG_HAVE_IOREMAP_PROT
>  	.access = generic_access_phys,
> -#endif
>  };
>  
>  static int uio_mmap_physical(struct vm_area_struct *vma)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..60c183dce5ea 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1857,8 +1857,16 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
>  	unsigned long *pfn);
>  int follow_phys(struct vm_area_struct *vma, unsigned long address,
>  		unsigned int flags, unsigned long *prot, resource_size_t *phys);
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>  int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
>  			void *buf, int len, int write);
> +#else
> +static inline int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
> +			void *buf, int len, int write)
> +{
> +	return 0;
> +}
> +#endif
>  
>  extern void truncate_pagecache(struct inode *inode, loff_t new);
>  extern void truncate_setsize(struct inode *inode, loff_t newsize);
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a089145cad4..79b94db1bd5e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5437,9 +5437,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  		ret = get_user_pages_remote(mm, addr, 1,
>  				gup_flags, &page, &vma, NULL);
>  		if (ret <= 0) {
> -#ifndef CONFIG_HAVE_IOREMAP_PROT
> -			break;
> -#else
>  			/*
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
> @@ -5453,7 +5450,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  			if (ret <= 0)
>  				break;
>  			bytes = ret;
> -#endif
>  		} else {
>  			bytes = len;
>  			offset = addr & (PAGE_SIZE-1);
> -- 
> 2.25.1
> 
