Return-Path: <linux-pci+bounces-15339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081C9B09B4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A33A1F2221F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709D18595F;
	Fri, 25 Oct 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxzSsFye"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF021A4CE
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873277; cv=none; b=WKh1wuonEWwD5Qxg3zlACVtuhT2fxFFBHG1glkXPZBRtylErwCVZY62QamGnXRv+IJhbV+sjvWf3GWlS/4KEYgZzuMrpMFAm8x1Rrx2XDBl6a3/Uo0FqQ7PR+ZIOqtjB+oULz5qYhCZZ3k9SakiS2bcmLn2qbzEYaU6Jq40ZOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873277; c=relaxed/simple;
	bh=wRIqcXYSu0TbsfnU66uracppMzGtCR8Gy9RC3f86X8o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NlCfzR/G+tbW/hRWRF3SMPW46w1buUoc86+A8ewxTDpkBqKCRikgPa5OT8jFLJy+LfgVo1FvtAI2KFtM0Cn7ckQFCkUstSo1YZY9mDq/GGyKalJ5muMq1c8pdS27JRtBT4UlOBPvYfY6ayxub55MuB9GdUlufjXZZ5rpTO+77kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxzSsFye; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729873275; x=1761409275;
  h=date:from:to:cc:subject:message-id;
  bh=wRIqcXYSu0TbsfnU66uracppMzGtCR8Gy9RC3f86X8o=;
  b=LxzSsFyeW524253PK0KCVuZClxfVHe5WE3UZWyJOu9/GQZKb60zTX7F3
   o2Wt2kTYuxHVvIR2QsTZgBYLHk5V4T1GB96q7JC8XjXsRHbischdpERLO
   62VNNBeXaactQZYCMGrfgwo3aX4+qK314Y/sRV0caxmRquWTVR3a4FKol
   GKrxzdQIxZjjwN5HbbGZJXz0cIw16VRre7S9iAkl1ITPgISj2+VHQplEP
   ImUS9FCredc2Jo202gobmCgClZRbyWWepDUhOJLtXO8DT5UcMKT/AlcKb
   J0uRnf8mcntcaXeOtn4lrDzOK83WYuTizORT/xCbvvkbB2vF55OM+o49y
   A==;
X-CSE-ConnectionGUID: ilKHwpEgQcW/qF+rQLElsQ==
X-CSE-MsgGUID: VjBl8rLWTQCD4sERVk/5mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="33352030"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="33352030"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:21:14 -0700
X-CSE-ConnectionGUID: z9EyZzHvRr2wcG8ZWKT22A==
X-CSE-MsgGUID: uNFAcXa0Tditlx1A9yF9gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80883392"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Oct 2024 09:21:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4N3n-000YTQ-09;
	Fri, 25 Oct 2024 16:21:11 +0000
Date: Sat, 26 Oct 2024 00:20:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD SUCCESS
 18956ececba637e45fa1f2a91126d0421b3e05a5
Message-ID: <202410260037.5LfifXa3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: 18956ececba637e45fa1f2a91126d0421b3e05a5  selftests/pcie_bwctrl: Create selftests

elapsed time: 1229m

