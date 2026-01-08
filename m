Return-Path: <linux-pci+bounces-44273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A720DD04545
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 17:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF0D831B5E36
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309A3A89BA;
	Thu,  8 Jan 2026 10:17:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC13A63EC;
	Thu,  8 Jan 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867472; cv=none; b=oU8+OY54bwJO+GtB1ensaOeD1yXueDX2ewRbLXUb/God/W3uM8bG/4TYxuG6qIcg1fRkKTlOaDS6dymL4ovbQYxExZ9RT9kDmJWY3U43QZMtC+LPGfIVMwPD8wEe57ATQU8oLBUg8Z4Q1/b/+b9aYyHCdcIeFrwBS3OqApeb00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867472; c=relaxed/simple;
	bh=7y4MAUAOlFLvy6xkX8Vql9Spu9LRIDXbDcmnMGNgqZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2jrZyad0GEnDnZi2pBUb2etkIo9+L/GZS0uZaQ14S5TQ4Mbt4GfRWx2xUvMHY+DLjvRYDLaxgls5P6Pdaedp+GIVcv7uWRm0RLyoltKFsS7eotxbIiOdZXT8uhGxU8MonrJn/TXTmQhqu7WtYCB+j1nqNbx4486yA3U9zzsinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7E68227AAA; Thu,  8 Jan 2026 11:17:42 +0100 (CET)
Date: Thu, 8 Jan 2026 11:17:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>,
	Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
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
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
Message-ID: <20260108101742.GB24709@lst.de>
References: <20260107171724.GA432074@bhelgaas> <20260107203439.GA446340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107203439.GA446340@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 02:34:39PM -0600, Bjorn Helgaas wrote:
> > 
> > Given that, I would ordinarily target the v6.20 merge window, but the
> > "ASAP" suggests more urgency.  Do you want one or both for v6.19?
> 
> I put the patches above on pci/p2pdma for v6.20 until I hear
> otherwise.

Sounds good, thanks!


