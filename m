Return-Path: <linux-pci+bounces-36632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBDB8F6CB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216451899342
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBF22FCBE1;
	Mon, 22 Sep 2025 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOo5j+10"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25083271443;
	Mon, 22 Sep 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528713; cv=none; b=uWbd+jxZnejpwiA2nFg/V+2UPUBq3gfw9jN0DmbAAxVly39kdvid8IHpZ2/8BFhlyl3hrAZVDxOLVN0SYMTybPCknufObuKSnFuHkEFDgMRFbV2LbDhena+z1N0e1aZVsoCNa0raUCzrTdAN5FUH0Rz7gclBs868t5AmVnQyfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528713; c=relaxed/simple;
	bh=TFieXeSqQwXU9xmQy2/1hV6npdIzsqQ6YQ0YtM/MueU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYzqcgtkLZsUg55f4P/s4q8Dx5THxURN2gq+ToYbhdELs2BlRz5RVCpOr7XWSNKESIruObo824b0ot9FSDK3RPKzJhh7H/cVOZAGgON3pVMEmQEUYgF2zjw/oTGoAX34+CIquP7vuQjUkcC5TDMHXQRml8HGKsdVIrhdoqqVicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOo5j+10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED9CC4CEF0;
	Mon, 22 Sep 2025 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758528712;
	bh=TFieXeSqQwXU9xmQy2/1hV6npdIzsqQ6YQ0YtM/MueU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOo5j+10d7jYRRyzQQo+wcy25aDso/CM3eBPfO0274Tj85majiw9W9Tl8kci8I/9h
	 oQ51/IaKWf1R4171BPRKursLmxBry70PapJsHmuZDpNLUNxk8lchOV7XjQ+FHI9K0W
	 QHnXZg6lVCthGDygMbiUzduALvzOuYqepcnwX+utI3RUCuKu/PWsFLfD4NO+AAAK9D
	 Ilakr3oVxz7IjZaL/UJitm41Gf4imAU/cAOmBiPyXsvGfcHJqoW8knMdcftX/K6ji8
	 OUM5mDwCaBdCcKngqzz5j+WoV3sEDEczSW+tb0rzHO3ezS5psrgbq0tZiQr+EW/u/q
	 y/is5x78XeVkQ==
Date: Mon, 22 Sep 2025 13:41:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Nagarjuna Kristam <nkristam@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Fix duplicate pll disable
Message-ID: <ssqy4itquuw3h45eugh6usnsysuwohzrlr2gutktje5ijgf62h@v2donlzrbyo7>
References: <20250911093021.1454385-2-cassel@kernel.org>
 <175838274651.17577.4183778050259320426.b4-ty@kernel.org>
 <aNDx15Per942jtCl@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNDx15Per942jtCl@ryzen>

On Mon, Sep 22, 2025 at 08:51:03AM +0200, Niklas Cassel wrote:
> On Sat, Sep 20, 2025 at 09:10:19PM +0530, Manivannan Sadhasivam wrote:
> > 
> > On Thu, 11 Sep 2025 11:30:22 +0200, Niklas Cassel wrote:
> > > During PERST# assertion tegra_pcie_bpmp_set_pll_state() is currently
> > > called twice.
> > > 
> > > pex_ep_event_pex_rst_assert() should do the opposite of
> > > pex_ep_event_pex_rst_deassert(), so it is obvious that the duplicate
> > > tegra_pcie_bpmp_set_pll_state() is a mistake, and that the duplicate
> > > tegra_pcie_bpmp_set_pll_state() call should instead be a call to
> > > tegra_pcie_bpmp_set_ctrl_state().
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] PCI: tegra194: Fix duplicate pll disable
> >       commit: 3fab9e8102f7f7c5099d69f8e00f478e8795f528
> > 
> > Note: I've added the Fixes tag a54e19073718, which added the duplicate
> > tegra_pcie_bpmp_set_pll_state() call.
> 
> Thank you Mani,
> 
> However, I don't see 3fab9e8102f7f7c5099d69f8e00f478e8795f528 on any branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/
> 
> Did you perhaps forget to push?
> 

Sorry, yes. Pushed now!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

