Return-Path: <linux-pci+bounces-44207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E7BCFF0E0
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 18:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5EC63025DBB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF513396E7;
	Wed,  7 Jan 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNubg6mC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14001342C94;
	Wed,  7 Jan 2026 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806248; cv=none; b=L8i6uPxV19m1YGCyPZ+nMXitJMu3hnttpLPsu3tRXxIzlMGxslcrLe+Wqy+Xis+sFaUeGGNYUJOF/wPgIqgJSOvGmNKtGTrJEEC4JEAm7LSMSFTyTux7NgFrbWzARpLywWMrTY7CB5Bh7Sjvy6sSNHmfUdfg1ukqNsXaijZZdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806248; c=relaxed/simple;
	bh=q4ABnJ3CuJh6SWMrNmKQBlZ1gSO4Xo85FUt+DD5A26g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gqmqQtP21xvUd8JALwXD3JXM2Kw6SUPX8SBL3UWVkSEbqQ3SV8Vo559d6keywCDI5iH6bYCslNB7UHekfTXFuI+ZKyYlMpHVkYKp/YP8jC1aXCfTzSe1F+hLoQsnrrA6qZ/pTlhD0p97+mT5qRuGQOAc5+c2zOeY6yRfW1Kaizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNubg6mC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D5C4CEF1;
	Wed,  7 Jan 2026 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767806246;
	bh=q4ABnJ3CuJh6SWMrNmKQBlZ1gSO4Xo85FUt+DD5A26g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eNubg6mCK0SobRhjYoJFNql7uzoEIcWdOyZJ+7syVmoIAFPWxpQ5qk1OOcXtWvMZ/
	 EbPHNXCZGtKZWWLsyI8zNvbSgvEieOwFWos8HvgZ4qWEKGQTKr05nmNdPviq5otgrV
	 JoQ/n69F/t8qi0aHv/HswTkB3At6+u3ybtrUr1olX76MWaOP4a8ReA8a6ROjFZW+WV
	 QJ2qg+4PSGtZcaScVyLanjOBFEZqkgn8fNRL3vAt6Z6WgA/y3ZaRgAa8awY6iNpQcY
	 4Ye4/PyvwQpPnPzETDMuanANGjYLf2TXtc13gr512AogQUIbY3aQO3Wdt+503UOuhx
	 yoqZd+rSkrJdg==
Date: Wed, 7 Jan 2026 11:17:24 -0600
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
Message-ID: <20260107171724.GA432074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107143942.GB14904@lst.de>

On Wed, Jan 07, 2026 at 03:39:42PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 22, 2025 at 09:50:18AM -0700, Logan Gunthorpe wrote:
> > > Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > 
> > Thanks for the fix
> > 
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Can we get these fixes queued up ASAP while discussing the new
> feature?

I assume you mean the first two patches:

  PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page() fails
  PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()

I can certainly queue these up.  The second is a warning fix, and the
first fixes a hang that has apparently been around since v6.2
(7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through
sysfs")).

Given that, I would ordinarily target the v6.20 merge window, but the
"ASAP" suggests more urgency.  Do you want one or both for v6.19?

Bjorn

