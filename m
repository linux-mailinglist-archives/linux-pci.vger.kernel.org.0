Return-Path: <linux-pci+bounces-18585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BA9F46C0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9378D1889307
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB81805B;
	Tue, 17 Dec 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWffO+Us"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC981DC745
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426098; cv=none; b=uibo6nuu2DtHQWtKgs0Y72fGdPFaf2VK2OsFMoJvFb9DchS8yVcUV48mBl5Oc/Ia3fxwQ5rvIQc9/OHRiddnFSRP2t6gG3m7iO04tyiDxjsfrVi3urtRbrFA51ZR0JsJV3pHVzkOO0YH3czPqalUwaRm0ddHfm5wIOdS8y65muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426098; c=relaxed/simple;
	bh=grdcYjSa5h53d5M1PwJ8S2ZAr/nhiUkP0klvLW1PgbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buz1/fj8PRgTns8GI72KKOE9ZFaGkAPp4WGjLx+qVduUvL54g1ltO994zhjts90MEMV3E+fcAy+9a0dtayW3WfvWelDWFs8Zn/KjFbXbWQIEE7GbB1SrKUgxASnrz49ZPtkgxNtHZih4cCddpk1VVBe2HP/sIuadhURlMcE12qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWffO+Us; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so3645456a12.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734426096; x=1735030896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d6acbz+sYik7awbI0rOlFvmPprgMME8EdhtYEszk268=;
        b=CWffO+Usgv2t0jzKRVTqicR3QiGpB+mpPi2S0HgY/cmG8v3P48zhCizEhRPk9zAzFm
         zLC5NFIZVYoGsLs68HRSVtWPpCPSNCEOlJBKnMW2YGt3nVpSIxlBFz5vl86SEBTJuqU7
         bAsJUoLRZDv3Ijzxf2AvtA4y8U6H+eKx5esE7pbFxBmWEeNmBxODZfiZsBskMFAR+iC9
         vsBTBZFIfd3hYh/7YUvJXetiZp4Gdyw2eTFodNZhqpcNJBLSNoo5uNAMk64ThUSlb0+t
         0MIE+k3SoOV0DAYjVRp9DHmWFrSRGSFEDjBcxjAmDSbJwVB5inq0PuNV/t9P0RhFg0jp
         jYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426096; x=1735030896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6acbz+sYik7awbI0rOlFvmPprgMME8EdhtYEszk268=;
        b=kJ/KWb6zfNGPwczCg+C6gWK5K3PhvPn7MdgaPwwMJHvK6eqMPYE21kDpLNzmHDQcmw
         I50nA9oemcTmFqvE1q1Awfwo+nfsWqTZQiu5Ia4paH+BrHLUfltDCNfme43qQN9tNk7w
         xlh8OziK3KnKUPyeGY5K8chGNMiYSV1rXmmh1gQrJ8WZDnvIluEMirHxYG2YEFPDgW7l
         mNzNpBvhQttMPPY41i1hHfMOPhM9DyfUcEYM5z05gUx4lngtTVivBks+l/yeHLnmrxWx
         EpwYljXLXYec3nuw3hC9a4lR+Dv0VvFdV9SM/23pq6LIG0MRae1f5wyGzSwR+AxZ10W8
         y4lg==
X-Forwarded-Encrypted: i=1; AJvYcCVznvfxyZNYwBknOSgRdM84EyXeO90AVV3By4qp3Ip2rXlYq4SuAvsumTAteoWC7g+WfFFG6lgQbkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaB4jYrRy3N1jyFBeMEDVj42S/81DPWoZ2irkuxXCqZVFV67p
	9hcdOI/7gXYb927yNc9P0qsjfICMegx9F48LWgs0G20G/4YuPg4/Bu+2vY0Jyg==
X-Gm-Gg: ASbGncvnBumpDv58Gc7FD4K+vqzl4+kB+m402f9a60Pq61gvrh9PUF5Y/13xNNU47w4
	Lx3NXkMmvvXyamDiQw7vMuxQLE3ofl/WEnXAZVRkb1tMQR0c6tQ/84RO9k0J8h3TCiBgBZL6I7+
	HZVjavjvh4n8C3rlB1NhddPg81N9R5vo8HrRi8Eue+PDhqG/rXs8N4+0i6fEUeUIpvpduhuQeB0
	yb3w/Ub2MfVXY90iz6L4VESyH6WvmVldImZES/D6v2wqNiBOdvIG3cihRpPlDS0JeJd
