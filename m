Return-Path: <linux-pci+bounces-23127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD419A56BBD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128CF170185
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4D21CC68;
	Fri,  7 Mar 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aA2mfY+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8621D3FB;
	Fri,  7 Mar 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360718; cv=none; b=eP9uWPC8DQJhaGKtIG/tPdizlKblZR2yoboJyB7vi7g9O6zPuajeGFEMce1JKiDfUCLK7H1mozgDLNPDdEFZDm9C7XiZ7gaSlkKldXjrwG9ZfibK5OZ0ys+ImFJzzQukHcaGk6jMgX4Qp4K99rV7xy2lizwnE/vZ1tiD1NLmfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360718; c=relaxed/simple;
	bh=p3YKblVgNUJ9A5s9Y1bYvwOhcKIHEN1xpybr1xaLV30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxaOI7wZa5TZfRpdQ8I09CdXw3RzOt4MM8SQ0TZCMPARM79W6pwW9HnpN6ey8xqQCp/4aE6octh+19CiyOydJ5h2kxFITfpWbjrZY+yzM1RjCpPQGtIcWF6afp9AgpuL8NvlaSiqB/WwJJJl9YjscDa3DktAIXBn4ICAwaba+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aA2mfY+j; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741360716; x=1772896716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p3YKblVgNUJ9A5s9Y1bYvwOhcKIHEN1xpybr1xaLV30=;
  b=aA2mfY+jlKNO17ipWcE+Tkc394VB3BTMUMdrZ6tfdgHkkaZjKir9Na7Y
   7wJYbBDHbmOEVR07ayUJ4f4bdF6vPFQKJiQSk8AhmNQdAMK4lmZl5226N
   JyS6fg4OdJmAIn9Vu0xUgjrRWXh6FBdR1UaXLmeFCrXoLNDwp7fSzFo18
   0EhMcKASRme0snOiKzdOJNgutymUdZw/xTFLTBaid4MBaSblyGtBK9RFD
   s3UyKTyqG/AALmG8lpQoehCl3G5GHbj/aIwforjgXBoNiJgzLqUZ+Q4iC
   6xHnwSDuzo+KpQRrSVfod1z6iASHFB9k4jYOOcql1enFxd33BTncaoZwn
   A==;
X-CSE-ConnectionGUID: x6yU4Y5CSvOJc+AKKmsjwQ==
X-CSE-MsgGUID: ZGDn9kl8Te2Af+z44fVlOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64851640"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="64851640"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 07:18:36 -0800
X-CSE-ConnectionGUID: 36dOYEWET0ygLpDwWdY2zw==
X-CSE-MsgGUID: Q8v3D0hLRwi3LzzGxjhyAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156561887"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Mar 2025 07:18:32 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqZT4-0000dL-0o;
	Fri, 07 Mar 2025 15:18:30 +0000
Date: Fri, 7 Mar 2025 23:18:02 +0800
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
Message-ID: <202503072251.DHy2O6b1-lkp@intel.com>
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
[also build test ERROR on pci/for-linus linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/PCI-DOE-Rename-Discovery-Response-Data-Object-Contents-to-type/20250306-155550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250306075211.1855177-3-alistair%40alistair23.me
patch subject: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
config: powerpc64-randconfig-003-20250307 (https://download.01.org/0day-ci/archive/20250307/202503072251.DHy2O6b1-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503072251.DHy2O6b1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072251.DHy2O6b1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/platforms/powernv/pci-ioda.c:46:
   arch/powerpc/platforms/powernv/../../../../drivers/pci/pci.h: In function 'pci_doe_sysfs_init':
>> arch/powerpc/platforms/powernv/../../../../drivers/pci/pci.h:488:70: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   arch/powerpc/platforms/powernv/../../../../drivers/pci/pci.h:488:20: note: declared here
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~


vim +/return +488 arch/powerpc/platforms/powernv/../../../../drivers/pci/pci.h

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

