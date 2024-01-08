Return-Path: <linux-pci+bounces-1772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DAA826961
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 09:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAE31F2161B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478DD2CA9;
	Mon,  8 Jan 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzKsL1Jy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200BB665
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704702287; x=1736238287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wsEiauYCQ7RWiuHErbDu8crqI+a7BZL8YgOlF2MVW2c=;
  b=XzKsL1JysznpyMOiOyLFNXHyws09IawnmXPJ3XVfqkS12+Th9gbS/OpE
   oo9V58bYQ/IkoGhsg4iH2dgUo6wU2/c4HQdsgfBSPsI8a9xIIuKMTAJfA
   elYdMzFaW8u3LYhDI/777vpGRK35I4EdLu67lQtlQHWmT5q79BSZMlNWE
   WnV3Ktw1x+VAOhYs5Tj8vsAgoNxJrNI+DiCQJCRJgf03ckJQK+x1gyGFZ
   2Ddqe8LTMYAq4OAeIM6zapWGiiT1bMs69rPkeIbgC8owG0/OeuwDNKPpN
   ldgwygq1rYWMvUbbnOfVlh4Xq1/EicUtMXMwJYBFfZydEuXIOXUg65YR+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="401613446"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="401613446"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1112676601"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1112676601"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jan 2024 00:24:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMkw7-0004Xw-05;
	Mon, 08 Jan 2024 08:24:43 +0000
Date: Mon, 08 Jan 2024 16:24:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-ep] BUILD SUCCESS
 a171e1d60dadf770348c009f11497aa6007d93f8
Message-ID: <202401081612.XegcQCDV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-ep
branch HEAD: a171e1d60dadf770348c009f11497aa6007d93f8  PCI: designware-ep: Move pci_epc_init_notify() inside dw_pcie_ep_init_complete()

elapsed time: 1446m

