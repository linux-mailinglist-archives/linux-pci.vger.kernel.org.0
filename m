Return-Path: <linux-pci+bounces-19226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDDA00A09
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249A4163D18
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2A1C07CF;
	Fri,  3 Jan 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bxzgy4vt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC550190049
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912274; cv=none; b=F8pJ8dn/9zvVK/9ppD5ULAz760mtGpEkbfNBYFBNUjEfu1sJNCfxqE4XRU0N0rI7zFjAEwCEKaZuN6ZIq6BQhT0Zg4fcEZ9bnThxAt/rH+KcjJn98ZCtPth6JtM14cvAO06O6lPJ+DqSyJH1rKXr8psUyrHiQSv8i1g4VpOgxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912274; c=relaxed/simple;
	bh=Jp0ApLPiYjYt58iJtfhPXse9SP1gtliYZ4wrekm3lYE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XjMBa2Oa00CZj7XfFmqzc9AEOjaqmc3pndOSx3rk13NLe55fvJztSZu4kcrSU3DjlOp91H3xx2P+KG4ltonUjKmKdTYx/Bl8z3zAgK1bULKOevErwRMJGPbLdw3tGuhct+VVXZpeoARILttwBLC6iOai+b81i1c7NORqGxTd1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bxzgy4vt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735912273; x=1767448273;
  h=date:from:to:cc:subject:message-id;
  bh=Jp0ApLPiYjYt58iJtfhPXse9SP1gtliYZ4wrekm3lYE=;
  b=Bxzgy4vt72pcKQONkrWsaz/HaIkGQQ7jb4kw54TmJFhK6LjWt6lGsfGO
   eXhF+/jNxhZWwa4hSSRBIFMc/r1Hj69Oyp0tIYBzr+93xTOvVtOQcWUEr
   LMk6V1niFUT9VzL4BHc53wO60gqScUV7rqy9uQ3eFBHvvSSzy0PAUEsz/
   NAvxSfeb3SJAbIrEXDqSR0A1Se1gIpX4dOO60YWXzmESTSKs+vWfYhTsr
   d29hwL/QSDpVlMIVaF+ZA+aiYKFhzc4gENljxtdzQBajAQv3Z/DsNoGrr
   gW470BhLc+3EIlYlqHNzIfWhDZGW67N+ZWdicRjIU8PPlCroqS+xd519p
   Q==;
X-CSE-ConnectionGUID: GHhJL3N5Q/2C3J9jc7Uj7A==
X-CSE-MsgGUID: S2BVurtiTXSzRrWREP+j9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="53569526"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="53569526"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 05:51:12 -0800
X-CSE-ConnectionGUID: CWXIs3EFTU+T1siNahgj0Q==
X-CSE-MsgGUID: wDfxwNhvQyiqsbtoQw379g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139130789"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Jan 2025 05:51:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTi4z-0009n5-0M;
	Fri, 03 Jan 2025 13:51:09 +0000
Date: Fri, 03 Jan 2025 21:50:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 bbefc2ff28b883c124cab7a436a7eb7d1fa51006
Message-ID: <202501032114.LavT0o7K-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: bbefc2ff28b883c124cab7a436a7eb7d1fa51006  PCI/bwctrl: Fix NULL pointer deref on unbind and bind

elapsed time: 848m

