Return-Path: <linux-pci+bounces-36665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FBEB914AF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761FB18A3402
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007573093A1;
	Mon, 22 Sep 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRDXREnB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5EC120;
	Mon, 22 Sep 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546422; cv=none; b=gZOsLHtODPjAURDaxYQvtESoVh/3x8rH/x1T/kEbv8J/RkVi5ATc9E9U0A9X7/d8GD1adJvLC7iFxCTayaKSP2xdOWUVUsXcM5V45bynmID1TQD/VV8c5MhuavnU6cDxg5R94KEEBltZ5J0uiLUDQiIj+FQnKGujhxdPU5WhQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546422; c=relaxed/simple;
	bh=QlB7iaLuNmzpqov5+EmFBdLMmExbbO8Dc8q4KaNtWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up69eHuwuuS+BwAk4SrLbqmjHVRSZdtHFvHdLE2JWsxtqjaBDBUMTxk30hrOcDe08f8cjhdSHnSzWejeT1+4GjcLPvm62NaA3Ycaene0qwd0mwJGEmmeLDIPjnl+13F3ibEfI+a1oM8jax1w+oQWimZ5kj1e7WQDdFToFD7FLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRDXREnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0887C4CEF0;
	Mon, 22 Sep 2025 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546422;
	bh=QlB7iaLuNmzpqov5+EmFBdLMmExbbO8Dc8q4KaNtWxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRDXREnBhidZmeb3oH2IuXgwMi/iPolSA1tr3cTy7dvqPTi1nt2ALcXaah0EWPHF0
	 kncJWLOvIBYVstqkicF0xTYMdbZgVieuJJ/ceeh7kyLFey/EClEkngG+JR06a1E7Aa
	 BxTJhduNl9is1g7HSwYzYBMz4S5FmI2/V5neAHygDbes7jGyJh4/+INk9vtvO6U6R6
	 4pTOuumG1ilTpVuWcqWZ4HXPfHNXprQ0u3OEhwSH2UG/0a7y6zjrNOHwdfOQ/KPOA8
	 gDX4nFl/XrPwjWkvyugG9LoEqL00Y3IMqzAhhrHY4+102WL/DIOKpjLoswFWEYO0Mz
	 mD9P0QfDPdp7Q==
Date: Mon, 22 Sep 2025 15:06:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Reset BARs when running in PCIe endpoint
 mode
Message-ID: <aNFJ8awYYwxb2o6B@ryzen>
References: <20250919131646.167330-2-cassel@kernel.org>
 <lrox3l5cafqsom3eier6n7wpbfatlic42rxs5q5utrhg4fekls@kj3b5ue7ggt7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrox3l5cafqsom3eier6n7wpbfatlic42rxs5q5utrhg4fekls@kj3b5ue7ggt7>

On Sat, Sep 20, 2025 at 09:04:01PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Sep 19, 2025 at 03:16:47PM +0200, Niklas Cassel wrote:
> > Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
> > This is sufficient for pci-epf-test to not allocate backing memory and to
> > not call set_bar() for those BARs.
> > 
> > However, the host side driver, pci_endpoint_test, simply does an ioremap
> > for all enabled BARs, and will run tests against all enabled BARs.
> > 
> > After running the BARs tests (which will write to all enabled BARs), the
> > inbound address translation is broken.
> > This is because the tegra controller exposes the ATU Port Logic Structure
> > in BAR4. So when BAR4 is written, the inbound address translation settings
> > get overwritten.
> > 
> 
> BAR4 or BAR0?

BAR4.
Just because a BAR is marked as BAR_RESERVED does not mean that the BAR is
disabled. Hence this patch.
I can make this clearer in V2.

I think a better solution would be for pci-epf-test to actually do something
like call a .disable_bar() for BARs that are marked as BAR_RESERVED.

But, implementing this callback is non-trivial, especially for non-DWC based
drivers where we dont have an equivalent to dw_pcie_ep_reset_bar().
Thus, I chose to keep with the existing convention of calling
dw_pcie_ep_reset_bar() in the .init callback, like it is done for all other
DWC-based EPC drivers.


Kind regards,
Niklas

