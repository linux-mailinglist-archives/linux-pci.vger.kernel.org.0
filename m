Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC24C9176
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 18:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiCAR0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 12:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiCARZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 12:25:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6184857480;
        Tue,  1 Mar 2022 09:25:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F7A51042;
        Tue,  1 Mar 2022 09:25:17 -0800 (PST)
Received: from e123427-lin.cambridge.arm.com (unknown [10.57.40.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0D483F73D;
        Tue,  1 Mar 2022 09:25:15 -0800 (PST)
Date:   Tue, 1 Mar 2022 17:25:09 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        "Meena, Mahesh" <mahesh.meena@intel.com>,
        linux-pci@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Prevent recursive locking on interrupt
 allocation
Message-ID: <Yh5W9WHNH2FNu4hG@e123427-lin.cambridge.arm.com>
References: <87a6euub2a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6euub2a.ffs@tglx>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 13, 2022 at 02:54:05PM +0100, Thomas Gleixner wrote:
> Tejas reported the following recursive locking issue:
> 
>  swapper/0/1 is trying to acquire lock:
>  ffff8881074fd0a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x30/0xc0
>  
>  but task is already holding lock:
>  ffff8881017cd6a0 (&md->mutex){+.+.}-{3:3}, at: __pci_enable_msi_range+0xf2/0x290
>  
>  stack backtrace:
>   __mutex_lock+0x9d/0x920
>   msi_get_virq+0x30/0xc0
>   pci_irq_vector+0x26/0x30
>   vmd_msi_init+0xcc/0x210
>   msi_domain_alloc+0xbf/0x150
>   msi_domain_alloc_irqs_descs_locked+0x3e/0xb0
>   __pci_enable_msi_range+0x155/0x290
>   pci_alloc_irq_vectors_affinity+0xba/0x100
>   pcie_port_device_register+0x307/0x550
>   pcie_portdrv_probe+0x3c/0xd0
>   pci_device_probe+0x95/0x110
> 
> This is caused by the VMD MSI code which does a lookup of the Linux
> interrupt number for an VMD managed MSI[X] vector. The lookup function
> tries to acquire the already held mutex.
> 
> Avoid that by caching the Linux interrupt number at initialization time
> instead of looking it up over and over.
> 
> Fixes: 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")
> Reported-by: "Surendrakumar Upadhyay, TejaskumarX" <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Bjorn, this is a fix for a patch we merged in the last cycle,
if possible we should be sending it before v5.17 is released,
please.

Thanks,
Lorenzo

>  drivers/pci/controller/vmd.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -99,11 +99,13 @@ struct vmd_irq {
>   * @srcu:	SRCU struct for local synchronization.
>   * @count:	number of child IRQs assigned to this vector; used to track
>   *		sharing.
> + * @virq:	The underlying VMD Linux interrupt number
>   */
>  struct vmd_irq_list {
>  	struct list_head	irq_list;
>  	struct srcu_struct	srcu;
>  	unsigned int		count;
> +	unsigned int		virq;
>  };
>  
>  struct vmd_dev {
> @@ -253,7 +255,6 @@ static int vmd_msi_init(struct irq_domai
>  	struct msi_desc *desc = arg->desc;
>  	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
>  	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
> -	unsigned int index, vector;
>  
>  	if (!vmdirq)
>  		return -ENOMEM;
> @@ -261,10 +262,8 @@ static int vmd_msi_init(struct irq_domai
>  	INIT_LIST_HEAD(&vmdirq->node);
>  	vmdirq->irq = vmd_next_irq(vmd, desc);
>  	vmdirq->virq = virq;
> -	index = index_from_irqs(vmd, vmdirq->irq);
> -	vector = pci_irq_vector(vmd->dev, index);
>  
> -	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
> +	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip, vmdirq,
>  			    handle_untracked_irq, vmd, NULL);
>  	return 0;
>  }
> @@ -685,7 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev
>  			return err;
>  
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> -		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
> +		vmd->irqs[i].virq = pci_irq_vector(dev, i);
> +		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
>  				       vmd_irq, IRQF_NO_THREAD,
>  				       vmd->name, &vmd->irqs[i]);
>  		if (err)
> @@ -969,7 +969,7 @@ static int vmd_suspend(struct device *de
>  	int i;
>  
>  	for (i = 0; i < vmd->msix_count; i++)
> -		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
> +		devm_free_irq(dev, vmd->irqs[i].virq, &vmd->irqs[i]);
>  
>  	return 0;
>  }
> @@ -981,7 +981,7 @@ static int vmd_resume(struct device *dev
>  	int err, i;
>  
>  	for (i = 0; i < vmd->msix_count; i++) {
> -		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> +		err = devm_request_irq(dev, vmd->irqs[i].virq,
>  				       vmd_irq, IRQF_NO_THREAD,
>  				       vmd->name, &vmd->irqs[i]);
>  		if (err)
