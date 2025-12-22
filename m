Return-Path: <linux-pci+bounces-43537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E870CD6C58
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F901303FA6C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09B34D4DF;
	Mon, 22 Dec 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tRWsY5/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525E322B73;
	Mon, 22 Dec 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423454; cv=none; b=urVT1aBW7Dd5mSqjrdBqHI2RJzONEIKIRBPWxwP9TZMKxKDYfZu2IzsqteoS12oyyxbvfzGqDtDp8H41KUHa784ITc83g0AZ0WZXvyCEz+Fi7gxY8kyjOXoDWt78MwkO9NVCBu5djI/1bJxQS06N/4lXuKRsCj4UEdQoPAtPnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423454; c=relaxed/simple;
	bh=CtfMXTSy2FNpzSai4RzDF+ckY7Na8zZJmkT2MNlAxiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Hb+kSRg0y8pUBnlDxcXe3JGja48X3q4Oqv9elg+yyZcormI8r663pWON+Q8cI+o1OJGN5M7LVbsBk/7YBywFgHZL3GiO0LLNjVmI++6+PLbR/OoBFHfxPxzhh8iVeIhu5Z7cN1zNpsGi15oCon66io/1/C2TZt04wlNosbwKG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=tRWsY5/s; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=rlyvxFeosUCTgS/NckPF7IGlpen8lONAZ5K7J2cadI0=; b=tRWsY5/sJc3LPeDw1XCCSz61w0
	BvWaboyhIaIEstf+FY+Pw3Mrt5ROwsjzprelE/Dbmh9BRCgZcjM9cRhrK2xDiKCWBtQWK5F/lzZkP
	PpNJy8D3qK5jOtsyf83j2b/46tSYE2IZtAb2YXy03L2FOOBYZuZTHLkFQ9P/e3jjabtrTcdFSKFS2
	6tbk1P8d+7aR874dnSz0hvwa3Pr8j0MJ/1UMfgGkU4Hep4RAWOBos1XCBpfcxtIjMFxDzRDQaYobq
	fYyVRqMJCkHhV1tUjPk9oLYItwU/iRUmJ6kI8a7h/oSA1jTsdui5AzoJ6T3PNXSVXYLTCvV3Wt/ZH
	rSeMv9vw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vXjQp-00000008K3A-3QRR;
	Mon, 22 Dec 2025 10:10:52 -0700
Message-ID: <33c4a321-0e5c-4090-be2c-4bfbee603f5a@deltatee.com>
Date: Mon, 22 Dec 2025 10:10:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 houtao1@huawei.com
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-14-houtao@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251220040446.274991-14-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 13/13] PCI/P2PDMA: enable compound page support for p2pdma
 memory
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-12-19 21:04, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Compound page support for P2PDMA memory in both kernel and user space is
> now in place. Enable it by allowing PUD_SIZE and PMD_SIZE alignment.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/pci/p2pdma.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4a133219ac43..969bdacdcf8b 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -452,9 +452,19 @@ static inline int pci_p2pdma_check_pagemap_align(struct pci_dev *pdev, int bar,
>  						 u64 size, size_t align,
>  						 u64 offset)
>  {
> +	if (has_transparent_pud_hugepage() && align == PUD_SIZE)
> +		goto more_check;
> +	if (has_transparent_hugepage() && align == PMD_SIZE)
> +		goto more_check;
>  	if (align == PAGE_SIZE)
>  		return 0;
>  	return -EINVAL;
> +
> +more_check:
> +	if (IS_ALIGNED(pci_resource_start(pdev, bar), align) &&
> +	    IS_ALIGNED(size, align) && IS_ALIGNED(offset, align))
> +		return 0;
> +	return -EINVAL;
>  }

Again this seems strange. It's a bit unlikely to have a large BAR that
wouldn't be well aligned, but this change is now requiring all P2P
memory to be aligned to 1GB if the CPU supports PUDs. So if a particular
device only has a small (say 256MB) imperfectly aligned bar it may now
fail to be registered.

I don't think the alignment should be a property of the device. When a
mapping is created, if everything is aligned appropriately, and there is
enough free aligned P2PDMA memory, then it should map a full PUD page.
There shouldn't be other restrictions placed on the hardware to make
this work.

Logan

