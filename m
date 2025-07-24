Return-Path: <linux-pci+bounces-32878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B5B1030E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 10:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AFF18805F9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9F2749CF;
	Thu, 24 Jul 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZij/Khf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1727467A;
	Thu, 24 Jul 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344806; cv=none; b=H1yZoShF9/gO1ZfB/MctoG+UjzRbdFm06GEKCbUzeaNPHQnHngF3jA2B+A8mHl4aO+CKEjYeYVhubNVVccjUfrstsc0eDIXFAc/vVjRAUVpW217tbx/wceJFtzyHNqxb2X2TlSvnCt9fFAO9FEwUqxfrOcp38iaNESoSVTPK5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344806; c=relaxed/simple;
	bh=TMHBNschFRg/EXbokl2TnOo376mtUvL9vCgJ968zWc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP9P30ioLRxzemyYh2FZUs5im7yYgSewxy5ukfOqkLCpGMNyol1NZe2eHgMaiunQ0klOh6AJX7B3MNCGx29GDcGvUh17spk4hcleBEAfMCoHIhw7q+9fn2VL9Jj5zcgwM6alLU3eSxQicdeOVE5uMcc2O6MmurjrEbXhsCgxNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZij/Khf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259DEC4CEED;
	Thu, 24 Jul 2025 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753344805;
	bh=TMHBNschFRg/EXbokl2TnOo376mtUvL9vCgJ968zWc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZij/KhfBIUnbU4lbHxjP88/lDFzJVzpN+LpEfBwzehWsDkUfges9TR5IyiZTnUhz
	 OadLn/vpSTN0knIfMqxk1/W2CkIVAi3gxUO12Curbh72sdoAFUoZHMoQdkblwXYtCK
	 DBBS15tXdkII8NQBEHBXo5TqCjHgGsdp0FLQhgc8yB1hMi8M7wr3Or6XwNhMDDmE5z
	 Em/8soyscY18uKVRMTABiIjE1R3FnnTzVaf+jWOosD8zdiT3uo+rw2d6i+cCw9KzmJ
	 6lq4oh/7XQmhm5eJkFy7pTkaIXNXQvR9uEMZs2rWb31Otvoz0nnuBSZNCxcv8TqFNT
	 vTyCJMK4plyfw==
Date: Thu, 24 Jul 2025 11:13:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 05/10] PCI/P2PDMA: Export pci_p2pdma_map_type() function
Message-ID: <20250724081321.GT402218@unreal>
References: <cover.1753274085.git.leonro@nvidia.com>
 <82e62eb59afcd39b68ae143573d5ed113a92344e.1753274085.git.leonro@nvidia.com>
 <20250724080313.GA31887@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080313.GA31887@lst.de>

On Thu, Jul 24, 2025 at 10:03:13AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 23, 2025 at 04:00:06PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Export the pci_p2pdma_map_type() function to allow external modules
> > and subsystems to determine the appropriate mapping type for P2PDMA
> > transfers between a provider and target device.
> 
> External modules have no business doing this.

VFIO PCI code is built as module. There is no way to access PCI p2p code
without exporting functions in it.

Thanks

> 
> 

