Return-Path: <linux-pci+bounces-4681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8928769CD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC641F23FE8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E9425570;
	Fri,  8 Mar 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CW9Zw/3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6979D1;
	Fri,  8 Mar 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918698; cv=none; b=DZC8gfesmXh9C0R/4pX39gpXBuJNC+a9+d2rV1Y9o/K+ivfsLbA11uzczEZu+DWEzT8ds+CBAUvcRr3EwrxZ4BgrCKMfIRC+995h1JrIVM6/1+hswtn54pgQfbBs2XguYCkFHwTWUwavoQ99Bo980NKqAdO+ffZAZshQEJDD0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918698; c=relaxed/simple;
	bh=9mFS8xDPhvQmJicVJaxTmq7s9KnqxS/ikPQurUPqwX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QldDUL2EcS5rfkDisol6nDN9wm3YxNcfUMHEaT4p6aos6mBkDGz10bBTDCkkmLMj89my/eYjEF5rTBmMXKknfcBBjhoaYGAcVhp1r/lQpVjrjc9XdEkj3GQz9uYwZ3HbZEqiuX62NS+zsxLen/ykm5Sk9RI6rNAGiAah+itm3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CW9Zw/3f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9mFS8xDPhvQmJicVJaxTmq7s9KnqxS/ikPQurUPqwX0=; b=CW9Zw/3fg7T3GHI+dYllRagXJL
	uE2vGxtshRPe24a8Yf8lOHi0lvZC9XVGLjWebc+2RwRRgQxxMG96bqY67wrlnaHDijDwJDvTFDG/H
	gHMlBrVQWm/EOceRRg9HyLf9LvcXK07+qffBlto2Kt9wxNg+09lmFCz6W6FFGjq/6QFpUNFRXqsIE
	ZGMhW8nnH3EJoi6KStb3MIR1g6HqFUUBWgkd2vX7wg7/KTxVgsBQu+wW/leWMS69ExfS9bpf8KAI+
	M2zRV3LeqHtfzgM5EE7EZvUi8OFLV5OtDBAuz/+i2tVgZYu0tAoBr8VscWXRsCIgrhj+775DYFau7
	5WzAadgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridxj-0000000AUmj-4C7r;
	Fri, 08 Mar 2024 17:24:52 +0000
Date: Fri, 8 Mar 2024 09:24:51 -0800
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
Message-ID: <ZetJ4xfopatYstPs@infradead.org>
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
 <Zeso7eNj1sBhH5zY@infradead.org>
 <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
 <ZetEkyW1QgIKwfFz@infradead.org>
 <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 08, 2024 at 09:20:24AM -0800, Alexei Starovoitov wrote:
> ok. Like the attached patch?

Looks sensibe, but I think the powerpc callers of ioremap_page_range
will need the same treatment.


