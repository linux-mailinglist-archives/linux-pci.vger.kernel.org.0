Return-Path: <linux-pci+bounces-44231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A389D0004D
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1A733004E39
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE223EA85;
	Wed,  7 Jan 2026 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkagjpi/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6931DBB3A;
	Wed,  7 Jan 2026 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818081; cv=none; b=kiAqpvTtWLOMGEXW/+jU0lcs150dEgJLKVdPA1sXKfRBMYOdDX3LausT5hHKFYejs8uZ2MjPIUrPZH+3lnmbZNNtQsblHGav4qRCYycMUvu0QWWJeaBSIwCliMVp43ebQJyJ/EDavu7FvsvxtzicLdZIrtpZid/9y6/A+e4HjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818081; c=relaxed/simple;
	bh=AOWaSug2G86K93bzxMiGRrg2OWHdAUJfYh0qmRde9cw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mEGkHZSG1ixfGyhP625tD1jDZrPB4879TLtKmT/Yb4D75XbUc7hRHXTsUxUwhdOF3Hs4TUlaWNpLmTrNn1dNZTmwOtD/BNA+cWcyED1o9RYJjmhuiYZDAf9Iwy/DGLRuC08W8liTqEAUtOwA7W5tM1EM82vuIXYtBHpszryt+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zkagjpi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76CFC4CEF1;
	Wed,  7 Jan 2026 20:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818080;
	bh=AOWaSug2G86K93bzxMiGRrg2OWHdAUJfYh0qmRde9cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zkagjpi/muS2VGzfUQjIxWGGH6i70N++9x5xZTIbkQuBU/DRrQKhH+4pJNASzSy7j
	 VZVMqRapNWwBVu4ByYANDdpu5Sr1knnVuTrRyvvD9WvCdJEJGw7K64bSO0hKmfhQqY
	 OThU+sNzp56YiPAIE2t6FI8X1MJjVuPhzRzGd7emskjfYVBBhV532eSF+mtSAlV4PM
	 /Bk4PfbiIBZ6xke04u2/c0EbrakDa/8EflVBSSO3zKX1nL5AtFS09ovFmx7BrgOCgU
	 tmdVAzw0ELBLL1dewvzFHL5enSxqyAR/O6JMjvEonF6tFvrO5qIZ2ZFH4+K24yXrjT
	 cQqiR/XDuYSbQ==
Date: Wed, 7 Jan 2026 14:34:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, Hou Tao <houtao@huaweicloud.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
Message-ID: <20260107203439.GA446340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107171724.GA432074@bhelgaas>

On Wed, Jan 07, 2026 at 11:17:24AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 07, 2026 at 03:39:42PM +0100, Christoph Hellwig wrote:
> > On Mon, Dec 22, 2025 at 09:50:18AM -0700, Logan Gunthorpe wrote:
> > > > Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> > > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > 
> > > Thanks for the fix
> > > 
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > 
> > Can we get these fixes queued up ASAP while discussing the new
> > feature?
> 
> I assume you mean the first two patches:
> 
>   PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page() fails
>   PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()
> 
> I can certainly queue these up.  The second is a warning fix, and the
> first fixes a hang that has apparently been around since v6.2
> (7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through
> sysfs")).
> 
> Given that, I would ordinarily target the v6.20 merge window, but the
> "ASAP" suggests more urgency.  Do you want one or both for v6.19?

I put the patches above on pci/p2pdma for v6.20 until I hear
otherwise.

Bjorn

