Return-Path: <linux-pci+bounces-44128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA2CFB3DD
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 23:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9097304DDB8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 22:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91392DC78D;
	Tue,  6 Jan 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPNMYEgJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40F270540;
	Tue,  6 Jan 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737934; cv=none; b=UQAiT6AVH1ogAaE2QTTa6OCeqEDWgTYg1Aqsq5qn44OqDavr8azeD0W6KWre4+T1i3zrBemhtBRT86V9VBE06NfTcZCcHFfNWVNFcNy1ITmo9SIJC1hrffLZ/bv+UlPMWrmk1hAFnJjmoJHbnqww4xaVNbvh2/cCGQOnJxuLQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737934; c=relaxed/simple;
	bh=E0aWy+uUfCNMGGslLrShR+QevIrPR+ipsxdLL6EH+vo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qFZXCq98GzDfCmHyVpWm+C+yrUfnCPxILxuKy/aETOw0T1i+DTo35EKawPxLVkcRqy96KUJ8PechVBBt4kLODtv2Y7KAyYUqOmmxo42OIDYPAGsS1K7Gh5D36HOswMCxQcrnJX1j2GrrZNWhPbx0zfN41P7GDYXQvvWV33YglS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPNMYEgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CEAC19421;
	Tue,  6 Jan 2026 22:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737934;
	bh=E0aWy+uUfCNMGGslLrShR+QevIrPR+ipsxdLL6EH+vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gPNMYEgJfX0u5gGNhuKiEwC51LNyHV431aYLu1NqTvfcW/K1j0C36x2Tmg1JHIrRh
	 ooccH4ml0DL8eh506xVerwQuicUg8oMaIhVPp1bF7LO5l7nTmNZhP0x1ch6tEjUG3z
	 j1yz+w0FpqMwT97FTG1DcATumgYS9FeC+XcHUsyRXRVhaqt5Ra80O7sWWEg0UnL1th
	 hVnt1vwAcgE6ewePjcbgFZsVpqIL5V7bdhjBB8A26Cp18OP/iGG9Xd1kIfQobR3QOz
	 FQi9t54FZAIwWE0hTiKd0A62mShq1D7xmmfDljUTxyBu52h3ZJFMRIAjCYh75PUwm4
	 C9BhFz0cl13+w==
Date: Tue, 6 Jan 2026 16:18:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add missing struct p2pdma_provider
 documentation
Message-ID: <20260106221852.GA381083@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104-fix-p2p-kdoc-v1-1-6d181233f8bc@nvidia.com>

On Sun, Jan 04, 2026 at 02:51:28PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Two fields in struct p2pdma_provider were not documented, which resulted
> in the following kernel-doc warning:
> 
>   Warning: include/linux/pci-p2pdma.h:26 struct member 'owner' not described in 'p2pdma_provider'
>   Warning: include/linux/pci-p2pdma.h:26 struct member 'bus_offset' not described in 'p2pdma_provider'
> 
> Repro:
> 
>   $ scripts/kernel-doc -none include/linux/pci-p2pdma.h
> 
> Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the core logic")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/all/20260102234033.GA246107@bhelgaas
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied to pci/misc for v6.20, thanks!

Alex, let me know if you'd rather take this (you merged f58ef9d1d135).

> ---
>  include/linux/pci-p2pdma.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 517e121d2598..873de20a2247 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -20,6 +20,8 @@ struct scatterlist;
>   * struct p2pdma_provider
>   *
>   * A p2pdma provider is a range of MMIO address space available to the CPU.
> + * @owner: Device to which this provider belongs.
> + * @bus_offset: Bus offset for p2p communication.
>   */
>  struct p2pdma_provider {
>  	struct device *owner;
> 
> ---
> base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
> change-id: 20260104-fix-p2p-kdoc-3f503e6d6a55
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 

