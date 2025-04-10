Return-Path: <linux-pci+bounces-25607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE5A838D5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 08:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989F81B602AD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7F1C3F0C;
	Thu, 10 Apr 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCb9mMPo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8217A309;
	Thu, 10 Apr 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744264990; cv=none; b=hSrDhRKAMBKkstT2j/CSoliSVxVMr852In2lF8tmYFdKrUUnvFwVO1OuQO89AC22ibjQRvAxyTUzFnt4tArnG0CQ71yXV9ke1yMVQ/isdsfp0xr+msQW4dw1ndnwvILjJtFKUJHlbXqvfBLUUVxE3iVhpgY5kidZ+iJufFeQMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744264990; c=relaxed/simple;
	bh=+JIaEozMlGyG70wwHQE8uZ5c8OFIO6Iqup59Ar5RRH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtaQ469wOfUDmHeeQ1dxEP7sUv8Avvrtr46nj1C85jw9OjRVi1VX4HX260qsmpi98NI/FhwqzmDId/jIRvrSs5xJS81VS0v7eC+UbOXCJqIeAKL96kdvF/OPFAXh6Ulmma8yMDGMT3Y9g4kkwO1a2wZjTnGudqOasGLnVIeatBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCb9mMPo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744264988; x=1775800988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+JIaEozMlGyG70wwHQE8uZ5c8OFIO6Iqup59Ar5RRH0=;
  b=PCb9mMPoHr0njPaiQ85KdrHTNuJtoqwkLGlu+sgTXwzMxno8vEePyfoT
   PYRsskhU6RrSJRivBRd2fwX3FDRy1K0Bi7RF2nY5idHjHcUwaXtZiVVwd
   Eoqch+rmC6NrOG22Vk1p6mhhmLCAthFCGBejaoCuyQANGF5w5cdO2cDkg
   KZESFd8/IQqoMJCnUswdVDvrNkqrtGy4paELHT3/ArqcYuIcXiJ1McuCS
   Jdb3V81kuZQccIsHc3ZkJfvQPyTY/N8RZb/RVhZ8wGeA2XD0bJU9xBrCH
   LUiZBoqgdUetjF7SfsvsDg/QfFNf9iKtw1e80ghNW4aVroYD8iMTDWwYS
   w==;
X-CSE-ConnectionGUID: 2RK/F/dASdmaR1YFLJorpQ==
X-CSE-MsgGUID: /BnKZ5NtTdi3KUgVpYMTbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49606441"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="49606441"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 23:03:03 -0700
X-CSE-ConnectionGUID: ejyuXpPUQJiVBuqwcaZGwQ==
X-CSE-MsgGUID: 6cJio8CqRYy/QqGgcu8zhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128779492"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2025 23:02:59 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2l03-0009el-2D;
	Thu, 10 Apr 2025 06:02:55 +0000
Date: Thu, 10 Apr 2025 14:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com,
	robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v9 4/6] PCI: dwc: Use common PCI host bridge APIs for
 finding the capabilities
Message-ID: <202504101228.CX8tAgfW-lkp@intel.com>
References: <20250409034156.92686-5-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409034156.92686-5-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a24588245776dafc227243a01bfbeb8a59bafba9]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-bus-config-read-helper-function/20250409-115839
base:   a24588245776dafc227243a01bfbeb8a59bafba9
patch link:    https://lore.kernel.org/r/20250409034156.92686-5-18255117159%40163.com
patch subject: [PATCH v9 4/6] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
config: arc-randconfig-001-20250410 (https://download.01.org/0day-ci/archive/20250410/202504101228.CX8tAgfW-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504101228.CX8tAgfW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504101228.CX8tAgfW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c: In function '__dw_pcie_find_vsec_capability':
>> drivers/pci/controller/dwc/pcie-designware.c:239:24: error: implicit declaration of function 'dw_pcie_find_next_ext_capability'; did you mean 'pci_find_next_ext_capability'? [-Wimplicit-function-declaration]
     239 |         while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                        pci_find_next_ext_capability


vim +239 drivers/pci/controller/dwc/pcie-designware.c

5b0841fa653f6c Vidya Sagar  2019-08-13  229  
efaf16de43f599 Shradha Todi 2025-02-21  230  static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
efaf16de43f599 Shradha Todi 2025-02-21  231  					  u16 vsec_id)
efaf16de43f599 Shradha Todi 2025-02-21  232  {
efaf16de43f599 Shradha Todi 2025-02-21  233  	u16 vsec = 0;
efaf16de43f599 Shradha Todi 2025-02-21  234  	u32 header;
efaf16de43f599 Shradha Todi 2025-02-21  235  
efaf16de43f599 Shradha Todi 2025-02-21  236  	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
efaf16de43f599 Shradha Todi 2025-02-21  237  		return 0;
efaf16de43f599 Shradha Todi 2025-02-21  238  
efaf16de43f599 Shradha Todi 2025-02-21 @239  	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
efaf16de43f599 Shradha Todi 2025-02-21  240  						       PCI_EXT_CAP_ID_VNDR))) {
efaf16de43f599 Shradha Todi 2025-02-21  241  		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
efaf16de43f599 Shradha Todi 2025-02-21  242  		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
efaf16de43f599 Shradha Todi 2025-02-21  243  			return vsec;
efaf16de43f599 Shradha Todi 2025-02-21  244  	}
efaf16de43f599 Shradha Todi 2025-02-21  245  
efaf16de43f599 Shradha Todi 2025-02-21  246  	return 0;
efaf16de43f599 Shradha Todi 2025-02-21  247  }
efaf16de43f599 Shradha Todi 2025-02-21  248  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

