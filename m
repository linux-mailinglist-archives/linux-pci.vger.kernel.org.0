Return-Path: <linux-pci+bounces-19305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB6DA0168B
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 20:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90EF162DE6
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 19:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD51607AC;
	Sat,  4 Jan 2025 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfehZ4/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753D125B2
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736019199; cv=none; b=q3f0fpxhaeXAgKKAv4sBp14QuX+RFakK6m1iCUAfmr2DFSb64NcZmEhTtNA3rIjn6I0OfNlIgUM38ABQVLHCXA3dF4aRZ7sQtJYC3Nhu6qUfz1tQoCZYFib10kiZcnm4a0jZ50uzLnVPwzwlK6kRhOq0y14tApb+fNsThOudHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736019199; c=relaxed/simple;
	bh=30UneSa1kpLg4TMIES07LLx9IJ/6JcoDHX1gnl0eYsI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NMLVEQaJfFD7br9Jcmkt2KwX0lCeQguq2wAizcZLlbi50ybx0jpUbLx0bDgxGahQsWX4TDRVU44Gu7TtnLt5w5s0Cf/kPBpYVAKKnAUnSPdB8ZT6ESoslhW25pKa9wyVxtKREHs98QKWfIREcH26928oxVDvUiu1yeBAdOai3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfehZ4/4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736019197; x=1767555197;
  h=date:from:to:cc:subject:message-id;
  bh=30UneSa1kpLg4TMIES07LLx9IJ/6JcoDHX1gnl0eYsI=;
  b=TfehZ4/42TajGnVDNtq0RWsvbrM1zVPx53dpMEH0XJLabRS7Zrt9P7/x
   YhZBjpXaU8G8sQVWvIRtatYlAZLGsrHGW+hFf6PhoyPIsf8Do8N36fAwm
   s9qEHxaDTkevXSXIBz+sQKwUC+l4HRjIHTSDvbUZgKDI27F+qG4iO6yi+
   uGJ2U1/XlYWLNH2G8LRbMNQEjmAt+G1YBVEil5hXqPlbrJHBFZ+NofTmi
   /0VSgjW2mT/qEp0Eb5f7Zm5pYY1bt2jLeCI5YGBbQJQTubIBxQTJ0ZI4+
   zLHpnKVi+T+FO0q107DW3TJ/RpjG3ck+VByzo+aYe9cPxWgQaPht6zAbY
   A==;
X-CSE-ConnectionGUID: CKDGWOgmRhWmAi0mjIrryw==
X-CSE-MsgGUID: dX9aG+6DTJaeZjX7W+kRxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11305"; a="35923803"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="35923803"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 11:33:16 -0800
X-CSE-ConnectionGUID: aMbHH0NGRwqbYYFtfWs7qw==
X-CSE-MsgGUID: YBgg+5umSPqwEIATBhk5Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="107037127"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Jan 2025 11:33:15 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tU9tY-000BAP-31;
	Sat, 04 Jan 2025 19:33:12 +0000
Date: Sun, 05 Jan 2025 03:32:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 5d48481b73932c21cbec897b5cfe6a1045689a31
Message-ID: <202501050301.gEtWzXlF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 5d48481b73932c21cbec897b5cfe6a1045689a31  PCI: Remove redundant PCI_VSEC_HDR and PCI_VSEC_HDR_LEN_SHIFT

elapsed time: 1373m

