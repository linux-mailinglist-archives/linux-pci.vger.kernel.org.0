Return-Path: <linux-pci+bounces-44945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F9FD24E11
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C77930066FE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA11E86E;
	Thu, 15 Jan 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GArrmd8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1C3D76
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486154; cv=none; b=rpUzaI0+ZmuRsH3A3WmdkM4D9HaV3m96mKSAS6yXyPGM2NUTFxweRXo9U9E5AY3vKPee8MCfeHByf+8Of2C07/BMx2GaAZ0tcPWBfy3HXRmNdGy4S/2aK3S3SDoeKc7xoKDhvZiwg3BwVH7HncgN1+/jD3bxCV8Gxb+XsW8tA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486154; c=relaxed/simple;
	bh=FNGyDrZBVbtByZxsFOpx091I2JledUQK7rzeIQO/+gc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uE/ET6E8nbYtg/qnnu+Q+zVTFM8akO8cG6ttvUUmuuf/IYbh0u2gqlzWquTK3uvYOnMxdBf5LSTw9umDuMu6nY8zxOGWmc6t9yl/ragSGywZd0ltQ9uG7IoJlYm51YCojlkvlewtHuapMJ7197UWwlXjXKZhXw5waQj0NdRiLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GArrmd8U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768486152; x=1800022152;
  h=date:from:to:cc:subject:message-id;
  bh=FNGyDrZBVbtByZxsFOpx091I2JledUQK7rzeIQO/+gc=;
  b=GArrmd8UhSiyvhtJk2qoPsxd+iBgXnztKq1vn1ddvU31qo3bymf7ICjS
   iCPLriryOPgkQhj9VKqFimpIUoAiosG6ynxkzT7+a9svBBVkwmU789Ecq
   hoLyT8T4/U4u20zITQSbTJ2zxr6VuCa9do6m7kfGa3Uku6HeKsJxiY0Wf
   f+8ZjoBPVJQNMiPBTSXikH0qd03xBDbFIfj4St9xOQxRD8Rp87zPgGZcL
   VimRM1PSBS5TttK/izJL/a/CRluaoy+lG+LM/CSnJH9Jqb9ND6ZK5tSQR
   fHDwCH7G7w+7Ekm3GACVWn236LiaZu3QrmdYiHI9tuEd/FFGzdBsd2nX7
   A==;
X-CSE-ConnectionGUID: TRvJKqL9SuW/O5t29kk25Q==
X-CSE-MsgGUID: CPjLVtOCSHGlwfO8xVpJew==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69883785"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69883785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 06:09:09 -0800
X-CSE-ConnectionGUID: vBf+qkELSBa4Qaya1/WwsA==
X-CSE-MsgGUID: dVtb2NrGRPO4Xdvh7vp3kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204745822"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Jan 2026 06:09:08 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgO25-00000000I2s-17qY;
	Thu, 15 Jan 2026 14:09:05 +0000
Date: Thu, 15 Jan 2026 22:08:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 c265090b385adc0dfdecfa276d8c2d13e462b47f
Message-ID: <202601152243.5fY5AVbV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: c265090b385adc0dfdecfa276d8c2d13e462b47f  Merge branch 'pci/misc'

elapsed time: 1261m

