Return-Path: <linux-pci+bounces-1608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155782219E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 20:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DA3283BCD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7F15AD2;
	Tue,  2 Jan 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOXZUrR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB71775C
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704222002; x=1735758002;
  h=date:from:to:cc:subject:message-id;
  bh=BS7n1SZCPJThDnd/qklkIkO8mfEAgYalmHz3NjvwZxw=;
  b=XOXZUrR50SR8HQVtNWWZCmDyoTf9eqnw0qMfzSBqcuI+HJua1+VLYKpH
   iT7mNlfeJ9jHvR9C2+t2924l7Irk1OLBLDmKT8CEK/jY4okcM9JVtswxl
   NN3TVf9xb8EU2yXxAdxOFxVLlbAEINmhKBB+iPX2ggsp0LigweCycaPuc
   EqE4yHlKx6HbnW4mNYNoti/P50IvgMjb1JtLK2kROt9iKcY+k9cxb4lV/
   l+PopXDRQ4jsjf1GS+TZa/8bpMOAHSrpsTVcUdy524vGg6whsIZ9IxQaJ
   aOGbPPMJ2fDUNGoRbSMyVhe2zuAVzy3plsoOVfkMqmp79HIVN/0fpTv+B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="394058166"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="394058166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:00:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="952999711"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="952999711"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Jan 2024 10:59:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKjzZ-000LOK-1a;
	Tue, 02 Jan 2024 18:59:57 +0000
Date: Wed, 03 Jan 2024 02:59:31 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 1ce7d3dbed191e2c491cff4233d25365f3650b86
Message-ID: <202401030227.WOBcs7ga-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 1ce7d3dbed191e2c491cff4233d25365f3650b86  Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"

elapsed time: 1456m

configs tested: 216
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240102   gcc  
arc                   randconfig-002-20240102   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                       multi_v4t_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20240102   gcc  
arm                   randconfig-002-20240102   gcc  
arm                   randconfig-003-20240102   gcc  
arm                   randconfig-004-20240102   gcc  
arm                         s5pv210_defconfig   clang
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240102   gcc  
arm64                 randconfig-002-20240102   gcc  
arm64                 randconfig-003-20240102   gcc  
arm64                 randconfig-004-20240102   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240102   gcc  
csky                  randconfig-002-20240102   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240102   clang
hexagon               randconfig-002-20240102   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240102   gcc  
i386         buildonly-randconfig-002-20240102   gcc  
i386         buildonly-randconfig-003-20240102   gcc  
i386         buildonly-randconfig-004-20240102   gcc  
i386         buildonly-randconfig-005-20240102   gcc  
i386         buildonly-randconfig-006-20240102   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240102   gcc  
i386                  randconfig-002-20240102   gcc  
i386                  randconfig-003-20240102   gcc  
i386                  randconfig-004-20240102   gcc  
i386                  randconfig-005-20240102   gcc  
i386                  randconfig-006-20240102   gcc  
i386                  randconfig-011-20240102   clang
i386                  randconfig-012-20240102   clang
i386                  randconfig-013-20240102   clang
i386                  randconfig-014-20240102   clang
i386                  randconfig-015-20240102   clang
i386                  randconfig-016-20240102   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240102   gcc  
loongarch             randconfig-002-20240102   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240102   gcc  
nios2                 randconfig-002-20240102   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240102   gcc  
parisc                randconfig-002-20240102   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240102   gcc  
powerpc               randconfig-002-20240102   gcc  
powerpc               randconfig-003-20240102   gcc  
powerpc                     tqm8540_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240102   gcc  
powerpc64             randconfig-002-20240102   gcc  
powerpc64             randconfig-003-20240102   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240102   gcc  
riscv                 randconfig-002-20240102   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240102   clang
s390                  randconfig-002-20240102   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240102   gcc  
sh                    randconfig-002-20240102   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240102   gcc  
sparc64               randconfig-002-20240102   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240102   gcc  
um                    randconfig-002-20240102   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240102   gcc  
x86_64       buildonly-randconfig-002-20240102   gcc  
x86_64       buildonly-randconfig-003-20240102   gcc  
x86_64       buildonly-randconfig-004-20240102   gcc  
x86_64       buildonly-randconfig-005-20240102   gcc  
x86_64       buildonly-randconfig-006-20240102   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20240102   clang
x86_64                randconfig-003-20240102   clang
x86_64                randconfig-011-20240102   gcc  
x86_64                randconfig-012-20240102   gcc  
x86_64                randconfig-013-20240102   gcc  
x86_64                randconfig-014-20240102   gcc  
x86_64                randconfig-015-20240102   gcc  
x86_64                randconfig-016-20240102   gcc  
x86_64                randconfig-071-20240102   gcc  
x86_64                randconfig-072-20240102   gcc  
x86_64                randconfig-073-20240102   gcc  
x86_64                randconfig-074-20240102   gcc  
x86_64                randconfig-075-20240102   gcc  
x86_64                randconfig-076-20240102   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240102   gcc  
xtensa                randconfig-002-20240102   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

