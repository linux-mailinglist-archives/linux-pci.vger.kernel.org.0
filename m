Return-Path: <linux-pci+bounces-43485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC01CD3FF3
	for <lists+linux-pci@lfdr.de>; Sun, 21 Dec 2025 13:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DF8F3000B7D
	for <lists+linux-pci@lfdr.de>; Sun, 21 Dec 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57C1F95C;
	Sun, 21 Dec 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkR4deFJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A66125D0;
	Sun, 21 Dec 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766319560; cv=none; b=lb1KUopxhxkwVt8CKLFFnnHXr71PL0y+12BdYEyqW0QSwdD4rJ0FVF0ZXixDlpK/mKzhzMnYwuXNX6rM2urHJlYJM1nLvkEgdcEPDbOmPwv64H2fu5H+3sWrYTHa1LFXDgQw+wSuub9pvNn2PZYU5gnwR133tUtI/JgV32pDREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766319560; c=relaxed/simple;
	bh=ZeOPwShHRhwYUB1pry9WKHZ3vg3L8IaUwEYKG8XWhQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc7yPEvbW4C5X52GZPPCdHo70300u/Ghi8etjFmGzHWlg6pAdtirDpTq7efHWopEj8WeCaKLi2cxnRR/C4vhNmhLXrPuw2OUYx/2UTmvHucqjax4q7ktFoRJDfxNB6z78UEawWTwA0ckNYk63Ypx+Cl1E0l+HcRKuFv2E1ASVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkR4deFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6261BC4CEFB;
	Sun, 21 Dec 2025 12:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766319560;
	bh=ZeOPwShHRhwYUB1pry9WKHZ3vg3L8IaUwEYKG8XWhQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkR4deFJRzYHolHakfbtdIDJtIK9Yk8DEnj/EqcYYdZgFW2I1C4gWIMRhYEV5SKlb
	 zNNLh8pdxlqTYU8eLvtzQuykfloKYp1KfpB9SWgR6ATsaOlCXkSzolIV4RqxuYbkNu
	 Qezx9UnTHfcahw/4ucIhdrMlFMdPbBrRUTgqw4qP7l6X2MRvlprvOu6D1F35hO3i7I
	 gvWhoZ0/htR6bJx7t+Iwr4AoPRZlXmIRhv7uSUibBOmkzDZB8FmpHXChxqlNfMx3DS
	 8SoqCN11kEmL2lhLaJZPKGoubgNsGbJu+CBNrzIOwiRaqNY0G3olfpPtH8xPiYE17/
	 SD8VhXCcxIn8Q==
Date: Sun, 21 Dec 2025 14:19:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alistair Popple <apopple@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 00/13] Enable compound page for p2pdma memory
Message-ID: <20251221121915.GJ13030@unreal>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251220040446.274991-1-houtao@huaweicloud.com>

On Sat, Dec 20, 2025 at 12:04:33PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> device-dax has already supported compound page. It not only reduces the
> cost of struct page significantly, it also improve the performance of
> get_user_pages when 2MB or 1GB page size is used. We are experimenting
> to use p2p dma to directly transfer the content of NVMe SSD into NPU.

I’ll admit my understanding here is limited, and lately everything tends  
to look like a DMABUF problem to me. Could you explain why DMABUF support 
is not being used for this use case?

Thanks

> The size of NPU HBM is 32GB or larger and there are at most 8 NPUs in
> the host. When using the base page, the memory overhead is about 4GB for
> 128GB HBM, and the mapping of 32GB HBM into userspace takes about 0.8
> second. Considering ZONE_DEVICE memory type has already supported the
> compound page, enabling the compound page support for p2pdma memory as
> well. After applying the patch set, when using the 1GB page, the memory
> overhead is about 2MB and the mmap costs about 0.04 ms.
> 
> The main difference between the compound page support of device-dax and
> p2pdma is that p2pdma inserts the page into user vma during mmap instead
> of page fault. The main reason is simplicity. The patch set is
> structured as shown below:
> 
> Patch #1~#2: tiny bug fixes for p2pdma
> Patch #3~#5: add callbacks support in kernfs and sysfs, include
> pagesize, may_split and get_unmapped_area. These callbacks are necessary
> for the support of compound page when mmaping sysfs binary file.
> Patch #6~#7: create compound page for p2pdma memory in the kernel. 
> Patch #8~#10: support the mapping of compound page in userspace. 
> Patch #11~#12: support the compound page for NVMe CMB.
> Patch #13: enable the support for compound page for p2pdma memory.
> 
> Please see individual patches for more details. Comments and
> suggestions are always welcome.
> 
> Hou Tao (13):
>   PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page()
>     fails
>   PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()
>   kernfs: add support for get_unmapped_area callback
>   kernfs: add support for may_split and pagesize callbacks
>   sysfs: support get_unmapped_area callback for binary file
>   PCI/P2PDMA: add align parameter for pci_p2pdma_add_resource()
>   PCI/P2PDMA: create compound page for aligned p2pdma memory
>   mm/huge_memory: add helpers to insert huge page during mmap
>   PCI/P2PDMA: support get_unmapped_area to return aligned vaddr
>   PCI/P2PDMA: support compound page in p2pmem_alloc_mmap()
>   PCI/P2PDMA: add helper pci_p2pdma_max_pagemap_align()
>   nvme-pci: introduce cmb_devmap_align module parameter
>   PCI/P2PDMA: enable compound page support for p2pdma memory
> 
>  drivers/accel/habanalabs/common/hldio.c |   3 +-
>  drivers/nvme/host/pci.c                 |  10 +-
>  drivers/pci/p2pdma.c                    | 140 ++++++++++++++++++++++--
>  fs/kernfs/file.c                        |  79 +++++++++++++
>  fs/sysfs/file.c                         |  15 +++
>  include/linux/huge_mm.h                 |   4 +
>  include/linux/kernfs.h                  |   3 +
>  include/linux/pci-p2pdma.h              |  30 ++++-
>  include/linux/sysfs.h                   |   4 +
>  mm/huge_memory.c                        |  66 +++++++++++
>  10 files changed, 339 insertions(+), 15 deletions(-)
> 
> -- 
> 2.29.2
> 
> 

