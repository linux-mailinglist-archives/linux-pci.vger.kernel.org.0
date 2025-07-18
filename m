Return-Path: <linux-pci+bounces-32532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93470B0A510
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 15:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B51886F3B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CEE2DEA69;
	Fri, 18 Jul 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWzHHPoE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39822DCBF4
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845055; cv=none; b=OhJf+s7g8Jq2S8rVkv2wMEWxpzsdR4ZNeF7/ccxW1dMjz45oQXyBGaa3A0aLn7zEX9smkc0JAO7nlXBn35kYW2vwhN0WAQOkOyuDKZIFngAN6JH/8Ahc13Dz9JgfLuRBWZRhMb5a4TZvtcT9+JjG5aT+fTc6QbMXOdCihWfOopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845055; c=relaxed/simple;
	bh=cO2wYstAnA9d8OtKLXJEQsdAobbkoeOfF+A2O3OIzp0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=POQ2E0gSZhuuh/1R9je/VAluWrn0TGAQNuOmIyPVKyrwgW/T1BqT1StHdunvW6+dqT4oJ1HgOp7xY+i5vV3Rai+B6NLDRAg+REUoz9pNRD1IVEtLc88PHqKFDYpiUHSp9nsr7Fv6NDQ3MnwEqAWxxklncCXL4pXmLq6u5ZCpn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWzHHPoE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752845054; x=1784381054;
  h=date:from:to:cc:subject:message-id;
  bh=cO2wYstAnA9d8OtKLXJEQsdAobbkoeOfF+A2O3OIzp0=;
  b=HWzHHPoE8TMtKyPf8hnZaFJ2haVe0FG7bULnEo3+gzhynNa1J6ape2Oz
   a2bSU7K6poG/9CjryFVEQU7FsUZRQC2xOtjCSmiCIy8NBTtXrW2cX8jqZ
   oCSG2dWs9QMkC/HL8N7OnQOWAEax1+I6ZK+8E+sfEabRO5Gb95RcLi0YB
   VxblSvzioG27/TxiC4+GHG29Ux1misfaGmLH3DdMDlfyFwe10Jj/ipKXn
   /gvkEPDXzJAA3EERFke67qLpSaFG4fJg3r2E0FSOQihsvXtfbQJubRQ9X
   tX8h5fiFcguu0qRpzOsTtFWkbtJ8XUPbMChrO1z09kR6xPXxPA+4nHItm
   w==;
X-CSE-ConnectionGUID: Xu4X7zYoRRKqUzyDcjTHzg==
X-CSE-MsgGUID: Jtqc3D2aQVaVYWOKBf7umw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54994274"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="54994274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 06:24:13 -0700
X-CSE-ConnectionGUID: mKD/Pul1Tla2AVB76NTbjg==
X-CSE-MsgGUID: 6JVe5jjEQQuARYn3PPrKjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="163689259"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jul 2025 06:24:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucl4L-000EhR-1y;
	Fri, 18 Jul 2025 13:24:09 +0000
Date: Fri, 18 Jul 2025 21:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 e8e7c1e95d6d4ccdc53654a5966d2183532ab115
Message-ID: <202507182153.pnZsmotU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: e8e7c1e95d6d4ccdc53654a5966d2183532ab115  PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS

elapsed time: 1459m

