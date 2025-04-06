Return-Path: <linux-pci+bounces-25338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A8A7CC85
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDB93B6A24
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 02:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF0130E58;
	Sun,  6 Apr 2025 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuH6QwFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10484E1C;
	Sun,  6 Apr 2025 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743905430; cv=none; b=lWBvzWepjAS7ibW/OGX1vQ6PcYYoVT4+HArnwwJQQ7I/+EFLey1Xaofjb4OdKdb0xvjeO5qm1KQs3ONe1XphjVFVIfAhhfDQfYgRGrqQt+nkR/LXlStb1mFgEbHC+OCP7I5HmdCEacakEq9fMS6X2xkUxena7dbuLSLyARXrE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743905430; c=relaxed/simple;
	bh=s2ePmLJebTBif3adtwwn4EZ0Sw4QTnrxCeWLYtQTVF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkNxcC/W6OZdGvkdlNimFMIWN+WEExmorA18jHOGeNjhWMzBYigu12Q1NRfP5cs6AOn3ll2sLJZ6BKty4Wxp/DnAMz9fIHXkCpDRFsI9N6PqBzDV9WoRpGhmOM2u4ucWKkrlYckCAwcKGldlXEPBf0IdEhxM+G++JnkyEGRnwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuH6QwFQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743905428; x=1775441428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s2ePmLJebTBif3adtwwn4EZ0Sw4QTnrxCeWLYtQTVF0=;
  b=BuH6QwFQkTTIw8Hq7WfaUyd+eBPrE7RGZJVhf118Akef3UsDc8a3fhp8
   dIHTvHFzJkNt6KM+N2utR+pVc2RN9c7sYXLOeotNJUVW8NngyE78AawGC
   D5Zt+qOR+mvwhQIifOgOBuWnVtO9SJEGP4bCHSmQUTBIjtCrpTEOreF77
   26V1OmeUKzYbBZ5RhkEnLcOXWYgQ7C18pLWmbdn4VGxX6qD/kHzhclEI5
   dJhyS1Tv4RWr8RVVwdwp02iil22WAy/3saU7v05I3loaVaeYL+H3uLrq6
   FQvPBH5Zwi4RjOJluUjZ8t0R29TNAJbBFw1I+75ZN4X0JiNJVQkiR5uZP
   A==;
X-CSE-ConnectionGUID: WBdIZus9TKml6hYnixzsgw==
X-CSE-MsgGUID: uLq7zobaSlWfXq8ehnItjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="44556416"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="44556416"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 19:10:24 -0700
X-CSE-ConnectionGUID: /pKw8fHHRiSxJUvBFH73yg==
X-CSE-MsgGUID: UqF+u6gbTWOzwmzSK+PRxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="127611308"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Apr 2025 19:10:21 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1FSk-0002OV-33;
	Sun, 06 Apr 2025 02:10:18 +0000
Date: Sun, 6 Apr 2025 10:10:06 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	manivannan.sadhasivam@linaro.org, thierry.reding@gmail.com,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jonathanh@nvidia.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
Message-ID: <202504060938.xa7VrE6O-lkp@intel.com>
References: <20250405145459.26800-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405145459.26800-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a8662bcd2ff152bfbc751cab20f33053d74d0963]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/pci-tegra194-Fix-debugfs-cleanup-for-CONFIG_PCIEASPM/20250405-230047
base:   a8662bcd2ff152bfbc751cab20f33053d74d0963
patch link:    https://lore.kernel.org/r/20250405145459.26800-1-18255117159%40163.com
patch subject: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
config: arm-randconfig-001-20250406 (https://download.01.org/0day-ci/archive/20250406/202504060938.xa7VrE6O-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504060938.xa7VrE6O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504060938.xa7VrE6O-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-tegra194.c:2301:18: error: incompatible pointer types passing 'struct dentry *' to parameter of type 'struct tegra_pcie_dw *' [-Werror,-Wincompatible-pointer-types]
    2301 |                 deinit_debugfs(pcie->debugfs);
         |                                ^~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-tegra194.c:732:57: note: passing argument to parameter 'pcie' here
     732 | static inline void deinit_debugfs(struct tegra_pcie_dw *pcie) { return; }
         |                                                         ^
   drivers/pci/controller/dwc/pcie-tegra194.c:2420:18: error: incompatible pointer types passing 'struct dentry *' to parameter of type 'struct tegra_pcie_dw *' [-Werror,-Wincompatible-pointer-types]
    2420 |                 deinit_debugfs(pcie->debugfs);
         |                                ^~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-tegra194.c:732:57: note: passing argument to parameter 'pcie' here
     732 | static inline void deinit_debugfs(struct tegra_pcie_dw *pcie) { return; }
         |                                                         ^
   2 errors generated.


vim +2301 drivers/pci/controller/dwc/pcie-tegra194.c

  2292	
  2293	static void tegra_pcie_dw_remove(struct platform_device *pdev)
  2294	{
  2295		struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
  2296	
  2297		if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
  2298			if (!pcie->link_state)
  2299				return;
  2300	
> 2301			deinit_debugfs(pcie->debugfs);
  2302			tegra_pcie_deinit_controller(pcie);
  2303			pm_runtime_put_sync(pcie->dev);
  2304		} else {
  2305			disable_irq(pcie->pex_rst_irq);
  2306			pex_ep_event_pex_rst_assert(pcie);
  2307		}
  2308	
  2309		pm_runtime_disable(pcie->dev);
  2310		tegra_bpmp_put(pcie->bpmp);
  2311		if (pcie->pex_refclk_sel_gpiod)
  2312			gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
  2313	}
  2314	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

