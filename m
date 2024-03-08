Return-Path: <linux-pci+bounces-4677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77609876939
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BC9287802
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982CC200AA;
	Fri,  8 Mar 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SjKkr9M7"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085B1D698;
	Fri,  8 Mar 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917338; cv=none; b=cdDmrmtAryO7mj/CB7Y5U7ef1QTETHnw5PLK1WlIjs5CjKKLFjQN8TMSpRjnTys5tmQWi31ClVkj8UUhmvzAdFTZ9Fr8UQfbTHS0vrENyLzaQxyJ/dPBAtOUAA9mHbzUsxfqHskqISXxZHl1AxWrxuks+KfUQ/YtFBlX+bCun5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917338; c=relaxed/simple;
	bh=EJfinzrUbLD4sEKSlrZWMhsgaO5WiyaoMvgJl2gYYYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/L5WCdAmUpn/ej8EIIbnGQs75mjy2lsumk5+tuRrWnxW/YWQpIJsFJFHlVjUETxmV+xOyjKYjQNKYt+p/dyr9R7tP0DDPdGNLvcp6lQYeWsBX1YFE2swhctKbW0X2EplfWisruGQXvItAGJynEfaaXT0Kl2QdKYnnj8No1ranI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SjKkr9M7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4qt6B2DEelMk3i3au76miwVYGuqD69MMNvsQhf9L6eU=; b=SjKkr9M7HMCTOJeUS7mscRYx5K
	lu8Smc7Bhj+S8mDp4VsgDShum2AAGcEXflC1jcpUhkEKrYpF7Bbp4xI42lx8mhtr+euAwApC5Z2z8
	3ffgWeSG/txUpX5DOj1uG/xkuo05nYQLUhkPFHxvw0tRJoronxRdMYz6DJ92mTWRVW4HkkMFhA3RH
	QhOXe42tfkLsAn5aZr8HjFlGiilvCmARmuR1YxooOxh8Nt64TfxiAb9obIMj1KEYClj//0VG669Ps
	eZLe3sQOoNSqU+vWomQSz11n0w3kQAOd38T37PSYk2o7kMWG0sbtdtNNYnZInnflW4kpZfEPTMu8N
	qwnrrJ+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridbo-0000000AMNk-086d;
	Fri, 08 Mar 2024 17:02:12 +0000
Date: Fri, 8 Mar 2024 09:02:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
Message-ID: <ZetEkyW1QgIKwfFz@infradead.org>
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
 <Zeso7eNj1sBhH5zY@infradead.org>
 <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 08, 2024 at 08:33:18AM -0800, Alexei Starovoitov wrote:
> vmap_range_noflush() is static in mm/vmalloc.c
> There is vmap_pages_range_noflush() that is in mm/internal.h,
> but it needs pages instead of phys_addr_t.
> Newly introduced vm_area_map_pages() needs struct vm_struct *area
> and struct page **pages.
> In this PCI case there is no vm_struct and no pages.
> ioremap_page_range() is the only api that fits. afaict.

Except that we want to enforce a vm_area with the ioremap flag for
ioremap_page_range, and just adding a NULL check defeats that.

The right long term thing would be to actually create a vm_area
for the PCI_IOBASE region, but until then we just need a lower level
API.  That's why I suggest to add a vmap_range() that is basically
the ioremap_page_range before you added the checks, and make
ioremap_page_range a wrapper around that that checks the area.

If/when we get PCI_IOBASE handling converted to the proper
vmalloc/ioremap areas we can remove that again as well as
vunmap_range which is just used for PCI_IOBASE and other equivalent
ISA_IO_BASE in powerpc and somewhat unusual case in arm64 that I
need to look into a bit more.

