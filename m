Return-Path: <linux-pci+bounces-36618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6FCB8F31E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B803AC4A1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F41274B2F;
	Mon, 22 Sep 2025 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrvVXFhD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA0274B2B;
	Mon, 22 Sep 2025 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523868; cv=none; b=dqiB4bCLbQEV6+B8TzNa+o5qZLT6rcRVhFx0Qj8Q1C9gY0fhHpGclFll6wffpq9ndIFeUHREQh6ffPqVLj1Gg1LebWM5MWapZIYWeYUByeRID6963/Xch75YNq7lG+01PLBshjtN6CDYXpmZ1yEFgd0L+2fFPrsHUPOd0NTDALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523868; c=relaxed/simple;
	bh=a1/XvATMLZUTzQRitcGTYy+21H3UJyWGOzhLjbcfokg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzWKXVE8WAJ+dCDmnNq7cTFozTrCKrueW+y0quVy6VG1uguKNSh8pMWtabomxdyfgJ0uzfNQWu+A0Z3m1cOCMcBeDHbcVmH1W6k/soed7oAzaqwZiBO8yCIN2zghPkp3ek116qHC8jBcfz6hwdnIRPFzOYyv6pBkO8layHo64j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrvVXFhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D218C4CEF0;
	Mon, 22 Sep 2025 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758523868;
	bh=a1/XvATMLZUTzQRitcGTYy+21H3UJyWGOzhLjbcfokg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrvVXFhDnJSKlco/4/rpMxNSB2IxcmKjg2z8yGkyJTaADfbV2fbf166jBApRzbVqL
	 jswKMB/lAXHy8TzxK2CC1FDs9zYwHSEV7qxaXC5Bp+tfZyPKP7XVd//OtYRni3ld9A
	 VkIHvmgrFU/N5NDo3d2GYgA/aGhtLo98fudgsHrmr1lQ2tqpqYe3FFeEJrjiMVbqAA
	 eBe14RcT0XVZXPTtXS/eJRNm0f96DuR/Ttr9oWRjHVSHn236pEwNN218gvdyPfMBpV
	 ZMRU2wJ1ChIphP8fxPeKek/UX8fbPOz7VRhEZdukOCY8ckPN4p1PdvC0lkS6SSy4hv
	 D293hrBZEUshg==
Date: Mon, 22 Sep 2025 08:51:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Fix duplicate pll disable
Message-ID: <aNDx15Per942jtCl@ryzen>
References: <20250911093021.1454385-2-cassel@kernel.org>
 <175838274651.17577.4183778050259320426.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175838274651.17577.4183778050259320426.b4-ty@kernel.org>

On Sat, Sep 20, 2025 at 09:10:19PM +0530, Manivannan Sadhasivam wrote:
> 
> On Thu, 11 Sep 2025 11:30:22 +0200, Niklas Cassel wrote:
> > During PERST# assertion tegra_pcie_bpmp_set_pll_state() is currently
> > called twice.
> > 
> > pex_ep_event_pex_rst_assert() should do the opposite of
> > pex_ep_event_pex_rst_deassert(), so it is obvious that the duplicate
> > tegra_pcie_bpmp_set_pll_state() is a mistake, and that the duplicate
> > tegra_pcie_bpmp_set_pll_state() call should instead be a call to
> > tegra_pcie_bpmp_set_ctrl_state().
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: tegra194: Fix duplicate pll disable
>       commit: 3fab9e8102f7f7c5099d69f8e00f478e8795f528
> 
> Note: I've added the Fixes tag a54e19073718, which added the duplicate
> tegra_pcie_bpmp_set_pll_state() call.

Thank you Mani,

However, I don't see 3fab9e8102f7f7c5099d69f8e00f478e8795f528 on any branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/

Did you perhaps forget to push?


Kind regards,
Niklas

