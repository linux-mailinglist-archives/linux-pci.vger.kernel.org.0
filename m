Return-Path: <linux-pci+bounces-32349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F8B0842E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE54A0659
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 04:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447082556E;
	Thu, 17 Jul 2025 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYeQh90f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDD202F7C
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728249; cv=none; b=hIPTty88u+rdLWOXr4iPhUFAMTmuPWGwU4xulrKlsEWTfhbn0/Gc3egCHDocJOZ83kKbah5tHrp9upaZcLMSdI+XFhDLq3FaYRC+khsL8dYezVg+NKGUXYzUAbP/s/Lb9PBJCRZB0GQilNNpyEynB7Gk2ONTvFNqbJl8T7oXtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728249; c=relaxed/simple;
	bh=zZoK3g5SSIA4Oczppe5z+/ofwGxMgm+ar6yhW+CnsrI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t11OSmXHIZtJyapepRV4ckFr8Gh1Psf+zWBV/DFeDD4lKzUX8hAoK+hE+N6ezU2q5bIDjEmzT82sZPbeo+5If0DhDybZnpPvro7SCWMLWQab2t3yMU28AuaDnklXKnrrZY9HsyntyvZUH+6E9y/G/cbjrWmySe4oDdKAb00IVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYeQh90f; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752728247; x=1784264247;
  h=date:from:to:cc:subject:message-id;
  bh=zZoK3g5SSIA4Oczppe5z+/ofwGxMgm+ar6yhW+CnsrI=;
  b=fYeQh90fH6pybay13hZGy6NfDXVScGJNqK6AFYBQBMZG1+zC39ofL4ro
   sQJcnPqZF1H3/KGHtmOKsHlsW8UyUmvbE6lAFH/LLLzriGWsLB7/jgw7L
   B/wRs79dNiZInW0ETxjUqzSACI/ra6f3UlU7zYclF9k1TcjoNYvBgSrDi
   QFdLZzg/j/oZifxKSixUUj6X7KGj6nUABuWOqjbnuQiO1VIr/6/j86gNQ
   z3Q3J64VAWiTY1PVPvJjQJZ07wOxMpbdBr30BS0eBWqOqpLIDG3tZ95M/
   miqbB4LKZxkcoLOdYzM7oG5P7m6YEQX0GlaTrp+V/dJ/1W0JQl4SLRt2m
   Q==;
X-CSE-ConnectionGUID: MOMG8hHSR/SsmH5QmTzAWg==
X-CSE-MsgGUID: pfoGZ0tCRnelSjUDfmCeWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="42618956"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="42618956"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 21:57:26 -0700
X-CSE-ConnectionGUID: PLyG/XPoSDiVHlEjZGhJ8Q==
X-CSE-MsgGUID: 3V1IbYFiQlqUl5nSHEVmXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="188636248"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Jul 2025 21:57:25 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucGgM-000DA3-1f;
	Thu, 17 Jul 2025 04:57:22 +0000
Date: Thu, 17 Jul 2025 12:56:53 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 c1dc61aede55a571d34fe20415b1413a3c86ee24
Message-ID: <202507171241.lnuFZ90m-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: c1dc61aede55a571d34fe20415b1413a3c86ee24  PCI: dwc: Make dw_pcie_ptm_ops static

elapsed time: 1385m

