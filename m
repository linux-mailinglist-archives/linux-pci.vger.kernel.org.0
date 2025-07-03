Return-Path: <linux-pci+bounces-31411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF064AF7A77
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65624A3931
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD9B2ED143;
	Thu,  3 Jul 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULlZrb7S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D62ED16D;
	Thu,  3 Jul 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555372; cv=none; b=cYttprR6zPFaeRQF6ufKW8BdqRr1jaD6LH0TTL0ITGdsL4crh2POBB7t4+kx8agy6AH0w/Xd3NHSVPK2QNOUvnS5TQwdspy6K3Mg3LRnFle6HTeoFDMRyjmMNdyhMsUz/K22mjMnfjoCXeR1yxY64xIOmeS2z4H8ScE1gXx5LWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555372; c=relaxed/simple;
	bh=5r2HFBXGqiJbMnELA3izs0vFEPy1VpuRoyBi3VXCRC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddZfMPYvwELhZvJZj1Rql0bwa1PLpVXDB+Dd/4v+m2togDm0bTA9TvBFivL8pp9govfx2dDpzkYcFpa18iXfGjksSAHZC0eBEdMDooxrTchQKIRGJUQxcpUD9iB1WrK54Cl0WZuJB4yypa/k8jEm2HrO6BYYff0vAf1cQL2DK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULlZrb7S; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751555372; x=1783091372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5r2HFBXGqiJbMnELA3izs0vFEPy1VpuRoyBi3VXCRC0=;
  b=ULlZrb7ScveNpJOs/R3asTYtebUfrR2W/2bqadWVMd5l1V825KYSK2yh
   WDVP+P05zb8mwGU3tkreEZ5vfxN/GaNj55SHDXptaaTY7I3FqcRkOJBL4
   U5hdZuTe3DoyOgnuToLdkb1ZLlTQ+lqpagEwhPvy0eTIRFvxZ6MMYg4qp
   kxKmQtjN+EpfeZWlbBrX0mc6JB3mPVASyW4uIjHAmwmHf/0arhlkxNcPT
   6VW1GI+oGCW5iyF1zTblpg5Bg7J7N+SWi6zz2s4Lt/ajfEi8aT54nvZOb
   9kXsS0lnAQo8iO6ZA/UT0HZx7fvNuCvi/rA7fVfJ2eFlhP7CYMOU/B6Am
   Q==;
X-CSE-ConnectionGUID: ui1ul/J9TKejczL766yJzw==
X-CSE-MsgGUID: JMM9fRfXTQCmj4EOQuHEMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64129197"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="64129197"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:09:27 -0700
X-CSE-ConnectionGUID: ecdvsozjQIu7ySN+1HW9TQ==
X-CSE-MsgGUID: GgdvLPP+SjW1ulIRoLI1gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154488587"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Jul 2025 08:09:24 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXLYw-0002Gx-25;
	Thu, 03 Jul 2025 15:09:22 +0000
Date: Thu, 3 Jul 2025 23:09:05 +0800
From: kernel test robot <lkp@intel.com>
To: Shuan He <heshuan@bytedance.com>, bhelgaas@google.com,
	cuiyunhui@bytedance.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, heshuan@bytedance.com,
	sunilvl@ventanamicro.com
Subject: Re: [PATCH] PCI: Fix pci devices double register WARN in the kernel
 starting process
Message-ID: <202507032253.sXSgz4lH-lkp@intel.com>
References: <20250702155112.40124-2-heshuan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702155112.40124-2-heshuan@bytedance.com>

Hi Shuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.16-rc4 next-20250703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuan-He/PCI-Fix-pci-devices-double-register-WARN-in-the-kernel-starting-process/20250703-035442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250702155112.40124-2-heshuan%40bytedance.com
patch subject: [PATCH] PCI: Fix pci devices double register WARN in the kernel starting process
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20250703/202507032253.sXSgz4lH-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250703/202507032253.sXSgz4lH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507032253.sXSgz4lH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/proc.c: In function 'pci_proc_init':
>> drivers/pci/proc.c:476:25: error: too many arguments to function 'pci_dev_assign_added'; expected 1, have 2
     476 |                         pci_dev_assign_added(dev, true);
         |                         ^~~~~~~~~~~~~~~~~~~~      ~~~~
   In file included from drivers/pci/proc.c:18:
   drivers/pci/pci.h:577:20: note: declared here
     577 | static inline void pci_dev_assign_added(struct pci_dev *dev)
         |                    ^~~~~~~~~~~~~~~~~~~~


vim +/pci_dev_assign_added +476 drivers/pci/proc.c

   463	
   464	static int __init pci_proc_init(void)
   465	{
   466		struct pci_dev *dev = NULL;
   467		proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
   468		proc_create_seq("devices", 0, proc_bus_pci_dir,
   469			    &proc_bus_pci_devices_op);
   470		proc_initialized = 1;
   471		pci_lock_rescan_remove();
   472		for_each_pci_dev(dev) {
   473			if (pci_dev_is_added(dev))
   474				continue;
   475			if (!pci_proc_attach_device(dev))
 > 476				pci_dev_assign_added(dev, true);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

