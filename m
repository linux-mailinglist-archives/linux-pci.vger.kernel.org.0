Return-Path: <linux-pci+bounces-28734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC3AC978A
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 00:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1AE9E1AA8
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 22:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B4827AC25;
	Fri, 30 May 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKwZd9ly"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CD230D1E;
	Fri, 30 May 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748642677; cv=none; b=HC0wHdBkRckWkTCsWHNUIXFBsNKJJDZ+c1o2K/r1CweVaH/xjUtq7KwMYRd+gwXumLzrqeRvb5pr5ZbchIq7URrmWrSos4OMbKlsfJ+JCtAAQW7zKadwvqFSIb1jCCpV/qdxkRV3J9rHqrYtpYZLURxwyKZc1UU5mMH8kKfpUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748642677; c=relaxed/simple;
	bh=wVEqYeIheJTsExh0y+ny/dya1Ge9pSIKZyHUPQ3jebc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qAvHuiI026Orw5OLCXnqMYBptaCAYF8nmg2g0mxXnIB0YxyapP3Ewd4n+eXm0gqKhXmp8jHeI6V5pNf6AJBnGlSZ5HRt51MOrBXFzrUBTJYoM1FPFtkZzdzxHsaPVJCQbJgwztAp+fU2ULMuATSK9+gpJAheP/CP4gu9PYseag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKwZd9ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FBDC4CEE9;
	Fri, 30 May 2025 22:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748642676;
	bh=wVEqYeIheJTsExh0y+ny/dya1Ge9pSIKZyHUPQ3jebc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rKwZd9lyPdPEM8MP7oUfj2hnyU3L4/w8QAG9hWnnPROC7M/2pv0SM0FNRhk9ys+DF
	 piY/m+S3ai4rReTaOh3ktqD0anAJtDoBJitNQ2d06eUqOUSZNHtYKKDgjh+a+syYwc
	 u/WcKYyLpZuIr4RCeTeSQ7yetoQx1FF19Zxug9cAbrDR5JtBZUTo5poys8SQA0eAKC
	 LmQ/erALu33vZOXOUAHRmyFi3mx8+bSw7qIHXbR99I2zpuf/tjtzpsAKpAhh2SuS0p
	 Yip7iVtHzgOhTHoSisx7V7iWYY/t18cjRPGDkK/FUXiKdQzBGd5hHQXvnoXHLLUgD0
	 cTCSLafdf/REQ==
Date: Fri, 30 May 2025 17:04:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Niklas Cassel <cassel@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Hans Zhang <18255117159@163.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [pci:controller/dw-rockchip 2/3]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:227:9: error:
 'PCIE_T_PVPERL_MS' undeclared; did you mean 'PCIE_ATU_TYPE_MSG'?
Message-ID: <20250530220433.GA239797@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202505310520.ElO2YbM3-lkp@intel.com>

On Sat, May 31, 2025 at 05:29:09AM +0800, kernel test robot wrote:
> Hi Niklas,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dw-rockchip
> head:   a47c73d6a884edf2a8b09015596744a495c6a236
> commit: 56825f5946a0da29658fa8e768c8706dffdac82b [2/3] PCI: dw-rockchip: Replace PERST# sleep time with proper macro
> config: arm-randconfig-003-20250531 (https://download.01.org/0day-ci/archive/20250531/202505310520.ElO2YbM3-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250531/202505310520.ElO2YbM3-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505310520.ElO2YbM3-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/controller/dwc/pcie-dw-rockchip.c: In function 'rockchip_pcie_start_link':
> >> drivers/pci/controller/dwc/pcie-dw-rockchip.c:227:9: error: 'PCIE_T_PVPERL_MS' undeclared (first use in this function); did you mean 'PCIE_ATU_TYPE_MSG'?
>      msleep(PCIE_T_PVPERL_MS);
>             ^~~~~~~~~~~~~~~~
>             PCIE_ATU_TYPE_MSG
>    drivers/pci/controller/dwc/pcie-dw-rockchip.c:227:9: note: each undeclared identifier is reported only once for each function it appears in
> 

My fault, I added

  #include "../../pci.h"

which was previously added by "PCI: dw-rockchip: Do not enumerate bus
before endpoint devices are ready" patch, which I dropped while we
figure out where to put the delay.

> vim +227 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> 
>    208	
>    209	static int rockchip_pcie_start_link(struct dw_pcie *pci)
>    210	{
>    211		struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>    212	
>    213		/* Reset device */
>    214		gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>    215	
>    216		rockchip_pcie_enable_ltssm(rockchip);
>    217	
>    218		/*
>    219		 * PCIe requires the refclk to be stable for 100µs prior to releasing
>    220		 * PERST. See table 2-4 in section 2.6.2 AC Specifications of the PCI
>    221		 * Express Card Electromechanical Specification, 1.1. However, we don't
>    222		 * know if the refclk is coming from RC's PHY or external OSC. If it's
>    223		 * from RC, so enabling LTSSM is the just right place to release #PERST.
>    224		 * We need more extra time as before, rather than setting just
>    225		 * 100us as we don't know how long should the device need to reset.
>    226		 */
>  > 227		msleep(PCIE_T_PVPERL_MS);
>    228		gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
>    229	
>    230		return 0;
>    231	}
>    232	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

