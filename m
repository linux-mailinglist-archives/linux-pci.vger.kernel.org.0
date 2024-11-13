Return-Path: <linux-pci+bounces-16673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A89C7791
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CF0282B5D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6CE249EB;
	Wed, 13 Nov 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFF9sytn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EB7E0E8
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512512; cv=none; b=RFG0rHA0tmC75ZrUx0pTovXO5EEli7uxOJwMGsz3+yMu3AjkhQVw0mooiRWNjnGJnJxy4IhL02To/rSWIlMcrR8ma2VG2qSebZydMbihTGEletxolKRLQxVHecxcV6TZJf6x2vi7EW4tjQDaKDdvauHtc7ehqVeLRHJcB1db3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512512; c=relaxed/simple;
	bh=WpO4xbJrB8gJAXdO+Qa3rxJP0JJJqNO5DLHV6DsiKZM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qEMgjmaKo/6ZzA3xMM99s9KqYqsvOux9eSJmRnFM/NKVYoGuGp+rQ2Yjz/uZfaqI6zKS8asw1NubcYqe4rNbvAFhlSXF6uxmwCBpMHNB9oE8iuYvWEGMse1BCkct5RbQjj2/9UNeYX+t1oKzslpnLMeAVxFS2Yt458FrMhwMeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFF9sytn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731512511; x=1763048511;
  h=date:from:to:cc:subject:message-id;
  bh=WpO4xbJrB8gJAXdO+Qa3rxJP0JJJqNO5DLHV6DsiKZM=;
  b=UFF9sytnmUpN2ZWcdM3hVn2dO05f42CzM2Xw8N7Y11dH2gXqvt6MkqPd
   yQKI3AJ9wkLba+VIdh8bIaT7NKd80KWQblA7jbL986Q73nKUCs5F9EHEO
   21LA5c5QDa3pWiz/7vvH8G9i/T1yuvuaEyouMCCDJfnq9tCsg4nycM6D6
   +Y9uvn24zgDVWw7RXfVhOl1u4ntyUWgJpThExLnNzVZjIB1jfXZrL698z
   w5faw73w4PHMmNBn6meMLZZXllzyCS4zaK3nlAttHRM269qLhON7q2hCp
   pTV4KDuPhJOKXIpcH4SNoASLddTZLxTepdgSJ2Vbiy5Hs+/j6O0o+RFuy
   g==;
X-CSE-ConnectionGUID: 1+qxhXErSFqeKHFIyx6jBg==
X-CSE-MsgGUID: G0kz2BLUR7y2dl7S/OZhfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41972350"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41972350"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:41:51 -0800
X-CSE-ConnectionGUID: Z2N6ZuJNTpy6C0N8aFAZOA==
X-CSE-MsgGUID: x1dANeWSQfSgwUVkx/RnrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92975390"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Nov 2024 07:41:49 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBFV4-0000VB-2F;
	Wed, 13 Nov 2024 15:41:46 +0000
Date: Wed, 13 Nov 2024 23:41:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD SUCCESS
 78e372d9905b3d23ad024ca74e554bd4d72851fe
Message-ID: <202411132310.z3cKUTLJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: 78e372d9905b3d23ad024ca74e554bd4d72851fe  PCI: Drop duplicate pcie_get_speed_cap(), pcie_get_width_cap() declarations

elapsed time: 1065m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    clang-19
i386        buildonly-randconfig-005-20241113    clang-19
i386        buildonly-randconfig-006-20241113    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    clang-19
i386                  randconfig-002-20241113    clang-19
i386                  randconfig-003-20241113    clang-19
i386                  randconfig-004-20241113    clang-19
i386                  randconfig-005-20241113    clang-19
i386                  randconfig-006-20241113    clang-19
i386                  randconfig-011-20241113    clang-19
i386                  randconfig-012-20241113    clang-19
i386                  randconfig-013-20241113    clang-19
i386                  randconfig-014-20241113    clang-19
i386                  randconfig-015-20241113    clang-19
i386                  randconfig-016-20241113    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                       maple_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241113    clang-19
x86_64      buildonly-randconfig-002-20241113    clang-19
x86_64      buildonly-randconfig-003-20241113    clang-19
x86_64      buildonly-randconfig-004-20241113    clang-19
x86_64      buildonly-randconfig-005-20241113    clang-19
x86_64      buildonly-randconfig-006-20241113    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241113    clang-19
x86_64                randconfig-002-20241113    clang-19
x86_64                randconfig-003-20241113    clang-19
x86_64                randconfig-004-20241113    clang-19
x86_64                randconfig-005-20241113    clang-19
x86_64                randconfig-006-20241113    clang-19
x86_64                randconfig-011-20241113    clang-19
x86_64                randconfig-012-20241113    clang-19
x86_64                randconfig-013-20241113    clang-19
x86_64                randconfig-014-20241113    clang-19
x86_64                randconfig-015-20241113    clang-19
x86_64                randconfig-016-20241113    clang-19
x86_64                randconfig-071-20241113    clang-19
x86_64                randconfig-072-20241113    clang-19
x86_64                randconfig-073-20241113    clang-19
x86_64                randconfig-074-20241113    clang-19
x86_64                randconfig-075-20241113    clang-19
x86_64                randconfig-076-20241113    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

