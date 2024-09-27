Return-Path: <linux-pci+bounces-13600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17319887A0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBC01F2242A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365BF1C0DF1;
	Fri, 27 Sep 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zaj3NVH+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5798D101F2
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448990; cv=none; b=M136piZGwxYM+TeLoUp1KsFx0rmUwFmDaZBSNzZNyeBebTRwrdOf2GSjP9YTfmJtT7OooJpB3KnpSTM4EGSEb93cNxBvhJpykLUB5VIooMPBtPTZJOfPBrfVOOy8UDVCJaCB3o79a/vWycoVU9ZUbMt5shZZgjENn39H07d0SgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448990; c=relaxed/simple;
	bh=FiwODEQqDhaUPY4iDH0UIOr9LIwRUVuEr6ebMC4t6mY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gd9Cs1X0NBage7WAXfiz6RgZT2hHpluGu6U59+p83jyTQh7Gia6XQ82rT80FY+UefksNBDCFPf2Ot/D0qIbGIL2+2hHlqSr82z4JsjTsJ7BlU6/saVjCTgbxJ071BxcQip6vkQ7jX6ksQxLsByw8qsCvE9PNt6wQFniqwAoo544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zaj3NVH+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727448988; x=1758984988;
  h=date:from:to:cc:subject:message-id;
  bh=FiwODEQqDhaUPY4iDH0UIOr9LIwRUVuEr6ebMC4t6mY=;
  b=Zaj3NVH+HoXk4zNBSQG670r90T3KP2wR7v6s4nJkNuoqd3vgxNwf+T+P
   o14Dsa2PRzVVNxksX8DMqrtfuig9yBr9Y0GE3IoZgLCozwkOzHi5mUSwx
   sm+jlXhhxwu5odXrSKx1io7o/xuwnuVXSEzJj/7tOYhyDzzDMRDV30Lvn
   7HQcjCtFO5xEh5hXZ/e88jlACWoHm1RrMTb56q8ceR5tip51I0Hu6WRld
   s3yl0oZaz0cJiW41mmEVOW/dS5m2IZs+4UxbevJcR0XkxdZAmSU1IiKqI
   YcUEYM0YSbeJ3kOhgp+YrrjmRp3ttg11WqNKWuNRUOrarR4sx4Dgc6yIf
   g==;
X-CSE-ConnectionGUID: 0a/T6yyoQ4uXqm3VVlEcLA==
X-CSE-MsgGUID: rwoW76gkSRmAxnkllDn29A==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="37978928"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="37978928"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 07:56:28 -0700
X-CSE-ConnectionGUID: uIYYtj6eRsiNXBrWSUaG2Q==
X-CSE-MsgGUID: XU8GQdo9SnSfNE96dOK8kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72447260"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Sep 2024 07:56:26 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suCOO-000MGa-24;
	Fri, 27 Sep 2024 14:56:24 +0000
Date: Fri, 27 Sep 2024 22:55:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/remove] BUILD SUCCESS
 855697801349a431fccec46d5cc6d20a0a80e724
Message-ID: <202409272249.3o8rdd1w-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/remove
branch HEAD: 855697801349a431fccec46d5cc6d20a0a80e724  PCI: controller: Switch back to struct platform_driver::remove()

elapsed time: 1001m

configs tested: 188
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-14.1.0
arc                   randconfig-001-20240927    gcc-14.1.0
arc                   randconfig-002-20240927    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          gemini_defconfig    gcc-14.1.0
arm                         lpc18xx_defconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                       multi_v4t_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                         orion5x_defconfig    gcc-14.1.0
arm                          pxa910_defconfig    gcc-14.1.0
arm                   randconfig-001-20240927    gcc-14.1.0
arm                   randconfig-002-20240927    gcc-14.1.0
arm                   randconfig-003-20240927    gcc-14.1.0
arm                   randconfig-004-20240927    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-14.1.0
arm                           sunxi_defconfig    gcc-14.1.0
arm                           tegra_defconfig    gcc-14.1.0
arm                           u8500_defconfig    gcc-14.1.0
arm                        vexpress_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240927    gcc-14.1.0
arm64                 randconfig-002-20240927    gcc-14.1.0
arm64                 randconfig-003-20240927    gcc-14.1.0
arm64                 randconfig-004-20240927    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240927    gcc-14.1.0
csky                  randconfig-002-20240927    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240927    gcc-14.1.0
hexagon               randconfig-002-20240927    gcc-14.1.0
i386                             alldefconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240927    clang-18
i386        buildonly-randconfig-002-20240927    clang-18
i386        buildonly-randconfig-003-20240927    clang-18
i386        buildonly-randconfig-004-20240927    clang-18
i386        buildonly-randconfig-005-20240927    clang-18
i386        buildonly-randconfig-006-20240927    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240927    clang-18
i386                  randconfig-002-20240927    clang-18
i386                  randconfig-003-20240927    clang-18
i386                  randconfig-004-20240927    clang-18
i386                  randconfig-005-20240927    clang-18
i386                  randconfig-006-20240927    clang-18
i386                  randconfig-011-20240927    clang-18
i386                  randconfig-012-20240927    clang-18
i386                  randconfig-013-20240927    clang-18
i386                  randconfig-014-20240927    clang-18
i386                  randconfig-015-20240927    clang-18
i386                  randconfig-016-20240927    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240927    gcc-14.1.0
loongarch             randconfig-002-20240927    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                  decstation_64_defconfig    gcc-14.1.0
mips                           gcw0_defconfig    gcc-14.1.0
mips                       lemote2f_defconfig    gcc-14.1.0
mips                           rs90_defconfig    gcc-14.1.0
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240927    gcc-14.1.0
nios2                 randconfig-002-20240927    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240927    gcc-14.1.0
parisc                randconfig-002-20240927    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                       eiger_defconfig    gcc-14.1.0
powerpc                      ep88xc_defconfig    gcc-14.1.0
powerpc                      katmai_defconfig    gcc-14.1.0
powerpc                     ksi8560_defconfig    gcc-14.1.0
powerpc                 linkstation_defconfig    gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.1.0
powerpc                    mvme5100_defconfig    gcc-14.1.0
powerpc                      ppc6xx_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240927    gcc-14.1.0
powerpc64             randconfig-001-20240927    gcc-14.1.0
powerpc64             randconfig-002-20240927    gcc-14.1.0
powerpc64             randconfig-003-20240927    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240927    gcc-14.1.0
riscv                 randconfig-002-20240927    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240927    gcc-14.1.0
s390                  randconfig-002-20240927    gcc-14.1.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                    randconfig-001-20240927    gcc-14.1.0
sh                    randconfig-002-20240927    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                   sh7770_generic_defconfig    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sh                          urquell_defconfig    gcc-14.1.0
sparc                            alldefconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-14.1.0
sparc64                          alldefconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240927    gcc-14.1.0
sparc64               randconfig-002-20240927    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240927    gcc-14.1.0
um                    randconfig-002-20240927    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20240927    gcc-14.1.0
xtensa                randconfig-002-20240927    gcc-14.1.0
xtensa                         virt_defconfig    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

