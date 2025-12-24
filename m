Return-Path: <linux-pci+bounces-43654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60615CDBC78
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD66C3008CFF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84599257848;
	Wed, 24 Dec 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCkI51xV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB0194A76;
	Wed, 24 Dec 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568168; cv=none; b=ZJ8sV7PCZg91Zio41nuiHo1SBCs0IVpaBbgsGzU8VYEVYlEFLVzvdsmOmWSjgsLS98rfT+2FoknbXFNJnGo6TjgkhILcBGW4x24wlox6HlJtU9pZOau2swrYx9wsKS0wz+uZZtqaNM+ZEXHTPXBqguVVGB1qEFSkD8uBEZPDSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568168; c=relaxed/simple;
	bh=9OEO/JCs0BjLukCm//EkrDbgU9VMrzlMsA88lCY5hGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgKMS5E75P0Xxdrp8PfHE6TYOxBRUVjQBKVNvRny4q5la9Tinj9t8/ZtWd3nVmbIMYtFoRyR0JTwN6tJhgnM6wciVvYtCMgaSZRZCT0YT6pOGO1sMrlbmPnCCGgHHKCG2vhGa8bzohlXuK/qEjUCmwZahSBkY5uSSxP5Mz8lgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCkI51xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A6EC4CEFB;
	Wed, 24 Dec 2025 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766568167;
	bh=9OEO/JCs0BjLukCm//EkrDbgU9VMrzlMsA88lCY5hGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCkI51xVQCyd338Mh8k6YDydutGxW9LmK1CZQTQOp9ZNqX6dJ8MesvyXVBlPUP5rd
	 UiAtC+tgEIeqZCTuAG9axT7FHxvnsXz1iPbuLahLRMXMSGzdxvZFuTmF8WQ7V5R5/S
	 tNBBHQ50i61ChoLK+Gm43OowSe75BX05sloy512mIvMTWtRS0mpc/i44AmziYybD21
	 U4MC8Hl+0ZCGiGDxAm+HKsa8sWadq6NKd5D3W7Rsk3iyLfdXAvgJYzo0mA9Z5OWIbK
	 kTTmdzZ/q0bg1IuxI41xhsaQwdjS845Op6Jh/ai49K58EEjfjfay4UD62j5jtnkLwE
	 tVgdauP5tojoQ==
Date: Wed, 24 Dec 2025 11:22:43 +0200
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
Message-ID: <20251224092243.GG11869@unreal>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251221121915.GJ13030@unreal>
 <416b2575-f5e7-7faf-9e7c-6e9df170bf1a@huaweicloud.com>
 <996c64ca-8e97-2143-9227-ce65b89ae35e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <996c64ca-8e97-2143-9227-ce65b89ae35e@huaweicloud.com>

On Wed, Dec 24, 2025 at 09:37:39AM +0800, Hou Tao wrote:
> 
> 
> On 12/24/2025 9:18 AM, Hou Tao wrote:
> > Hi,
> >
> > On 12/21/2025 8:19 PM, Leon Romanovsky wrote:
> >> On Sat, Dec 20, 2025 at 12:04:33PM +0800, Hou Tao wrote:
> >>> From: Hou Tao <houtao1@huawei.com>
> >>>
> >>> Hi,
> >>>
> >>> device-dax has already supported compound page. It not only reduces the
> >>> cost of struct page significantly, it also improve the performance of
> >>> get_user_pages when 2MB or 1GB page size is used. We are experimenting
> >>> to use p2p dma to directly transfer the content of NVMe SSD into NPU.
> >> I’ll admit my understanding here is limited, and lately everything tends  
> >> to look like a DMABUF problem to me. Could you explain why DMABUF support 
> >> is not being used for this use case?
> > I have limited knowledge of dma-buf, so correct me if I am wrong. It
> > seems that as for now there is no available way to use the dma-buf to
> > read/write files. For the userspace vaddr backended by  the dma-buf, it
> > is a PFN mapping, get_user_pages() will reject such address.
> 
> Hit the send button too soon :) So In my understanding, the advantage of
> dma-buf is that it doesn't need struct page.

