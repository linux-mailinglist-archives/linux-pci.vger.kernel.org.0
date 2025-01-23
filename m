Return-Path: <linux-pci+bounces-20300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037DA1A9AE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226E4188E9A8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FCC147C91;
	Thu, 23 Jan 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRsCZHEz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFCC2F2
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657311; cv=none; b=CWLCYSf/cpMijdZujB6h1VGg+Q75OGP0fab+142aW3xcZNIL/cAQwpEwyb/oVD8NL0vhgdVdeHXMiHS4/pGN2USFtSVYLRPjp0fzdUaXG0CB2ng83u00FKBspKMpc0Gpcb5wlOl4QCa3VsoK/OLSS/lqE/9pdXNDs9c98G6oA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657311; c=relaxed/simple;
	bh=x5bQF/cNACJ1+tjMwDiQXbdPCBBUBGFBiHqRD5z9a4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqt1CBsa15W7sKNWnAWJwOYqNOGP3qyl7anflC1ftdSDCWF4KDPOc6I1sH/MSfFl6MBzNyNRF4QVmnf87cehJBYaUtBZxIV+F9KsO8u6g+nVeC2jHW37Clqa1htj/V1W17xEPOl0GCiFkiJzEh8gcW7UCPrXKK+KvH97FsNxSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRsCZHEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB9EC4CED3;
	Thu, 23 Jan 2025 18:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657311;
	bh=x5bQF/cNACJ1+tjMwDiQXbdPCBBUBGFBiHqRD5z9a4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRsCZHEzzGrIaX9nIzlC0EyLaUXln+2ohFxCxhcez4c7geJTCe2RvE1/bt0SlOgoI
	 IYlilsQMSvv77hWKH0L3KKDDbpS+yQt17sRUd8y+DiboDE1AA9v7FVjIoVkiNX87r8
	 y7ll/JNab+C3G/emMZetuxC1SgukDDB8n5rG2B7Y5mKKhgf1TOOSMTgNpYDpq5chDP
	 alP5eVw3hroVcwdbJyeVQljkCtN1r/q4suhkBc2NH9ZsCz0vTRVIfrg1zj8P17Jx8c
	 MOHB3CfnJJNqLIFfu/OBBtTEewyVBVaNHJkSN6UTjG2J1ZgXpGOWjR5oPMII5YcV/j
	 mIacMa+nb/IDA==
Date: Thu, 23 Jan 2025 19:35:06 +0100
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
Message-ID: <Z5KL2o0hREaVDiTC@ryzen>
References: <20250123095906.3578241-2-cassel@kernel.org>
 <Z5JmK3tAtNi2K2bO@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5JmK3tAtNi2K2bO@lizhi-Precision-Tower-5810>

On Thu, Jan 23, 2025 at 10:54:19AM -0500, Frank Li wrote:
> On Thu, Jan 23, 2025 at 10:59:07AM +0100, Niklas Cassel wrote:
> > Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> > is e.g. 8 GB.
> >
> > The return value of the pci_resource_len() macro can be larger than that
> > of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> > the bar_size of the integer type will overflow.
> >
> > Change bar_size from integer to resource_size_t to prevent integer
> > overflow for large BAR sizes with 32-bit compilers.
> >
> > Co-developed-by: Hans Zhang <18255117159@163.com>
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Hans submitted a patch for this that was reverted because apparently some
> > gcc-7 arm32 compiler doesn't like div_u64(). In order to avoid debugging
> > gcc-7 arm32 compiler issues, simply replace the division with addition,
> > which arguably makes the code simpler as well.
> >
> >  drivers/misc/pci_endpoint_test.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index d5ac71a49386..8e48a15100f1 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -272,9 +272,9 @@ static const u32 bar_test_pattern[] = {
> >  };
> >
> >  static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > -					enum pci_barno barno, int offset,
> > -					void *write_buf, void *read_buf,
> > -					int size)
> > +					enum pci_barno barno,
> > +					resource_size_t offset, void *write_buf,
> > +					void *read_buf, int size)
> >  {
> >  	memset(write_buf, bar_test_pattern[barno], size);
> >  	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> > @@ -287,10 +287,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> >  static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >  				  enum pci_barno barno)
> >  {
> > -	int j, bar_size, buf_size, iters;
> > +	resource_size_t bar_size, offset = 0;
> >  	void *write_buf __free(kfree) = NULL;
> >  	void *read_buf __free(kfree) = NULL;
> >  	struct pci_dev *pdev = test->pdev;
> > +	int buf_size;
> >
> >  	if (!test->bar[barno])
> >  		return -ENOMEM;
> > @@ -314,11 +315,12 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >  	if (!read_buf)
> >  		return -ENOMEM;
> >
> > -	iters = bar_size / buf_size;
> > -	for (j = 0; j < iters; j++)
> > -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> > -						 write_buf, read_buf, buf_size))
> > +	while (offset < bar_size) {
> > +		if (pci_endpoint_test_bar_memcmp(test, barno, offset, write_buf,
> > +						 read_buf, buf_size))
> >  			return -EIO;
> > +		offset += buf_size;
> > +	}
> 
> Actually, you change code logic although functionality is the same. I feel
> like you should mention at commit message or use origial code by just
> change variable type.
> 
> #ifdef CONFIG_PHYS_ADDR_T_64BIT
> typedef u64 phys_addr_t;
> #else
> typedef u32 phys_addr_t;
> #endif

Hello Frank,

I personally think that is a horrible idea :)

We do not want to introduce ifdefs in the middle of the code, unless
in exceptional circumstances, like architecture specific optimized code.


Kind regards,
Niklas

