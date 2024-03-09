Return-Path: <linux-pci+bounces-4696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17533877255
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEF41C20CB0
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7F15BE;
	Sat,  9 Mar 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="13soT37s"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0415BA;
	Sat,  9 Mar 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710002207; cv=none; b=tp0HvH1/aPcYG7a3oYEDXCq39xTptOhkX8afJEr1qtUTi0XZTHMpWL7Xkx5BapTofhYJFd/YFkv3ETY/K/1TpjJplQL3ktknDqehCox8lQCSkHipl5h+24Q4K5qU7Ryri1v1YAtvlso2IcYdgwvRg21Ch5Esvd2NtT2bSsTRd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710002207; c=relaxed/simple;
	bh=pxIOe2hfqRhb0QCUXddAl6+zpU3sFWxZy0utO2WLXh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icCDFb0bbdsA4qxqK80BQn4nVQypeRk1/cgaGoBabydxAFizDF/7h5L5ols9KE3Rn/TgLKAJU0UkEKswNlWIb8L6QkUYq2JyrqoFBvikQbAvHJQ3FbnXBvRkNRu/Z/ovj7VStjLWkcAcLfWxPuGjl0Mwycxrbhl2232VoxMSBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=13soT37s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ddEtC0OaYXNinFjX1O8qBWg4PwT/XS5HbgLCjTbGBtw=; b=13soT37sghi46wwoosaRp/B7Ww
	tJ0AS28EAKUxB/jCvMxgv79Iaj8CcXIr0ADG2WFzMWPXu6hzVzE7FF+EPhJD5ejoPgshy3x28rB7U
	yVSbrCxTn5BrdXaULJTEIFBjpc4Qz78/+9bHGdS/2mKA43YDgbNTyu2RqiFNLQCe/cjh5qcz5tZmJ
	noTb5iIiPHpM34G+6Uu2CzvXyVi9nO7HVvq4ftvDru+Bl1S98AV1J5xzUKLqqJtWSgC2Pw/2PeMZd
	RMjwMY6iye345H/oN3yLd3U5KgjaBejDhWue9mcGg/5kV72cz5FHVq2yH198r5OZuMT22r3DtVXXc
	EgIcOYiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rizgf-0000000Dldv-0CdF;
	Sat, 09 Mar 2024 16:36:41 +0000
Date: Sat, 9 Mar 2024 08:36:41 -0800
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
Message-ID: <ZeyQGU3ziQbLBu_E@infradead.org>
References: <Zeso7eNj1sBhH5zY@infradead.org>
 <CAADnVQKQumV-0AxGLKX0jQEfa8Z2Bxx2yW8k_1OqGBnD-RqrbA@mail.gmail.com>
 <ZetEkyW1QgIKwfFz@infradead.org>
 <CAADnVQL4JAUz-p-X9aEggeKNpYUqJZrzQKO7N0dnohE0r7mdpg@mail.gmail.com>
 <ZetJ4xfopatYstPs@infradead.org>
 <CAADnVQJKPa+JUUKpW7gZehbFBYj3GPrbpd0NCj4xwkU2puObEw@mail.gmail.com>
 <CAADnVQJeOc9Muki+-PUYc20-=1vRgkprbNL0zTc=Cz-T_iYkNQ@mail.gmail.com>
 <CAADnVQ+zbZ1M_uvWmyWUdomAedP+LWMhQX-5bGajzJ0GYzme9g@mail.gmail.com>
 <ZeyATzYas84F3IKQ@infradead.org>
 <CAADnVQLVr4ppEkDOVScR2FZ0dRwMLADtgh7L4jqt1yOYrxoWZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLVr4ppEkDOVScR2FZ0dRwMLADtgh7L4jqt1yOYrxoWZg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Mar 09, 2024 at 08:33:37AM -0800, Alexei Starovoitov wrote:
> On Sat, Mar 9, 2024 at 7:29 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Hi Alexei,
> >
> > yes, the patch looks good,
> 
> Thanks for the review.
> Can I add your ack or reviewed-by ?

I thought you had already applied it, but in case you can still
ammend it:

Reviewed-by: Christoph Hellwig <hch@lst.de>

