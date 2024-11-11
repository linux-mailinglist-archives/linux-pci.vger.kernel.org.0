Return-Path: <linux-pci+bounces-16468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208EA9C4577
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A549D1F21107
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9181AB513;
	Mon, 11 Nov 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZuo15Pc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D661AAE2C;
	Mon, 11 Nov 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351653; cv=none; b=L/jhslM0+gWVZX/x1sjYd1Ockv3kBw52+fQ9bNMkvWaYTg3AODNniNBh67OAYPrR+xIjmVuCx/lgqOgCD2UwLOzb4ba162WsNkoLmBhko5m3jCful4FdqNVlRZpZsErDnWbxyHNkqBUqeioWHVk7zYUTvp2E2s1+eFJpwZMuYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351653; c=relaxed/simple;
	bh=mBGeH5YCHeqpmaVtCC4xNxEVGj3Tk2zJbSDEmkvUaZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ic+4OSPci9qseKZqAIk8PuBwmUJMNHdU6h/DRG4x2wywZg3zrdsOOK+GzFcg3psPmQ6h9l2QFzM6kXCuQtIsLgz72BffFf+xXaJrKO1WgtYllTFMw7Sm1Vemr9awBfoIeB1J7MehP7EP9tI823b+gwJhnahd6cGS3wlYO+UMZbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZuo15Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74332C4CECF;
	Mon, 11 Nov 2024 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731351652;
	bh=mBGeH5YCHeqpmaVtCC4xNxEVGj3Tk2zJbSDEmkvUaZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UZuo15PcJS/fEIOQ6yrQZTCNsCHxALYUSOIScmrvPXDJQMhjZNRf770l5Z2728P++
	 sy8pSV0/eNPBepxRoigBkIKb0XH1OvGgWVyPX22NcqViE6DDwLAVVXWnXuCUzpes09
	 lHS0vENq4YFXdU0mUsLirNk95YYHGCJlWvdVwUC/u3R3DDoWinOdJrPNexHJoZJvi+
	 FXMnSuyudT7o6Hbdq9m61YbmKnSrH/ylUSZYPUcgUfq2263puVOgFdFU1l8LgF6TF2
	 DzNYr+bq6UOg+kK26HjR8uGDJagpRazxz87uTZZxnXAtAB+bvlYg8MxiqUp5Ze5QPO
	 hRhDf1RlHJlrQ==
Date: Mon, 11 Nov 2024 13:00:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20241111190051.GA1805960@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>

