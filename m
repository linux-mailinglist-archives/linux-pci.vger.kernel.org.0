Return-Path: <linux-pci+bounces-35210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C2B3D6A5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 04:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F6E7A2549
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365D19D88F;
	Mon,  1 Sep 2025 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjFqsFwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EA170826
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693431; cv=none; b=P12AJmOnmpYu0mgQWFR+Jt7BnCCiS1IsCZWPQvWvxMnSKTIibrT7Eckljq5HbWBei2BKZTohx8Gku8GoYjE7t1xM3uCKUH72H2Y7wCcxY0vkE+tqOpDLF0SX1WhAdFTI2ROLwbGEWf/ORofTEj9scaLRAR+9JnNXVejfvdr7LgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693431; c=relaxed/simple;
	bh=KR1Vq2G1YQ3hn0TbirRZcszuGxO8B28aGJbnFA8jYOg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BXbvbTnxZubJxGsdKwpIkEjOLByEvXtvrxGY295OK/KSS804PQ2/ofV4pEUViticHRSnjv+C6vFWVB5m0GJv1nfzXn3vlB2+KqmI0H7ADdlOYTgAhZ5YxdoiP//W2/kCMK3QFuYLPlOBs1Y3s0TfcKcp1pSBqpO7O7yP7g9AnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjFqsFwR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756693430; x=1788229430;
  h=date:from:to:cc:subject:message-id;
  bh=KR1Vq2G1YQ3hn0TbirRZcszuGxO8B28aGJbnFA8jYOg=;
  b=NjFqsFwRQlEsS0VDgxpGy24iiEJ+CE0GuBzwb9SYWcGxDLRKtsgIBZ7l
   tyV1YeM4k0p45EBG0RhHv96TEuK7/SXWkK9qfEeyf16Ps9OKCqr3pq5IU
   8f0O2dGUHK6U0mTf26TVzHEEakFyYVB6zCUMPvZrW58ED0kllvHpBFpOA
   /HvN+2fY3UN59KjPvgtrAjjx4dc7C1XanTQ8H25+Q1RqXtgN+f5Mm4kZ9
   atJ5l0SWgUBc03z8tv1IaU0D4Fa9tn3N2hYgKkXUMrUyMd1Cwo9ByWzud
   l015OJiIDvQsoTJilfVlz1rf4wohsAotarnjDlPf0KbklUlMFzuGmSkrO
   g==;
X-CSE-ConnectionGUID: iQCtEpyhRvaBSzOBmQ5+tA==
X-CSE-MsgGUID: tGEsyW0dR5ec2YjgKPqeiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58952142"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58952142"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 19:23:49 -0700
X-CSE-ConnectionGUID: fuxbUZLSSzuIB3CuDx9oMA==
X-CSE-MsgGUID: E3UaYaCjSQmsZ5L/sbVXOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="208001320"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 31 Aug 2025 19:23:48 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usuCU-00007d-1L;
	Mon, 01 Sep 2025 02:23:44 +0000
Date: Mon, 01 Sep 2025 10:15:48 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra] BUILD SUCCESS
 b69f898bf94b374a97d367459ff2fb52b4ab8829
Message-ID: <202509011032.5DsBoJv1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra
branch HEAD: b69f898bf94b374a97d367459ff2fb52b4ab8829  PCI: tegra: Fix devm_kcalloc argument order for port->phys allocation

elapsed time: 819m

configs tested: 194
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250831    gcc-8.5.0
arc                   randconfig-002-20250831    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                      footbridge_defconfig    gcc-15.1.0
arm                           imxrt_defconfig    gcc-15.1.0
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250831    clang-22
arm                   randconfig-002-20250831    gcc-8.5.0
arm                   randconfig-003-20250831    clang-22
arm                   randconfig-004-20250831    gcc-14.3.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250831    gcc-13.4.0
arm64                 randconfig-002-20250831    gcc-9.5.0
arm64                 randconfig-003-20250831    gcc-8.5.0
arm64                 randconfig-004-20250831    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250831    gcc-11.5.0
csky                  randconfig-002-20250831    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250831    clang-22
hexagon               randconfig-002-20250831    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250831    gcc-12
i386        buildonly-randconfig-002-20250831    clang-20
i386        buildonly-randconfig-003-20250831    gcc-12
i386        buildonly-randconfig-004-20250831    gcc-12
i386        buildonly-randconfig-005-20250831    gcc-12
i386        buildonly-randconfig-006-20250831    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20250901    gcc-12
i386                  randconfig-012-20250901    gcc-12
i386                  randconfig-013-20250901    gcc-12
i386                  randconfig-014-20250901    gcc-12
i386                  randconfig-015-20250901    gcc-12
i386                  randconfig-016-20250901    gcc-12
i386                  randconfig-017-20250901    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250831    gcc-15.1.0
loongarch             randconfig-002-20250831    clang-22
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       rbtx49xx_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250831    gcc-11.5.0
nios2                 randconfig-002-20250831    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250831    gcc-15.1.0
parisc                randconfig-002-20250831    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    clang-22
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20250831    gcc-14.3.0
powerpc               randconfig-002-20250831    gcc-12.5.0
powerpc               randconfig-003-20250831    gcc-14.3.0
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250831    gcc-8.5.0
powerpc64             randconfig-003-20250831    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250901    clang-22
riscv                 randconfig-001-20250901    gcc-15.1.0
riscv                 randconfig-002-20250901    clang-20
riscv                 randconfig-002-20250901    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250901    gcc-13.4.0
s390                  randconfig-001-20250901    gcc-15.1.0
s390                  randconfig-002-20250901    gcc-13.4.0
s390                  randconfig-002-20250901    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250901    gcc-15.1.0
sh                    randconfig-002-20250901    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250901    gcc-15.1.0
sparc                 randconfig-001-20250901    gcc-8.5.0
sparc                 randconfig-002-20250901    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250901    clang-20
sparc64               randconfig-001-20250901    gcc-15.1.0
sparc64               randconfig-002-20250901    gcc-13.4.0
sparc64               randconfig-002-20250901    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250901    gcc-12
um                    randconfig-001-20250901    gcc-15.1.0
um                    randconfig-002-20250901    gcc-12
um                    randconfig-002-20250901    gcc-15.1.0
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250831    gcc-12
x86_64      buildonly-randconfig-002-20250831    clang-20
x86_64      buildonly-randconfig-003-20250831    gcc-12
x86_64      buildonly-randconfig-004-20250831    gcc-12
x86_64      buildonly-randconfig-005-20250831    gcc-12
x86_64      buildonly-randconfig-006-20250831    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250901    clang-20
x86_64                randconfig-002-20250901    clang-20
x86_64                randconfig-003-20250901    clang-20
x86_64                randconfig-004-20250901    clang-20
x86_64                randconfig-005-20250901    clang-20
x86_64                randconfig-006-20250901    clang-20
x86_64                randconfig-007-20250901    clang-20
x86_64                randconfig-008-20250901    clang-20
x86_64                randconfig-071-20250901    clang-20
x86_64                randconfig-072-20250901    clang-20
x86_64                randconfig-073-20250901    clang-20
x86_64                randconfig-074-20250901    clang-20
x86_64                randconfig-075-20250901    clang-20
x86_64                randconfig-076-20250901    clang-20
x86_64                randconfig-077-20250901    clang-20
x86_64                randconfig-078-20250901    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250901    gcc-15.1.0
xtensa                randconfig-001-20250901    gcc-8.5.0
xtensa                randconfig-002-20250901    gcc-12.5.0
xtensa                randconfig-002-20250901    gcc-15.1.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

