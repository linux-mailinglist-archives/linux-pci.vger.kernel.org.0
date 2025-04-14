Return-Path: <linux-pci+bounces-25796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E9A87958
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 09:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B87A3349
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC8143736;
	Mon, 14 Apr 2025 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPuZMVH/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28202628C;
	Mon, 14 Apr 2025 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616857; cv=none; b=Ta6400gbdx1KnIwFdu0Bu49ava4Skdbwylq5gtGG85DMECEFD57i15dCyrwAAJ3g9voJwVMBz0agRXbTdn2aJgbh7RMp8ZNakCbUDvkEy+auKzpN2Uy4GFOhBpRI2UnIoppCo9Yccu1+j2LV5k8lJxOf0uCRQZoJQ7OTpTAZDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616857; c=relaxed/simple;
	bh=cJVe3apFs6nVj9y2qjiGhvwIV6g3h3nboUFjSdFy8gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbQmyMAtJTd4tHKkcFNeW4u48c2HkOip0MEFkGFEVxnrxonjgl/8cW2q3TwSWXuhVsLygO29UIUZKdLLBCIkajdqgoLk6hCqSAJdlRFh3IyBGVr25oYVew+2tS/wP5r1PKyOvMJ/OfmOUw7wblXF/TVtMlHPrI3Z//0qcmNByF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPuZMVH/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744616856; x=1776152856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJVe3apFs6nVj9y2qjiGhvwIV6g3h3nboUFjSdFy8gM=;
  b=XPuZMVH/RGLY9BLTMpGeW2rvCObFTyRi9ZdlAUZX4apcLUx8eyr9X2H8
   YI1kZhExFfpluG+8zEPsBfIzQ0o2+psr0h8iKwvhWL6PY9OORVnb13N+S
   5B31BPNZGOlbH7t+moEkXp1JQOqtUkHNbNilxsgRF66HfOZbOZtCPpQQ8
   3w+oOPaVWF3uXnvjolT+OQjEt0aGMI7JBI1vsX0zf9m13CL9Zq1pRRCeR
   xY0Ep2Hyj3CxoPNzEWW8JC9APJMu8dmINFSz0jGJaoQvogdPZw+ckf2Aq
   nzkU3OU2oJgSzXrcASMVJ8VnVt2U0evadFcUFnW9kv8Ma1/OA+o3DCVn2
   w==;
X-CSE-ConnectionGUID: 4kMA9sn7RbuzCHC9v6gsJQ==
X-CSE-MsgGUID: mNQt36SnS8ybCkGvRz8gAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46083351"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46083351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 00:47:32 -0700
X-CSE-ConnectionGUID: ELGUn/CtQW+FwiUdM/EBCw==
X-CSE-MsgGUID: 1aNZkmdaQum7hxE92/guUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129503739"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Apr 2025 00:47:27 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4EXM-000Du6-20;
	Mon, 14 Apr 2025 07:47:24 +0000
Date: Mon, 14 Apr 2025 15:47:00 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and
 EP controller
Message-ID: <202504141523.v9N9MrDJ-lkp@intel.com>
References: <20250411103656.2740517-6-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411103656.2740517-6-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on a24588245776dafc227243a01bfbeb8a59bafba9]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/dt-bindings-pci-cadence-Extend-compatible-for-new-RP-configuration/20250414-094836
base:   a24588245776dafc227243a01bfbeb8a59bafba9
patch link:    https://lore.kernel.org/r/20250411103656.2740517-6-hans.zhang%40cixtech.com
patch subject: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP controller
config: x86_64-buildonly-randconfig-002-20250414 (https://download.01.org/0day-ci/archive/20250414/202504141523.v9N9MrDJ-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250414/202504141523.v9N9MrDJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504141523.v9N9MrDJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pcie-cadence-host.c:108:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     108 |         addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
         |                 ^
   drivers/pci/controller/cadence/pcie-cadence.h:309:2: note: expanded from macro 'CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS'
     309 |         FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, \
         |         ^
   drivers/pci/controller/cadence/pcie-cadence-host.c:574:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     574 |         value = CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
         |                 ^
   drivers/pci/controller/cadence/pcie-cadence.h:263:2: note: expanded from macro 'CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL'
     263 |         FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
         |         ^
   drivers/pci/controller/cadence/pcie-cadence-host.c:610:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     610 |         addr0 = CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
         |                 ^
   drivers/pci/controller/cadence/pcie-cadence.h:361:2: note: expanded from macro 'CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS'
     361 |         FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
         |         ^
   drivers/pci/controller/cadence/pcie-cadence-host.c:663:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     663 |         desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
         |                 ^
   drivers/pci/controller/cadence/pcie-cadence.h:339:2: note: expanded from macro 'CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS'
     339 |         FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
         |         ^
   4 errors generated.
--
>> drivers/pci/controller/cadence/pcie-cadence.c:199:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     199 |                             CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay));
         |                             ^
   drivers/pci/controller/cadence/pcie-cadence.h:375:2: note: expanded from macro 'CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY'
     375 |         FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
         |         ^
   drivers/pci/controller/cadence/pcie-cadence.c:221:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     221 |         addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
         |                 ^
   drivers/pci/controller/cadence/pcie-cadence.h:309:2: note: expanded from macro 'CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS'
     309 |         FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, \
         |         ^
   drivers/pci/controller/cadence/pcie-cadence.c:293:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     293 |         desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
         |                 ^
   drivers/pci/controller/cadence/pcie-cadence.h:333:2: note: expanded from macro 'CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG'
     333 |         FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
         |         ^
   3 errors generated.


vim +/FIELD_PREP +108 drivers/pci/controller/cadence/pcie-cadence-host.c

    72	
    73	void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
    74					   int where)
    75	{
    76		struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
    77		struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
    78		struct cdns_pcie *pcie = &rc->pcie;
    79		unsigned int busn = bus->number;
    80		u32 addr0, desc0, desc1, ctrl0;
    81		u32 regval;
    82	
    83		if (pci_is_root_bus(bus)) {
    84			/*
    85			 * Only the root port (devfn == 0) is connected to this bus.
    86			 * All other PCI devices are behind some bridge hence on another
    87			 * bus.
    88			 */
    89			if (devfn)
    90				return NULL;
    91	
    92			return pcie->reg_base + (where & 0xfff);
    93		}
    94	
    95		/*
    96		 * Clear AXI link-down status
    97		 */
    98		regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
    99		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
   100				     (regval & GENMASK(0, 0)));
   101	
   102		desc1 = 0;
   103		ctrl0 = 0;
   104	
   105		/*
   106		 * Update Output registers for AXI region 0.
   107		 */
 > 108		addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
   109			CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
   110			CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
   111		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   112				     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
   113	
   114		desc1 = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
   115					    CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
   116		desc1 &= ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
   117		desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
   118		ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
   119			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
   120	
   121		if (busn == bridge->busnr + 1)
   122			desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
   123		else
   124			desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
   125	
   126		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   127				     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
   128		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   129				     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
   130		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   131				     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
   132	
   133		return rc->cfg_base + (where & 0xfff);
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