On Mon, Nov 11, 2024 at 07:02:09PM +0100, Daniel Wagner wrote:
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two function
> share common code and only differ on how the affinity information is
> retrieved. Also, those functions are located in the block subsystem
> where it doesn't really fit in. They are virtio and pci subsystem
> specific.
> 
> Introduce a new callback in struct bus_type to get the affinity mask.
> The callbacks can then be populated by the subsystem directly.
> 
> All but one driver use the subsystem default affinity masks. hisi_sas v2
> depends on a driver specific mapping, thus use the optional argument
> get_queue_affinity to retrieve the mapping.
> 
> Original-by : Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq-cpumap.c      | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c   | 16 ++++++++++++++++
>  drivers/virtio/virtio.c    | 12 ++++++++++++
>  include/linux/blk-mq.h     |  5 +++++
>  include/linux/device/bus.h |  3 +++
>  5 files changed, 76 insertions(+)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..4dd703f5ee647fd1ba0b14ca11ddfdefa98a9a25 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -54,3 +54,43 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
>  
>  	return NUMA_NO_NODE;
>  }
> +
> +/**
> + * blk_mq_hctx_map_queues - Create CPU to hardware queue mapping
> + * @qmap:	CPU to hardware queue map.
> + * @dev:	The device to map queues.
> + * @offset:	Queue offset to use for the device.
> + * @get_irq_affinity:	Optional callback to retrieve queue affinity.
> + *
> + * Create a CPU to hardware queue mapping in @qmap. For each queue
> + * @get_queue_affinity will be called. If @get_queue_affinity is not
> + * provided, then the bus_type irq_get_affinity callback will be
> + * used to retrieve the affinity.
> + */
> +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> +			    struct device *dev, unsigned int offset,
> +			    get_queue_affinity_fn *get_irq_affinity)
> +{
> +	const struct cpumask *mask = NULL;
> +	unsigned int queue, cpu;
> +
> +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> +		if (get_irq_affinity)
> +			mask = get_irq_affinity(dev, queue + offset);
> +		else if (dev->bus->irq_get_affinity)
> +			mask = dev->bus->irq_get_affinity(dev, queue + offset);
> +
> +		if (!mask)
> +			goto fallback;
> +
> +		for_each_cpu(cpu, mask)
> +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> +	}
> +
> +	return;
> +
> +fallback:
> +	WARN_ON_ONCE(qmap->nr_queues > 1);
> +	blk_mq_clear_mq_map(qmap);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_hctx_map_queues);
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 35270172c833186995aebdda6f95ab3ffd7c67a0..59e5f430a380285162a87bd1a9b392bba8066450 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1670,6 +1670,21 @@ static void pci_dma_cleanup(struct device *dev)
>  		iommu_device_unuse_default_domain(dev);
>  }
>  
> +/**
> + * pci_device_irq_get_affinity - get affinity mask queue mapping for PCI device
> + * @dev: ptr to dev structure
> + * @irq_vec: interrupt vector number
> + *
> + * This function returns for a queue the affinity mask for a PCI device.

From the PCI core perspective, this is only the *IRQ* affinity mask.
The queue connection is not relevant here and probably confusing.

  ... - get IRQ affinity mask for device

  Return the CPU affinity mask for @dev and @irq_vec.

With the above changes,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> + */
> +static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
> +					unsigned int irq_vec)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return pci_irq_get_affinity(pdev, irq_vec);
> +}
> +
>  const struct bus_type pci_bus_type = {
>  	.name		= "pci",
>  	.match		= pci_bus_match,
> @@ -1677,6 +1692,7 @@ const struct bus_type pci_bus_type = {
>  	.probe		= pci_device_probe,
>  	.remove		= pci_device_remove,
>  	.shutdown	= pci_device_shutdown,
> +	.irq_get_affinity = pci_device_irq_get_affinity,
>  	.dev_groups	= pci_dev_groups,
>  	.bus_groups	= pci_bus_groups,
>  	.drv_groups	= pci_drv_groups,
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43bb7db5fc991b0cc0979d2e86f7b9b..86390db7e74befa17c9fa146ab6b454bbae3b7f5 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -377,6 +377,17 @@ static void virtio_dev_remove(struct device *_d)
>  	of_node_put(dev->dev.of_node);
>  }
>  
> +static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
> +						     unsigned int irq_veq)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +
> +	if (!dev->config->get_vq_affinity)
> +		return NULL;
> +
> +	return dev->config->get_vq_affinity(dev, irq_veq);
> +}
> +
>  static const struct bus_type virtio_bus = {
>  	.name  = "virtio",
>  	.match = virtio_dev_match,
> @@ -384,6 +395,7 @@ static const struct bus_type virtio_bus = {
>  	.uevent = virtio_uevent,
>  	.probe = virtio_dev_probe,
>  	.remove = virtio_dev_remove,
> +	.irq_get_affinity = virtio_irq_get_affinity,
>  };
>  
>  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2035fad3131fb60781957095ce8a3a941dd104be..6b40af77bf44afa7112d274b731b591f2a67d68c 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -922,7 +922,12 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
>  void blk_freeze_queue_start_non_owner(struct request_queue *q);
>  
> +typedef const struct cpumask *(get_queue_affinity_fn)(struct device *dev,
> +						      unsigned int queue);
>  void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
> +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> +			    struct device *dev, unsigned int offset,
> +			    get_queue_affinity_fn *get_queue_affinity);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
>  
>  void blk_mq_quiesce_queue_nowait(struct request_queue *q);
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,6 +48,7 @@ struct fwnode_handle;
>   *		will never get called until they do.
>   * @remove:	Called when a device removed from this bus.
>   * @shutdown:	Called at shut-down time to quiesce the device.
> + * @irq_get_affinity:	Get IRQ affinity mask for the device on this bus.
>   *
>   * @online:	Called to put the device back online (after offlining it).
>   * @offline:	Called to put the device offline for hot-removal. May fail.
> @@ -87,6 +88,8 @@ struct bus_type {
>  	void (*sync_state)(struct device *dev);
>  	void (*remove)(struct device *dev);
>  	void (*shutdown)(struct device *dev);
> +	const struct cpumask *(*irq_get_affinity)(struct device *dev,
> +			unsigned int irq_vec);
>  
>  	int (*online)(struct device *dev);
>  	int (*offline)(struct device *dev);
> 
> -- 
> 2.47.0
> 

