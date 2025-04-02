Return-Path: <linux-pci+bounces-25157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A45A78DA1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3957A188B6FB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5234423771C;
	Wed,  2 Apr 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTolIx0x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45023814E;
	Wed,  2 Apr 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595143; cv=none; b=VJJ7/U2ExFMluP/h8C32I8XsxiYzmYopdfcOBiQ9j+VbZbQkssQoYb2Xp6c6p0OkzRBhb0fqutheW4mK/JGXN+g8/euEN7dcXPzmbHZ0Iy/TTUBbdi+e3lRD8b4b8w0nvfAW9hYRvFJWjZPFMEcMj1gLYzwUKFJX44+Rz+LgWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595143; c=relaxed/simple;
	bh=lEgXEGc4oeSLWNn+tNIIYFjH345uNAMY4TODj7ii6hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovQpz04qdC6Dk3pPXBylboIzARYbBWi5Q7nF2gXCAsmBLDUy9J8bQfognPZoFtLtJtyv0IjhpuXsZd1q5uzDjnYLdgE12LdzkRNp6G1FCVG5M/lXT6Mve7mSH59+TImlzHE3ksbK3MCE8gZigVdN6x+CHPd/r+KkP50b0KratZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTolIx0x; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743595142; x=1775131142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lEgXEGc4oeSLWNn+tNIIYFjH345uNAMY4TODj7ii6hQ=;
  b=ZTolIx0xUsEnuob2xUOMBzm9gkSjl7TiC3Fy8BWH3y6AisZykptwgWAV
   SqbbK1EcdJvehytJL+Qr2h4OdpqO0PAZ+XN62+7iZQ/DNPYqrnBD/COjY
   QRTdJ/56h5cAW1jgsdObZD/2xEc6a1Cl2PY9VAnJhiTA1uDvJsLkIqocO
   INus2wBz7uuvkhyVpqFTMQRyhVorkAdEUYoZ6cYmcpSGBIrDT10uJ2GKn
   CvHJWDBZuibyUACp0JVCjxGDhrQz/9xRmOantpdGK9c+3FujR09UT1UyM
   WDBal8ZGmZIne5RR3qG7nbztx0CzpV/hxaq3wHklTyUDJqS6GZPIG7x3f
   w==;
X-CSE-ConnectionGUID: 8g0UH4sWRYWi+wIC0yoR6Q==
X-CSE-MsgGUID: daA3yRi/Smq922r7eTcjkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48619360"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="48619360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 04:59:01 -0700
X-CSE-ConnectionGUID: oW1R1pqPSH+xKuAfFo/IGg==
X-CSE-MsgGUID: bR0HajQ8S0KfDxFBNx12MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126577539"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Apr 2025 04:58:58 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tzwkB-000Afi-03;
	Wed, 02 Apr 2025 11:58:55 +0000
Date: Wed, 2 Apr 2025 19:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com,
	robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [v7 3/5] PCI: dwc: Use common PCI host bridge APIs for finding
 the capabilities
Message-ID: <202504021958.YeTPCsW1-lkp@intel.com>
References: <20250402042020.48681-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402042020.48681-4-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on acb4f33713b9f6cadb6143f211714c343465411c]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Refactor-capability-search-into-common-macros/20250402-122544
base:   acb4f33713b9f6cadb6143f211714c343465411c
patch link:    https://lore.kernel.org/r/20250402042020.48681-4-18255117159%40163.com
patch subject: [v7 3/5] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
config: loongarch-randconfig-001-20250402 (https://download.01.org/0day-ci/archive/20250402/202504021958.YeTPCsW1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250402/202504021958.YeTPCsW1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504021958.YeTPCsW1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-designware.c:23:
   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_find_capability':
>> drivers/pci/controller/dwc/pcie-designware.c:218:38: error: 'pcie' undeclared (first use in this function); did you mean 'pci'?
     218 |                                      pcie);
         |                                      ^~~~
   drivers/pci/controller/dwc/../../pci.h:114:18: note: in definition of macro 'PCI_FIND_NEXT_CAP_TTL'
     114 |         read_cfg(args, __pos, 1, (u32 *)&__pos);                        \
         |                  ^~~~
   drivers/pci/controller/dwc/pcie-designware.c:218:38: note: each undeclared identifier is reported only once for each function it appears in
     218 |                                      pcie);
         |                                      ^~~~
   drivers/pci/controller/dwc/../../pci.h:114:18: note: in definition of macro 'PCI_FIND_NEXT_CAP_TTL'
     114 |         read_cfg(args, __pos, 1, (u32 *)&__pos);                        \
         |                  ^~~~
   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_find_ext_capability':
   drivers/pci/controller/dwc/pcie-designware.c:224:71: error: 'pcie' undeclared (first use in this function); did you mean 'pci'?
     224 |         return PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, 0, cap, pcie);
         |                                                                       ^~~~
   drivers/pci/controller/dwc/../../pci.h:156:34: note: in definition of macro 'PCI_FIND_NEXT_EXT_CAPABILITY'
     156 |                 __ret = read_cfg(args, __pos, 4, &__header);                    \
         |                                  ^~~~


vim +218 drivers/pci/controller/dwc/pcie-designware.c

   214	
   215	u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
   216	{
   217		return PCI_FIND_NEXT_CAP_TTL(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
 > 218					     pcie);
   219	}
   220	EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
   221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