configs tested: 226
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-20
arc                   randconfig-001-20250103    clang-20
arc                   randconfig-001-20250103    gcc-13.2.0
arc                   randconfig-002-20250103    clang-20
arc                   randconfig-002-20250103    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250103    clang-20
arm                   randconfig-002-20250103    clang-15
arm                   randconfig-002-20250103    clang-20
arm                   randconfig-003-20250103    clang-20
arm                   randconfig-003-20250103    gcc-14.2.0
arm                   randconfig-004-20250103    clang-20
arm                           stm32_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250103    clang-19
arm64                 randconfig-001-20250103    clang-20
arm64                 randconfig-002-20250103    clang-20
arm64                 randconfig-003-20250103    clang-19
arm64                 randconfig-003-20250103    clang-20
arm64                 randconfig-004-20250103    clang-20
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250103    gcc-14.2.0
csky                  randconfig-002-20250103    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250103    clang-20
hexagon               randconfig-001-20250103    gcc-14.2.0
hexagon               randconfig-002-20250103    clang-20
hexagon               randconfig-002-20250103    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250103    clang-19
i386        buildonly-randconfig-002-20250103    clang-19
i386        buildonly-randconfig-003-20250103    gcc-12
i386        buildonly-randconfig-004-20250103    clang-19
i386        buildonly-randconfig-005-20250103    clang-19
i386        buildonly-randconfig-006-20250103    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250103    clang-19
i386                  randconfig-002-20250103    clang-19
i386                  randconfig-003-20250103    clang-19
i386                  randconfig-004-20250103    clang-19
i386                  randconfig-005-20250103    clang-19
i386                  randconfig-006-20250103    clang-19
i386                  randconfig-007-20250103    clang-19
i386                  randconfig-011-20250103    gcc-12
i386                  randconfig-012-20250103    gcc-12
i386                  randconfig-013-20250103    gcc-12
i386                  randconfig-014-20250103    gcc-12
i386                  randconfig-015-20250103    gcc-12
i386                  randconfig-016-20250103    gcc-12
i386                  randconfig-017-20250103    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250103    gcc-14.2.0
loongarch             randconfig-002-20250103    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                           ip22_defconfig    clang-20
mips                     loongson1b_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-20
mips                       rbtx49xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250103    gcc-14.2.0
nios2                 randconfig-002-20250103    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250103    gcc-14.2.0
parisc                randconfig-002-20250103    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    clang-20
powerpc                      ppc6xx_defconfig    clang-20
powerpc               randconfig-001-20250103    clang-17
powerpc               randconfig-001-20250103    gcc-14.2.0
powerpc               randconfig-002-20250103    clang-19
powerpc               randconfig-002-20250103    gcc-14.2.0
powerpc               randconfig-003-20250103    gcc-14.2.0
powerpc                    socrates_defconfig    clang-20
powerpc                     taishan_defconfig    clang-20
powerpc64             randconfig-001-20250103    clang-19
powerpc64             randconfig-001-20250103    gcc-14.2.0
powerpc64             randconfig-002-20250103    gcc-14.2.0
powerpc64             randconfig-003-20250103    clang-19
powerpc64             randconfig-003-20250103    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250103    clang-20
riscv                 randconfig-002-20250103    clang-20
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250103    clang-20
s390                  randconfig-001-20250103    gcc-14.2.0
s390                  randconfig-002-20250103    clang-20
s390                  randconfig-002-20250103    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    clang-20
sh                    randconfig-001-20250103    clang-20
sh                    randconfig-001-20250103    gcc-14.2.0
sh                    randconfig-002-20250103    clang-20
sh                    randconfig-002-20250103    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250103    clang-20
sparc                 randconfig-001-20250103    gcc-14.2.0
sparc                 randconfig-002-20250103    clang-20
sparc                 randconfig-002-20250103    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250103    clang-20
sparc64               randconfig-001-20250103    gcc-14.2.0
sparc64               randconfig-002-20250103    clang-20
sparc64               randconfig-002-20250103    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250103    clang-20
um                    randconfig-001-20250103    gcc-11
um                    randconfig-002-20250103    clang-20
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250103    clang-19
x86_64      buildonly-randconfig-001-20250103    gcc-12
x86_64      buildonly-randconfig-002-20250103    clang-19
x86_64      buildonly-randconfig-003-20250103    clang-19
x86_64      buildonly-randconfig-003-20250103    gcc-12
x86_64      buildonly-randconfig-004-20250103    clang-19
x86_64      buildonly-randconfig-005-20250103    clang-19
x86_64      buildonly-randconfig-006-20250103    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250103    gcc-12
x86_64                randconfig-002-20250103    gcc-12
x86_64                randconfig-003-20250103    gcc-12
x86_64                randconfig-004-20250103    gcc-12
x86_64                randconfig-005-20250103    gcc-12
x86_64                randconfig-006-20250103    gcc-12
x86_64                randconfig-007-20250103    gcc-12
x86_64                randconfig-008-20250103    gcc-12
x86_64                randconfig-071-20250103    clang-19
x86_64                randconfig-072-20250103    clang-19
x86_64                randconfig-073-20250103    clang-19
x86_64                randconfig-074-20250103    clang-19
x86_64                randconfig-075-20250103    clang-19
x86_64                randconfig-076-20250103    clang-19
x86_64                randconfig-077-20250103    clang-19
x86_64                randconfig-078-20250103    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250103    clang-20
xtensa                randconfig-001-20250103    gcc-14.2.0
xtensa                randconfig-002-20250103    clang-20
xtensa                randconfig-002-20250103    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

