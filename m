Return-Path: <linux-pci+bounces-45096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A5D38F1E
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 15:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6161301EC40
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7FF1D88AC;
	Sat, 17 Jan 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcEUMHEp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D8219A81;
	Sat, 17 Jan 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768660147; cv=none; b=jDnV9FUzQCMAIy7vXjheisfX0gXGGN+Ubpplfw8goTwIWBriTFjISXiJxGHXvrGGqrxxzLUbn2m4sbwj7mztGfP5xFo31cTw5Xqf0NIoPgUlVYfmzhss/YoL0AeYC/FeMJMGmoDc4xdBqJkXJn7DrWWESBnyYOt9dXqlym0aTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768660147; c=relaxed/simple;
	bh=VdoK6YjYcUZYVwWsOXZdcfJQ7oQefRNJZ53l4CSLxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXaXhF5uTd3S+tuiBSzbYlGBvh9oBkPjWg61RncDt+j3qhwTqRRUdls425LaWtIw65BJtrQEsLVRvv5CGl9eFCrtXSx22c1yFbzQ5uvPzbyJmlxiXPtENG1ppWr1oWfrH3ainxuZSo/7Y921qWkHiS2wGHWGoNl884FmiXYZJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcEUMHEp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768660145; x=1800196145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VdoK6YjYcUZYVwWsOXZdcfJQ7oQefRNJZ53l4CSLxKM=;
  b=dcEUMHEpSnM95OwqfsvyHnbanIqsrKtkX8cPmHev8eUHSQG93ZMqSC17
   rDClyEJzO3IQ1ghB4WUzGTweTVcC65i32pUEmkPJPFiP9/uiyuetx5R/O
   KC5pE3h4Oq9FAj4vcpYa+1IQeSIxKkHizrIsJZZMKJGHc2lBeUCpzjpFg
   abJ+KH8nEQitoVQaZVgnIvAvXrs2h5B8FtrDHURVTuMQLcIFn4VGy9Mbz
   8rrz6Z2wLKc288p1WyiUa4l93okTqBECI/rLQDTSYWPBcEfUIzc0c1xXL
   190jcRuCenDmikI9ad/CbhNneLmicS0t5ysNh7h4LbzFAFcqgLFjuYCUM
   w==;
X-CSE-ConnectionGUID: dT/R+YYDQKScPh5uLYbr1A==
X-CSE-MsgGUID: mdvnSrCcSiKb596Bax6Ssg==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="81317615"
X-IronPort-AV: E=Sophos;i="6.21,234,1763452800"; 
   d="scan'208";a="81317615"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 06:29:05 -0800
X-CSE-ConnectionGUID: XVM2ANnaQHmfxSVkBLRwSg==
X-CSE-MsgGUID: UsffCMT5SXyqLSSe6SZyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,234,1763452800"; 
   d="scan'208";a="205377178"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jan 2026 06:29:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vh7IQ-00000000LvA-0Cmy;
	Sat, 17 Jan 2026 14:28:58 +0000
Date: Sat, 17 Jan 2026 22:28:42 +0800
From: kernel test robot <lkp@intel.com>
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
	rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	huaisheng.ye@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	smadhavan@nvidia.com, vaslot@nvidia.com, vsethi@nvidia.com,
	sdonthineni@nvidia.com, vidyas@nvidia.com, mochs@nvidia.com,
	jsequeira@nvidia.com, Srirangan Madhavan <smsadhavan@nvidia.com>
Subject: Re: [PATCH v3 4/10] PCI: add CXL reset method
Message-ID: <202601172246.rz4Orygn-lkp@intel.com>
References: <20260116014146.2149236-5-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116014146.2149236-5-smadhavan@nvidia.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc5]
[cannot apply to next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/smadhavan-nvidia-com/cxl-move-DVSEC-defines-to-cxl-pci-header/20260116-094457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260116014146.2149236-5-smadhavan%40nvidia.com
patch subject: [PATCH v3 4/10] PCI: add CXL reset method
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260117/202601172246.rz4Orygn-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601172246.rz4Orygn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601172246.rz4Orygn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci.c:4979:10: warning: & has lower precedence than ==; == will be evaluated first [-Wparentheses]
    4979 |         if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/pci.c:4979:10: note: place parentheses around the '==' expression to silence this warning
    4979 |         if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
         |                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/pci.c:4979:10: note: place parentheses around the & expression to evaluate it first
    4979 |         if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
         |             ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +4979 drivers/pci/pci.c

  4956	
  4957	/**
  4958	 * cxl_reset - initiate a cxl reset
  4959	 * @dev: device to reset
  4960	 * @probe: if true, return 0 if device can be reset this way
  4961	 *
  4962	 * Initiate a cxl reset on @dev.
  4963	 */
  4964	static int cxl_reset(struct pci_dev *dev, bool probe)
  4965	{
  4966		u16 dvsec, reg;
  4967		int rc;
  4968	
  4969		dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
  4970						  CXL_DVSEC_PCIE_DEVICE);
  4971		if (!dvsec)
  4972			return -ENOTTY;
  4973	
  4974		/* Check if CXL Reset is supported. */
  4975		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
  4976		if (rc)
  4977			return -ENOTTY;
  4978	
> 4979		if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
  4980			return -ENOTTY;
  4981	
  4982		/*
  4983		 * Expose CXL reset for Type 2 devices.
  4984		 */
  4985		if (!cxl_is_type2_device(dev))
  4986			return -ENOTTY;
  4987	
  4988		if (probe)
  4989			return 0;
  4990	
  4991		if (!pci_wait_for_pending_transaction(dev))
  4992			pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
  4993	
  4994		return cxl_reset_init(dev, dvsec);
  4995	}
  4996	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

