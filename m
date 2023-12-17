Return-Path: <linux-pci+bounces-1095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD51815D29
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 03:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D324F283E4A
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286FA3D;
	Sun, 17 Dec 2023 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrdRg3zW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C1A32
	for <linux-pci@vger.kernel.org>; Sun, 17 Dec 2023 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702779327; x=1734315327;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JG4DTjPETZoaEw9R04SFHsCi44hDHGurlo93Xe/G1fY=;
  b=WrdRg3zWwVSXnajmQuVOfisg1IOoxH24/dVzwMndLg4I8hKqDUHLDa7q
   WT6VOlmg9NrMwoKt6C6dIkrDjj7d36SwsNZ870LbDrhYbXaUX/iblOGcu
   uYs2RDso9LEgDbCB+YZMDeJPteMSRpFQ2l/CunSJir5Z8JnpZQ5cLAvAL
   maxaGnwuqOFsm//MCH4uNwkbTu2f6M69H73ReaZIMtByhWJwLsvYkgpnP
   QUJhGwWRZPsOdhyFOqUXZiezN+rghtFoVRJrMHlqgEXWHvMfztFcL/P9e
   maoH0TzEju888QbPeZvTxvPcitgyTe25bCaof06O1yDxv/j/pTc9vCC9m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2235589"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="2235589"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 18:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="778697166"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="778697166"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2023 18:15:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEggZ-0002V1-2w;
	Sun, 17 Dec 2023 02:15:20 +0000
Date: Sun, 17 Dec 2023 10:14:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/remove-void-return] BUILD SUCCESS
 a5eee68931fcc6ecabd35651fed0c31439078e67
Message-ID: <202312171015.UNzl1IAv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/remove-void-return
branch HEAD: a5eee68931fcc6ecabd35651fed0c31439078e67  PCI: kirin: Convert to platform remove callback returning void

elapsed time: 1474m

configs tested: 193
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20231216   gcc  
arc                   randconfig-002-20231216   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20231216   gcc  
arm                   randconfig-002-20231216   gcc  
arm                   randconfig-003-20231216   gcc  
arm                   randconfig-004-20231216   gcc  
arm                             rpc_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231216   gcc  
arm64                 randconfig-002-20231216   gcc  
arm64                 randconfig-003-20231216   gcc  
arm64                 randconfig-004-20231216   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231216   gcc  
csky                  randconfig-002-20231216   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20231216   clang
i386                  randconfig-011-20231217   gcc  
i386                  randconfig-012-20231216   clang
i386                  randconfig-012-20231217   gcc  
i386                  randconfig-013-20231216   clang
i386                  randconfig-013-20231217   gcc  
i386                  randconfig-014-20231216   clang
i386                  randconfig-014-20231217   gcc  
i386                  randconfig-015-20231216   clang
i386                  randconfig-015-20231217   gcc  
i386                  randconfig-016-20231216   clang
i386                  randconfig-016-20231217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231216   gcc  
loongarch             randconfig-002-20231216   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip32_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231216   gcc  
nios2                 randconfig-002-20231216   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231216   gcc  
parisc                randconfig-002-20231216   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20231216   gcc  
powerpc               randconfig-002-20231216   gcc  
powerpc               randconfig-003-20231216   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231216   gcc  
powerpc64             randconfig-002-20231216   gcc  
powerpc64             randconfig-003-20231216   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231216   gcc  
riscv                 randconfig-002-20231216   gcc  
riscv                          rv32_defconfig   clang
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20231216   gcc  
sh                    randconfig-002-20231216   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231216   gcc  
sparc64               randconfig-002-20231216   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231216   gcc  
um                    randconfig-002-20231216   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231216   gcc  
x86_64       buildonly-randconfig-001-20231217   clang
x86_64       buildonly-randconfig-002-20231216   gcc  
x86_64       buildonly-randconfig-002-20231217   clang
x86_64       buildonly-randconfig-003-20231216   gcc  
x86_64       buildonly-randconfig-003-20231217   clang
x86_64       buildonly-randconfig-004-20231216   gcc  
x86_64       buildonly-randconfig-004-20231217   clang
x86_64       buildonly-randconfig-005-20231216   gcc  
x86_64       buildonly-randconfig-005-20231217   clang
x86_64       buildonly-randconfig-006-20231216   gcc  
x86_64       buildonly-randconfig-006-20231217   clang
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231216   gcc  
x86_64                randconfig-011-20231217   clang
x86_64                randconfig-012-20231216   gcc  
x86_64                randconfig-012-20231217   clang
x86_64                randconfig-013-20231216   gcc  
x86_64                randconfig-013-20231217   clang
x86_64                randconfig-014-20231216   gcc  
x86_64                randconfig-014-20231217   clang
x86_64                randconfig-015-20231216   gcc  
x86_64                randconfig-015-20231217   clang
x86_64                randconfig-016-20231216   gcc  
x86_64                randconfig-016-20231217   clang
x86_64                randconfig-071-20231216   gcc  
x86_64                randconfig-071-20231217   clang
x86_64                randconfig-072-20231216   gcc  
x86_64                randconfig-072-20231217   clang
x86_64                randconfig-073-20231216   gcc  
x86_64                randconfig-073-20231217   clang
x86_64                randconfig-074-20231216   gcc  
x86_64                randconfig-074-20231217   clang
x86_64                randconfig-075-20231216   gcc  
x86_64                randconfig-075-20231217   clang
x86_64                randconfig-076-20231216   gcc  
x86_64                randconfig-076-20231217   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231216   gcc  
xtensa                randconfig-002-20231216   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

