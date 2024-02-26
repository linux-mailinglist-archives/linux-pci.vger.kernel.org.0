Return-Path: <linux-pci+bounces-4009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA88867415
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CB0B232EB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28681EB5B;
	Mon, 26 Feb 2024 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nff32nA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C421DA5F;
	Mon, 26 Feb 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948184; cv=none; b=kymbJJJvUiRsonOj2hVNnOW86WVjrLpQBt84dNouA2CYOHHaJybEcoBrBReMoJYtESjHfmafPgiitwLoINik69RWN2SkbafIZp8eTQQwQCoP7iLIQ+aNXvzZYF2Z20uX6TuF38vlGjFuxKLin8kz7r9AaXjiF2KWYSlTfdldsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948184; c=relaxed/simple;
	bh=0g9GcCs8vfketXgTlugah+18Pi8X9CkkeR2K4H65dqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyB4/XgQWdDc8hK07hTE2mFobr1bV3UxDc6I2pQaKNv96fw71P48LWCPXlFTj3sttyZyUPeTcxCmESsDAbaXffuhbTJe/GCKszK5puqOCpMrIc6oQYRLUfN/qRScSt1Vaevw8PX29dglRsIfdG3zN/TcAs9S4vKaCAaYvpJIl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nff32nA7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708948183; x=1740484183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0g9GcCs8vfketXgTlugah+18Pi8X9CkkeR2K4H65dqY=;
  b=nff32nA7aeoi1EMYsZBuKAw8hWnSHscax6hTeCocVNkfvnlMDjCWVhpl
   c4LzuKUR8qa9INZldQbGAQNWL0zU802t6M3uLEhrz69lgdDJYRIgDvID5
   QvjycE2flZzC/8KGK6M9xg0oFv9VNmMGozfipkt3TMInfVHWzwblTgUAu
   FPIE3eepLEcrRMI9xQyrSWwUDRiEahZ26A/SeVbqz9wkgcOvcfT6Ccpix
   e3SpETq+rDvz2iXrlfiAL7pozQiyQhDXkZKnmrGlzL/AIeXVmtxZpIKEE
   WEYsHriROzJNy79a7ZoVevUdea+rmLVQosPJ23/53B7dRb4C973g9r5N5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="28652379"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="28652379"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6678310"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Feb 2024 03:49:35 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reZTn-000AHf-22;
	Mon, 26 Feb 2024 11:49:15 +0000
Date: Mon, 26 Feb 2024 19:48:08 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, baolu.lu@linux.intel.com,
	bhelgaas@google.com, robin.murphy@arm.com, jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
	lukas@wunner.de, yi.l.liu@intel.com, dan.carpenter@linaro.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <202402261910.IZ3PGmH3-lkp@intel.com>
References: <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on e60bf5aa1a74c0652cd12d0cdc02f5c2b5fe5c74]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Zhao/PCI-make-pci_dev_is_disconnected-helper-public-for-other-drivers/20240222-170625
base:   e60bf5aa1a74c0652cd12d0cdc02f5c2b5fe5c74
patch link:    https://lore.kernel.org/r/20240222090251.2849702-4-haifeng.zhao%40linux.intel.com
patch subject: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target device isn't valid
config: x86_64-randconfig-074-20240226 (https://download.01.org/0day-ci/archive/20240226/202402261910.IZ3PGmH3-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240226/202402261910.IZ3PGmH3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402261910.IZ3PGmH3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: device_rbtree_find
   >>> referenced by dmar.c:1346 (drivers/iommu/intel/dmar.c:1346)
   >>>               drivers/iommu/intel/dmar.o:(qi_submit_sync) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

