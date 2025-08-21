Return-Path: <linux-pci+bounces-34490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7278B30736
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 22:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488EF643062
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD0A393DCA;
	Thu, 21 Aug 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlOmvJcS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CF393DC2
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807741; cv=none; b=CDJarhbRZ/KPykFO4EUq5kOOrbku1ZxrK+3nxSi3UwFzfnkd0rFo0M0X7M5eN87B+oLVYBK/sFB7SuZ6ISFqeJndPLCf9AENxzgygt8LnoWYqK2CYJ2aYLi9MrEp2qL8QdK2OR27WrnQZ50f5lqzqkNvLxpCC9Q1S6s9ITLwzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807741; c=relaxed/simple;
	bh=WBW373YS2nABoPmsshloNlkG246db+so4fKU1cPSiDI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Cud4uKMx44+2SSYJqDEDvTaJ9C+0IVCnrzh7/MgWN0sTck0wfcd3uWL67fO6Sal2tcKNltILeFQVPF538cq82JwVi1jfGJ4jyPGEYusdbgCAOPYacd+L1imMJWJ+3QFfqzFV/qS9gCJYA1RGK6F8OUs8b5R7KWKSHby2rBIZuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlOmvJcS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755807739; x=1787343739;
  h=date:from:to:cc:subject:message-id;
  bh=WBW373YS2nABoPmsshloNlkG246db+so4fKU1cPSiDI=;
  b=SlOmvJcSLdgUpL1EY/3NmTTDJa0EXsQzh4KK8M27IW3TBHbZRUrxmw3W
   X84pxGE7+Vtqmc3+xiYUb0emm1v/EEUsUuPWG/xgXH97sY+NbjnHLZWtw
   1lMXJzQvlOg7fAx23P0rrh6+SL3QHuBmo19qI5BXN1YEjFVeFONH4EZOF
   1vMq1k0n/dqo6LSLnWRSXgaB97uUY1No09IlDbcaIkK4yZ3o8TwgWz0z/
   HzcTHxC2herKcR/BwO9V6/MtnUGAK8qbhi2lG3Lbl++cwOVrlCEFf0yy0
   vX3ybbciHLju+NXJyIr+VnUMupdAByzj0vUdaBS4h4rIc6k4ipBJYxOwT
   A==;
X-CSE-ConnectionGUID: Y2Suep5HTYO+VVig0Cfasg==
X-CSE-MsgGUID: mIFrA17WSn2vvx5fZzbPiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58059590"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58059590"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 13:22:18 -0700
X-CSE-ConnectionGUID: 8P7B/e9dRBq74Sc9Qat3rA==
X-CSE-MsgGUID: IL0Gu0J5ScCBnlqBu5Stfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169320601"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 21 Aug 2025 13:22:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upBna-000Kdf-0Z;
	Thu, 21 Aug 2025 20:22:14 +0000
Date: Fri, 22 Aug 2025 04:21:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2508-christian-stm32-v13] BUILD SUCCESS
 43e069c6c364aa00aae92bc444359b3121496fd8
Message-ID: <202508220432.Wm8WcOCX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2508-christian-stm32-v13
branch HEAD: 43e069c6c364aa00aae92bc444359b3121496fd8  arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board

elapsed time: 1299m

