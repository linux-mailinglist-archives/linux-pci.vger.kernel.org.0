Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471A13CBD71
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 22:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhGPUEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 16:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232312AbhGPUEx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 16:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AFDB613F3;
        Fri, 16 Jul 2021 20:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626465716;
        bh=rFOR2qypUtELpoy2NWUoxm7klREkrZb97itZWXUaaq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pi9l/EsCuyB3C2oqdMBel42BqfeYCuwLFgejqa+LxYPXLcBaatM7lXFExmrtCrx3m
         BchR35OeiH7MTAe9IsqKSuyT0fTRX5ESy75Eey5eo44I+o0GVu0+HD8q3NK2wplTV3
         rvwLro/bCPchoWBwM+NyAEfcQNl49rj2ZswFD8SO8W9Rc1aUmIuwtzYm+wdtdEYhpA
         TVUy3EQdryL2kJ8mkzjnJhT7t4mL0Iz5gm3c0fDBCTDIOKqTpGIXzsmdsacrDWWXNE
         elut+xl31sz+UAVfyhC9lCXCLW98XJzlkMow/keBWtNLRRAiIDwHoTevOumlr4avmu
         dBvchD8JHB1Ug==
Date:   Fri, 16 Jul 2021 15:01:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <20210716200154.GA2113453@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715120844.636968-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> irq vector allocation with managed affinity may be used by driver, and
> blk-mq needs this info because managed irq will be shutdown when all
> CPUs in the affinity mask are offline.
> 
> The info of using managed irq is often produced by drivers(pci subsystem,

Add space between "drivers" and "(".
s/pci/PCI/

Does this "managed IRQ" (or "managed affinity", not sure what the
correct terminology is here) have something to do with devm?

> platform device, ...), and it is consumed by blk-mq, so different subsystems
> are involved in this info flow

Add period at end of sentence.

> Address this issue by adding one field of .irq_affinity_managed into
> 'struct device'.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/base/platform.c | 7 +++++++
>  drivers/pci/msi.c       | 3 +++
>  include/linux/device.h  | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8640578f45e9..d28cb91d5cf9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
>  				ptr->irq[i], ret);
>  			goto err_free_desc;
>  		}
> +
> +		/*
> +		 * mark the device as irq affinity managed if any irq affinity
> +		 * descriptor is managed
> +		 */
> +		if (desc[i].is_managed)
> +			dev->dev.irq_affinity_managed = true;
>  	}
>  
>  	devres_add(&dev->dev, ptr);
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 3d6db20d1b2b..7ddec90b711d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
>  			affd = &msi_default_affd;
> +		dev->dev.irq_affinity_managed = true;

This is really opaque to me.  I can't tell what the connection between
PCI_IRQ_AFFINITY and irq_affinity_managed is.

AFAICT the only place irq_affinity_managed is ultimately used is
blk_mq_hctx_notify_offline(), and there's no obvious connection
between that and this code.

>  	} else {
>  		if (WARN_ON(affd))
>  			affd = NULL;
> @@ -1215,6 +1216,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  			return nvecs;
>  	}
>  
> +	dev->dev.irq_affinity_managed = false;
> +
>  	/* use legacy IRQ if allowed */
>  	if (flags & PCI_IRQ_LEGACY) {
>  		if (min_vecs == 1 && dev->irq) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 59940f1744c1..9ec6e671279e 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -569,6 +569,7 @@ struct device {
>  #ifdef CONFIG_DMA_OPS_BYPASS
>  	bool			dma_ops_bypass : 1;
>  #endif
> +	bool			irq_affinity_managed : 1;
>  };
>  
>  /**
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
