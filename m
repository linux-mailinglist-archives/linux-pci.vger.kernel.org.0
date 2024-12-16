Return-Path: <linux-pci+bounces-18563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413439F3981
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 20:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1617188C3BA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC3207A25;
	Mon, 16 Dec 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG4DWPdX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8F206F2D
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376330; cv=none; b=Oi5UbiaWif0bzmlfipF1NOfjza/yLFs4s0I8qraO1JsgUGr1fOU0aosv3+Pfr3mM+dSUgfy07AI7rn308Ya9D1+5ngpbGk2bLI1axjII7HrW9xY4rUvnSXh7HFZzAW/9hQtzZ5KkbGfhoMdzN7bjlPpWXMlR+MflgNg6f8Wh15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376330; c=relaxed/simple;
	bh=CRPNOBDFPXTDmLQ7rQq8Yr9i6kXX7bwuxyIFMN6UNDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fT3woJEMUhXhIYb22E4RuRt6263W3GDm2aCY0Z0iUUm3Kyvj5yM3vm2gcRF+AlyoX7qP7PZgce/Bjau3Q3wqFeth8MuCfBbAJsbxOrMBo5bPfnBvmO7CBa2W9LfXmh/rQjv5wzYgJN6eZKDd/7zXr35PHiMhKgOadZ/fsdrZmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG4DWPdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193A2C4CED0;
	Mon, 16 Dec 2024 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734376329;
	bh=CRPNOBDFPXTDmLQ7rQq8Yr9i6kXX7bwuxyIFMN6UNDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gG4DWPdXt6xxx39D5Fqty82LhGJJBP1+6OW4q8HR2s15ad93XA4gNA9IBH7sDtt5E
	 DBPDVTQlk6VCUmz5+Ra5GoFfsrrWNpaAVOsYxh42ddaHY3i02LXHKWrPzjb9TKoafH
	 E+uC/7aVt1AVo1MXyrlKDKhCu50FBFWinCyTIwWQwkYY14IwmLB18EGEzD+B9ytm57
	 dCyVYvCLgfrCPJTmKo4W/QP+nwW+exqdL/CJMYAZO/19HZFKV7XwQzFtasaS5QUdKb
	 Bro0CTX/M3XZLdkgSYVAU16nHErZ01ACLFlSJFV6Y0HmnfrTR9iQ60cCXAPEj0STZM
	 zGIL++6kM1SKg==
Message-ID: <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
Date: Mon, 16 Dec 2024 11:12:08 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
To: Vinod Koul <vkoul@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org> <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z2BW4CjdE1p50AhC@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 8:35, Vinod Koul wrote:
> Hi Niklas,
> 
> On 13-12-24, 17:59, Niklas Cassel wrote:
>> Hello Vinod,
>>
>> I am a bit confused about the usage of the dmaengine API, and I hope that you
>> could help make me slightly less confused :)
> 
> Sure thing!
> 
>> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
>> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
>> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
>>
>> I really wish that we would remove this mutex, to get better performance.
>>
>>
>> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
>> that dmaengine_prep_slave_single() (which will call
>> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
>> dma_async_tx_descriptor for each function call.
>>
>> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
>> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
>> the descriptor to the tail of a list.
>>
>> I can also see that dw_edma_done_interrupt() will automatically start the
>> transfer of the next descriptor (using vchan_next_desc()).
>>
>> So this looks like it is supposed to be asynchronous... however, if we simply
>> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
>> an incorrect address.
>>
>> It looks like this is because dmaengine_prep_slave_single() really requires
>> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
>> in the sconf that we are supplying to dmaengine_slave_config().)
>>
>> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
>>
>> So while this API is supposed to be async, to me it looks like it can only
>> be used in a synchronous manner... But that seems like a really weird design.
>>
>> Am I missing something obvious here?
> 
> Yes, I feel nvme being treated as slave transfer, which it might not be.
> This API was designed for peripherals like i2c/spi etc where we have a
> hardware address to read/write to. So the dma_slave_config would pass on
> the transfer details for the peripheral like address, width of fifo,
> depth etc and these are setup config, so call once for a channel and then
> prepare the descriptor, submit... and repeat of prepare and submit ...
> 
> I suspect since you are passing an address which keep changing in the
> dma_slave_config, you need to guard that and prep_slave_single() call,
> as while preparing the descriptor driver would lookup what was setup for
> the configuration.
> 
> I suggest then use the prep_memcpy() API instead and pass on source and
> destination, no need to lock the calls...

Vinod,

Thank you for the information. However, I think we can use this only if the DMA
controller driver implements the device_prep_dma_memcpy operation, no ?
In our case, the DWC EDMA driver does not seem to implement this.


-- 
Damien Le Moal
Western Digital Research

