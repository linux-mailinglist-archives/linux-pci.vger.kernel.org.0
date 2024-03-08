Return-Path: <linux-pci+bounces-4668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E198766F6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E28285F67
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE8539C;
	Fri,  8 Mar 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmdmwaPZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD44400;
	Fri,  8 Mar 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910259; cv=none; b=GBxdf8cpP17EkymPYKUrHzNJv3OktYU8ew+CGcgxKWhjhKM5ETcxNiFkQRd8yLEzvJzGMwLRmULk4nkTYKuZkAzllDWsPJByDyyS+su09XfEZBgXHeD4N2mb3932gxtIYMGEe19xqq88rWqQnuFJNPOeegNRjYrvOOBcSrKquX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910259; c=relaxed/simple;
	bh=amIJ43frdp4LdXvpQ67ZzTeH+8PRRAvAbZgeIDVVaBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEYGaFiWES+O/P+NgCZA9qnUVbvLezwdn8+B6vfIfpMJ+Nu2hDQe+btc/4lfmaUHdHjns1wlz6L602tpFewtifAFiSQDx/JcKCMJHX+EEuS7icCH3fQEptWxfJPFV3JcbTaf9Kl2Ie09P5UfNDZDb8c6hkignCfEcAhYM2jnjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WmdmwaPZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pt9Vyv0hcTbTYMdOV2K1n/4yTaHmt/kpyjOZmBFIygA=; b=WmdmwaPZwwGNHbN9Mdm0fInXWg
	/38/AKUe+SqOhBSgny47q8Bln2IH0TAhlEeLXUOhQTzWEa1bpNSOcaXqRaAFez7eOXEskbuhE98kX
	iRE+3wrBkuVfSgA3g7sjP7fRClApebGV4ftmX3gFqpfAMOd6R4uTKvmfq7aRYPPzy0LhP/mF95wMI
	xOOIXJlud1/jcKPhRmlII6Z/RuHTA9md3ErqD2Y/Y2MX5PhjPI/h7cgO40v5gYXEd2nboW6EXHjI/
	j++TdKQn/1bUJ1flcfUNVYxWr9JhN9YkSn7+mGji96XZkdr5Z42NV/TtHXKXutPgfMKtOcENGQ/BO
	y565Zzmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ribld-00000009jst-2sof;
	Fri, 08 Mar 2024 15:04:13 +0000
Date: Fri, 8 Mar 2024 07:04:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
Message-ID: <Zeso7eNj1sBhH5zY@infradead.org>
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 07, 2024 at 07:49:16PM -0800, Alexei Starovoitov wrote:
> Ok. I think I figured it out.
> Please try the attached patch.

I don't think this is the right thing.  The probem is that
the PCI code shouldn't really be using ioremap_page_range if it is
not an ioremap area, but instead directly call into
vmap_range_noflush (or an added back vmap_range to avoid all the
duplication) similar to the vunmap case in vunmap_range.

