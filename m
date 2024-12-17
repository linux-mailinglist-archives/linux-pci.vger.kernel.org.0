Return-Path: <linux-pci+bounces-18650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC37D9F5096
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD2916479D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7841FC0F1;
	Tue, 17 Dec 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHzmDWaM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE11FBEA4
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451196; cv=none; b=Y/DWWyG2w4NxvRrxdJDAf6YBDITaLLV6Iu/FZI5scH6958/JoGgYqGHI1lAVgOHIYrlLVTAiAcAZo1H2lBaSeKUPJIKKiBywjsVFJdi2zvCjAMI3GR3eVDI8iXIsc3/eHUeNxDyKihy3f61q4FunWHzJ5HHVOShYBp69WL80Dis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451196; c=relaxed/simple;
	bh=nUX3IOEY4L2Iqp2QUUWu5H20jVTxoMFhA3GkwcXLnhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAGPItvpAH2/OMJ22nxNbsFA0+r3xWt/Q69208XjNOTzv1CVDQ/PYsJiXjYo4FIEBcIcJMSnmu+4eSaKfzwTTFQ/tiOjlX3AqZ2qfOhUZ2HdZvxga5l3cGnFQSXcEzl8QAZvLL0gKXNuRAVOslj3CfzTY13YfFeQyIybds+m+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHzmDWaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82389C4CED3;
	Tue, 17 Dec 2024 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451196;
	bh=nUX3IOEY4L2Iqp2QUUWu5H20jVTxoMFhA3GkwcXLnhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHzmDWaM2j/ZV9zsCUxKZLD6mjf0yTBhZWcYb80Lue8StkqOjHZYpyABFXE0Vxvck
	 AgCYHlzQB6XheRvb4ihjf7JYc4o3atvFmfGut2n/9SgAO5Mmheo+8RoUkMqYJuNs/F
	 WwN2GC1QPW0KkXP1jA+UvnQeK638/vHZlzWJvlSRVvhaW4ZrrgIhzIjSw2ITVKCF4P
	 Uvc1OaKJp71bl6z/t/S7FljJTTOxF/eiDxki+wIWZ4t5yBNBoFrK02GUQE8/4EXugD
	 Yr+Odgoj8bklqWJu6BS9L47P0ZyfACSe781efgERbFDA+GTV74Q/IK/N2xQKKHSjEZ
	 VebpBwAUngNPg==
Date: Tue, 17 Dec 2024 16:59:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2Gf9lv6hLROjM8e@ryzen>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
 <20241217062144.g7jjnkziuen3qsm6@thinkpad>
 <20241217090129.6dodrgi4tn7l3cod@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217090129.6dodrgi4tn7l3cod@thinkpad>

On Tue, Dec 17, 2024 at 02:31:29PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 17, 2024 at 11:51:44AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> > > On 16-12-24, 11:12, Damien Le Moal wrote:
> > > > On 2024/12/16 8:35, Vinod Koul wrote:
> > > > > Hi Niklas,
> > > > > 
> > > > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > > > >> Hello Vinod,
> > > > >>
> > > > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > > > >> could help make me slightly less confused :)
> > > > > 
> > > > > Sure thing!
> > > > > 
> > > > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > > > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > > > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > > > >>
> > > > >> I really wish that we would remove this mutex, to get better performance.
> > > > >>
> > > > >>
> > > > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > > > >> that dmaengine_prep_slave_single() (which will call
> > > > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > > > >> dma_async_tx_descriptor for each function call.
> > > > >>
> > > > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > > > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > > > >> the descriptor to the tail of a list.
> > > > >>
> > > > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > > > >> transfer of the next descriptor (using vchan_next_desc()).
> > > > >>
> > > > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > > > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > > > >> an incorrect address.
> > > > >>
> > > > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > > > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > > > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > > > >>
> > > > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > > > >>
> > > > >> So while this API is supposed to be async, to me it looks like it can only
> > > > >> be used in a synchronous manner... But that seems like a really weird design.
> > > > >>
> > > > >> Am I missing something obvious here?
> > > > > 
> > > > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > > > This API was designed for peripherals like i2c/spi etc where we have a
> > > > > hardware address to read/write to. So the dma_slave_config would pass on
> > > > > the transfer details for the peripheral like address, width of fifo,
> > > > > depth etc and these are setup config, so call once for a channel and then
> > > > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > > > 
> > > > > I suspect since you are passing an address which keep changing in the
> > > > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > > > as while preparing the descriptor driver would lookup what was setup for
> > > > > the configuration.
> > > > > 
> > > > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > > > destination, no need to lock the calls...
> > > > 
> > > > Vinod,
> > > > 
> > > > Thank you for the information. However, I think we can use this only if the DMA
> > > > controller driver implements the device_prep_dma_memcpy operation, no ?
> > > > In our case, the DWC EDMA driver does not seem to implement this.
> > > 
> > > It should be added in that case.
> > > 
> > > Before that, the bigger question is, should nvme be slave transfer or
> > > memcpy.. Was driver support the reason why the slave transfer was used here...?
> > > 
> > > As i said, slave is for peripherals which have a static fifo to
> > > send/receive data from, nvme sounds like a memory transfer to me, is
> > > that a right assumption?
> > > 
> > 
> > My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
> > are local addresses. And DMA_SLAVE is for transfer between remote and local
> > addresses. I haven't looked into the NVMe EPF driver yet, but it should do
> > the transfer between remote and local addresses. This is similar to MHI EPF
> > driver as well.
> > 
> 
> I had an offline discussion with Vinod and he clarified that the DMA_SLAVE
> implementation is supposed to be used by clients with fixed FIFO. That's why
> 'struct dma_slave_config' has options to configure maxburst, addr_width,
> port_window_size etc... So these are not applicable for our usecase where we
> would be just carrying out transfer between remote and local DDR.
> 
> So we should be implementing prep_memcpy() in dw-edma driver and use DMA_MEMCPY
> in client drivers.
> 
> @Niklas: Since you asked this question, are you volunteering to implement
> prep_memcpy() in dw-edma driver? ;)

I did implement something that seems to be working.

It would be nice if you could help testing it using your MHI EPF driver.
(You need to convert it to use _prep_memcpy() in order to be able to test.)


Kind regards,
Niklas

