Return-Path: <linux-pci+bounces-39639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C2C1A15F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD861AA2494
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C72E6CDA;
	Wed, 29 Oct 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzXl8UYj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A22D9497
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737984; cv=none; b=PAG1pOyDESb3DA3brHoAknHjisTNt0MC6r6sUj2WzvZxIKpQw2XOvxuKMrVfhr5ZNKjA/E+2qdsd8xCo+sms6qEub98Sz+zF7AdSaHRILmtYKObKu2zdkBhcqSfWsg12QoSc0Fesm8o/H+iPHzVBodAv891SGHeQLLf/ekyCYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737984; c=relaxed/simple;
	bh=uMfhhnQjNCJskPM3OuwSGvNgoK6a4Y9KNcSv1VJMo/M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c668urzrv+E8Twr8FlHwZqHVkMgBp+3LbUEqDpQBsJ3hu2Stk1gk04wn3x/PmoKI6R62lXJNzEN8D94YVYVwirQ2GGDRBDxqUA/LKUcU9GXeL4hQIF4VUCf2A1/YL4CzGtBbicEVOFR5Mrnr8aDLJibBazF2iClNHvvxutZ1KuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzXl8UYj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761737983; x=1793273983;
  h=date:from:to:cc:subject:message-id;
  bh=uMfhhnQjNCJskPM3OuwSGvNgoK6a4Y9KNcSv1VJMo/M=;
  b=VzXl8UYjV42vsT5DsYVzmumaU9mxW2huCK2uiUy0wp3Lab4Jppdq3Ive
   3C6UnTEeIMS5E4x/aWNRGQ4QqSHQQbW/OUENykgtgkfOZzUPhhMnMAgP3
   iC45t7acmRs+M++FlXfmiLV8bY+iQMzOOSDaGwPQMpknpkTmuBh9svHq1
   EvSAK63pu1MqwSlvTEMXfkEwlqH/deivSnL23uO+SkPhy4Svdb4kGbRg1
   Upmfz2cfQz6DiRiG352KVYvSIe61Fqxj+6eDv9opP2nyGMrkbjRYxEZ38
   5xBXXfC5j3n3U9rbJ+EnG6ydgBj/N65uz4Nr72HRob2rk3bc2pLUkQNiL
   A==;
X-CSE-ConnectionGUID: Z5aRZM7RQ5W6H/SCqi33Pg==
X-CSE-MsgGUID: rZYIIZi0QiKBlHcHuN5FJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="81276189"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="81276189"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:39:42 -0700
X-CSE-ConnectionGUID: 27sOrGzdQ+qyz1KggVp6Pg==
X-CSE-MsgGUID: AlF8YruxSmioBYdSwAl+hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185269068"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 29 Oct 2025 04:39:41 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE4Wd-000KYl-0H;
	Wed, 29 Oct 2025 11:39:36 +0000
Date: Wed, 29 Oct 2025 19:39:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 b37b6095a94e1ccecac80c9f1a8fca8d72919c65
Message-ID: <202510291923.UBqAzbO4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: b37b6095a94e1ccecac80c9f1a8fca8d72919c65  PCI: vmd: Switch to pci_bus_find_emul_domain_nr()

elapsed time: 1050m