configs tested: 236
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250717    gcc-8.5.0
arc                   randconfig-001-20250718    gcc-8.5.0
arc                   randconfig-002-20250717    gcc-15.1.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    clang-19
arm                         orion5x_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250717    clang-21
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-002-20250717    gcc-8.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250717    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250717    clang-21
arm                   randconfig-004-20250718    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250717    clang-18
arm64                 randconfig-001-20250718    gcc-8.5.0
arm64                 randconfig-002-20250717    clang-18
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250717    gcc-10.5.0
arm64                 randconfig-003-20250718    gcc-8.5.0
arm64                 randconfig-004-20250717    clang-21
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250717    gcc-15.1.0
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250717    gcc-12.4.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250717    clang-20
hexagon               randconfig-001-20250718    gcc-15.1.0
hexagon               randconfig-002-20250717    clang-19
hexagon               randconfig-002-20250718    gcc-15.1.0
i386                             alldefconfig    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250717    gcc-12
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250717    gcc-12
i386        buildonly-randconfig-002-20250718    gcc-12
i386        buildonly-randconfig-003-20250717    clang-20
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250717    clang-20
i386        buildonly-randconfig-004-20250718    gcc-12
i386        buildonly-randconfig-005-20250717    clang-20
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250717    gcc-12
i386        buildonly-randconfig-006-20250718    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250718    gcc-12
i386                  randconfig-002-20250718    gcc-12
i386                  randconfig-003-20250718    gcc-12
i386                  randconfig-004-20250718    gcc-12
i386                  randconfig-005-20250718    gcc-12
i386                  randconfig-006-20250718    gcc-12
i386                  randconfig-007-20250718    gcc-12
i386                  randconfig-011-20250718    clang-20
i386                  randconfig-012-20250718    clang-20
i386                  randconfig-013-20250718    clang-20
i386                  randconfig-014-20250718    clang-20
i386                  randconfig-015-20250718    clang-20
i386                  randconfig-016-20250718    clang-20
i386                  randconfig-017-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250717    gcc-15.1.0
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250717    clang-21
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250717    gcc-8.5.0
nios2                 randconfig-001-20250718    gcc-15.1.0
nios2                 randconfig-002-20250717    gcc-9.3.0
nios2                 randconfig-002-20250718    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250717    gcc-9.3.0
parisc                randconfig-001-20250718    gcc-15.1.0
parisc                randconfig-002-20250717    gcc-9.3.0
parisc                randconfig-002-20250718    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
powerpc                      ppc44x_defconfig    clang-21
powerpc               randconfig-001-20250717    clang-21
powerpc               randconfig-001-20250718    gcc-15.1.0
powerpc               randconfig-002-20250717    gcc-13.4.0
powerpc               randconfig-002-20250718    gcc-15.1.0
powerpc               randconfig-003-20250717    clang-21
powerpc               randconfig-003-20250718    gcc-15.1.0
powerpc64             randconfig-001-20250717    clang-21
powerpc64             randconfig-001-20250718    gcc-15.1.0
powerpc64             randconfig-002-20250717    clang-18
powerpc64             randconfig-002-20250718    gcc-15.1.0
powerpc64             randconfig-003-20250717    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250717    gcc-14.3.0
riscv                 randconfig-001-20250718    gcc-15.1.0
riscv                 randconfig-002-20250717    clang-21
riscv                 randconfig-002-20250718    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250717    gcc-8.5.0
s390                  randconfig-001-20250718    gcc-15.1.0
s390                  randconfig-002-20250717    gcc-9.3.0
s390                  randconfig-002-20250718    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20250717    gcc-14.3.0
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-002-20250717    gcc-9.3.0
sh                    randconfig-002-20250718    gcc-15.1.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250717    gcc-14.3.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-002-20250717    gcc-8.5.0
sparc                 randconfig-002-20250718    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250717    gcc-12.4.0
sparc64               randconfig-001-20250718    gcc-15.1.0
sparc64               randconfig-002-20250717    clang-21
sparc64               randconfig-002-20250718    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250717    gcc-12
um                    randconfig-001-20250718    gcc-15.1.0
um                    randconfig-002-20250717    gcc-12
um                    randconfig-002-20250718    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250717    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250717    clang-20
x86_64      buildonly-randconfig-002-20250718    clang-20
x86_64      buildonly-randconfig-003-20250717    clang-20
x86_64      buildonly-randconfig-003-20250718    clang-20
x86_64      buildonly-randconfig-004-20250717    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250717    gcc-12
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250717    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250718    clang-20
x86_64                randconfig-002-20250718    clang-20
x86_64                randconfig-003-20250718    clang-20
x86_64                randconfig-004-20250718    clang-20
x86_64                randconfig-005-20250718    clang-20
x86_64                randconfig-006-20250718    clang-20
x86_64                randconfig-007-20250718    clang-20
x86_64                randconfig-008-20250718    clang-20
x86_64                randconfig-071-20250718    clang-20
x86_64                randconfig-072-20250718    clang-20
x86_64                randconfig-073-20250718    clang-20
x86_64                randconfig-074-20250718    clang-20
x86_64                randconfig-075-20250718    clang-20
x86_64                randconfig-076-20250718    clang-20
x86_64                randconfig-077-20250718    clang-20
x86_64                randconfig-078-20250718    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250717    gcc-13.4.0
xtensa                randconfig-001-20250718    gcc-15.1.0
xtensa                randconfig-002-20250717    gcc-9.3.0
xtensa                randconfig-002-20250718    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

