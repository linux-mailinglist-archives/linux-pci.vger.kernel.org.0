Return-Path: <linux-pci+bounces-26782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797CA9CF94
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 19:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F6C1BC5D95
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2911FE455;
	Fri, 25 Apr 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzJ5A5BP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E211FBC92;
	Fri, 25 Apr 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602186; cv=none; b=pXPGjROEBY3CnZgenSyzQNn7bcEsdCrd0uV4V+fycUXDz1JFfwfPOLaWUMW1YDlvJF5Q7/gye/G75T+VZSfFjgrcNeqxBIZTD7+wqPam1WSFvTGPBx8i+xCpJLFTXkaTAvtBAk7aRSSBfuoXRiK7X2ks12wUuusBhxSOlfj+0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602186; c=relaxed/simple;
	bh=rIUIE776wCGre/V+cMF7M4GdfRE2LRV4+lSyBGHQX+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIua7WGSr2D16J5J2fXtFDFgGCM5mwRfe7AR156fAVQcCBlol/Mj+H0MylV19CZR81JTrnOIcClCjkJyZabFp3QzZ6KVIu1eXHygOIMaxCVjNjbHp/MVzXUW5T8f/W7ZhF7ca/mauzPF2x18K/ZvhelSro/gcAedK7LSGQWKLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzJ5A5BP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745602184; x=1777138184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rIUIE776wCGre/V+cMF7M4GdfRE2LRV4+lSyBGHQX+c=;
  b=CzJ5A5BPpSsC1iXhJrh1kct9mtDFO6kE2AKO4o7iNlG33FWMpDIjX2t4
   dNrZEDjplEpriPGkVeajFFMUn73umNEVrBpbtOc7ZRfIAafgwTNPqwS46
   pHd09DGc09WmYTTPfUH3H/SesyjfZwS2mIrXNXH5GsHf7pHgR0mJ0gyPA
   OOCLSHf8X0mmnQMX/SltsOmXRDAPZlH/bO3y6KihGBlsJ4NYTWE0TTyqK
   ja3cwD1gbOh76vPMbYpDHY9iC5bm4urWNVDm2LWKXa4Mt9EBGyenUtr8A
   80ebGSIEYXvBWMnvJIVxX361c7WD1AVXSod95I256eB3xHY/5STHOISio
   A==;
X-CSE-ConnectionGUID: 8uP4PM3XRvKhXx+j/4FYQA==
X-CSE-MsgGUID: uaMwI02yQo+aHQddMrzhlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="57917788"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="57917788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:29:42 -0700
X-CSE-ConnectionGUID: OysVDFxzRcmRFl4PfL9zBw==
X-CSE-MsgGUID: x0YhZtSzSKO6ext38AbRwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133934294"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Apr 2025 10:29:39 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8Mro-0005Oh-1A;
	Fri, 25 Apr 2025 17:29:36 +0000
Date: Sat, 26 Apr 2025 01:29:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 1/4] PCI: Add debugfs support for exposing PTM context
Message-ID: <202504260126.wxQ1Dp0M-lkp@intel.com>
References: <20250424-pcie-ptm-v3-1-c929ebd2821c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-pcie-ptm-v3-1-c929ebd2821c@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0af2f6be1b4281385b618cb86ad946eded089ac8]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-Add-debugfs-support-for-exposing-PTM-context/20250425-001237
base:   0af2f6be1b4281385b618cb86ad946eded089ac8
patch link:    https://lore.kernel.org/r/20250424-pcie-ptm-v3-1-c929ebd2821c%40linaro.org
patch subject: [PATCH v3 1/4] PCI: Add debugfs support for exposing PTM context
config: riscv-randconfig-001-20250425 (https://download.01.org/0day-ci/archive/20250426/202504260126.wxQ1Dp0M-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504260126.wxQ1Dp0M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504260126.wxQ1Dp0M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/pci-pf-stub.c:10:
   include/linux/pci.h: In function 'pcie_ptm_create_debugfs':
>> include/linux/pci.h:1911:39: warning: no return statement in function returning non-void [-Wreturn-type]
    1911 |                          const struct pcie_ptm_ops *ops) { }
         |                                       ^~~~~~~~~~~~


vim +1911 include/linux/pci.h

  1903	
  1904	#if IS_ENABLED(CONFIG_DEBUG_FS) && IS_ENABLED(CONFIG_PCIE_PTM)
  1905	struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
  1906							const struct pcie_ptm_ops *ops);
  1907	void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs);
  1908	#else
  1909	static inline struct pci_ptm_debugfs
  1910	*pcie_ptm_create_debugfs(struct device *dev, void *pdata,
> 1911				 const struct pcie_ptm_ops *ops) { }
  1912	static inline void
  1913	pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
  1914	#endif
  1915	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

