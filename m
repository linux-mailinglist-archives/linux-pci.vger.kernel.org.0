Return-Path: <linux-pci+bounces-20323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C0A1B298
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A953A7E6B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03520218EAB;
	Fri, 24 Jan 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klvwWPSF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D9218EA7
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710955; cv=none; b=BR9UALUru25cbwdtmXPYkmWlBanrA/onfzZAe8Kjdgm7XLM8DN+F74BwKUNGPXOwolD7iRl44s27maR8SvcAjV+HoDFUPu5ec7HM1cwDflgS5kuoHIKz92Eh5xkvlFmambj+W3QgNrVEPV3J9IXEbx2nK5RsowDns2A+65/whKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710955; c=relaxed/simple;
	bh=NG6H0nzNi1H7cZ9MPb4c2f2Rjj27yK60bq+x6Rtu3rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwEwbpb+hnu4b64IT49wwXzpWTNTj8xcgh0NCCtND7EMfoqWmCoBG314QCe9rWeAisM/hsmb7thro/hjTvD8zPTNsZze0yDpKj4Lpdk/0/UxIN+9OJ0cyVuOv9od3HE6aU58U8r1P6agxFHNXZuRgC4RsmQvjrW1j1nMyIVkRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klvwWPSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891D1C4CED2;
	Fri, 24 Jan 2025 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737710955;
	bh=NG6H0nzNi1H7cZ9MPb4c2f2Rjj27yK60bq+x6Rtu3rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klvwWPSFC2zoJrB/q84Kxl8lpJzV0mVNlMUn4R3Ypc3m+OOPn70bsfyGkyX9AUyGB
	 NaP5fu/herFwGgQKOtOKveaKyxpj+MGX6yQX4sl7iiDCZW9EZUZDRxiwOPWCGhqZkz
	 b3d5I0TrxJEPywljo8IKPb0+pEWaT25dyzc9lY4J7Z0qn6tXr6POqY9yoUlV1sqdJP
	 43pu9Pt3xiMw0kIo7+cv47gGs2Niz3KCDM5khFRBslqOeqRIhPO1opu7yUR39Tl5cQ
	 bXZ5dWHdC3zPTXrKOfe1O9Ftt25gbuG/wDeAPqIKs8ATJe19yBGgpvfOx9AXx2MQZJ
	 evnRnJ+8VI7aQ==
Date: Fri, 24 Jan 2025 10:29:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, Hans Zhang <18255117159@163.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <Z5NdZvFC1uwjrMX5@ryzen>
References: <20250123095906.3578241-2-cassel@kernel.org>
 <Z5JmK3tAtNi2K2bO@lizhi-Precision-Tower-5810>
 <Z5KL2o0hREaVDiTC@ryzen>
 <Z5KT5GZH4VEpz430@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5KT5GZH4VEpz430@lizhi-Precision-Tower-5810>

On Thu, Jan 23, 2025 at 02:09:24PM -0500, Frank Li wrote:
> On Thu, Jan 23, 2025 at 07:35:06PM +0100, Niklas Cassel wrote:
> > >
> > > Actually, you change code logic although functionality is the same. I feel
> > > like you should mention at commit message or use origial code by just
> > > change variable type.
> > >
> > > #ifdef CONFIG_PHYS_ADDR_T_64BIT
> > > typedef u64 phys_addr_t;
> > > #else
> > > typedef u32 phys_addr_t;
> > > #endif
> >
> > Hello Frank,
> >
> > I personally think that is a horrible idea :)
> >
> > We do not want to introduce ifdefs in the middle of the code, unless
> > in exceptional circumstances, like architecture specific optimized code.
> 
> You miss understand what my means. I copy it from type.h to indicate
> resource_size_t is not 64bit at all platforms.

I know that resource_size_t is typedefed to phys_addr_t, which can be 32-bit
or 64-bit. (I compile tested this patch on 32-bit both with and without PAE.)

resource_size_t is the type returned by pci_resource_len().
That is why the patch in subject changes the type to use resource_size_t.
IMO, it does not make sense to use any other type (e.g. u64), since the
value returned by pci_resource_len() will still be limited to what can be
represented by resource_size_t.

A BARs larger than 4GB, on systems with 32-bit resource_size_t, will get
disabled by PCI core:
https://github.com/torvalds/linux/blob/v6.13/drivers/pci/probe.c#L265-L270

So all good.



As for your question why I don't keep the division, please read the comment
section in this patch (where the changelog usually is), or read the thread:
https://lore.kernel.org/linux-pci/20250109094556.1724663-1-18255117159@163.com/T/#t

I guess I could have added:
"
In order to handle 64-bit resource_type_t on 32-bit platforms, we would
have needed to use a function like div_u64() or similar. Instead, change
the code to use addition instead of division. This avoids the need for
div_u64() or similar, while also simplifying the code.
"

Let me send a V2 with that senctence added to address your review comment.


Kind regards,
Niklas

