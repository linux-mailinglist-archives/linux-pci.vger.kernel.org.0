Return-Path: <linux-pci+bounces-19182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB4A00032
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 21:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A8B3A14F5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6304B1BBBD4;
	Thu,  2 Jan 2025 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXhGFHWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DD1B983E;
	Thu,  2 Jan 2025 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735850781; cv=none; b=Lv8pmAWI76arAVfuLuqWfx6AJp9+QUgnbAJ/oE3x6Q5EwrxGEyJLIOVNBu7aiV8Awzkk3+ixDHlulH2urNx6OQ67la5gM9G0ke+Am1SDIcPVFbDvAe+HK42K7aymcGxTkLqTqXZMp0Ne9mzY/PFt+qFZ+iako2Z9JMhns0+K8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735850781; c=relaxed/simple;
	bh=lXtHheUcWiplOvGAaTqAv+gEmAbp2r9+jFsyAWbuv5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR0CXrmkms1x92qDz8xNx6tN2dFeWAlopHaGmB7oQAPRItMKVqkFYERPhiabveeEYsD1+sW5IJXFkU9UcZtNL0Ahu3Goyr3Htk2cLctrXEkwsy7ylo6KnXKBSIUl6BSss9b/FXRJ87MDbscvJJ553XPJZJzImhfVXc2cPnh0/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXhGFHWz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735850780; x=1767386780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lXtHheUcWiplOvGAaTqAv+gEmAbp2r9+jFsyAWbuv5E=;
  b=gXhGFHWzoHVpElP7dWFpYehwOwDRLDXBRqgRr/XE/T0Rr52DWBIdz/+K
   73+jeShocoo2f2v2lkGhVf8BjVZC0p0ENoB6v8ljqt9ghPNKdU39bf4K7
   gP+TIsCgDMieSm1t3M5UbEyQHPNJFhE1wGZx5s94VjzuZ3yiWU8Bs+72k
   caHzYZi+0hTYtYLjtSMN/FJjAV4N3It0T8YZxgmRlkQ9ex7VsdUQzDoIY
   hvBRlB01GPy60vacAzm0F5UrL9YelmN4em0nac1/iGEejz+9LtNDXSIEq
   hO9hi34U2/MwTO4W1dyBPLG4/ssyqFzOPYCd1oig+ylI75U5pKayLkm0N
   g==;
X-CSE-ConnectionGUID: NDaV+iimTq2GSTV6cNTpEQ==
X-CSE-MsgGUID: mZzGcTdKR2qDKJJ8qh1ulg==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="38926847"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="38926847"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 12:46:19 -0800
X-CSE-ConnectionGUID: JXo9s0gESbW+wTzPOGbn+Q==
X-CSE-MsgGUID: vzOAfbDNR5eBh3vmRD4fPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105654733"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jan 2025 12:46:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTS58-0008rD-0U;
	Thu, 02 Jan 2025 20:46:14 +0000
Date: Fri, 3 Jan 2025 04:46:01 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, manivannan.sadhasivam@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kw@linux.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, Hans Zhang <18255117159@163.com>,
	kernel test robot <lkp@intel.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v6] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <202501030414.p0DE9xNK-lkp@intel.com>
References: <20250102120222.1403906-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102120222.1403906-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on ccb98ccef0e543c2bd4ef1a72270461957f3d8d0]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/misc-pci_endpoint_test-Fix-overflow-of-bar_size/20250102-200548
base:   ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
patch link:    https://lore.kernel.org/r/20250102120222.1403906-1-18255117159%40163.com
patch subject: [v6] misc: pci_endpoint_test: Fix overflow of bar_size
config: arm-defconfig (https://download.01.org/0day-ci/archive/20250103/202501030414.p0DE9xNK-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250103/202501030414.p0DE9xNK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501030414.p0DE9xNK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/misc/pci_endpoint_test.c:311:11: warning: comparison of distinct pointer types ('typeof ((bar_size)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     311 |         remain = do_div(bar_size, buf_size);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:183:28: note: expanded from macro 'do_div'
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> drivers/misc/pci_endpoint_test.c:311:11: error: incompatible pointer types passing 'resource_size_t *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     311 |         remain = do_div(bar_size, buf_size);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:199:22: note: expanded from macro 'do_div'
     199 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
      24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
         |                                             ^
>> drivers/misc/pci_endpoint_test.c:311:11: warning: shift count >= width of type [-Wshift-count-overflow]
     311 |         remain = do_div(bar_size, buf_size);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:195:25: note: expanded from macro 'do_div'
     195 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   2 warnings and 1 error generated.


vim +311 drivers/misc/pci_endpoint_test.c

   279	
   280	static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
   281					  enum pci_barno barno)
   282	{
   283		void *write_buf __free(kfree) = NULL;
   284		void *read_buf __free(kfree) = NULL;
   285		struct pci_dev *pdev = test->pdev;
   286		int j, buf_size, iters, remain;
   287		resource_size_t bar_size;
   288	
   289		if (!test->bar[barno])
   290			return false;
   291	
   292		bar_size = pci_resource_len(pdev, barno);
   293	
   294		if (barno == test->test_reg_bar)
   295			bar_size = 0x4;
   296	
   297		/*
   298		 * Allocate a buffer of max size 1MB, and reuse that buffer while
   299		 * iterating over the whole BAR size (which might be much larger).
   300		 */
   301		buf_size = min(SZ_1M, bar_size);
   302	
   303		write_buf = kmalloc(buf_size, GFP_KERNEL);
   304		if (!write_buf)
   305			return false;
   306	
   307		read_buf = kmalloc(buf_size, GFP_KERNEL);
   308		if (!read_buf)
   309			return false;
   310	
 > 311		remain = do_div(bar_size, buf_size);
   312		iters = bar_size;
   313		for (j = 0; j < iters; j++)
   314			if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
   315							 write_buf, read_buf, buf_size))
   316				return false;
   317	
   318		if (remain)
   319			if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
   320							 write_buf, read_buf, remain))
   321				return false;
   322	
   323		return true;
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

