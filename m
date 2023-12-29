Return-Path: <linux-pci+bounces-1560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1764C820117
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 19:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A441F21405
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A7125DD;
	Fri, 29 Dec 2023 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1GWfjMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43112B92
	for <linux-pci@vger.kernel.org>; Fri, 29 Dec 2023 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703875727; x=1735411727;
  h=date:from:to:cc:subject:message-id;
  bh=yd59/XjVY9+6bvGzapSZnxWxOTYJFfJn3795SobMpHE=;
  b=N1GWfjMBhyGT2ouiWL7xuqtc5swsH/QbZmkD5a49ivQPQtG0fNy23VbB
   dyy3KJsiYMs0citR/5SQ4ITaCvUtQ2UUju6Er1gwWSBueJ/zAv7C3gX49
   3TKs439DMAzr3qQqXZS5oVwhyA4oS4DLCLRdh1g7kvQyHiVEIL2esmnUe
   7N2W0elQHuDuhqzMpkyri05XT5WgyMuLyKnm8DEATSxvV9mH4VqLX356t
   s6nn/9Dd2F7vsyV5NJo8hbcDJFa6MgEOQKoZAwR4YdPdIeQyD+VD+eUpc
   nHNtHkienzxj/lX/WNHrjdg1ocC34Oz9iGNGE8c6ucok7a1RbtHLK+pph
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="18217260"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="18217260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 10:48:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="849273900"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="849273900"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Dec 2023 10:48:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJHuU-000Hi3-0i;
	Fri, 29 Dec 2023 18:48:42 +0000
Date: Sat, 30 Dec 2023 02:47:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 2afb41864fbd42b3880af5aafec558a6c0b56b45
Message-ID: <202312300243.pEwxXXUT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 2afb41864fbd42b3880af5aafec558a6c0b56b45  Merge branch 'pci/dt-bindings'

elapsed time: 1442m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231229   gcc  
arc                   randconfig-002-20231229   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231229   clang
arm                   randconfig-002-20231229   clang
arm                   randconfig-003-20231229   clang
arm                   randconfig-004-20231229   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231229   clang
arm64                 randconfig-002-20231229   clang
arm64                 randconfig-003-20231229   clang
arm64                 randconfig-004-20231229   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231229   gcc  
csky                  randconfig-002-20231229   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231229   clang
hexagon               randconfig-002-20231229   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231229   clang
i386         buildonly-randconfig-002-20231229   clang
i386         buildonly-randconfig-003-20231229   clang
i386         buildonly-randconfig-004-20231229   clang
i386         buildonly-randconfig-005-20231229   clang
i386         buildonly-randconfig-006-20231229   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231229   clang
i386                  randconfig-002-20231229   clang
i386                  randconfig-003-20231229   clang
i386                  randconfig-004-20231229   clang
i386                  randconfig-005-20231229   clang
i386                  randconfig-006-20231229   clang
i386                  randconfig-011-20231229   gcc  
i386                  randconfig-012-20231229   gcc  
i386                  randconfig-013-20231229   gcc  
i386                  randconfig-014-20231229   gcc  
i386                  randconfig-015-20231229   gcc  
i386                  randconfig-016-20231229   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231229   gcc  
loongarch             randconfig-002-20231229   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231229   gcc  
nios2                 randconfig-002-20231229   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231229   gcc  
parisc                randconfig-002-20231229   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc               randconfig-001-20231229   clang
powerpc               randconfig-002-20231229   clang
powerpc               randconfig-003-20231229   clang
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc64             randconfig-001-20231229   clang
powerpc64             randconfig-002-20231229   clang
powerpc64             randconfig-003-20231229   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231229   clang
riscv                 randconfig-002-20231229   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231229   gcc  
s390                  randconfig-002-20231229   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20231229   gcc  
sh                    randconfig-002-20231229   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231229   gcc  
sparc64               randconfig-002-20231229   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231229   clang
um                    randconfig-002-20231229   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231229   clang
x86_64       buildonly-randconfig-002-20231229   clang
x86_64       buildonly-randconfig-003-20231229   clang
x86_64       buildonly-randconfig-004-20231229   clang
x86_64       buildonly-randconfig-005-20231229   clang
x86_64       buildonly-randconfig-006-20231229   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231229   gcc  
x86_64                randconfig-002-20231229   gcc  
x86_64                randconfig-003-20231229   gcc  
x86_64                randconfig-004-20231229   gcc  
x86_64                randconfig-005-20231229   gcc  
x86_64                randconfig-006-20231229   gcc  
x86_64                randconfig-011-20231229   clang
x86_64                randconfig-012-20231229   clang
x86_64                randconfig-013-20231229   clang
x86_64                randconfig-014-20231229   clang
x86_64                randconfig-015-20231229   clang
x86_64                randconfig-016-20231229   clang
x86_64                randconfig-071-20231229   clang
x86_64                randconfig-072-20231229   clang
x86_64                randconfig-073-20231229   clang
x86_64                randconfig-074-20231229   clang
x86_64                randconfig-075-20231229   clang
x86_64                randconfig-076-20231229   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231229   gcc  
xtensa                randconfig-002-20231229   gcc  
xtensa                    smp_lx200_defconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

