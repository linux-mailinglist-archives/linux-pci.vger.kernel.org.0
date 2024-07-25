Return-Path: <linux-pci+bounces-10795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE793C6BC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5839B1F25C51
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EFC19AD81;
	Thu, 25 Jul 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TXWbYQXr"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680418028;
	Thu, 25 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922447; cv=none; b=ok5RZWZDCbf4/W73X94F6H/V9s1puUrspsj2cF9qOFWQRafa7gbaU3UydFhhm0rrRIXOMYCp81dKw8OHSe2byWbNB5gfNXORWJpTAsEwuxYpp8s5p3CgxBh+uUSCYCnYOMIMSWZhGK3LZAr6GwliIa3P34afYbEotG5rGY8M4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922447; c=relaxed/simple;
	bh=DOid1xzMT+yAdojicRBMDsnBuLwmESana9LiLPR+RHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1RWZmSiQ636SkOaiVr8LSwEBMG3vDXCHHYHWMeimosfid8qT7ptSuLzfU9xlReNVJb2EgZuKcrgTrMQ92g0XWkQWolmln9GHr/J2yXEs6vluBTwz+++W6DihCT0+jCQK1zuo4GMwvsfKueXxs9j2FDmLgM2hc5f509ZX3JQCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TXWbYQXr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VZ1b77BjTZ1fVJ/XQ5ChB8stY2Qb8vGhK84eMcWqs4s=; b=TXWbYQXrfE/cKwDkHGFzrz8SLo
	OkLYgFZnkFT8mRmQ+eleCQQRcMfsQkKjLVmE4NYUv5cobLbvZcMNCA1IsGlBQ3kKQaaMHr+5i9oZh
	RYzRuLunm9iEYaPCdugpxX+jYewqK0aAoWI+g/dmEPGDjtI+1rtatliBpL7AJP0ATR6P7rVxwpaHi
	OqEscoGL4F8ZY//xaUor7AY0aEfM6uugNQCuGig5n+dV1mIpo2xI65Ld4iL2285fNxIFVheExrLrT
	z2Mzo2pSpyMpntrY7864N3AykudSS4SqCzZTwfE6AznW7UUaa8godEe+MOppkaionvitZ8xSX+aNw
	9LwBdspw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX0gf-00000001SsC-1rw7;
	Thu, 25 Jul 2024 15:47:25 +0000
Date: Thu, 25 Jul 2024 08:47:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <ZqJzjStDQIeL2ojd@infradead.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
 <ZqJgkLxJjJS7xpp1@infradead.org>
 <9529b8012b1a1573316d65727f231f5cf54d0315.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9529b8012b1a1573316d65727f231f5cf54d0315.camel@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> That's precisely what all my work is all about. The hybrid nature of
> pci_intx(), pci_set_mwi() and all pci*request*() functions needs to be
> removed.

Ok.  Thanks for doing the work..


