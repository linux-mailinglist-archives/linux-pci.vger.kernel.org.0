Return-Path: <linux-pci+bounces-30298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FBAE2A35
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D52164A2D
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DDAD51;
	Sat, 21 Jun 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdazucJ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77DDDC1
	for <linux-pci@vger.kernel.org>; Sat, 21 Jun 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750522460; cv=none; b=Cm9sXvd0qGmkp2OIJb+kmE+HsH9i8cMwcDJb+961vlFobNR67b8t87xhAhYBQ+3aPjbFpfMi4+NAgu7KXhIwCjJnHMbT7M6PpoE0I61WKDIJ1jfr7OnFdYrYzjbkGemZhSpah9AIZCvRmBvc5QuCNnPOIrgy7JkQZkgO3WVCAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750522460; c=relaxed/simple;
	bh=r3QAeQooW/ZCHie96PSbGusbqE0lgtkudkVDeZXfxF0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zs6lzwPX+v127UaSYbF7ook7K/lg9UoK7UDRlYUsw+zbFqfMc77lf42iD/Hqk/oQq6TruCJ4NpP7GgAE997P5nnnsCiLcH5lUIFm/Z/F4aRWIy3bqsZpquhFFpFasjkswiJNssb6N02DBUyeZuq/bwWuM02JowOs63ARKvvG4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdazucJ0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750522459; x=1782058459;
  h=date:from:to:cc:subject:message-id;
  bh=r3QAeQooW/ZCHie96PSbGusbqE0lgtkudkVDeZXfxF0=;
  b=cdazucJ09fjVMXvwBF+D30h9YY95iuhoBGqUQ3FHEkzx8LASDJYmSaOO
   aKQ+AMir1MOoOcD3aYZyv/afxMLAzAC4eV3D4hqdrx6SCpuKkbr8oRA9D
   zjNwIwz07hEt+2ZNxC2qcHuNwJYr6knjNKh2mbprC/h0O55iALi45RStx
   ihmdfjtKGc/wwmGrKWYbpx2zGtjnNkiZsOj9l88UXyy0vZT/5wJDyLh/z
   Gu+sOJPlwsBxFBnG7BIg6igaTyF8qrUaZcHTH2vs8Oi7o5iLxWIunprLM
   k7MBV8o0E3YR0T696jpj/jozysxdZ0dzIz387/mKhEjMdzDV0JPKOqauv
   A==;
X-CSE-ConnectionGUID: 0ctoUIfrQrGrfWsRd8cE2A==
X-CSE-MsgGUID: 0ZSq1jFkTXOWcB+MA5m19A==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="52478227"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="52478227"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 09:14:15 -0700
X-CSE-ConnectionGUID: gqSMekKXTSavHG5U5YC1UQ==
X-CSE-MsgGUID: NDTx8Ty7SUKt4Z1psAFtug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155563377"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Jun 2025 09:14:14 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uT0r5-000Miw-31;
	Sat, 21 Jun 2025 16:14:11 +0000
Date: Sun, 22 Jun 2025 00:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 c10ba24fb5c9d6e2eb595bf7a0a00fda8f265a0b
Message-ID: <202506220007.MTE2tsnf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: c10ba24fb5c9d6e2eb595bf7a0a00fda8f265a0b  Merge branch 'pci/misc'

elapsed time: 1395m

