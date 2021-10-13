Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6842B24B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 03:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhJMBhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 21:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhJMBhU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 21:37:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A8C161056;
        Wed, 13 Oct 2021 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634088918;
        bh=QeSMIWRZp7x+XaAw3ZCrt23uzGcrj1rReuYX+snVCF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DMJ4I0/WR2D8ECWc74JA9mCo8JZ13Res2KhFqKyGiOgwpet87tQ25PFZrsd1AuetZ
         efv9OOV3BCZYgkKMllCASbO4IVgTAR/uFsk+u776UgjErHp5vEvNODjI5amWgryDGE
         V9zaBCgIPFR7POOFr+iy7jpYxODQeAYWb73vdSs2eDyjg4YkgtNyil48R5ljTt6Lt1
         /3hByjykPlFD9SvnPhnB2d28I/iXKBzE7VPBlWHkY6MOSFwRsx7R1tRqCXBOrONAmm
         JXTTpznEY/W7Y6F5inhNdc3bH1AfYi3AYdmpPuvEsC7nqepiEM3N2ia1Seb4BNJVmw
         qeh9zocoWrahQ==
Date:   Tue, 12 Oct 2021 20:35:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     bhelgaas@google.com, andy.shevchenko@gmail.com, maz@kernel.org,
        tglx@linutronix.de, song.bao.hua@hisilicon.com, 21cnbao@gmail.com,
        gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/MSI: fix page fault when msi_populate_sysfs()
 failed
Message-ID: <20211013013515.GA1860366@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012071556.939137-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 03:15:56PM +0800, Wang Hai wrote:
> I got a page fault report when doing fault injection test:
> 
> BUG: unable to handle page fault for address: fffffffffffffff4
> ...
> RIP: 0010:sysfs_remove_groups+0x25/0x60
> ...
> Call Trace:
>  msi_destroy_sysfs+0x30/0xa0
>  free_msi_irqs+0x11d/0x1b0
>  __pci_enable_msix_range+0x67f/0x760
>  pci_alloc_irq_vectors_affinity+0xe7/0x170
>  vp_find_vqs_msix+0x129/0x560
>  vp_find_vqs+0x52/0x230
>  vp_modern_find_vqs+0x47/0xb0
>  p9_virtio_probe+0xa1/0x460 [9pnet_virtio]
> ...
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> When populating msi_irqs sysfs failed (such as msi_attrs = kcalloc()
> in msi_populate_sysfs() failed) in msi_capability_init() or
> msix_capability_init(), dev->msi_irq_groups will point to ERR_PTR(...).
> This will cause a page fault when destroying the wrong
> dev->msi_irq_groups in free_msi_irqs().
> 
> msix_capability_init()/msi_capability_init()
> 	msi_populate_sysfs()
> 		msi_attrs = kcalloc() // fault injection, let msi_attrs = NULL
> 	free_msi_irqs()
> 		msi_destroy_sysfs() // msi_irq_groups is ERR_PTR(...), page fault
> 
> Define a temp variable and assign it to dev->msi_irq_groups if
> the temp variable is not PTR_ERR.
> 
> Fixes: 2f170814bdd2 ("genirq/msi: Move MSI sysfs handling from PCI to MSI core")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Acked-by: Barry Song <song.bao.hua@hisilicon.com>

2f170814bdd2 appeared in v5.15-rc1, so I applied this to for-linus so
we can fix it before v5.15.  Thank you!

> ---
> v2->v3: refine the commit log
> v1->v2: introduce temporary variable 'groups'
>  drivers/pci/msi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0099a00af361..4b4792940e86 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -535,6 +535,7 @@ static int msi_verify_entries(struct pci_dev *dev)
>  static int msi_capability_init(struct pci_dev *dev, int nvec,
>  			       struct irq_affinity *affd)
>  {
> +	const struct attribute_group **groups;
>  	struct msi_desc *entry;
>  	int ret;
>  
> @@ -558,12 +559,14 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  	if (ret)
>  		goto err;
>  
> -	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
> -	if (IS_ERR(dev->msi_irq_groups)) {
> -		ret = PTR_ERR(dev->msi_irq_groups);
> +	groups = msi_populate_sysfs(&dev->dev);
> +	if (IS_ERR(groups)) {
> +		ret = PTR_ERR(groups);
>  		goto err;
>  	}
>  
> +	dev->msi_irq_groups = groups;
> +
>  	/* Set MSI enabled bits	*/
>  	pci_intx_for_msi(dev, 0);
>  	pci_msi_set_enable(dev, 1);
> @@ -691,6 +694,7 @@ static void msix_mask_all(void __iomem *base, int tsize)
>  static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  				int nvec, struct irq_affinity *affd)
>  {
> +	const struct attribute_group **groups;
>  	void __iomem *base;
>  	int ret, tsize;
>  	u16 control;
> @@ -730,12 +734,14 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  
>  	msix_update_entries(dev, entries);
>  
> -	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
> -	if (IS_ERR(dev->msi_irq_groups)) {
> -		ret = PTR_ERR(dev->msi_irq_groups);
> +	groups = msi_populate_sysfs(&dev->dev);
> +	if (IS_ERR(groups)) {
> +		ret = PTR_ERR(groups);
>  		goto out_free;
>  	}
>  
> +	dev->msi_irq_groups = groups;
> +
>  	/* Set MSI-X enabled bits and unmask the function */
>  	pci_intx_for_msi(dev, 0);
>  	dev->msix_enabled = 1;
> -- 
> 2.17.1
> 
