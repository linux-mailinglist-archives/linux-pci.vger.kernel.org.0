Return-Path: <linux-pci+bounces-34751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6712B35ECB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1001BA01A4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E41312803;
	Tue, 26 Aug 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIAJW59e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CF29B8FE;
	Tue, 26 Aug 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210127; cv=none; b=aI0MiNHFWo0dYoQ90YDjYaG52wJt1T/rT8IOwG8YtMaSKfW5FtKLidDTDzZw6OMjT1CWbgKW1COsEL+9mQnyWsUlQ3ryWA0VkXXLb7hUc69GZO6MK7u3ysSCcbA3hE5OOHMbdsEsUNdxHSz6OvnDNov+9/gz/zeURIhbXm6gfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210127; c=relaxed/simple;
	bh=U5u6cagY9YEjSTixmbrphE7jjypj6sy7j6239hNSHAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDbBCtUL1bsmIYrGIBQsEYQSN8iOW+ayXKEDkuTjFqK7+P6hVQ7rgJliJNlJ54oM+AhqzaVdj53MekW3Lhgjz3dn/5McOf3hHIaOtCJ4a/4mYBY2YleaHpwKS2X83qT9BWRyy4iIslIT+buVCO0sLj90O6rjeI2hAa8dywhsqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIAJW59e; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756210125; x=1787746125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5u6cagY9YEjSTixmbrphE7jjypj6sy7j6239hNSHAA=;
  b=DIAJW59ejQ1+LmbK0AxZRdQJfeFxzckRM6o3fGAnR3wd/StMqtyXsPZV
   DxU7AVxStmtJGOuZqEcvvgkme2CHOo5fIzqaaHYh94pA6OImR510S1Atf
   M6EtzzVueOntMlthDO+ibHC1Ajw43Dobo2TefQvad7PXspfKmIxqy3cEn
   ZM8d/ZU9yFPIBBW0HEr8V/dDY9ypLrxMSvQ8i5Uii+dzJXLgUE4njteeA
   k9Vb/+PCNElxTr9fzBKyctEEQP57jqtpZkNPBrOlS+GJLm99BQXxY23HW
   lCiaYxPHAHP43kXpG9a6chX0H1l3d6gWD1qOZtShtcemBcSU4WBD7QYLf
   g==;
X-CSE-ConnectionGUID: sjQds6iUQZez82b5lqcrcA==
X-CSE-MsgGUID: 6/Pvy7W8SXGbASoDRsF50Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58383031"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58383031"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 05:08:45 -0700
X-CSE-ConnectionGUID: gkaHm60NTMOz/UaLFOsV6A==
X-CSE-MsgGUID: YY4AsznZRwqM3M0+CZ4cpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169736257"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Aug 2025 05:08:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqsTe-000PIB-0i;
	Tue, 26 Aug 2025 12:08:38 +0000
Date: Tue, 26 Aug 2025 20:08:30 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, robh@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v8 08/15] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Message-ID: <202508261955.U9IomdXb-lkp@intel.com>
References: <20250819115239.4170604-9-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819115239.4170604-9-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on be48bcf004f9d0c9207ff21d0edb3b42f253829e]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Add-module-support-for-platform-controller-driver/20250819-200002
base:   be48bcf004f9d0c9207ff21d0edb3b42f253829e
patch link:    https://lore.kernel.org/r/20250819115239.4170604-9-hans.zhang%40cixtech.com
patch subject: [PATCH v8 08/15] PCI: cadence: Add support for High Perf Architecture (HPA) controller
config: powerpc-randconfig-001-20250826 (https://download.01.org/0day-ci/archive/20250826/202508261955.U9IomdXb-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508261955.U9IomdXb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508261955.U9IomdXb-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/pci/controller/cadence/pcie-cadence-hpa.c: In function 'cdns_pcie_hpa_set_outbound_region':
>> include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_488' declared with attribute error: FIELD_PREP: value too large for the field
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:553:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:572:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
      ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      ^~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h:147:2: note: in expansion of macro 'FIELD_PREP'
     FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1))
     ^~~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence-hpa.c:129:10: note: in expansion of macro 'CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS'
     addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_488 +572 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  563   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  565   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  566   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  567   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  568   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  569   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  570   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  571  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @572  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  573  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

