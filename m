Return-Path: <linux-pci+bounces-2014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E054482A4E9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 00:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E500B1C223C7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587B50242;
	Wed, 10 Jan 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhTZJbkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AE50243
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704928660; x=1736464660;
  h=date:from:to:cc:subject:message-id;
  bh=eZqRSHepgjxSYAh36O10RNDUEL67kZowlxzlqc4uyLg=;
  b=hhTZJbkDVGj9+OJg8SiB796SUdzI1l7HczQGUtfip7H7gXt9Fob3CkdU
   djspShD+kkZaQ63CllyHs8VCDxIsGXvK8WwSbNEGxPg1480qalpnX25Sc
   YKAr5ot+k7aj7VAmF4t/82hNCsM4W4vCuSumvar8iAsxBduZg9v0Uqrtz
   Q37GoeDWJYnhV/LrItF4bWz879po/r13DrpzyE3JSsF7D4IzlkhNoc8Cp
   uyRRzKQ0D9BOsug1Zif4H0iM3caXQqLvdXQEJNcC9FMlnxPs+73NAb8YR
   OPRXiZUKom9l7o2DgUcVMx2aCz4MqNKeDtYwMKVvpiXbK/NeoWS8E8GUW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5415209"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5415209"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 15:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="955529569"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="955529569"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2024 15:17:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNhpH-0007a6-0J;
	Wed, 10 Jan 2024 23:17:35 +0000
Date: Thu, 11 Jan 2024 07:16:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek] BUILD SUCCESS
 9ccc1318cf4bd90601f221268e42c3374703d681
Message-ID: <202401110757.gQPfPZ1U-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek
branch HEAD: 9ccc1318cf4bd90601f221268e42c3374703d681  PCI: mediatek-gen3: Fix translation window size calculation

elapsed time: 1466m

configs tested: 192
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240110   gcc  
arc                   randconfig-002-20240110   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20240110   clang
arm                   randconfig-002-20240110   clang
arm                   randconfig-003-20240110   clang
arm                   randconfig-004-20240110   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240110   clang
arm64                 randconfig-002-20240110   clang
arm64                 randconfig-003-20240110   clang
arm64                 randconfig-004-20240110   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240110   gcc  
csky                  randconfig-002-20240110   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240110   clang
hexagon               randconfig-002-20240110   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20240110   gcc  
i386                  randconfig-011-20240111   clang
i386                  randconfig-012-20240110   gcc  
i386                  randconfig-012-20240111   clang
i386                  randconfig-013-20240110   gcc  
i386                  randconfig-013-20240111   clang
i386                  randconfig-014-20240110   gcc  
i386                  randconfig-014-20240111   clang
i386                  randconfig-015-20240110   gcc  
i386                  randconfig-015-20240111   clang
i386                  randconfig-016-20240110   gcc  
i386                  randconfig-016-20240111   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240110   gcc  
loongarch             randconfig-002-20240110   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240110   gcc  
nios2                 randconfig-002-20240110   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240110   gcc  
parisc                randconfig-002-20240110   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240110   clang
powerpc               randconfig-002-20240110   clang
powerpc               randconfig-003-20240110   clang
powerpc                     tqm8540_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240110   clang
powerpc64             randconfig-002-20240110   clang
powerpc64             randconfig-003-20240110   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20240110   clang
riscv                 randconfig-002-20240110   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240110   gcc  
s390                  randconfig-002-20240110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240110   gcc  
sh                    randconfig-002-20240110   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240110   gcc  
sparc64               randconfig-002-20240110   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240110   clang
um                    randconfig-002-20240110   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240110   clang
x86_64       buildonly-randconfig-002-20240110   clang
x86_64       buildonly-randconfig-003-20240110   clang
x86_64       buildonly-randconfig-004-20240110   clang
x86_64       buildonly-randconfig-005-20240110   clang
x86_64       buildonly-randconfig-006-20240110   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240110   clang
x86_64                randconfig-012-20240110   clang
x86_64                randconfig-013-20240110   clang
x86_64                randconfig-014-20240110   clang
x86_64                randconfig-015-20240110   clang
x86_64                randconfig-016-20240110   clang
x86_64                randconfig-071-20240110   clang
x86_64                randconfig-072-20240110   clang
x86_64                randconfig-073-20240110   clang
x86_64                randconfig-074-20240110   clang
x86_64                randconfig-075-20240110   clang
x86_64                randconfig-076-20240110   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240110   gcc  
xtensa                randconfig-002-20240110   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

