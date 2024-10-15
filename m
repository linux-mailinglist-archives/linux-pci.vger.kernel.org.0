Return-Path: <linux-pci+bounces-14531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3199E206
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045BC1C22EC9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B001E25F1;
	Tue, 15 Oct 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDxGIjCk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7A1E1C1A
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982940; cv=none; b=UudmrElwrThGY25Sf3+j1GSx1cXFxjQIBVXCfrUznV1H2arN+z7MW8GsZ4lSyETSuPlsxiOrlTrSqNjegUTbRjJyiPnacKHiwK8UNkQJPk/elrwl4SjBTEDtyu1UK1IkE5tzkyPYf1Vgkf1VMyQ/VSe8ksbKchjduJqViEKO6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982940; c=relaxed/simple;
	bh=5pO/Dxe5UTH5His3g4E+9eyJRWMGhH7cc/yU2jrRDD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaLBYWJGB/PQCy4upAYicE5bDEykrv1FO0b3s9vBlwAPAjGiRwBs5VwYTSng4z4pc0DURrsvgrAH2XCv74OqFd4vZcDC1vcJJ0JU+dbqyw1Lc5Yf10vv0Pq1vDoBn13ArU9S27S1IPff/qmPDgX8+QrD9LAByBiLx3xU0jtdgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDxGIjCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236E0C4AF09;
	Tue, 15 Oct 2024 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728982938;
	bh=5pO/Dxe5UTH5His3g4E+9eyJRWMGhH7cc/yU2jrRDD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDxGIjCkjGlRZ6EDfYaemUnYEOC4JpArhd7UCBP9g8G55g3zvcxYSkf+a6pnrPT/L
	 JthOCQh58fVeuX8lPO4A3FojgQYTv4NAQNeb5iwQJ3Z4P7EkggpiThRPgCaR2NURUF
	 sDTM0PTJatyBoXHCaNbzpmfQZDI95ahP2aa+a3Xyl9O3riaBovWm4f0F+v1Xj7EKOZ
	 F2ZCk327L0Q0Xt0ZOGKVnMVF6Hoqz8oXwXrGzd5yfkfvRfF9rbmFSdD2Ls86J8OmdW
	 de3VRpZt9mqM5jaLSInoIycGOkXaPEpve1g10TRmOXybzCvBU0HU80F+8bSt6oQ0jn
	 oEb5jkBcRE3DA==
Date: Tue, 15 Oct 2024 11:02:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Improve pci_epc_ops::align_addr()
 interface
Message-ID: <Zw4vPeM8sFwOGlLy@ryzen.lan>
References: <20241015064718.111952-1-dlemoal@kernel.org>
 <Zw4YkSVpbRVA5KEr@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4YkSVpbRVA5KEr@ryzen.lan>

On Tue, Oct 15, 2024 at 09:24:01AM +0200, Niklas Cassel wrote:
> 3) The problem with using u64 is that it will be 64-bit even on 32-bit
> systems.
> 
> Looking at:
> https://github.com/torvalds/linux/blob/master/Documentation/core-api/dma-api-howto.rst#cpu-and-dma-addresses
> and
> https://github.com/torvalds/linux/blob/master/include/linux/pci.h#L820-L824
> 
> makes me think that dma_addr_t is a better choice than u64 in this case.
> 
> pci_bus_addr_t is probably an even better choice, but it doesn't seem
> to be used outside drivers/pci/ core code, and it is simply defined to
> have the same size as dma_addr_t (CONFIG_ARCH_DMA_ADDR_T_64BIT) anyway.

Since:
int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
                     phys_addr_t phys_addr, u64 pci_addr, size_t size)

Currently uses u64 for the pci address, I guess keeping this new API to
use u64 for the pci address is the most consistent thing after all...

Although ideally, sometime in the future someone should probably convert
both APIs to use pci_bus_addr_t or dma_addr_t instead.


Kind regards,
Niklas

