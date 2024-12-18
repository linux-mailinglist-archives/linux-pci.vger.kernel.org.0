Return-Path: <linux-pci+bounces-18723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD09F6D76
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 19:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BC5169AC8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB93597C;
	Wed, 18 Dec 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AX5KbBE7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484B14B06A
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547047; cv=none; b=ElHn9sQvoDgX2L6qqSZ78r0Num07+uMAGxSdXbqFp7DaTjMl8/L4RZOZhIkZO3TOY/QuLoDX3MPx9SDgczqkZHcHeNyWYQTp39ln8DaUIV5e1Xw7Xgzi0NbRnWTQC00C0d65ENQUcQff9IgrLStMAa8EqL9/ldPQN1tuw1Qtc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547047; c=relaxed/simple;
	bh=TdFQrfVZn/Hl12e/0BaLCTgl87j+tB/Q5++BjUCsGeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaG7b2eZSUkUty3ENBdwWfZruSv9VPhjhpCA41S7BwSG6zmbNfaA2KV0rFUuqC4qNzRjQ4+QTt6XA0hlvaSoo4ZqFoXvhbOnRPOiPbqkPV1ohl93sdVwCGPi0E2zuTp9hpohDWqbOGowzFGjPRdVjis9PKa3Z+S2U502YcWG3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AX5KbBE7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7265c18d79bso1908b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 10:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734547045; x=1735151845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Cg1zgsuxjgBjaw/sW0olfwRhMkQl1rQNt1Q6tfvwjE=;
        b=AX5KbBE7U1cBtcYl3sCP9Uae7cplh9YeXLNmbSz4pZiKvEo+d+AcvraRFrFI/sE4gn
         ihOU/mEtLvuM7v1ICsjjoMbo4R8C8j5G6FxncrnUqguDuJW7/R4IaD6YCueluclJml++
         7Eec4FGKrC2U8Yqd/GbNVlHESsrJUh+PMtRMRn32nUUd52Ku7CGoNpmzv+0VCpsVecv4
         KePE11WLqPxBKKTRr5gFBl4Uxf1dZgWGLp2fvVwocg0zlureBLr7HifMI1TWMUy3aWKS
         ujKsDa98GB917VGCXFpkD2Rigo90TsZadvNsTKBaeVKlRjtNNAEn8YxHxkdzGzEyxP/g
         9Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547045; x=1735151845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cg1zgsuxjgBjaw/sW0olfwRhMkQl1rQNt1Q6tfvwjE=;
        b=seB4/Df3EWsNGodJCR8B0BBRFgbqECqzUpSS2evH6I16f1DlDIEmCr33xCBA54UesZ
         YmLGJYkwuy7oC+SYoDT13vJEn8ukFT6o75dKNW94kqkyAgXw45IccMalXS9yWQIcl68C
         yjOFMyFVoBCNCsHbE0CfG3QtsUPH7QOr22wxBqxknj0Xxv83hdg6j+4F+Sj6nInSlU8u
         LhEY8Lm5LAYZ/fr8ZeBwcbdF7cxrJKsnz/NSALgEi2REiGzSdq3fhiXs/UKYnIsJ1GTo
         Z0z485juOkJi5KGH8gru3hlX01Fc7RN3T1HDZ+072eYS5DN6A47qd4PfkkOj+XZ615nf
         a9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtmSLomQtYP9aDb/29sDUKLfrfYhcpLd6TBBYDz1JR2VlyKu9g2QAuL680gRrL7MeBS9hQIf61mDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLA0eyxIthdlzo9MvsHSkNYpLR3GcyS0njgGZOltPtx6JHQz8
	BXndwLYsUDbgIlebJPEzf32enS/MX6i6YnVC+UszA05WTq6zTgQWHxFTAH+EOg==
X-Gm-Gg: ASbGncv7TgGhMGqYlbrPjetUFwZ7BkYgXgiAvSdHvkNmXFgtysGeaLo62RQBNTfKp7M
	xYw7bpb44X/Fq5FTjoEeXGOkGO4iTxeksdYWj9HiWSeaF03Eg2MSJKBYxhTZ4FtZ20Tw3If5Wvy
	B2zdzF8HXVM7VXaAZI49emEq4DJli7dcGpJhhBic0uGBIVfOsILv4dOh3ytA6iijUnCu8fe+E0Z
	LMwx98zVTWwNjrRdcuAqGOAYqZ2YkN9+rBQa1xCIuNwky6kjc9f7x+U+ZClf+hl4Czw
