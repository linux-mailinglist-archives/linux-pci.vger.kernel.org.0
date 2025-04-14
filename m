Return-Path: <linux-pci+bounces-25783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC286A876A5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 06:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680F9160DAA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 04:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84419CC3D;
	Mon, 14 Apr 2025 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOAi+vag"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A2192B8C;
	Mon, 14 Apr 2025 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744604018; cv=none; b=M23d16fhmyYmRgQKps/HQ2QyW8ouj2+DU1IVo/dn3DWyOGIMF/W/47xtHvREgtzDcJHWvKtnPalQXciJY1NvSsHtyMzscfr+76yfAiCJCkR9woz7yiXAR/q3s1+cuRuoJvT9ZWRAog5PwZ5nWST9QSDWQvvir3tvZiJ5Zr7PXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744604018; c=relaxed/simple;
	bh=CB8pu/44ToFwI9NWz+1xSf7PMSuFUI0+WvVfiTyezjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc6sjNZVVHD7PQr5dLp66PQ0qtAIB8IhG9zaNs6gDRi6yRc+nrAytSSbjeuzGuVmchVXTqmeXMyDXWhu1+Xa0I4Qrwi82fPVX6KqMv5P1IQhwVWMcYy8wpzFPudz+B0ixNF0Bsq/OeNm8i7QoLrtmjcI/zAI6sL3W1QBXuRscdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOAi+vag; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744604016; x=1776140016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CB8pu/44ToFwI9NWz+1xSf7PMSuFUI0+WvVfiTyezjM=;
  b=gOAi+vagrTK9bezNbQDOcFRIz7U0WJhcMn/SKgMIdsVC6QC/kZyfo2mo
   2wKxLYdxFjBA+QlfvhTpJUedSvv8f4mR/CnT4/+vgDvmWRRtr3FhPZgaV
   gp0iMsMAcGgaXdHJNvEJSIoE3Eo2gtsUMgFeI9Z91r/ezO24X6ayJELif
   d9MmxZBdOvdJOMEB3uAE96RUulFH80fZdfS/bI3ffiXPxNGXg1FqhfmLY
   GB7byRUXpBAM5PzTjxcFrX3VIhq4QfZ2eNZoFmmjAosyyAJ/EcxWFwiVS
   2q8FWq7J91QIUYaG/y5KMUga0zrFR4rNcSHsO/jHECgkaIIrQIWL6KKVc
   w==;
X-CSE-ConnectionGUID: I9ztO0mJTsS5spLvxTdo/w==
X-CSE-MsgGUID: mfQSlc4NSkC6OkULop8aMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46069616"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46069616"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 21:13:35 -0700
X-CSE-ConnectionGUID: e1diT5iITya16f02jEWIeA==
X-CSE-MsgGUID: qW0vI5rURz6dohE7ULXZaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="160657009"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Apr 2025 21:13:33 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4BCM-000DXK-1K;
	Mon, 14 Apr 2025 04:13:30 +0000
Date: Mon, 14 Apr 2025 12:13:29 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and
 EP controller
Message-ID: <202504141101.J2GJGhRZ-lkp@intel.com>
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
config: arc-randconfig-001-20250414 (https://download.01.org/0day-ci/archive/20250414/202504141101.J2GJGhRZ-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250414/202504141101.J2GJGhRZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504141101.J2GJGhRZ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/cadence/pcie-cadence-host.c:13:
   drivers/pci/controller/cadence/pcie-cadence-host.c: In function 'cdns_pci_hpa_map_bus':
>> drivers/pci/controller/cadence/pcie-cadence.h:309:9: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     309 |         FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, \
         |         ^~~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence-host.c:108:17: note: in expansion of macro 'CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS'
     108 |         addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/pci/controller/cadence/pcie-cadence-plat.c:59:23: error: 'cdns_pcie_hpa_startlink' undeclared here (not in a function); did you mean 'cdns_pcie_hpa_start_link'?
      59 |         .start_link = cdns_pcie_hpa_startlink,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~
         |                       cdns_pcie_hpa_start_link
>> drivers/pci/controller/cadence/pcie-cadence-plat.c:58:35: warning: 'cdns_hpa_plat_ops' defined but not used [-Wunused-const-variable=]
      58 | static const struct cdns_pcie_ops cdns_hpa_plat_ops = {
         |                                   ^~~~~~~~~~~~~~~~~


vim +/FIELD_PREP +309 drivers/pci/controller/cadence/pcie-cadence.h

fc9e872310321c Manikandan K Pillai 2025-04-11  304  
fc9e872310321c Manikandan K Pillai 2025-04-11  305  /* Region r Outbound AXI to PCIe Address Translation Register 0 */
fc9e872310321c Manikandan K Pillai 2025-04-11  306  #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r) (0x1010 + ((r) & 0x1f) * 0x0080)
fc9e872310321c Manikandan K Pillai 2025-04-11  307  #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK GENMASK(5, 0)
fc9e872310321c Manikandan K Pillai 2025-04-11  308  #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits)           \
fc9e872310321c Manikandan K Pillai 2025-04-11 @309  	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, \
fc9e872310321c Manikandan K Pillai 2025-04-11  310  		   ((nbits) - 1))
fc9e872310321c Manikandan K Pillai 2025-04-11  311  #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK GENMASK(23, 16)
fc9e872310321c Manikandan K Pillai 2025-04-11  312  #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
fc9e872310321c Manikandan K Pillai 2025-04-11  313  	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
fc9e872310321c Manikandan K Pillai 2025-04-11  314  #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK GENMASK(31, 24)
fc9e872310321c Manikandan K Pillai 2025-04-11  315  #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
fc9e872310321c Manikandan K Pillai 2025-04-11  316  	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
fc9e872310321c Manikandan K Pillai 2025-04-11  317  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

