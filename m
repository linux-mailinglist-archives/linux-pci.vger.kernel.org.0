Return-Path: <linux-pci+bounces-43679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1B0CDC71D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 15:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2C730B1144
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3B34CFB1;
	Wed, 24 Dec 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dgf/QCkV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5C34BA34
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584077; cv=none; b=JczKyqylkOBvXPQYBNpFDAcnZ1uG5HExABzYCbM1ZkCxbMQevGGUmUsSkotzgOXsTyLKRV0OsLFq/InAYa8ZY0EB04szM1QjOcJIcZqucwjxnqmc1dqVsfasweGkPR6GM/GAjtRvPad55PH29zrlxruI2DzYk1xmDoEEVL1hr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584077; c=relaxed/simple;
	bh=efhTXSVa1sHAoGAsuwUWgM20QxVv/Bl3qxzJkIPr4lA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Nt66puOv8jMvbpBhXnAbmkN4uOuARHMkl8ZGSj3D8Yik2yjmFOhFTd1jQCHiIa8TTwwcrkvC2cLhh5HyU9feAmbCzpzwQ37AFzxieDonImwHzkgD0ML7RoOOkvX/hTU1pvqBTOj3z4QWsLyXvcNlqeO2YqRs435eQfb51WvrLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dgf/QCkV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766584075; x=1798120075;
  h=date:from:to:cc:subject:message-id;
  bh=efhTXSVa1sHAoGAsuwUWgM20QxVv/Bl3qxzJkIPr4lA=;
  b=Dgf/QCkVwfsLmmcrvXB2xnMeQtmCyIkQ5cXYjNyQuxg51gcw5q8smMpR
   f7ZuR7Fnol2YyXexwSyl5e1oqJC3Y0h8oW1yN9mm1OPKiBKZ6OwCmgsFe
   QhgmapSlKuLIL+cheitIh5rvmopIxv9+yEJZNGlSzPGQIA67e5L6AP2VK
   G9e3Xz81iBnVw/0lYfvz+X6I+EBxw6EXFP89eSLcpzlvXYkeKtIWLQKr0
   VPagCpEydeGOQtBc+afpvgxaYR7xZoqIoJTxeiRA/5clg9EipidJV501R
   OXY+VVGisfipVde+fPOQLE2YfuUJ3+HEWoo+h6eMXYegBodNwJ6T94IQ9
   A==;
X-CSE-ConnectionGUID: +ieiKtZRTA6yOolHG+uyZg==
X-CSE-MsgGUID: CTqliOtSTtyH7EOFzAnioQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="72274030"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="72274030"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 05:47:55 -0800
X-CSE-ConnectionGUID: W73MLf0nRzOGGvU8G8xu/A==
X-CSE-MsgGUID: B1GkPgVZTois9w95k7+Jog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="204940447"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 24 Dec 2025 05:47:53 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYPDD-0000000037j-0kmx;
	Wed, 24 Dec 2025 13:47:41 +0000
Date: Wed, 24 Dec 2025 21:45:35 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 a306722d67c2089617c6b20948b84bbd5c84dab8
Message-ID: <202512242130.PTgSMQw9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: a306722d67c2089617c6b20948b84bbd5c84dab8  PCI: cadence: Avoid possible signed 64-bit truncation

elapsed time: 1270m

configs tested: 202
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251224    gcc-10.5.0
arc                   randconfig-002-20251224    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                   randconfig-001-20251224    gcc-10.5.0
arm                   randconfig-002-20251224    gcc-10.5.0
arm                   randconfig-003-20251224    gcc-10.5.0
arm                   randconfig-004-20251224    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251224    gcc-15.1.0
arm64                 randconfig-002-20251224    gcc-15.1.0
arm64                 randconfig-003-20251224    gcc-15.1.0
arm64                 randconfig-004-20251224    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251224    gcc-15.1.0
csky                  randconfig-002-20251224    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251224    gcc-15.1.0
hexagon               randconfig-002-20251224    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251224    gcc-14
i386        buildonly-randconfig-002-20251224    gcc-14
i386        buildonly-randconfig-003-20251224    gcc-14
i386        buildonly-randconfig-004-20251224    gcc-14
i386        buildonly-randconfig-005-20251224    gcc-14
i386        buildonly-randconfig-006-20251224    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251224    clang-20
i386                  randconfig-002-20251224    clang-20
i386                  randconfig-003-20251224    clang-20
i386                  randconfig-004-20251224    clang-20
i386                  randconfig-005-20251224    clang-20
i386                  randconfig-006-20251224    clang-20
i386                  randconfig-007-20251224    clang-20
i386                  randconfig-011-20251224    clang-20
i386                  randconfig-012-20251224    clang-20
i386                  randconfig-013-20251224    clang-20
i386                  randconfig-014-20251224    clang-20
i386                  randconfig-015-20251224    clang-20
i386                  randconfig-016-20251224    clang-20
i386                  randconfig-017-20251224    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251224    gcc-15.1.0
loongarch             randconfig-002-20251224    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251224    gcc-15.1.0
nios2                 randconfig-002-20251224    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251224    clang-22
parisc                randconfig-002-20251224    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251224    clang-22
powerpc               randconfig-002-20251224    clang-22
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251224    clang-22
powerpc64             randconfig-002-20251224    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251224    gcc-15.1.0
riscv                 randconfig-002-20251224    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251224    gcc-15.1.0
s390                  randconfig-002-20251224    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251224    gcc-15.1.0
sh                    randconfig-002-20251224    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251224    gcc-14
sparc                 randconfig-002-20251224    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251224    gcc-14
sparc64               randconfig-002-20251224    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251224    gcc-14
um                    randconfig-002-20251224    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251224    gcc-14
x86_64      buildonly-randconfig-002-20251224    gcc-14
x86_64      buildonly-randconfig-003-20251224    gcc-14
x86_64      buildonly-randconfig-004-20251224    gcc-14
x86_64      buildonly-randconfig-005-20251224    gcc-14
x86_64      buildonly-randconfig-006-20251224    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251224    gcc-14
x86_64                randconfig-002-20251224    gcc-14
x86_64                randconfig-003-20251224    gcc-14
x86_64                randconfig-004-20251224    gcc-14
x86_64                randconfig-005-20251224    gcc-14
x86_64                randconfig-006-20251224    gcc-14
x86_64                randconfig-011-20251224    gcc-14
x86_64                randconfig-012-20251224    gcc-14
x86_64                randconfig-013-20251224    gcc-14
x86_64                randconfig-014-20251224    gcc-14
x86_64                randconfig-015-20251224    gcc-14
x86_64                randconfig-016-20251224    gcc-14
x86_64                randconfig-071-20251224    clang-20
x86_64                randconfig-072-20251224    clang-20
x86_64                randconfig-073-20251224    clang-20
x86_64                randconfig-074-20251224    clang-20
x86_64                randconfig-075-20251224    clang-20
x86_64                randconfig-076-20251224    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251224    gcc-14
xtensa                randconfig-002-20251224    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

