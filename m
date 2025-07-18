Return-Path: <linux-pci+bounces-32525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B6B0A157
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63371188F205
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1140BF5;
	Fri, 18 Jul 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuioUIHR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DE2BD030
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836218; cv=none; b=WdUw+p/jQkBXm28m4ktFiM/fZBjM1EweGiRiMR3k6uz1r0jh73bt23roRHn8N2B4ukCFjiERyDSFQbNxN7u/n1Cm32LPnINGKNh3UTSqV8khCj5kSdzlNDc7B/WQKVnUrZ6E9AHTDpISvtYVs5guZhHK4pZhNyztDuSe1hzIA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836218; c=relaxed/simple;
	bh=PTIQ5mYIablmDBmZU9Mbf2o1+heL1zNQm/kwoUkW8oA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TtbvSMbvXChfP7JbP8mhRWvD0q2A6EQLUHFILEw4xYJ59oFcqi8y/4C146EuGLBPpkZQuOOB9ZfX3q5bSKzSzMYRbVWo07RTLLjMn4Ypt3bGcAL4Z/ofIBljrPMEQpgvQCZ6bMX5lzW5818g871TOUvJnqpdvOuIpuIzpBT78IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuioUIHR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752836216; x=1784372216;
  h=date:from:to:cc:subject:message-id;
  bh=PTIQ5mYIablmDBmZU9Mbf2o1+heL1zNQm/kwoUkW8oA=;
  b=cuioUIHRAC5jsA2uZY4hnzbrZMCqJcvfrvjzudlhxRYZDHtr0CimqWQ3
   zTxhdN8XexdUQmddvD3WvYCcN+uP2kiFezgSwYGRofxYWrEitu05eNXXC
   lhLWKI7AM8aSUYwrbCukhZI0jrdzUDkfRvXRjGsA1uJ3LuJ1mXwhE9Oi9
   qf1NPNKq12/f3xmMjXRPwJ5YQ35EVggTlQlqfIRWKV87DImRXK2Uw/hjs
   KzeRn7kUEn48AOclsxIFoPG8cuMjHdHU64rOCyit8AnIxYGkK6o+wP/Yx
   lmkbGDdGPmXUpDGirmUPgHN796nP3HOHA5vWovvS4rgA19gR0kus2l1Xv
   A==;
X-CSE-ConnectionGUID: /UAtKBKAQdqUMKvefys/IQ==
X-CSE-MsgGUID: 3INOMTHbRjiE9Sd3d7KHZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55092618"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="55092618"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 03:56:55 -0700
X-CSE-ConnectionGUID: WkQnuSfiQz2jfhIo2lLRUw==
X-CSE-MsgGUID: /o792+R7RaWQ2IP3SGsJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="162061835"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jul 2025 03:56:54 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucilo-000EZh-1J;
	Fri, 18 Jul 2025 10:56:52 +0000
Date: Fri, 18 Jul 2025 18:56:27 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xgene] BUILD SUCCESS
 8db22d697c52e3959f02b9125175dd826608e7a0
Message-ID: <202507181815.UvIThVvt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xgene
branch HEAD: 8db22d697c52e3959f02b9125175dd826608e7a0  cpu/hotplug: Remove unused cpuhp_state CPUHP_PCI_XGENE_DEAD

elapsed time: 1459m

configs tested: 234
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250717    gcc-8.5.0
arc                   randconfig-001-20250718    gcc-8.5.0
arc                   randconfig-002-20250717    gcc-15.1.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           h3600_defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    gcc-15.1.0
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
m68k                                defconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-21
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
powerpc                          allyesconfig    clang-21
powerpc                    gamecube_defconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
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
riscv                            allyesconfig    clang-16
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
sh                    randconfig-001-20250717    gcc-14.3.0
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-002-20250717    gcc-9.3.0
sh                    randconfig-002-20250718    gcc-15.1.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250717    gcc-14.3.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-002-20250717    gcc-8.5.0
sparc                 randconfig-002-20250718    gcc-15.1.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250717    gcc-12.4.0
sparc64               randconfig-001-20250718    gcc-15.1.0
sparc64               randconfig-002-20250717    clang-21
sparc64               randconfig-002-20250718    gcc-15.1.0
um                               alldefconfig    clang-21
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

