Return-Path: <linux-pci+bounces-1764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E972826395
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 10:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7B31C20CD5
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF98C15;
	Sun,  7 Jan 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lavYHIrj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4B12B6D
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704619369; x=1736155369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HGCf1stHwaSarrgh5qsf03KNARiXQM7nbgoCFfLMLgI=;
  b=lavYHIrj+gL1p5X2/VzMLn95RBBZDEoTahiiI7jzrLIDRbvB1pI07LgR
   /IH6QnNAMT2rR4T3K8ApW1UWX/btvwiUKzAdtA24arx8Ad76hm98OHMcQ
   oNbrBqIbKadV+RmWxNIRZABpFg+aGp8v9VuWoExqc7BNijKqh7CSM3jWF
   nlHn4CENsktcrewTZnX2nHKO9/FI5YFtMFBxYY0SZp6vAhy+wuPPu6qnm
   Lznhfx0HX7E6MJ0rvrWCUkQkL28Bq39sCb4ESH9L6j97UOfVFrlh4ZxcU
   vxmwtX6NUxhvTJCESPATM5tDuOzT5SKkD1Vr7L6DsZJXvzugaG8fxzTWB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="5082334"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="5082334"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 01:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="730850036"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="730850036"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2024 01:22:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMPMi-0003iO-1q;
	Sun, 07 Jan 2024 09:22:44 +0000
Date: Sun, 07 Jan 2024 17:21:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 7682f19c3c8c709ff4ef0e1d475f00907ade868f
Message-ID: <202401071748.eHc9dFW8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 7682f19c3c8c709ff4ef0e1d475f00907ade868f  PCI: rcar-gen4: Fix -Wvoid-pointer-to-enum-cast error

elapsed time: 1448m

configs tested: 184
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240107   gcc  
arc                   randconfig-002-20240107   gcc  
arm                               allnoconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                   randconfig-001-20240107   clang
arm                   randconfig-002-20240107   clang
arm                   randconfig-003-20240107   clang
arm                   randconfig-004-20240107   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240107   clang
arm64                 randconfig-002-20240107   clang
arm64                 randconfig-003-20240107   clang
arm64                 randconfig-004-20240107   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240107   gcc  
csky                  randconfig-002-20240107   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
hexagon               randconfig-001-20240107   clang
hexagon               randconfig-002-20240107   clang
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
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
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
powerpc                   motionpro_defconfig   gcc  
powerpc               randconfig-001-20240107   clang
powerpc               randconfig-002-20240107   clang
powerpc               randconfig-003-20240107   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc64             randconfig-001-20240107   clang
powerpc64             randconfig-002-20240107   clang
powerpc64             randconfig-003-20240107   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240107   clang
riscv                 randconfig-002-20240107   clang
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
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240107   gcc  
sh                    randconfig-002-20240107   gcc  
sh                           se7619_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240107   gcc  
sparc64               randconfig-002-20240107   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240107   clang
um                    randconfig-002-20240107   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240107   clang
x86_64       buildonly-randconfig-002-20240107   clang
x86_64       buildonly-randconfig-003-20240107   clang
x86_64       buildonly-randconfig-004-20240107   clang
x86_64       buildonly-randconfig-005-20240107   clang
x86_64       buildonly-randconfig-006-20240107   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20240107   gcc  
x86_64                randconfig-002-20240107   gcc  
x86_64                randconfig-003-20240107   gcc  
x86_64                randconfig-004-20240107   gcc  
x86_64                randconfig-005-20240107   gcc  
x86_64                randconfig-006-20240107   gcc  
x86_64                randconfig-011-20240107   clang
x86_64                randconfig-012-20240107   clang
x86_64                randconfig-013-20240107   clang
x86_64                randconfig-014-20240107   clang
x86_64                randconfig-015-20240107   clang
x86_64                randconfig-016-20240107   clang
x86_64                randconfig-071-20240107   clang
x86_64                randconfig-072-20240107   clang
x86_64                randconfig-073-20240107   clang
x86_64                randconfig-074-20240107   clang
x86_64                randconfig-075-20240107   clang
x86_64                randconfig-076-20240107   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240107   gcc  
xtensa                randconfig-002-20240107   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

