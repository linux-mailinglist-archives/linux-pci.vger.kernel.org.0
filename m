Return-Path: <linux-pci+bounces-44935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E62D2402C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D07A301A49B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E736C5AD;
	Thu, 15 Jan 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0boFaMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AD3385B2
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473962; cv=none; b=VAAMIivlL752QxpX7zQQ/wxScE0wEFGj2MU42TFa71oYRqGb7WZ4gL47C11bWT19Y0730FqAtDjyNOn/8ktqhJYwmm/8q1ShDC0+CQcQXS+7NtlIJEWev7yEsPB050kLFhmGKWCh/K08yaugMQ7pPH4sbYbO4PMxO4W3nYPoMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473962; c=relaxed/simple;
	bh=Rs7tiW+Ht2ryd6v+R/DQDncmn/wx1Hi/VAfI0ZLey4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGME/f/8X8fKUi4LwUm15y4tBop6Yd5mxCJ+4i8JqHXJdD1fdKhm23QwrAnuGuOWnhkmCvqYDAFtM+Xhpl6NgU3YPIQyE9jhTTNxsM08apIiN68HXbiPjVcDIL/3LCA4h8AdNTW4UUKX/JklgM5yifKblIg2TQZ5JHZUQYigps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0boFaMR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768473960; x=1800009960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rs7tiW+Ht2ryd6v+R/DQDncmn/wx1Hi/VAfI0ZLey4s=;
  b=H0boFaMRIW7U2TNAfH+b/mUPq5pljPvVxDbp24d/3IfWlcJVWX+8Z9MK
   6QnGBvNl2vzVqQ+j8xQzCJN/hKTaYEHxZJu3JXuZ6ZiV2P8mYFo1ky7dZ
   bfwWXqHrrrFyXFgYni1QyuCwPaVJ8pQy4//ARScu+S7TJilQZMC8zZYmx
   T2j0mWbGgNePG1PuXEPIijKXgFE4JqUrR4y61pH2QDEzy+7JWeY3hp8ru
   qqiVykgWjtQV6G6vCECl1lCcQ03nVFkx7+Y0qvarElVkM4cnjI2Tk7NvZ
   yBY6Vhmv8WR+/pTVroOSJ1felMk0WeLJS39jie7nF2Yj60zwyYF1TJQFS
   Q==;
X-CSE-ConnectionGUID: XJ0NoOn7Rs+IUhdbCtu48w==
X-CSE-MsgGUID: EyRNPyN1QYKFYMHtk+dwSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68984518"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="68984518"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 02:46:00 -0800
X-CSE-ConnectionGUID: ifMPV6q3SUK2W6UQPKzAXg==
X-CSE-MsgGUID: MBjcHsW1R0yAYMgvJaI45w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="235634835"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Jan 2026 02:45:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgKrU-00000000HrK-0KLU;
	Thu, 15 Jan 2026 10:45:56 +0000
Date: Thu, 15 Jan 2026 18:45:07 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: make reset_subordinate hotplug safe
Message-ID: <202601151808.EGC5maN5-lkp@intel.com>
References: <20260114185821.704089-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114185821.704089-1-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc5 next-20260115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/pci-make-reset_subordinate-hotplug-safe/20260115-030004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260114185821.704089-1-kbusch%40meta.com
patch subject: [PATCH] pci: make reset_subordinate hotplug safe
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260115/202601151808.EGC5maN5-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601151808.EGC5maN5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601151808.EGC5maN5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci.c:5585:5: warning: no previous prototype for '__pci_reset_bus' [-Wmissing-prototypes]
    5585 | int __pci_reset_bus(struct pci_bus *bus)
         |     ^~~~~~~~~~~~~~~


vim +/__pci_reset_bus +5585 drivers/pci/pci.c

9a3d2b9beefd5b0 Alex Williamson 2013-08-14  5578  
090a3c5322e900f Alex Williamson 2013-08-08  5579  /**
c6a44ba950d147e Sinan Kaya      2018-07-19  5580   * __pci_reset_bus - Try to reset a PCI bus
090a3c5322e900f Alex Williamson 2013-08-08  5581   * @bus: top level PCI bus to reset
090a3c5322e900f Alex Williamson 2013-08-08  5582   *
61cf16d8bd38c3d Alex Williamson 2013-12-16  5583   * Same as above except return -EAGAIN if the bus cannot be locked
090a3c5322e900f Alex Williamson 2013-08-08  5584   */
2fa046449a82a7d Keith Busch     2024-10-25 @5585  int __pci_reset_bus(struct pci_bus *bus)
090a3c5322e900f Alex Williamson 2013-08-08  5586  {
090a3c5322e900f Alex Williamson 2013-08-08  5587  	int rc;
090a3c5322e900f Alex Williamson 2013-08-08  5588  
9bdc81ce440ec6e Amey Narkhede   2021-08-17  5589  	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
090a3c5322e900f Alex Williamson 2013-08-08  5590  	if (rc)
090a3c5322e900f Alex Williamson 2013-08-08  5591  		return rc;
090a3c5322e900f Alex Williamson 2013-08-08  5592  
61cf16d8bd38c3d Alex Williamson 2013-12-16  5593  	if (pci_bus_trylock(bus)) {
ddefc033eecf23f Alex Williamson 2019-02-18  5594  		pci_bus_save_and_disable_locked(bus);
61cf16d8bd38c3d Alex Williamson 2013-12-16  5595  		might_sleep();
381634cad15b711 Sinan Kaya      2018-07-19  5596  		rc = pci_bridge_secondary_bus_reset(bus->self);
ddefc033eecf23f Alex Williamson 2019-02-18  5597  		pci_bus_restore_locked(bus);
61cf16d8bd38c3d Alex Williamson 2013-12-16  5598  		pci_bus_unlock(bus);
61cf16d8bd38c3d Alex Williamson 2013-12-16  5599  	} else
61cf16d8bd38c3d Alex Williamson 2013-12-16  5600  		rc = -EAGAIN;
090a3c5322e900f Alex Williamson 2013-08-08  5601  
090a3c5322e900f Alex Williamson 2013-08-08  5602  	return rc;
090a3c5322e900f Alex Williamson 2013-08-08  5603  }
8dd7f8036c12329 Sheng Yang      2008-10-21  5604  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