configs tested: 253
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
arc                   randconfig-001-20240107   gcc  
arc                   randconfig-001-20240108   gcc  
arc                   randconfig-002-20240107   gcc  
arc                   randconfig-002-20240108   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240107   clang
arm                   randconfig-001-20240108   gcc  
arm                   randconfig-002-20240107   clang
arm                   randconfig-002-20240108   gcc  
arm                   randconfig-003-20240107   clang
arm                   randconfig-003-20240108   gcc  
arm                   randconfig-004-20240107   clang
arm                   randconfig-004-20240108   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240107   clang
arm64                 randconfig-001-20240108   gcc  
arm64                 randconfig-002-20240107   clang
arm64                 randconfig-002-20240108   gcc  
arm64                 randconfig-003-20240107   clang
arm64                 randconfig-003-20240108   gcc  
arm64                 randconfig-004-20240107   clang
arm64                 randconfig-004-20240108   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240107   gcc  
csky                  randconfig-001-20240108   gcc  
csky                  randconfig-002-20240107   gcc  
csky                  randconfig-002-20240108   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240107   clang
hexagon               randconfig-002-20240107   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240107   clang
i386         buildonly-randconfig-002-20240107   clang
i386         buildonly-randconfig-003-20240107   clang
i386         buildonly-randconfig-004-20240107   clang
i386         buildonly-randconfig-005-20240107   clang
i386         buildonly-randconfig-006-20240107   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240107   clang
i386                  randconfig-002-20240107   clang
i386                  randconfig-003-20240107   clang
i386                  randconfig-004-20240107   clang
i386                  randconfig-005-20240107   clang
i386                  randconfig-006-20240107   clang
i386                  randconfig-011-20240107   gcc  
i386                  randconfig-012-20240107   gcc  
i386                  randconfig-013-20240107   gcc  
i386                  randconfig-014-20240107   gcc  
i386                  randconfig-015-20240107   gcc  
i386                  randconfig-016-20240107   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240107   gcc  
loongarch             randconfig-001-20240108   gcc  
loongarch             randconfig-002-20240107   gcc  
loongarch             randconfig-002-20240108   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240107   gcc  
nios2                 randconfig-001-20240108   gcc  
nios2                 randconfig-002-20240107   gcc  
nios2                 randconfig-002-20240108   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240107   gcc  
parisc                randconfig-001-20240108   gcc  
parisc                randconfig-002-20240107   gcc  
parisc                randconfig-002-20240108   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc               randconfig-001-20240107   clang
powerpc               randconfig-001-20240108   gcc  
powerpc               randconfig-002-20240107   clang
powerpc               randconfig-002-20240108   gcc  
powerpc               randconfig-003-20240107   clang
powerpc               randconfig-003-20240108   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20240107   clang
powerpc64             randconfig-001-20240108   gcc  
powerpc64             randconfig-002-20240107   clang
powerpc64             randconfig-002-20240108   gcc  
powerpc64             randconfig-003-20240107   clang
powerpc64             randconfig-003-20240108   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240107   clang
riscv                 randconfig-001-20240108   gcc  
riscv                 randconfig-002-20240107   clang
riscv                 randconfig-002-20240108   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240107   gcc  
s390                  randconfig-002-20240107   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240107   gcc  
sh                    randconfig-001-20240108   gcc  
sh                    randconfig-002-20240107   gcc  
sh                    randconfig-002-20240108   gcc  
sh                          rsk7269_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240107   gcc  
sparc64               randconfig-001-20240108   gcc  
sparc64               randconfig-002-20240107   gcc  
sparc64               randconfig-002-20240108   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240107   clang
um                    randconfig-001-20240108   gcc  
um                    randconfig-002-20240107   clang
um                    randconfig-002-20240108   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240107   clang
x86_64       buildonly-randconfig-001-20240108   gcc  
x86_64       buildonly-randconfig-002-20240107   clang
x86_64       buildonly-randconfig-002-20240108   gcc  
x86_64       buildonly-randconfig-003-20240107   clang
x86_64       buildonly-randconfig-003-20240108   gcc  
x86_64       buildonly-randconfig-004-20240107   clang
x86_64       buildonly-randconfig-004-20240108   gcc  
x86_64       buildonly-randconfig-005-20240107   clang
x86_64       buildonly-randconfig-005-20240108   gcc  
x86_64       buildonly-randconfig-006-20240107   clang
x86_64       buildonly-randconfig-006-20240108   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20240107   gcc  
x86_64                randconfig-002-20240107   gcc  
x86_64                randconfig-003-20240107   gcc  
x86_64                randconfig-004-20240107   gcc  
x86_64                randconfig-005-20240107   gcc  
x86_64                randconfig-006-20240107   gcc  
x86_64                randconfig-011-20240107   clang
x86_64                randconfig-011-20240108   gcc  
x86_64                randconfig-012-20240107   clang
x86_64                randconfig-012-20240108   gcc  
x86_64                randconfig-013-20240107   clang
x86_64                randconfig-013-20240108   gcc  
x86_64                randconfig-014-20240107   clang
x86_64                randconfig-014-20240108   gcc  
x86_64                randconfig-015-20240107   clang
x86_64                randconfig-015-20240108   gcc  
x86_64                randconfig-016-20240107   clang
x86_64                randconfig-016-20240108   gcc  
x86_64                randconfig-071-20240107   clang
x86_64                randconfig-071-20240108   gcc  
x86_64                randconfig-072-20240107   clang
x86_64                randconfig-072-20240108   gcc  
x86_64                randconfig-073-20240107   clang
x86_64                randconfig-073-20240108   gcc  
x86_64                randconfig-074-20240107   clang
x86_64                randconfig-074-20240108   gcc  
x86_64                randconfig-075-20240107   clang
x86_64                randconfig-075-20240108   gcc  
x86_64                randconfig-076-20240107   clang
x86_64                randconfig-076-20240108   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240107   gcc  
xtensa                randconfig-001-20240108   gcc  
xtensa                randconfig-002-20240107   gcc  
xtensa                randconfig-002-20240108   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

