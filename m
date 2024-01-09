Return-Path: <linux-pci+bounces-1951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095B9828E1F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D88D1F24EB0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85123C694;
	Tue,  9 Jan 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2PDgpuM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85323D974
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704829413; x=1736365413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gqzOAoeNVasMe6DAM3aYYA7Zk7wEohrM37bpeKuMgtk=;
  b=N2PDgpuMg5STbQRXZHzRVmkH+Qmz/stJqPB8EpL0gFFF+OdK/bD782Jc
   y/+DqXa/l+duHKUwsNCKP1INpXQ++Pnyg12MNc04lDF8587MPnGkpys69
   2atm5fL0rOgXuTKw0lkfR4+gQPVd5ASA1k9LLhcg3LctFk3yONLdeR1Zo
   goUpVM5O9yAWK0qklfnOwkKdLibls6oxvhA/5CkZYy0lCAlb6Ltv2nUdl
   8+9rpgW0dkQCvraBdgoFymRvbx9FZKK1lFj2V6zGMrQbQmSFJoeXvVk9t
   V9TW1Np7lnuMAQC/0MG/CALv7uIWH3/ZtkvzqkFusz3qsOPOC9Ot1KAZC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5389671"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5389671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 11:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="23677966"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 09 Jan 2024 11:43:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNI0V-0006D4-2Z;
	Tue, 09 Jan 2024 19:43:27 +0000
Date: Wed, 10 Jan 2024 03:42:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx] BUILD SUCCESS
 2324be17b5e05ac682e7c81fcbfc7b36a9b1becb
Message-ID: <202401100356.FveYGBXj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx
branch HEAD: 2324be17b5e05ac682e7c81fcbfc7b36a9b1becb  PCI: xilinx-xdma: Fix error code in xilinx_pl_dma_pcie_init_irq_domain()

elapsed time: 1458m

configs tested: 182
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240109   gcc  
arc                   randconfig-002-20240109   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240109   gcc  
csky                  randconfig-002-20240109   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240109   clang
i386         buildonly-randconfig-002-20240109   clang
i386         buildonly-randconfig-003-20240109   clang
i386         buildonly-randconfig-004-20240109   clang
i386         buildonly-randconfig-005-20240109   clang
i386         buildonly-randconfig-006-20240109   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240109   clang
i386                  randconfig-002-20240109   clang
i386                  randconfig-003-20240109   clang
i386                  randconfig-004-20240109   clang
i386                  randconfig-005-20240109   clang
i386                  randconfig-006-20240109   clang
i386                  randconfig-011-20240109   gcc  
i386                  randconfig-012-20240109   gcc  
i386                  randconfig-013-20240109   gcc  
i386                  randconfig-014-20240109   gcc  
i386                  randconfig-015-20240109   gcc  
i386                  randconfig-016-20240109   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240109   gcc  
loongarch             randconfig-002-20240109   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240109   gcc  
nios2                 randconfig-002-20240109   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240109   gcc  
parisc                randconfig-002-20240109   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
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
s390                  randconfig-002-20240109   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240109   gcc  
sh                    randconfig-002-20240109   gcc  
sh                             sh03_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240109   gcc  
sparc64               randconfig-002-20240109   gcc  
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
x86_64       buildonly-randconfig-002-20240109   clang
x86_64       buildonly-randconfig-003-20240109   clang
x86_64       buildonly-randconfig-004-20240109   clang
x86_64       buildonly-randconfig-005-20240109   clang
x86_64       buildonly-randconfig-006-20240109   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240109   clang
x86_64                randconfig-012-20240109   clang
x86_64                randconfig-013-20240109   clang
x86_64                randconfig-014-20240109   clang
x86_64                randconfig-015-20240109   clang
x86_64                randconfig-016-20240109   clang
x86_64                randconfig-071-20240109   clang
x86_64                randconfig-072-20240109   clang
x86_64                randconfig-073-20240109   clang
x86_64                randconfig-074-20240109   clang
x86_64                randconfig-075-20240109   clang
x86_64                randconfig-076-20240109   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240109   gcc  
xtensa                randconfig-002-20240109   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

