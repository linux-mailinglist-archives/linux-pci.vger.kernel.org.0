Return-Path: <linux-pci+bounces-18577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7EB9F4376
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 07:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778DD7A3938
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E78BF8;
	Tue, 17 Dec 2024 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AG9xFyfU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549E1514F6
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416512; cv=none; b=QxMXdPqAIkX9jIwxxG4v9uWwpsl/6ahcrrAU++g81O+36NEeb72j7awM6GXyWfmHeDJRoHcZ9OBZUwbU4cnADR30yx9HCkWbCIT5AO+oQEF8SqxgLny7TSk1FHP2s6pUSOeNApR0uCKu/J9UuFyAQA6xgrLqg44c3MK4sgqKWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416512; c=relaxed/simple;
	bh=2KYvHhz9BpMWbu4Yic69ixVDVJ+sVk7qxE3oR3ZhSHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3V7MrOq8eyNLXFFbBPcSVgixlXxpd09RgD0XQZJdeiTulFIqqAC6AYp1e1uC9EBuVq46IV6cZ/rROjF2e4swC2hD/KtVAwmPCROOXxSPl5zkS+CzGmdtR+OAI33ULU9ed/3p7hzWcG27+VjUaUIPvtXfUOPadqjpbqEd9HXL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AG9xFyfU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728ec840a8aso5198108b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734416510; x=1735021310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTMt2S+urkIYn87qIOII4tAmscWY+RXwAsYODxpHnCQ=;
        b=AG9xFyfU/aLl7HUCiGKPxXW5qa416w3yoSNc0EzZAKoB7FL5PkhNjngALgoFiqbSCY
         h35012ljChKp/P9+5TKBNvOnwkvN0CtGyvx3jVHq8Dt09k4mr/W9OXXE4aSzBagdyq5S
         cgG5/szKEM/plOaBj4jL1dctQY1u4nbC7jlSjkCyTF+3WOFdKSnsUlZK5YhqDL/Cp+R6
         JtGATPjQ56PKdpRoiPG3UEzN8tC2BB/GQQoU6etGStj5MnfHvhQm8jtkg6Llh6kj5crg
         6UonkeEYxbD7P05UNkKJd2v+SnTbvL8kh8kJn9ReRRzhSSnZQcvynSb9wwioBwTlWmUt
         i+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734416510; x=1735021310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTMt2S+urkIYn87qIOII4tAmscWY+RXwAsYODxpHnCQ=;
        b=o3ypsJ4iRBfn0hFYgI3+Kt72kRjKnJEujMhLauTgONs4oSmpsYXZliMoHSYKfGrICg
         JYeMnQeuXeUg/XP2w77i7S8/IX4r3AxQXaspgtUf7Bo7rplkBamxkchclP4/dIOvKAKW
         lYTH97p0ixb4Hn790XhF9zNfuCzbm6DY1lecJPqxQrgpZrpqQm4mdfRCy6+J8vc9BY13
         MoW4Ie4wDKXHYhWsSfq0OT+47rxPsjens+SFmfVQ/5DwYgNzT2xGsO0P5uWN4wX/abSQ
         F1LclBdizAJaTUqbHlXOLpYw+8aqB964TMGYwBk884cwdoJHOajMDLMM5/EeRroGHoBH
         ZzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3MzsyaIMR1kYBvV8MaqQ6Y0BYXTlbWgvuFERVvycdFEfqlPj4jmVpvoH2wk4XALh6yaJaNLCHIg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcV4yiOplt4yv+ZmrepYyxoJIly1tHf1ztwk3ih6fJXxUhusV8
	Fato7XjHGfCBh+AbuTOcvl0nWVK5BBNwyVQCOitl/rWqNfcBAnHOp/28NPb0wQ==
X-Gm-Gg: ASbGncvkyZT5UbCPWmzOrRsNezPDyERH3RDy1cEluMzfgW4wpB5yF0lyeSP29OcXAPl
	ht6rKOCcO1MiOTk2R4alg4qTYieb6mkf00JcAjYdS1HhkujB6qRGBqcY2Bbgf/48zizoakPcHMB
	awu0Xl8uuCWk7aXQr6g8SyinAaGHZGd7SSkLnmhFg8zUIuDga6QuHXqClNwIcLvOJkrcWlgiaG1
	Re+my0JNAO491+AM9fVmoHo7YqAaNE6/AS9qvozCE+K+cf1tU4wGFEtu1v/VS27fpEf
X-Google-Smtp-Source: AGHT+IHDN73kVjagfpHFEE7paMuJrna3XYZyYUYZnGRRnyEXV5MnD/5cAwnRlJHCCAF2jpNTULiJrQ==
X-Received: by 2002:a05:6a00:2341:b0:728:e1e3:3d88 with SMTP id d2e1a72fcca58-7290c15d7bfmr19910862b3a.7.1734416510163;
        Mon, 16 Dec 2024 22:21:50 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918af1040sm5835770b3a.83.2024.12.16.22.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:21:49 -0800 (PST)
Date: Tue, 17 Dec 2024 11:51:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241217062144.g7jjnkziuen3qsm6@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2ELpuC+ltp5wDay@vaman>

On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> On 16-12-24, 11:12, Damien Le Moal wrote:
> > On 2024/12/16 8:35, Vinod Koul wrote:
> > > Hi Niklas,
> > > 
> > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > >> Hello Vinod,
> > >>
> > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > >> could help make me slightly less confused :)
> > > 
> > > Sure thing!
> > > 
> > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > >>
> > >> I really wish that we would remove this mutex, to get better performance.
> > >>
> > >>
> > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > >> that dmaengine_prep_slave_single() (which will call
> > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > >> dma_async_tx_descriptor for each function call.
> > >>
> > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > >> the descriptor to the tail of a list.
> > >>
> > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > >> transfer of the next descriptor (using vchan_next_desc()).
> > >>
> > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > >> an incorrect address.
> > >>
> > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > >>
> > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > >>
> > >> So while this API is supposed to be async, to me it looks like it can only
> > >> be used in a synchronous manner... But that seems like a really weird design.
> > >>
> > >> Am I missing something obvious here?
> > > 
> > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > This API was designed for peripherals like i2c/spi etc where we have a
> > > hardware address to read/write to. So the dma_slave_config would pass on
> > > the transfer details for the peripheral like address, width of fifo,
> > > depth etc and these are setup config, so call once for a channel and then
> > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > 
> > > I suspect since you are passing an address which keep changing in the
> > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > as while preparing the descriptor driver would lookup what was setup for
> > > the configuration.
> > > 
> > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > destination, no need to lock the calls...
> > 
> > Vinod,
> > 
> > Thank you for the information. However, I think we can use this only if the DMA
> > controller driver implements the device_prep_dma_memcpy operation, no ?
> > In our case, the DWC EDMA driver does not seem to implement this.
> 
> It should be added in that case.
> 
> Before that, the bigger question is, should nvme be slave transfer or
> memcpy.. Was driver support the reason why the slave transfer was used here...?
> 
> As i said, slave is for peripherals which have a static fifo to
> send/receive data from, nvme sounds like a memory transfer to me, is
> that a right assumption?
> 

My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
are local addresses. And DMA_SLAVE is for transfer between remote and local
addresses. I haven't looked into the NVMe EPF driver yet, but it should do
the transfer between remote and local addresses. This is similar to MHI EPF
driver as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

