Return-Path: <linux-pci+bounces-18397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D5A9F1318
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 17:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD78188426C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8F1684AE;
	Fri, 13 Dec 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkp+YNm+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB8632
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109193; cv=none; b=DM6FRO767Vafw7o4A9g9KGvLsWq+VMoq5D7+Z7bLvEEmW2pw4LeQj+dBhCb53s6ObCSVOkItGQ9s2ukgGehm8CjWQKqbx917I9kToXEzAQnieDYtx9gPWNtHkAU2QhEex+BSWqOdRT0qMkAhFTU8kqdgpm0ie6pBJnA2R1bXFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109193; c=relaxed/simple;
	bh=EgRgareuCzSN3yzJcQ10JMjJTrJnUNwakzXNQVNF43I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfYMDEyA7EL9i9LXGebk8EvjaiNlRiiGKftSdJF1WhipeZWkA/zPYWUcX7c7her2haLS6P5kFeROwf4uW5cEqIgXJsLHj2aBMbaFzi9PnkB0PQT7QfBboMKyQFbQj/LRNXM3yg5u5FfbD50nEzNFeJtYlhr48c7M/hZgoQ221Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkp+YNm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E16C4CED0;
	Fri, 13 Dec 2024 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734109192;
	bh=EgRgareuCzSN3yzJcQ10JMjJTrJnUNwakzXNQVNF43I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkp+YNm+kwF8Hd//xHdCKjVA3d9b/puF8XL+KCbeDSp+jy6VcPaCCvlLU7WyeTlC+
	 RuiCnZcqZ+onoL4+wgTvJFwSn/1hEIkk89gP8Ls1RZP/gsUQVLBI7eemhRf+fwoXkA
	 3lvU1E/j4d/TULv8+VySY9b8+6ofNM2826F5Rwzj1YIdVSR/HqSduA2fTDdM/SS2aB
	 oqYzJ0Wq8YyBYdDs5yq4sq+2vT7o3l9MsA8y9Mb6stWd+T3f/8ccjVDTRlvFgl9Mwf
	 zLibm5w19vJ4J8Z7kewHQDELn17E7vI+P+4yhuX/5v29WrjEfrZFCWZs4VYCRPMpb2
	 lmlH9l205pFPA==
Date: Fri, 13 Dec 2024 17:59:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
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
Message-ID: <Z1xoAj9c9oWhqZoV@ryzen>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-18-dlemoal@kernel.org>

Hello Vinod,

I am a bit confused about the usage of the dmaengine API, and I hope that you
could help make me slightly less confused :)

If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.

I really wish that we would remove this mutex, to get better performance.


If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
that dmaengine_prep_slave_single() (which will call
device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
dma_async_tx_descriptor for each function call.

I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
the descriptor to the tail of a list.

I can also see that dw_edma_done_interrupt() will automatically start the
transfer of the next descriptor (using vchan_next_desc()).

So this looks like it is supposed to be asynchronous... however, if we simply
remove the mutex, we get IOMMU errors, most likely because the DMA writes to
an incorrect address.

It looks like this is because dmaengine_prep_slave_single() really requires
dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
in the sconf that we are supplying to dmaengine_slave_config().)

(i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)

So while this API is supposed to be async, to me it looks like it can only
be used in a synchronous manner... But that seems like a really weird design.

Am I missing something obvious here?


If the dmaengine_prep_slave_single() instead took a sconfig as a parameter,
then it seems like it would be possible to use this API asynchronously.

There does seem to be other drivers holding a mutex around
dmaengine_slave_config() + dmaengine_prep_slave_single()... but it feels like
this should be avoidable (at least for dw-edma), if
dmaengine_prep_slave_single() simply took an sconf.

What am I missing? :)


Kind regards,
Niklas


On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:
> +static int nvmet_pciep_epf_dma_transfer(struct nvmet_pciep_epf *nvme_epf,
> +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> +{
> +	struct pci_epf *epf = nvme_epf->epf;
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config sconf = {};
> +	struct device *dev = &epf->dev;
> +	struct device *dma_dev;
> +	struct dma_chan *chan;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_addr;
> +	struct mutex *lock;
> +	int ret;
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +		lock = &nvme_epf->dma_rx_lock;
> +		chan = nvme_epf->dma_rx_chan;
> +		sconf.direction = DMA_DEV_TO_MEM;
> +		sconf.src_addr = seg->pci_addr;
> +		break;
> +	case DMA_TO_DEVICE:
> +		lock = &nvme_epf->dma_tx_lock;
> +		chan = nvme_epf->dma_tx_chan;
> +		sconf.direction = DMA_MEM_TO_DEV;
> +		sconf.dst_addr = seg->pci_addr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(lock);
> +
> +	dma_dev = dmaengine_get_dma_device(chan);
> +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> +	ret = dma_mapping_error(dma_dev, dma_addr);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = dmaengine_slave_config(chan, &sconf);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure DMA channel\n");
> +		goto unmap;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> +					   sconf.direction, DMA_CTRL_ACK);
> +	if (!desc) {
> +		dev_err(dev, "Failed to prepare DMA\n");
> +		ret = -EIO;
> +		goto unmap;
> +	}
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(dev, "DMA submit failed %d\n", ret);
> +		goto unmap;
> +	}
> +
> +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
> +		dev_err(dev, "DMA transfer failed\n");
> +		ret = -EIO;
> +	}
> +
> +	dmaengine_terminate_sync(chan);
> +
> +unmap:
> +	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> +
> +unlock:
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}