configs tested: 231
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-22
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260115    clang-22
arc                   randconfig-001-20260115    gcc-13.4.0
arc                   randconfig-002-20260115    clang-22
arc                   randconfig-002-20260115    gcc-13.4.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                        keystone_defconfig    clang-22
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20260115    clang-22
arm                   randconfig-001-20260115    gcc-8.5.0
arm                   randconfig-002-20260115    clang-22
arm                   randconfig-003-20260115    clang-17
arm                   randconfig-003-20260115    clang-22
arm                   randconfig-004-20260115    clang-22
arm                        shmobile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260115    clang-22
arm64                 randconfig-002-20260115    clang-22
arm64                 randconfig-003-20260115    clang-22
arm64                 randconfig-004-20260115    clang-22
arm64                 randconfig-004-20260115    gcc-9.5.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260115    clang-22
csky                  randconfig-001-20260115    gcc-15.2.0
csky                  randconfig-002-20260115    clang-22
csky                  randconfig-002-20260115    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260115    clang-22
hexagon               randconfig-002-20260115    clang-16
hexagon               randconfig-002-20260115    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260115    gcc-14
i386        buildonly-randconfig-002-20260115    gcc-14
i386        buildonly-randconfig-003-20260115    gcc-14
i386        buildonly-randconfig-004-20260115    clang-20
i386        buildonly-randconfig-004-20260115    gcc-14
i386        buildonly-randconfig-005-20260115    clang-20
i386        buildonly-randconfig-005-20260115    gcc-14
i386        buildonly-randconfig-006-20260115    clang-20
i386        buildonly-randconfig-006-20260115    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260115    clang-20
i386                  randconfig-002-20260115    clang-20
i386                  randconfig-003-20260115    clang-20
i386                  randconfig-004-20260115    clang-20
i386                  randconfig-005-20260115    clang-20
i386                  randconfig-006-20260115    clang-20
i386                  randconfig-006-20260115    gcc-14
i386                  randconfig-007-20260115    clang-20
i386                  randconfig-007-20260115    gcc-14
i386                  randconfig-011-20260115    clang-20
i386                  randconfig-011-20260115    gcc-14
i386                  randconfig-012-20260115    gcc-14
i386                  randconfig-013-20260115    gcc-14
i386                  randconfig-014-20260115    gcc-14
i386                  randconfig-015-20260115    clang-20
i386                  randconfig-015-20260115    gcc-14
i386                  randconfig-016-20260115    clang-20
i386                  randconfig-016-20260115    gcc-14
i386                  randconfig-017-20260115    clang-20
i386                  randconfig-017-20260115    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260115    clang-22
loongarch             randconfig-002-20260115    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                       m5208evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       rbtx49xx_defconfig    clang-22
mips                          rm200_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260115    clang-22
nios2                 randconfig-001-20260115    gcc-10.5.0
nios2                 randconfig-002-20260115    clang-22
nios2                 randconfig-002-20260115    gcc-11.5.0
openrisc                         alldefconfig    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    clang-22
parisc                randconfig-001-20260115    clang-22
parisc                randconfig-001-20260115    gcc-8.5.0
parisc                randconfig-002-20260115    clang-22
parisc                randconfig-002-20260115    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                   bluestone_defconfig    clang-22
powerpc                    gamecube_defconfig    clang-22
powerpc                     mpc512x_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20260115    clang-22
powerpc               randconfig-001-20260115    gcc-8.5.0
powerpc               randconfig-002-20260115    clang-22
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20260115    clang-22
powerpc64             randconfig-002-20260115    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260115    clang-18
riscv                 randconfig-001-20260115    gcc-10.5.0
riscv                 randconfig-002-20260115    gcc-10.5.0
riscv                 randconfig-002-20260115    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260115    gcc-10.5.0
s390                  randconfig-002-20260115    clang-22
s390                  randconfig-002-20260115    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          r7785rp_defconfig    clang-22
sh                    randconfig-001-20260115    gcc-10.5.0
sh                    randconfig-002-20260115    gcc-10.5.0
sh                    randconfig-002-20260115    gcc-14.3.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                           se7619_defconfig    gcc-15.2.0
sh                              ul2_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260115    clang-22
sparc                 randconfig-001-20260115    gcc-15.2.0
sparc                 randconfig-002-20260115    clang-22
sparc                 randconfig-002-20260115    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260115    clang-22
sparc64               randconfig-002-20260115    clang-22
sparc64               randconfig-002-20260115    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260115    clang-22
um                    randconfig-002-20260115    clang-22
um                    randconfig-002-20260115    gcc-14
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260115    clang-20
x86_64      buildonly-randconfig-002-20260115    clang-20
x86_64      buildonly-randconfig-003-20260115    clang-20
x86_64      buildonly-randconfig-004-20260115    clang-20
x86_64      buildonly-randconfig-005-20260115    clang-20
x86_64      buildonly-randconfig-006-20260115    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260115    clang-20
x86_64                randconfig-002-20260115    clang-20
x86_64                randconfig-002-20260115    gcc-14
x86_64                randconfig-003-20260115    clang-20
x86_64                randconfig-004-20260115    clang-20
x86_64                randconfig-005-20260115    clang-20
x86_64                randconfig-005-20260115    gcc-14
x86_64                randconfig-006-20260115    clang-20
x86_64                randconfig-006-20260115    gcc-12
x86_64                randconfig-011-20260115    clang-20
x86_64                randconfig-012-20260115    clang-20
x86_64                randconfig-013-20260115    clang-20
x86_64                randconfig-014-20260115    clang-20
x86_64                randconfig-015-20260115    clang-20
x86_64                randconfig-016-20260115    clang-20
x86_64                randconfig-071-20260115    gcc-14
x86_64                randconfig-072-20260115    clang-20
x86_64                randconfig-072-20260115    gcc-14
x86_64                randconfig-073-20260115    gcc-14
x86_64                randconfig-074-20260115    gcc-14
x86_64                randconfig-075-20260115    clang-20
x86_64                randconfig-075-20260115    gcc-14
x86_64                randconfig-076-20260115    clang-20
x86_64                randconfig-076-20260115    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260115    clang-22
xtensa                randconfig-001-20260115    gcc-8.5.0
xtensa                randconfig-002-20260115    clang-22
xtensa                randconfig-002-20260115    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

