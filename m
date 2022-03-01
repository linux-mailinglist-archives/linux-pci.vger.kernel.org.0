Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97FF4C942E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 20:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiCATYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 14:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCATYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 14:24:53 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E6140CC;
        Tue,  1 Mar 2022 11:24:10 -0800 (PST)
Message-ID: <d96528a9-ae1e-d09c-f3e2-1cba0a88c483@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646162648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fso8h5lyoc1XbXbWlpMD5KMQHPxcp2kQ/qyBvjy+VZA=;
        b=AEPe+60dmQl601WU8/W2rlDSJBjC/nwgZyxPkL2X8lcz65hlirA02vIrqiuuu/HQLNWud1
        VNmK12Frz3n7FdQoKktQaR+PFZwM6240540CQUjFTpb2ySjWo6urgtGa6x/KIoi4uxmzzG
        4ZUSNB538s0A/FkOd7rZDNEQaZlZ99A=
Date:   Tue, 1 Mar 2022 12:24:06 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Prevent recursive locking on interrupt
 allocation
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        "Meena, Mahesh" <mahesh.meena@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>
References: <87a6euub2a.ffs@tglx>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <87a6euub2a.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is how it used to be before I removed the member to better
cache align the vmd_irq_list struct, but then the scru_struct grew
to negate that benefit.

So this is good
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>

On 2/13/2022 6:54 AM, Thomas Gleixner wrote:
> Tejas reported the following recursive locking issue:
> 
>   swapper/0/1 is trying to acquire lock:
>   ffff8881074fd0a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x30/0xc0
>   
>   but task is already holding lock:
>   ffff8881017cd6a0 (&md->mutex){+.+.}-{3:3}, at: __pci_enable_msi_range+0xf2/0x290
>   
>   stack backtrace:
>    __mutex_lock+0x9d/0x920
>    msi_get_virq+0x30/0xc0
>    pci_irq_vector+0x26/0x30
>    vmd_msi_init+0xcc/0x210
>    msi_domain_alloc+0xbf/0x150
>    msi_domain_alloc_irqs_descs_locked+0x3e/0xb0
>    __pci_enable_msi_range+0x155/0x290
>    pci_alloc_irq_vectors_affinity+0xba/0x100
>    pcie_port_device_register+0x307/0x550
>    pcie_portdrv_probe+0x3c/0xd0
>    pci_device_probe+0x95/0x110
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
> 
> ---
>   drivers/pci/controller/vmd.c |   14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -99,11 +99,13 @@ struct vmd_irq {
>    * @srcu:	SRCU struct for local synchronization.
>    * @count:	number of child IRQs assigned to this vector; used to track
>    *		sharing.
> + * @virq:	The underlying VMD Linux interrupt number
>    */
>   struct vmd_irq_list {
>   	struct list_head	irq_list;
>   	struct srcu_struct	srcu;
>   	unsigned int		count;
> +	unsigned int		virq;
>   };
>   
>   struct vmd_dev {
> @@ -253,7 +255,6 @@ static int vmd_msi_init(struct irq_domai
>   	struct msi_desc *desc = arg->desc;
>   	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
>   	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
> -	unsigned int index, vector;
>   
>   	if (!vmdirq)
>   		return -ENOMEM;
> @@ -261,10 +262,8 @@ static int vmd_msi_init(struct irq_domai
>   	INIT_LIST_HEAD(&vmdirq->node);
>   	vmdirq->irq = vmd_next_irq(vmd, desc);
>   	vmdirq->virq = virq;
> -	index = index_from_irqs(vmd, vmdirq->irq);
> -	vector = pci_irq_vector(vmd->dev, index);
>   
> -	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
> +	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip, vmdirq,
>   			    handle_untracked_irq, vmd, NULL);
>   	return 0;
>   }
> @@ -685,7 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev
>   			return err;
>   
>   		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> -		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
> +		vmd->irqs[i].virq = pci_irq_vector(dev, i);
> +		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
>   				       vmd_irq, IRQF_NO_THREAD,
>   				       vmd->name, &vmd->irqs[i]);
>   		if (err)
> @@ -969,7 +969,7 @@ static int vmd_suspend(struct device *de
>   	int i;
>   
>   	for (i = 0; i < vmd->msix_count; i++)
> -		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
> +		devm_free_irq(dev, vmd->irqs[i].virq, &vmd->irqs[i]);
>   
>   	return 0;
>   }
> @@ -981,7 +981,7 @@ static int vmd_resume(struct device *dev
>   	int err, i;
>   
>   	for (i = 0; i < vmd->msix_count; i++) {
> -		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> +		err = devm_request_irq(dev, vmd->irqs[i].virq,
>   				       vmd_irq, IRQF_NO_THREAD,
>   				       vmd->name, &vmd->irqs[i]);
>   		if (err)
