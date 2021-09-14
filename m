Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE040B7BA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 21:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhINTQP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 15:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232695AbhINTQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 15:16:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A49661029;
        Tue, 14 Sep 2021 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631646896;
        bh=mhpvGEfIx9+vy8CiR5B76VViwpfNveCB3DV3KqfHF1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FJPv9VIL0M9ynPnsOHyqiGeIovkGXE9n0Tu5GuX7GzHDfJIVo+EizAzqcHoeV7VNo
         UbjGuHhxWpF1ON7vnENFmtHBopjqUVMX7V8Nj45xJCYY29oPFcwcKMbz9lmbJnT6Rf
         kJsVrUTbudUhXX1X2y70+X9ROn19daULMs5FcxA1BNgYci7+LwGCtbF5zYjf/kr8tV
         RhZNth9Ithy2UyBjxwKKvrzMPzGVJpktfB72TaxzH/qA3g+zR1JHNTLIyCtG8XCpoG
         +sNRSzSdJbMwdrKJaXIs61OPswBqOyTRje400uqHSInXGHj8aluKFlft3YRneOUahP
         CbMWV5zeTvL9w==
Date:   Tue, 14 Sep 2021 14:14:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: vmd: assign a number to each vmd controller
Message-ID: <20210914191455.GA1446002@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631532337-12473-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 07:25:37PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> If the system has multiple vmd controllers, the current vmd driver
> does not assign a number to each controller, so when analyzing the
> interrupt through /proc/interrupt, the names of all controllers are
> the same, which is not very convenient for problem analysis. Here,
> try to assign a number to each vmd controller.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

If you repost this for any reason, please update your subject line and
commit log to match the convention, e.g.,

  PCI: vmd: Assign a number to each VMD controller

  If the system has multiple VMD controllers, the current vmd driver
  ...
  try to assign a number to each VMD controller.

If not, Lorenzo might fix this up for you.

> ---
>  drivers/pci/controller/vmd.c | 58 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e3fcdfe..c334396 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -69,6 +69,8 @@ enum vmd_features {
>  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
>  };
>  
> +static DEFINE_IDA(vmd_instance_ida);
> +
>  /*
>   * Lock for manipulating VMD IRQ lists.
>   */
> @@ -119,6 +121,8 @@ struct vmd_dev {
>  	struct pci_bus		*bus;
>  	u8			busn_start;
>  	u8			first_vec;
> +	char			*name;
> +	int			instance;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -599,7 +603,7 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
>  		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
>  				       vmd_irq, IRQF_NO_THREAD,
> -				       "vmd", &vmd->irqs[i]);
> +				       vmd->name, &vmd->irqs[i]);
>  		if (err)
>  			return err;
>  	}
> @@ -769,28 +773,48 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	unsigned long features = (unsigned long) id->driver_data;
>  	struct vmd_dev *vmd;
> -	int err;
> +	int err = 0;
>  
> -	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
> -		return -ENOMEM;
> +	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20)) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
>  	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
> -	if (!vmd)
> -		return -ENOMEM;
> +	if (!vmd) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
>  	vmd->dev = dev;
> +	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
> +	if (vmd->instance < 0) {
> +		err = vmd->instance;
> +		goto out;
> +	}
> +
> +	vmd->name = kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
> +	if (!vmd->name) {
> +		err = -ENOMEM;
> +		goto out_release_instance;
> +	}
> +
>  	err = pcim_enable_device(dev);
>  	if (err < 0)
> -		return err;
> +		goto out_release_instance;
>  
>  	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
> -	if (!vmd->cfgbar)
> -		return -ENOMEM;
> +	if (!vmd->cfgbar) {
> +		err = -ENOMEM;
> +		goto out_release_instance;
> +	}
>  
>  	pci_set_master(dev);
>  	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
> -	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
> -		return -ENODEV;
> +	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32))) {
> +		err = -ENODEV;
> +		goto out_release_instance;
> +	}
>  
>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>  		vmd->first_vec = 1;
> @@ -799,11 +823,17 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, features);
>  	if (err)
> -		return err;
> +		goto out_release_instance;
>  
>  	dev_info(&vmd->dev->dev, "Bound to PCI domain %04x\n",
>  		 vmd->sysdata.domain);
>  	return 0;
> +
> + out_release_instance:
> +	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> +	kfree(vmd->name);
> + out:
> +	return err;
>  }
>  
>  static void vmd_cleanup_srcu(struct vmd_dev *vmd)
> @@ -824,6 +854,8 @@ static void vmd_remove(struct pci_dev *dev)
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
>  	vmd_remove_irq_domain(vmd);
> +	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> +	kfree(vmd->name);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -848,7 +880,7 @@ static int vmd_resume(struct device *dev)
>  	for (i = 0; i < vmd->msix_count; i++) {
>  		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>  				       vmd_irq, IRQF_NO_THREAD,
> -				       "vmd", &vmd->irqs[i]);
> +				       vmd->name, &vmd->irqs[i]);
>  		if (err)
>  			return err;
>  	}
> -- 
> 1.8.3.1
> 
