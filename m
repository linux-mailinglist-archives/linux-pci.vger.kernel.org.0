Return-Path: <linux-pci+bounces-10229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED993048B
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DAEB22D4F
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA4E1BDD3;
	Sat, 13 Jul 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzsw4PjF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C410E0;
	Sat, 13 Jul 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720859956; cv=none; b=kua87xZk+HKX6N3EEmUd6qY6BwtLmh8rVXjcxItIYJRkbGluDrH1c60sGrMLFRAneUH2JGJ/cf43qalpvqo+gDfOf5m6dmk25aUfwvsvnLFgt26dvOODh5FAA2Qu+0+2ZcLuIkXU8Ry9HVwwkrs7aZud/+c639hwR9jTAdG7T7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720859956; c=relaxed/simple;
	bh=7Ehlij/hfs0O3RF04lOWinYMsT9WzZnkv318/p052kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfKxs5uC3brCFTGBNedM1VRegt63s16O+ntpp1CcyAw3ZDpJnXefzXmOVzfIH7JwSXlFB1NHwxZG0ymjE6Gs+rzA0r3ZGMFVrrBV3AP4VUKev180wb21E4s/XFQvye1CZEmogFtOOZn8PeFQ/0gGc0IbdcT5Fa9bGjQqF88q16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzsw4PjF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720859954; x=1752395954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Ehlij/hfs0O3RF04lOWinYMsT9WzZnkv318/p052kw=;
  b=kzsw4PjFcT6uluBrl3DA+tv+Ri8rF5qEIH38b3g1P3Kh+8pg8n2E6kz1
   iR5HkbWz7k5tRRAyXP6JkGAolkMHUI8Gx0jX4c7jw7VdhCe9mtJDPoozu
   U+tYO69poM81dQ++6JqBZ2uGZlZdT7QF5zoTnmDLZy1V7a4LTEN47NPNO
   PW1kzifwNcQYb+7oQeRQlqvzXAkVfirFKFJJV8FeWDv7WVPMvW+GLwAhQ
   kjjEs7wZjgB4BmzVFB3GXavaSDsBk1vmJ8l1NigSxcze927MXn5KRU1gF
   TVYsJHItSGm8d9N5BoU9OmsoDNVsYVXacJT8joBNtxgFUaD4zWYVw1l0a
   w==;
X-CSE-ConnectionGUID: 9XpQgt4fT7qJjmZdhmv2eA==
X-CSE-MsgGUID: 18l/dQQRReCOuzrsm4ux/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29698598"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="29698598"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 01:39:14 -0700
X-CSE-ConnectionGUID: KPpkD71tS66ZzgJfslQW0w==
X-CSE-MsgGUID: yfphIIOmQxyUiLc+/M67Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="86642299"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Jul 2024 01:39:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSYHb-000bt8-2S;
	Sat, 13 Jul 2024 08:39:07 +0000
Date: Sat, 13 Jul 2024 16:38:13 +0800
From: kernel test robot <lkp@intel.com>
To: superm1@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 1/5] PCI: Use an enum for reset type in pci_dev_wait()
Message-ID: <202407131650.S68TetNP-lkp@intel.com>
References: <20240712181246.811044-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712181246.811044-2-superm1@kernel.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.10-rc7 next-20240712]
[cannot apply to pci/next pci/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/superm1-kernel-org/PCI-Use-an-enum-for-reset-type-in-pci_dev_wait/20240713-022018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240712181246.811044-2-superm1%40kernel.org
patch subject: [PATCH v3 1/5] PCI: Use an enum for reset type in pci_dev_wait()
config: x86_64-randconfig-121-20240713 (https://download.01.org/0day-ci/archive/20240713/202407131650.S68TetNP-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131650.S68TetNP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131650.S68TetNP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/pci.c:184:12: sparse: sparse: symbol 'pci_reset_types' was not declared. Should it be static?
   drivers/pci/pci.c:1208:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1208:36: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1208:36: sparse:     got int
   drivers/pci/pci.c:1367:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [assigned] [usertype] state @@     got int @@
   drivers/pci/pci.c:1367:15: sparse:     expected restricted pci_power_t [assigned] [usertype] state
   drivers/pci/pci.c:1367:15: sparse:     got int
   drivers/pci/pci.c:1369:50: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1369:69: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1422:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1422:28: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1422:28: sparse:     got int
   drivers/pci/pci.c:1512:16: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1512:35: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1512:52: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1512:70: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1534:15: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:1534:15: sparse:    left side has type unsigned short
   drivers/pci/pci.c:1534:15: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c:1546:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1546:28: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1546:28: sparse:     got int
   drivers/pci/pci.c:1563:13: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1563:21: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1565:18: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1565:26: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1588:13: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1588:22: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1920:38: sparse: sparse: array of flexible structures
   drivers/pci/pci.c:2370:44: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2689:60: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2690:30: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2861:20: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2861:38: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2884:49: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2884:67: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:4580:13: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:4580:13: sparse:    left side has type unsigned short
   drivers/pci/pci.c:4580:13: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c:4585:13: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:4585:13: sparse:    left side has type unsigned short
   drivers/pci/pci.c:4585:13: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c: note: in included file (through include/linux/resource_ext.h, include/linux/acpi.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   drivers/pci/pci.c:1163:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted pci_power_t [usertype] @@
   drivers/pci/pci.c:1163:24: sparse:     expected int
   drivers/pci/pci.c:1163:24: sparse:     got restricted pci_power_t [usertype]
   drivers/pci/pci.c:1163:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted pci_power_t [usertype] @@
   drivers/pci/pci.c:1163:24: sparse:     expected int
   drivers/pci/pci.c:1163:24: sparse:     got restricted pci_power_t [usertype]

vim +/pci_reset_types +184 drivers/pci/pci.c

   183	
 > 184	const char * const pci_reset_types[] = {
   185		"FLR",
   186		"AF_FLR",
   187		"PM D3HOT->D0",
   188		"bus reset",
   189		"resume",
   190		"DPC",
   191	};
   192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

