Return-Path: <linux-pci+bounces-26666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B9A9A481
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 09:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01E17A181A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92F14900B;
	Thu, 24 Apr 2025 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILTHmcCM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E31E261F
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480506; cv=none; b=AoMcVViBBATOigjMgZtJXFaebTgAf5ELZpMw78LWz967wQP2UFZ8UWXn3MXQLBMELmsGeGFctk4FqJ4rKlbSUOjQpItUMVc+E8T/Sl8Eg2FwRkGiKeb2nGUc2eq3vAwkdSasTOtUdblTpAm+kNg9vs7Bsc2PxKVSPZ23Rk6Uvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480506; c=relaxed/simple;
	bh=3juoGav/wEM6mKHYzvsJMzohDfwDkqiCLaE2RBE34F8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gJjrX2r5wxVt5gicXCCTRkljjND55k6SVh2+J62dUj0I3ZzCNAD3rWNaXPpRmmVfUry7SJuyw6z9wMAF0xsM8kJitvdOqTtTjR78QkjFUMHle1e9ei5Hg57KqifYhwBD0q/7uuGbZLMM0diGvRPnLqBcVyQT4zOZbYPXS1XlZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILTHmcCM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745480504; x=1777016504;
  h=date:from:to:cc:subject:message-id;
  bh=3juoGav/wEM6mKHYzvsJMzohDfwDkqiCLaE2RBE34F8=;
  b=ILTHmcCMMs0wskvglr3FPjXWrJn0k+uCgB+cwxiYfuhmGn+noNsbdoLO
   WWqbc+167vvWWheUS9ZPq0+AcYZKHXMIEjrmT74ZS1XBeaKUq1RwBHKoN
   MEDahiospug8vuktNETjr8KjRwzUeWaabLRZVf6Bfc3LVvnwCEaj2RGXU
   0PB6wwZu3zRFPTROu7i9QJnouHBCOthogLueeuTE9a3gosKGAVIWfq0e+
   NibBPqcTKK/Fc010PWZuB7D7obZPb51R+ajXIlZQVlytVBgw2HCZXBMYG
   dzvzaR5W5yzjbRkMtoOrfn+P+FmQcOpQfCs4Q7fjfKiOxF+YbzMLFOgoE
   g==;
X-CSE-ConnectionGUID: 1pZhl4ElTXWdJF3sRIi4fQ==
X-CSE-MsgGUID: iVzzoBJ0QLupvMKv/bP4wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="49760680"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="49760680"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:41:44 -0700
X-CSE-ConnectionGUID: 5Ia351dkQVadYr/dISsmqQ==
X-CSE-MsgGUID: ExBbfX4nSwCwgE1NhH1iWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="155771382"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Apr 2025 00:41:42 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7rDI-0003ws-1n;
	Thu, 24 Apr 2025 07:41:40 +0000
Date: Thu, 24 Apr 2025 15:41:03 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 d63dbfc6f27de1dd5741107db07b585d344676ee
Message-ID: <202504241553.aLLn7EmH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: d63dbfc6f27de1dd5741107db07b585d344676ee  dt-bindings: PCI: Remove obsolete .txt docs

elapsed time: 1459m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250423    gcc-14.2.0
arc                   randconfig-002-20250423    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                                 defconfig    clang-21
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20250423    gcc-10.5.0
arm                   randconfig-002-20250423    gcc-10.5.0
arm                   randconfig-003-20250423    gcc-7.5.0
arm                   randconfig-004-20250423    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250423    gcc-5.5.0
arm64                 randconfig-002-20250423    gcc-7.5.0
arm64                 randconfig-003-20250423    clang-17
arm64                 randconfig-004-20250423    gcc-7.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250423    gcc-13.3.0
csky                  randconfig-002-20250423    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250423    clang-21
hexagon               randconfig-002-20250423    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250423    gcc-12
i386        buildonly-randconfig-002-20250423    clang-20
i386        buildonly-randconfig-003-20250423    clang-20
i386        buildonly-randconfig-004-20250423    clang-20
i386        buildonly-randconfig-005-20250423    gcc-12
i386        buildonly-randconfig-006-20250423    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250423    gcc-14.2.0
loongarch             randconfig-002-20250423    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-14.2.0
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250423    gcc-11.5.0
nios2                 randconfig-002-20250423    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250423    gcc-12.4.0
parisc                randconfig-002-20250423    gcc-12.4.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250423    gcc-9.3.0
powerpc               randconfig-002-20250423    clang-21
powerpc               randconfig-003-20250423    gcc-9.3.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250423    gcc-5.5.0
powerpc64             randconfig-002-20250423    gcc-7.5.0
powerpc64             randconfig-003-20250423    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250423    gcc-9.3.0
riscv                 randconfig-002-20250423    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250423    clang-21
s390                  randconfig-002-20250423    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250423    gcc-7.5.0
sh                    randconfig-002-20250423    gcc-13.3.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250423    gcc-6.5.0
sparc                 randconfig-002-20250423    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250423    gcc-12.4.0
sparc64               randconfig-002-20250423    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250423    clang-21
um                    randconfig-002-20250423    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250423    gcc-12
x86_64      buildonly-randconfig-002-20250423    gcc-12
x86_64      buildonly-randconfig-003-20250423    gcc-12
x86_64      buildonly-randconfig-004-20250423    clang-20
x86_64      buildonly-randconfig-005-20250423    gcc-12
x86_64      buildonly-randconfig-006-20250423    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250423    gcc-8.5.0
xtensa                randconfig-002-20250423    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

