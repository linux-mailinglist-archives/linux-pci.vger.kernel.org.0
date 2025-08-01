Return-Path: <linux-pci+bounces-33294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1087B18329
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01215170222
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE953259CB6;
	Fri,  1 Aug 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeLyPiA0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4194156CA
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057081; cv=none; b=eRhfJszzDZ4FYDvOpSmcO/HLMmwL3l/StQRNGKUKvPe3G5oUgPkMTjWiPZz7yVJMPIV5dOPHjTWexPoFK/D/ZhQ8T/bnSt3EveqmqO8I53XfZ9yd3Hkd9ZfZk+3mOb039bZntlY0Y4m1ea9StrI/VQnYhafFAgSHeSkFIUduR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057081; c=relaxed/simple;
	bh=OUfvDbm2+n6Kk7yN4/92WE9cXLKqfgXDL5iaL1avBM4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QV950V+KrgE77LNxTVK4LztIW2cHJyhtoZMJ9ykZYiCVQeLGssIN04XUyIlLJ5sL2xxYzTVLyNh4IkD3UJ+bsSTx6BBo4K1ezAfoyThUpoPD+vUO3yCSaODAYW9NYHIsid31QCruNR0eM2I3fsT+nhOnlQsaulu8lP1xRWLuzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeLyPiA0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754057080; x=1785593080;
  h=date:from:to:cc:subject:message-id;
  bh=OUfvDbm2+n6Kk7yN4/92WE9cXLKqfgXDL5iaL1avBM4=;
  b=EeLyPiA0lbUxNmlXxxUVo6Sy+cwTOQCfOsonc3GOtRkxwPwCVf6E65H4
   DSSNYvXb7Sz+9N8UYljSCQcGwNFZFiYeX4P0uNX2R8157ODOu8W9huShq
   4lKlujsZi69eWhy3TpKYZBxEgeLkyoEAHLMueqekfGl5Rtw+toUdB2IfY
   LR2bmg018q+3lnlbSzUdAJVzBMJiGS2MRymrOynPuqWZTPOOGMJCNTvzx
   xlxhxCwYsH3tz/GIzLP7uIH1AKwt8AJ/QIuQ2a81AFFqhbCGK0IPhyNaQ
   mM6jcAQm4evLfNBa0OdWnU1V1G7CHl6p2Uf0gcaTks0T75Qm/4I9ewjeB
   g==;
X-CSE-ConnectionGUID: mCtV04nzRYmS9sFjqxDuBw==
X-CSE-MsgGUID: X/b0XFHzQba1Y2ww6FarOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67767675"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="67767675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:04:14 -0700
X-CSE-ConnectionGUID: LVrjGvtkQDmHexpQsNoBug==
X-CSE-MsgGUID: B0nfXCtSREKQn/jNnDUt2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163502843"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Aug 2025 07:04:12 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhqMk-0004g4-02;
	Fri, 01 Aug 2025 14:04:10 +0000
Date: Fri, 01 Aug 2025 22:04:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:v6.17-merge] BUILD SUCCESS
 7b76d8fd6a641d9e71a296c09073f2943e3eb8cf
Message-ID: <202508012255.7Pbwjpoa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git v6.17-merge
branch HEAD: 7b76d8fd6a641d9e71a296c09073f2943e3eb8cf  Merge branch 'next' into v6.17-merge

elapsed time: 953m

configs tested: 165
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250801    gcc-10.5.0
arc                   randconfig-001-20250801    gcc-15.1.0
arc                   randconfig-002-20250801    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20250801    clang-22
arm                   randconfig-001-20250801    gcc-10.5.0
arm                   randconfig-002-20250801    gcc-10.5.0
arm                   randconfig-002-20250801    gcc-8.5.0
arm                   randconfig-003-20250801    gcc-10.5.0
arm                   randconfig-004-20250801    gcc-10.5.0
arm                   randconfig-004-20250801    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250801    clang-22
arm64                 randconfig-001-20250801    gcc-10.5.0
arm64                 randconfig-002-20250801    clang-22
arm64                 randconfig-002-20250801    gcc-10.5.0
arm64                 randconfig-003-20250801    gcc-10.5.0
arm64                 randconfig-003-20250801    gcc-11.5.0
arm64                 randconfig-004-20250801    clang-22
arm64                 randconfig-004-20250801    gcc-10.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250801    gcc-13.4.0
csky                  randconfig-002-20250801    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250801    clang-22
hexagon               randconfig-002-20250801    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250801    clang-20
i386        buildonly-randconfig-002-20250801    gcc-12
i386        buildonly-randconfig-003-20250801    gcc-12
i386        buildonly-randconfig-004-20250801    gcc-12
i386        buildonly-randconfig-005-20250801    gcc-12
i386        buildonly-randconfig-006-20250801    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250801    gcc-12
i386                  randconfig-002-20250801    gcc-12
i386                  randconfig-003-20250801    gcc-12
i386                  randconfig-004-20250801    gcc-12
i386                  randconfig-005-20250801    gcc-12
i386                  randconfig-006-20250801    gcc-12
i386                  randconfig-007-20250801    gcc-12
i386                  randconfig-011-20250801    gcc-12
i386                  randconfig-012-20250801    gcc-12
i386                  randconfig-013-20250801    gcc-12
i386                  randconfig-014-20250801    gcc-12
i386                  randconfig-015-20250801    gcc-12
i386                  randconfig-016-20250801    gcc-12
i386                  randconfig-017-20250801    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250801    gcc-15.1.0
loongarch             randconfig-002-20250801    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250801    gcc-11.5.0
nios2                 randconfig-002-20250801    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250801    gcc-13.4.0
parisc                randconfig-002-20250801    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250801    gcc-13.4.0
powerpc               randconfig-002-20250801    clang-22
powerpc               randconfig-003-20250801    clang-22
powerpc                 xes_mpc85xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250801    gcc-8.5.0
powerpc64             randconfig-002-20250801    clang-22
powerpc64             randconfig-003-20250801    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20250801    clang-22
riscv                 randconfig-002-20250801    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250801    clang-22
s390                  randconfig-002-20250801    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250801    gcc-14.3.0
sh                    randconfig-002-20250801    gcc-11.5.0
sh                          sdk7786_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250801    gcc-15.1.0
sparc                 randconfig-002-20250801    gcc-15.1.0
sparc64               randconfig-001-20250801    gcc-9.5.0
sparc64               randconfig-002-20250801    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250801    gcc-12
um                    randconfig-002-20250801    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250801    gcc-12
x86_64      buildonly-randconfig-002-20250801    clang-20
x86_64      buildonly-randconfig-003-20250801    clang-20
x86_64      buildonly-randconfig-004-20250801    clang-20
x86_64      buildonly-randconfig-005-20250801    gcc-12
x86_64      buildonly-randconfig-006-20250801    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250801    gcc-8.5.0
xtensa                randconfig-002-20250801    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

