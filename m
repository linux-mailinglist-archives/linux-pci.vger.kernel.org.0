Return-Path: <linux-pci+bounces-29518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4BAD66E3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 06:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A1617DC9D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 04:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2231DF751;
	Thu, 12 Jun 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPsP4oBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE051A0BC5;
	Thu, 12 Jun 2025 04:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749703455; cv=none; b=oiZwQE3S2wadec27hNS6a2BUbyS4lMJFzAyLhnuhdFyvzB3Cb2jHS9D7wXcTAMtcnWT1+Gtc2Ot2x5DnMvEfJE8zcFeIhYdHqlzjYtPk17r0amFcfvDnHnVTfwRl1t8T6qGMWIsdhncSL4zwRTHl3hqw/kOcwqvDLzSReIQYUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749703455; c=relaxed/simple;
	bh=c20JGxz7owIFFjbCtgNQck0/Y7pf2TfNDqzUWz5yELc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEMi4b65BqsK6Jo9zWeA0ylKV5zpNKRAsFhTw8fG/8Z2nnw7ZHZUDFB71V23lR51VBCc3V1EzsFSitQRsSS5HD1NxxHAVURzJ3otAxRIXaQ85hgNP+5FkTpMpM+yLPkG31CDczva4lg0ZGgOWrA9qMyK3SDtiWZa6B+RuAchvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPsP4oBI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749703455; x=1781239455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c20JGxz7owIFFjbCtgNQck0/Y7pf2TfNDqzUWz5yELc=;
  b=lPsP4oBI1QVkzsf+ZvpvksoDYlHRfFFAEa/bcKCdL5w0xpggWVVYFQSD
   lEUyRy0xKDj4kaSr+hWvD5AMNYt+puU/4Se1m3g71HbJHu9nJyB71Vy6y
   X5uzFcsNNjeoU3nznlmwygeSSeQyfeiPGHZPbYv3rZ+Biu6nciIEx33LD
   CiHGBvFvomuC0WTRBNNR7TiQIXB+lFwIqMyxp8z2VxtJJKgrjtMmz60Ih
   n93oWxIWO4I97BOWlT/poDYIZnn8RdeByN91vGo9qCuCqBP7zSnkNhwo0
   mfWX4qQ+ANbMXr0vDm7UPVqousm16N3gjLsI3ItL8GdxTEUs4EkNWDSqL
   A==;
X-CSE-ConnectionGUID: wN4ns6cTR6i8X4OFPBzX9w==
X-CSE-MsgGUID: hy9LurcNSZCVSSgt7YbYrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51743331"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51743331"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 21:44:14 -0700
X-CSE-ConnectionGUID: PLVjGx2jTj6VuZEHKkszLA==
X-CSE-MsgGUID: 8S8jNBq5SB+0xh04LEbIjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="147390370"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Jun 2025 21:44:11 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPZnM-000B86-38;
	Thu, 12 Jun 2025 04:44:08 +0000
Date: Thu, 12 Jun 2025 12:43:29 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com, mani@kernel.org, kwilczynski@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH 13/13] PCI: dwc: Refactor tegra194 to use
 dw_pcie_clear_and_set_dword()
