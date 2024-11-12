Return-Path: <linux-pci+bounces-16488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B79C4DD5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 05:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800EB1F24EFE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04E84C91;
	Tue, 12 Nov 2024 04:47:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EC19F13C;
	Tue, 12 Nov 2024 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386864; cv=none; b=VN1xaRSzBBYvRGFKxkAm2murO4K2OWGhczd37OdvP/ByvCTiOQB613JII9cO+cUThCx++28pXq18stZF1UPTjIvwlhKkbTXkSAaShT8UbiUyjU53aevgZUzO75hhYNYwDnZmxLHoooAhByQXIAvcE5+vdRAeyfr5jo70/0UWe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386864; c=relaxed/simple;
	bh=LEqqJ4nFtPDR80cCFpUujkkjo5vD242bVGicW1R9Uwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ0FKLCn0R1K/vkgh4DDcSEvJ9CfVJeAVVbW3m3Vv2qQr1VrYneOzi4SDg1W8DgEldUrYs51XZ0EIL29JEg4in/+yaB628tnBLwAQikKnYjnYlBjox78Cb7s+Zf0JOqIVrLY1SldnFqb0wMX5dUOBe+iazTYDIPGd3rqg7pXfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95CAB68D09; Tue, 12 Nov 2024 05:47:36 +0100 (CET)
Date: Tue, 12 Nov 2024 05:47:36 +0100
From: Christoph Hellwig <hch@lst.de>
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
Message-ID: <20241112044736.GA8883@lst.de>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org> <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

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

This seems to mix up a few different things:

 1) adding a new bus operation
 2) implementations of that operation for PCI and virtio
 3) a block layer consumer of the operation

all these really should be separate per-subsystem patches.

You'll also need to Cc the driver model maintainers.

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

This does different things with a NULL argument vs not.  Please split it
into two separate helpers.  The non-NULL case is only uses in hisi_sas,
so it might be worth just open coding it there as well.

> +static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
> +					unsigned int irq_vec)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return pci_irq_get_affinity(pdev, irq_vec);

Nit: this could be shortened to:

	return pci_irq_get_affinity(to_pci_dev(dev), irq_vec);


