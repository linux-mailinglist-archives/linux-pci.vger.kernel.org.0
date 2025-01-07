Return-Path: <linux-pci+bounces-19404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDEA03E33
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE257A2510
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668951EE001;
	Tue,  7 Jan 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol/x2pPp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E21EBFF0;
	Tue,  7 Jan 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250466; cv=none; b=iJfD0WsCYtJjHXX/fHV2eOgn2XVws+XLqZoMr9dxYFlHtM9i12Em5qvuLnrReVt9SjBk4xtFTIIKJ5lpbBnQLsHl/SOPu0HWRXeIVCNL+ptbqaQY5ZFAO7Ygt+aeeUbf7GKoNyhRz86mS0BK2UKfJZxZXhBDOBenWjzm0TpXldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250466; c=relaxed/simple;
	bh=gJjYD1fo+HjuqEWXbg21jUSok6U3cLCahroKUc9Ao1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXQloFImXNtcqz9vnPO9XYRYla0/BcI/DmD2DIBAgzyxdGhsndlBrZB7y1U9kx5mRhAUHgBuLjnjFbzR6akftQ2Znk7djM3w1e6VY3leT4hZncVeWP6mpeTncuanFCNFCxNgyJ4fh5m67KWDpptfNn1sEgrQApfJWZid3qFKTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol/x2pPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3A3C4CED6;
	Tue,  7 Jan 2025 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250465;
	bh=gJjYD1fo+HjuqEWXbg21jUSok6U3cLCahroKUc9Ao1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ol/x2pPpR0ulv7hWzp0dsi7TW3g/N/eWCJkzSWzS5gxYIJkdxFHuFFkjams5B62Ti
	 bDcqv16Z0n1MkZYrtOGlyWM7pWuo8gbbIfK2wf4XvVbeQSrF2oKLW7rX2NizqcXUJ5
	 lT0IfX1A9Yu3NjervNgw75iVZED2rqB3LtRyf5OEKOUDXSr0OD3aISbXmm9c1MBgGs
	 oOqXeW+ypvlRCuwD74wSCaQsNoZYPMc/8H3u6sUYzm8Kxqb7WswpszGRej856AyocY
	 sIWRc2V1P7PQaypTlwmmHLfssPe87qL4EHX1aBzXrD6PeYE98aA75AkuzzPpMm7EEg
	 kolUz7T4e5iXw==
Date: Tue, 7 Jan 2025 12:47:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z30UXDVZi3Re_J9p@ryzen>
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
 <Z30RFBcOI61784bI@ryzen>
 <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>

On Tue, Jan 07, 2025 at 07:43:26PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/1/7 19:33, Niklas Cassel wrote:
> > > Hi Niklas,
> > > 
> > > resource_size_t bar_size;
> > > remain = do_div((u64)bar_size, buf_size);
> > > 
> > > It works for the arm platform.
> > > 
> > > arch/arm/include/asm/div64.h
> > > static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> > > {
> > > 	register unsigned int __base      asm("r4") = base;
> > > 	register unsigned long long __n   asm("r0") = *n;
> > > 	register unsigned long long __res asm("r2");
> > > 	unsigned int __rem;
> > > 	asm(	__asmeq("%0", "r0")
> > > 		__asmeq("%1", "r2")
> > > 		__asmeq("%2", "r4")
> > > 		"bl	__do_div64"
> > > 		: "+r" (__n), "=r" (__res)
> > > 		: "r" (__base)
> > > 		: "ip", "lr", "cc");
> > > 	__rem = __n >> 32;
> > > 	*n = __res;
> > > 	return __rem;
> > > }
> > > #define __div64_32 __div64_32
> > > 
> > > #define do_div(n, base) __div64_32(&(n), base)
> > > 
> > > 
> > > For X86 platforms, do_div is a macro definition, and the first parameter
> > > does not define its type. If the macro definition is replaced directly, an
> > > error will be reported in the ubuntu20.04 release.
> > 
> > What is the error?
> > 
> > We don't need to use do_div().
> > The current code that does normal / and % works fine on both
> > 32-bit and 64-bit if you just do:
> > 
> >   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >                                    enum pci_barno barno)
> >   {
> > -       int j, bar_size, buf_size, iters, remain;
> > +       int j, buf_size, iters, remain;
> >          void *write_buf __free(kfree) = NULL;
> >          void *read_buf __free(kfree) = NULL;
> >          struct pci_dev *pdev = test->pdev;
> > +       u64 bar_size;
> > 
> > No?
> 
> 
> Hi Niklas,
> 
> Please look at the robot compilation error.
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20241231065500.168799-1-18255117159@163.com/
> 
> drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'

That error was for your patch that changed bar_size to resource_size_t,
which is typedefed to phys_addr_t, which can be either 32-bits or 64-bits
on 32-bit systems (depending on CONFIG_X86_PAE).

I was suggesting to just change it to u64, so it will unconditionally be
64-bits.


Kind regards,
Niklas