The primary advantage of dma-buf is that it provides a safe mechanism for
sharing a DMA region between devices or subsystems. This allows reliable
p2p communication between two devices. For example, a GPU and an RDMA NIC
can share a memory region for data transfer.

The ability to operate without a struct page is an important part of this
design.

> and it also means that it needs special handling to support IO
> from/to dma-buf (e.g.,  [RFC v2 00/11] Add dmabuf read/write via io_uring [1])

It looks like that read/write support is needed for IO data transfer,
but you talked about CMB.

I would imagine that NVMe exported CMB through dmabuf and your NPU will
import it without need to do any read/write at all.

Thanks

> 
> [1]
> https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
> >> Thanks
> >>
> >>> The size of NPU HBM is 32GB or larger and there are at most 8 NPUs in
> >>> the host. When using the base page, the memory overhead is about 4GB for
> >>> 128GB HBM, and the mapping of 32GB HBM into userspace takes about 0.8
> >>> second. Considering ZONE_DEVICE memory type has already supported the
> >>> compound page, enabling the compound page support for p2pdma memory as
> >>> well. After applying the patch set, when using the 1GB page, the memory
> >>> overhead is about 2MB and the mmap costs about 0.04 ms.
> >>>
> >>> The main difference between the compound page support of device-dax and
> >>> p2pdma is that p2pdma inserts the page into user vma during mmap instead
> >>> of page fault. The main reason is simplicity. The patch set is
> >>> structured as shown below:
> >>>
> >>> Patch #1~#2: tiny bug fixes for p2pdma
> >>> Patch #3~#5: add callbacks support in kernfs and sysfs, include
> >>> pagesize, may_split and get_unmapped_area. These callbacks are necessary
> >>> for the support of compound page when mmaping sysfs binary file.
> >>> Patch #6~#7: create compound page for p2pdma memory in the kernel. 
> >>> Patch #8~#10: support the mapping of compound page in userspace. 
> >>> Patch #11~#12: support the compound page for NVMe CMB.
> >>> Patch #13: enable the support for compound page for p2pdma memory.
> >>>
> >>> Please see individual patches for more details. Comments and
> >>> suggestions are always welcome.
> >>>
> >>> Hou Tao (13):
> >>>   PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page()
> >>>     fails
> >>>   PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()
> >>>   kernfs: add support for get_unmapped_area callback
> >>>   kernfs: add support for may_split and pagesize callbacks
> >>>   sysfs: support get_unmapped_area callback for binary file
> >>>   PCI/P2PDMA: add align parameter for pci_p2pdma_add_resource()
> >>>   PCI/P2PDMA: create compound page for aligned p2pdma memory
> >>>   mm/huge_memory: add helpers to insert huge page during mmap
> >>>   PCI/P2PDMA: support get_unmapped_area to return aligned vaddr
> >>>   PCI/P2PDMA: support compound page in p2pmem_alloc_mmap()
> >>>   PCI/P2PDMA: add helper pci_p2pdma_max_pagemap_align()
> >>>   nvme-pci: introduce cmb_devmap_align module parameter
> >>>   PCI/P2PDMA: enable compound page support for p2pdma memory
> >>>
> >>>  drivers/accel/habanalabs/common/hldio.c |   3 +-
> >>>  drivers/nvme/host/pci.c                 |  10 +-
> >>>  drivers/pci/p2pdma.c                    | 140 ++++++++++++++++++++++--
> >>>  fs/kernfs/file.c                        |  79 +++++++++++++
> >>>  fs/sysfs/file.c                         |  15 +++
> >>>  include/linux/huge_mm.h                 |   4 +
> >>>  include/linux/kernfs.h                  |   3 +
> >>>  include/linux/pci-p2pdma.h              |  30 ++++-
> >>>  include/linux/sysfs.h                   |   4 +
> >>>  mm/huge_memory.c                        |  66 +++++++++++
> >>>  10 files changed, 339 insertions(+), 15 deletions(-)
> >>>
> >>> -- 
> >>> 2.29.2
> >>>
> >>>
> 
> 

