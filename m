Return-Path: <linux-pci+bounces-17282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B79D88FB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FA4160562
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC761922E9;
	Mon, 25 Nov 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntn6jglT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0E171CD
	for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547829; cv=none; b=e4FWHRhXHomgw1kVXGVLOlGcecO50ym52kAi7pAEvnjwih2Jc9786lNWnyqQqN43sEsP82o66UxZSl0AbmSQa610QCpAfJ3ZMBteEiAN24+6KDikmbFfGqIS+mN5rY266BIMe4qfcNE1lreqF9zS17rsaCt7b4/vu4ZG/DSmatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547829; c=relaxed/simple;
	bh=ktorktRMv8jR2fHxc55YWIWwrlg4exPf4cYte3IPkQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgOMXZZk/8ug+k6/m0iaLX9OxmK41GuzvKlBqiE+g6vM2jl/Iwd+W0w82GgizbTBNuho7//0H0ohQyWz7pE0oSvVHibxab5OdFJOmSwIJh/65Rt3YozSAFRv3qvzXpFZyMYnn/dnDU1d8vMS0AwhiytEKfcSPxwBGiJw3DLnClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntn6jglT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B4EC4CECE;
	Mon, 25 Nov 2024 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732547828;
	bh=ktorktRMv8jR2fHxc55YWIWwrlg4exPf4cYte3IPkQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntn6jglTNcNVabvacS1eibTqMhugn/sx6xGAuxY2sXLuSeXlva//iSKggG8e3DIOF
	 a27KeETbvGFIlcYmJ0Hsk/PCi6iVGMXNQu23bHwBJ74lvTUzo7ozYtI8bmP5Pputyb
	 nNuvJbNrkTm+zJNQ/geJ9dpR/jhh7U1NY70D4YNjWpndI3AfF43OC0nMehi5FnAtrz
	 9jVo1kCznYbcwQHEtx1bwvUds+OM/6IGOzC/JQ/leCblS3CcUmuxqbNLGCcUT8NsSp
	 etnmP5YO8KaBstUNdChpo32zfnWe4Zo4mMra9nxC+itXGWx7W6d2qrIcAT567Lm1Pn
	 2PyMtqXu3O4+Q==
Date: Mon, 25 Nov 2024 16:17:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] misc: pci_endpoint_test: Add support for
 capabilities
Message-ID: <Z0SU8EpsTcYXqKJ_@ryzen>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-6-cassel@kernel.org>
 <Zz+NV312ESzPdp/a@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz+NV312ESzPdp/a@lizhi-Precision-Tower-5810>

On Thu, Nov 21, 2024 at 02:43:19PM -0500, Frank Li wrote:
> On Thu, Nov 21, 2024 at 04:23:21PM +0100, Niklas Cassel wrote:
> > The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> > which allocates the backing memory using dma_alloc_coherent(), which will
> > return zeroed memory regardless of __GFP_ZERO was set or not.
> >
> > This means that running a new version of pci-endpoint-test.c (host side)
> > with an old version of pci-epf-test.c (EP side) will not see any
> > capabilities being set (as intended), so this is backwards compatible.
> >
> > Additionally, the EP side always allocates at least 128 bytes for the test
> > BAR (excluding the MSI-X table), this means that adding another register at
> > offset 0x30 is still within the 128 available bytes.
> >
> > For now, we only add the CAP_UNALIGNED_ACCESS capability.
> >
> > If CAP_UNALIGNED_ACCESS is set, that means that the EP side supports
> > reading/writing to an address without any alignment requirements.
> >
> > Thus, if CAP_UNALIGNED_ACCESS is set, make sure that the host side does
> > not add any extra padding to the buffers that we allocate (which was only
> > done in order to get the buffers to satisfy certain alignment requirements
> > by the endpoint controller).
> >
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> I think 4byte align for readl/writel still required?

I've been running this series on rk3588 (which has CAP_UNALIGNED_ACCESS set),
so alignment will be set to 0 in pci_endpoint_test_{copy,read,write}().
When running:
pcitest -r -s 1
pcitest -r -s 2
pcitest -r -s 3
pcitest -r -s 4

many, many times, and dma_alloc_coherent() always returned an address that
was 4 byte aligned, regardless of input size.


Additionally, when setting alignment to 0, the code in
pci_endpoint_test_{copy,read,write}() will behave exactly as it did before
the "alignment support" was added in commit:
https://github.com/torvalds/linux/commit/13107c60681f19fec25af93de86442ac9373e43f


So I think this patch is good as is.


Kind regards,
Niklas

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> > ---
> >  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >

