Return-Path: <linux-pci+bounces-42981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B924CB7933
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 02:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 890C130056C4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343B33993;
	Fri, 12 Dec 2025 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBzd4b/7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2FD27E
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765504093; cv=none; b=OsP/0HH/MJNa+7wQ5DagBx+rE2IM0A7QkcQneyHC/K8slMiXbTGAELxP0aMfKW6RXDfUNzBQ2WSz7Vy88E7swNbCZDydMeV7UT+rNH3uzq42o9qED7ojOSl9zDDQDbrLwYk8abnqUnPXW99mOMB1a9/bQl4jLi2AHqs+QNMFGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765504093; c=relaxed/simple;
	bh=PKQSmHv3szogBb/x8lv/pJGiLh0R/hmYN+0H2dGtbug=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TDCuYd1emhjONvKj0oQEoB7+wpcLgO0k1xtLjYL7vcYFKw+xB4AjT6ZXaz53haQdetUNca1mQ6LBISS+8kGkdOkAC1y0ZrpjZBz70ghjRlZadrihKZKdCu5Fgm/zY8TDxuveK8axZsMyu+gi82aGZ07CNFsMD67svdJZHD5HQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBzd4b/7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765504091; x=1797040091;
  h=date:from:to:cc:subject:message-id;
  bh=PKQSmHv3szogBb/x8lv/pJGiLh0R/hmYN+0H2dGtbug=;
  b=NBzd4b/7obEcnyYnEARW3zSeaDdE/SPFMWLYoGSKyvV5dmYXdOGTJU8t
   B1X4KbNFehGvqtfYL22WmkcWTKLqTsPT4fQnahmtH+KvBMl9EuxiFJ2EK
   5m/sMjeczYfee3wjBqan53KO2t0i6jcquSPIR0k9FA2hPC1zfMOHspXS1
   qcBG5iixXaRL+w5QOVT0SSo4sT4Knyd3Qqrac5y/VKRy0JXL4fLvQ17p/
   Qsc1If3Qzozf+s+ZEcxPY+tKY2HrKeeXqp8IqD+/joJ+tHZZv1IupLk6e
   Cv61XGD6LYrAtO9AaOeuE2hclv71LEqeeDbLssEw1DMV6gWszoNI91il+
   g==;
X-CSE-ConnectionGUID: Es6vPNBxRaaKzmcfTTa8hA==
X-CSE-MsgGUID: tnNmxZKjRCiMPSqRIQu68g==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67542872"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67542872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 17:48:11 -0800
X-CSE-ConnectionGUID: sVujYcoQQXm707HeEGjzKg==
X-CSE-MsgGUID: WRvd0H/JRfK14ib+SO28UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="201117586"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Dec 2025 17:48:11 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTsGN-000000005KL-0hys;
	Fri, 12 Dec 2025 01:48:07 +0000
Date: Fri, 12 Dec 2025 09:47:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:trace] BUILD SUCCESS
 d1a2d5beb4d7fba6886df7f4a008707d4f85a71c
Message-ID: <202512120950.RES9cyOX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git trace
branch HEAD: d1a2d5beb4d7fba6886df7f4a008707d4f85a71c  Documentation: tracing: Add PCI tracepoint documentation

elapsed time: 1462m

