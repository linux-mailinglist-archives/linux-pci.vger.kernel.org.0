Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46737EAED4
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 12:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJaLY2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 07:24:28 -0400
Received: from foss.arm.com ([217.140.110.172]:47446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfJaLY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 07:24:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AB641F1;
        Thu, 31 Oct 2019 04:24:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986513F719;
        Thu, 31 Oct 2019 04:24:26 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:24:24 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: vmd: Add indirection layer to vmd irq lists
Message-ID: <20191031112424.GB26080@e121166-lin.cambridge.arm.com>
References: <1571658459-5668-1-git-send-email-jonathan.derrick@intel.com>
 <1571658459-5668-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571658459-5668-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 05:47:39AM -0600, Jon Derrick wrote:
> With CONFIG_MAXSMP and other debugging options enabled, the size of an
> srcu_struct can grow quite large. These are embedded in the vmd_irq_list
> struct, and a N=64 allocation can exceed MAX_ORDER, violating reclaim
> rules.
> 
> This patch changes the irq list array into an array of pointers to irq
> lists to avoid allocation failures with greater msix counts.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)

Hi Jon,

I think that for bisectability reasons these two patches should
be squashed together. Also if you can provide more fine grain details
of what we are fixing in the commit log I think that would be
beneficial.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index c4de95a..096006e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -92,7 +92,7 @@ struct vmd_dev {
>  	char __iomem		*cfgbar;
>  
>  	int msix_count;
> -	struct vmd_irq_list	*irqs;
> +	struct vmd_irq_list	**irqs;
>  
>  	struct pci_sysdata	sysdata;
>  	struct resource		resources[3];
> @@ -194,7 +194,7 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
>  	unsigned long flags;
>  
>  	if (vmd->msix_count == 1)
> -		return &vmd->irqs[0];
> +		return vmd->irqs[0];
>  
>  	/*
>  	 * White list for fast-interrupt handlers. All others will share the
> @@ -204,17 +204,17 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
>  	case PCI_CLASS_STORAGE_EXPRESS:
>  		break;
>  	default:
> -		return &vmd->irqs[0];
> +		return vmd->irqs[0];
>  	}
>  
>  	raw_spin_lock_irqsave(&list_lock, flags);
>  	for (i = 1; i < vmd->msix_count; i++)
> -		if (vmd->irqs[i].count < vmd->irqs[best].count)
> +		if (vmd->irqs[i]->count < vmd->irqs[best]->count)
>  			best = i;
> -	vmd->irqs[best].count++;
> +	vmd->irqs[best]->count++;
>  	raw_spin_unlock_irqrestore(&list_lock, flags);
>  
> -	return &vmd->irqs[best];
> +	return vmd->irqs[best];
>  }
>  
>  static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
> @@ -764,15 +764,22 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < vmd->msix_count; i++) {
> -		err = init_srcu_struct(&vmd->irqs[i].srcu);
> +		vmd->irqs[i] = devm_kcalloc(&dev->dev, 1, sizeof(**vmd->irqs),
> +					    GFP_KERNEL);
> +		if (!vmd->irqs[i])
> +			return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < vmd->msix_count; i++) {
> +		err = init_srcu_struct(&vmd->irqs[i]->srcu);
>  		if (err)
>  			return err;
>  
> -		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> -		vmd->irqs[i].index = i;
> +		INIT_LIST_HEAD(&vmd->irqs[i]->irq_list);
> +		vmd->irqs[i]->index = i;
>  		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
>  				       vmd_irq, IRQF_NO_THREAD,
> -				       "vmd", &vmd->irqs[i]);
> +				       "vmd", vmd->irqs[i]);
>  		if (err)
>  			return err;
>  	}
> @@ -793,7 +800,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
>  	int i;
>  
>  	for (i = 0; i < vmd->msix_count; i++)
> -		cleanup_srcu_struct(&vmd->irqs[i].srcu);
> +		cleanup_srcu_struct(&vmd->irqs[i]->srcu);
>  }
>  
>  static void vmd_remove(struct pci_dev *dev)
> @@ -817,7 +824,7 @@ static int vmd_suspend(struct device *dev)
>  	int i;
>  
>  	for (i = 0; i < vmd->msix_count; i++)
> -                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
> +                devm_free_irq(dev, pci_irq_vector(pdev, i), vmd->irqs[i]);
>  
>  	pci_save_state(pdev);
>  	return 0;
> @@ -832,7 +839,7 @@ static int vmd_resume(struct device *dev)
>  	for (i = 0; i < vmd->msix_count; i++) {
>  		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>  				       vmd_irq, IRQF_NO_THREAD,
> -				       "vmd", &vmd->irqs[i]);
> +				       "vmd", vmd->irqs[i]);
>  		if (err)
>  			return err;
>  	}
> -- 
> 1.8.3.1
> 
