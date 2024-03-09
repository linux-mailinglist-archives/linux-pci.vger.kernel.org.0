Return-Path: <linux-pci+bounces-4691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74DC8771ED
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 16:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E232D1C209C6
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259B4439F;
	Sat,  9 Mar 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HM7Vrg5S"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE236446AF;
	Sat,  9 Mar 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998169; cv=none; b=NQV3WPeNPcu9SpO8AYNIjG+ieQn9ScLpnH01I1RBFp6dD7Zjq/6zwTT5vbgMxkMMQbVpP9x7jQzM0Sd+uV2nO0hTLAJaEC7SFnbOu8+a6HhfVKfwYliD94yOCPWiEusWrmY1EP0TXn0oj/8C2j9M4vZptwObLic4bh6uoWsa5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998169; c=relaxed/simple;
	bh=VsFq1vLYgMYpNkt3W3CkLvb1Geo1az9eOjCyRTV2seI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0hOlvS1xws80TG7C6POwDIqFxuHTmyWkc02vGBnK2WEtob+gBl3xXRqos7JBCoVCTCue3ZGepk6r11sIa1yuQhv9zhiUiAHeQ1fJuMmc7GQyGLrp9tDZiVTfVe+0/nINW/HlDP3StyCTdRsVK1+1SzjqHt4qMFAHWBFV3c/SAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HM7Vrg5S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0tj9wgNa7QSf7Wh9KfHcJgRIH+8sNfugiqQvdie44kc=; b=HM7Vrg5SwNjyb/7qo13INAfDq1
	AsAg31fHw6GnJN6n4Js+FgB8A/41+wCSubvjhlUhQtVerDNDV3cCiUFaqX0zgGZ28E9YP1jduej02
	AyyZargmA3+kAOknZpDm0lU2uXaxvzcYJD8XbUxI9A4BwIoB/zB2dyAWgs8P8UxMZ3NX+96nTJVnA
	bsy/bInWtKME/Tw/kswWfn3SwJ2eTNUt6tdFCach7sD9FOPTtw7CfrZej1tUIGjCkjWoiomSjeGbp
	RcmFBoBo/kJUE1Y7/yQbXFP6kjKHvI30H9tBn1aNQBEzKaNCTNKTRIe0aVRKX/fWR1XbI1cdfg9n3
	+n3I4Q6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riydT-0000000Ddwa-1NSK;
	Sat, 09 Mar 2024 15:29:19 +0000
Date: Sat, 9 Mar 2024 07:29:19 -0800
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
Message-ID: <ZeyATzYas84F3IKQ@infradead.org>
References: <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
 <Zeso7eNj1sBhH5zY@infradead.org>
 <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
 <ZetEkyW1QgIKwfFz@infradead.org>
 <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
 <ZetJ4xfopatYstPs@infradead.org>
 <CAADnVQJKPa+JUUKpW7gZehbFBYj3GPrbpd0NCj4xwkU2puObEw@mail.gmail.com>
 <CAADnVQJeOc9Muki+-PUYc20-=1vRgkprbNL0zTc=Cz-T_iYkNQ@mail.gmail.com>
 <CAADnVQ+zbZ1M_uvWmyWUdomAedP+LWMhQX-5bGajzJ0GYzme9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+zbZ1M_uvWmyWUdomAedP+LWMhQX-5bGajzJ0GYzme9g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Alexei,

yes, the patch looks good, and yes, arm32 ioremap_page should just be
removed.  I can send  patch unless you plan to.


