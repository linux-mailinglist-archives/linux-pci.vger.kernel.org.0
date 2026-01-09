Return-Path: <linux-pci+bounces-44368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 264FAD0AC7F
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C2913017002
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA1314D1F;
	Fri,  9 Jan 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE4DXA4M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAF312816;
	Fri,  9 Jan 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971024; cv=none; b=cs4FOxRuddHF4zpPDU86GMxlBVgLYUG4svmabvNj2AxmpHXWwZ2B+fC/eQQhiL4B3JmPghKpQKQ+UD6HDsw9iavNn0rbBis07XZobOOBkVchDw3vxYlEGoxqtrEeBzjHPQ6VsSrtawOHRAM482BiFE4CwuLByitWmz6Fk8XHDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971024; c=relaxed/simple;
	bh=WAuchXVNbi1E8wL1YCiS1onMwk8fVlA590vyUaYKxYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JhL1PnzFmMtI5wSHK+foZDDI4jvuHNRQQjJbnsdY4wvaH+639FYyxK3nuorB3T1h6CebC1ec3eQJnCuUB25yJlwrSS0UsS5L7fRL77/+HY2l7/4J5RMJTFjFp/XB0+hvNbur8bVPI8sGzsSwKNFVChNdKKIhmN1/hKc2iBWa3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE4DXA4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD764C4CEF1;
	Fri,  9 Jan 2026 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767971024;
	bh=WAuchXVNbi1E8wL1YCiS1onMwk8fVlA590vyUaYKxYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SE4DXA4MOciW8xfdJXBrN01CZqLwFW5mbrXNqOB717rS3DPhir3IKMAYUPUlfNCNG
	 oSrp086ZYAXSL92LzUrIGHD4hAMVrqHne4K/V4honA0Sdc4MqOJ8m/SnSRKVmJ0nGi
	 yGsgXO5bbNoYRyAMxPGH75OGylwqPrB+zIruHZWk3i7kqFtCvAPPS+qiHfd/83dKyO
	 2bHw1C4FufwAKVvlPtucN+I0YXw1NbI79//5/k6RUspiS6PykxjoXoOCJpJXiC1s8e
	 7hOlLlnIwjuXvIvuSS1dFMQOPoSDlmkrIkQ3PQlSDmp5lxci8og+C55Pk+FojGBUfa
	 zkKk4VDitU6fw==
Date: Fri, 9 Jan 2026 09:03:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
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
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
Message-ID: <20260109150342.GA544448@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vrti6maahtwfrd6xrdmyupunprioodhl7x5alpi2r6kyi4qcyr@ga6a5yrdvmb2>

On Fri, Jan 09, 2026 at 11:41:51AM +1100, Alistair Popple wrote:
> On 2026-01-09 at 02:55 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> > On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> > > On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > > > From: Hou Tao <houtao1@huawei.com>
> > > > 
> > > > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > > > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > > > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > > > forever when trying to remove the PCIe device.
> > > > 
> > > > Fix it by adding the missed percpu_ref_put().
> ...

> > Looking at this again, I'm confused about why in the normal, non-error
> > case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
> > percpu_ref_get(ref) for each page, followed by just a single
> > percpu_ref_put() at the exit.
> > 
> > So we do ref_get() "1 + number of pages" times but we only do a single
> > ref_put().  Is there a loop of ref_put() for each page elsewhere?
> 
> Right, the per-page ref_put() happens when the page is freed (ie. the struct
> page refcount drops to zero) - in this case free_zone_device_folio() will call
> p2pdma_folio_free() which has the corresponding percpu_ref_put().

I don't see anything that looks like a loop to call ref_put() for each
page in free_zone_device_folio() or in p2pdma_folio_free(), but this
is all completely out of my range, so I'll take your word for it :)  

Bjorn

