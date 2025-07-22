Return-Path: <linux-pci+bounces-32734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB19B0DC0B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 15:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637721894777
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E182B9A5;
	Tue, 22 Jul 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blXVLuhG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BC8836
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192518; cv=none; b=sJIczOnEhRxEKrYMp4kBgYco4fJbMX9a5xrnYerHnLpv4owkNE5bLA2W5JoKGWJwpEQVcWm5lmXGBBmVDalQvVnx2oqLlrICxJ1iSD2Wj9kauerlY+XMsi6UNTpoSMLjU6WIU7s+/T4BQfc4u0FHICzHDc/jnFj/e7h71S/JVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192518; c=relaxed/simple;
	bh=rjDd2fJcwXFnLYO/v9q3AcGSp6eI0GJR7lLO6smxGsY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cDL+dardJ5D3pxWMBPMzXeBozDqP6DSe4rzBMtHmrn6hhxqTR8HEtHT+WKBUQkG9uUA5J+RsR10RmtzL2aKN+TGq5J7ZfeWXH5r35o2A3Iz0RyvXa7O9SAXlfH1IBpEpFXDrUB2GIIIuXxpAKkMnhbQpyl75EUp5jQ/ofRW9z+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blXVLuhG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753192517; x=1784728517;
  h=date:from:to:cc:subject:message-id;
  bh=rjDd2fJcwXFnLYO/v9q3AcGSp6eI0GJR7lLO6smxGsY=;
  b=blXVLuhGORBBKLBCmpjutro+2hlo0cx/J5mKHKIHhsgYQwlI56PK5YP6
   HpDCCol6RZiuGgKCvn373SLgNBFv84R2sAkPBc1gQnZpjknbmh6mnEyxR
   8oLGxK7xr3rTbjqq0nau3RVYAtQXWjdSiEyYMwlQMY2+N5Zh4SjGR6HQs
   nlK9M+jORcJoVzgLUy78PAdEBxCtfduv/+16Ozdo+9r+f+eXYevH1vnSr
   4fYIJluN5f7uhO32vM0dIAMHIepIg4JyOQs3+AXxoq5vjL7QpyNN6xCeO
   H+sEBjlu7B3enjEjc2dz/TlfC7du69L4hVAWIW/ME0tMtG9hMDj58uTXx
   g==;
X-CSE-ConnectionGUID: 3syhKKZhQB6Ca8hWuQVX5Q==
X-CSE-MsgGUID: 8A8b8Fd2QFG23vj6J73IJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="65704863"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="65704863"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:55:16 -0700
X-CSE-ConnectionGUID: myiJfRFxR1qCcU9xPOba2g==
X-CSE-MsgGUID: Tp3Pw/ZfSZeLOczYlzlJ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="159877274"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 Jul 2025 06:55:15 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueDSa-000Hwt-1g;
	Tue, 22 Jul 2025 13:55:12 +0000
Date: Tue, 22 Jul 2025 21:54:40 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint/doorbell] BUILD SUCCESS
 b964b4894fcfc72e7496cf52a33cbba39d094c5b
Message-ID: <202507222128.LHiw0vyP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint/doorbell
branch HEAD: b964b4894fcfc72e7496cf52a33cbba39d094c5b  selftests: pci_endpoint: Add doorbell test case

elapsed time: 1342m

