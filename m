Return-Path: <linux-pci+bounces-1094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02939815C02
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 23:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A471F22946
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51B328C2;
	Sat, 16 Dec 2023 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG4CrWMJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F233588C
	for <linux-pci@vger.kernel.org>; Sat, 16 Dec 2023 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702764183; x=1734300183;
  h=date:from:to:cc:subject:message-id;
  bh=8q4CtMCMF8VNRHtEdZTL7vFnIVyFcETkQkwehRVzCaE=;
  b=LG4CrWMJMzm7wySLF1LlscTCuAxuApdEfrTWvMhgkDxI4fHfJyP3ejXb
   zi+E604NGKSez3UVLKCs2Zw25TSUneJjQ3d9QjweZNrDPKTXlvwj8FPTT
   iVzOx4jCp4a8mk4HJdbP9J0dJ9bdSVSsVJmO/+yFIZl58m+JAdtOzzeUM
   wkbkqkanRlKr68eWN1DjhGnRx1DfMeUMESvrk+KGNeHl5R9wUqzEnX0gj
   C3rzdBJb2C9jiHVCK81CJ3d2LKgQTUf16gOs81k+G1fw7WXbvRo55nYys
   q1qeMDPrcUe2cdDfiJoEY/iuiJ1D8N3+fGhOGbcvIfWUp9MVTcNpVDNgM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="394264916"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="394264916"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 14:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="948348112"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="948348112"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2023 14:03:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEckM-0002G3-2b;
	Sat, 16 Dec 2023 22:02:58 +0000
Date: Sun, 17 Dec 2023 06:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 5df12742b7e3aae2594a30a9d14d5d6e9e7699f4
Message-ID: <202312170612.x5B3Hcbd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 5df12742b7e3aae2594a30a9d14d5d6e9e7699f4  Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

elapsed time: 1472m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231217   gcc  
arc                   randconfig-002-20231217   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                       netwinder_defconfig   clang
arm                   randconfig-001-20231217   clang
arm                   randconfig-002-20231217   clang
arm                   randconfig-003-20231217   clang
arm                   randconfig-004-20231217   clang
arm                             rpc_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231217   clang
arm64                 randconfig-002-20231217   clang
arm64                 randconfig-003-20231217   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231217   gcc  
csky                  randconfig-002-20231217   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231216   gcc  
i386         buildonly-randconfig-002-20231216   gcc  
i386         buildonly-randconfig-003-20231216   gcc  
i386         buildonly-randconfig-004-20231216   gcc  
i386         buildonly-randconfig-005-20231216   gcc  
i386         buildonly-randconfig-006-20231216   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231216   gcc  
i386                  randconfig-002-20231216   gcc  
i386                  randconfig-003-20231216   gcc  
i386                  randconfig-004-20231216   gcc  
i386                  randconfig-005-20231216   gcc  
i386                  randconfig-006-20231216   gcc  
i386                  randconfig-011-20231216   clang
i386                  randconfig-012-20231216   clang
i386                  randconfig-013-20231216   clang
i386                  randconfig-014-20231216   clang
i386                  randconfig-015-20231216   clang
i386                  randconfig-016-20231216   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231217   clang
x86_64       buildonly-randconfig-002-20231217   clang
x86_64       buildonly-randconfig-003-20231217   clang
x86_64       buildonly-randconfig-004-20231217   clang
x86_64       buildonly-randconfig-005-20231217   clang
x86_64       buildonly-randconfig-006-20231217   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231217   gcc  
x86_64                randconfig-002-20231217   gcc  
x86_64                randconfig-003-20231217   gcc  
x86_64                randconfig-004-20231217   gcc  
x86_64                randconfig-005-20231217   gcc  
x86_64                randconfig-006-20231217   gcc  
x86_64                randconfig-011-20231217   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

