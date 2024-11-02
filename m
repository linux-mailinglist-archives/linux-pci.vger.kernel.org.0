Return-Path: <linux-pci+bounces-15856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F349BA242
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 20:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ED32830F6
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEED1AB535;
	Sat,  2 Nov 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7pU1/fY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE41A4E9E
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577355; cv=none; b=QXUe8xcWZ5R3IbL6lglUwD16e/6qIF3Fnh6XYpmMuYMiFUZ5L6u8szj4WZQ9PaGcT8T3EW1qXbBT1l1P1bfKsPCfI5EfVki5tjDMrNvirOwdIC+Ma8v1bEvcXdVuh9C6jIhNwMG60E4lUDcTEDM+kbjXMr4aZb+7hd0nW56WRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577355; c=relaxed/simple;
	bh=I4C8qnFbgkbJMLpVH/O6dUyaP6cZ4bKm2rAYeFS4+LI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hOHX3STHMYd48nacK4ZLbSS3DWiiWnPmWKbvd4usdAPkTWePhYIEnbSyclq2QWSFt0jkbQCJhDbpyX+ME6FekgSuln1t7wVrvTNKQxfrAe4IRdOFOC4dbRCAEai0/8wFP2sYr67+XndAGljC+r8DVm4OQ9VvPJFdL+8k+NzB2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7pU1/fY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730577354; x=1762113354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I4C8qnFbgkbJMLpVH/O6dUyaP6cZ4bKm2rAYeFS4+LI=;
  b=J7pU1/fYvWgvusNPePjO2lzT6augy0SghJ4Z3xdZi16sgXz3Ah6jJfeI
   D0+Yw/Xk++Xbd+ICwoa2J+D3+b6mgqxYJUbrQqsOIe5pGH3tkMQY+k1dc
   /dSVjxm6ZTe8hKrrqrE9E4GQ/BoOxvgKsGYrXr5xeMWYNw4Jhtm7+D9rG
   vS994eRzw9F9gXx7l+4PoLzb6oFVTdg8jSvqPdbAYUDBHAnKlA55s++Yy
   J3bTqxwwTops7ABK/Vq2eGhIxgAllgBZGskhO9EjanYsyaJ5ckZhsKT+T
   sU0FJJ7hBsI4FqUrnEfcQPeStlikLMEmGGbKcOsf+n7g6DmMp5eir4FxU
   Q==;
X-CSE-ConnectionGUID: cLQFG6MYSTCau2ro/NzagQ==
X-CSE-MsgGUID: qgfsnwk/Sfqg5uyOkEUMlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30270376"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30270376"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 12:55:53 -0700
X-CSE-ConnectionGUID: kmaQynIrScWaXArVbB0BFQ==
X-CSE-MsgGUID: anPNX85ISeq1PZLmEtcHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88024913"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Nov 2024 12:55:52 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7KDt-000jI7-0V;
	Sat, 02 Nov 2024 19:55:49 +0000
Date: Sun, 3 Nov 2024 03:55:16 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [pci:bwctrl 2/5] drivers/pci/msi/../pci.h:834:1: error: expected
 identifier or '('
Message-ID: <202411030348.K5M6Sbow-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
head:   5ccc52fd1e5a9a7602b6e20ce931a7fd4f3be87b
commit: 5f2710a4c2754c3c63bbe751fe1c54eb7f5c8441 [2/5] PCI/pwrctl: Create pwrctl devices only if at least one power supply is present
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241103/202411030348.K5M6Sbow-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241103/202411030348.K5M6Sbow-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411030348.K5M6Sbow-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/msi/pcidev_msi.c:5:
   In file included from drivers/pci/msi/../pci.h:5:
   In file included from include/linux/pci.h:1662:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pci/msi/pcidev_msi.c:5:
>> drivers/pci/msi/../pci.h:834:1: error: expected identifier or '('
     834 | {
         | ^
   4 warnings and 1 error generated.


vim +834 drivers/pci/msi/../pci.h

   832	
   833	static inline bool of_pci_is_supply_present(struct device_node *np);
 > 834	{
   835		return false;
   836	}
   837	#endif /* CONFIG_OF */
   838	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

