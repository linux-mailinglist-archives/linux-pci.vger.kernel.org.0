Return-Path: <linux-pci+bounces-23109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D8A56780
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668BB1899206
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA4218E8B;
	Fri,  7 Mar 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG+mFGu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274EF21884B;
	Fri,  7 Mar 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349210; cv=none; b=Wjvc/Jl0AHPUrmBuOUQUXRXspms14h0sBREFhtBZ/LWr35zk5Oq45rlkSk/P8WCcmh1E6xPeCEJjcjauNV+YrfZ3LInCb160x49rLy5F1gZhNf/1w1w+ZcKqrO8zB6jW9dqCYTs9kFAMAEpFQXY4AUn99mKL7qUcU3dX1MVDd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349210; c=relaxed/simple;
	bh=YT4Wlcwkl4YtSQS3RjRTgrksQssnkjkPHEd5VqKqFE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijyvauFmw/OMkgTVRFFjKKhm/84YBeJRrioEliiAqWM8KftV69znuGLrJNzSyNiuhIHOi7aE/XMlU6eZc6axVjzvDI3eRezpYkw4tnX+LzAGy59MsxRpxcOnqb/+ei2pA0MYY9s/Bm41VdM9p1hS76jVB6Q3ArrlyGevZWe/wHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG+mFGu6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741349209; x=1772885209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YT4Wlcwkl4YtSQS3RjRTgrksQssnkjkPHEd5VqKqFE8=;
  b=PG+mFGu65Og6OI4jFLx3Fooishf97g1k1z5FRojL8ENB42z7/6qsELaI
   UKpbtNEJIVGxb5nJJ959q+N3dS+Y7/p7a1cXbq0ln4znB/Lgosq9AnXKT
   Q3lJzxlr53n+2E6x2bVw43kIKVPDKfXJEbyXskoR379hMXxIHE0ZPwgOR
   ZxOSl6nHuzP6KoX2KqA77iue0+t5QOtWRKw45oIxntxuAljCFFodwHUGK
   9gRCeSBW1DLQLvR5rFtcyzg+K8uUjuFAakBVm3xry+r+c3zGBcG9LR4kH
   8LV37KlS17tlzRpJRuUv2bcorL77hjRe0I7d9+AI6dYO75rExWIQid9qi
   A==;
X-CSE-ConnectionGUID: xIP4WP5lTdiVNT2VxNl07A==
X-CSE-MsgGUID: hKPQALgKSc62dx5QG49Bzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42250777"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42250777"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:06:48 -0800
X-CSE-ConnectionGUID: ubeWDkQOTqKZlqyUeyxe9w==
X-CSE-MsgGUID: QSInDB0YTYq+D+MVTG61OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119476459"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2025 04:06:46 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWTS-0000Qt-0g;
	Fri, 07 Mar 2025 12:06:42 +0000
Date: Fri, 7 Mar 2025 20:05:49 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair@alistair23.me>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: oe-kbuild-all@lists.linux.dev, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <202503071950.vvsA3SXV-lkp@intel.com>
References: <20250306075211.1855177-3-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306075211.1855177-3-alistair@alistair23.me>

Hi Alistair,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/PCI-DOE-Rename-Discovery-Response-Data-Object-Contents-to-type/20250306-155550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250306075211.1855177-3-alistair%40alistair23.me
patch subject: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
config: powerpc-icon_defconfig (https://download.01.org/0day-ci/archive/20250307/202503071950.vvsA3SXV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071950.vvsA3SXV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071950.vvsA3SXV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/pci-common.c:44:
   arch/powerpc/kernel/../../../drivers/pci/pci.h: In function 'pci_doe_sysfs_init':
>> arch/powerpc/kernel/../../../drivers/pci/pci.h:488:70: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   arch/powerpc/kernel/../../../drivers/pci/pci.h:488:20: note: declared here
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~


vim +/return +488 arch/powerpc/kernel/../../../drivers/pci/pci.h

   483	
   484	#if defined(CONFIG_PCI_DOE) && defined(CONFIG_SYSFS)
   485	void pci_doe_sysfs_init(struct pci_dev *pci_dev);
   486	void pci_doe_sysfs_teardown(struct pci_dev *pdev);
   487	#else
 > 488	static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
   489	static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
   490	#endif
   491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

