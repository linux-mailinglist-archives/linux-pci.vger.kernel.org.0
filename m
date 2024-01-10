Return-Path: <linux-pci+bounces-1969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3709829346
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 06:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0248B24D47
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 05:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA8D531;
	Wed, 10 Jan 2024 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmHaqb+W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21026ABF
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704864436; x=1736400436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XaZ1MGGjvZ2/jY0dmkBU0Em3yKXcWxMVFlvqBxhxvtg=;
  b=nmHaqb+Wd5Dr1vEp7TGmno3uNi8Mq1+qSg/OfEhjWPB3Dpqc09OKnfbk
   yREAEXlN/3gpp0NuVxXFsyTt8qXnO+fwMVJh0fEQ/kaUTjiGbDiDzZ4yM
   m5Un/yHSSbLsCJpO9Ts+I1d42jwLGBeDn1oU9F43NNKGX8+qduqjZz9uY
   UyKcTX8YPnTYxJwE6iaas+L6xKrnKizt+S1CHTsoTk6MnNqUUm5U2I/C3
   9rQP60bMlSZQKoH5qIc8kR+6MRz/hV2zhKkTZkK85gc2FhdeF6Nk19sHi
   z0g3hqIK/zYMAjxf4UfnG9PqJuTr4Pb7Fjslf1DjPlXce117gg0+kJe64
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5498314"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5498314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872490624"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872490624"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2024 21:27:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNR7Q-0006dg-2l;
	Wed, 10 Jan 2024 05:27:12 +0000
Date: Wed, 10 Jan 2024 13:21:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/keystone] BUILD SUCCESS
 c12ca110c613a81cb0f0099019c839d078cd0f38
Message-ID: <202401101353.aIldqirG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
branch HEAD: c12ca110c613a81cb0f0099019c839d078cd0f38  PCI: keystone: Fix race condition when initializing PHYs

elapsed time: 1489m

configs tested: 201
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240109   gcc  
arc                   randconfig-001-20240110   gcc  
arc                   randconfig-002-20240109   gcc  
arc                   randconfig-002-20240110   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240109   gcc  
csky                  randconfig-001-20240110   gcc  
csky                  randconfig-002-20240109   gcc  
csky                  randconfig-002-20240110   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20240109   gcc  
i386                  randconfig-011-20240110   gcc  
i386                  randconfig-012-20240109   gcc  
i386                  randconfig-012-20240110   gcc  
i386                  randconfig-013-20240109   gcc  
i386                  randconfig-013-20240110   gcc  
i386                  randconfig-014-20240109   gcc  
i386                  randconfig-014-20240110   gcc  
i386                  randconfig-015-20240109   gcc  
i386                  randconfig-015-20240110   gcc  
i386                  randconfig-016-20240109   gcc  
i386                  randconfig-016-20240110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240109   gcc  
loongarch             randconfig-001-20240110   gcc  
loongarch             randconfig-002-20240109   gcc  
loongarch             randconfig-002-20240110   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240109   gcc  
nios2                 randconfig-001-20240110   gcc  
nios2                 randconfig-002-20240109   gcc  
nios2                 randconfig-002-20240110   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240109   gcc  
parisc                randconfig-001-20240110   gcc  
parisc                randconfig-002-20240109   gcc  
parisc                randconfig-002-20240110   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240109   gcc  
s390                  randconfig-001-20240110   gcc  
s390                  randconfig-002-20240109   gcc  
s390                  randconfig-002-20240110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240109   gcc  
sh                    randconfig-001-20240110   gcc  
sh                    randconfig-002-20240109   gcc  
sh                    randconfig-002-20240110   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240109   gcc  
sparc64               randconfig-001-20240110   gcc  
sparc64               randconfig-002-20240109   gcc  
sparc64               randconfig-002-20240110   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240109   clang
x86_64       buildonly-randconfig-001-20240110   clang
x86_64       buildonly-randconfig-002-20240109   clang
x86_64       buildonly-randconfig-002-20240110   clang
x86_64       buildonly-randconfig-003-20240109   clang
x86_64       buildonly-randconfig-003-20240110   clang
x86_64       buildonly-randconfig-004-20240109   clang
x86_64       buildonly-randconfig-004-20240110   clang
x86_64       buildonly-randconfig-005-20240109   clang
x86_64       buildonly-randconfig-005-20240110   clang
x86_64       buildonly-randconfig-006-20240109   clang
x86_64       buildonly-randconfig-006-20240110   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240109   clang
x86_64                randconfig-011-20240110   clang
x86_64                randconfig-012-20240109   clang
x86_64                randconfig-012-20240110   clang
x86_64                randconfig-013-20240109   clang
x86_64                randconfig-013-20240110   clang
x86_64                randconfig-014-20240109   clang
x86_64                randconfig-014-20240110   clang
x86_64                randconfig-015-20240109   clang
x86_64                randconfig-015-20240110   clang
x86_64                randconfig-016-20240109   clang
x86_64                randconfig-016-20240110   clang
x86_64                randconfig-071-20240109   clang
x86_64                randconfig-071-20240110   clang
x86_64                randconfig-072-20240109   clang
x86_64                randconfig-072-20240110   clang
x86_64                randconfig-073-20240109   clang
x86_64                randconfig-073-20240110   clang
x86_64                randconfig-074-20240109   clang
x86_64                randconfig-074-20240110   clang
x86_64                randconfig-075-20240109   clang
x86_64                randconfig-075-20240110   clang
x86_64                randconfig-076-20240109   clang
x86_64                randconfig-076-20240110   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240109   gcc  
xtensa                randconfig-001-20240110   gcc  
xtensa                randconfig-002-20240109   gcc  
xtensa                randconfig-002-20240110   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

