Return-Path: <linux-pci+bounces-21812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA270A3C61A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE86178260
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760E20E6F9;
	Wed, 19 Feb 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4/lLtIf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D1286284
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985855; cv=none; b=HNONaCfzXZy4qiZHNN0EhzrK1UUN+Sz1+/aeDJG9VQ4/wT9dWJOBOLlju/QEAkknjws3OiMeSmTxVQdhby3P0yRtk248ICTNsyHl0OPHnQ7zdtF2bkO4X0gMctzIKmwBMbXaTvM300O5x7GCHJROOdM4EYFDqZAi8tMHen/SYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985855; c=relaxed/simple;
	bh=ehT4bDmbB5Nt3ela1o6M1jnWYW8gPGdmPUFoGLVJU94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chPH4bXao5Z03C6wqwx9Qqr38O3J96dZ4GnvzKWTAL9+139xd8nBoME4QcFdjOlOANqMzyyYZPyh5HjDGazwpz+57CpOUvLKa9RRvaVQ1cUK5XxWS3QMC64yV30JBzM4PiYX6juGL+TL/BSAR1hhoEmeY2fGixNoSquM4Kz6tg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4/lLtIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F71C4CED1;
	Wed, 19 Feb 2025 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985855;
	bh=ehT4bDmbB5Nt3ela1o6M1jnWYW8gPGdmPUFoGLVJU94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4/lLtIfpySoCpBvYa2lEgHqp/3+y566vy1W1IoFI62K4eI5bW1zhAQIeMfwnm4N+
	 C6RAEgBmePu1Y2njhtavBaAWNKbQ+pYZtz7uhPjruZJwRkSmDeWp+SarqJcpD+eCQi
	 7YBbMNZ4OzJjEb28hz75fq65fOntlpmu6flZ9aIYaZSLt+DnRDhZ2rbv+cBCVGY84g
	 G22X2bgtWWO8IGdu+P6lw2UYdFrODRjY3xyzkdDahfAlfrNlFj89g25siLGqkA1A9L
	 MS1NG0n6AmbYYkpyRxC0uSoxawYw4rEEWleU/GSqqhTJEiTFG6f0fVNG6qMeH08+Je
	 HOSxbEW0vj9iw==
Date: Wed, 19 Feb 2025 18:24:10 +0100
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
Message-ID: <Z7YTukXh-Y3_HQsb@ryzen>
References: <20250131182949.465530-11-cassel@kernel.org>
 <20250218164804.GA181151@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218164804.GA181151@bhelgaas>

On Tue, Feb 18, 2025 at 10:48:04AM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 31, 2025 at 07:29:51PM +0100, Niklas Cassel wrote:
> > Add a helper function to convert a size to the representation used by the
> > Resizable BAR Capability Register.
> 
> > +/**
> > + * pci_epc_bar_size_to_rebar_cap() - convert a size to the representation used
> > + *				     by the Resizable BAR Capability Register
> > + * @size: the size to convert
> > + * @cap: where to store the result
> > + *
> > + * Returns 0 on success and a negative error code in case of error.
> > + */
> > +int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
> > +{
> > +	/*
> > +	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
> > +	 * thus disallow a requested BAR size smaller than 1 MB.
> > +	 * Disallow a requested BAR size larger than 128 TB.
> > +	 */
> > +	if (size < SZ_1M || (u64)size > (SZ_128G * 1024))
> > +		return -EINVAL;
> > +
> > +	*cap = ilog2(size) - ilog2(SZ_1M);
> > +
> > +	/* Sizes in REBAR_CAP start at BIT(4). */
> > +	*cap = BIT(*cap + 4);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_bar_size_to_rebar_cap);
> 
> This doesn't seem specific to EPC.  It looks basically similar to
> pci_rebar_bytes_to_size().  Can we consolidate anything there?

This function is to convert a size to
"Resizable BAR Capability Register", which includes one or more supported
BAR sizes.

This register should only ever by written by a PCI endpoint function,
so I think its current home in drivers/pci/endpoint/ is correct.


pci_rebar_bytes_to_size() is used to convert a size to
"Resizable BAR Control Register", specifically the field
"BAR Size".

This "BAR Size" field in the "Resizable BAR Control Register" can be
written by the host side (or endpoint side), to select one of the
supported bar sizes. So I think it makes sense for
pci_rebar_bytes_to_size() to live in pci.h.


> 
> Since we're basing this on the spec, we should include a complete
> citation, e.g., PCIe r6.0, sec xxx.

I agree:
https://lore.kernel.org/linux-pci/20250219171454.2903059-2-cassel@kernel.org/T/#u


Kind regards,
Niklas