configs tested: 198
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241025    gcc-14.1.0
arc                   randconfig-002-20241025    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                         lpc18xx_defconfig    gcc-14.1.0
arm                           omap1_defconfig    gcc-14.1.0
arm                   randconfig-001-20241025    gcc-14.1.0
arm                   randconfig-002-20241025    gcc-14.1.0
arm                   randconfig-003-20241025    gcc-14.1.0
arm                   randconfig-004-20241025    gcc-14.1.0
arm                           sama5_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241025    gcc-14.1.0
arm64                 randconfig-002-20241025    gcc-14.1.0
arm64                 randconfig-003-20241025    gcc-14.1.0
arm64                 randconfig-004-20241025    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241025    gcc-14.1.0
csky                  randconfig-002-20241025    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241025    gcc-14.1.0
hexagon               randconfig-002-20241025    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241025    gcc-12
i386        buildonly-randconfig-002-20241025    gcc-12
i386        buildonly-randconfig-003-20241025    gcc-12
i386        buildonly-randconfig-004-20241025    gcc-12
i386        buildonly-randconfig-005-20241025    gcc-12
i386        buildonly-randconfig-006-20241025    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241025    gcc-12
i386                  randconfig-002-20241025    gcc-12
i386                  randconfig-003-20241025    gcc-12
i386                  randconfig-004-20241025    gcc-12
i386                  randconfig-005-20241025    gcc-12
i386                  randconfig-006-20241025    gcc-12
i386                  randconfig-011-20241025    gcc-12
i386                  randconfig-012-20241025    gcc-12
i386                  randconfig-013-20241025    gcc-12
i386                  randconfig-014-20241025    gcc-12
i386                  randconfig-015-20241025    gcc-12
i386                  randconfig-016-20241025    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241025    gcc-14.1.0
loongarch             randconfig-002-20241025    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    clang-20
mips                         bigsur_defconfig    clang-20
mips                          eyeq6_defconfig    gcc-14.1.0
mips                            gpr_defconfig    clang-20
mips                        omega2p_defconfig    clang-20
nios2                         10m50_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241025    gcc-14.1.0
nios2                 randconfig-002-20241025    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241025    gcc-14.1.0
parisc                randconfig-002-20241025    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    clang-20
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc               randconfig-001-20241025    gcc-14.1.0
powerpc               randconfig-002-20241025    gcc-14.1.0
powerpc               randconfig-003-20241025    gcc-14.1.0
powerpc                     tqm8560_defconfig    clang-20
powerpc64             randconfig-001-20241025    gcc-14.1.0
powerpc64             randconfig-002-20241025    gcc-14.1.0
powerpc64             randconfig-003-20241025    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241025    gcc-14.1.0
riscv                 randconfig-002-20241025    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241025    gcc-14.1.0
s390                  randconfig-002-20241025    gcc-14.1.0
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.1.0
sh                    randconfig-001-20241025    gcc-14.1.0
sh                    randconfig-002-20241025    gcc-14.1.0
sh                      rts7751r2d1_defconfig    clang-20
sh                           se7343_defconfig    gcc-14.1.0
sh                           se7705_defconfig    clang-20
sh                   secureedge5410_defconfig    gcc-14.1.0
sh                  sh7785lcr_32bit_defconfig    clang-20
sh                             shx3_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241025    gcc-14.1.0
sparc64               randconfig-002-20241025    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241025    gcc-14.1.0
um                    randconfig-002-20241025    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241025    gcc-12
x86_64      buildonly-randconfig-002-20241025    gcc-12
x86_64      buildonly-randconfig-003-20241025    gcc-12
x86_64      buildonly-randconfig-004-20241025    gcc-12
x86_64      buildonly-randconfig-005-20241025    gcc-12
x86_64      buildonly-randconfig-006-20241025    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241025    gcc-12
x86_64                randconfig-002-20241025    gcc-12
x86_64                randconfig-003-20241025    gcc-12
x86_64                randconfig-004-20241025    gcc-12
x86_64                randconfig-005-20241025    gcc-12
x86_64                randconfig-006-20241025    gcc-12
x86_64                randconfig-011-20241025    gcc-12
x86_64                randconfig-012-20241025    gcc-12
x86_64                randconfig-013-20241025    gcc-12
x86_64                randconfig-014-20241025    gcc-12
x86_64                randconfig-015-20241025    gcc-12
x86_64                randconfig-016-20241025    gcc-12
x86_64                randconfig-071-20241025    gcc-12
x86_64                randconfig-072-20241025    gcc-12
x86_64                randconfig-073-20241025    gcc-12
x86_64                randconfig-074-20241025    gcc-12
x86_64                randconfig-075-20241025    gcc-12
x86_64                randconfig-076-20241025    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    clang-20
xtensa                randconfig-001-20241025    gcc-14.1.0
xtensa                randconfig-002-20241025    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

