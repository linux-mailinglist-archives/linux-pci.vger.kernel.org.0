Return-Path: <linux-pci+bounces-44285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49506D04297
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 17:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CFEF32F7663
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433EC26C39E;
	Thu,  8 Jan 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smTz0YN5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D725392A;
	Thu,  8 Jan 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887761; cv=none; b=tmNUqrFklyVUljeYvXsZaXrRljk91VTD/eTM0sgwR/TRlXgDNvdtL/09FOGjvwUMKlnZZqURyhGqnzynZBJY4D4NiO4FDVGTf68DWHLDQF7jvF7vSR+6Clc7G76JxGwkeSdjb0FQ3oEMMHBW56MdTk8YNz3wQM7k+Nub+NrLfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887761; c=relaxed/simple;
	bh=GfulWa/ARu4Yr8rPC67SODwYIn35P8iw0erhJXUkXcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TuGAEhc6PWxYJMtDB3r+kUBvNRzvoMA5BQ4QHdGm9Oy/Vu4QW9BsUDfe2tRVoxvP9eOohnSvvZj3uEWnOirpjBjQPMZ+FS3V+qsPp700kBwp+6uj9IE4kh0UiMfite71jA/YKmo/2469i7lC0BAnfyKWVmL5XHCM+pTfK+DzGDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smTz0YN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD6C116C6;
	Thu,  8 Jan 2026 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887760;
	bh=GfulWa/ARu4Yr8rPC67SODwYIn35P8iw0erhJXUkXcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=smTz0YN5YLFmAlOwB/XE8lSG6WmMP9wwqSDofdB02oq65EsOYfnBlUklxTr+EgvDK
	 D8lBV6Neawx+hCoXcQ6EgI+F4Vv4Zrwc9mjuyRoN2D9iz15mp/8X/xXkIDpluV8Z1+
	 2w9Aq1d0cFAIHm7EvNx2GH1ulX6+5eXLtIUGYofhwcoOT947MRxroquuxMdN+9IewD
	 W929EV3dvo4vDZAvAU27sNCWOs2xaEra2+bel24JzUK8CDMgc77ZvAVp3//FojQ+v7
	 kOs71Vya+liqOAZf8HJg6nkTyKyr+a/U1QkBeLh3lRWlYEt1McXz1ecpnZeMxewfMx
	 W9fCRcqMSwgog==
Date: Thu, 8 Jan 2026 09:55:58 -0600
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
Message-ID: <20260108155558.GA482755@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46lz5szq44vz3chzj6unh2sff4cfnpyvih7zty6fcnitzyrulu@6a2xdopoafxt>

On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > From: Hou Tao <houtao1@huawei.com>
> > 
> > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > forever when trying to remove the PCIe device.
> > 
> > Fix it by adding the missed percpu_ref_put().
> 
> This pairs with the percpu_ref_tryget_live_rcu() above right? Might
> be worth mentioning that as a comment, but overall looks good to me
> so feel free to add:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Added your Reviewed-by, thanks!

Would the following commit log address your suggestion?

  When the vm_insert_page() in p2pmem_alloc_mmap() failed, we did not
  invoke percpu_ref_put() to free the per-CPU pgmap ref acquired by
  percpu_ref_tryget_live_rcu(), which meant that PCI device removal would
  hang forever in memunmap_pages().

  Fix it by adding the missed percpu_ref_put().

Looking at this again, I'm confused about why in the normal, non-error
case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
percpu_ref_get(ref) for each page, followed by just a single
percpu_ref_put() at the exit.

So we do ref_get() "1 + number of pages" times but we only do a single
ref_put().  Is there a loop of ref_put() for each page elsewhere?

> > Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  drivers/pci/p2pdma.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 4a2fc7ab42c3..218c1f5252b6 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -152,6 +152,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
> >  		ret = vm_insert_page(vma, vaddr, page);
> >  		if (ret) {
> >  			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> > +			percpu_ref_put(ref);
> >  			return ret;
> >  		}
> >  		percpu_ref_get(ref);
> > -- 
> > 2.29.2
> > 