configs tested: 238
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250104    gcc-13.2.0
arc                   randconfig-002-20250104    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                            hisi_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250104    clang-20
arm                   randconfig-002-20250104    clang-20
arm                   randconfig-003-20250104    gcc-14.2.0
arm                   randconfig-004-20250104    gcc-14.2.0
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250104    clang-20
arm64                 randconfig-002-20250104    clang-16
arm64                 randconfig-003-20250104    gcc-14.2.0
arm64                 randconfig-004-20250104    gcc-14.2.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250104    gcc-14.2.0
csky                  randconfig-002-20250104    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250104    clang-20
hexagon               randconfig-002-20250104    clang-20
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250104    clang-19
i386        buildonly-randconfig-002-20250104    gcc-12
i386        buildonly-randconfig-003-20250104    clang-19
i386        buildonly-randconfig-004-20250104    gcc-12
i386        buildonly-randconfig-005-20250104    clang-19
i386        buildonly-randconfig-006-20250104    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250104    gcc-12
i386                  randconfig-002-20250104    gcc-12
i386                  randconfig-003-20250104    gcc-12
i386                  randconfig-004-20250104    gcc-12
i386                  randconfig-005-20250104    gcc-12
i386                  randconfig-006-20250104    gcc-12
i386                  randconfig-007-20250104    gcc-12
i386                  randconfig-011-20250104    gcc-12
i386                  randconfig-012-20250104    gcc-12
i386                  randconfig-013-20250104    gcc-12
i386                  randconfig-014-20250104    gcc-12
i386                  randconfig-015-20250104    gcc-12
i386                  randconfig-016-20250104    gcc-12
i386                  randconfig-017-20250104    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250104    gcc-14.2.0
loongarch             randconfig-002-20250104    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-18
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250104    gcc-14.2.0
nios2                 randconfig-002-20250104    gcc-14.2.0
openrisc                         allmodconfig    gcc-14.2.0
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
parisc                randconfig-001-20250104    gcc-14.2.0
parisc                randconfig-002-20250104    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    clang-18
powerpc               randconfig-001-20250104    clang-20
powerpc               randconfig-002-20250104    clang-18
powerpc               randconfig-003-20250104    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250104    gcc-14.2.0
powerpc64             randconfig-002-20250104    gcc-14.2.0
powerpc64             randconfig-003-20250104    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250104    gcc-11
riscv                 randconfig-001-20250104    gcc-14.2.0
riscv                 randconfig-002-20250104    clang-16
riscv                 randconfig-002-20250104    gcc-11
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250104    clang-20
s390                  randconfig-001-20250104    gcc-11
s390                  randconfig-002-20250104    clang-20
s390                  randconfig-002-20250104    gcc-11
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                    randconfig-001-20250104    gcc-11
sh                    randconfig-001-20250104    gcc-14.2.0
sh                    randconfig-002-20250104    gcc-11
sh                    randconfig-002-20250104    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250104    gcc-11
sparc                 randconfig-001-20250104    gcc-14.2.0
sparc                 randconfig-002-20250104    gcc-11
sparc                 randconfig-002-20250104    gcc-14.2.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250104    gcc-11
sparc64               randconfig-001-20250104    gcc-14.2.0
sparc64               randconfig-002-20250104    gcc-11
sparc64               randconfig-002-20250104    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250104    gcc-11
um                    randconfig-001-20250104    gcc-12
um                    randconfig-002-20250104    gcc-11
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250104    clang-19
x86_64      buildonly-randconfig-001-20250104    gcc-12
x86_64      buildonly-randconfig-002-20250104    clang-19
x86_64      buildonly-randconfig-003-20250104    clang-19
x86_64      buildonly-randconfig-003-20250104    gcc-12
x86_64      buildonly-randconfig-004-20250104    clang-19
x86_64      buildonly-randconfig-004-20250104    gcc-12
x86_64      buildonly-randconfig-005-20250104    clang-19
x86_64      buildonly-randconfig-006-20250104    clang-19
x86_64      buildonly-randconfig-006-20250104    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250104    clang-19
x86_64                randconfig-002-20250104    clang-19
x86_64                randconfig-003-20250104    clang-19
x86_64                randconfig-004-20250104    clang-19
x86_64                randconfig-005-20250104    clang-19
x86_64                randconfig-006-20250104    clang-19
x86_64                randconfig-007-20250104    clang-19
x86_64                randconfig-008-20250104    clang-19
x86_64                randconfig-071-20250104    gcc-11
x86_64                randconfig-072-20250104    gcc-11
x86_64                randconfig-073-20250104    gcc-11
x86_64                randconfig-074-20250104    gcc-11
x86_64                randconfig-075-20250104    gcc-11
x86_64                randconfig-076-20250104    gcc-11
x86_64                randconfig-077-20250104    gcc-11
x86_64                randconfig-078-20250104    gcc-11
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                randconfig-001-20250104    gcc-11
xtensa                randconfig-001-20250104    gcc-14.2.0
xtensa                randconfig-002-20250104    gcc-11
xtensa                randconfig-002-20250104    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