configs tested: 204
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251029    clang-22
arc                   randconfig-001-20251029    gcc-15.1.0
arc                   randconfig-002-20251029    clang-22
arc                   randconfig-002-20251029    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251029    clang-22
arm                   randconfig-001-20251029    gcc-8.5.0
arm                   randconfig-002-20251029    clang-22
arm                   randconfig-003-20251029    clang-22
arm                   randconfig-004-20251029    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251029    gcc-12.5.0
arm64                 randconfig-002-20251029    clang-22
arm64                 randconfig-003-20251029    gcc-13.4.0
arm64                 randconfig-004-20251029    gcc-11.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251029    gcc-9.5.0
csky                  randconfig-002-20251029    gcc-11.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251029    clang-20
hexagon               randconfig-001-20251029    clang-22
hexagon               randconfig-002-20251029    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251029    gcc-14
i386        buildonly-randconfig-002-20251029    gcc-14
i386        buildonly-randconfig-003-20251029    clang-20
i386        buildonly-randconfig-003-20251029    gcc-14
i386        buildonly-randconfig-004-20251029    gcc-14
i386        buildonly-randconfig-005-20251029    gcc-14
i386        buildonly-randconfig-006-20251029    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251029    clang-20
i386                  randconfig-002-20251029    clang-20
i386                  randconfig-003-20251029    clang-20
i386                  randconfig-004-20251029    clang-20
i386                  randconfig-005-20251029    clang-20
i386                  randconfig-006-20251029    clang-20
i386                  randconfig-007-20251029    clang-20
i386                  randconfig-011-20251029    gcc-14
i386                  randconfig-012-20251029    gcc-14
i386                  randconfig-013-20251029    gcc-14
i386                  randconfig-014-20251029    gcc-14
i386                  randconfig-015-20251029    gcc-14
i386                  randconfig-016-20251029    gcc-14
i386                  randconfig-017-20251029    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251029    clang-22
loongarch             randconfig-002-20251029    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251029    clang-22
nios2                 randconfig-001-20251029    gcc-11.5.0
nios2                 randconfig-002-20251029    clang-22
nios2                 randconfig-002-20251029    gcc-9.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251029    gcc-12.5.0
parisc                randconfig-001-20251029    gcc-8.5.0
parisc                randconfig-002-20251029    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251029    clang-22
powerpc               randconfig-001-20251029    gcc-8.5.0
powerpc               randconfig-002-20251029    gcc-12.5.0
powerpc               randconfig-002-20251029    gcc-8.5.0
powerpc64             randconfig-001-20251029    clang-22
powerpc64             randconfig-001-20251029    gcc-8.5.0
powerpc64             randconfig-002-20251029    clang-22
powerpc64             randconfig-002-20251029    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251029    clang-20
riscv                 randconfig-002-20251029    clang-20
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251029    clang-20
s390                  randconfig-002-20251029    clang-20
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251029    clang-20
sh                    randconfig-002-20251029    clang-20
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251029    clang-22
sparc                 randconfig-001-20251029    gcc-8.5.0
sparc                 randconfig-002-20251029    clang-22
sparc                 randconfig-002-20251029    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251029    clang-20
sparc64               randconfig-001-20251029    clang-22
sparc64               randconfig-002-20251029    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251029    clang-22
um                    randconfig-002-20251029    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251029    clang-20
x86_64      buildonly-randconfig-002-20251029    clang-20
x86_64      buildonly-randconfig-003-20251029    clang-20
x86_64      buildonly-randconfig-004-20251029    clang-20
x86_64      buildonly-randconfig-005-20251029    clang-20
x86_64      buildonly-randconfig-006-20251029    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251029    gcc-12
x86_64                randconfig-002-20251029    gcc-12
x86_64                randconfig-003-20251029    gcc-12
x86_64                randconfig-004-20251029    gcc-12
x86_64                randconfig-005-20251029    gcc-12
x86_64                randconfig-006-20251029    gcc-12
x86_64                randconfig-011-20251029    gcc-13
x86_64                randconfig-012-20251029    gcc-13
x86_64                randconfig-013-20251029    gcc-13
x86_64                randconfig-014-20251029    gcc-13
x86_64                randconfig-015-20251029    gcc-13
x86_64                randconfig-016-20251029    gcc-13
x86_64                randconfig-071-20251029    clang-20
x86_64                randconfig-072-20251029    clang-20
x86_64                randconfig-073-20251029    clang-20
x86_64                randconfig-074-20251029    clang-20
x86_64                randconfig-075-20251029    clang-20
x86_64                randconfig-076-20251029    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251029    clang-22
xtensa                randconfig-001-20251029    gcc-8.5.0
xtensa                randconfig-002-20251029    clang-22
xtensa                randconfig-002-20251029    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

