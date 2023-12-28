Return-Path: <linux-pci+bounces-1485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1C81F371
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 01:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CC41C227E3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 00:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9A368;
	Thu, 28 Dec 2023 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOFVY0gA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8B5671
	for <linux-pci@vger.kernel.org>; Thu, 28 Dec 2023 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703723815; x=1735259815;
  h=date:from:to:cc:subject:message-id;
  bh=lrYx3ECdO4R0UKFHxxBeFpuw8blk0GIljOioKKJVCug=;
  b=hOFVY0gABHchRC/YcenFDCNgUfWjnt64aULP3kcpnmnlQlk66Q0K3Gz+
   9DZrg+92iOVnU6Zc9DYUdH+KOIgfRPk8fNV7mcXZ2lhFpSIMQVR72UWlV
   bbKSsoTjG1Ch8LzKbPw3SGaXJ+Rqz5oy98ZHn6AlK0JIdLv3E3QWgrWU5
   8xfOeQJcnMAmdBYRzab0uoNjdx/8Ez6gs/Sv7z8gyZsAgqnBtd9XmFuXC
   APvnQCDKoRKrh49RLVE0MhDbJXC9vyRDYUyllLCWN46Cm74L8yBn2TneT
   IIBLVTieP4vekLXyXRe+cK95lHskpkSmKT3dSnAwMXxpHbCWIzqdJbrxe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="482675542"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="482675542"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 16:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781890958"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="781890958"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2023 16:36:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIeOJ-000Fs7-1g;
	Thu, 28 Dec 2023 00:36:51 +0000
Date: Thu, 28 Dec 2023 08:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 6936c253ee2e4061f6e62f940efbd46a256f91c0
Message-ID: <202312280822.grctYmT1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 6936c253ee2e4061f6e62f940efbd46a256f91c0  Merge branch 'pci/dt-bindings'

elapsed time: 1451m

configs tested: 250
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
arc                          axs101_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20231227   gcc  
arc                   randconfig-001-20231228   gcc  
arc                   randconfig-002-20231227   gcc  
arc                   randconfig-002-20231228   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20231227   clang
arm                   randconfig-001-20231228   gcc  
arm                   randconfig-002-20231227   clang
arm                   randconfig-002-20231228   gcc  
arm                   randconfig-003-20231227   clang
arm                   randconfig-003-20231228   gcc  
arm                   randconfig-004-20231227   clang
arm                   randconfig-004-20231228   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231227   clang
arm64                 randconfig-001-20231228   gcc  
arm64                 randconfig-002-20231227   clang
arm64                 randconfig-002-20231228   gcc  
arm64                 randconfig-003-20231227   clang
arm64                 randconfig-003-20231228   gcc  
arm64                 randconfig-004-20231227   clang
arm64                 randconfig-004-20231228   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231227   gcc  
csky                  randconfig-001-20231228   gcc  
csky                  randconfig-002-20231227   gcc  
csky                  randconfig-002-20231228   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231227   clang
hexagon               randconfig-002-20231227   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231227   clang
i386         buildonly-randconfig-002-20231227   clang
i386         buildonly-randconfig-003-20231227   clang
i386         buildonly-randconfig-004-20231227   clang
i386         buildonly-randconfig-005-20231227   clang
i386         buildonly-randconfig-006-20231227   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231227   clang
i386                  randconfig-002-20231227   clang
i386                  randconfig-003-20231227   clang
i386                  randconfig-004-20231227   clang
i386                  randconfig-005-20231227   clang
i386                  randconfig-006-20231227   clang
i386                  randconfig-011-20231227   gcc  
i386                  randconfig-011-20231228   clang
i386                  randconfig-012-20231227   gcc  
i386                  randconfig-012-20231228   clang
i386                  randconfig-013-20231227   gcc  
i386                  randconfig-013-20231228   clang
i386                  randconfig-014-20231227   gcc  
i386                  randconfig-014-20231228   clang
i386                  randconfig-015-20231227   gcc  
i386                  randconfig-015-20231228   clang
i386                  randconfig-016-20231227   gcc  
i386                  randconfig-016-20231228   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231227   gcc  
loongarch             randconfig-001-20231228   gcc  
loongarch             randconfig-002-20231227   gcc  
loongarch             randconfig-002-20231228   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231227   gcc  
nios2                 randconfig-001-20231228   gcc  
nios2                 randconfig-002-20231227   gcc  
nios2                 randconfig-002-20231228   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231227   gcc  
parisc                randconfig-001-20231228   gcc  
parisc                randconfig-002-20231227   gcc  
parisc                randconfig-002-20231228   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231227   clang
powerpc               randconfig-001-20231228   gcc  
powerpc               randconfig-002-20231227   clang
powerpc               randconfig-002-20231228   gcc  
powerpc               randconfig-003-20231227   clang
powerpc               randconfig-003-20231228   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc64             randconfig-001-20231227   clang
powerpc64             randconfig-001-20231228   gcc  
powerpc64             randconfig-002-20231227   clang
powerpc64             randconfig-002-20231228   gcc  
powerpc64             randconfig-003-20231227   clang
powerpc64             randconfig-003-20231228   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231227   clang
riscv                 randconfig-001-20231228   gcc  
riscv                 randconfig-002-20231227   clang
riscv                 randconfig-002-20231228   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231227   gcc  
s390                  randconfig-002-20231227   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231227   gcc  
sh                    randconfig-001-20231228   gcc  
sh                    randconfig-002-20231227   gcc  
sh                    randconfig-002-20231228   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231227   gcc  
sparc64               randconfig-001-20231228   gcc  
sparc64               randconfig-002-20231227   gcc  
sparc64               randconfig-002-20231228   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231227   clang
um                    randconfig-001-20231228   gcc  
um                    randconfig-002-20231227   clang
um                    randconfig-002-20231228   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231227   clang
x86_64       buildonly-randconfig-002-20231227   clang
x86_64       buildonly-randconfig-003-20231227   clang
x86_64       buildonly-randconfig-004-20231227   clang
x86_64       buildonly-randconfig-005-20231227   clang
x86_64       buildonly-randconfig-006-20231227   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231227   gcc  
x86_64                randconfig-002-20231227   gcc  
x86_64                randconfig-003-20231227   gcc  
x86_64                randconfig-004-20231227   gcc  
x86_64                randconfig-005-20231227   gcc  
x86_64                randconfig-006-20231227   gcc  
x86_64                randconfig-011-20231227   clang
x86_64                randconfig-012-20231227   clang
x86_64                randconfig-013-20231227   clang
x86_64                randconfig-014-20231227   clang
x86_64                randconfig-015-20231227   clang
x86_64                randconfig-016-20231227   clang
x86_64                randconfig-071-20231227   clang
x86_64                randconfig-072-20231227   clang
x86_64                randconfig-073-20231227   clang
x86_64                randconfig-074-20231227   clang
x86_64                randconfig-075-20231227   clang
x86_64                randconfig-076-20231227   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20231227   gcc  
xtensa                randconfig-001-20231228   gcc  
xtensa                randconfig-002-20231227   gcc  
xtensa                randconfig-002-20231228   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

