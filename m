Return-Path: <linux-pci+bounces-9357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB0791A193
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70AE1C22458
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF913A3F6;
	Thu, 27 Jun 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fspg5BEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BA7BB14;
	Thu, 27 Jun 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477209; cv=none; b=Fh4JG3TRruALFN6IUnLdQeain2b/55um5jYBfJjggI4VVhomNSVqskBW2GUpf2JhmNhlTR2l3AGJpSkP0NEwP1XjAlf4Lb3ZDzH456xvKU2jnW4CaElh+0D4Ol7sVbzVYE0hyID7w3gf3obqnbmX2ffnX7DF5ZfB175NvEKBv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477209; c=relaxed/simple;
	bh=Pi4LKlzc/7YwEBuJLXtj6NR3Kr9eYb1JNmen4IQ5Bi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgEBkLSP0tvmqVMM5yZWwI8piSJww65Fkl7kLzLtGdHYWAtkUBc7JgLzF6cVTTfj09zzZjRA549KaWeCrMleMn+fzh10nDcOK1iCXV6ww67OQfY8qO5xHZ8KP2PLr+ZhWjdJ7R+36OqfUObI7JaOxHuc421axD/Plg2ckpvhku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fspg5BEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72470C2BBFC;
	Thu, 27 Jun 2024 08:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719477208;
	bh=Pi4LKlzc/7YwEBuJLXtj6NR3Kr9eYb1JNmen4IQ5Bi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fspg5BEj6Xorw6NIDyTtodUt+PvMNTpiF5Ts/WB9ie/3pY1SmyyV6qeDnMCoWTjxo
	 5hwBVKq0r+N3nOVL9S8Y/dnQ4dD633g2zqNLnVv/zOCvC8jAf0fdeHrviw6oPRUqUj
	 /fzpX0mCNWVtDmJdu7Hq0GEVUHssMvPT48i4GQOuv19/pB3WXrWy8LzGcbcgys8H+M
	 IbwN9XXWjuv70aaGvg5HuFIrqeS1Umoe8vEKE1Ip7PodxcIRInSZ0Vzx1JBXKzZZHC
	 Hbg2YkU6Bu4DERnQ9nJprrSR+XwsNzNL2P0mHAOobJIGoqgAOOL5Lt1UraRTMbwvwp
	 qyALbDXn69sZg==
Date: Thu, 27 Jun 2024 10:33:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/rockchip 11/11]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:491:undefined reference to
 `pci_epc_init_notify'
Message-ID: <Zn0j1LrkLELW0fO1@ryzen.lan>
References: <202406270721.a8SQi2hn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406270721.a8SQi2hn-lkp@intel.com>

On Thu, Jun 27, 2024 at 07:54:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
> head:   246afbe0f6fca433d8d918b740719170b1b082cc
> commit: 246afbe0f6fca433d8d918b740719170b1b082cc [11/11] PCI: dw-rockchip: Use pci_epc_init_notify() directly
> config: loongarch-randconfig-r081-20240626 (https://download.01.org/0day-ci/archive/20240627/202406270721.a8SQi2hn-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270721.a8SQi2hn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406270721.a8SQi2hn-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init_notify':
>    drivers/pci/controller/dwc/pcie-designware-ep.c:26:(.text+0x1e4): undefined reference to `pci_epc_init_notify'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_deinit':
>    drivers/pci/controller/dwc/pcie-designware-ep.c:640:(.text+0x83c): undefined reference to `pci_epc_mem_free_addr'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:643:(.text+0x854): undefined reference to `pci_epc_mem_exit'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_linkup':
>    drivers/pci/controller/dwc/pcie-designware-ep.c:811:(.text+0x924): undefined reference to `pci_epc_linkup'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_linkdown':
>    drivers/pci/controller/dwc/pcie-designware-ep.c:836:(.text+0x964): undefined reference to `pci_epc_linkdown'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init':
>    drivers/pci/controller/dwc/pcie-designware-ep.c:875:(.text+0xe90): undefined reference to `__devm_pci_epc_create'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:888:(.text+0xf20): undefined reference to `pci_epc_mem_init'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:895:(.text+0xf54): undefined reference to `pci_epc_mem_alloc_addr'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:906:(.text+0xf74): undefined reference to `pci_epc_mem_exit'
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-dw-rockchip.o: in function `rockchip_pcie_configure_ep':
> >> drivers/pci/controller/dwc/pcie-dw-rockchip.c:491:(.text+0x7cc): undefined reference to `pci_epc_init_notify'

Hello Krzysztof,

This is the same problem that the kernel test robot previously reported,
and is fixed by:
https://lore.kernel.org/linux-pci/20240626191325.4074794-2-cassel@kernel.org/



Like I wrote in the other kernel test robot report, depending on .config,
we could also see another build error if we don't have:
7a847796e509 ("PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers")
(from the pci/endpoint branch).

You have also previously cherry-picked:
3d2e425263e2 ("PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event")
(from the pci/controller/dwc branch) which we also depend on.


Perhaps the smartest thing right now is to just recreate the
pci/controller/rockchip branch, by:
1) reset the rockchip branch to v6.10-rc1
2) merge the pci/controller/dwc branch to the rockchip branch
3) merge the pci/endpoint branch to to the rockchip branch
4) pick all the patches that are currently on the pci/controller/rockchip
5) squash: 246afbe0f6fc ("PCI: dw-rockchip: Use pci_epc_init_notify() directly")
   into the commit that adds dw-rockchip endpoint mode support
   (9b2ba393b3a6 ("PCI: dw-rockchip: Add endpoint mode support"))
6) squash: https://lore.kernel.org/linux-pci/20240626191325.4074794-2-cassel@kernel.org/
   into the commit that adds dw-rockchip endpoint mode support
   (9b2ba393b3a6 ("PCI: dw-rockchip: Add endpoint mode support"))


This way:
- All commits will build as individual patches, so no build errors from the
  test robot (even when it builds a patch that is in the middle (e.g. 10/11)).
- Even if futher commits are applied to pci/controller/dwc or pci/endpoint,
  we will not depend on any newly applied patches to these branches, so there
  will be no need to "re-merge" the branches to the rockchip branch.


Kind regards,
Niklas

