Return-Path: <linux-pci+bounces-44685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42097D1BBB0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 00:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5E5302D383
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 23:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDB36A039;
	Tue, 13 Jan 2026 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="j2r+6Q9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F8350A2F;
	Tue, 13 Jan 2026 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347341; cv=none; b=SUIqSe19IulGA2uR+Nc/OdXAYrHeaU2CM4AZ0m4hiKNcX2VGvMwIiHoYtKUCkr1txHDrjA5CCVra7g4/eMiy3dJqs5ETOufJpnAed1h3T40OOTKH1QPfb1tatDZcWGGT3P8RKhhRnfsD3/XJ2acxMA33nY3O7Gu3z2sFwgyJ4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347341; c=relaxed/simple;
	bh=C5M+S5RpSWvCVy1tLwXnj5PpcpjT6nBC8NSf/675Xmw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=QG91XoBnyKUmKDfgrEKf9eyFe0pq8xE1FOysgpBAu87rREpzIbjzo/MQ238qPjG0OXiDr1LyCDpKKZOEM7Ep4CZz1I7y5+/NsE9bCq9D8JwgMRNuu0QBtIh+9r86LRQTp8+c2mIXszUNBt25uCaiVXzBFbZhyg7d5VShDsXwg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=j2r+6Q9R; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=BSFJmjqkr3SG+Wmzr05iwRwKLgAbLdJHQWRc2GNC65g=; b=j2r+6Q9Rd1jlEMASSc+4qmx7gT
	wAMSprno495z+UF0PvP/iZLFC+KkJsLKKbfNeXHjm9yNdml575qdsEtvTg8L7oIl/2UpblCFvdllL
	oDC8D/H3i7ybC4bucF+qUUiDKin2wW90hxwp5txaulpA4sST+834nRRD0Xv+u+lnXBaOy/c5PFyxE
	9/Eo72mJQSkEJnZ7Ozt5V56yP7w9gAJ4xJe6oJa3an+mbmkx3I7KclYQRqIDXKdXZkbXDpjCo42nB
	rnFCeC+sYuIx1NohJPt69cjom2QdSDVIpJ62dRl1DbSRhqYj/Zg+rGOmNCKMFWHi8SusF7VxhkwI8
	VMe4hlOQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vfnvG-00000000mAR-2Lj7;
	Tue, 13 Jan 2026 16:35:39 -0700
Message-ID: <e2e4cbdd-2abe-4e25-9cf2-746af5ede443@deltatee.com>
Date: Tue, 13 Jan 2026 16:34:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Popple <apopple@nvidia.com>, helgaas@kernel.org
Cc: houtao@huaweicloud.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, bhelgaas@google.com, leonro@nvidia.com,
 gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org,
 dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, houtao1@huawei.com
References: <20260112005440.998543-1-apopple@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260112005440.998543-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: apopple@nvidia.com, helgaas@kernel.org, houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Reset page reference count when page mapping
 fails
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Alistair,

On 2026-01-11 17:54, Alistair Popple wrote:
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

I had time today to pull out some old hardware and run this patch
through my old p2pdma smoke tests. I don't think the tests exercise the
change, but it looks correct to me on review.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for the fix!

Logan

