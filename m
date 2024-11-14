Return-Path: <linux-pci+bounces-16722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5719C8051
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 02:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8932838F4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A21E3DF0;
	Thu, 14 Nov 2024 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arJS9o64"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894321CCEF8
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549535; cv=none; b=ZNlPBRVYtZfkrqqkgeRocYZgXcXWzJYogsPhZEXj/LoJEsd/lwuQGK2SIxVI0uCgeRL7bbVH376At+zyzaABU861Yjl3oxdzGFpqO6BmDodihGnOhlhKWqb/n/GvgcCZUHA1Cbktdv7oO+/pMRqbc22oL1QgQhGZD6+1IdiZ0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549535; c=relaxed/simple;
	bh=hoqhmg6FlBDvQeuzOBErYwmk/yRj4iVunK80ABEHnIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGr0Fo8YUFCUZ5XFMxmLvK2TzR/YRbNJQa/79I/rctvwiRcb6GbLol5HyiX/BoYoBH4bwJDVV+F+RyQQTsNyVYprKwx4cWi2/mP7HbQwBJfQWZw8DwZRIeYmfAfH8Zc3he0ZovRFO1LKc4XkJscT4ZHo/UfjCXpULQ3Zc5/XiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arJS9o64; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731549532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tyzVW+Gg+8+sWP/luqrPCOiZgo6AGIcYlgpgrY3sdVI=;
	b=arJS9o64uGBDIpmXv1JZDULTbNqDXXL+G94JV0/30kSknPj3WLpuqaFX6SpGeqDcWnKKRh
	byl8PTUZgWibaLVb/psug0BE0ITC2XixRX5FqpmMowJVj9mA6tTKks49b/Kk/thArZJfgD
	3R848ueavNL2i2dO7uI7M4pIR5vTBBk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-yJb2Vii1Mz2KxoD1rp3zfw-1; Wed,
 13 Nov 2024 20:58:47 -0500
X-MC-Unique: yJb2Vii1Mz2KxoD1rp3zfw-1
X-Mimecast-MFC-AGG-ID: yJb2Vii1Mz2KxoD1rp3zfw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5967C1956096;
	Thu, 14 Nov 2024 01:58:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.113])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD60819560A3;
	Thu, 14 Nov 2024 01:58:30 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:58:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <ZzVZQbZOYhNF08LX@fedora>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Nov 13, 2024 at 03:26:19PM +0100, Daniel Wagner wrote:
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two function
> share common code and only differ on how the affinity information is
> retrieved. Also, those functions are located in the block subsystem
> where it doesn't really fit in. They are virtio and pci subsystem
> specific.
> 
> Thus introduce provide a generic mapping function which uses the
> irq_get_affinity callback from bus_type.
> 
> Originally idea from Ming Lei <ming.lei@redhat.com>
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq-cpumap.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  2 ++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..3506f1c25a02d331d28212a2a97fb269cb21e738 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -11,6 +11,7 @@
>  #include <linux/smp.h>
>  #include <linux/cpu.h>
>  #include <linux/group_cpus.h>
> +#include <linux/device/bus.h>
>  
>  #include "blk.h"
>  #include "blk-mq.h"
> @@ -54,3 +55,45 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
>  
>  	return NUMA_NO_NODE;
>  }
> +
> +/**
> + * blk_mq_hctx_map_queues - Create CPU to hardware queue mapping
> + * @qmap:	CPU to hardware queue map.
> + * @dev:	The device to map queues.
> + * @offset:	Queue offset to use for the device.
> + *
> + * Create a CPU to hardware queue mapping in @qmap. The struct bus_type
> + * irq_get_affinity callback will be used to retrieve the affinity.
> + */
> +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,

Some drivers may not know hctx at all, maybe blk_mq_map_hw_queues()?

> +			    struct device *dev, unsigned int offset)
> +
> +{
> +	const struct cpumask *(*irq_get_affinity)(struct device *dev,
> +						  unsigned int irq_vec);
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	if (dev->driver->irq_get_affinity)
> +		irq_get_affinity = dev->driver->irq_get_affinity;
> +	else if (dev->bus->irq_get_affinity)
> +		irq_get_affinity = dev->bus->irq_get_affinity;

It is one generic API, I think both 'dev->driver' and
'dev->bus' should be validated here.


Thanks, 
Ming


