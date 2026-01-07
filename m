Return-Path: <linux-pci+bounces-44196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B59CFED29
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 17:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB8B31F82E2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835034B69C;
	Wed,  7 Jan 2026 14:39:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037F32E12E;
	Wed,  7 Jan 2026 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796788; cv=none; b=lKtox7fwqjzMCzOFOlJUM4C5l8UojPnU5RTYfsiE0xjqM2iwLx2B9cSbXPz/X6S0K88HtkWfNbr+Xz8pNFfBU8hgYUVUEycxmGE3h11d7URt0srIi+k+H2mlV2hoMxY8NxyAD9dzWsi/B+hZ7Hr8FroJd1LNrhXDvf7Yuozj4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796788; c=relaxed/simple;
	bh=BEHBqANA3TiZcSe7i/Viy3swpuIYk+yhZAhGbYUn4DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCavmD87+2vkdK1DuGEjCUmGhRJMB/BLCKMLxcCNEh0tWmzyeiLVNh8nhy4wdhxX51oyMFI8B3M/WlSpJw8wWdFIueK2POyQcITarIu62+bxXpDTkuXCoe3wvjxRbANitA4DglrZLSUs0O8tF9tSoHe0RQuiBCZulcfZfvYnAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 36C0A227A87; Wed,  7 Jan 2026 15:39:42 +0100 (CET)
Date: Wed, 7 Jan 2026 15:39:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
Message-ID: <20260107143942.GB14904@lst.de>
References: <20251220040446.274991-1-houtao@huaweicloud.com> <20251220040446.274991-3-houtao@huaweicloud.com> <4a91cfe7-75f5-49a4-89a4-fd6717e7e9d2@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a91cfe7-75f5-49a4-89a4-fd6717e7e9d2@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 22, 2025 at 09:50:18AM -0700, Logan Gunthorpe wrote:
> > Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> Thanks for the fix
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Can we get these fixes queued up ASAP while discussing the new
feature?


