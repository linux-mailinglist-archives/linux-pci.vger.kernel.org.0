Return-Path: <linux-pci+bounces-20883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB991A2C0C3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 11:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A188E7A10CC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F111547F8;
	Fri,  7 Feb 2025 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0XrUub7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0353A7;
	Fri,  7 Feb 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924895; cv=none; b=MiFhI0kPnfnH/FRfdBxFNN3WYMaSnOmgMx70TCtS3jzZu/8cZLitEFjcMPm/1sPd2ZWhnPk6y5Kj74PHqh2qXdkR8lCZVBuYNXKh/b8rdjpXS0OCML14vJqcb7Ihdx0o8v/CCnQpn0kXMRpR9lZpgC/Ik/30PmXSyieG4AUfk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924895; c=relaxed/simple;
	bh=UzsjoUCqhTOFiLpomAhh9OUmFU4xJr7T+OHaniS6+Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKzW2ULZHgmlvXcESYkSuKP8BCQrSXXx0/iRhXigOKIKLDcXGECh+4jMnCtVJ0kf2ZHtQxA49WwxD5w/Iy9C35TB/siDesjKaLFd0YgUy4tTBUsk8i9HOlieIZsUnNEXSywf9dJtZycd7c8i6gp8aDs1y+T3NCKlvjAxP5qN/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0XrUub7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0917CC4CED1;
	Fri,  7 Feb 2025 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738924893;
	bh=UzsjoUCqhTOFiLpomAhh9OUmFU4xJr7T+OHaniS6+Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0XrUub7ZzUUrFOvSlVSs1xNDC5AFx6d6VmTXMC8qZRuQmLm6jCAns/4Aga4JvE0O
	 09WhXvfwuv5SdTdSaHryWRPh9sGaHjKS+3GbUe/XdkJJnV+PXqSCAI4R+CZQkeWA6D
	 gCZ8aP3U/Z6ho77enkGuwrk5HgMpfymKoPa2HmxYAG/d5YQIkEQoB9KlxfYN6Gbd5z
	 ZPXMB5SACHoCEmf568E/dC9GKli/t/XrtYoDuhMPe9d2FDol24g3GSel6tkUoHgGVd
	 Ay+QA/9QvDeI5Tft4bsM9JGhDgF5Ab7Zw+WxEndJ8hurCZ/i2EOtfRaIBbE4+zKmVm
	 fZlktHlXq416Q==
Date: Fri, 7 Feb 2025 11:41:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Thierry Reding <treding@nvidia.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	quic_schintav@quicinc.com, johan+linaro@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Message-ID: <Z6XjWJd9jm0HHNXW@ryzen>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <Z5jH0G3V7fPXk0BG@ryzen>
 <20250203165932.72kezmi3dtqpytvg@thinkpad>
 <zaj4vcbduaoceaueqq5hvbw5rvoksk5oz6via3jhfp7lyzlxnh@2umxfxphupgd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zaj4vcbduaoceaueqq5hvbw5rvoksk5oz6via3jhfp7lyzlxnh@2umxfxphupgd>

On Tue, Feb 04, 2025 at 06:19:51PM +0100, Thierry Reding wrote:
> On Mon, Feb 03, 2025 at 10:29:32PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 28, 2025 at 01:04:32PM +0100, Niklas Cassel wrote:
> > > Hello Vidya,
> > > 
> > > On Tue, Jan 28, 2025 at 10:12:44AM +0530, Vidya Sagar wrote:
> > > > Add PCIe RC & EP support for Tegra234 Platforms.
> > > 
> > > The commit log does leave quite a few questions unanswered.
> > > 
> > > Since you are just updating the Kconfig and nothing else:
> > > Does the DT binding already have support for the Tegra234 SoC?
> > > Does the driver already have support for the Tegra234 SoC?
> > > 
> > > Looking at the DT binding and driver, the answer to both questions
> > > is yes. (This should have been in the commit message IMO.)
> > > 
> > > 
> > > But that leads me to the question, since there is support for Tegra234
> > > SoC in the driver, does this means that this fixes a regression, e.g.
> > > the Kconfig ARCH_TEGRA_234_SOC was added after the driver support in
> > > this driver was added. In this case, you should have a Fixes: tag that
> > > points to the commit that added ARCH_TEGRA_234_SOC.
> > > 
> > > Or has the the driver support for Tegra234 been "dead-code" since it
> > > was originally added? (Because without this patch, no one can have
> > > tested it, at least not without COMPILE_TEST.)
> > > In this case, you should add:
> > > Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> > > 
> > 
> > TBH, I don't like muddling with Kconfig like this. Ideally, the driver should
> > just depend on ARCH_TEGRA || COMPILE_TEST and the driver should be selected by
> > the relevant defconfig.
> 
> ARCH_TEGRA is a symbol that exists both on 32-bit and 64-bit ARM. This
> driver is completely useless on 32-bit ARM and only used on a very small
> subset of 64-bit ARM devices. It doesn't make sense to be able to enable
> this if you want to build a kernel for say Tegra210.

Well, if you look in drivers/pci/controller/dwc/Kconfig
there are quite a few drivers that does:

depends on ARM64 or ARM and then a ARCH_ something.

I don't see why you can't do
depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST


Kind regards,
Niklas

