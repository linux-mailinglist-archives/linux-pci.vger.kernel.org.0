Return-Path: <linux-pci+bounces-16540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23D9C59BC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 14:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DD284E21
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC671FBF51;
	Tue, 12 Nov 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AEVL3aiL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC051FBCB4;
	Tue, 12 Nov 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419927; cv=none; b=nGKQxcDwLhY7e8scpc7lv1FQYweY+jP45s65S5T7/vUhO9kZyb6VzxZNByRSSmv0Gl/THUd1yvmBNYUwMTITcizbfcjmr8y31XL1+qR6uG3RaL3KotL6pGKYTF4kPSahHunUDXN9fiK2WcKypX9HmoAFf8xEGwwDg0QEFdXGpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419927; c=relaxed/simple;
	bh=4pQscTrEU5vmK5o46Z8CwGup1txTZg9HfKzeFdSrbS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYVU88uyHi62isQ5CP1SEscHXoNC26YU2OjtubkkaWn5cPXUC24/T5qT0Uga8onY0pGegbNqi3VOEsYsPYJNazYnCoVFqQUiCVzDWIMPaoVr12ODvFCp1hM0MwRT3FgdKvTFs0FNRO8CTUDUa5XsveVkiCJLUCnLRnSjQjcmaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AEVL3aiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341EAC4CECD;
	Tue, 12 Nov 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731419926;
	bh=4pQscTrEU5vmK5o46Z8CwGup1txTZg9HfKzeFdSrbS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEVL3aiL8wTkbdWnNSbzgcdNk3RQPWC313AxWLqPSQ8lsIHiJyIIQ+a1+0brKoEv7
	 KUUta4ZAheLRxq/dXvj3W5IPp6XNi2jYXbYffK6aebTP7RStJ8pz1CsuOdvXtnlcum
	 RimsoDVR8th5qGmtSlee4+rtTASaMD19tU6j829U=
Date: Tue, 12 Nov 2024 14:58:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <2024111202-parish-prowess-78bc@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>

On Tue, Nov 12, 2024 at 02:26:19PM +0100, Daniel Wagner wrote:
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
>  block/blk-mq-cpumap.c  | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  2 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..db22a7d523a2762b76398fdd768f55efd1d6d669 100644
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
> @@ -54,3 +55,39 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
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
> +			    struct device *dev, unsigned int offset)
> +
> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	if (!dev->bus->irq_get_affinity)
> +		goto fallback;

I think this is better than hard-coding it, but are you sure that the
bus will always be bound to the device here so that you have a valid
bus-> pointer?

thanks,

greg k-h

