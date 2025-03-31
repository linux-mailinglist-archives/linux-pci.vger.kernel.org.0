Return-Path: <linux-pci+bounces-24997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B57A7611B
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2143166A36
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2711D54E3;
	Mon, 31 Mar 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG0w5F5F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A51D6DB5;
	Mon, 31 Mar 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408900; cv=none; b=jkRNHETwNeeHRSbFv/AHAbnL7gv4aZJCbdSWb3ZNleWwDBjd+EOoM0TZXyhrrv0F8QeFzd+DRyjqCNIGCVyW8tSCsNMxKK8bFLp3wQ34A6++HVEEiLEQlbSKyRe6suLnQt169oYz6ysCy2R796V2u7Qs2Gzei2YrxHbZLgK5Npc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408900; c=relaxed/simple;
	bh=XjyVzl74+jrKX0O0T7NTmStcxYaO1IpfPs7SA2e466o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl5EhiMPOvRtAgLFcx4B6W5sJbOSoQj0tqgaimRJvgqE1hv21lG2LvF/8P4ZEMTR4IkmOK7pq/m8lKaGCfE0T1SnEraNtIirooK6eHLWqUlyNMDx5Zp2UgXmgH+oLuqELz69WX9qbORJJFMAn4QKUeFgG5yGSEQbbyVsBZJsHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG0w5F5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4FBC4CEE3;
	Mon, 31 Mar 2025 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743408898;
	bh=XjyVzl74+jrKX0O0T7NTmStcxYaO1IpfPs7SA2e466o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MG0w5F5FVw4PjrkuzT6GTQoxAwhdzlHzDZw9jLKAvZ5ztVvaCVTKmDNA/5cco7VjE
	 3kCqOVMkSk0PJ7eU7sHasPLUVqgm2dbfMj4U2p11ggCfv5ioGGefSzuAx5jp0K0kpY
	 HVldTwr8YQpa8O1zlMA0W2muMnhjFDAVFI5Sww1b7kujuPhUFsacQxd3IHGlyLl3Wm
	 fxiH/SCywQuXw9JKqxZJv9m3ah/BW1ksdfy/8JPZDfD0ddbVpi/X1pJnBpIbxnqBOL
	 yKG6LZrvIB9uCOr8T1h3fzM1zkDpzP4CxIs27m3NgLJcG6j/Nh+/vzBWMrVym6f7D8
	 smX9r1hxAooUg==
Date: Mon, 31 Mar 2025 10:14:53 +0200
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
Message-ID: <Z-pO_c2zXxDqvIsU@ryzen>
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
 <20250328-pci-ep-size-alignment-v1-1-ee5b78b15a9a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328-pci-ep-size-alignment-v1-1-ee5b78b15a9a@baylibre.com>

Hello Jerome,

On Fri, Mar 28, 2025 at 03:53:42PM +0100, Jerome Brunet wrote:
> When trying to allocate space for an endpoint function on a BAR with a
> fixed size, that size should be used regardless of the alignment.

Why?


> 
> Some controller may have specified an alignment, but do have a BAR with a
> fixed size smaller that alignment. In such case, pci_epf_alloc_space()
> tries to allocate a space that matches the alignment and it won't work.

Could you please elaborate "won't work".


> 
> When the BAR size is fixed, pci_epf_alloc_space() should not deviate
> from this fixed size.

I think that this commit is wrong.

In your specific SoC:
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
 	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_1M,

fixed_size is 256B, inbound iATU alignment is 1 MB, which means that the
smallest area that the iATU can map is 1 MB.

I do think that it makes sense to have backing memory for the whole area
that the iATU will have mapped.


The reason why the the ALIGN() is done, is so that the size sent in to
dma_alloc_coherent() will return addresses that are aligned to the inbound
iATU alignment requirement.


I guess the problem is that your driver has a fixed size BAR that is smaller
than the inbound iATU alignment requirement, something that has never been a
problem before, because no SoC has previously defined such a fixed size BAR.

I doubt the problem is allocating such a BAR, so where is it you actually
encounter a problem? My guess is in .set_bar().

Perhaps the solution is to add another struct member to struct pci_epf_bar,
size (meaning actual BAR size, which will be written to the BAR mask register)
and backing_mem_size.

Or.. we modify pci_epf_alloc_space() to allocate an aligned size, but the
size that we store in (struct pci_epf_bar).size is the unaligned size.


Kind regards,
Niklas

