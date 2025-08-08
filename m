Return-Path: <linux-pci+bounces-33645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E257B1EF16
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A597586409
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A46288C08;
	Fri,  8 Aug 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMpJsT0H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02412288C1A;
	Fri,  8 Aug 2025 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683090; cv=none; b=rXh8v2CCYD720alw2t8sUBr5E2FJ4YSKQqgxK329n7YdNMTdWIfiwWUMUhNlYBPQ2nCKzvFejLAl/m0wdOHcXDZ88+J8QpU+BED3Dcokp2vKe+fYQtGX3AXyovJmILK4uP21zXs2YKL9OmRKYXKRlJ6/Us6rbKqZH2qwUgsQ2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683090; c=relaxed/simple;
	bh=CIQSbhlMKR1WIuZq4/Rkx2YJl5pIr3xxYoTEGe7WjpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1AS3Aib8qDMzZ0Wa0fYHKfVGfcEF/wztVsAanYEjS/xYkWcBf07zVrvtJJXCWIzLwzlFRtHzLmkWGZbWicmb5Fz2sGwsFLZ4j6YNP5WgcAczCw72+zNw2GAwm+CpTNtYRpFuZCICpWm7LIT2c0IxnUh+LFZxfbtFgwIO8eE6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMpJsT0H; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754683088; x=1786219088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CIQSbhlMKR1WIuZq4/Rkx2YJl5pIr3xxYoTEGe7WjpA=;
  b=eMpJsT0HH1ezGFFsecrJV/qrePPZ0kI4rIRrSe6LRUzr47x73ZkEIvnU
   sUUJbDjTLtlefeFGT+jprA71RZxz7stjCVhh1f/5NGS0+yvBfyEhktcLL
   nQTasV1eZLNf/CaNg1hItKFShe3T7SCKmTX86DLtwo+VLEiSwwUeoLh6S
   1u6Rvf8PP9o4z2U5vT8RZGDRDhxRdikffYwtSBI1BYbKl0oRJMqb3lCp2
   3ssRUXox0nM0R0lq0pTaaeJNgPdSXwFgWUuBlqXVY1q0Ir7Ar9V+bbKgQ
   MweCt6LhhL4/SDks3A3QuUshOtYl4VxPaaVaHKB+3mVRnv/itflaB20M9
   g==;
X-CSE-ConnectionGUID: /b3TSbWqQQ2dvLICKMU6pA==
X-CSE-MsgGUID: w1lqaay9RwyMQys73hcORw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56750881"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56750881"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 12:58:07 -0700
X-CSE-ConnectionGUID: nxAfNcsPTwSLKLoISiPpHw==
X-CSE-MsgGUID: OefX2H0oReqbAhGTkJXdzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164629461"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 08 Aug 2025 12:58:03 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukTE0-0004G2-2h;
	Fri, 08 Aug 2025 19:58:00 +0000
Date: Sat, 9 Aug 2025 03:57:06 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, robh@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mpillai@cadence.com, fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com, peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v6 06/12] PCI: cadence: Add support for High Performance
 Arch(HPA) controller
Message-ID: <202508090343.TWUqM8E7-lkp@intel.com>
References: <20250808072929.4090694-7-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808072929.4090694-7-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 37816488247ddddbc3de113c78c83572274b1e2e]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Split-PCIe-controller-header-file/20250808-154018
base:   37816488247ddddbc3de113c78c83572274b1e2e
patch link:    https://lore.kernel.org/r/20250808072929.4090694-7-hans.zhang%40cixtech.com
patch subject: [PATCH v6 06/12] PCI: cadence: Add support for High Performance Arch(HPA) controller
config: arm64-randconfig-002-20250809 (https://download.01.org/0day-ci/archive/20250809/202508090343.TWUqM8E7-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090343.TWUqM8E7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090343.TWUqM8E7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:66:3: warning: variable 'desc0' is uninitialized when used here [-Wuninitialized]
      66 |                 desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
         |                 ^~~~~
   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c:28:18: note: initialize the variable 'desc0' to silence this warning
      28 |         u32 addr0, desc0, desc1, ctrl0;
         |                         ^
         |                          = 0
   1 warning generated.


vim +/desc0 +66 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c

    20	
    21	void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
    22					   int where)
    23	{
    24		struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
    25		struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
    26		struct cdns_pcie *pcie = &rc->pcie;
    27		unsigned int busn = bus->number;
    28		u32 addr0, desc0, desc1, ctrl0;
    29		u32 regval;
    30	
    31		if (pci_is_root_bus(bus)) {
    32			/*
    33			 * Only the root port (devfn == 0) is connected to this bus.
    34			 * All other PCI devices are behind some bridge hence on another
    35			 * bus.
    36			 */
    37			if (devfn)
    38				return NULL;
    39	
    40			return pcie->reg_base + (where & 0xfff);
    41		}
    42	
    43		/* Clear AXI link-down status */
    44		regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
    45		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
    46				     (regval & ~GENMASK(0, 0)));
    47	
    48		desc1 = 0;
    49		ctrl0 = 0;
    50	
    51		/* Update Output registers for AXI region 0. */
    52		addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
    53			CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
    54			CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
    55		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
    56				     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
    57	
    58		desc1 = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
    59					    CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
    60		desc1 &= ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
    61		desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
    62		ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
    63			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
    64	
    65		if (busn == bridge->busnr + 1)
  > 66			desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
    67		else
    68			desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
    69	
    70		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
    71				     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
    72		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
    73				     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
    74		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
    75				     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
    76	
    77		return rc->cfg_base + (where & 0xfff);
    78	}
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

