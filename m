Return-Path: <linux-pci+bounces-21562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA5A3760C
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171F37A2C6C
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2C19CC0C;
	Sun, 16 Feb 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD8s2exV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819219C546;
	Sun, 16 Feb 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724860; cv=none; b=ruaox3UVzWll9LQraNUOst33ywJxvvzyQDBGbfMtJO9vq4jeFMHlJ9714i7vh+VkA+M8J5nPS2mCj9Z1vJufxFh3yQSqjKxmAP4TeJE+kPRtnNRS1rL6AZZrq6XKemvkiJY97D5Z3i2KwKcWKIA+jkAKFfsvtQvm2eVzvjcixss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724860; c=relaxed/simple;
	bh=b1gMtTVrS9kG/tz3DJSz0avx21//+/wqhBYvF9zq1fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXDBj5OWDqaKxCrXQvw+cj5Nn1bYqh1Z/d/ppEmpPJjoAsgJw/n3CEuPX7DreauYaB9r4T2OAcbRv+Nfls7652AGvr+y4hQAeMraWXeIrN/ofNt7ViFiPExpVFoCGE6e4C6Hbj3ddJGbBp3URYPiXmXyIeKDnFzmseIgtFFqr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD8s2exV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF13C4CEE4;
	Sun, 16 Feb 2025 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724859;
	bh=b1gMtTVrS9kG/tz3DJSz0avx21//+/wqhBYvF9zq1fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iD8s2exVQnZGw+vub1rvN5H80vPireFTswP2cXX3QzK3lDkD0aS1cAbqGDepxPnIw
	 eQzm45oLLgWvyuG2ub6l7rQCWLdxjzFdMcMELW25dffiDF9bAOAd15klpgspzi3qmi
	 5RD/YJb9gbyOvhR7GKYGruF6fxVfd6bFNVtejgF4PVKjylyZw289x/7I8o8c1NPOes
	 NnTe+kGH1bcCRs6lmwG38kV56mvtespmUHQDkgFX8Ng5tl4rBg+p/Q7Msoutw727Zh
	 bhshPwDxHWL/+9VuFs/Bly8bho7QTMETty3M2UYv0Yz2B/LrwuZRcS8fkLBPyBSSkT
	 SBmJZDaglNYbQ==
Received: by pali.im (Postfix)
	id E3B6C7FD; Sun, 16 Feb 2025 17:54:06 +0100 (CET)
Date: Sun, 16 Feb 2025 17:54:06 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use for_each_of_range() iterator for parsing
 "ranges"
Message-ID: <20250216165406.jp2dzfwdfucklt5b@pali>
References: <20241107153255.2740610-1-robh@kernel.org>
 <20241115073104.gsgf3xfbv4gg67ut@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115073104.gsgf3xfbv4gg67ut@thinkpad>
User-Agent: NeoMutt/20180716

On Friday 15 November 2024 13:01:04 Manivannan Sadhasivam wrote:
> On Thu, Nov 07, 2024 at 09:32:55AM -0600, Rob Herring (Arm) wrote:
> > The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> > but it's still just normal "ranges" as far as parsing is concerned.
> > Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> > instead of open coding the parsing.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> LGTM!
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Could someone please verify it on mvebu machine?
> 
> - Mani

That is mostly impossible as pci-mvebu is broken. Bjorn and Krzysztof in
past already refused to take patches which would fix the driver or
extend it for other platforms.

So I do not understand why you are rewriting something which worked,
instead of fixing something which is broken. The only point can be to
make driver even more broken...

> > ---
> > Compile tested only.
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 26 +++++++++-----------------
> >  1 file changed, 9 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 29fe09c99e7d..d4e3f1e76f84 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -1179,37 +1179,29 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
> >  			      unsigned int *tgt,
> >  			      unsigned int *attr)
> >  {
> > -	const int na = 3, ns = 2;
> > -	const __be32 *range;
> > -	int rlen, nranges, rangesz, pna, i;
> > +	struct of_range range;
> > +	struct of_range_parser parser;
> >  
> >  	*tgt = -1;
> >  	*attr = -1;
> >  
> > -	range = of_get_property(np, "ranges", &rlen);
> > -	if (!range)
> > +	if (of_pci_range_parser_init(&parser, np))
> >  		return -EINVAL;
> >  
> > -	pna = of_n_addr_cells(np);
> > -	rangesz = pna + na + ns;
> > -	nranges = rlen / sizeof(__be32) / rangesz;
> > -
> > -	for (i = 0; i < nranges; i++, range += rangesz) {
> > -		u32 flags = of_read_number(range, 1);
> > -		u32 slot = of_read_number(range + 1, 1);
> > -		u64 cpuaddr = of_read_number(range + na, pna);
> > +	for_each_of_range(&parser, &range) {
> >  		unsigned long rtype;
> > +		u32 slot = upper_32_bits(range.bus_addr);
> >  
> > -		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
> > +		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
> >  			rtype = IORESOURCE_IO;
> > -		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
> > +		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
> >  			rtype = IORESOURCE_MEM;
> >  		else
> >  			continue;
> >  
> >  		if (slot == PCI_SLOT(devfn) && type == rtype) {
> > -			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
> > -			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
> > +			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
> > +			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
> >  			return 0;
> >  		}
> >  	}
> > -- 
> > 2.45.2
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

