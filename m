Return-Path: <linux-pci+bounces-16059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537809BD1E7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC62CB2489D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B216EB4C;
	Tue,  5 Nov 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7ghMMfD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA3165F1E
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823159; cv=none; b=LqxLUBQCzF6XMVfntljw8CytnrsxQ1e+FlrGnPEdz7cMpw9+OoShMrVKu7jK5hXEqkgYStU9arIyFp+oqTSXNff2FkQ+8bgJHfD/wXSJM0Bkf/Uav656x724IfG6WemTMZMQutdA2bwgsXxkl6L0v69mZjrDTJW/+vg24eq78Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823159; c=relaxed/simple;
	bh=bM9Gael+bE1jomCKxZwhK/7aHQ4ptmcz3YXPJoduAPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MW2/e8ey57UWI2oqdlNApI5Qj8kuheEYnyikGEsuR+hTmqwVwez9MUmq213a738zaXduO8YGDigvXTV2eaqnkZ4NtjVh7btN33NLG3srPsPD25O3ZwXLXjIBUtKmFIFL8zHWo8oNM0exkkQeQa1VzJGFYHnrGBthOlEZ5CtBRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7ghMMfD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730823158; x=1762359158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bM9Gael+bE1jomCKxZwhK/7aHQ4ptmcz3YXPJoduAPg=;
  b=B7ghMMfD5Hio0Cbdqd3175dBs0wekfyX+p51Tr+6TMSv33S7Ty7jzzkt
   ed9hxST3bFyi3UK7grwPHzzfYw+VmBDIpVYx6sxyHBVndtnZfik4cdSWK
   uJK94wQpRnK7lgRxvTKvEZ4IU7Kaa1Hkr0NvgHRnuItG+3j6LwZwrLStB
   vqCnpTm37KcT6GVBV/xrBjm6CNKVdMK3V1/SRnXSh4s6D+OgID95wgSJ7
   38eXbgwUvYUoXiHDPhoLnWmQEepG0Sk1Chl+YnlXQ4yqlUCZxrPUqlg09
   9lo6QRqCYJTUQU3CRrtYaJ5Ev66SukTT944+H3WOPVu9Vib8BAYiJplUj
   w==;
X-CSE-ConnectionGUID: CE2AXWioSyWgLZ84k6OXLg==
X-CSE-MsgGUID: N8wcl3FDTiKyDi6OvnaJ/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30690272"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30690272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 08:12:37 -0800
X-CSE-ConnectionGUID: BFnijPrIRkqDynseEnm5Uw==
X-CSE-MsgGUID: MgCqLIQcTV+/nmyPmmsC6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84889782"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2024 08:12:36 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8MAT-000mDN-1C;
	Tue, 05 Nov 2024 16:12:33 +0000
Date: Wed, 06 Nov 2024 00:12:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 fba6045161d686adc102b6ef71b2fd1e5f90a616
Message-ID: <202411060017.I7ZY01KN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: fba6045161d686adc102b6ef71b2fd1e5f90a616  PCI: qcom: Disable ASPM L0s for X1E80100

elapsed time: 1461m

