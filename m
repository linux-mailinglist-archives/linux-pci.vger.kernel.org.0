Return-Path: <linux-pci+bounces-34491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11986B307A3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 23:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4309B562348
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D857350D50;
	Thu, 21 Aug 2025 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG2m+Gp8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353B350840
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808963; cv=none; b=lS+FpXOhyI/PyMhCgaF8MNDwWeZHWHiZ24JbYC8ZqU3P60zbybLP31jlP/Dt66OFFrs8WyrA4KV68SgqNR/whrDf/icuGBAPTWbl9RO2QFEkW4glEb9qNYLYQUO+4VAamNA5CbgYH3ZVnYhpigbU0kdju+SKYi8nIIIyJU+fM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808963; c=relaxed/simple;
	bh=tT+ikjdw3P4sSDhzexmdBuhggDAcv5XoL6JNScnZ0ZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sBTjrFA2DhE0yPu0RDVbw+PAMtN3c4ia7VNfMNVDFcgiknjrfc2JnDAISb5AvjzkU3prMMVWhSb0I2Qw7ksSnLoyR8DLDoaPYGBF+87j4lgORswp8ahkgZ2nQDXpw0nxWelhNBZ2C3KYQK67ax5fxwhfvibIPz2+HE91LXtC8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OG2m+Gp8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755808961; x=1787344961;
  h=date:from:to:cc:subject:message-id;
  bh=tT+ikjdw3P4sSDhzexmdBuhggDAcv5XoL6JNScnZ0ZI=;
  b=OG2m+Gp8T3sCV5VnaMR/FgBpn6/wWFjB1+6Xk3fb+9gHzmaCZQYlwVa6
   CU4Yo8VK1lKE2Nj2SiTVXK4jVVBB/Sgd6rgKsHFYhZNZ9BmwyYjyF5Vdx
   9lnZG87N1XvhodhiG3xJ+iX5/e1q1hnFsLd6H/qpCYhAylI4IpyqqsQ0G
   yqFZoGCBiAZy+QVQ/4Kttx2BjS4Q1Ji/QT7gVMLQzriLky1Hmv9xBCxR2
   dH0caFYTxOT2SZGzasY/jCceMTVL62Wfwp96zswCiUkr2y78A42LJSX/C
   BKGPyRK9bWwPIRARvys6gyu7YNn5E4K3vLwTwEhmfsH/yfE5QbxuC8JIC
   g==;
X-CSE-ConnectionGUID: Iyg9200ST3yY5KQS4f6Zaw==
X-CSE-MsgGUID: Dopvwl+BQVOPXxyKDJfo7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58181015"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58181015"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 13:42:40 -0700
X-CSE-ConnectionGUID: fKzRiDMmQ4GwQ31yzxr5lg==
X-CSE-MsgGUID: 52b1RSIsQ9uk6L1VtH7a+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172721807"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 21 Aug 2025 13:42:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upC7I-000KeN-2H;
	Thu, 21 Aug 2025 20:42:36 +0000
Date: Fri, 22 Aug 2025 04:42:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 6238784e502b6a9fbeb3a6b77284b29baa4135cc
Message-ID: <202508220412.83Kcd3NM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: 6238784e502b6a9fbeb3a6b77284b29baa4135cc  PCI/P2PDMA: Fix incorrect pointer usage in devm_kfree() call

elapsed time: 1396m

configs tested: 278
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250821    clang-22
arc                   randconfig-001-20250821    gcc-9.5.0
arc                   randconfig-001-20250822    clang-22
arc                   randconfig-002-20250821    clang-22
arc                   randconfig-002-20250821    gcc-13.4.0
arc                   randconfig-002-20250822    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250821    clang-22
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
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-001-20250822    clang-22
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-002-20250822    clang-22
arm64                 randconfig-003-20250821    clang-22
arm64                 randconfig-003-20250821    gcc-11.5.0
arm64                 randconfig-003-20250822    clang-22
arm64                 randconfig-004-20250821    clang-22
arm64                 randconfig-004-20250821    gcc-13.4.0
arm64                 randconfig-004-20250822    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250821    clang-22
csky                  randconfig-001-20250821    gcc-13.4.0
csky                  randconfig-001-20250822    clang-22
csky                  randconfig-002-20250821    clang-22
csky                  randconfig-002-20250821    gcc-15.1.0
csky                  randconfig-002-20250822    clang-22
hexagon                          allmodconfig    clang-17
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
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
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
i386                  randconfig-011-20250822    gcc-12
i386                  randconfig-012-20250821    gcc-12
i386                  randconfig-012-20250822    gcc-12
i386                  randconfig-013-20250821    gcc-12
i386                  randconfig-013-20250822    gcc-12
i386                  randconfig-014-20250821    gcc-12
i386                  randconfig-014-20250822    gcc-12
i386                  randconfig-015-20250821    gcc-12
i386                  randconfig-015-20250822    gcc-12
i386                  randconfig-016-20250821    gcc-12
i386                  randconfig-016-20250822    gcc-12
i386                  randconfig-017-20250821    gcc-12
i386                  randconfig-017-20250822    gcc-12
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
riscv                 randconfig-002-20250821    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250821    gcc-14.3.0
s390                  randconfig-002-20250821    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250821    gcc-15.1.0
sh                    randconfig-002-20250821    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250821    gcc-14.3.0
sparc                 randconfig-002-20250821    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250821    gcc-8.5.0
sparc64               randconfig-002-20250821    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250821    clang-19
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
x86_64                              defconfig    gcc-11
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
xtensa                randconfig-001-20250821    gcc-11.5.0
xtensa                randconfig-002-20250821    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

