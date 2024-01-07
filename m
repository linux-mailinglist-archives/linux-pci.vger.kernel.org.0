Return-Path: <linux-pci+bounces-1747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C549B8262F2
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 06:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F62281C3B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 05:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317D111B5;
	Sun,  7 Jan 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjHDDdKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EF125A4
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704604493; x=1736140493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qcKwU8mdmeFH741CdZZGk/pU3n6M6No0ip2+J1QAHUc=;
  b=gjHDDdKUyFBG/T/PeKiECqjohDov6dfZPtETBzy+V66NCT4+BbLufPkM
   s08ajhXyT1wiqQHLxYAKPyX9ASgdgmoVaI3e1Q4QcZlXlOOkKqAmGfhIU
   AHZkAhN5GM3dsJL155LLOsMYhaEuu7OHgvp1O7S2O2vGcqxinRMATBazm
   rCGPGwc7i3hKaPurFzBkpizLMFKBQWPV78CEUCBGqseiaju59l36t8JTR
   QCyR+nwiu6O3cbrr0h3wONWa3U5Wl1hE2AOIMxFpUwPVtB6fe3dTimAdX
   ruGjq2oSrCTrGrSS2Vg4rvfehjUeRoGHKY+hxP+a4u9NLJG80JGBcnw1L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="382670833"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="382670833"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 21:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="757308601"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="757308601"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2024 21:14:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMLUm-0003Pa-2R;
	Sun, 07 Jan 2024 05:14:48 +0000
Date: Sun, 07 Jan 2024 13:14:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 177c9ac6ab3fa585608a16877b1fa1aad832571c
Message-ID: <202401071301.Cc0lEuYi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 177c9ac6ab3fa585608a16877b1fa1aad832571c  PCI: j721e: Make TI J721E depend on ARCH_K3

elapsed time: 1447m

configs tested: 199
configs skipped: 3

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
arc                   randconfig-001-20240107   gcc  
arc                   randconfig-002-20240107   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240107   gcc  
csky                  randconfig-002-20240107   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240106   gcc  
i386         buildonly-randconfig-002-20240106   gcc  
i386         buildonly-randconfig-003-20240106   gcc  
i386         buildonly-randconfig-004-20240106   gcc  
i386         buildonly-randconfig-005-20240106   gcc  
i386         buildonly-randconfig-006-20240106   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240106   gcc  
i386                  randconfig-002-20240106   gcc  
i386                  randconfig-003-20240106   gcc  
i386                  randconfig-004-20240106   gcc  
i386                  randconfig-005-20240106   gcc  
i386                  randconfig-006-20240106   gcc  
i386                  randconfig-011-20240106   clang
i386                  randconfig-011-20240107   gcc  
i386                  randconfig-012-20240106   clang
i386                  randconfig-012-20240107   gcc  
i386                  randconfig-013-20240106   clang
i386                  randconfig-013-20240107   gcc  
i386                  randconfig-014-20240106   clang
i386                  randconfig-014-20240107   gcc  
i386                  randconfig-015-20240106   clang
i386                  randconfig-015-20240107   gcc  
i386                  randconfig-016-20240106   clang
i386                  randconfig-016-20240107   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240107   gcc  
loongarch             randconfig-002-20240107   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240107   gcc  
nios2                 randconfig-002-20240107   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240107   gcc  
parisc                randconfig-002-20240107   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240107   gcc  
s390                  randconfig-002-20240107   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240107   gcc  
sh                    randconfig-002-20240107   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240107   gcc  
sparc64               randconfig-002-20240107   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240106   gcc  
x86_64       buildonly-randconfig-001-20240107   clang
x86_64       buildonly-randconfig-002-20240106   gcc  
x86_64       buildonly-randconfig-002-20240107   clang
x86_64       buildonly-randconfig-003-20240106   gcc  
x86_64       buildonly-randconfig-003-20240107   clang
x86_64       buildonly-randconfig-004-20240106   gcc  
x86_64       buildonly-randconfig-004-20240107   clang
x86_64       buildonly-randconfig-005-20240106   gcc  
x86_64       buildonly-randconfig-005-20240107   clang
x86_64       buildonly-randconfig-006-20240106   gcc  
x86_64       buildonly-randconfig-006-20240107   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240106   gcc  
x86_64                randconfig-011-20240107   clang
x86_64                randconfig-012-20240106   gcc  
x86_64                randconfig-012-20240107   clang
x86_64                randconfig-013-20240106   gcc  
x86_64                randconfig-013-20240107   clang
x86_64                randconfig-014-20240106   gcc  
x86_64                randconfig-014-20240107   clang
x86_64                randconfig-015-20240106   gcc  
x86_64                randconfig-015-20240107   clang
x86_64                randconfig-016-20240106   gcc  
x86_64                randconfig-016-20240107   clang
x86_64                randconfig-071-20240106   gcc  
x86_64                randconfig-071-20240107   clang
x86_64                randconfig-072-20240106   gcc  
x86_64                randconfig-072-20240107   clang
x86_64                randconfig-073-20240106   gcc  
x86_64                randconfig-073-20240107   clang
x86_64                randconfig-074-20240106   gcc  
x86_64                randconfig-074-20240107   clang
x86_64                randconfig-075-20240106   gcc  
x86_64                randconfig-075-20240107   clang
x86_64                randconfig-076-20240106   gcc  
x86_64                randconfig-076-20240107   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240107   gcc  
xtensa                randconfig-002-20240107   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

