Return-Path: <linux-pci+bounces-21776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79DA3AC78
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 00:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C43A3AF6CD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2C1D9595;
	Tue, 18 Feb 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cT866n2l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF161DDA3D
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921185; cv=none; b=tV4SJTUHFabp7KwK3jsi6XpeRGEVMknzhCk2GLzIJyw+KKjljSmkhkUV97y/YsvD2pYIVx9y+8Ng+U1OZCwz8PbICEVTwmkUAwB1SbqBV7xXNVLCvR/c1lUkpY9pKjdxxiZlwLwdHipqA4RvgyFdEzkgClLvQj1uEAk51bh/1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921185; c=relaxed/simple;
	bh=iLG6kC1Z9W/gapcOdtJ0vxY6R8pgoFt0XvgKEGvT8rc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DKKcchxiDwLtr4fJxnW5+MyuBfzVlznsLRlR7f4oJernl5CRAZKdrr0Kgvd1QKOz9Xy51kRvqTZjKGr1tfNuLY/+v/br3ublexyB9etRAhcQx3dmEdiOLLXXo99nYsaXIQ7GS3R/w805hzpsY3KdFBCAUidNPwruUbFw5LlPcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cT866n2l; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739921184; x=1771457184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iLG6kC1Z9W/gapcOdtJ0vxY6R8pgoFt0XvgKEGvT8rc=;
  b=cT866n2lCqRjBejqe0qT0S+5TbNKsdbJpYok3lWnqjfxSajuX8N5SKU6
   3Yeti/8s/4ysrO+9VK7MwxnxgMZ+o70U/hHjEU5aRBSjbrK89LP4DzBOc
   3lo1/wfpwyc352uzmYedOJsroNdRAKPbbtAzuJ5fsu+XN0c4fq99GEEvS
   K6KJz84A8BzApAXG04e2v2Ub3qSCHiVX4ukHssZbrLpe3WJQczofxl+TQ
   QX8uawxHvFcUGRfZKjTyRkP1AkvxV9l23kb8Q6wJKkiqOW0lMSSBeuBzV
   Px5HzCipUP/2swkc8FcTKSo47aNC8360Pe3U9ja42g/hElelgwv+bc6Ps
   g==;
X-CSE-ConnectionGUID: qeKCrKlkQ/KVr7A0GTYuJg==
X-CSE-MsgGUID: 5dPip6/4S7KGpYy0fKVsnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44289433"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44289433"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 15:26:23 -0800
X-CSE-ConnectionGUID: OPSB3nNpTBmEGVD7G0ZaJw==
X-CSE-MsgGUID: CpoKXM8bTTGQSy/bxVqqhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="115062519"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Feb 2025 15:26:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkWyp-0000xr-0b;
	Tue, 18 Feb 2025 23:26:19 +0000
Date: Wed, 19 Feb 2025 07:26:05 +0800
From: kernel test robot <lkp@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:hotplug 1/2] drivers/pci/hotplug/shpchp_core.c:330:2: error:
 call to undeclared function 'dbg'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202502190711.BtNyZppZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
head:   42e8331215cfd096f86b8605822a0fe8b0a2e2bb
commit: bf8863c9be49b92db646b78fecd445e59a4c1e9f [1/2] PCI: shpchp: Remove unused logging wrappers
config: i386-buildonly-randconfig-004-20250219 (https://download.01.org/0day-ci/archive/20250219/202502190711.BtNyZppZ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502190711.BtNyZppZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502190711.BtNyZppZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/hotplug/shpchp_core.c:330:2: error: call to undeclared function 'dbg'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     330 |         dbg("%s: pci_register_driver = %d\n", __func__, retval);
         |         ^
>> drivers/pci/hotplug/shpchp_core.c:331:2: error: call to undeclared function 'info'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     331 |         info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
         |         ^
   drivers/pci/hotplug/shpchp_core.c:338:2: error: call to undeclared function 'dbg'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     338 |         dbg("unload_shpchpd()\n");
         |         ^
   drivers/pci/hotplug/shpchp_core.c:340:2: error: call to undeclared function 'info'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     340 |         info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
         |         ^
   4 errors generated.
--
>> drivers/pci/hotplug/shpchp_hpc.c:678:2: error: call to undeclared function 'dbg'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     678 |         dbg("Current bus speed = %d\n", bus_speed);
         |         ^
   1 error generated.


vim +/dbg +330 drivers/pci/hotplug/shpchp_core.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  324  
^1da177e4c3f41 Linus Torvalds  2005-04-16  325  static int __init shpcd_init(void)
^1da177e4c3f41 Linus Torvalds  2005-04-16  326  {
f652e7d2916fe2 Bjorn Helgaas   2013-01-11  327  	int retval;
e24dcbef93dbbf Tejun Heo       2010-10-18  328  
^1da177e4c3f41 Linus Torvalds  2005-04-16  329  	retval = pci_register_driver(&shpc_driver);
66bef8c059015b Harvey Harrison 2008-03-03 @330  	dbg("%s: pci_register_driver = %d\n", __func__, retval);
^1da177e4c3f41 Linus Torvalds  2005-04-16 @331  	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
f652e7d2916fe2 Bjorn Helgaas   2013-01-11  332  
^1da177e4c3f41 Linus Torvalds  2005-04-16  333  	return retval;
^1da177e4c3f41 Linus Torvalds  2005-04-16  334  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  335  

:::::: The code at line 330 was first introduced by commit
:::::: 66bef8c059015ba2b36bb5759080336feb01e680 PCI: replace remaining __FUNCTION__ occurrences

:::::: TO: Harvey Harrison <harvey.harrison@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