Message-ID: <202506121258.qVeeEKfy-lkp@intel.com>
References: <20250611163227.861403-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611163227.861403-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.16-rc1 next-20250611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-dwc-Refactor-dwc-to-use-dw_pcie_clear_and_set_dword/20250612-003548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250611163227.861403-1-18255117159%40163.com
patch subject: [PATCH 13/13] PCI: dwc: Refactor tegra194 to use dw_pcie_clear_and_set_dword()
config: x86_64-buildonly-randconfig-003-20250612 (https://download.01.org/0day-ci/archive/20250612/202506121258.qVeeEKfy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250612/202506121258.qVeeEKfy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506121258.qVeeEKfy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-tegra194.c: In function 'tegra_pcie_dw_host_init':
>> drivers/pci/controller/dwc/pcie-tegra194.c:884:13: warning: unused variable 'val' [-Wunused-variable]
     884 |         u32 val;
         |             ^~~


vim +/val +884 drivers/pci/controller/dwc/pcie-tegra194.c

56e15a238d9278 Vidya Sagar   2019-08-13  879  
64451ac83fe6ab Bjorn Helgaas 2022-08-04  880  static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
56e15a238d9278 Vidya Sagar   2019-08-13  881  {
56e15a238d9278 Vidya Sagar   2019-08-13  882  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
f1ab409d578752 Vidya Sagar   2022-07-21  883  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
56e15a238d9278 Vidya Sagar   2019-08-13 @884  	u32 val;
56e15a238d9278 Vidya Sagar   2019-08-13  885  
275e88b06a277c Rob Herring   2020-12-18  886  	pp->bridge->ops = &tegra_pci_ops;
275e88b06a277c Rob Herring   2020-12-18  887  
369b868f4a2ef8 Vidya Sagar   2020-11-26  888  	if (!pcie->pcie_cap_base)
369b868f4a2ef8 Vidya Sagar   2020-11-26  889  		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
369b868f4a2ef8 Vidya Sagar   2020-11-26  890  							      PCI_CAP_ID_EXP);
369b868f4a2ef8 Vidya Sagar   2020-11-26  891  
9891c2a48c49a9 Hans Zhang    2025-06-12  892  	dw_pcie_clear_and_set_dword(pci, PCI_IO_BASE,
9891c2a48c49a9 Hans Zhang    2025-06-12  893  				    IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8, 0);
56e15a238d9278 Vidya Sagar   2019-08-13  894  
9891c2a48c49a9 Hans Zhang    2025-06-12  895  	dw_pcie_clear_and_set_dword(pci, PCI_PREF_MEMORY_BASE, 0,
9891c2a48c49a9 Hans Zhang    2025-06-12  896  				    CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE |
9891c2a48c49a9 Hans Zhang    2025-06-12  897  				    CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE);
56e15a238d9278 Vidya Sagar   2019-08-13  898  
56e15a238d9278 Vidya Sagar   2019-08-13  899  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
56e15a238d9278 Vidya Sagar   2019-08-13  900  
87f10faf166a91 Bjorn Helgaas 2024-08-27  901  	/* Enable as 0xFFFF0001 response for RRS */
9891c2a48c49a9 Hans Zhang    2025-06-12  902  	dw_pcie_clear_and_set_dword(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT,
9891c2a48c49a9 Hans Zhang    2025-06-12  903  				    AMBA_ERROR_RESPONSE_RRS_MASK << AMBA_ERROR_RESPONSE_RRS_SHIFT,
9891c2a48c49a9 Hans Zhang    2025-06-12  904  				    AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001 <<
87f10faf166a91 Bjorn Helgaas 2024-08-27  905  				    AMBA_ERROR_RESPONSE_RRS_SHIFT);
56e15a238d9278 Vidya Sagar   2019-08-13  906  
a54e190737181c Vidya Sagar   2022-07-21  907  	/* Clear Slot Clock Configuration bit if SRNS configuration */
9891c2a48c49a9 Hans Zhang    2025-06-12  908  	if (pcie->enable_srns)
9891c2a48c49a9 Hans Zhang    2025-06-12  909  		dw_pcie_clear_and_set_dword(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
9891c2a48c49a9 Hans Zhang    2025-06-12  910  					    PCI_EXP_LNKSTA_SLC, 0);
a54e190737181c Vidya Sagar   2022-07-21  911  
56e15a238d9278 Vidya Sagar   2019-08-13  912  	config_gen3_gen4_eq_presets(pcie);
56e15a238d9278 Vidya Sagar   2019-08-13  913  
56e15a238d9278 Vidya Sagar   2019-08-13  914  	init_host_aspm(pcie);
56e15a238d9278 Vidya Sagar   2019-08-13  915  
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  916  	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  917  	if (!pcie->supports_clkreq) {
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  918  		disable_aspm_l11(pcie);
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  919  		disable_aspm_l12(pcie);
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  920  	}
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  921  
9891c2a48c49a9 Hans Zhang    2025-06-12  922  	if (!pcie->of_data->has_l1ss_exit_fix)
9891c2a48c49a9 Hans Zhang    2025-06-12  923  		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
9891c2a48c49a9 Hans Zhang    2025-06-12  924  					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
56e15a238d9278 Vidya Sagar   2019-08-13  925  
9891c2a48c49a9 Hans Zhang    2025-06-12  926  	if (pcie->update_fc_fixup)
9891c2a48c49a9 Hans Zhang    2025-06-12  927  		dw_pcie_clear_and_set_dword(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
9891c2a48c49a9 Hans Zhang    2025-06-12  928  					    0, 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT);
56e15a238d9278 Vidya Sagar   2019-08-13  929  
56e15a238d9278 Vidya Sagar   2019-08-13  930  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
56e15a238d9278 Vidya Sagar   2019-08-13  931  
275e88b06a277c Rob Herring   2020-12-18  932  	return 0;
275e88b06a277c Rob Herring   2020-12-18  933  }
275e88b06a277c Rob Herring   2020-12-18  934  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

