Return-Path: <linux-pci+bounces-20880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41CDA2C0A3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E8B164497
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703118C928;
	Fri,  7 Feb 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAYVs5gW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AB53A7;
	Fri,  7 Feb 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924378; cv=none; b=i9M7UMu13iY5+4nvugVSJI8CjfYkDpyPtELSUM+gRtwSqyh0+lC4aIZkBmXxvuh/wbg54G+ZrYSY+l1C6xDTemW0XQqtlj5dYLiZGEz1ZXpTdxeWpc8t3r161WpH3y6DU7J68gWuN33xVEWqf3i5lb+LwHn813rz25ryGDbxRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924378; c=relaxed/simple;
	bh=zdWxKqYjZfyoIgV2YKrQ+0zFB86K9e1Lh6bziXQAoJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHHK4C9H02FNmeBoVd5GjJDSE42ptwO0xPVywuXeeP2dsQ0bRUUue/gzmrmCbwjMDrW+PrN8uDrzz+588+xJcHDGHWbrATE1NLVLInvAHR/9HIEL7KTBrzxi3K1hlUT6KVL5130CsimkQ57GF2cAbM5LJpVJggKkMGOnT1OeatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAYVs5gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ABFC4CED6;
	Fri,  7 Feb 2025 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738924377;
	bh=zdWxKqYjZfyoIgV2YKrQ+0zFB86K9e1Lh6bziXQAoJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAYVs5gWARMKTOfVwLqbB+DX+g+205nfM0FI9VbwlkSrhVGzln+ifKo4/ztXrbtDF
	 MvSQg/5pwcMo6EoSU8dPtDKJUj5f33bGZpAxmD7VaZVdHmTPd6/tOeCls+TeYpBKYk
	 GAa7aLT+8SBmCfrUo7KhalS5MrbW0a8s4dpkV8tkXLo0QODZ8cvx+ori/HMW+EIO69
	 jIxwkbcVTrtsZ6+f5abjIC9df2gy0pc5yPPEwRFWR/aAj+kwiCcim8E8f8J2VYN5mj
	 NOJ/QHvOL/nLQlA/WjGca6yyxGsb0rkQ2q3BncwyvgcvHlsoMY2IBP9lEonLUUPvVr
	 TsA0elBp/96Tw==
Date: Fri, 7 Feb 2025 11:32:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Thierry Reding <treding@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, quic_schintav@quicinc.com,
	johan+linaro@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Message-ID: <Z6XhVL_OckIOnqvV@ryzen>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <Z5jH0G3V7fPXk0BG@ryzen>
 <2xhy6gvpxczcqlchddfti6ymjlsa6fl3xzgxps5644u5w5f3u2@ywudmcu42i4s>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2xhy6gvpxczcqlchddfti6ymjlsa6fl3xzgxps5644u5w5f3u2@ywudmcu42i4s>

On Tue, Feb 04, 2025 at 06:12:56PM +0100, Thierry Reding wrote:
> On Tue, Jan 28, 2025 at 01:04:32PM +0100, Niklas Cassel wrote:
> > Hello Vidya,
> > 
> > On Tue, Jan 28, 2025 at 10:12:44AM +0530, Vidya Sagar wrote:
> > > Add PCIe RC & EP support for Tegra234 Platforms.
> > 
> > The commit log does leave quite a few questions unanswered.
> > 
> > Since you are just updating the Kconfig and nothing else:
> > Does the DT binding already have support for the Tegra234 SoC?
> > Does the driver already have support for the Tegra234 SoC?
> > 
> > Looking at the DT binding and driver, the answer to both questions
> > is yes. (This should have been in the commit message IMO.)
> > 
> > 
> > But that leads me to the question, since there is support for Tegra234
> > SoC in the driver, does this means that this fixes a regression, e.g.
> > the Kconfig ARCH_TEGRA_234_SOC was added after the driver support in
> > this driver was added. In this case, you should have a Fixes: tag that
> > points to the commit that added ARCH_TEGRA_234_SOC.
> > 
> > Or has the the driver support for Tegra234 been "dead-code" since it
> > was originally added? (Because without this patch, no one can have
> > tested it, at least not without COMPILE_TEST.)
> > In this case, you should add:
> > Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> 
> Typically we build the default configuration with some custom options
> (like everyone else, I assume) and usually in those configurations both
> Tegra194 and Tegra234 support will be enabled, so the code ends up
> enabled in most cases. I guess the commit message doesn't do a very good
> job of making this clear. Really what this commit does is enable the PCI
> controller driver for Tegra234-only configurations (i.e. no other Tegra
> generations are built-in).

Ok, fine by me.


> 
> Not sure about the Fixes: tag since this is fairly harmless. Worst case
> you'll need to enable Tegra194 support along with Tegra234 in order to
> be able to enable this driver, but that's almost always the case anyway.

I think it is quite a fundamental mistake that the commit that added
support for Tegra234, actually requires you to enabled support for a
completely different SoC to actually make use of that driver, so IMO
the Fixes tag is absolutely warrented.


Kind regards,
Niklas



