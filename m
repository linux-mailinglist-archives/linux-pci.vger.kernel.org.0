Return-Path: <linux-pci+bounces-21420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FCFA354FD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6488B189185E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57B1519B5;
	Fri, 14 Feb 2025 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNDOPFaF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259C15198C
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501107; cv=none; b=Gi82Vv4eg35XKyZx3v0I1uhDBn6MlCBuWqkFzXCPTrwg4AftuppchrgeOh5JRfGddPG6Vg5lhelkXP++ZianIRuKLDtFHDb4YxZRu638yC0+KP2qACm+iLgnQdgYOZMbye7AhPUWD4k7M1nmS38RJBejri6rl5povfZ4yi4gAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501107; c=relaxed/simple;
	bh=2Rgeq30P6ALUOW6FJB7zmyoT6XFSOzd4ZmRdKmfi+oU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jm9FBw3XtYXVhY8NeKKR5L7iivikTnFUbMTYimmttzpOKBNDxqlzc2IpfMCkYmY3xAalUoviw7N0JAaiPsZF+hGVK30emUi6KQ70wCmsIAphESuKAcyefDvoGMSJNOl+/4G1dIGSZnbG+BPpX8ieaAL+SY7vzWnI/iJbGH1wwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNDOPFaF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739501106; x=1771037106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Rgeq30P6ALUOW6FJB7zmyoT6XFSOzd4ZmRdKmfi+oU=;
  b=aNDOPFaF6+6MlKLqtO5WrmMi2pZpDmDjISDNl8oogsWvMHvGs3EiVeD0
   21FRxP8OtbqQ/rh4kIXzuYYRpcoqr7iOgZiVUFke3aEmE6k+0UGrfIA3z
   LkK3cWvkCpt7rY+J3P7MxYZaRSG3JZ4bWhv5jFta2FaAGlJYoHggYl8nm
   rJ57QomZ0pCj5Z2JpfJ/USSVmXt9ARwMwRW3nYaZGUMA5PRb9NpSdYicM
   TS5ahS/MQ+Z8oq0TXNmYygwXSZY/LSvxdTshExtKOxa1BQGRYoUZNYXWn
   DO4rzcZe132cheq291yhk6i9QtIxoeL4uOX5cEv9lDsWXz1eG6Wr9BWqf
   Q==;
X-CSE-ConnectionGUID: sit79sw1Sq+Qx+uhnbv3sg==
X-CSE-MsgGUID: tUEK49TdQ6Webs3hIjkJWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44003365"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="44003365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:45:05 -0800
X-CSE-ConnectionGUID: GK9yJDK3TYW9pPGAMMbN0w==
X-CSE-MsgGUID: 1vL+HWHURdy29jV3flRRbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="113287258"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Feb 2025 18:45:03 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tilhN-0018zH-09;
	Fri, 14 Feb 2025 02:45:01 +0000
Date: Fri, 14 Feb 2025 10:44:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:aer 1/1] drivers/pci/hotplug/shpchp.h:51:25: error: implicit
 declaration of function 'pci_printk'; did you mean 'pci_intx'?
Message-ID: <202502141005.inOeb0pP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
head:   c928d117f57c9ca1801c0e37019a357f86eb96f1
commit: c928d117f57c9ca1801c0e37019a357f86eb96f1 [1/1] PCI: Descope pci_printk() to aer_printk()
config: i386-buildonly-randconfig-004-20250214 (https://download.01.org/0day-ci/archive/20250214/202502141005.inOeb0pP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502141005.inOeb0pP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141005.inOeb0pP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/hotplug/shpchp_ctrl.c:22:
   drivers/pci/hotplug/shpchp.h: In function 'amd_pogo_errata_restore_misc_reg':
>> drivers/pci/hotplug/shpchp.h:51:25: error: implicit declaration of function 'pci_printk'; did you mean 'pci_intx'? [-Werror=implicit-function-declaration]
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^~~~~~~~~~
   drivers/pci/hotplug/shpchp.h:256:17: note: in expansion of macro 'ctrl_dbg'
     256 |                 ctrl_dbg(p_slot->ctrl,
         |                 ^~~~~~~~
   cc1: some warnings being treated as errors


vim +51 drivers/pci/hotplug/shpchp.h

^1da177e4c3f415 Linus Torvalds   2005-04-16  35  
8352e04eb427db0 Kenji Kaneshige  2006-12-16  36  #define dbg(format, arg...)						\
8352e04eb427db0 Kenji Kaneshige  2006-12-16  37  do {									\
8352e04eb427db0 Kenji Kaneshige  2006-12-16  38  	if (shpchp_debug)						\
1c35b8e538cb625 Frank Seidel     2009-02-06  39  		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
8352e04eb427db0 Kenji Kaneshige  2006-12-16  40  } while (0)
8352e04eb427db0 Kenji Kaneshige  2006-12-16  41  #define err(format, arg...)						\
8352e04eb427db0 Kenji Kaneshige  2006-12-16  42  	printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
8352e04eb427db0 Kenji Kaneshige  2006-12-16  43  #define info(format, arg...)						\
8352e04eb427db0 Kenji Kaneshige  2006-12-16  44  	printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
8352e04eb427db0 Kenji Kaneshige  2006-12-16  45  #define warn(format, arg...)						\
8352e04eb427db0 Kenji Kaneshige  2006-12-16  46  	printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
^1da177e4c3f415 Linus Torvalds   2005-04-16  47  
f98ca311f3a32e2 Taku Izumi       2008-10-23  48  #define ctrl_dbg(ctrl, format, arg...)					\
f98ca311f3a32e2 Taku Izumi       2008-10-23  49  	do {								\
f98ca311f3a32e2 Taku Izumi       2008-10-23  50  		if (shpchp_debug)					\
7506dc798993323 Frederick Lawler 2018-01-18 @51  			pci_printk(KERN_DEBUG, ctrl->pci_dev,		\
f98ca311f3a32e2 Taku Izumi       2008-10-23  52  					format, ## arg);		\
f98ca311f3a32e2 Taku Izumi       2008-10-23  53  	} while (0)
f98ca311f3a32e2 Taku Izumi       2008-10-23  54  #define ctrl_err(ctrl, format, arg...)					\
7506dc798993323 Frederick Lawler 2018-01-18  55  	pci_err(ctrl->pci_dev, format, ## arg)
f98ca311f3a32e2 Taku Izumi       2008-10-23  56  #define ctrl_info(ctrl, format, arg...)					\
7506dc798993323 Frederick Lawler 2018-01-18  57  	pci_info(ctrl->pci_dev, format, ## arg)
f98ca311f3a32e2 Taku Izumi       2008-10-23  58  #define ctrl_warn(ctrl, format, arg...)					\
7506dc798993323 Frederick Lawler 2018-01-18  59  	pci_warn(ctrl->pci_dev, format, ## arg)
f98ca311f3a32e2 Taku Izumi       2008-10-23  60  
f98ca311f3a32e2 Taku Izumi       2008-10-23  61  

:::::: The code at line 51 was first introduced by commit
:::::: 7506dc7989933235e6fc23f3d0516bdbf0f7d1a8 PCI: Add wrappers for dev_printk()

:::::: TO: Frederick Lawler <fred@fredlawl.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

