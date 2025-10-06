Return-Path: <linux-pci+bounces-37605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD6BBDBCC
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E624B3A48DB
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A48620A5C4;
	Mon,  6 Oct 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8Y8FSAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989C246BB8;
	Mon,  6 Oct 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747437; cv=none; b=CQPfH1bpor1tQGHD2ZoLkoR1/yl27mYHF8+mmT6KiiB0o7ymuXZDykxWDWUSqkldePKRAwTdL6Ve5Z9agELOdBLz27P4NVxlQT37LXYMTihtu47dagSC0N1ipgzARTUx+sR+CAbOZhZsjWaNNR0WVa/VdGCLcXPgY16GBho9otM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747437; c=relaxed/simple;
	bh=l/o/ZdfQ6BEWu7LeBwywJyRN51NFnbNzGbCL+Oqum2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/RNUIkIC7AxXX8dRtZd5ciUoXK5xH6wVmNUqaWqUiAsOUmGUFn3+ulue8lQhK5J3v707Yh+o53z2R9bfOjxF5h1Al4kU2CBco6yj8ha5aLemWjPgqBrBblvNHCQu37qXVz50Bxt0+ZcFUQmDrZdtLVQNgipg8EFRBuDMkjEYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8Y8FSAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0775C4CEF5;
	Mon,  6 Oct 2025 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759747437;
	bh=l/o/ZdfQ6BEWu7LeBwywJyRN51NFnbNzGbCL+Oqum2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8Y8FSAqROWRUvcLBdssNUqfYa/b3x64jbUT1nsUHDOZjlH3UTKodH8tpDn495E6D
	 v0lSMi82cRwq8bjjbL4ZxkIjZyzQUlI+gh12enavejj7VUsIHi0/MXQ2u4iKQp+TEy
	 iG0m98/UaznH0xFeIJYNCYCbyspwq+euUSvvUr7yWI+y5eVSEptJxnNb6gZweVlcem
	 UfWAd4dftS4L/wPR3wvGWG/jOeoLEySEnciwm3TEY0JB+AfztJCpOnEtDg+d29ULuH
	 KiwBKNDe/PQQG6kyIf4woNMhZljB2qoVNerK50tlwlyN9Cm9/+W/Jh4f4A0vVdK3LR
	 XtvToTw5U48eg==
Date: Mon, 6 Oct 2025 12:43:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <aOOdaDdxCAkmGbkd@ryzen>
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
 <20250930-vntb_msi_doorbell-v4-1-ea2c94c6ff2e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-vntb_msi_doorbell-v4-1-ea2c94c6ff2e@nxp.com>

On Tue, Sep 30, 2025 at 04:39:37PM -0400, Frank Li wrote:
> Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> size and memory size. Prepare for adding support to set an MMIO address to
> a specific BAR.
> 
> Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
> confuse.

'aligned_bar_size' has been renamed, so this sentence should be updated.


(snip)

> @@ -308,7 +327,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	}
>  
>  	dev = epc->dev.parent;
> -	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
> +
> +	space = dma_alloc_coherent(dev, aligned_mem_size,
> +				   &phys_addr, GFP_KERNEL);
>  	if (!space) {
>  		dev_err(dev, "failed to allocate mem space\n");
>  		return NULL;
> @@ -317,7 +338,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	epf_bar[bar].phys_addr = phys_addr;
>  	epf_bar[bar].addr = space;
>  	epf_bar[bar].size = size;
> -	epf_bar[bar].aligned_size = aligned_size;
> +	epf_bar[bar].aligned_size = aligned_mem_size;

I like that this local variable is now named aligned_mem_size
to more clearly highlight that it is the aligned _memory_ size.

Perhaps you could also rename the struct pci_epf_bar struct member
'aligned_size' to 'aligned_mem_size' or perhaps even better,
'backing_mem_size' or 'mem_size' ?


Kind regards,
Niklas

