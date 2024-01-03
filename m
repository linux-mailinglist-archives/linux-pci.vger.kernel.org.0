Return-Path: <linux-pci+bounces-1639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A4782394C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 00:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D29B2489F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 23:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C81F613;
	Wed,  3 Jan 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsOb+c3p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB081F607
	for <linux-pci@vger.kernel.org>; Wed,  3 Jan 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704325451; x=1735861451;
  h=date:from:to:cc:subject:message-id;
  bh=T4zXGRhLnRTQ+oUJ3iLPu24rCcChIs+fZ3wHJmaZTUI=;
  b=GsOb+c3pgqtMlU6ZFeHBgeTCq3RWOVqVDOFXcAItTEy6BWp/XxMwPpJa
   IHkvzHIO29aQJYS0rAhvmdnLW8MP6X8zm9Xo/eYTVRClqMQUwXTrvJFRt
   prhtSP7QKUEkD0bdZY4+02T7AOK5f6UtbQSUAMexoI7KDppvul1t0OzUK
   6tr0qdVo73ENTnZIqNo5L2tPFfyqZ3nW6i+L9g8DyTPWeeH1YD4X5b2/k
   SNRzSgQC+LLaNAhkLQLFYMXKXvbtIg12lkRJebRlVx/rRQ9VPkq1MjQyN
   YFEHjfXjfOoYnPBWV9JqGv1HowTXjAg0D8LsGmPJ+ugBhdP6XKy5i2qm1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="377241630"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="377241630"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 15:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="870697033"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="870697033"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2024 15:44:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLAu7-000Mgm-0e;
	Wed, 03 Jan 2024 23:44:07 +0000
Date: Thu, 04 Jan 2024 07:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 db02e176f597a14eb696141ffa008c2429453a15
Message-ID: <202401040707.JxbbEfpD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: db02e176f597a14eb696141ffa008c2429453a15  PCI/AER: Use explicit register sizes for struct members

elapsed time: 1461m

configs tested: 201
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
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240103   gcc  
arc                   randconfig-002-20240103   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240103   clang
arm                   randconfig-002-20240103   clang
arm                   randconfig-003-20240103   clang
arm                   randconfig-004-20240103   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240103   clang
arm64                 randconfig-002-20240103   clang
arm64                 randconfig-003-20240103   clang
arm64                 randconfig-004-20240103   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240103   gcc  
csky                  randconfig-002-20240103   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240103   clang
hexagon               randconfig-002-20240103   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240103   clang
i386         buildonly-randconfig-002-20240103   clang
i386         buildonly-randconfig-003-20240103   clang
i386         buildonly-randconfig-004-20240103   clang
i386         buildonly-randconfig-005-20240103   clang
i386         buildonly-randconfig-006-20240103   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240103   clang
i386                  randconfig-002-20240103   clang
i386                  randconfig-003-20240103   clang
i386                  randconfig-004-20240103   clang
i386                  randconfig-005-20240103   clang
i386                  randconfig-006-20240103   clang
i386                  randconfig-011-20240103   gcc  
i386                  randconfig-011-20240104   clang
i386                  randconfig-012-20240103   gcc  
i386                  randconfig-012-20240104   clang
i386                  randconfig-013-20240103   gcc  
i386                  randconfig-013-20240104   clang
i386                  randconfig-014-20240103   gcc  
i386                  randconfig-014-20240104   clang
i386                  randconfig-015-20240103   gcc  
i386                  randconfig-015-20240104   clang
i386                  randconfig-016-20240103   gcc  
i386                  randconfig-016-20240104   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240103   gcc  
loongarch             randconfig-002-20240103   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240103   gcc  
nios2                 randconfig-002-20240103   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240103   gcc  
parisc                randconfig-002-20240103   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                     ksi8560_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20240103   clang
powerpc               randconfig-002-20240103   clang
powerpc               randconfig-003-20240103   clang
powerpc                     stx_gp3_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20240103   clang
powerpc64             randconfig-002-20240103   clang
powerpc64             randconfig-003-20240103   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240103   clang
riscv                 randconfig-002-20240103   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240103   gcc  
s390                  randconfig-002-20240103   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240103   gcc  
sh                    randconfig-002-20240103   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240103   gcc  
sparc64               randconfig-002-20240103   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240103   clang
um                    randconfig-002-20240103   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240103   clang
x86_64       buildonly-randconfig-002-20240103   clang
x86_64       buildonly-randconfig-003-20240103   clang
x86_64       buildonly-randconfig-004-20240103   clang
x86_64       buildonly-randconfig-005-20240103   clang
x86_64       buildonly-randconfig-006-20240103   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240103   clang
x86_64                randconfig-012-20240103   clang
x86_64                randconfig-013-20240103   clang
x86_64                randconfig-014-20240103   clang
x86_64                randconfig-015-20240103   clang
x86_64                randconfig-016-20240103   clang
x86_64                randconfig-071-20240103   clang
x86_64                randconfig-072-20240103   clang
x86_64                randconfig-073-20240103   clang
x86_64                randconfig-074-20240103   clang
x86_64                randconfig-075-20240103   clang
x86_64                randconfig-076-20240103   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240103   gcc  
xtensa                randconfig-002-20240103   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

