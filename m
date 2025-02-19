Return-Path: <linux-pci+bounces-21825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7382A3C6E4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9949A165C48
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35514B092;
	Wed, 19 Feb 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7OPUOA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077301D554
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988058; cv=none; b=HmisfzSrcnrhm7y7j7JzAQTIGLjhvt9Pe9JiJnDwsiEYqlAugUqHl/U61IpTP1sO4MhCUu6+yT23qlFC84jqc5RNnwQduIfixsJvtCSPSGEVxmWc9L7whP+OCYDOOuZihbjnySW4bOQstyQ4ZP8I3lc0+14W2fKqGBTUcb9GjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988058; c=relaxed/simple;
	bh=10ugBIMWWecRCfAep3sGGxgeI0M1ddYl0HmhIv357cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAzHzQyhTUBZu7ckjD3+1BDJlq2NjcTgr4aUE2yqUNWquapYdeyQ8k/j9gqyAg1Kp5jd3Ig50NL3xQCOTkW7TYiwXYmzgRE31Xw1kd8dzT17n8tqPaYasM1jSARh7kNCF1qE+U7qAf1pn8GoWG12QglNas64s+Gt8/4C9Bu6Mb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7OPUOA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61880C4CED1;
	Wed, 19 Feb 2025 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988057;
	bh=10ugBIMWWecRCfAep3sGGxgeI0M1ddYl0HmhIv357cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7OPUOA7U0GPV/BsHMhWSbUVR3ybX3fGkzsHrsS1uWeGUVKC19y9gJS8+QnadyZ1c
	 ex/FY9uHx/dCgGwkIzo0CvNoZqASbRdJQDVCZ8PY3b6mu4s677QrEOAbN8RUGNSdll
	 myCvCuWia294AqT+nIhw5glI5STfmrCIBMAyC2B+KJfZP2lQNXmVuBu3DHDUWvnm1X
	 qB1NFhzWVxKbW0bfLlDIxjGVGpUyNEeJPWKUe3Dp5y7UjXXNCxkAoVAHa4dKVKHSBW
	 DJCjSnbZgPNwaSB1WC2jM0Gux68uPcRLLnua3ZXjx9yJd1DTCczKR3udfuKOCu+GVm
	 UW60CiLl1qLqg==
Date: Wed, 19 Feb 2025 19:00:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/7] PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
Message-ID: <Z7YcVEa95ulOh81p@ryzen>
References: <Z7YTukXh-Y3_HQsb@ryzen>
 <20250219174927.GA224883@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219174927.GA224883@bhelgaas>

On Wed, Feb 19, 2025 at 11:49:27AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 19, 2025 at 06:24:10PM +0100, Niklas Cassel wrote:
> > On Tue, Feb 18, 2025 at 10:48:04AM -0600, Bjorn Helgaas wrote:
> > > On Fri, Jan 31, 2025 at 07:29:51PM +0100, Niklas Cassel wrote:
> > > > Add a helper function to convert a size to the representation used by the
> > > > Resizable BAR Capability Register.
> > > 
> > > > +/**
> > > > + * pci_epc_bar_size_to_rebar_cap() - convert a size to the representation used
> > > > + *				     by the Resizable BAR Capability Register
> > > > + * @size: the size to convert
> > > > + * @cap: where to store the result
> > > > + *
> > > > + * Returns 0 on success and a negative error code in case of error.
> > > > + */
> > > > +int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
> > > > +{
> > > > +	/*
> > > > +	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
> > > > +	 * thus disallow a requested BAR size smaller than 1 MB.
> > > > +	 * Disallow a requested BAR size larger than 128 TB.
> > > > +	 */
> > > > +	if (size < SZ_1M || (u64)size > (SZ_128G * 1024))
> > > > +		return -EINVAL;
> > > > +
> > > > +	*cap = ilog2(size) - ilog2(SZ_1M);
> > > > +
> > > > +	/* Sizes in REBAR_CAP start at BIT(4). */
> > > > +	*cap = BIT(*cap + 4);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_epc_bar_size_to_rebar_cap);
> > > 
> > > This doesn't seem specific to EPC.  It looks basically similar to
> > > pci_rebar_bytes_to_size().  Can we consolidate anything there?
> > 
> > This function is to convert a size to
> > "Resizable BAR Capability Register", which includes one or more supported
> > BAR sizes.
> > 
> > This register should only ever by written by a PCI endpoint function,
> > so I think its current home in drivers/pci/endpoint/ is correct.
> > 
> > pci_rebar_bytes_to_size() is used to convert a size to
> > "Resizable BAR Control Register", specifically the field
> > "BAR Size".
> > 
> > This "BAR Size" field in the "Resizable BAR Control Register" can be
> > written by the host side (or endpoint side), to select one of the
> > supported bar sizes. So I think it makes sense for
> > pci_rebar_bytes_to_size() to live in pci.h.
> 
> Thanks, I agree.
> 
> It looks like pci_epc_bar_size_to_rebar_cap() is only called once per
> BAR.  Does that mean an endpoint driver can only set a single
> supported size for a Resizable BAR in the Capability register?

Yes, that is the current design.

(Which is an improvement to before this series was merged, where a Resizable
BAR had to be forced to 1 MB size, so EPF drivers could not configure a size
larger/different than 1 MB.)



It is possible to allow the endpoint framework to allow multiple Resizable
BAR sizes to be supported in the future.

On e.g. rk3588, the EP gets an IRQ when the host side writes the "BAR Size"
field in the "Resizable BAR Control Register".

So one can image that the drivers could call some function in the EPC
framework that allocates + copies + frees new backing memory for the BARs.

But right now, I don't have a need for such a use-case, so let's defer that
until someone actually wants/needs that, since it will undoubtedly also add
more code complexity to the EPC framework.


Kind regards,
Niklas

