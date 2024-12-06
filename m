Return-Path: <linux-pci+bounces-17839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D5B9E6EB1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 13:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE2E28156C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91CA2066FF;
	Fri,  6 Dec 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6KMm8hc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3B1D63DF;
	Fri,  6 Dec 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489892; cv=none; b=sjNdWG69OMeHB4OtElmFMgGFjqt8JIFh0m7MHW7ij1pLhYGc18BkcO8X9fVYv4ga4pHfYX24QqtFS3wlrJ3cCbnOckJU+3HEFwmtdyGvxuJtQZYNhPaapQY7uXUx7eOEkFFkB4q+/2l8dLT0woa0DW3Nb8gfodxUWwVsjBtl6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489892; c=relaxed/simple;
	bh=gHmtYM0xFbENgH0JOzuO/NpklUBLQ269LXb2gsKedOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRztx5wpgwiXBzl3SsRtBd1Y8UFGLY2q4q/QqmgTBqPzyPaYaBSl3TqJXJaqr4BtvPW59BsYF3q6jBvrlXK6tsr9w8bNNWP7wqY9OvH/bsMMxR3AOdqm5evlyBZQ+X9fS+cdFL7UeENqsF2KO7dSmPodxFdCJf238S5qWQnQI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6KMm8hc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733489892; x=1765025892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gHmtYM0xFbENgH0JOzuO/NpklUBLQ269LXb2gsKedOA=;
  b=k6KMm8hc3+XBPBpG7/FYYK5rW8n8tktnrpqDRuD5GdjHxOdoDJVnxUJY
   5bQoCfYJ2EM/sn/wpSSjx42m79KYINklis4YA2cO1eOyvvl3AjGu9+SEs
   io1SZ+S8+eTtm8RXL9dh6rO9yhN8rBY70mTe3nrGAGjzFEIweujOCN7S4
   kAgdXvjlqCMrfuoPCcAD8w0uo9nsFzB58n3JQi7raZxdof+Sf9hBKVyqn
   E0KPAKx2YCTDzeNumLIsaE0excHloIVivxqyH2uBy/xK6PupT3h4B3Qoc
   sZrCh0DpaExL8ZWC1YPskMYLn39t8w2lY2KHACLqnntn6MRlk/A3oSO2c
   w==;
X-CSE-ConnectionGUID: vpxMdINFT8mWe8QvQ2P1fQ==
X-CSE-MsgGUID: i1iKqZBYTha/dnI8ASarog==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37626192"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37626192"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 04:58:11 -0800
X-CSE-ConnectionGUID: K1z3DFaDRuml0ncnFtb84g==
X-CSE-MsgGUID: U+l5/zCpRpaI5s5WGZsy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="98855019"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Dec 2024 04:58:06 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJXuG-00013r-0N;
	Fri, 06 Dec 2024 12:58:04 +0000
Date: Fri, 6 Dec 2024 20:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <202412062046.0XR2e2V6-lkp@intel.com>
References: <20241206074456.17401-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206074456.17401-2-shradha.t@samsung.com>

Hi Shradha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus mani-mhi/mhi-next linus/master v6.13-rc1 next-20241205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shradha-Todi/PCI-dwc-Add-support-for-vendor-specific-capability-search/20241206-163620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241206074456.17401-2-shradha.t%40samsung.com
patch subject: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability search
config: arm64-randconfig-003-20241206 (https://download.01.org/0day-ci/archive/20241206/202412062046.0XR2e2V6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412062046.0XR2e2V6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412062046.0XR2e2V6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware.c:285:14: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
     285 |         while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
         |                ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     286 |                                         PCI_EXT_CAP_ID_VNDR)) {
         |                                         ~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:285:14: note: place parentheses around the assignment to silence this warning
     285 |         while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
         |                     ^
         |                (
     286 |                                         PCI_EXT_CAP_ID_VNDR)) {
         |                                                             
         |                                                             )
   drivers/pci/controller/dwc/pcie-designware.c:285:14: note: use '==' to turn this assignment into an equality comparison
     285 |         while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
         |                     ^
         |                     ==
   5 warnings generated.


vim +285 drivers/pci/controller/dwc/pcie-designware.c

   279	
   280	u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
   281	{
   282		u16 vsec = 0;
   283		u32 header;
   284	
 > 285		while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
   286						PCI_EXT_CAP_ID_VNDR)) {
   287			header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
   288			if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
   289				return vsec;
   290		}
   291	
   292		return 0;
   293	}
   294	EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
   295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

