Return-Path: <linux-pci+bounces-19949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D62A136BF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 10:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE23A16582D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA311DAC95;
	Thu, 16 Jan 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVmdMzDB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A841D89FA;
	Thu, 16 Jan 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020285; cv=none; b=MmImLedGS265DRMAwykQbMOyb6idqCIMPr1bXNXRW8Dbq8NYYrPYUVC7pTLWlNqRWt+rquc6hb3zg94Knavbc8dvg6oFsPsvhuGFkTmFoZpaz3plDmWYCxnFACxBmriQ0Zt5fIiSr1QwrlVsPhydwj3fFcM9jDKE5FzisGk6SrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020285; c=relaxed/simple;
	bh=LHIQ9jdvIq3kxFYUd9gVmPCA8Ry90NC30qhJAAhzdcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL2NdW6Tr2tuT+tECpb1qv0weeILH9m2hMgrCCb2YnEXQnx3QtQkse0Vme0cp2eCTg9lWnpopBmb4yJvPAqnKcUC9krsBARqNeBr00s3Ohnpmfglb7+YWn03JQW8Ktp54c9KjUg8MBHXq3tWEaq296Nz90zTsWv76ibaI0k8cNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVmdMzDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC43BC4CED6;
	Thu, 16 Jan 2025 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737020285;
	bh=LHIQ9jdvIq3kxFYUd9gVmPCA8Ry90NC30qhJAAhzdcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVmdMzDBY0o5pNBFom7RqbIM+EIyb+ixpsw+86rXkFLtpnaSP9vUBtJKPGvWn0heW
	 96hbcN3/ZUWSuus2B4wgh2oaM5smtwaa703HanlmyMtMIJXpTIF8DUv5nUYbwI1yIJ
	 x9giO3P1U4UdrwkQP8pycpzi8+E2gXsUJGinOArsGpmBkHg7yX2nt/vce+brgGttUZ
	 3vzUoFa0qwzLgXE0Pd8tsEkDV9Zj3+g2/XjrS0DMZfCKln7L+oimra8E6qlH3XXAg7
	 jHQBRN0tOm7Nfla8HPrT/C2BbMKe2lJec9NtPpn+kTHuvwPiTuhWiOU1CgDn4vu0Iy
	 UjQgok2xvmy+Q==
Date: Thu, 16 Jan 2025 10:38:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Hans Zhang <18255117159@163.com>, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z4jTeNjl7ddfcQl1@ryzen>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <20250115165842.p7vo24zwjvej2tbc@thinkpad>
 <Z4fq6XU650iOsFZe@ryzen>
 <20250116020300.GE2111792@rocinante>
 <Z4jTEkznMUcApzbe@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4jTEkznMUcApzbe@ryzen>

On Thu, Jan 16, 2025 at 10:36:18AM +0100, Niklas Cassel wrote:
> Hello Krzysztof,
> 
> On Thu, Jan 16, 2025 at 11:03:00AM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> > 
> > > I intended to stay silent, but considering that Mani gave additional
> > > feedback:
> > 
> > I am glad you didn't as feedback is always appreciated. :)
> > 
> > > - The Suggested-by tag should be in patch 1/2, not 2/2 :)
> > >   (Patch 2/2 was 100% you.)
> > 
> > I moved the Suggested-by tag around the correct patch.
> > 
> > Thank you!
> > 
> > 	Krzysztof
> 
> Since you have already applied this series, with my comment fixed up,
> could your perhaps add the following (or similar) to the commit message
> in patch 2/2:
> 
> 
> "
> By changing the type to resource_size_t, which is a typedef to phys_addr_t,
> which can be 64-bit in certain configurations (e.g. X86_PAE selects
> PHYS_ADDR_T_64BIT), even when the compiler is 32-bit. Thus, we also need to
> change the division to do_div(), to properly perform a 64-bit division when
> the compiler is 32-bit.
> "

s/do_div()/div_u64()/


Kind regards,
Niklas

