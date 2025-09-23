Return-Path: <linux-pci+bounces-36774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA4B9607C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1178216396D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39957245006;
	Tue, 23 Sep 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3H1ZCxjj"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB84204E
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634596; cv=none; b=kUEujavi7q9yHUAFhU+CJE7tOwR6i6Vpxuu1g8cyrv3xnp7TRZko7QgSFNAp25lMR+ZmF+ef0ggZC9tJau3+WgEL5jBbYUd7pumV7mN4YQDPRYJtfobPwItFhbNRbqoeHDPfUajCoj5tF2FqKoZsXCL9A2SriIccrn3Bsqzxgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634596; c=relaxed/simple;
	bh=dvkBTMzAkRPtHEpwyjfjXXHumnpLiEFSH2/WjNbkDGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7rXj2lRb+VGElESUa/eomTcgad8y5XG9ujSWjP2jeunIaSr7/DSbd7FMUWKwJlVl+furLehb58Z+KaLTH8KFzbnNhvoUM3eXb0XDr9lfbPokxA0aI7flRtVmc+yBwxwA2LcrWKGq1r/Bd8pKU+YQh5novK2WtlYjdvXS6+M/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3H1ZCxjj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qit3OXxpZh2ogtg5RstC5cs1VSqpbAxG4rhPfkTl5lc=; b=3H1ZCxjjBOdKNRVAfEFtmda4XE
	r6k9RE3NhaDKZGRQYCcecwPguTadehXBN5HoI5W5ztvjEoy3NIfXmJJf1EGXze48EbdYnG5Htn2Jy
	yQhGjPozo/FBt0U86G1DZtZb3EnjQY+iS/kbB0WsmkJley70/cjDqE+aHbU2r4rm35g3lOOzya38m
	oDyYAgnCSj0ih+4mTdDcFE539cgrvFnAYK7OrsUCnAmtBTapEfwY/u5MbLht+UItnDDD2hOiIKFp9
	VhS/dpdN3r39gCtXzTwseCjAv6IfMu+0rEZNC6BcFfGqyyl/1K/y/rj2f7LhAV6DwYAyuFw/fXYdQ
	LZYwwGCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v13C1-0000000DX9j-3ykz;
	Tue, 23 Sep 2025 13:36:29 +0000
Date: Tue, 23 Sep 2025 06:36:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
Message-ID: <aNKiXTGs75fldDYS@infradead.org>
References: <20250919122931.GR1391379@nvidia.com>
 <IA0PR11MB718504F59BFA080EC0963E94F812A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <045c6892-9b15-4f31-aa6a-1f45528500f1@amd.com>
 <20250922122018.GU1391379@nvidia.com>
 <IA0PR11MB718580B723FA2BEDCFAB71E9F81DA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <aNI9a6o0RtQmDYPp@lstrano-desk.jf.intel.com>
 <aNJB1r51eC2v2rXh@lstrano-desk.jf.intel.com>
 <80d2d0d1-db44-4f0a-8481-c81058d47196@amd.com>
 <20250923121528.GH1391379@nvidia.com>
 <522d3d83-78b5-4682-bb02-d2ae2468d30a@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <522d3d83-78b5-4682-bb02-d2ae2468d30a@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 23, 2025 at 02:45:10PM +0200, Christian König wrote:
> On 23.09.25 14:15, Jason Gunthorpe wrote:
> > On Tue, Sep 23, 2025 at 09:52:04AM +0200, Christian König wrote:
> >> For example the ISP driver part of amdgpu provides the V4L2
> >> interface and when we interchange a DMA-buf with it we recognize that
> >> it is actually the same device we work with.
> > 
> > One of the issues here is the mis-use of dma_map_resource() to create
> > dma_addr_t for PCI devices. This was never correct.
> 
> That is not a mis-use at all but rather exactly what dma_map_resource() was created for.

It isn't.  dma_map_resource was not created for PCIe P2P, and does not
work for the general case of PCIe P2P including offsets and switches.
Using it always was a big, and the drm driver maitaintainers were
constanty reminded of that and chose to ignore it with passion.