X-Google-Smtp-Source: AGHT+IGEK6/dK1naAm83SqXg1kfGUqMxn3XUnbRqdCz+y153a8bvEV+YxxmTbEC8bJadRQNfsU/W8g==
X-Received: by 2002:a05:6a21:394a:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1e5b47fe155mr7211113637.12.1734547044958;
        Wed, 18 Dec 2024 10:37:24 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3ded0sm7822826a12.83.2024.12.18.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:37:24 -0800 (PST)
Date: Thu, 19 Dec 2024 00:07:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
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
Message-ID: <20241218183717.3kxevwjia4mqc6ov@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
 <20241217062144.g7jjnkziuen3qsm6@thinkpad>
 <20241217090129.6dodrgi4tn7l3cod@thinkpad>
 <Z2Gf9lv6hLROjM8e@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2Gf9lv6hLROjM8e@ryzen>

On Tue, Dec 17, 2024 at 04:59:50PM +0100, Niklas Cassel wrote:
> On Tue, Dec 17, 2024 at 02:31:29PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Dec 17, 2024 at 11:51:44AM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> > > > On 16-12-24, 11:12, Damien Le Moal wrote:
> > > > > On 2024/12/16 8:35, Vinod Koul wrote:
> > > > > > Hi Niklas,
> > > > > > 
> > > > > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > > > > >> Hello Vinod,
> > > > > >>
> > > > > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > > > > >> could help make me slightly less confused :)
> > > > > > 
> > > > > > Sure thing!
> > > > > > 
> > > > > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > > > > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > > > > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > > > > >>
> > > > > >> I really wish that we would remove this mutex, to get better performance.
> > > > > >>
> > > > > >>
> > > > > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > > > > >> that dmaengine_prep_slave_single() (which will call
> > > > > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > > > > >> dma_async_tx_descriptor for each function call.
> > > > > >>
> > > > > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > > > > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > > > > >> the descriptor to the tail of a list.
> > > > > >>
> > > > > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > > > > >> transfer of the next descriptor (using vchan_next_desc()).
> > > > > >>
> > > > > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > > > > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > > > > >> an incorrect address.
> > > > > >>
> > > > > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > > > > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > > > > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > > > > >>
> > > > > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > > > > >>
> > > > > >> So while this API is supposed to be async, to me it looks like it can only
> > > > > >> be used in a synchronous manner... But that seems like a really weird design.
> > > > > >>
> > > > > >> Am I missing something obvious here?
> > > > > > 
> > > > > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > > > > This API was designed for peripherals like i2c/spi etc where we have a
> > > > > > hardware address to read/write to. So the dma_slave_config would pass on
> > > > > > the transfer details for the peripheral like address, width of fifo,
> > > > > > depth etc and these are setup config, so call once for a channel and then
> > > > > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > > > > 
> > > > > > I suspect since you are passing an address which keep changing in the
> > > > > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > > > > as while preparing the descriptor driver would lookup what was setup for
> > > > > > the configuration.
> > > > > > 
> > > > > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > > > > destination, no need to lock the calls...
> > > > > 
> > > > > Vinod,
> > > > > 
> > > > > Thank you for the information. However, I think we can use this only if the DMA
> > > > > controller driver implements the device_prep_dma_memcpy operation, no ?
> > > > > In our case, the DWC EDMA driver does not seem to implement this.
> > > > 
> > > > It should be added in that case.
> > > > 
> > > > Before that, the bigger question is, should nvme be slave transfer or
> > > > memcpy.. Was driver support the reason why the slave transfer was used here...?
> > > > 
> > > > As i said, slave is for peripherals which have a static fifo to
> > > > send/receive data from, nvme sounds like a memory transfer to me, is
> > > > that a right assumption?
> > > > 
> > > 
> > > My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
> > > are local addresses. And DMA_SLAVE is for transfer between remote and local
> > > addresses. I haven't looked into the NVMe EPF driver yet, but it should do
> > > the transfer between remote and local addresses. This is similar to MHI EPF
> > > driver as well.
> > > 
> > 
> > I had an offline discussion with Vinod and he clarified that the DMA_SLAVE
> > implementation is supposed to be used by clients with fixed FIFO. That's why
> > 'struct dma_slave_config' has options to configure maxburst, addr_width,
> > port_window_size etc... So these are not applicable for our usecase where we
> > would be just carrying out transfer between remote and local DDR.
> > 
> > So we should be implementing prep_memcpy() in dw-edma driver and use DMA_MEMCPY
> > in client drivers.
> > 
> > @Niklas: Since you asked this question, are you volunteering to implement
> > prep_memcpy() in dw-edma driver? ;)
> 
> I did implement something that seems to be working.
> 
> It would be nice if you could help testing it using your MHI EPF driver.
> (You need to convert it to use _prep_memcpy() in order to be able to test.)
> 

Sure, will do it tomorrow and let you know. Thanks for sending the patches
quickly :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

