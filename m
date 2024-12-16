Return-Path: <linux-pci+bounces-18526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C119F3630
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500CA164C4A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FFF204F92;
	Mon, 16 Dec 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEW+Y9+s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD984A3E
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366948; cv=none; b=KSE1D4BxanQTW5bhobG5oX63OI/m5MeebP8Q38puDEaLonGtXOlo52oLdJ0SbbjWyB+/ALgszT0IaFp612xPbay0egfQtKDPyncjgOmRl5nu+Hu5mA9dCjUSw9jzfKCUFVL9euainm+00nzoj/0Y4zK6+ArGdFcCYmplfuLEKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366948; c=relaxed/simple;
	bh=3iPcEokKl82QATys2srvtgnVQ5QzbIcdVKpEDugtwig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbwKEXpGQePxai1eVe805dgeWtoPKoWCyos0Z+ndRVnb5ZrXIdBq2LMrx0ABr3BkTGO7WULgj7Itz2b4FBhDXy7WgiJWfrD8VENQZyjlzMr+4NmpW+8CI1VbaZR+DmK9TbbuHxDRdUimFAkSspm3mXvGIXcaWgC76miKIHXbWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEW+Y9+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1ACC4CED0;
	Mon, 16 Dec 2024 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366948;
	bh=3iPcEokKl82QATys2srvtgnVQ5QzbIcdVKpEDugtwig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEW+Y9+sQ5098kCykYnXiLOe2KDPYltyUC0lwNaCTjZN5DVDEkdz0kwpD9Jz7lOXK
	 7ChbYBvtZ5ihCZnl5W1bGI5EAdi87AbxVLQ576FWnHdGKGCIVmA63uLmdJm3laYXpM
	 oNkiXxSv8BTKtUKkUKcKPJfx/LoQ4fjjL0n8AQiB/XK3Odj4o/isMZJhQP7eq5fl9i
	 T9nm7jQDuEDaygqccErIx0sg6sDOQJ8b+zDPuxHmdXwSuCcSw/UboMVgyCrAfikUZB
	 UPJrccNonuV7AH+V6BCGZsmFDghCt5NpIa39eC6pNF0gEpwncs2RceIqISRpz9ssmB
	 xgGSmSjObj05w==
Date: Mon, 16 Dec 2024 22:05:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2BW4CjdE1p50AhC@vaman>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1xoAj9c9oWhqZoV@ryzen>

Hi Niklas,

On 13-12-24, 17:59, Niklas Cassel wrote:
> Hello Vinod,
> 
> I am a bit confused about the usage of the dmaengine API, and I hope that you
> could help make me slightly less confused :)

Sure thing!

> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> 
> I really wish that we would remove this mutex, to get better performance.
> 
> 
> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> that dmaengine_prep_slave_single() (which will call
> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> dma_async_tx_descriptor for each function call.
> 
> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> the descriptor to the tail of a list.
> 
> I can also see that dw_edma_done_interrupt() will automatically start the
> transfer of the next descriptor (using vchan_next_desc()).
> 
> So this looks like it is supposed to be asynchronous... however, if we simply
> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> an incorrect address.
> 
> It looks like this is because dmaengine_prep_slave_single() really requires
> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> in the sconf that we are supplying to dmaengine_slave_config().)
> 
> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> 
> So while this API is supposed to be async, to me it looks like it can only
> be used in a synchronous manner... But that seems like a really weird design.
> 
> Am I missing something obvious here?

Yes, I feel nvme being treated as slave transfer, which it might not be.
This API was designed for peripherals like i2c/spi etc where we have a
hardware address to read/write to. So the dma_slave_config would pass on
the transfer details for the peripheral like address, width of fifo,
depth etc and these are setup config, so call once for a channel and then
prepare the descriptor, submit... and repeat of prepare and submit ...

I suspect since you are passing an address which keep changing in the
dma_slave_config, you need to guard that and prep_slave_single() call,
as while preparing the descriptor driver would lookup what was setup for
the configuration.

I suggest then use the prep_memcpy() API instead and pass on source and
destination, no need to lock the calls...

> If the dmaengine_prep_slave_single() instead took a sconfig as a parameter,
> then it seems like it would be possible to use this API asynchronously.
> 
> There does seem to be other drivers holding a mutex around
> dmaengine_slave_config() + dmaengine_prep_slave_single()... but it feels like
> this should be avoidable (at least for dw-edma), if
> dmaengine_prep_slave_single() simply took an sconf.
> 
> What am I missing? :)
> 
> 
> Kind regards,
> Niklas
> 
> 
> On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:
> > +static int nvmet_pciep_epf_dma_transfer(struct nvmet_pciep_epf *nvme_epf,
> > +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> > +{
> > +	struct pci_epf *epf = nvme_epf->epf;
> > +	struct dma_async_tx_descriptor *desc;
> > +	struct dma_slave_config sconf = {};
> > +	struct device *dev = &epf->dev;
> > +	struct device *dma_dev;
> > +	struct dma_chan *chan;
> > +	dma_cookie_t cookie;
> > +	dma_addr_t dma_addr;
> > +	struct mutex *lock;
> > +	int ret;
> > +
> > +	switch (dir) {
> > +	case DMA_FROM_DEVICE:
> > +		lock = &nvme_epf->dma_rx_lock;
> > +		chan = nvme_epf->dma_rx_chan;
> > +		sconf.direction = DMA_DEV_TO_MEM;
> > +		sconf.src_addr = seg->pci_addr;
> > +		break;
> > +	case DMA_TO_DEVICE:
> > +		lock = &nvme_epf->dma_tx_lock;
> > +		chan = nvme_epf->dma_tx_chan;
> > +		sconf.direction = DMA_MEM_TO_DEV;
> > +		sconf.dst_addr = seg->pci_addr;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(lock);
> > +
> > +	dma_dev = dmaengine_get_dma_device(chan);
> > +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> > +	ret = dma_mapping_error(dma_dev, dma_addr);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	ret = dmaengine_slave_config(chan, &sconf);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to configure DMA channel\n");
> > +		goto unmap;
> > +	}
> > +
> > +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> > +					   sconf.direction, DMA_CTRL_ACK);
> > +	if (!desc) {
> > +		dev_err(dev, "Failed to prepare DMA\n");
> > +		ret = -EIO;
> > +		goto unmap;
> > +	}
> > +
> > +	cookie = dmaengine_submit(desc);
> > +	ret = dma_submit_error(cookie);
> > +	if (ret) {
> > +		dev_err(dev, "DMA submit failed %d\n", ret);
> > +		goto unmap;
> > +	}
> > +
> > +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
> > +		dev_err(dev, "DMA transfer failed\n");
> > +		ret = -EIO;
> > +	}
> > +
> > +	dmaengine_terminate_sync(chan);
> > +
> > +unmap:
> > +	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> > +
> > +unlock:
> > +	mutex_unlock(lock);
> > +
> > +	return ret;
> > +}

-- 
~Vinod

