Return-Path: <linux-pci+bounces-22072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB45A405FB
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 08:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD93B168515
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D61F2BB5;
	Sat, 22 Feb 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqwunMRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19E1EF0B2;
	Sat, 22 Feb 2025 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208103; cv=none; b=D46bgdr8e0CQnwyd4M+25Bj0PADjBa6qZylAdOozDNvNWR+gTnrLgFWGsKaO0ZxPbQK62tV+lDX2q6CmgELONKVqCi0xOFgTtV3javWHi1CVU0d+PDTKLaocb3DKQ6jP0Tjxk9q7cZB9wwr2z/S4OJe5hi7nkjM2+7Z5dzkC0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208103; c=relaxed/simple;
	bh=fsY5t112Q8WM/mdH96kIkcjOJgGQNS0f/svA6RtETtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJEd1bWfPWHg/2jljRYZlwMYaWmwVGIf2roe0xv/OUehTSsDkk0Uudt+LyXkurePTitSIjPREM+d+j/Ae6+F1KUYPvdOIbE/iz4ZXzGscAb+3rU8iWINYCiYCNxMXXEl8e0bKQdJU7ZUgbxNfRA40O1XQEN4SglOdoWMlZpcjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqwunMRA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740208101; x=1771744101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsY5t112Q8WM/mdH96kIkcjOJgGQNS0f/svA6RtETtk=;
  b=SqwunMRAQM6s901/4UrngrC+CIJxFiwUoW8Tx9xLz9DbeKRNNxL4Ejb5
   GAsvuuuCR4IA2HvS25bhy6YD8W9SOP0vvh0WGt3300rqx2jkPafe4aDrw
   ifMzOTlXUizxUBi+Zz3HzVIviUFx7iDC91yNE0IAB+IvhfYjdQGE9J6rl
   /fwj4HPJJQI6RlDDeeW8xFWOT5My+3F24eNhiCJwvmTeSFNO1G+f5uowr
   LhDxfo+tUCYf7fWMbCZteigrs0BXt+zWTJl32kOqZCEElu0e+PtETz0eE
   s7w87LCw343jzN6oG10W4TQ3/ecD311Xq83PmzbiZBt8hX+3CMHJxQOai
   w==;
X-CSE-ConnectionGUID: d1v5ws1gStWRgWk1+e+Cog==
X-CSE-MsgGUID: hAdDTQWDRfqiNDBptn/cHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="66400784"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="66400784"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 23:08:20 -0800
X-CSE-ConnectionGUID: ac7/Se+NRD+BbfAHzKfzKA==
X-CSE-MsgGUID: gfp972L3RJKUyasanhGhfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="115763826"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Feb 2025 23:08:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tljcR-0006Mh-12;
	Sat, 22 Feb 2025 07:08:12 +0000
Date: Sat, 22 Feb 2025 15:08:04 +0800
From: kernel test robot <lkp@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-cxl@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset
Message-ID: <202502221438.j0UgOryU-lkp@intel.com>
References: <20250221043906.1593189-3-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221043906.1593189-3-smadhavan@nvidia.com>

Hi Srirangan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250220]
[cannot apply to pci/next pci/for-linus linus/master v6.14-rc3 v6.14-rc2 v6.14-rc1 v6.14-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srirangan-Madhavan/cxl-de-duplicate-cxl-DVSEC-reg-defines/20250221-124043
base:   next-20250220
patch link:    https://lore.kernel.org/r/20250221043906.1593189-3-smadhavan%40nvidia.com
patch subject: [PATCH v2 2/2] cxl: add support for cxl reset
config: arm64-randconfig-003-20250222 (https://download.01.org/0day-ci/archive/20250222/202502221438.j0UgOryU-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502221438.j0UgOryU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502221438.j0UgOryU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci.c:5258:10: warning: & has lower precedence than ==; == will be evaluated first [-Wparentheses]
    5258 |         if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/pci.c:5258:10: note: place parentheses around the '==' expression to silence this warning
    5258 |         if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
         |                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/pci.c:5258:10: note: place parentheses around the & expression to evaluate it first
    5258 |         if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
         |             ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +5258 drivers/pci/pci.c

  5235	
  5236	/**
  5237	 * cxl_reset - initiate a cxl reset
  5238	 * @dev: device to reset
  5239	 * @probe: if true, return 0 if device can be reset this way
  5240	 *
  5241	 * Initiate a cxl reset on @dev.
  5242	 */
  5243	static int cxl_reset(struct pci_dev *dev, bool probe)
  5244	{
  5245		u16 dvsec, reg;
  5246		int rc;
  5247	
  5248		dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
  5249						  CXL_DVSEC_PCIE_DEVICE);
  5250		if (!dvsec)
  5251			return -ENOTTY;
  5252	
  5253		/* Check if CXL Reset is supported. */
  5254		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
  5255		if (rc)
  5256			return -ENOTTY;
  5257	
> 5258		if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
  5259			return -ENOTTY;
  5260	
  5261		if (probe)
  5262			return 0;
  5263	
  5264		rc = cxl_reset_prepare(dev, dvsec);
  5265		if (rc)
  5266			return rc;
  5267	
  5268		return cxl_reset_init(dev, dvsec);
  5269	}
  5270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

