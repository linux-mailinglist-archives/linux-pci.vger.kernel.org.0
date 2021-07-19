Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2BE3CCEDC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhGSHyV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 03:54:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3427 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhGSHyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 03:54:21 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GStvX0hMDz6D8Zn;
        Mon, 19 Jul 2021 15:36:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 09:51:20 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 08:51:19 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        "Hannes Reinecke" <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
Date:   Mon, 19 Jul 2021 08:51:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210715120844.636968-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/07/2021 13:08, Ming Lei wrote:
> irq vector allocation with managed affinity may be used by driver, and
> blk-mq needs this info because managed irq will be shutdown when all
> CPUs in the affinity mask are offline.
> 
> The info of using managed irq is often produced by drivers(pci subsystem,
> platform device, ...), and it is consumed by blk-mq, so different subsystems
> are involved in this info flow
> 
> Address this issue by adding one field of .irq_affinity_managed into
> 'struct device'.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Did you consider that for PCI device we effectively have this info already:

bool dev_has_managed_msi_irq(struct device *dev)
{
	struct msi_desc *desc;

	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
		if (desc->affinity && desc->affinity->is_managed)
			return true;
	}

	return false;
}

Thanks,
John

> ---
>   drivers/base/platform.c | 7 +++++++
>   drivers/pci/msi.c       | 3 +++
>   include/linux/device.h  | 1 +
>   3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8640578f45e9..d28cb91d5cf9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
>   				ptr->irq[i], ret);
>   			goto err_free_desc;
>   		}
> +
> +		/*
> +		 * mark the device as irq affinity managed if any irq affinity
> +		 * descriptor is managed
> +		 */
> +		if (desc[i].is_managed)
> +			dev->dev.irq_affinity_managed = true;
>   	}
>   
>   	devres_add(&dev->dev, ptr);
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 3d6db20d1b2b..7ddec90b711d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>   	if (flags & PCI_IRQ_AFFINITY) {
>   		if (!affd)
>   			affd = &msi_default_affd;
> +		dev->dev.irq_affinity_managed = true;
>   	} else {
>   		if (WARN_ON(affd))
>   			affd = NULL;
> @@ -1215,6 +1216,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>   			return nvecs;
>   	}
>   
> +	dev->dev.irq_affinity_managed = false;
> +
>   	/* use legacy IRQ if allowed */
>   	if (flags & PCI_IRQ_LEGACY) {
>   		if (min_vecs == 1 && dev->irq) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 59940f1744c1..9ec6e671279e 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -569,6 +569,7 @@ struct device {
>   #ifdef CONFIG_DMA_OPS_BYPASS
>   	bool			dma_ops_bypass : 1;
>   #endif
> +	bool			irq_affinity_managed : 1;
>   };
>   
>   /**
> 

