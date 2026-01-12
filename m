Return-Path: <linux-pci+bounces-44536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B44D1454B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 18:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F1230C2B79
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63603376BD5;
	Mon, 12 Jan 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXE+tFKS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831517B505;
	Mon, 12 Jan 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237998; cv=none; b=dZjtvWnhhpQ2ST7zrntXxjOSZ3QLU60UkBskDYJ8deYgiLhIOQUi4UyvPrVoAlb5oUADWuWqWPAk99j9mKMlmirTPtU23XEpSC9mWnc5Re1ojSuYaX/rXGoMDQBERcYqRs/YxBTW4zDcY9RMt4qLVwU410PBGgdkAL9AH0qZYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237998; c=relaxed/simple;
	bh=CTVrya0benCYisxRFikm+e5pStHqutlTbypDz019q6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tmp1NBDmxsf621NKuNuZfjjdi2zMg6mqR/Jt48t37X6Z37o4/C6LyAMrhoabIgh+fa+ouO6iuB7yyK9e2du70AWelFcY1/E/0XnI4lABBfUBRiid1FBMmHqnXg6kSLDDaDbSygdejihi9ULT2ZyByLSkT8kv1O1Kd5kgJV+Dsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXE+tFKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144AEC116D0;
	Mon, 12 Jan 2026 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237998;
	bh=CTVrya0benCYisxRFikm+e5pStHqutlTbypDz019q6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SXE+tFKSoL3IJzOL0ppAEPq1Yj7631M2XmO7QzgW1/gIIiFmnoWqfAPWfTBwwxbSM
	 bFp4XbZ9Tun1GbQSuiXmnO35eBQSDD8H1/1xu2uShPTnb8U6Lycln70OJTzwHJ5xb7
	 ZBZqpqy8ntCxqZUB5OrIBKYu0IqEdpxaOMPdTtfWHURIEP8JV0S/nIbkaCiEFVKl11
	 QQzyPFqigdgxEm9DJ/AOJpDmi9cwsGOvdW73h5Oe4dIpZBs6H3kgbxo9tEr957uUHV
	 vb+sz7up2888w2Wal0vkGLAhq3oTi2Lqy9fy8cq6vHZbiAhBq4bMaFzoTvqa+fJOkx
	 7eI9Byrbykzwg==
Date: Mon, 12 Jan 2026 11:13:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: houtao@huaweicloud.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, bhelgaas@google.com,
	logang@deltatee.com, leonro@nvidia.com, gregkh@linuxfoundation.org,
	tj@kernel.org, rafael@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
Subject: Re: [PATCH] PCI/P2PDMA: Reset page reference count when page mapping
 fails
Message-ID: <20260112171316.GA716207@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112005440.998543-1-apopple@nvidia.com>

On Mon, Jan 12, 2026 at 11:54:40AM +1100, Alistair Popple wrote:
> When mapping a p2pdma page the page reference count is initialised to
> 1 prior to calling vm_insert_page(). This is to avoid vm_insert_page()
> warning if the page refcount is zero. Prior to setting the page count
> there is a check to ensure the page is currently free (ie. has a zero
> reference count).
> 
> However vm_insert_page() can fail. In this case the pages are freed
> back to the genalloc pool, but that does not reset the page refcount.
> So a future allocation of the same page will see the elevated page
> refcount from the previous set_page_count() call triggering the
> VM_WARN_ON_ONCE_PAGE checking that the page is free.
> 
> Fix this by resetting the page refcount back to zero using
> set_page_count(). Note that put_page() is not used because that
> would result in freeing the page twice due to implicitly calling
> p2pdma_folio_free().
> 
> Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Applied to pci/p2pdma for v6.20, thanks!

> ---
> 
> This was found by inspection. I don't currently have a good setup that
> exercises the p2pmem_alloc_mmap() path so this has only been compile
> tested - additional testing would be appreciated.
> ---
>  drivers/pci/p2pdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index dd64ec830fdd..3b29246b9e86 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -152,6 +152,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		ret = vm_insert_page(vma, vaddr, page);
>  		if (ret) {
>  			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> +
> +			/*
> +			 * Reset the page count. We don't use put_page() because
> +			 * we don't want to trigger the p2pdma_folio_free() path.
> +			 */
> +			set_page_count(page, 0);
>  			percpu_ref_put(ref);
>  			return ret;
>  		}
> -- 
> 2.51.0
> 

