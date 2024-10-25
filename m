Return-Path: <linux-pci+bounces-15342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D49B09EB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265C71F21568
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25370815;
	Fri, 25 Oct 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWBYDHpu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CE13212A
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873638; cv=none; b=aAOYmoZhyV64EioNKdCVRJZwd9RRqpL/noQ8IK2P2DCUkGuo+8sJ0mNt+f7sjC60e1W/boNg4sPoufB8jbAZ+MlNqLlrVWSnsxRaP5nlCJKrHA6IhCqMUoj/4UmQxsLwgCwiHVNWxCdoTPcFA6b7CRc6UlYgheaQEjEN/8vgeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873638; c=relaxed/simple;
	bh=wHGU2Mlxc08fW1SojYehfiD6WncmmQy0X7G1fLaxHnk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W3zznIkdih4jUFsM47VAWhBtw16M3br+xcBvBb7Dj9HispzfHA0IapTrBtUdxUleQejVQQlWcfhuTZkf+WFX0S7zKBSdEMxmxrBEbVro9Q2LdkcV+AYdnbyPg7nB+Ru5U63iTP2Dj3FwrgFt54zI657rLXJYih2/5CcUsl9mK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWBYDHpu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729873635; x=1761409635;
  h=date:from:to:cc:subject:message-id;
  bh=wHGU2Mlxc08fW1SojYehfiD6WncmmQy0X7G1fLaxHnk=;
  b=OWBYDHpuZp206G0Q4lYpOmIxz2qFMbN9gvxVOXxgcR8Y0CUy0cBQSNLc
   ZsB5U1B8LhVSU/StfGvvXlPMwfnphM36XAmcgjJFFVgNvIGRBDx4dSfva
   2SCQfn4qjlzG6wIhbhA70w24G9//cyWBeEj6b10OkWqDymBtFW8nKHVmm
   ifMW7riB7dN4R788jYgQMxTQwAALytU5W/D2Hh4XB3FSfrgeJgnKYdhW0
   puXSaDgk3TfVaFMBwQlwgi7QYzehkHVSEqhS++mzB7RVDdzipoJ4WSwND
   IpbR0aDf/RM62kPu2gWVXoEwYWQRFtxVbvXPMjXQHya3SbKxLtf1TZK9j
   A==;
X-CSE-ConnectionGUID: TCs032KSSnGFaqwfoqjucA==
X-CSE-MsgGUID: Ay4IF8qjS/mj96f9GXH3LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="32408152"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="32408152"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:27:15 -0700
X-CSE-ConnectionGUID: 1u38ymidQtSexyVQrw7Qrg==
X-CSE-MsgGUID: K3/rgwGMSI6aSYdXlbk+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="111767768"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2024 09:27:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4N9b-000YVD-31;
	Fri, 25 Oct 2024 16:27:11 +0000
Date: Sat, 26 Oct 2024 00:26:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 759a3ceba34a59e36d2396f5e16fc260fffa22ca
Message-ID: <202410260020.Zx28G3UX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 759a3ceba34a59e36d2396f5e16fc260fffa22ca  Merge branch 'pci/misc'

elapsed time: 1235m

configs tested: 193
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
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241025    gcc-14.1.0
parisc                randconfig-002-20241025    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    clang-20
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
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

