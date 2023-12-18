Return-Path: <linux-pci+bounces-1139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941B816591
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 05:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F384A1F224BE
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 04:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E355392;
	Mon, 18 Dec 2023 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iyk4jSGs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1F538D
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702872532; x=1734408532;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F0UD3Z1uuALukMHK6q93vHEa5Zr20GXnOXE3OxISYZ8=;
  b=Iyk4jSGsYQG1o36cQFx4Xe0Hp0pOSPjRSk7gU/QyrUULeeUiy5sxEUQ+
   LKPn5aV3z9iXhoc2oeL/R81IdAAo/f78K/At0t/Y4Pr1Fui7AfnX5Adtk
   CYTPRSAGMtsYdOJ4SG18MWHaJVzsKNXXPj5migMV0TSdPhaENUlArzWxv
   DSMOIB01jGBwS5GHgABqp5SiKO61ziCiteQo79bOQA+1vDX5fOB16EW21
   4sxDAobXJle2XbDy0yVTR/4Xph3DK/mgeaBa5bMdGjsjAkQUcf+4U8ktQ
   0B7WoY6ZLC2KhA5kgNFWAw8/U5uXKvMu47ggi1+411UWBoTWdr3YD1i11
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2660929"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2660929"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 20:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="919130675"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="919130675"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2023 20:08:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF4vw-0003kD-0n;
	Mon, 18 Dec 2023 04:08:48 +0000
Date: Mon, 18 Dec 2023 12:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/kirin] BUILD SUCCESS
 9f5077ef8f8157270f51f4ebd782c985d56d33c6
Message-ID: <202312181255.ovt6j6C7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/kirin
branch HEAD: 9f5077ef8f8157270f51f4ebd782c985d56d33c6  PCI: kirin: Use devm_kasprintf() to dynamically allocate clock names

elapsed time: 1464m

