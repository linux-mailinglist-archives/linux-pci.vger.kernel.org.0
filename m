Return-Path: <linux-pci+bounces-25055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F390A777AA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9C188800D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03A1EE7C6;
	Tue,  1 Apr 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaDDO56N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BD1EE02A;
	Tue,  1 Apr 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499563; cv=none; b=e9u9spt1+6BfaMORU3KVmiqZ9uP+sBBDYNJ1rqzX1Eor0iLRWYfwCQ2Gto9F/PHhx4NqmZdqAOAsn30DtpA+yGNYluYKoqJraFWqLx2zj5f+X/Ndf4Bcm8+WLHmkAFrc9KtorGyqJE1PBCNpiwsDfhxPM/gvgTT7re2FmbL+h0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499563; c=relaxed/simple;
	bh=2S6+CIwU99AxyEmYroYUZ2AkN6k++Air0Ian5Ime1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVBukulUF2G5bsmMtrKJtGdVlf9Jkn59M2EhlurFbuDj5gfJyP50Nz17C7cnZfcmJOpIk0YrOtwA2NnrQ2gK7usZAB/z51vyNA88uTKD4HNRedIlHeBWivJOL5soAVY07r+jZo4YrVVqzRNfMGDdSP9mj/9awEwVWwuLV+4rWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaDDO56N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E1C4CEE4;
	Tue,  1 Apr 2025 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499563;
	bh=2S6+CIwU99AxyEmYroYUZ2AkN6k++Air0Ian5Ime1cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaDDO56NFD1sts9/zPJgBbmGP3TM4mGBcx58oTKdw/ouoyDMdwnKBuZ0ZXvPyJHS2
	 gsAr0bTEu2Hrwzyz4xVjVJoOShv3R2xqof48nv4yK1wewlgKznIJgYClaqFu238xJn
	 yLgOLKuB/W7ta0PxpvsY2c+jt1MVTANYQR0ZOUnKXiO4lei/jcrtFO5PlvhhaCZ0RB
	 LGyign0Q70l0ewkvuGa5UZ7AY5VVb8tNwe+KRjqZL6rfgnBt9rrepCUvay0F2QBrdh
	 b6VGMFe1PoDgxpn9OWwZddyOjwCabHoJEn/l96mHm/ilWQqlUynlK8zi5Jnk91uRsV
	 56gl2nQk70JPA==
Date: Tue, 1 Apr 2025 11:25:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, dlemoal@kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: strictly apply bar fixed size to
 allocate space
Message-ID: <Z-uxJKMQFY8eX1iw@ryzen>
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
 <20250328-pci-ep-size-alignment-v1-1-ee5b78b15a9a@baylibre.com>
 <Z-pO_c2zXxDqvIsU@ryzen>
 <1jwmc5tgbe.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jwmc5tgbe.fsf@starbuckisacylon.baylibre.com>

On Mon, Mar 31, 2025 at 04:39:33PM +0200, Jerome Brunet wrote:
> On Mon 31 Mar 2025 at 10:14, Niklas Cassel <cassel@kernel.org> wrote:
> >
> > Perhaps the solution is to add another struct member to struct pci_epf_bar,
> > size (meaning actual BAR size, which will be written to the BAR mask register)
> > and backing_mem_size.
> >
> > Or.. we modify pci_epf_alloc_space() to allocate an aligned size, but the
> > size that we store in (struct pci_epf_bar).size is the unaligned size.
> 
> I tried this and it works. As pointed above, as long as pci_epc_set_bar() is
> happy, it will work for me since the dwc-ep driver does not really care for
> the size given with fixed BARs.
> 
> However, when doing so, it gets a bit trick to properly call
> dma_free_coherent() as we don't have the size actually allocated
> anymore. It is possible to compute it again but it is rather ugly.

You are right.


> 
> It would probably be best to add a parameter indeed, to track the size
> allocated with dma_alloc_coherent(). What about .aligned_size ? Keeping
> .size to track the actual bar size requires less modification I think.

Your problem should be able to be reproducible also for BAR type
BAR_PROGRAMMABLE, when sending in a size smaller than epc_features.align
to pci_epf_alloc_space(), which will then modify epf_bar.size to be aligned.

The call to set_bar() will then use the aligned size instead of the
"BAR size" when writing the BAR mask register, which is wrong.
(This means that the BAR size seen by the host is the aligned size and not
"BAR size".)

So yes, I think having both size and aligned_size (or whatever name) is the
way to go.


Kind regards,
Niklas

