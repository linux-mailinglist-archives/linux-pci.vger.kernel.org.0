Return-Path: <linux-pci+bounces-13021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53476974798
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 02:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1390B287216
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8214290;
	Wed, 11 Sep 2024 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZywEcea8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC1AD5A
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016062; cv=none; b=D4lO6sw2QgtHN9GfBgl0S3NBI7uDENLP9rHsfIEMGkMvsNfQ07M/JbdsMojQ8xSxuw3TsBwP15sa35vS/dZ8NnZBEp8EKF9jL5jVDrVVxgpKJQ1u8NP9mMdMQHB/u+inqZPKXdgB5aCEg5DPcqpwRMxGtp1sXgEUKJyUeVSlTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016062; c=relaxed/simple;
	bh=+rZ9RVMd9rJmPj3ZMZ+np0DxGyN8HzeqK2hMKMC1JBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upY5OY9wDJwXGec4VtFo37kTl2DS2wl33Wpa9PfnikaH6Txs2/OmXbsQjjNeFqEdoJkEWKLGW1cfidm7/AxoEhn3PINTLIJFIIbRr9XCo7kcvWtvOnN0kv9/nsV2MaM3GYcOueeeuXIkdXaOP8vydOSlGvjvrEBH5qHyFVzgpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZywEcea8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726016062; x=1757552062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+rZ9RVMd9rJmPj3ZMZ+np0DxGyN8HzeqK2hMKMC1JBA=;
  b=ZywEcea8IAIGG12bYl3jnfWmg/WG5883iDzWfF2WPF12guDI7sX7OoAi
   E03prV5dJ5zCGftSga+ySbKoh1/998oI9VtYcbMLvRemGUKH5vjw6sxMR
   1D78BS+bD8y9oD3fVDWtfeyQmoXkSR8az1XQ0PV+aRgiS2pSSy0q1RJVZ
   i9o5JHkw5cYb+FwIGV1krhgbdDZ8RprVIrJmvq+zNOBHEYSSz+AD3s3N+
   68ccdDqHBKZyaWHN8+6T/EHDq0a9g2Sh9GHwWI7elBsesHE2ClBEdTvWo
   e4TgI6/R7Xf65nxAIA3VnYNHS1JmnUY3JKRUVLFSdxcyV8ryeghPHe4gk
   w==;
X-CSE-ConnectionGUID: E2KU+EzfSZu4uAfGoUKalg==
X-CSE-MsgGUID: Qj6/KBpFTcSJQaiXqvJEYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="27714906"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="27714906"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 17:54:21 -0700
X-CSE-ConnectionGUID: uAaxVga6S3WvggkQTLI6AQ==
X-CSE-MsgGUID: GKg2f3YrRd+Aoj2c35hRqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67491946"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Sep 2024 17:54:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soBce-0002tS-1z;
	Wed, 11 Sep 2024 00:54:16 +0000
Date: Wed, 11 Sep 2024 08:53:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Kobayashi, Daisuke" <kobayashi.da-06@fujitsu.com>,
	linux-pci@vger.kernel.org, kw@linux.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Kobayashi, Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: Re: [PATCH v3] Export PBEC Data register into sysfs
Message-ID: <202409110845.zaUjhBmy-lkp@intel.com>
References: <20240910090951.332773-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910090951.332773-1-kobayashi.da-06@fujitsu.com>

Hi Kobayashi,Daisuke,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.11-rc7 next-20240910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kobayashi-Daisuke/Export-PBEC-Data-register-into-sysfs/20240910-170834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240910090951.332773-1-kobayashi.da-06%40fujitsu.com
patch subject: [PATCH v3] Export PBEC Data register into sysfs
config: arm-randconfig-002-20240911 (https://download.01.org/0day-ci/archive/20240911/202409110845.zaUjhBmy-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409110845.zaUjhBmy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409110845.zaUjhBmy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/pci-sysfs.c:18:
   In file included from include/linux/pci.h:1646:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/pci/pci-sysfs.c:663:3: error: use of undeclared identifier 'dev_attr_pbec'; did you mean 'dev_attr_irq'?
     663 |         &dev_attr_pbec.attr,
         |          ^~~~~~~~~~~~~
         |          dev_attr_irq
   drivers/pci/pci-sysfs.c:76:8: note: 'dev_attr_irq' declared here
      76 | static DEVICE_ATTR_RO(irq);
         |        ^
   include/linux/device.h:199:26: note: expanded from macro 'DEVICE_ATTR_RO'
     199 |         struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
         |                                 ^
   <scratch space>:58:1: note: expanded from here
      58 | dev_attr_irq
         | ^
   1 warning and 1 error generated.


vim +663 drivers/pci/pci-sysfs.c

   657	
   658	static struct attribute *pcie_dev_attrs[] = {
   659		&dev_attr_current_link_speed.attr,
   660		&dev_attr_current_link_width.attr,
   661		&dev_attr_max_link_width.attr,
   662		&dev_attr_max_link_speed.attr,
 > 663		&dev_attr_pbec.attr,
   664		NULL,
   665	};
   666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

