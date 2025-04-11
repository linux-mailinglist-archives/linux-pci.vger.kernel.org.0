Return-Path: <linux-pci+bounces-25657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53093A856B6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F5F4C82E7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEB32980AE;
	Fri, 11 Apr 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLsBJ26L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF82980B9
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360551; cv=none; b=b1hUaLRqFltlo3HMHObY05OJL45UHhUQa4bSM/z1OegpK1937fVq8O4B1CIofRve2FgNVLYvy2hxqiliPV870sWhNO6A1ZLWubtzUzekErM6AsFGw0uwpZ+QsQap7b5kXZk3Y/lbxPXT2t8Fy84wUHpwsLCaRdGYKG/WPn7E7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360551; c=relaxed/simple;
	bh=UB+gYPbNoFH/gTLnDV+gkaB+80nVg6rXio4SmeE5bMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3LBUHxSERBV1GVxE/IV6PXfJLKERRKhnCK1A4cCjaNkEgBagzT2b02bop1nqMhSrPSpz1n5QklI50O25DoxoD1W5rfAyu9iLJfb9tZa7BThfqIUZFwjlqjt9lHH5ndcqPqiF1/QX88p4MzzVGCoZjLJ2yHdabmZtmveV+4AgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLsBJ26L; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744360549; x=1775896549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UB+gYPbNoFH/gTLnDV+gkaB+80nVg6rXio4SmeE5bMg=;
  b=hLsBJ26LUDfscnc5FmmhykbQZp9aALbv6mahdIto/Tkb7NfjuPsjznaE
   hUWgRDzYYQSdvx59bNRHdQQOuRF7C0fU6rBo7rf12ZflBOdedjPpD28UZ
   rBWIqljoVpFPmwLx8tmP9MpusWMLick5THvVflQcT8opAvzWjK66NQ+1i
   /m4E1TqEol07+eQSm73i/wFrWjccu7GOigkqxHjBOGF8a5UqcwjDhFoEf
   2egOrPCEzVO8eaWCkJcU1LCjhh2uckwgDdpPf65FtIDdFrYwNVLD8cpTt
   kNjbMiRq9d8WoigJuPXCsoD/dLz31DBPKy9A1XIPkzJCu/lhO+hC4M1aS
   Q==;
X-CSE-ConnectionGUID: DaB4Q/lCQiGPK1WfCn8Atw==
X-CSE-MsgGUID: lqt2cowWTnGmWxUObHJq1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45996184"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45996184"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 01:35:49 -0700
X-CSE-ConnectionGUID: 4OxZi7pqQgW7c4kwv/5WSQ==
X-CSE-MsgGUID: H+x/QhFWSjKkr8lJDf21Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129980391"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Apr 2025 01:35:46 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u39rU-000AyY-2c;
	Fri, 11 Apr 2025 08:35:44 +0000
Date: Fri, 11 Apr 2025 16:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Add system PM support
Message-ID: <202504111625.Eds7X9BC-lkp@intel.com>
References: <1744267805-119602-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744267805-119602-1-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.15-rc1 next-20250410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/PCI-dw-rockchip-Add-system-PM-support/20250410-145426
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1744267805-119602-1-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH] PCI: dw-rockchip: Add system PM support
config: x86_64-buildonly-randconfig-001-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111625.Eds7X9BC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111625.Eds7X9BC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504111625.Eds7X9BC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:749:12: warning: 'rockchip_pcie_resume' defined but not used [-Wunused-function]
     749 | static int rockchip_pcie_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:725:12: warning: 'rockchip_pcie_suspend' defined but not used [-Wunused-function]
     725 | static int rockchip_pcie_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/rockchip_pcie_resume +749 drivers/pci/controller/dwc/pcie-dw-rockchip.c

   724	
 > 725	static int rockchip_pcie_suspend(struct device *dev)
   726	{
   727		struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
   728		struct dw_pcie *pci = &rockchip->pci;
   729		int ret;
   730	
   731		rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
   732	
   733		ret = dw_pcie_suspend_noirq(pci);
   734		if (ret) {
   735			dev_err(dev, "failed to suspend\n");
   736			return ret;
   737		}
   738	
   739		rockchip_pcie_phy_deinit(rockchip);
   740		clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
   741		reset_control_assert(rockchip->rst);
   742		if (rockchip->vpcie3v3)
   743			regulator_disable(rockchip->vpcie3v3);
   744		gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
   745	
   746		return 0;
   747	}
   748	
 > 749	static int rockchip_pcie_resume(struct device *dev)
   750	{
   751		struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
   752		struct dw_pcie *pci = &rockchip->pci;
   753		int ret;
   754	
   755		reset_control_assert(rockchip->rst);
   756	
   757		ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
   758		if (ret) {
   759			dev_err(dev, "clock init failed\n");
   760			goto err_clk;
   761		}
   762	
   763		if (rockchip->vpcie3v3) {
   764			ret = regulator_enable(rockchip->vpcie3v3);
   765			if (ret)
   766				goto err_power;
   767		}
   768	
   769		ret = phy_init(rockchip->phy);
   770		if (ret) {
   771			dev_err(dev, "fail to init phy\n");
   772			goto err_phy_init;
   773		}
   774	
   775		ret = phy_power_on(rockchip->phy);
   776		if (ret) {
   777			dev_err(dev, "fail to power on phy\n");
   778			goto err_phy_on;
   779		}
   780	
   781		reset_control_deassert(rockchip->rst);
   782	
   783		rockchip_pcie_writel_apb(rockchip, HIWORD_UPDATE(0xffff, rockchip->intx),
   784					 PCIE_CLIENT_INTR_MASK_LEGACY);
   785	
   786		rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
   787		rockchip_pcie_unmask_dll_indicator(rockchip);
   788	
   789		ret = dw_pcie_resume_noirq(pci);
   790		if (ret) {
   791			dev_err(dev, "fail to resume\n");
   792			goto err_resume;
   793		}
   794	
   795		return 0;
   796	
   797	err_resume:
   798		phy_power_off(rockchip->phy);
   799	err_phy_on:
   800		phy_exit(rockchip->phy);
   801	err_phy_init:
   802		if (rockchip->vpcie3v3)
   803			regulator_disable(rockchip->vpcie3v3);
   804	err_power:
   805		clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
   806	err_clk:
   807		reset_control_deassert(rockchip->rst);
   808		return ret;
   809	}
   810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

