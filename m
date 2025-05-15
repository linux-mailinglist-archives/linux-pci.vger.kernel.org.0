Return-Path: <linux-pci+bounces-27809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCAAB8A95
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854B216C243
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71CE2135A0;
	Thu, 15 May 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhu5l9cR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B320C026
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322698; cv=none; b=tBlq1vTyAJkgp0WgRCVzSjc6Nq1vu0qULWAjltAgN1fPmKovp8eDS2eVItrMVVWZe+3WwZYNYUiDXATmeVQZgao+30Z+4phC9mvi/8LepRpRJGcFWyfYhjYhhFt9/7D7myTCCDprwJd/pQqmkG/tBhsXGqA3wIZqvb7iAB2KNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322698; c=relaxed/simple;
	bh=09F/fmQ9DRw3bPZW/fkgLE51zlKtqbf7b8dvt7aMdn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GXJDmUhQUwplfi2LsUokkSejeU7XHvU33auJ1q4H5Ff6uiD0L3nJ4PwZdBX/55Nuq1Gm0VdPiF9F1HZeeCOfhldO/SFVsDolpLvEpYMKLZHTGEABe9Dq8L6gZAAzgU2Ou4IBhYQ/nD8WezMV/GC7H+/TJY0GjnnvmHlwN0dVx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhu5l9cR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747322697; x=1778858697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=09F/fmQ9DRw3bPZW/fkgLE51zlKtqbf7b8dvt7aMdn0=;
  b=lhu5l9cRq4QLb2U2ptmsYVtmjDkzmCXP/roWZ1xzFvkqVc4SNI70CYEw
   7VASeQ333TlfDZkDEc+rk/jXd0doNBq8UuKQ+Hf6X2RK6X9S5ukhWeSg/
   pFL3qEfflJwuih7OsiAzB+dZt8CoGJN8knajl9GqNh4x3tg+S4SHIeJDH
   Bpy3QscZdmB7HTZGnl5VaagLkOHHHPb+fF7lK2TktCQs1+g2kEmI/ki5M
   eiDe+G/tioKQgv8vPfNIh6S46OQy8P1b/YwX9V+6mLAZQaLqsLfZ7+/KU
   u92oND8TRnLyREmyXoTRa0cJD/RYIjS9bn9L3Aa4mhazaWLN8loTP6M6A
   w==;
X-CSE-ConnectionGUID: N++1NA1CTOalVRLCFsF7WA==
X-CSE-MsgGUID: 3RPkstaZQnWR4XqUdq00vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49136704"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="49136704"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 08:24:56 -0700
X-CSE-ConnectionGUID: qLORngJCQReupv3UAVBuig==
X-CSE-MsgGUID: 9tw5fYq+SlC0INW5WTNcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="143295418"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 May 2025 08:24:53 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFaS3-000IUt-0P;
	Thu, 15 May 2025 15:24:51 +0000
Date: Thu, 15 May 2025 23:24:15 +0800
From: kernel test robot <lkp@intel.com>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [pci:slot-reset 1/1]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:721:58: error: use of
 undeclared identifier 'PCIE_CLIENT_GENERAL_CON'
Message-ID: <202505152337.AoKvnBmd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git slot-reset
head:   ebf9d2fae99254fc37f49384b769f363e676018d
commit: ebf9d2fae99254fc37f49384b769f363e676018d [1/1] PCI: dw-rockchip: Add support for slot reset on link down event
config: arm64-randconfig-002-20250515 (https://download.01.org/0day-ci/archive/20250515/202505152337.AoKvnBmd-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250515/202505152337.AoKvnBmd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505152337.AoKvnBmd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:721:58: error: use of undeclared identifier 'PCIE_CLIENT_GENERAL_CON'
     721 |         rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE, PCIE_CLIENT_GENERAL_CON);
         |                                                                 ^
   1 error generated.


vim +/PCIE_CLIENT_GENERAL_CON +721 drivers/pci/controller/dwc/pcie-dw-rockchip.c

   679	
   680	static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
   681					       struct pci_dev *pdev)
   682	{
   683		struct pci_bus *bus = bridge->bus;
   684		struct dw_pcie_rp *pp = bus->sysdata;
   685		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
   686		struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
   687		struct device *dev = rockchip->pci.dev;
   688		u32 val;
   689		int ret;
   690	
   691		dw_pcie_stop_link(pci);
   692		clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
   693		rockchip_pcie_phy_deinit(rockchip);
   694	
   695		ret = reset_control_assert(rockchip->rst);
   696		if (ret)
   697			return ret;
   698	
   699		ret = rockchip_pcie_phy_init(rockchip);
   700		if (ret)
   701			goto disable_regulator;
   702	
   703		ret = reset_control_deassert(rockchip->rst);
   704		if (ret)
   705			goto deinit_phy;
   706	
   707		ret = rockchip_pcie_clk_init(rockchip);
   708		if (ret)
   709			goto deinit_phy;
   710	
   711		ret = pp->ops->init(pp);
   712		if (ret) {
   713			dev_err(dev, "host init failed: %d\n", ret);
   714			goto deinit_clk;
   715		}
   716	
   717		/* LTSSM enable control mode. */
   718		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
   719		rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
   720	
 > 721		rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE, PCIE_CLIENT_GENERAL_CON);
   722	
   723		ret = dw_pcie_setup_rc(pp);
   724		if (ret) {
   725			dev_err(dev, "failed to setup RC: %d\n", ret);
   726			goto deinit_clk;
   727		}
   728	
   729		/* Unmask DLL up/down indicator and hot reset/link-down reset IRQ. */
   730		val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
   731		rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
   732	
   733		ret = dw_pcie_start_link(pci);
   734		if (ret)
   735			goto deinit_clk;
   736	
   737		/* Ignore errors, the link may come up later. */
   738		dw_pcie_wait_for_link(pci);
   739		dev_dbg(dev, "slot reset completed\n");
   740		return ret;
   741	
   742	deinit_clk:
   743		clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
   744	deinit_phy:
   745		rockchip_pcie_phy_deinit(rockchip);
   746	disable_regulator:
   747		if (rockchip->vpcie3v3)
   748			regulator_disable(rockchip->vpcie3v3);
   749	
   750		return ret;
   751	}
   752	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

