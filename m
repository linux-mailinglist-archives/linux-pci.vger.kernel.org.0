Return-Path: <linux-pci+bounces-24406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09FA6C4BA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45783B85B6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538E1233715;
	Fri, 21 Mar 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghe8scCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EE23314B;
	Fri, 21 Mar 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590661; cv=none; b=BjisdjBvMWUKoXNaxZx45Vc3ZbSYjWdDeV5J7jbFQj259LxpJY0udyMiYWPSQe2AIDUMaBFYPX+C9Fbo0y79ia9WA1mTEI57isz2psx/tAA4+mVQdB+mSwlc8LedcVuvTB7YPxINmOY3UlIIcnvCMAF86XiqS4vEWdK87Lgf/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590661; c=relaxed/simple;
	bh=qftLK0hY/WZVD7D76hBXKUfNnZ4vTnHp/AThCTwwWlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACiYDtse16f+Y/lL24ChiVfOJabwlgtRVL8SfD1ZvnilfEtzrG97kEGaPtbk0Iuqz4DSAS0Mj/mg91i38+ulfvGKXgzQQ0uyq/yUSpdPIA1S1IuiYHWIU+G59s9QH6BCeZe7T6N+NfHi+c1PjtHTEZ4sFL3KY2pMu2f+cpb9ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghe8scCr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742590660; x=1774126660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qftLK0hY/WZVD7D76hBXKUfNnZ4vTnHp/AThCTwwWlI=;
  b=ghe8scCrh7p7jvYJ486CdwQMKI7wxPFt0MjUFF32kDOCpuS0CpxaXego
   D4u9/8LJo7jNaCLJL8cSjeJhqmDrbzSZMMs41VXJnpuu6c2sjVzy6a2Gr
   OfsnHbQg1u4lEVHZesJM0N/CrAO5oSN/zcUt4B3BOmKVfuoT4KGNYLsuN
   /EkDS3UkC8kfiDLHLyfB0KMb3OyeqL7TUimsEQJMJmgYpnVvGuI3U+8Pd
   /UzBjbjkeNhDuk+pAzaP0j9sH/xS/Ri2yP4xomFy1dJiuzvTmu//QXk6l
   LmopunDYCU9he7d0N+kcBFgwk4S1j+k8YTyNPX2fQMtPfuRYVgXI93I4c
   w==;
X-CSE-ConnectionGUID: +sojVW7xQZmzCJBnya3Asw==
X-CSE-MsgGUID: zdjVOaH+Svq9znRVgFfWhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44057312"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="44057312"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:57:36 -0700
X-CSE-ConnectionGUID: Vn+KcVw8SRGcuhdF5Ii7XQ==
X-CSE-MsgGUID: SR/EuMXvQQyjeRe0yupHVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="128179653"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Mar 2025 13:57:33 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvjQo-0001gl-2i;
	Fri, 21 Mar 2025 20:57:30 +0000
Date: Sat, 22 Mar 2025 04:57:27 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v5 1/4] PCI: Introduce generic capability search functions
Message-ID: <202503220409.NDrvLkQF-lkp@intel.com>
References: <20250321163803.391056-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321163803.391056-2-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250322-004312
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250321163803.391056-2-18255117159%40163.com
patch subject: [v5 1/4] PCI: Introduce generic capability search functions
config: arm64-randconfig-001-20250322 (https://download.01.org/0day-ci/archive/20250322/202503220409.NDrvLkQF-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250322/202503220409.NDrvLkQF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503220409.NDrvLkQF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hv/vmbus_drv.c:38:
>> include/linux/pci.h:2025:1: error: expected identifier or '('
    2025 | { return 0; }
         | ^
   include/linux/pci.h:2029:1: error: expected identifier or '('
    2029 | { return 0; }
         | ^
   drivers/hv/vmbus_drv.c:1928:42: warning: shift count >= width of type [-Wshift-count-overflow]
    1928 |         dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
         |                                                 ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 2 errors generated.


vim +2025 include/linux/pci.h

  2000	
  2001	static inline void pci_set_master(struct pci_dev *dev) { }
  2002	static inline void pci_clear_master(struct pci_dev *dev) { }
  2003	static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
  2004	static inline void pci_disable_device(struct pci_dev *dev) { }
  2005	static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
  2006	static inline int pci_assign_resource(struct pci_dev *dev, int i)
  2007	{ return -EBUSY; }
  2008	static inline int __must_check __pci_register_driver(struct pci_driver *drv,
  2009							     struct module *owner,
  2010							     const char *mod_name)
  2011	{ return 0; }
  2012	static inline int pci_register_driver(struct pci_driver *drv)
  2013	{ return 0; }
  2014	static inline void pci_unregister_driver(struct pci_driver *drv) { }
  2015	static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
  2016	{ return 0; }
  2017	static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
  2018	{ return 0; }
  2019	static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
  2020	{ return 0; }
  2021	typedef u32 (*pci_host_bridge_read_cfg)(void *priv, int where, int size);
  2022	static inline u8
  2023	pci_host_bridge_find_capability(void *priv, pci_host_bridge_read_cfg read_cfg,
  2024					u8 cap);
> 2025	{ return 0; }
  2026	static inline u16
  2027	pci_host_bridge_find_ext_capability(void *priv,
  2028					    pci_host_bridge_read_cfg read_cfg, u8 cap);
  2029	{ return 0; }
  2030	static inline u64 pci_get_dsn(struct pci_dev *dev)
  2031	{ return 0; }
  2032	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