configs tested: 229
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250722    clang-22
arc                   randconfig-001-20250722    gcc-10.5.0
arc                   randconfig-002-20250722    clang-22
arc                   randconfig-002-20250722    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250722    clang-22
arm                   randconfig-001-20250722    gcc-12.5.0
arm                   randconfig-002-20250722    clang-22
arm                   randconfig-003-20250722    clang-22
arm                   randconfig-003-20250722    gcc-8.5.0
arm                   randconfig-004-20250722    clang-17
arm                   randconfig-004-20250722    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250722    clang-22
arm64                 randconfig-002-20250722    clang-22
arm64                 randconfig-003-20250722    clang-22
arm64                 randconfig-004-20250722    clang-22
arm64                 randconfig-004-20250722    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250722    gcc-11.5.0
csky                  randconfig-001-20250722    gcc-8.5.0
csky                  randconfig-002-20250722    gcc-15.1.0
csky                  randconfig-002-20250722    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250722    clang-20
hexagon               randconfig-001-20250722    gcc-8.5.0
hexagon               randconfig-002-20250722    clang-18
hexagon               randconfig-002-20250722    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250722    gcc-12
i386        buildonly-randconfig-002-20250722    gcc-12
i386        buildonly-randconfig-003-20250722    clang-20
i386        buildonly-randconfig-003-20250722    gcc-12
i386        buildonly-randconfig-004-20250722    gcc-12
i386        buildonly-randconfig-005-20250722    clang-20
i386        buildonly-randconfig-005-20250722    gcc-12
i386        buildonly-randconfig-006-20250722    clang-20
i386        buildonly-randconfig-006-20250722    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250722    clang-20
i386                  randconfig-002-20250722    clang-20
i386                  randconfig-003-20250722    clang-20
i386                  randconfig-004-20250722    clang-20
i386                  randconfig-005-20250722    clang-20
i386                  randconfig-006-20250722    clang-20
i386                  randconfig-007-20250722    clang-20
i386                  randconfig-011-20250722    clang-20
i386                  randconfig-012-20250722    clang-20
i386                  randconfig-013-20250722    clang-20
i386                  randconfig-014-20250722    clang-20
i386                  randconfig-015-20250722    clang-20
i386                  randconfig-016-20250722    clang-20
i386                  randconfig-017-20250722    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250722    gcc-15.1.0
loongarch             randconfig-001-20250722    gcc-8.5.0
loongarch             randconfig-002-20250722    clang-22
loongarch             randconfig-002-20250722    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250722    gcc-11.5.0
nios2                 randconfig-001-20250722    gcc-8.5.0
nios2                 randconfig-002-20250722    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250722    gcc-8.5.0
parisc                randconfig-002-20250722    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc               randconfig-001-20250722    gcc-13.4.0
powerpc               randconfig-001-20250722    gcc-8.5.0
powerpc               randconfig-002-20250722    clang-22
powerpc               randconfig-002-20250722    gcc-8.5.0
powerpc               randconfig-003-20250722    gcc-14.3.0
powerpc               randconfig-003-20250722    gcc-8.5.0
powerpc                     tqm5200_defconfig    clang-22
powerpc                     tqm8560_defconfig    clang-22
powerpc64             randconfig-001-20250722    gcc-8.5.0
powerpc64             randconfig-002-20250722    clang-22
powerpc64             randconfig-002-20250722    gcc-8.5.0
powerpc64             randconfig-003-20250722    clang-22
powerpc64             randconfig-003-20250722    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250722    clang-16
riscv                 randconfig-002-20250722    clang-16
riscv                 randconfig-002-20250722    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250722    clang-16
s390                  randconfig-001-20250722    clang-22
s390                  randconfig-002-20250722    clang-16
s390                  randconfig-002-20250722    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250722    clang-16
sh                    randconfig-001-20250722    gcc-15.1.0
sh                    randconfig-002-20250722    clang-16
sh                    randconfig-002-20250722    gcc-15.1.0
sh                          urquell_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250722    clang-16
sparc                 randconfig-001-20250722    gcc-13.4.0
sparc                 randconfig-002-20250722    clang-16
sparc                 randconfig-002-20250722    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250722    clang-16
sparc64               randconfig-001-20250722    gcc-8.5.0
sparc64               randconfig-002-20250722    clang-16
sparc64               randconfig-002-20250722    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250722    clang-16
um                    randconfig-001-20250722    gcc-12
um                    randconfig-002-20250722    clang-16
um                    randconfig-002-20250722    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250722    gcc-12
x86_64      buildonly-randconfig-002-20250722    gcc-12
x86_64      buildonly-randconfig-003-20250722    gcc-12
x86_64      buildonly-randconfig-004-20250722    clang-20
x86_64      buildonly-randconfig-004-20250722    gcc-12
x86_64      buildonly-randconfig-005-20250722    gcc-12
x86_64      buildonly-randconfig-006-20250722    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250722    clang-20
x86_64                randconfig-002-20250722    clang-20
x86_64                randconfig-003-20250722    clang-20
x86_64                randconfig-004-20250722    clang-20
x86_64                randconfig-005-20250722    clang-20
x86_64                randconfig-006-20250722    clang-20
x86_64                randconfig-007-20250722    clang-20
x86_64                randconfig-008-20250722    clang-20
x86_64                randconfig-071-20250722    gcc-12
x86_64                randconfig-072-20250722    gcc-12
x86_64                randconfig-073-20250722    gcc-12
x86_64                randconfig-074-20250722    gcc-12
x86_64                randconfig-075-20250722    gcc-12
x86_64                randconfig-076-20250722    gcc-12
x86_64                randconfig-077-20250722    gcc-12
x86_64                randconfig-078-20250722    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250722    clang-16
xtensa                randconfig-001-20250722    gcc-15.1.0
xtensa                randconfig-002-20250722    clang-16
xtensa                randconfig-002-20250722    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

