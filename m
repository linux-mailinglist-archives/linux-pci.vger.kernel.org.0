Return-Path: <linux-pci+bounces-23356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E9A5A2B5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09443A6092
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF0233D89;
	Mon, 10 Mar 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQj3H104"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744542309BD;
	Mon, 10 Mar 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630957; cv=none; b=cx/nVWrgoHvcsPSj+f3E2Q/JamrfzSU73wFo9AC93uykyRbhz/ebgUI6S6BX58xRtGDGRRTjwgav35NoQS7OTk/WbfKc+qknrooaEShv4sSViEh9D1wnTFfHX/Rf8mCBPzhJxDWAGvwLdBBc9x9srjq4cuG/7rg3F4p0yFTeMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630957; c=relaxed/simple;
	bh=fognwa1FjofLcfAc8it2UjirQfh9kt0Vts7CK1wQOWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuSHq8dWCrVqtIhXtIenUGMd3WE9kHsG9w2adfT4/q4qzXLlZl0OoLl72fLsD/x+3tDAl0ASW68G2WEo/mfZt4SPTNsG/yzmACGiZqC/SYXdKrHPsqaC/eAqvTFp7YyN32bgPL2KCJBjSf1PyJQMtCtNcR4Iw5cipslBG8/GnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQj3H104; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04594C4CEED;
	Mon, 10 Mar 2025 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741630957;
	bh=fognwa1FjofLcfAc8it2UjirQfh9kt0Vts7CK1wQOWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQj3H104rYmuBRDm/aE9h6GqMYat86OyiEImVZB3C5K2EqfHOdBAgyHynqaLqCCPZ
	 MJiENzw1ahYUauN1oiRfPKorP/iAp7zwthft8PfPYh9p5DH7IOOn9wxsElQ1zOw6uT
	 IZix7when9A1nn/+fEBkdUaopDCYwLWWu0g5kkMuMP380dYBfm/JVsyE8tkys6sJvD
	 FcPx9hi69XM3DOGpzrAQxInbrDbe3Z2oVL/BOPF0bVIZHnYqynDIzY+GsPJp0sS/gi
	 6vqRVKM3oX4gqIFO/B8tlcLhitnb1kpVLPl/didma4hYni1iImmurQEPrSCMgS/PBo
	 uoysoLZxi0t7A==
Date: Mon, 10 Mar 2025 19:22:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:endpoint-test 16/18]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:3: error: field designator
 'intx_capable' does not refer to any field in type 'const struct
 dw_pcie_ep_ops'
Message-ID: <Z88t6TEjFCHDznmb@ryzen>
References: <202503110151.vQXf5yof-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503110151.vQXf5yof-lkp@intel.com>

Hello Krzysztof,

On Tue, Mar 11, 2025 at 02:02:12AM +0800, kernel test robot wrote:
> Hi Niklas,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint-test
> head:   d87a0e7ac55245a3f75ca5c646ffdf0cfa36e749
> commit: da8628c06a7f08cb3402d02040d7a6195949772c [16/18] PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts
> config: s390-randconfig-001-20250311 (https://download.01.org/0day-ci/archive/20250311/202503110151.vQXf5yof-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503110151.vQXf5yof-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503110151.vQXf5yof-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:3: error: field designator 'intx_capable' does not refer to any field in type 'const struct dw_pcie_ep_ops'
>            .intx_capable = false,
>             ^
>    drivers/pci/controller/dwc/pcie-dw-rockchip.c:530:33: warning: shift count >= width of type [-Wshift-count-overflow]
>            dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>                                           ^~~~~~~~~~~~~~~~
>    include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
>    #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>                                                         ^ ~~~
>    1 warning and 1 error generated.
> 
> 
> vim +316 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> 
>    313	
>    314	static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
>    315		.init = rockchip_pcie_ep_init,
>  > 316		.intx_capable = false,
>    317		.raise_irq = rockchip_pcie_raise_irq,
>    318		.get_features = rockchip_pcie_get_features,
>    319	};
>    320	
>

This is not how the patch that I sent out looked like.

See:
https://lore.kernel.org/all/20250310111016.859445-14-cassel@kernel.org/

My guess is that you modified it before applying
(without adding [kwilczynski: ]).
If you undo your modifications, it should compile :)


Kind regards,
Niklas