configs tested: 320
configs skipped: 1

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
arc                   randconfig-001-20251211    gcc-10.5.0
arc                   randconfig-001-20251211    gcc-8.5.0
arc                   randconfig-001-20251212    clang-22
arc                   randconfig-002-20251211    gcc-10.5.0
arc                   randconfig-002-20251211    gcc-14.3.0
arc                   randconfig-002-20251212    clang-22
arm                              alldefconfig    gcc-15.1.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                      footbridge_defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    gcc-15.1.0
arm                   randconfig-001-20251211    gcc-10.5.0
arm                   randconfig-001-20251211    gcc-8.5.0
arm                   randconfig-001-20251212    clang-22
arm                   randconfig-002-20251211    gcc-10.5.0
arm                   randconfig-002-20251212    clang-22
arm                   randconfig-003-20251211    clang-22
arm                   randconfig-003-20251211    gcc-10.5.0
arm                   randconfig-003-20251212    clang-22
arm                   randconfig-004-20251211    clang-22
arm                   randconfig-004-20251211    gcc-10.5.0
arm                   randconfig-004-20251212    clang-22
arm                         s5pv210_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251211    clang-22
arm64                 randconfig-001-20251211    gcc-14.3.0
arm64                 randconfig-001-20251212    clang-22
arm64                 randconfig-002-20251211    clang-22
arm64                 randconfig-002-20251211    gcc-14.3.0
arm64                 randconfig-002-20251212    clang-22
arm64                 randconfig-003-20251211    gcc-14.3.0
arm64                 randconfig-003-20251212    clang-22
arm64                 randconfig-004-20251211    clang-16
arm64                 randconfig-004-20251211    gcc-14.3.0
arm64                 randconfig-004-20251212    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251211    gcc-11.5.0
csky                  randconfig-001-20251211    gcc-14.3.0
csky                  randconfig-001-20251212    clang-22
csky                  randconfig-002-20251211    gcc-10.5.0
csky                  randconfig-002-20251211    gcc-14.3.0
csky                  randconfig-002-20251212    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251211    clang-19
hexagon               randconfig-001-20251211    gcc-8.5.0
hexagon               randconfig-001-20251212    gcc-11.5.0
hexagon               randconfig-002-20251211    clang-17
hexagon               randconfig-002-20251211    gcc-8.5.0
hexagon               randconfig-002-20251212    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251211    clang-20
i386        buildonly-randconfig-001-20251211    gcc-13
i386        buildonly-randconfig-001-20251212    gcc-14
i386        buildonly-randconfig-002-20251211    gcc-13
i386        buildonly-randconfig-002-20251211    gcc-14
i386        buildonly-randconfig-002-20251212    gcc-14
i386        buildonly-randconfig-003-20251211    clang-20
i386        buildonly-randconfig-003-20251211    gcc-13
i386        buildonly-randconfig-003-20251212    gcc-14
i386        buildonly-randconfig-004-20251211    gcc-13
i386        buildonly-randconfig-004-20251212    gcc-14
i386        buildonly-randconfig-005-20251211    gcc-13
i386        buildonly-randconfig-005-20251211    gcc-14
i386        buildonly-randconfig-005-20251212    gcc-14
i386        buildonly-randconfig-006-20251211    gcc-13
i386        buildonly-randconfig-006-20251212    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251211    gcc-14
i386                  randconfig-001-20251212    gcc-14
i386                  randconfig-002-20251211    clang-20
i386                  randconfig-002-20251212    gcc-14
i386                  randconfig-003-20251211    clang-20
i386                  randconfig-003-20251212    gcc-14
i386                  randconfig-004-20251211    gcc-14
i386                  randconfig-004-20251212    gcc-14
i386                  randconfig-005-20251211    clang-20
i386                  randconfig-005-20251212    gcc-14
i386                  randconfig-006-20251211    gcc-14
i386                  randconfig-006-20251212    gcc-14
i386                  randconfig-007-20251211    clang-20
i386                  randconfig-007-20251212    gcc-14
i386                  randconfig-011-20251211    clang-20
i386                  randconfig-011-20251211    gcc-14
i386                  randconfig-012-20251211    clang-20
i386                  randconfig-012-20251211    gcc-12
i386                  randconfig-013-20251211    clang-20
i386                  randconfig-014-20251211    clang-20
i386                  randconfig-015-20251211    clang-20
i386                  randconfig-016-20251211    clang-20
i386                  randconfig-017-20251211    clang-20
i386                  randconfig-017-20251211    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251211    gcc-14.3.0
loongarch             randconfig-001-20251211    gcc-8.5.0
loongarch             randconfig-001-20251212    gcc-11.5.0
loongarch             randconfig-002-20251211    clang-18
loongarch             randconfig-002-20251211    gcc-8.5.0
loongarch             randconfig-002-20251212    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
mips                           xway_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251211    gcc-8.5.0
nios2                 randconfig-001-20251212    gcc-11.5.0
nios2                 randconfig-002-20251211    gcc-8.5.0
nios2                 randconfig-002-20251212    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251211    clang-22
parisc                randconfig-001-20251212    clang-22
parisc                randconfig-002-20251211    clang-22
parisc                randconfig-002-20251212    clang-22
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251211    clang-22
powerpc               randconfig-001-20251212    clang-22
powerpc               randconfig-002-20251211    clang-22
powerpc               randconfig-002-20251212    clang-22
powerpc64             randconfig-001-20251211    clang-22
powerpc64             randconfig-001-20251212    clang-22
powerpc64             randconfig-002-20251211    clang-22
powerpc64             randconfig-002-20251212    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251211    clang-22
riscv                 randconfig-001-20251211    gcc-11.5.0
riscv                 randconfig-001-20251212    clang-17
riscv                 randconfig-002-20251211    gcc-11.5.0
riscv                 randconfig-002-20251212    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251211    gcc-11.5.0
s390                  randconfig-001-20251212    clang-17
s390                  randconfig-002-20251211    clang-22
s390                  randconfig-002-20251211    gcc-11.5.0
s390                  randconfig-002-20251212    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251211    gcc-11.5.0
sh                    randconfig-001-20251211    gcc-15.1.0
sh                    randconfig-001-20251212    clang-17
sh                    randconfig-002-20251211    gcc-10.5.0
sh                    randconfig-002-20251211    gcc-11.5.0
sh                    randconfig-002-20251212    clang-17
sh                          sdk7786_defconfig    gcc-15.1.0
sh                           se7619_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251211    gcc-11.5.0
sparc                 randconfig-001-20251212    gcc-8.5.0
sparc                 randconfig-002-20251211    gcc-11.5.0
sparc                 randconfig-002-20251211    gcc-8.5.0
sparc                 randconfig-002-20251212    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251211    gcc-11.5.0
sparc64               randconfig-001-20251211    gcc-8.5.0
sparc64               randconfig-001-20251212    gcc-8.5.0
sparc64               randconfig-002-20251211    gcc-11.5.0
sparc64               randconfig-002-20251211    gcc-8.5.0
sparc64               randconfig-002-20251212    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251211    clang-22
um                    randconfig-001-20251211    gcc-11.5.0
um                    randconfig-001-20251212    gcc-8.5.0
um                    randconfig-002-20251211    gcc-11.5.0
um                    randconfig-002-20251211    gcc-14
um                    randconfig-002-20251212    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251211    clang-20
x86_64      buildonly-randconfig-001-20251211    gcc-14
x86_64      buildonly-randconfig-002-20251211    clang-20
x86_64      buildonly-randconfig-002-20251211    gcc-14
x86_64      buildonly-randconfig-003-20251211    clang-20
x86_64      buildonly-randconfig-004-20251211    clang-20
x86_64      buildonly-randconfig-005-20251211    clang-20
x86_64      buildonly-randconfig-005-20251211    gcc-14
x86_64      buildonly-randconfig-006-20251211    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251211    gcc-12
x86_64                randconfig-001-20251211    gcc-14
x86_64                randconfig-001-20251212    clang-20
x86_64                randconfig-002-20251211    clang-20
x86_64                randconfig-002-20251211    gcc-12
x86_64                randconfig-002-20251212    clang-20
x86_64                randconfig-003-20251211    gcc-12
x86_64                randconfig-003-20251212    clang-20
x86_64                randconfig-004-20251211    clang-20
x86_64                randconfig-004-20251211    gcc-12
x86_64                randconfig-004-20251212    clang-20
x86_64                randconfig-005-20251211    gcc-12
x86_64                randconfig-005-20251211    gcc-14
x86_64                randconfig-005-20251212    clang-20
x86_64                randconfig-006-20251211    gcc-12
x86_64                randconfig-006-20251211    gcc-14
x86_64                randconfig-006-20251212    clang-20
x86_64                randconfig-011-20251211    gcc-14
x86_64                randconfig-011-20251212    clang-20
x86_64                randconfig-012-20251211    gcc-14
x86_64                randconfig-012-20251212    clang-20
x86_64                randconfig-013-20251211    gcc-14
x86_64                randconfig-013-20251212    clang-20
x86_64                randconfig-014-20251211    gcc-14
x86_64                randconfig-014-20251212    clang-20
x86_64                randconfig-015-20251211    gcc-14
x86_64                randconfig-015-20251212    clang-20
x86_64                randconfig-016-20251211    gcc-14
x86_64                randconfig-016-20251212    clang-20
x86_64                randconfig-071-20251211    gcc-14
x86_64                randconfig-072-20251211    clang-20
x86_64                randconfig-073-20251211    gcc-14
x86_64                randconfig-074-20251211    clang-20
x86_64                randconfig-075-20251211    clang-20
x86_64                randconfig-076-20251211    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251211    gcc-11.5.0
xtensa                randconfig-001-20251212    gcc-8.5.0
xtensa                randconfig-002-20251211    gcc-11.5.0
xtensa                randconfig-002-20251211    gcc-15.1.0
xtensa                randconfig-002-20251212    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

