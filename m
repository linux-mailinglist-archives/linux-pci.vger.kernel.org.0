Return-Path: <linux-pci+bounces-25802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230BDA87BBE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA3716F9CE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E20225E479;
	Mon, 14 Apr 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9L9GkCg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743541A8401;
	Mon, 14 Apr 2025 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622453; cv=none; b=dUVcRIplNOp+B2qd1zXiuMq292/6qjsXHTXN22kxF2D2le+zb8fa836aXvM5WwE3Zhgp3VF1kujVmk4poIUt7+H3DWKLwGkowx0f3vb/gGwna/QtU3sA9T7S0RqStmphwTHsiJJJutLuBB0X+OUP4LhmH87oOiAa4QJd5tp/y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622453; c=relaxed/simple;
	bh=bz1n5Vi8wBxB9B2+kQXtaqVfb20MXtUZpsz3bQ93BJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsJ19xZMgqAa97wD6VvaMyQHKYnmticjYeVNo65BRtmsexkS8GpUAZY24wrYmMJya2K5JawaovK5QXRD00A60Xprc8U6uB+pAPRf4CV69MZPwDTapQqkyPLdR4Z5ZspBmkWcqRQlUXUn8Li/lEbCMSS2lJV4Vh+WPH+ayK2jgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9L9GkCg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744622450; x=1776158450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bz1n5Vi8wBxB9B2+kQXtaqVfb20MXtUZpsz3bQ93BJ8=;
  b=K9L9GkCgj6hdsC6ZDizk8nVpbWIHHJ9gVdPFa8u6HpPs3QrotjMaWu3Z
   GN9uIwnHmd8mp06pOnnxLZvvkkUrXnAdD9cUFcT2V2y3ab+3hzfbSsUTj
   ksRJ9EQZ7FY85riFX1PUulxPt3g7tO8o3AYYhhsuB9kgPjj6bav/Xa7f/
   wOdq7bmDzIO0wlVAhNo5yt0wCjhVv+Oi/gZ55lET/x3vGZR/ZmFhecKhx
   qGRdJnZtx+gTf/pp99JuAYQAs8PhxGQAWyvV7dpy5N6HLzHn524XiszbP
   V1LgPHsigLlC+neNbbFK7uGFWyB5i163B3223niIp8/SEkBduPx5nUBoz
   g==;
X-CSE-ConnectionGUID: EXRBzIUPRIK6MDvEe5LGUQ==
X-CSE-MsgGUID: Ex2IiMuOSo+/ZHCNq5Jt2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57071613"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="57071613"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 02:20:50 -0700
X-CSE-ConnectionGUID: 9YIxMUhpQ8WDg5wUXXbL1A==
X-CSE-MsgGUID: L2c9Ba6lRjKWPYBikVug5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129617713"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Apr 2025 02:20:36 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4FzW-000Dz8-0S;
	Mon, 14 Apr 2025 09:20:34 +0000
Date: Mon, 14 Apr 2025 17:20:20 +0800
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
Message-ID: <202504141719.svx3rf5x-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on a24588245776dafc227243a01bfbeb8a59bafba9]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/dt-bindings-pci-cadence-Extend-compatible-for-new-RP-configuration/20250414-094836
base:   a24588245776dafc227243a01bfbeb8a59bafba9
patch link:    https://lore.kernel.org/r/20250411103656.2740517-6-hans.zhang%40cixtech.com
patch subject: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP controller
config: powerpc64-randconfig-001-20250414 (https://download.01.org/0day-ci/archive/20250414/202504141719.svx3rf5x-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250414/202504141719.svx3rf5x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504141719.svx3rf5x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pcie-cadence.c:303:12: warning: variable 'ctrl0' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     303 |                 desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence.h:342:2: note: expanded from macro 'CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN'
     342 |         FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      69 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      70 |                                         (0 + (_val)) : 0,               \
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      71 |                                  _pfx "value too large for the field"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:557:2: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:2: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:7: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                     ^~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence.c:323:46: note: uninitialized use occurs here
     323 |                              CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
         |                                                                   ^~~~~
   drivers/pci/controller/cadence/pcie-cadence.c:303:12: note: remove the 'if' if its condition is always true
     303 |                 desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
         |                          ^
   drivers/pci/controller/cadence/pcie-cadence.h:342:2: note: expanded from macro 'CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN'
     342 |         FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
         |         ^
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:557:2: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:545:2: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:537:3: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                 ^
   drivers/pci/controller/cadence/pcie-cadence.c:291:39: note: initialize the variable 'ctrl0' to silence this warning
     291 |         u32 addr0, addr1, desc0, desc1, ctrl0;
         |                                              ^
         |                                               = 0
   1 warning generated.
--
>> drivers/pci/controller/cadence/pcie-cadence-host.c:122:3: warning: variable 'desc0' is uninitialized when used here [-Wuninitialized]
     122 |                 desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
         |                 ^~~~~
   drivers/pci/controller/cadence/pcie-cadence-host.c:80:18: note: initialize the variable 'desc0' to silence this warning
      80 |         u32 addr0, desc0, desc1, ctrl0;
         |                         ^
         |                          = 0
   1 warning generated.


vim +303 drivers/pci/controller/cadence/pcie-cadence.c

   286	
   287	void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
   288							      u8 busnr, u8 fn,
   289							      u32 r, u64 cpu_addr)
   290	{
   291		u32 addr0, addr1, desc0, desc1, ctrl0;
   292	
   293		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
   294		desc1 = 0;
   295	
   296		/* See cdns_pcie_set_outbound_region() comments above. */
   297		if (pcie->is_rc) {
   298			desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
   299				CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
   300			ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
   301				CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
   302		} else {
 > 303			desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
   304		}
   305	
   306		addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
   307			(lower_32_bits(cpu_addr) & GENMASK(31, 8));
   308		addr1 = upper_32_bits(cpu_addr);
   309	
   310		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   311				     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
   312		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   313				     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
   314		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   315				     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
   316		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   317				     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
   318		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   319				     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
   320		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   321				     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
   322		cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
   323				     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

