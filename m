Return-Path: <linux-pci+bounces-21820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D9DA3C6A7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B30317A430
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D63126BFA;
	Wed, 19 Feb 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJEjH+5r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4F192580
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987370; cv=none; b=k2mJQHUnFu/SNLuhXB2p/UVirAxe0p7hfUn1ikdX0Jzvb+BUWRXu4As/BtKWOUKRMYi+8LiFS2DSYba8ogxk850KriklXIPXnfTdxXx08MO2pX8cNAiQonXM69vb2moNnyabr9WwNzrwKO/kgvqEsCrmK6UsK6iRgbUzWNpWQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987370; c=relaxed/simple;
	bh=P8Nnwwa1SauVAgIv1aZOpywLjjiAcMxdV3wj4p42fDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uwsDh9jDba9e3H7gZ+bUWSwyJ48jviT7DGydADi11miJWbIxWXbrXwb92JBsPYv4oEiqcLkO8bvRGDyjOslEtnIObJKkfgqEZR9OUDUil5HnqT7dniTUfKBv7NcUzOuolBrXvCLMWUqnpMto3IERtQZM5PG0r18ot3KJOLmHvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJEjH+5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51AAC4CED1;
	Wed, 19 Feb 2025 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987370;
	bh=P8Nnwwa1SauVAgIv1aZOpywLjjiAcMxdV3wj4p42fDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZJEjH+5r/CXKwix0312XLpAEbQvo7TYfoNISpXf5MOx3/XUncviU6X4JPyedbeeuU
	 G5fNCJJr6foB4YebycZcKLT7a9dAhi8J1iDaY0RDX+8nPtjBENT6BgLpJwOw5XxH6w
	 usB/uGrPkG71D92icdkhwVcRb3DCLZ/acu1J6RRu5gyDzYp1Y6RmvwOc1s/o2R0fbf
	 A15p9giNTZ7fzzVSIYpDRLEIjdzCN+g+A+nWzMmvnoBgu6p81RmtdmV1A61nTwyYAD
	 YsBYLYfV8LHAIJovr809ANjBmkQ9NessAHnGdSyj0Qm74Bi8Uk3poHsARNzS/ketdd
	 bjbt0yerL5YGQ==
Date: Wed, 19 Feb 2025 11:49:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/7] PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
Message-ID: <20250219174927.GA224883@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7YTukXh-Y3_HQsb@ryzen>

On Wed, Feb 19, 2025 at 06:24:10PM +0100, Niklas Cassel wrote:
> On Tue, Feb 18, 2025 at 10:48:04AM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 31, 2025 at 07:29:51PM +0100, Niklas Cassel wrote:
> > > Add a helper function to convert a size to the representation used by the
> > > Resizable BAR Capability Register.
> > 
> > > +/**
> > > + * pci_epc_bar_size_to_rebar_cap() - convert a size to the representation used
> > > + *				     by the Resizable BAR Capability Register
> > > + * @size: the size to convert
> > > + * @cap: where to store the result
> > > + *
> > > + * Returns 0 on success and a negative error code in case of error.
> > > + */
> > > +int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
> > > +{
> > > +	/*
> > > +	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
> > > +	 * thus disallow a requested BAR size smaller than 1 MB.
> > > +	 * Disallow a requested BAR size larger than 128 TB.
> > > +	 */
> > > +	if (size < SZ_1M || (u64)size > (SZ_128G * 1024))
> > > +		return -EINVAL;
> > > +
> > > +	*cap = ilog2(size) - ilog2(SZ_1M);
> > > +
> > > +	/* Sizes in REBAR_CAP start at BIT(4). */
> > > +	*cap = BIT(*cap + 4);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_bar_size_to_rebar_cap);
> > 
> > This doesn't seem specific to EPC.  It looks basically similar to
> > pci_rebar_bytes_to_size().  Can we consolidate anything there?
> 
> This function is to convert a size to
> "Resizable BAR Capability Register", which includes one or more supported
> BAR sizes.
> 
> This register should only ever by written by a PCI endpoint function,
> so I think its current home in drivers/pci/endpoint/ is correct.
> 
> pci_rebar_bytes_to_size() is used to convert a size to
> "Resizable BAR Control Register", specifically the field
> "BAR Size".
> 
> This "BAR Size" field in the "Resizable BAR Control Register" can be
> written by the host side (or endpoint side), to select one of the
> supported bar sizes. So I think it makes sense for
> pci_rebar_bytes_to_size() to live in pci.h.

Thanks, I agree.

It looks like pci_epc_bar_size_to_rebar_cap() is only called once per
BAR.  Does that mean an endpoint driver can only set a single
supported size for a Resizable BAR in the Capability register?

Bjorn

