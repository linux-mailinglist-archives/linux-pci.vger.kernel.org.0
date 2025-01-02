Return-Path: <linux-pci+bounces-19179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720BE9FFEE8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B56D160C51
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E57418FDAB;
	Thu,  2 Jan 2025 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfSqZdC1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9214F9F7;
	Thu,  2 Jan 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843990; cv=none; b=Ou5d6XZw+nuZy+mp0rGCt107wLm9166lD1z0RWHq69fOlScblO/+vcfbhPpZiKSREMcCdUWiAlU81xYVk+7S1zK6bC9nM70TEw8UH9zPCb6BAH66KWtClYlu4ye8p8M547B5QPoNiBVubzwb18MtN4nyDNptu416+u8gHslf+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843990; c=relaxed/simple;
	bh=C5uhygVpFSAMH26WubSta1/6ShJinhqB6PUVGB6/E4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHZ2uCfxEBQs4XQQXFrdPxheq+B7HzBO2YO8ne6Eb/5oO0sW1Ut9ybo6BBCvGd4EoVHPvh/bTMggfcdJeSdFU4OmuOC1ksy+6MpaJ7MBfeoCPo4ePs405093usKlTZWgT3/9va126nEVDK3cZuxovc3Wgm0B9c1IWJErNqgxE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfSqZdC1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735843989; x=1767379989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C5uhygVpFSAMH26WubSta1/6ShJinhqB6PUVGB6/E4g=;
  b=mfSqZdC17cYoF7w3BTSwgjMZKyKYaqO+2Fscs9RlNbIOJ15sJaLRORUN
   Atyd7II+5lNbrjIpIn9gf/x5RBYqzeO3Y4rVCUECpxDeHRw2KjQcnWVqZ
   vs7y+SvlTX9ZHtuiMwBH20vv/3wZ7pg5prK5roN0+eS4Bol5sEWzB4DzA
   jlWii0212PtmQcHHfPV3M0gxu7zuUdL7Y1KTnUqnCTKlabhmIxZlII90B
   nQABVTqk7GskdSZSr7GgbbCVc8F3iZRx+YKJRrQi+hmibZY0B0UwHptZs
   fCX6oveaVg0cNiRdiEIWvZoW2hJTWlqphD8dRhFj2oY/Fa4ND4c/rHbT8
   g==;
X-CSE-ConnectionGUID: DS5SJQpnTD6q+VfjAtHA8Q==
X-CSE-MsgGUID: S0YeC3ZDQmOiAkRzv4Sgeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="36255619"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="36255619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 10:53:08 -0800
X-CSE-ConnectionGUID: etN7jZrBRb+qciGVqMgaMQ==
X-CSE-MsgGUID: bnl9W5O4RCGTxyWddatt0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138913988"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Jan 2025 10:53:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTQJb-0008lZ-0Q;
	Thu, 02 Jan 2025 18:53:03 +0000
Date: Fri, 3 Jan 2025 02:52:06 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, manivannan.sadhasivam@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, Hans Zhang <18255117159@163.com>,
	kernel test robot <lkp@intel.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v6] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <202501030210.iaAEQUA6-lkp@intel.com>
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
config: powerpc-randconfig-003-20250102 (https://download.01.org/0day-ci/archive/20250103/202501030210.iaAEQUA6-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250103/202501030210.iaAEQUA6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501030210.iaAEQUA6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/powerpc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:12,
                    from drivers/misc/pci_endpoint_test.c:11:
   drivers/misc/pci_endpoint_test.c: In function 'pci_endpoint_test_bar':
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   drivers/misc/pci_endpoint_test.c:311:18: note: in expansion of macro 'do_div'
     311 |         remain = do_div(bar_size, buf_size);
         |                  ^~~~~~
   In file included from include/linux/cleanup.h:5,
                    from drivers/misc/pci_endpoint_test.c:10:
   include/asm-generic/div64.h:195:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     195 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/misc/pci_endpoint_test.c:311:18: note: in expansion of macro 'do_div'
     311 |         remain = do_div(bar_size, buf_size);
         |                  ^~~~~~
>> include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
     199 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    resource_size_t * {aka unsigned int *}
   drivers/misc/pci_endpoint_test.c:311:18: note: in expansion of macro 'do_div'
     311 |         remain = do_div(bar_size, buf_size);
         |                  ^~~~~~
   include/asm-generic/div64.h:174:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'resource_size_t *' {aka 'unsigned int *'}
     174 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~


vim +/__div64_32 +199 include/asm-generic/div64.h

^1da177e4c3f41 Linus Torvalds     2005-04-16  176  
^1da177e4c3f41 Linus Torvalds     2005-04-16  177  /* The unnecessary pointer compare is there
^1da177e4c3f41 Linus Torvalds     2005-04-16  178   * to check for type safety (n must be 64bit)
^1da177e4c3f41 Linus Torvalds     2005-04-16  179   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  180  # define do_div(n,base) ({				\
^1da177e4c3f41 Linus Torvalds     2005-04-16  181  	uint32_t __base = (base);			\
^1da177e4c3f41 Linus Torvalds     2005-04-16  182  	uint32_t __rem;					\
^1da177e4c3f41 Linus Torvalds     2005-04-16  183  	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  184  	if (__builtin_constant_p(__base) &&		\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  185  	    is_power_of_2(__base)) {			\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  186  		__rem = (n) & (__base - 1);		\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  187  		(n) >>= ilog2(__base);			\
c747ce4706190e Geert Uytterhoeven 2021-08-11  188  	} else if (__builtin_constant_p(__base) &&	\
461a5e51060c93 Nicolas Pitre      2015-10-30  189  		   __base != 0) {			\
461a5e51060c93 Nicolas Pitre      2015-10-30  190  		uint32_t __res_lo, __n_lo = (n);	\
461a5e51060c93 Nicolas Pitre      2015-10-30  191  		(n) = __div64_const32(n, __base);	\
461a5e51060c93 Nicolas Pitre      2015-10-30  192  		/* the remainder can be computed with 32-bit regs */ \
461a5e51060c93 Nicolas Pitre      2015-10-30  193  		__res_lo = (n);				\
461a5e51060c93 Nicolas Pitre      2015-10-30  194  		__rem = __n_lo - __res_lo * __base;	\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  195  	} else if (likely(((n) >> 32) == 0)) {		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  196  		__rem = (uint32_t)(n) % __base;		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  197  		(n) = (uint32_t)(n) / __base;		\
c747ce4706190e Geert Uytterhoeven 2021-08-11  198  	} else {					\
^1da177e4c3f41 Linus Torvalds     2005-04-16 @199  		__rem = __div64_32(&(n), __base);	\
c747ce4706190e Geert Uytterhoeven 2021-08-11  200  	}						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  201  	__rem;						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  202   })
^1da177e4c3f41 Linus Torvalds     2005-04-16  203  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