configs tested: 250
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250716    gcc-13.4.0
arc                   randconfig-001-20250717    clang-21
arc                   randconfig-002-20250716    gcc-8.5.0
arc                   randconfig-002-20250717    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250716    clang-20
arm                   randconfig-001-20250717    clang-21
arm                   randconfig-002-20250716    gcc-12.4.0
arm                   randconfig-002-20250717    clang-21
arm                   randconfig-003-20250716    gcc-8.5.0
arm                   randconfig-003-20250717    clang-21
arm                   randconfig-004-20250716    gcc-8.5.0
arm                   randconfig-004-20250717    clang-21
arm                             rpc_defconfig    clang-21
arm                           sama5_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250716    gcc-9.5.0
arm64                 randconfig-001-20250717    clang-21
arm64                 randconfig-002-20250716    gcc-8.5.0
arm64                 randconfig-002-20250717    clang-21
arm64                 randconfig-003-20250716    gcc-8.5.0
arm64                 randconfig-003-20250717    clang-21
arm64                 randconfig-004-20250716    clang-21
arm64                 randconfig-004-20250717    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250716    gcc-14.3.0
csky                  randconfig-001-20250717    gcc-12.4.0
csky                  randconfig-002-20250716    gcc-15.1.0
csky                  randconfig-002-20250717    gcc-12.4.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250716    clang-21
hexagon               randconfig-001-20250717    gcc-12.4.0
hexagon               randconfig-002-20250716    clang-21
hexagon               randconfig-002-20250717    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-001-20250717    clang-20
i386        buildonly-randconfig-002-20250716    clang-20
i386        buildonly-randconfig-002-20250717    clang-20
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-003-20250717    clang-20
i386        buildonly-randconfig-004-20250716    gcc-11
i386        buildonly-randconfig-004-20250717    clang-20
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-005-20250717    clang-20
i386        buildonly-randconfig-006-20250716    clang-20
i386        buildonly-randconfig-006-20250717    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250717    gcc-12
i386                  randconfig-002-20250717    gcc-12
i386                  randconfig-003-20250717    gcc-12
i386                  randconfig-004-20250717    gcc-12
i386                  randconfig-005-20250717    gcc-12
i386                  randconfig-006-20250717    gcc-12
i386                  randconfig-007-20250717    gcc-12
i386                  randconfig-011-20250717    gcc-12
i386                  randconfig-012-20250717    gcc-12
i386                  randconfig-013-20250717    gcc-12
i386                  randconfig-014-20250717    gcc-12
i386                  randconfig-015-20250717    gcc-12
i386                  randconfig-016-20250717    gcc-12
i386                  randconfig-017-20250717    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250716    clang-18
loongarch             randconfig-001-20250717    gcc-12.4.0
loongarch             randconfig-002-20250716    clang-21
loongarch             randconfig-002-20250717    gcc-12.4.0
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
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250716    gcc-14.2.0
nios2                 randconfig-001-20250717    gcc-12.4.0
nios2                 randconfig-002-20250716    gcc-11.5.0
nios2                 randconfig-002-20250717    gcc-12.4.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-8.5.0
parisc                randconfig-001-20250717    gcc-12.4.0
parisc                randconfig-002-20250716    gcc-8.5.0
parisc                randconfig-002-20250717    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                        icon_defconfig    clang-21
powerpc                      mgcoge_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    clang-21
powerpc               randconfig-001-20250716    gcc-8.5.0
powerpc               randconfig-001-20250717    gcc-12.4.0
powerpc               randconfig-002-20250716    clang-21
powerpc               randconfig-002-20250717    gcc-12.4.0
powerpc               randconfig-003-20250716    gcc-14.3.0
powerpc               randconfig-003-20250717    gcc-12.4.0
powerpc64             randconfig-001-20250716    gcc-10.5.0
powerpc64             randconfig-001-20250717    gcc-12.4.0
powerpc64             randconfig-002-20250717    gcc-12.4.0
powerpc64             randconfig-003-20250716    gcc-13.4.0
powerpc64             randconfig-003-20250717    gcc-12.4.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250716    gcc-8.5.0
riscv                 randconfig-001-20250717    gcc-13.4.0
riscv                 randconfig-002-20250716    gcc-11.5.0
riscv                 randconfig-002-20250717    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-001-20250717    gcc-13.4.0
s390                  randconfig-002-20250716    gcc-11.5.0
s390                  randconfig-002-20250717    gcc-13.4.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-15.1.0
sh                    randconfig-001-20250717    gcc-13.4.0
sh                    randconfig-002-20250716    gcc-14.3.0
sh                    randconfig-002-20250717    gcc-13.4.0
sh                   sh7724_generic_defconfig    clang-21
sparc                            alldefconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-8.5.0
sparc                 randconfig-001-20250717    gcc-13.4.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc                 randconfig-002-20250717    gcc-13.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-001-20250717    gcc-13.4.0
sparc64               randconfig-002-20250716    clang-21
sparc64               randconfig-002-20250717    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-001-20250717    gcc-13.4.0
um                    randconfig-002-20250716    gcc-12
um                    randconfig-002-20250717    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250716    gcc-12
x86_64      buildonly-randconfig-001-20250717    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-002-20250717    gcc-12
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-003-20250717    gcc-12
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-004-20250717    gcc-12
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-005-20250717    gcc-12
x86_64      buildonly-randconfig-006-20250716    gcc-12
x86_64      buildonly-randconfig-006-20250717    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250717    gcc-11
x86_64                randconfig-002-20250717    gcc-11
x86_64                randconfig-003-20250717    gcc-11
x86_64                randconfig-004-20250717    gcc-11
x86_64                randconfig-005-20250717    gcc-11
x86_64                randconfig-006-20250717    gcc-11
x86_64                randconfig-007-20250717    gcc-11
x86_64                randconfig-008-20250717    gcc-11
x86_64                randconfig-071-20250717    gcc-12
x86_64                randconfig-072-20250717    gcc-12
x86_64                randconfig-073-20250717    gcc-12
x86_64                randconfig-074-20250717    gcc-12
x86_64                randconfig-075-20250717    gcc-12
x86_64                randconfig-076-20250717    gcc-12
x86_64                randconfig-077-20250717    gcc-12
x86_64                randconfig-078-20250717    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-001-20250717    gcc-13.4.0
xtensa                randconfig-002-20250716    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

