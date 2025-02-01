Return-Path: <linux-pci+bounces-20627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC4A24B29
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49E8164038
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C491C5D78;
	Sat,  1 Feb 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCNTjQzE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE321ADC69
	for <linux-pci@vger.kernel.org>; Sat,  1 Feb 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431548; cv=none; b=C672wDNIUEanJzrs2aHlJzXSO7cjo/OU1L4+g8iRAqftoITxW1RBoU0rbvWm+k3Z8RTDZKSXvRoy1BBuwcn0lxr2/FWcw6z4h9nKye/mKwAloHEt/7cxqEiQ2ghwL6U9kolfLd9aFFG1CwEDBsDvaVdGLqeXY7XpiEgNtVe2tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431548; c=relaxed/simple;
	bh=La1LNffAEjQFoTKt8KvEAMm8pmD3DHSw6reVmRKo1nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKHYxeFLg4nkhXMJw7j21rraHxaaJXPUC6rqjN4Vii/92dpKMdWU9QU3m/7xGAV6/byGHomahTmFlpygFSsgayFAX/9mf2nci/z3LBUkprppxt/SDAR9nuuVCEsyPDLI8MdjOw+60UxBz1nnxqWXXWt/7nLgQ3S5PNWHiS/eEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCNTjQzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC1C4CED3;
	Sat,  1 Feb 2025 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738431547;
	bh=La1LNffAEjQFoTKt8KvEAMm8pmD3DHSw6reVmRKo1nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCNTjQzEmsgMiuJpJy9ZMcl77ksKUMCBqGgVT3yms8WFNMpDFKsnk39f4ThmAH2ai
	 en9YGabfzDZ5s7c0Zb9eG3RYXCMhBxzEwRIiQabe/rxZByc0ptT287DekjJ3tw0iq0
	 NnXgrySyNdkw2VjQme2j2CkjH4LMX0lPV8GHdAY+JTmR0S4w9urNmpiJkE9iLJa8qg
	 WwckDE782/W7I+1hwbHSktSGfNwCm+okEHuREG5baMWcd/SPZhNbgxu0ZzqeCOkwmU
	 KxT0F/YioJTdf3qzUogeGefI0yeLVFuWEbpvEHIwCf2CDWKlPFlR57fxzFpua+JRtp
	 mAW5y33bTiaCg==
Date: Sat, 1 Feb 2025 18:39:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, Frank Li <Frank.li@nxp.com>,
	Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <Z55cNWKi8+9h9rUo@x1-carbon>
References: <20250124093300.3629624-2-cassel@kernel.org>
 <20250201160154.ih7qhpj2ovjtowcu@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201160154.ih7qhpj2ovjtowcu@thinkpad>

On Sat, Feb 01, 2025 at 09:31:54PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 24, 2025 at 10:33:01AM +0100, Niklas Cassel wrote:
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
> > In order to handle 64-bit resource_type_t on 32-bit platforms, we would
> > have needed to use a function like div_u64() or similar. Instead, change
> > the code to use addition instead of division. This avoids the need for
> > div_u64() or similar, while also simplifying the code.
> > 
> 
> Fixes tag?

size has been of type int since:
2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")

But I think a better SHA1 to use as the Fixes tag would be:
cda370ec6d1f ("misc: pci_endpoint_test: Avoid using hard-coded BAR sizes")

Which has the one that started using pci_resource_len()
(while still keeping size as type int).

Perhaps this can be amended while applying?


> 
> > Co-developed-by: Hans Zhang <18255117159@163.com>
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > ---
> > Changes since v1:
> > -Add reason for why division was changed to addition in commit log.
> 
> You removed the history of this patch that was present in v1. Since there is
> no link to v1, you could've kept it here for the sake of completeness.

Yes, because I made the commit log way more verbose, as requested by Frank,
so it now includes references to div_u64() even though we are not using it.


Kind regards,
Niklas

