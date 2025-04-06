Return-Path: <linux-pci+bounces-25337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F29A7CC65
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 02:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E444174551
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 00:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9494C83;
	Sun,  6 Apr 2025 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoB+DQ7V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9B610D;
	Sun,  6 Apr 2025 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743900502; cv=none; b=nJr9OVKUHRTJ2CTSKMHF8CIT8hKunF/urehXfL/Ivx8OrMJ9HgiD1q4QOD68/5G/Mu7y2tnWhP8h92mQV3p4LgAhT/JDMuQl0W2GE2JDUnNVrnzvfDpuF77AG4166RQNGv+Jrj87N8uIt7EID0l65cQ67idoa8dtqspCKvLhWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743900502; c=relaxed/simple;
	bh=YtY8yKPGTxpv3/8LUl6pWN1bg8RbIw7n5Q9ES0ZaE5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM2C4riUlK79SUj+bXwNozsdtM0a31EaJtc5zeTOFeV6r4LRtFSS/4jFBQO2Kq8XvNDk9UhyN4ITZGO6Hj/kjEJqiVxR/MkysFaAE/YoDZIuPnJ11ISCsHkmCY4NurGVT731r1CO0PuPaBhR29H/UgiMRe9Ui5kCADWlo6O8+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoB+DQ7V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743900500; x=1775436500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtY8yKPGTxpv3/8LUl6pWN1bg8RbIw7n5Q9ES0ZaE5k=;
  b=MoB+DQ7VfmmX9oT1KSAaNP575sZnIS3UEFHPSvyDsz3Pv9JINc10lp3/
   sCesGt9VvCBZBiq0dEpLQtoWWD5Q8oegMuSZUui+4wYJl82BwV89YWt/u
   RYyU6v2uYLXEkbpdxrC3ddTiRmflY+dBorlZHOrHBGxVqLJtRsAQwyJBQ
   Xl38fWFKxysAYrEJd1AiduwZS3ZWtW4OQgKdASXjpQGbhJm8HTTCnijHv
   RMCBwdYV6oyvi7km2KooJk/NMfLQZ50BcddA9G2i/Gkq2Z56SPAVIY3uf
   ZD4/NupCtODn8p/+akhT/lhsG2ZgwJ1YwLNzRCVMqWu71m6zQOHVmRwBF
   A==;
X-CSE-ConnectionGUID: bFzB9honSVKcTwnxunihAQ==
X-CSE-MsgGUID: LF5qSLEwQka3LOjRrbZScw==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45199358"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="45199358"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 17:48:19 -0700
X-CSE-ConnectionGUID: vtCmNRHnSni3xq2chpYLJQ==
X-CSE-MsgGUID: BQdb/O19SvWkgWn0wVHYIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="127499624"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Apr 2025 17:48:16 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1EBJ-0002NH-1g;
	Sun, 06 Apr 2025 00:48:13 +0000
Date: Sun, 6 Apr 2025 08:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, manivannan.sadhasivam@linaro.org,
	thierry.reding@gmail.com, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jonathanh@nvidia.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
Message-ID: <202504060814.4HRuwajf-lkp@intel.com>
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
config: arm-randconfig-002-20250406 (https://download.01.org/0day-ci/archive/20250406/202504060814.4HRuwajf-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504060814.4HRuwajf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504060814.4HRuwajf-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-tegra194.c: In function 'tegra_pcie_dw_remove':
>> drivers/pci/controller/dwc/pcie-tegra194.c:2301:18: error: passing argument 1 of 'deinit_debugfs' from incompatible pointer type [-Werror=incompatible-pointer-types]
      deinit_debugfs(pcie->debugfs);
                     ^~~~
   drivers/pci/controller/dwc/pcie-tegra194.c:732:20: note: expected 'struct tegra_pcie_dw *' but argument is of type 'struct dentry *'
    static inline void deinit_debugfs(struct tegra_pcie_dw *pcie) { return; }
                       ^~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-tegra194.c: In function 'tegra_pcie_dw_shutdown':
   drivers/pci/controller/dwc/pcie-tegra194.c:2420:18: error: passing argument 1 of 'deinit_debugfs' from incompatible pointer type [-Werror=incompatible-pointer-types]
      deinit_debugfs(pcie->debugfs);
                     ^~~~
   drivers/pci/controller/dwc/pcie-tegra194.c:732:20: note: expected 'struct tegra_pcie_dw *' but argument is of type 'struct dentry *'
    static inline void deinit_debugfs(struct tegra_pcie_dw *pcie) { return; }
                       ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/deinit_debugfs +2301 drivers/pci/controller/dwc/pcie-tegra194.c

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

