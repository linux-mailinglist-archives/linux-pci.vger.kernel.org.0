Return-Path: <linux-pci+bounces-21775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7CA3AC6B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 00:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1954B174C25
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D61A8F6D;
	Tue, 18 Feb 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy09Eemj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67751D61A1
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920584; cv=none; b=AOcFs5YjqD4W3B+6iUjqYkWwWHni3O6jJzvruQZGKX+PCdEMouO8iDzF/8cuWrYvF/32HjRXIgh0dyRuPM6CZue5j2VWnxAM6ebFt4BSj+Ica+4/jFllMVtB0I6f+nih+a266SZ8KyP827mg/LxOd6m1m4gydEljNnTuqbPcfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920584; c=relaxed/simple;
	bh=1/cYWTAkl57CmWDHOZlHOjFWVo2sF0ZzKAbUx9sM2Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+gIfTrW6HxT7JJloGgfpGvm2b9bl3ijoVNoIkyDp8vAUC3lxhRpDuZMc5+20kKXPwJcOBwGyO+bdkGvMDz4r+iiqoMHlqMNz8sL/jtmJkK2yOR8d4wh4K1TWRoEg/BXOcRAUw2HzZv7lYQamt5xwW71BxkMRZhoFalTDsOkh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy09Eemj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739920583; x=1771456583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1/cYWTAkl57CmWDHOZlHOjFWVo2sF0ZzKAbUx9sM2Ak=;
  b=Qy09Eemj/rt4ZRK+wYFensqZf1Gkb8LmiMExVPT65tdY0RI4Q9+0863L
   pRxU2tUgCm2GPCcdofzP95Qg89GqCXTxyWZcSU0t/F2da5aed2FxNDI+m
   KIJwvoKmt0tfznkjBBrrDIlufOxYscONmbg2TLq8JXM1Na9xX0EPg6y9D
   K563fSJywuCCzMshLPc/rBLSj9HHJOg9HnVSo6cQLLdFA6WiWR6xONMym
   OwJZtJx+jmGqU3wPrzaBOzZWGxBWpZ9Lnbn3UPHz7J+7YAf7x2erK1zC+
   SjKxENyojJ3i9pVGhZNcw7wxSm+wLVuFJ9+46f0iGZ+gForEyiAB9q1m7
   w==;
X-CSE-ConnectionGUID: a+XTi533THujK1JLymbh6Q==
X-CSE-MsgGUID: aPv+GY4PSQiAzYNYI8BZvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51624039"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="51624039"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 15:16:22 -0800
X-CSE-ConnectionGUID: HbqaA4bWSleolyIZEP7RVA==
X-CSE-MsgGUID: l3KN5cScQZi7Q2RZ0Vyt6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119648941"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 15:16:20 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkWp8-0000xT-1g;
	Tue, 18 Feb 2025 23:16:18 +0000
Date: Wed, 19 Feb 2025 07:15:41 +0800
From: kernel test robot <lkp@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:hotplug 1/2] drivers/pci/hotplug/shpchp_core.c:330:9: error:
 implicit declaration of function 'dbg'
Message-ID: <202502190754.ogAfcyNP-lkp@intel.com>
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
config: arm-randconfig-001-20250219 (https://download.01.org/0day-ci/archive/20250219/202502190754.ogAfcyNP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502190754.ogAfcyNP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502190754.ogAfcyNP-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/hotplug/shpchp_core.c: In function 'shpcd_init':
>> drivers/pci/hotplug/shpchp_core.c:330:9: error: implicit declaration of function 'dbg' [-Wimplicit-function-declaration]
     330 |         dbg("%s: pci_register_driver = %d\n", __func__, retval);
         |         ^~~
>> drivers/pci/hotplug/shpchp_core.c:331:9: error: implicit declaration of function 'info' [-Wimplicit-function-declaration]
     331 |         info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
         |         ^~~~
--
   drivers/pci/hotplug/shpchp_hpc.c: In function 'shpc_get_cur_bus_speed':
>> drivers/pci/hotplug/shpchp_hpc.c:678:9: error: implicit declaration of function 'dbg' [-Wimplicit-function-declaration]
     678 |         dbg("Current bus speed = %d\n", bus_speed);
         |         ^~~


vim +/dbg +330 drivers/pci/hotplug/shpchp_core.c

^1da177e4c3f415 Linus Torvalds  2005-04-16  324  
^1da177e4c3f415 Linus Torvalds  2005-04-16  325  static int __init shpcd_init(void)
^1da177e4c3f415 Linus Torvalds  2005-04-16  326  {
f652e7d2916fe2f Bjorn Helgaas   2013-01-11  327  	int retval;
e24dcbef93dbbf5 Tejun Heo       2010-10-18  328  
^1da177e4c3f415 Linus Torvalds  2005-04-16  329  	retval = pci_register_driver(&shpc_driver);
66bef8c059015ba Harvey Harrison 2008-03-03 @330  	dbg("%s: pci_register_driver = %d\n", __func__, retval);
^1da177e4c3f415 Linus Torvalds  2005-04-16 @331  	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
f652e7d2916fe2f Bjorn Helgaas   2013-01-11  332  
^1da177e4c3f415 Linus Torvalds  2005-04-16  333  	return retval;
^1da177e4c3f415 Linus Torvalds  2005-04-16  334  }
^1da177e4c3f415 Linus Torvalds  2005-04-16  335  

:::::: The code at line 330 was first introduced by commit
:::::: 66bef8c059015ba2b36bb5759080336feb01e680 PCI: replace remaining __FUNCTION__ occurrences

:::::: TO: Harvey Harrison <harvey.harrison@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

