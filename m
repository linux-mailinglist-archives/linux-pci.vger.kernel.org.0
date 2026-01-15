Return-Path: <linux-pci+bounces-44980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4223D26BA5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32B14302724C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C542D780A;
	Thu, 15 Jan 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVxGr7G6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE986334
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498725; cv=none; b=XoOun/m86WnUdPclOT5DEIx9L2DF2s2Kv4Vl5s4b1+8RY6VtCnMMJTzofyEPF369fZPDOe3iHYf45Lk4+IEQwYAPIb0ohsbJ8hEWeeE6aylw/ktT1xu9FSYF6e97y9yDu6RiPAiYrSfBdCzY0o09s1HCH5SpI6hNdTg3ESkzgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498725; c=relaxed/simple;
	bh=4sRXR8XrYOFTjhIfUiu2sPiafKCIC4aSYGJW5tPNZks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRZJzd8wDvwNGEbMJFOEaGAovpRodYOe5EScd0zfBwD9jWAIcWz13S59PPJQFK1xMsSOcMKoD6l3/spNLKbSaRYle8GT+91+ZGq4QxpI/MykTWUrwd3xQk1wWAw83TrGUfxf7nfK6jy219AurqGAumS15tnH5BN07rAgA0SU0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVxGr7G6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768498724; x=1800034724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sRXR8XrYOFTjhIfUiu2sPiafKCIC4aSYGJW5tPNZks=;
  b=jVxGr7G6seDn58QyHYyHga+cdgdSoDFkbzseykevP37Ch811/Cp4jJIL
   dwEdd/uc88oWegIhxMK+NnAs2i+inmj7BU3bBVuU+wlyq2px77N4Pwagu
   Uag72a9x+4GXvVoCwLYiB9TIpfm9+hVeV0H9xw8D+41k7uB7z0O7ibgMa
   x2SdRItv92cuSwFGGrl9Ost4Ro/3HJkdxm/1lb8tWqSmge0JKSuxamCoI
   ClmUjfaW0uk92Xs8SjH22MsTqZxU4qgXXQbAmnPhJc7L1g9MBKfWz6/Dl
   wtYS4cm12+HHXy29YwxzLUb+smmjX8eZ4S3eVFIYjtjIIZ5Fxt8ORiqS9
   A==;
X-CSE-ConnectionGUID: 4SFteXGbS42NCHW82+J7iA==
X-CSE-MsgGUID: woVdYcklQRO0ernIfChtGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69977879"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69977879"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 09:38:43 -0800
X-CSE-ConnectionGUID: WMznQlqfTwSpT/G6Aw0KwA==
X-CSE-MsgGUID: AKlyYRwzQHWVpNB+Mn5R7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="228076697"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jan 2026 09:38:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgRIr-00000000IzI-1tDl;
	Thu, 15 Jan 2026 17:38:37 +0000
