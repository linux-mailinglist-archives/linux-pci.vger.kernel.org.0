Return-Path: <linux-pci+bounces-27720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C88AB6C73
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2513BE5E8
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89BC253958;
	Wed, 14 May 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEqGvBMo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21425634;
	Wed, 14 May 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228649; cv=none; b=QfAibU2ilI0rUjf3HVMdhDajFUbPsvUYjVDxjVgDX6RfXTeE0auqnfAkb4ew5umkeRDilH+97xeN45QcUm2F/n2faXogusfEM3NcFSAW4Bkem6N7E/bysMNwQ+ma2QT7Uv9+uxZNjAZ9yrUlAHm96roe/iiaIbP1qvg4akmdt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228649; c=relaxed/simple;
	bh=KFzinwkrWZST4DdJl3OmxHW7o9uuxcvDd9uplO/go4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpKHdhh+Rni/KFxerT7z5x2ClFw/5gsWVIZ83pgmJzP2ri+YFJNx/pd+7GjpIa55lFcVLEUwrfoE2eJnUxowID1nnwgfxkQ/SMo82ZGYtsOkfC0rR2ZQ5zxsj5y47efQ2XNp4gWxDioV4t7pGNjy8/tYCkhykc8SGvTyNFNRolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEqGvBMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941ADC4CEE9;
	Wed, 14 May 2025 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747228649;
	bh=KFzinwkrWZST4DdJl3OmxHW7o9uuxcvDd9uplO/go4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEqGvBMoNykYxGNJSXD9vR5z0l0q2fW1trWACbkiWAHafySTV+R5+n57+MxH8Pq4+
	 VqvdH8iaM0QiFADry9ZtL8QLTSVBb4AU7RKNeUEHLTtFV7s+YO+yrUaOdlor6i7kkd
	 2UupwgZgUGfDk9O/CGsUFk1MWZ/VTSzmQG2N6nZQ9ukACVIkoowDlFKtCO2Kpx3TXG
	 ViPu+mvZz13IbpiRZ73ZPW76tlpUdv/UZkUboL/ATTSZnfpmd7M2VZJinfdbJ8plT6
	 3YtolpnndTyDERs69HpOdFFeBXLkIjTmvrclshXYs1CJMd534AaU7wvrpn4mJXfO/6
	 ym0iWcA2fqz5Q==
Date: Wed, 14 May 2025 14:17:26 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <aCSX5gKsehupIC35@vaman>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
 <174722268141.85510.14696275121588719556.b4-ty@kernel.org>
 <aCSUfiwnZRTgMKGT@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCSUfiwnZRTgMKGT@ryzen>

On 14-05-25, 15:02, Niklas Cassel wrote:
> Hello Vinod, Krzysztof,
> 
> On Wed, May 14, 2025 at 12:38:01PM +0100, Vinod Koul wrote:
> > 
> > On Thu, 08 May 2025 10:49:22 +0530, Vidya Sagar wrote:
> > > Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> > > check for the Tegra194 PCIe controller, allowing it to be built on
> > > Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> > > by requiring ARM64 or COMPILE_TEST.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [1/1] PCI: dwc: tegra194: Broaden architecture dependency
> >       (no commit info)
> > [1/1] phy: tegra: p2u: Broaden architecture dependency
> >       commit: 0c22287319741b4e7c7beaedac1f14fbe01a03b9
> > 
> > Best regards,
> > -- 
> 
> I see that Vinod has queued patch 1/2.
> 
> Please don't forget that this series requires coordination.
> 
> There are many ways to solve it.
> 
> 1) One tree takes both patches.
> 
> 2) PHY tree puts the PHY patch on an immutable branch with just that
> commit, and PCI merges that branch, so the same SHA1 of the PHY patch
> is in both trees.
> 
> 3) Send PHY patch for the upcoming merge window. Send PCI patch for
> merge window + 1.

1, 3 works for me, for 2 pls let me know, I need to prep a branch with
this patch and tag on it...

BR

-- 
~Vinod