configs tested: 255
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231217   gcc  
arc                   randconfig-001-20231218   gcc  
arc                   randconfig-002-20231217   gcc  
arc                   randconfig-002-20231218   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231217   clang
arm                   randconfig-001-20231218   gcc  
arm                   randconfig-002-20231217   clang
arm                   randconfig-002-20231218   gcc  
arm                   randconfig-003-20231217   clang
arm                   randconfig-003-20231218   gcc  
arm                   randconfig-004-20231217   clang
arm                   randconfig-004-20231218   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231217   clang
arm64                 randconfig-001-20231218   gcc  
arm64                 randconfig-002-20231217   clang
arm64                 randconfig-002-20231218   gcc  
arm64                 randconfig-003-20231218   gcc  
arm64                 randconfig-004-20231217   clang
arm64                 randconfig-004-20231218   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231217   gcc  
csky                  randconfig-001-20231218   gcc  
csky                  randconfig-002-20231217   gcc  
csky                  randconfig-002-20231218   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231217   clang
hexagon               randconfig-002-20231217   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231217   clang
i386         buildonly-randconfig-002-20231217   clang
i386         buildonly-randconfig-003-20231217   clang
i386         buildonly-randconfig-004-20231217   clang
i386         buildonly-randconfig-005-20231217   clang
i386         buildonly-randconfig-006-20231217   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231217   clang
i386                  randconfig-002-20231217   clang
i386                  randconfig-003-20231217   clang
i386                  randconfig-004-20231217   clang
i386                  randconfig-005-20231217   clang
i386                  randconfig-006-20231217   clang
i386                  randconfig-011-20231217   gcc  
i386                  randconfig-011-20231218   clang
i386                  randconfig-012-20231217   gcc  
i386                  randconfig-012-20231218   clang
i386                  randconfig-013-20231217   gcc  
i386                  randconfig-013-20231218   clang
i386                  randconfig-014-20231217   gcc  
i386                  randconfig-014-20231218   clang
i386                  randconfig-015-20231217   gcc  
i386                  randconfig-015-20231218   clang
i386                  randconfig-016-20231217   gcc  
i386                  randconfig-016-20231218   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231217   gcc  
loongarch             randconfig-001-20231218   gcc  
loongarch             randconfig-002-20231217   gcc  
loongarch             randconfig-002-20231218   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231217   gcc  
nios2                 randconfig-001-20231218   gcc  
nios2                 randconfig-002-20231217   gcc  
nios2                 randconfig-002-20231218   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231217   gcc  
parisc                randconfig-001-20231218   gcc  
parisc                randconfig-002-20231217   gcc  
parisc                randconfig-002-20231218   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231217   clang
powerpc               randconfig-001-20231218   gcc  
powerpc               randconfig-002-20231217   clang
powerpc               randconfig-002-20231218   gcc  
powerpc               randconfig-003-20231217   clang
powerpc               randconfig-003-20231218   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20231217   clang
powerpc64             randconfig-001-20231218   gcc  
powerpc64             randconfig-002-20231217   clang
powerpc64             randconfig-002-20231218   gcc  
powerpc64             randconfig-003-20231217   clang
powerpc64             randconfig-003-20231218   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231217   clang
riscv                 randconfig-001-20231218   gcc  
riscv                 randconfig-002-20231217   clang
riscv                 randconfig-002-20231218   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231217   gcc  
s390                  randconfig-002-20231217   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20231217   gcc  
sh                    randconfig-001-20231218   gcc  
sh                    randconfig-002-20231217   gcc  
sh                    randconfig-002-20231218   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                 randconfig-001-20231218   gcc  
sparc                 randconfig-002-20231218   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231217   gcc  
sparc64               randconfig-001-20231218   gcc  
sparc64               randconfig-002-20231217   gcc  
sparc64               randconfig-002-20231218   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231217   clang
um                    randconfig-001-20231218   gcc  
um                    randconfig-002-20231217   clang
um                    randconfig-002-20231218   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231217   clang
x86_64       buildonly-randconfig-001-20231218   gcc  
x86_64       buildonly-randconfig-002-20231217   clang
x86_64       buildonly-randconfig-002-20231218   gcc  
x86_64       buildonly-randconfig-003-20231217   clang
x86_64       buildonly-randconfig-003-20231218   gcc  
x86_64       buildonly-randconfig-004-20231217   clang
x86_64       buildonly-randconfig-004-20231218   gcc  
x86_64       buildonly-randconfig-005-20231217   clang
x86_64       buildonly-randconfig-005-20231218   gcc  
x86_64       buildonly-randconfig-006-20231217   clang
x86_64       buildonly-randconfig-006-20231218   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231217   clang
x86_64                randconfig-011-20231218   gcc  
x86_64                randconfig-012-20231217   clang
x86_64                randconfig-012-20231218   gcc  
x86_64                randconfig-013-20231217   clang
x86_64                randconfig-013-20231218   gcc  
x86_64                randconfig-014-20231217   clang
x86_64                randconfig-014-20231218   gcc  
x86_64                randconfig-015-20231217   clang
x86_64                randconfig-015-20231218   gcc  
x86_64                randconfig-016-20231217   clang
x86_64                randconfig-016-20231218   gcc  
x86_64                randconfig-071-20231217   clang
x86_64                randconfig-071-20231218   gcc  
x86_64                randconfig-072-20231217   clang
x86_64                randconfig-072-20231218   gcc  
x86_64                randconfig-073-20231217   clang
x86_64                randconfig-073-20231218   gcc  
x86_64                randconfig-074-20231217   clang
x86_64                randconfig-074-20231218   gcc  
x86_64                randconfig-075-20231217   clang
x86_64                randconfig-075-20231218   gcc  
x86_64                randconfig-076-20231217   clang
x86_64                randconfig-076-20231218   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231217   gcc  
xtensa                randconfig-001-20231218   gcc  
xtensa                randconfig-002-20231217   gcc  
xtensa                randconfig-002-20231218   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