Date: Fri, 16 Jan 2026 01:38:17 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: make reset_subordinate hotplug safe
Message-ID: <202601160154.HvY4PSd3-lkp@intel.com>
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
config: loongarch-randconfig-r112-20260115 (https://download.01.org/0day-ci/archive/20260116/202601160154.HvY4PSd3-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601160154.HvY4PSd3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601160154.HvY4PSd3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/pci/pci.c:1155:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1155:36: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1155:36: sparse:     got int
   drivers/pci/pci.c:1334:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [assigned] [usertype] state @@     got int @@
   drivers/pci/pci.c:1334:15: sparse:     expected restricted pci_power_t [assigned] [usertype] state
   drivers/pci/pci.c:1334:15: sparse:     got int
   drivers/pci/pci.c:1336:50: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1336:69: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1389:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1389:28: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1389:28: sparse:     got int
   drivers/pci/pci.c:1479:16: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1479:35: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1479:52: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1479:70: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1504:15: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:1504:15: sparse:    left side has type unsigned short
   drivers/pci/pci.c:1504:15: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c:1516:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1516:28: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1516:28: sparse:     got int
   drivers/pci/pci.c:1533:13: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1533:21: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1535:18: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1535:26: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1558:13: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1558:22: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1863:38: sparse: sparse: array of flexible structures
   drivers/pci/pci.c:2341:44: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2660:60: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2661:30: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2832:20: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2832:38: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2855:49: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2855:67: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:4454:13: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:4454:13: sparse:    left side has type unsigned short
   drivers/pci/pci.c:4454:13: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c:4459:13: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:4459:13: sparse:    left side has type unsigned short
   drivers/pci/pci.c:4459:13: sparse:    right side has type restricted pci_power_t
>> drivers/pci/pci.c:5585:5: sparse: sparse: symbol '__pci_reset_bus' was not declared. Should it be static?
   drivers/pci/pci.c:1110:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted pci_power_t [usertype] @@
   drivers/pci/pci.c:1110:24: sparse:     expected int
   drivers/pci/pci.c:1110:24: sparse:     got restricted pci_power_t [usertype]
   drivers/pci/pci.c:1110:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted pci_power_t [usertype] @@
   drivers/pci/pci.c:1110:24: sparse:     expected int
   drivers/pci/pci.c:1110:24: sparse:     got restricted pci_power_t [usertype]

vim +/__pci_reset_bus +5585 drivers/pci/pci.c

9a3d2b9beefd5b Alex Williamson 2013-08-14  5578  
090a3c5322e900 Alex Williamson 2013-08-08  5579  /**
c6a44ba950d147 Sinan Kaya      2018-07-19  5580   * __pci_reset_bus - Try to reset a PCI bus
090a3c5322e900 Alex Williamson 2013-08-08  5581   * @bus: top level PCI bus to reset
090a3c5322e900 Alex Williamson 2013-08-08  5582   *
61cf16d8bd38c3 Alex Williamson 2013-12-16  5583   * Same as above except return -EAGAIN if the bus cannot be locked
090a3c5322e900 Alex Williamson 2013-08-08  5584   */
2fa046449a82a7 Keith Busch     2024-10-25 @5585  int __pci_reset_bus(struct pci_bus *bus)
090a3c5322e900 Alex Williamson 2013-08-08  5586  {
090a3c5322e900 Alex Williamson 2013-08-08  5587  	int rc;
090a3c5322e900 Alex Williamson 2013-08-08  5588  
9bdc81ce440ec6 Amey Narkhede   2021-08-17  5589  	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
090a3c5322e900 Alex Williamson 2013-08-08  5590  	if (rc)
090a3c5322e900 Alex Williamson 2013-08-08  5591  		return rc;
090a3c5322e900 Alex Williamson 2013-08-08  5592  
61cf16d8bd38c3 Alex Williamson 2013-12-16  5593  	if (pci_bus_trylock(bus)) {
ddefc033eecf23 Alex Williamson 2019-02-18  5594  		pci_bus_save_and_disable_locked(bus);
61cf16d8bd38c3 Alex Williamson 2013-12-16  5595  		might_sleep();
381634cad15b71 Sinan Kaya      2018-07-19  5596  		rc = pci_bridge_secondary_bus_reset(bus->self);
ddefc033eecf23 Alex Williamson 2019-02-18  5597  		pci_bus_restore_locked(bus);
61cf16d8bd38c3 Alex Williamson 2013-12-16  5598  		pci_bus_unlock(bus);
61cf16d8bd38c3 Alex Williamson 2013-12-16  5599  	} else
61cf16d8bd38c3 Alex Williamson 2013-12-16  5600  		rc = -EAGAIN;
090a3c5322e900 Alex Williamson 2013-08-08  5601  
090a3c5322e900 Alex Williamson 2013-08-08  5602  	return rc;
090a3c5322e900 Alex Williamson 2013-08-08  5603  }
8dd7f8036c1232 Sheng Yang      2008-10-21  5604  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

