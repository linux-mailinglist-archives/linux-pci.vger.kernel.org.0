Return-Path: <linux-pci+bounces-13186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C219785B4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA83B22D4B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7B56B72;
	Fri, 13 Sep 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p16OlQEp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D114A85;
	Fri, 13 Sep 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244817; cv=none; b=efPmtKVwStzx5yYJ01HifOnxksYX2SUowMLBDGAQiHrYdMX3cPN2TxRcNliXbmqd2ap7laG+wDFiDQbU5pB3+Fu8wHOWRzqvTYj4a+UfeNyDFPy6m8Spe+cnS8jfkI7OeW0ARNQ8SKGVIkSH+7lp8Qx3+tcUBCuZjZQQFjJHS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244817; c=relaxed/simple;
	bh=N/dGWdelfzW1jn7M+zLDe+HuQdFpqVd7x9gArCb5Jvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hbGsWCQKSiFsIUwZxrjdhPIghitQNQExh8kMlXbVMnetr9zqQx/se1n32JjAtKwqSfkZ8M1WZOCoTYQ3+0JliMSVWxgz0qDGFGFSUAXYWWKqyUoVKUNtaNfi12ACuoXT8U305o1DFWGI3UqqqKqtcCNfwFp8tiH6LAzQFodqMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p16OlQEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB45C4CEC0;
	Fri, 13 Sep 2024 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726244816;
	bh=N/dGWdelfzW1jn7M+zLDe+HuQdFpqVd7x9gArCb5Jvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p16OlQEpr5SAw2jRw6O1xDg5YWbgxPDunmMZ0Sn3z1WK70qMRUtRnSYItwlFquMz3
	 yy4fHiskNpy9vZ9R1OjKG5XM0WxfZrYDWZKb0/As8aq94zr9scbWbt4bcAzJIjgR88
	 Rpbj1q+5++m00rAm0WVpOv4NyToZ4Zs9gpW7nXXy1aFahtHGMLJMOb9K4DhJodJ44o
	 Ymz5cLXQGYn455KbAHQXACFdINjTucrcbGxpjP5qo4i31T6pcHJLE7KUsZhVJvVybl
	 9F9bT9d/Q9e61kw/fi3+lyZzn7S7xg7lmIfws5NMXaF0gXVof2qb/XTgtciVCdizFe
	 7v8BBeLtvAgVA==
Date: Fri, 13 Sep 2024 11:26:54 -0500
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
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20240913162654.GA713813@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-refactor-blk-affinity-helpers-v1-1-8e058f77af12@suse.de>

On Fri, Sep 13, 2024 at 09:41:59AM +0200, Daniel Wagner wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two
> function share code which only differs on how the affinity information
> is retrieved. Also there is the hisi_sas which open codes the same loop.
> 
> Thus introduce a new helper function for creating these mappings which
> takes an callback function for fetching the affinity mask. Also
> introduce common helper function for PCI and virtio devices to retrieve
> affinity masks.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e3a49f66982d..84f9c16b813b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6370,6 +6370,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BLK_MQ_PCI
> +/**
> + * pci_get_blk_mq_affinity - get affinity mask queue mapping for PCI device
> + * @dev_data:	Pointer to struct pci_dev.
> + * @offset:	Offset to use for the pci irq vector
> + * @queue:	Queue index
> + *
> + * This function returns for a queue the affinity mask for a PCI device.
> + * It is usually used as callback for blk_mq_hctx_map_queues().
> + */
> +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
> +					      int queue)
> +{
> +	struct pci_dev *pdev = dev_data;
> +
> +	return pci_irq_get_affinity(pdev, offset + queue);
> +}
> +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
> +#endif

IMO this doesn't really fit well in drivers/pci since it doesn't add
any PCI-specific knowledge or require any PCI core internals, and the
parameters are blk-specific.  I don't object to the code, but it seems
like it could go somewhere in block/?

Bjorn

