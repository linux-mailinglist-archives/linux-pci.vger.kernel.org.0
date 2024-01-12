Return-Path: <linux-pci+bounces-2098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B124382C0D5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 14:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA30B2390F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3F59B5C;
	Fri, 12 Jan 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHdUHAsO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0F6D1A3
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705065750; x=1736601750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lR0C1pYVPYDBsz6CW3SEyZNTfJE6rOzkVRg14AgL0Uo=;
  b=GHdUHAsOBMhSHA95iE/yveAn1CGCSMOnsaOVZN9zsK/yL+/eYneJTiIw
   0WFCofxKN3SawVZpwZSJTDorvkUHAEQ0vsuRVOPlkqmznWjDABzfDVEw3
   P4MtBae/rMYWM8YjoHDqljFkedGNB2LbV60gKuDOmY1Bn3theYKBHwt6r
   wUOEks/1VPPfh/xUh54j39OtT7im5LDFGTYAZYIKQ6lcG0vUuz9t3u+tB
   aIpdxXAc2g7wB6DoyulanzTOHhXw2gaA/NVG6l6JGZwQl77Ck7S8ePRfr
   0TE3OwBrzR2SOFOnFGLTzzTl/YpR6flVuZnWrL9JAzIH7p4ADeY7RCicc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20637373"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="20637373"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 05:22:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="24999469"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jan 2024 05:22:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOHUQ-0009Va-0g;
	Fri, 12 Jan 2024 13:22:26 +0000
Date: Fri, 12 Jan 2024 21:21:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/broadcom] BUILD SUCCESS
 e2596dcf1e9dfd5904d50f796c19b03c94a3b8b4
Message-ID: <202401122148.VWyorsi1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/broadcom
branch HEAD: e2596dcf1e9dfd5904d50f796c19b03c94a3b8b4  PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device

elapsed time: 1455m

configs tested: 161
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240112   gcc  
arc                   randconfig-002-20240112   gcc  
arm                               allnoconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240112   gcc  
csky                  randconfig-002-20240112   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20240112   gcc  
i386                  randconfig-012-20240112   gcc  
i386                  randconfig-013-20240112   gcc  
i386                  randconfig-014-20240112   gcc  
i386                  randconfig-015-20240112   gcc  
i386                  randconfig-016-20240112   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240112   gcc  
loongarch             randconfig-002-20240112   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240112   gcc  
nios2                 randconfig-002-20240112   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240112   gcc  
parisc                randconfig-002-20240112   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240112   gcc  
s390                  randconfig-002-20240112   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240112   gcc  
sh                    randconfig-002-20240112   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240112   gcc  
sparc64               randconfig-002-20240112   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240112   clang
x86_64       buildonly-randconfig-002-20240112   clang
x86_64       buildonly-randconfig-003-20240112   clang
x86_64       buildonly-randconfig-004-20240112   clang
x86_64       buildonly-randconfig-005-20240112   clang
x86_64       buildonly-randconfig-006-20240112   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240112   clang
x86_64                randconfig-012-20240112   clang
x86_64                randconfig-013-20240112   clang
x86_64                randconfig-014-20240112   clang
x86_64                randconfig-015-20240112   clang
x86_64                randconfig-016-20240112   clang
x86_64                randconfig-071-20240112   clang
x86_64                randconfig-072-20240112   clang
x86_64                randconfig-073-20240112   clang
x86_64                randconfig-074-20240112   clang
x86_64                randconfig-075-20240112   clang
x86_64                randconfig-076-20240112   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240112   gcc  
xtensa                randconfig-002-20240112   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

