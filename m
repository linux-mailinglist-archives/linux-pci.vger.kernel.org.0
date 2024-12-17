Return-Path: <linux-pci+bounces-18576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B29F42BE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 06:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC367164AF5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 05:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34168189B8C;
	Tue, 17 Dec 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh1q6bU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB1154BE0
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734413227; cv=none; b=VNOZWXQUikgj8/0/eYRmsPmiSv6bsxNCIiPOsiQlJ3CGEQolxHPjn5KCZY6OMUKmGtnhaR3mKpB7I4fkHu1F/gdejCstrdBltdKd5ZdipOtio7lcV7GEZmuo78cnRqBIxObuwcsuiu5Iq8yKOVEODgKI3wi8g0BLb1kql4LWtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734413227; c=relaxed/simple;
	bh=hlilBpHDIjEBNGJiFqjKYE8/nd6vUP2wlydRXVbEjoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXhrajx/X2rj3qaSouNR3f2hsUpLkF+CPLPO2kSQE1Fwwjdejr5aaBLAy5PJaDpI+rfulGVucSRyka/kAISc4pFrWpu6fPeviuxd9EWxC9fLoIIl7O0qQn+RzywyseufqXL31LkgYKe/IjRYpnM2DHTGZlSSRj7pz0/rUt191C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh1q6bU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2F4C4CED3;
	Tue, 17 Dec 2024 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734413226;
	bh=hlilBpHDIjEBNGJiFqjKYE8/nd6vUP2wlydRXVbEjoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh1q6bU958wEZV82Rlc3TKh61qiYZzu3Pv2ka649lZpy6DoLoTHOqJ1TXKnUCu66I
	 tjBydLfS43YfYmHQeATbJ5letw7uhV8OMGub/wbPXgzN9InnuGhfQYYXIxlRoogMIq
	 ucTyjlhj5l5E90pWvr9iu4ji/IkAP1Hya9Q8O/iHs3Ck1xqlLZz/qqaTpkzpSVYlUq
	 8pkWyRpNh7DOMIvOR17MwFBwaRQxwW10WYsktpxLb60A6DlISu4vTCfi1IeiY6hC4h
	 SJyGsTTbK+qVvkLNqDXXy5VJDQM2FU/BDrbhbT9s3Cz/DZCr4+kHWxUlcEFhXzq/G1
	 kTZmqZI/J0XPg==
Date: Tue, 17 Dec 2024 10:57:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2ELpuC+ltp5wDay@vaman>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>

On 16-12-24, 11:12, Damien Le Moal wrote:
> On 2024/12/16 8:35, Vinod Koul wrote:
> > Hi Niklas,
> > 
> > On 13-12-24, 17:59, Niklas Cassel wrote:
> >> Hello Vinod,
> >>
> >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> >> could help make me slightly less confused :)
> > 
> > Sure thing!
> > 
> >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> >>
> >> I really wish that we would remove this mutex, to get better performance.
> >>
> >>
> >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> >> that dmaengine_prep_slave_single() (which will call
> >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> >> dma_async_tx_descriptor for each function call.
> >>
> >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> >> the descriptor to the tail of a list.
> >>
> >> I can also see that dw_edma_done_interrupt() will automatically start the
> >> transfer of the next descriptor (using vchan_next_desc()).
> >>
> >> So this looks like it is supposed to be asynchronous... however, if we simply
> >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> >> an incorrect address.
> >>
> >> It looks like this is because dmaengine_prep_slave_single() really requires
> >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> >> in the sconf that we are supplying to dmaengine_slave_config().)
> >>
> >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> >>
> >> So while this API is supposed to be async, to me it looks like it can only
> >> be used in a synchronous manner... But that seems like a really weird design.
> >>
> >> Am I missing something obvious here?
> > 
> > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > This API was designed for peripherals like i2c/spi etc where we have a
> > hardware address to read/write to. So the dma_slave_config would pass on
> > the transfer details for the peripheral like address, width of fifo,
> > depth etc and these are setup config, so call once for a channel and then
> > prepare the descriptor, submit... and repeat of prepare and submit ...
> > 
> > I suspect since you are passing an address which keep changing in the
> > dma_slave_config, you need to guard that and prep_slave_single() call,
> > as while preparing the descriptor driver would lookup what was setup for
> > the configuration.
> > 
> > I suggest then use the prep_memcpy() API instead and pass on source and
> > destination, no need to lock the calls...
> 
> Vinod,
> 
> Thank you for the information. However, I think we can use this only if the DMA
> controller driver implements the device_prep_dma_memcpy operation, no ?
> In our case, the DWC EDMA driver does not seem to implement this.

It should be added in that case.

Before that, the bigger question is, should nvme be slave transfer or
memcpy.. Was driver support the reason why the slave transfer was used here...?

As i said, slave is for peripherals which have a static fifo to
send/receive data from, nvme sounds like a memory transfer to me, is
that a right assumption?

-- 
~Vinod