X-Google-Smtp-Source: AGHT+IErZlHdFPBSG0pEQN7o8tLqL6wo5ZhyFFqcvV3YUSnBr/tQiyUamgeW4V2OWCLXqq//eYe8bg==
X-Received: by 2002:a17:90b:4d05:b0:2ee:b26c:1099 with SMTP id 98e67ed59e1d1-2f2902ae9damr19245070a91.34.1734426096276;
        Tue, 17 Dec 2024 01:01:36 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1e6dsm9426193a91.39.2024.12.17.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:01:35 -0800 (PST)
Date: Tue, 17 Dec 2024 14:31:29 +0530
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
Message-ID: <20241217090129.6dodrgi4tn7l3cod@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
 <20241217062144.g7jjnkziuen3qsm6@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217062144.g7jjnkziuen3qsm6@thinkpad>

On Tue, Dec 17, 2024 at 11:51:44AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> > On 16-12-24, 11:12, Damien Le Moal wrote:
> > > On 2024/12/16 8:35, Vinod Koul wrote:
> > > > Hi Niklas,
> > > > 
> > > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > > >> Hello Vinod,
> > > >>
> > > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > > >> could help make me slightly less confused :)
> > > > 
> > > > Sure thing!
> > > > 
> > > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > > >>
> > > >> I really wish that we would remove this mutex, to get better performance.
> > > >>
> > > >>
> > > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > > >> that dmaengine_prep_slave_single() (which will call
> > > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > > >> dma_async_tx_descriptor for each function call.
> > > >>
> > > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > > >> the descriptor to the tail of a list.
> > > >>
> > > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > > >> transfer of the next descriptor (using vchan_next_desc()).
> > > >>
> > > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > > >> an incorrect address.
> > > >>
> > > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > > >>
> > > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > > >>
> > > >> So while this API is supposed to be async, to me it looks like it can only
> > > >> be used in a synchronous manner... But that seems like a really weird design.
> > > >>
> > > >> Am I missing something obvious here?
> > > > 
> > > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > > This API was designed for peripherals like i2c/spi etc where we have a
> > > > hardware address to read/write to. So the dma_slave_config would pass on
> > > > the transfer details for the peripheral like address, width of fifo,
> > > > depth etc and these are setup config, so call once for a channel and then
> > > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > > 
> > > > I suspect since you are passing an address which keep changing in the
> > > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > > as while preparing the descriptor driver would lookup what was setup for
> > > > the configuration.
> > > > 
> > > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > > destination, no need to lock the calls...
> > > 
> > > Vinod,
> > > 
> > > Thank you for the information. However, I think we can use this only if the DMA
> > > controller driver implements the device_prep_dma_memcpy operation, no ?
> > > In our case, the DWC EDMA driver does not seem to implement this.
> > 
> > It should be added in that case.
> > 
> > Before that, the bigger question is, should nvme be slave transfer or
> > memcpy.. Was driver support the reason why the slave transfer was used here...?
> > 
> > As i said, slave is for peripherals which have a static fifo to
> > send/receive data from, nvme sounds like a memory transfer to me, is
> > that a right assumption?
> > 
> 
> My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
> are local addresses. And DMA_SLAVE is for transfer between remote and local
> addresses. I haven't looked into the NVMe EPF driver yet, but it should do
> the transfer between remote and local addresses. This is similar to MHI EPF
> driver as well.
> 

I had an offline discussion with Vinod and he clarified that the DMA_SLAVE
implementation is supposed to be used by clients with fixed FIFO. That's why
'struct dma_slave_config' has options to configure maxburst, addr_width,
port_window_size etc... So these are not applicable for our usecase where we
would be just carrying out transfer between remote and local DDR.

So we should be implementing prep_memcpy() in dw-edma driver and use DMA_MEMCPY
in client drivers.

@Niklas: Since you asked this question, are you volunteering to implement
prep_memcpy() in dw-edma driver? ;)

If not, I will work with Qcom to make it happen.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

