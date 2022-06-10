Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982325462A7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiFJJlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbiFJJlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:41:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF381915DB;
        Fri, 10 Jun 2022 02:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B37D1CE3433;
        Fri, 10 Jun 2022 09:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBF3C34114;
        Fri, 10 Jun 2022 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654854072;
        bh=RFUzyhUSwzSu4iiHMiqKtHk3uhYnFdDUQekeZLUrGmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAJdh4OPIfIrsMMSyYq0pYDhh9+9rJgP2K/4RZHv6EPvUgWlk8QHEHDAGvr2rJK3V
         YGiwI6CK3/M+WgZBsTIFlfYQJfXnRpJBu0NXcSFJS4xBjPIs8OQ1HWYsy9coEJWm/c
         bihiPgSDbzv8rsP8yPuyzSCUHQqqr+jrY0fSFG1o=
Date:   Fri, 10 Jun 2022 11:41:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Wenhu <lonehugo@hotmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FPGA DFL DRIVERS" <linux-fpga@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        wenhu.wang@hotmail.com
Subject: Re: [PATCH] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c files
Message-ID: <YqMRtWAH5fIWsLQB@kroah.com>
References: <PN3PR01MB7725BD573E8D63C1CB978AD8D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB7725BD573E8D63C1CB978AD8D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 02:25:18AM -0700, Wang Wenhu wrote:
> It is recommended in the "Conditional Compilation" chapter of kernel
> coding-style documentation that preprocessor conditionals should not
> be used in .c files wherever possible.
> 
> As for the micro CONFIG_HAVE_IOREMAP_PROT, now it's a proper chance
> to eliminate it in .c files as we add a no-op function defination
> in the header file if the micro is not enabled.
> 
> The main trigger for this patch is an UIO driver series and as Greg
> commented we'd better not use such preprocessor contionals.
> See: https://lore.kernel.org/lkml/YqHy1uXwCLlJmftr@kroah.com/
> For there is little work to do with the UIO driver, I try to push
> this commit independently.
> 
> Signed-off-by: Wang Wenhu <lonehugo@hotmail.com>
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
> index bc8f326be0ce..66d0cff6054e 100644
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
> +int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
> +			void *buf, int len, int write)

This needs to be an inline function, right?

Did you test build this?

thanks,

greg k-h