configs tested: 270
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250821    gcc-9.5.0
arc                   randconfig-001-20250822    clang-22
arc                   randconfig-002-20250821    gcc-13.4.0
arc                   randconfig-002-20250822    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250821    gcc-13.4.0
arm                   randconfig-001-20250822    clang-22
arm                   randconfig-002-20250821    clang-22
arm                   randconfig-002-20250822    clang-22
arm                   randconfig-003-20250821    clang-22
arm                   randconfig-003-20250822    clang-22
arm                   randconfig-004-20250821    clang-22
arm                   randconfig-004-20250822    clang-22
arm                           sama7_defconfig    gcc-15.1.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm                           spitz_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-001-20250822    clang-22
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-002-20250822    clang-22
arm64                 randconfig-003-20250821    gcc-11.5.0
arm64                 randconfig-003-20250822    clang-22
arm64                 randconfig-004-20250821    gcc-13.4.0
arm64                 randconfig-004-20250822    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250821    clang-22
csky                  randconfig-001-20250821    gcc-13.4.0
csky                  randconfig-001-20250822    clang-22
csky                  randconfig-002-20250821    clang-22
csky                  randconfig-002-20250821    gcc-15.1.0
csky                  randconfig-002-20250822    clang-22
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250821    clang-20
hexagon               randconfig-001-20250821    clang-22
hexagon               randconfig-001-20250822    clang-22
hexagon               randconfig-002-20250821    clang-22
hexagon               randconfig-002-20250822    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250821    gcc-12
i386        buildonly-randconfig-001-20250822    clang-20
i386        buildonly-randconfig-002-20250821    gcc-12
i386        buildonly-randconfig-002-20250822    clang-20
i386        buildonly-randconfig-003-20250821    clang-20
i386        buildonly-randconfig-003-20250821    gcc-12
i386        buildonly-randconfig-003-20250822    clang-20
i386        buildonly-randconfig-004-20250821    gcc-12
i386        buildonly-randconfig-004-20250822    clang-20
i386        buildonly-randconfig-005-20250821    gcc-12
i386        buildonly-randconfig-005-20250822    clang-20
i386        buildonly-randconfig-006-20250821    clang-20
i386        buildonly-randconfig-006-20250821    gcc-12
i386        buildonly-randconfig-006-20250822    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250821    gcc-11
i386                  randconfig-001-20250822    clang-20
i386                  randconfig-002-20250821    gcc-11
i386                  randconfig-002-20250822    clang-20
i386                  randconfig-003-20250821    gcc-11
i386                  randconfig-003-20250822    clang-20
i386                  randconfig-004-20250821    gcc-11
i386                  randconfig-004-20250822    clang-20
i386                  randconfig-005-20250821    gcc-11
i386                  randconfig-005-20250822    clang-20
i386                  randconfig-006-20250821    gcc-11
i386                  randconfig-006-20250822    clang-20
i386                  randconfig-007-20250821    gcc-11
i386                  randconfig-007-20250822    clang-20
i386                  randconfig-011-20250821    gcc-12
i386                  randconfig-012-20250821    gcc-12
i386                  randconfig-013-20250821    gcc-12
i386                  randconfig-014-20250821    gcc-12
i386                  randconfig-015-20250821    gcc-12
i386                  randconfig-016-20250821    gcc-12
i386                  randconfig-017-20250821    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250821    clang-22
loongarch             randconfig-001-20250821    gcc-14.3.0
loongarch             randconfig-001-20250822    clang-22
loongarch             randconfig-002-20250821    clang-22
loongarch             randconfig-002-20250821    gcc-15.1.0
loongarch             randconfig-002-20250822    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250821    clang-22
nios2                 randconfig-001-20250821    gcc-9.5.0
nios2                 randconfig-001-20250822    clang-22
nios2                 randconfig-002-20250821    clang-22
nios2                 randconfig-002-20250821    gcc-10.5.0
nios2                 randconfig-002-20250822    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250821    clang-22
parisc                randconfig-001-20250821    gcc-12.5.0
parisc                randconfig-001-20250822    clang-22
parisc                randconfig-002-20250821    clang-22
parisc                randconfig-002-20250821    gcc-8.5.0
parisc                randconfig-002-20250822    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-15.1.0
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250821    clang-17
powerpc               randconfig-001-20250821    clang-22
powerpc               randconfig-001-20250822    clang-22
powerpc               randconfig-002-20250821    clang-22
powerpc               randconfig-002-20250822    clang-22
powerpc               randconfig-003-20250821    clang-22
powerpc               randconfig-003-20250821    gcc-9.5.0
powerpc               randconfig-003-20250822    clang-22
powerpc64             randconfig-001-20250822    clang-22
powerpc64             randconfig-002-20250821    clang-22
powerpc64             randconfig-002-20250822    clang-22
powerpc64             randconfig-003-20250821    clang-22
powerpc64             randconfig-003-20250822    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250821    clang-17
riscv                 randconfig-001-20250821    clang-18
riscv                 randconfig-002-20250821    clang-18
riscv                 randconfig-002-20250821    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250821    clang-18
s390                  randconfig-001-20250821    gcc-14.3.0
s390                  randconfig-002-20250821    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250821    clang-18
sh                    randconfig-001-20250821    gcc-15.1.0
sh                    randconfig-002-20250821    clang-18
sh                    randconfig-002-20250821    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250821    clang-18
sparc                 randconfig-001-20250821    gcc-14.3.0
sparc                 randconfig-002-20250821    clang-18
sparc                 randconfig-002-20250821    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250821    clang-18
sparc64               randconfig-001-20250821    gcc-8.5.0
sparc64               randconfig-002-20250821    clang-18
sparc64               randconfig-002-20250821    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250821    clang-18
um                    randconfig-001-20250821    clang-19
um                    randconfig-002-20250821    clang-18
um                    randconfig-002-20250821    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250821    clang-20
x86_64      buildonly-randconfig-001-20250822    clang-20
x86_64      buildonly-randconfig-002-20250821    clang-20
x86_64      buildonly-randconfig-002-20250822    clang-20
x86_64      buildonly-randconfig-003-20250821    clang-20
x86_64      buildonly-randconfig-003-20250822    clang-20
x86_64      buildonly-randconfig-004-20250821    clang-20
x86_64      buildonly-randconfig-004-20250821    gcc-12
x86_64      buildonly-randconfig-004-20250822    clang-20
x86_64      buildonly-randconfig-005-20250821    clang-20
x86_64      buildonly-randconfig-005-20250822    clang-20
x86_64      buildonly-randconfig-006-20250821    clang-20
x86_64      buildonly-randconfig-006-20250822    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250821    clang-20
x86_64                randconfig-001-20250822    clang-20
x86_64                randconfig-002-20250821    clang-20
x86_64                randconfig-002-20250822    clang-20
x86_64                randconfig-003-20250821    clang-20
x86_64                randconfig-003-20250822    clang-20
x86_64                randconfig-004-20250821    clang-20
x86_64                randconfig-004-20250822    clang-20
x86_64                randconfig-005-20250821    clang-20
x86_64                randconfig-005-20250822    clang-20
x86_64                randconfig-006-20250821    clang-20
x86_64                randconfig-006-20250822    clang-20
x86_64                randconfig-007-20250821    clang-20
x86_64                randconfig-007-20250822    clang-20
x86_64                randconfig-008-20250821    clang-20
x86_64                randconfig-008-20250822    clang-20
x86_64                randconfig-071-20250821    clang-20
x86_64                randconfig-072-20250821    clang-20
x86_64                randconfig-073-20250821    clang-20
x86_64                randconfig-074-20250821    clang-20
x86_64                randconfig-075-20250821    clang-20
x86_64                randconfig-076-20250821    clang-20
x86_64                randconfig-077-20250821    clang-20
x86_64                randconfig-078-20250821    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250821    clang-18
xtensa                randconfig-001-20250821    gcc-11.5.0
xtensa                randconfig-002-20250821    clang-18
xtensa                randconfig-002-20250821    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