configs tested: 253
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20241105    gcc-14.1.0
arc                   randconfig-002-20241105    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g5_defconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                        clps711x_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                           imxrt_defconfig    clang-20
arm                           imxrt_defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                        keystone_defconfig    gcc-14.1.0
arm                            mps2_defconfig    clang-20
arm                            qcom_defconfig    gcc-14.1.0
arm                   randconfig-001-20241105    gcc-14.1.0
arm                   randconfig-002-20241105    gcc-14.1.0
arm                   randconfig-003-20241105    gcc-14.1.0
arm                   randconfig-004-20241105    gcc-14.1.0
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241105    gcc-14.1.0
arm64                 randconfig-002-20241105    gcc-14.1.0
arm64                 randconfig-003-20241105    gcc-14.1.0
arm64                 randconfig-004-20241105    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241105    gcc-14.1.0
csky                  randconfig-002-20241105    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241105    gcc-14.1.0
hexagon               randconfig-002-20241105    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241105    clang-19
i386        buildonly-randconfig-002-20241105    clang-19
i386        buildonly-randconfig-002-20241105    gcc-12
i386        buildonly-randconfig-003-20241105    clang-19
i386        buildonly-randconfig-004-20241105    clang-19
i386        buildonly-randconfig-004-20241105    gcc-12
i386        buildonly-randconfig-005-20241105    clang-19
i386        buildonly-randconfig-006-20241105    clang-19
i386        buildonly-randconfig-006-20241105    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241105    clang-19
i386                  randconfig-001-20241105    gcc-12
i386                  randconfig-002-20241105    clang-19
i386                  randconfig-003-20241105    clang-19
i386                  randconfig-003-20241105    gcc-12
i386                  randconfig-004-20241105    clang-19
i386                  randconfig-005-20241105    clang-19
i386                  randconfig-006-20241105    clang-19
i386                  randconfig-006-20241105    gcc-12
i386                  randconfig-011-20241105    clang-19
i386                  randconfig-012-20241105    clang-19
i386                  randconfig-013-20241105    clang-19
i386                  randconfig-013-20241105    gcc-12
i386                  randconfig-014-20241105    clang-19
i386                  randconfig-014-20241105    gcc-12
i386                  randconfig-015-20241105    clang-19
i386                  randconfig-015-20241105    gcc-12
i386                  randconfig-016-20241105    clang-19
i386                  randconfig-016-20241105    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241105    gcc-14.1.0
loongarch             randconfig-002-20241105    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    clang-20
m68k                          multi_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    gcc-14.1.0
mips                         bigsur_defconfig    gcc-14.1.0
mips                       bmips_be_defconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    clang-20
mips                           ip27_defconfig    gcc-14.1.0
mips                           jazz_defconfig    clang-20
mips                     loongson1b_defconfig    gcc-14.1.0
mips                       rbtx49xx_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241105    gcc-14.1.0
nios2                 randconfig-002-20241105    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241105    gcc-14.1.0
parisc                randconfig-002-20241105    gcc-14.1.0
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    clang-20
powerpc                        cell_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                     ksi8560_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc834x_itx_defconfig    gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-14.1.0
powerpc                     mpc83xx_defconfig    gcc-14.1.0
powerpc                     ppa8548_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241105    gcc-14.1.0
powerpc               randconfig-002-20241105    gcc-14.1.0
powerpc               randconfig-003-20241105    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
powerpc                     taishan_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241105    gcc-14.1.0
powerpc64             randconfig-002-20241105    gcc-14.1.0
powerpc64             randconfig-003-20241105    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241105    gcc-14.1.0
riscv                 randconfig-002-20241105    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241105    gcc-14.1.0
s390                  randconfig-002-20241105    gcc-14.1.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         ap325rxa_defconfig    gcc-14.1.0
sh                         apsh4a3a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                             espt_defconfig    gcc-14.1.0
sh                          landisk_defconfig    gcc-14.1.0
sh                          lboxre2_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-14.1.0
sh                          r7780mp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241105    gcc-14.1.0
sh                    randconfig-002-20241105    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                          sdk7786_defconfig    gcc-14.1.0
sh                           se7206_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7722_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.1.0
sh                           se7724_defconfig    gcc-14.1.0
sh                           se7750_defconfig    gcc-14.1.0
sh                   secureedge5410_defconfig    gcc-14.1.0
sh                           sh2007_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    clang-20
sh                              ul2_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241105    gcc-14.1.0
sparc64               randconfig-002-20241105    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241105    gcc-14.1.0
um                    randconfig-002-20241105    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241105    gcc-12
x86_64      buildonly-randconfig-002-20241105    gcc-12
x86_64      buildonly-randconfig-003-20241105    gcc-12
x86_64      buildonly-randconfig-004-20241105    gcc-12
x86_64      buildonly-randconfig-005-20241105    gcc-12
x86_64      buildonly-randconfig-006-20241105    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241105    gcc-12
x86_64                randconfig-002-20241105    gcc-12
x86_64                randconfig-003-20241105    gcc-12
x86_64                randconfig-004-20241105    gcc-12
x86_64                randconfig-005-20241105    gcc-12
x86_64                randconfig-006-20241105    gcc-12
x86_64                randconfig-011-20241105    gcc-12
x86_64                randconfig-012-20241105    gcc-12
x86_64                randconfig-013-20241105    gcc-12
x86_64                randconfig-014-20241105    gcc-12
x86_64                randconfig-015-20241105    gcc-12
x86_64                randconfig-016-20241105    gcc-12
x86_64                randconfig-071-20241105    gcc-12
x86_64                randconfig-072-20241105    gcc-12
x86_64                randconfig-073-20241105    gcc-12
x86_64                randconfig-074-20241105    gcc-12
x86_64                randconfig-075-20241105    gcc-12
x86_64                randconfig-076-20241105    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241105    gcc-14.1.0
xtensa                randconfig-002-20241105    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