configs tested: 247
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250621    gcc-15.1.0
arc                   randconfig-001-20250621    gcc-8.5.0
arc                   randconfig-002-20250621    gcc-10.5.0
arc                   randconfig-002-20250621    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            dove_defconfig    gcc-15.1.0
arm                   randconfig-001-20250621    clang-21
arm                   randconfig-001-20250621    gcc-15.1.0
arm                   randconfig-002-20250621    gcc-15.1.0
arm                   randconfig-003-20250621    clang-20
arm                   randconfig-003-20250621    gcc-15.1.0
arm                   randconfig-004-20250621    gcc-15.1.0
arm                   randconfig-004-20250621    gcc-8.5.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250621    clang-21
arm64                 randconfig-001-20250621    gcc-15.1.0
arm64                 randconfig-002-20250621    gcc-15.1.0
arm64                 randconfig-003-20250621    clang-17
arm64                 randconfig-003-20250621    gcc-15.1.0
arm64                 randconfig-004-20250621    gcc-10.5.0
arm64                 randconfig-004-20250621    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250621    clang-21
csky                  randconfig-001-20250621    gcc-15.1.0
csky                  randconfig-002-20250621    clang-21
csky                  randconfig-002-20250621    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250621    clang-21
hexagon               randconfig-002-20250621    clang-16
hexagon               randconfig-002-20250621    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250621    clang-20
i386        buildonly-randconfig-001-20250621    gcc-12
i386        buildonly-randconfig-002-20250621    gcc-12
i386        buildonly-randconfig-003-20250621    clang-20
i386        buildonly-randconfig-003-20250621    gcc-12
i386        buildonly-randconfig-004-20250621    clang-20
i386        buildonly-randconfig-004-20250621    gcc-12
i386        buildonly-randconfig-005-20250621    clang-20
i386        buildonly-randconfig-005-20250621    gcc-12
i386        buildonly-randconfig-006-20250621    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250621    clang-20
i386                  randconfig-002-20250621    clang-20
i386                  randconfig-003-20250621    clang-20
i386                  randconfig-004-20250621    clang-20
i386                  randconfig-005-20250621    clang-20
i386                  randconfig-006-20250621    clang-20
i386                  randconfig-007-20250621    clang-20
i386                  randconfig-011-20250621    gcc-12
i386                  randconfig-012-20250621    gcc-12
i386                  randconfig-013-20250621    gcc-12
i386                  randconfig-014-20250621    gcc-12
i386                  randconfig-015-20250621    gcc-12
i386                  randconfig-016-20250621    gcc-12
i386                  randconfig-017-20250621    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250621    clang-21
loongarch             randconfig-001-20250621    gcc-12.4.0
loongarch             randconfig-002-20250621    clang-21
loongarch             randconfig-002-20250621    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-21
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250621    clang-21
nios2                 randconfig-001-20250621    gcc-9.3.0
nios2                 randconfig-002-20250621    clang-21
nios2                 randconfig-002-20250621    gcc-12.4.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250621    clang-21
parisc                randconfig-001-20250621    gcc-10.5.0
parisc                randconfig-002-20250621    clang-21
parisc                randconfig-002-20250621    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-19
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250621    clang-17
powerpc               randconfig-001-20250621    clang-21
powerpc               randconfig-002-20250621    clang-19
powerpc               randconfig-002-20250621    clang-21
powerpc               randconfig-003-20250621    clang-21
powerpc               randconfig-003-20250621    gcc-8.5.0
powerpc                     redwood_defconfig    clang-21
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250621    clang-21
powerpc64             randconfig-001-20250621    gcc-11.5.0
powerpc64             randconfig-002-20250621    clang-21
powerpc64             randconfig-002-20250621    gcc-13.3.0
powerpc64             randconfig-003-20250621    clang-21
powerpc64             randconfig-003-20250621    gcc-11.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250621    clang-21
riscv                 randconfig-001-20250621    gcc-8.5.0
riscv                 randconfig-002-20250621    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250621    clang-21
s390                  randconfig-001-20250621    gcc-8.5.0
s390                  randconfig-002-20250621    clang-21
s390                  randconfig-002-20250621    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250621    gcc-15.1.0
sh                    randconfig-001-20250621    gcc-8.5.0
sh                    randconfig-002-20250621    gcc-15.1.0
sh                    randconfig-002-20250621    gcc-8.5.0
sh                              ul2_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250621    gcc-15.1.0
sparc                 randconfig-001-20250621    gcc-8.5.0
sparc                 randconfig-002-20250621    gcc-15.1.0
sparc                 randconfig-002-20250621    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250621    gcc-8.5.0
sparc64               randconfig-002-20250621    gcc-13.3.0
sparc64               randconfig-002-20250621    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250621    clang-21
um                    randconfig-001-20250621    gcc-8.5.0
um                    randconfig-002-20250621    gcc-12
um                    randconfig-002-20250621    gcc-8.5.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250621    gcc-12
x86_64      buildonly-randconfig-002-20250621    clang-20
x86_64      buildonly-randconfig-002-20250621    gcc-12
x86_64      buildonly-randconfig-003-20250621    gcc-12
x86_64      buildonly-randconfig-004-20250621    gcc-12
x86_64      buildonly-randconfig-005-20250621    gcc-12
x86_64      buildonly-randconfig-006-20250621    clang-20
x86_64      buildonly-randconfig-006-20250621    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250621    gcc-12
x86_64                randconfig-002-20250621    gcc-12
x86_64                randconfig-003-20250621    gcc-12
x86_64                randconfig-004-20250621    gcc-12
x86_64                randconfig-005-20250621    gcc-12
x86_64                randconfig-006-20250621    gcc-12
x86_64                randconfig-007-20250621    gcc-12
x86_64                randconfig-008-20250621    gcc-12
x86_64                randconfig-071-20250621    gcc-12
x86_64                randconfig-072-20250621    gcc-12
x86_64                randconfig-073-20250621    gcc-12
x86_64                randconfig-074-20250621    gcc-12
x86_64                randconfig-075-20250621    gcc-12
x86_64                randconfig-076-20250621    gcc-12
x86_64                randconfig-077-20250621    gcc-12
x86_64                randconfig-078-20250621    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250621    gcc-12.4.0
xtensa                randconfig-001-20250621    gcc-8.5.0
xtensa                randconfig-002-20250621    gcc-15.1.0
xtensa                randconfig-002-20250621    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

