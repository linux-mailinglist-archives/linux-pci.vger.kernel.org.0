Return-Path: <linux-pci+bounces-29817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA12AD9E56
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC863B9B0A
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4151A8412;
	Sat, 14 Jun 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ4bvh7D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB81922FB
	for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749919151; cv=none; b=nJShE8tui8uOFo7wmoH5Z06VY/bq/DF3xhUwqLtlWF4QD3wknxSsxsHAwR3nTQiJpAoyoXaS98OQ2utohuZx1GAlARM+fbr32ZzK5qgsA3/5lhETYxIzL1eOjJV4tj8ntGoSN1BZKJNGKUyxiTnZqGeqmbX2Cc73ferbhysvwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749919151; c=relaxed/simple;
	bh=StSIbIBXhQ7oop3kkT8Ubs+c/wiJ2JVGL2E7pWMcAZ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NJdBPw2Cf47Nzt1jbLx59p8uAZyKbeS9zrOTTbWKltz8XDmRg/B/jHKyQZrvkaJa1w9W18Szs15RA/APIXZyvlG771wSjHTJuu3ad6Bf41GxxsvfN1AccymRi259Emp4NF9Lz6P2hci+ZTJmdwUj7tvb3zrN5WzMF94hzzQWXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ4bvh7D; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749919150; x=1781455150;
  h=date:from:to:cc:subject:message-id;
  bh=StSIbIBXhQ7oop3kkT8Ubs+c/wiJ2JVGL2E7pWMcAZ0=;
  b=ZJ4bvh7DThP4THrRC2L4ab1PwWq8esD5kyYTzqhtEDGmybj6Mhfceg21
   XH6aS6O673pHgjUQG8p5NDBZSOKYacinYsAQgv6688YVUVjKxWPGxL0h8
   rCyoIBliqi2XReNCNdTDVgxdTa/9gFlgMOsVHCheTsEYyKXIxocBJk5/C
   bmBgoXZq0xgDh07zsB/2A7pEMdes5kbs32pIYvtRIIwUvNR5d3CHiBmWw
   BEaWLJjKvK4CLTDrkVOh4p5i1N5fIdtQ01yQbdE6rlsu896B+7e1MCSTq
   owEYoLBhPxOo6UVAsWgLGvRX58FIKGVR0cGIEYM2U8lR7+DCma0B43A5J
   g==;
X-CSE-ConnectionGUID: U64d1tG6QsCWJ3hGEPiocA==
X-CSE-MsgGUID: iBjYHsSHRjSOWaK63YzuoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="74644774"
X-IronPort-AV: E=Sophos;i="6.16,237,1744095600"; 
   d="scan'208";a="74644774"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 09:39:09 -0700
X-CSE-ConnectionGUID: UhMW/5a2RRCJrHM4BmwtmQ==
X-CSE-MsgGUID: iMBtp/ozS264FZWxh/9/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,237,1744095600"; 
   d="scan'208";a="147919697"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 Jun 2025 09:39:08 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQTuL-000Dgi-1c;
	Sat, 14 Jun 2025 16:39:05 +0000
Date: Sun, 15 Jun 2025 00:38:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
Message-ID: <202506150056.keQFnfex-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0  PCI/PM: Set up runtime PM even for devices without PCI PM

elapsed time: 1246m

configs tested: 221
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250614    gcc-8.5.0
arc                   randconfig-002-20250614    gcc-12.4.0
arc                   randconfig-002-20250614    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                      footbridge_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20250614    gcc-8.5.0
arm                   randconfig-002-20250614    clang-21
arm                   randconfig-002-20250614    gcc-8.5.0
arm                   randconfig-003-20250614    clang-16
arm                   randconfig-003-20250614    gcc-8.5.0
arm                   randconfig-004-20250614    clang-17
arm                   randconfig-004-20250614    gcc-8.5.0
arm                             rpc_defconfig    gcc-15.1.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250614    clang-21
arm64                 randconfig-001-20250614    gcc-8.5.0
arm64                 randconfig-002-20250614    gcc-15.1.0
arm64                 randconfig-002-20250614    gcc-8.5.0
arm64                 randconfig-003-20250614    clang-21
arm64                 randconfig-003-20250614    gcc-8.5.0
arm64                 randconfig-004-20250614    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250614    clang-21
csky                  randconfig-001-20250614    gcc-13.3.0
csky                  randconfig-002-20250614    clang-21
csky                  randconfig-002-20250614    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250614    clang-21
hexagon               randconfig-002-20250614    clang-16
hexagon               randconfig-002-20250614    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250614    clang-20
i386        buildonly-randconfig-002-20250614    clang-20
i386        buildonly-randconfig-003-20250614    clang-20
i386        buildonly-randconfig-004-20250614    gcc-12
i386        buildonly-randconfig-005-20250614    clang-20
i386        buildonly-randconfig-006-20250614    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250614    clang-20
i386                  randconfig-002-20250614    clang-20
i386                  randconfig-003-20250614    clang-20
i386                  randconfig-004-20250614    clang-20
i386                  randconfig-005-20250614    clang-20
i386                  randconfig-006-20250614    clang-20
i386                  randconfig-007-20250614    clang-20
i386                  randconfig-011-20250614    clang-20
i386                  randconfig-012-20250614    clang-20
i386                  randconfig-013-20250614    clang-20
i386                  randconfig-014-20250614    clang-20
i386                  randconfig-015-20250614    clang-20
i386                  randconfig-016-20250614    clang-20
i386                  randconfig-017-20250614    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250614    clang-21
loongarch             randconfig-001-20250614    gcc-15.1.0
loongarch             randconfig-002-20250614    clang-21
loongarch             randconfig-002-20250614    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250614    clang-21
nios2                 randconfig-001-20250614    gcc-13.3.0
nios2                 randconfig-002-20250614    clang-21
nios2                 randconfig-002-20250614    gcc-11.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250614    clang-21
parisc                randconfig-001-20250614    gcc-8.5.0
parisc                randconfig-002-20250614    clang-21
parisc                randconfig-002-20250614    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc                      ppc64e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250614    clang-21
powerpc               randconfig-001-20250614    gcc-13.3.0
powerpc               randconfig-002-20250614    clang-21
powerpc               randconfig-003-20250614    clang-21
powerpc               randconfig-003-20250614    gcc-12.4.0
powerpc                     taishan_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250614    clang-21
powerpc64             randconfig-001-20250614    gcc-11.5.0
powerpc64             randconfig-002-20250614    clang-21
powerpc64             randconfig-003-20250614    clang-21
powerpc64             randconfig-003-20250614    gcc-12.4.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250614    clang-21
riscv                 randconfig-001-20250614    gcc-14.3.0
riscv                 randconfig-002-20250614    gcc-14.3.0
riscv                 randconfig-002-20250614    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250614    clang-21
s390                  randconfig-001-20250614    gcc-14.3.0
s390                  randconfig-002-20250614    gcc-10.5.0
s390                  randconfig-002-20250614    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250614    gcc-14.3.0
sh                    randconfig-002-20250614    gcc-12.4.0
sh                    randconfig-002-20250614    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250614    gcc-14.3.0
sparc                 randconfig-001-20250614    gcc-15.1.0
sparc                 randconfig-002-20250614    gcc-10.3.0
sparc                 randconfig-002-20250614    gcc-14.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250614    gcc-14.3.0
sparc64               randconfig-001-20250614    gcc-8.5.0
sparc64               randconfig-002-20250614    gcc-14.3.0
sparc64               randconfig-002-20250614    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250614    clang-21
um                    randconfig-001-20250614    gcc-14.3.0
um                    randconfig-002-20250614    gcc-12
um                    randconfig-002-20250614    gcc-14.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250614    clang-20
x86_64      buildonly-randconfig-002-20250614    clang-20
x86_64      buildonly-randconfig-003-20250614    clang-20
x86_64      buildonly-randconfig-003-20250614    gcc-12
x86_64      buildonly-randconfig-004-20250614    clang-20
x86_64      buildonly-randconfig-005-20250614    clang-20
x86_64      buildonly-randconfig-006-20250614    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250614    clang-20
x86_64                randconfig-002-20250614    clang-20
x86_64                randconfig-003-20250614    clang-20
x86_64                randconfig-004-20250614    clang-20
x86_64                randconfig-005-20250614    clang-20
x86_64                randconfig-006-20250614    clang-20
x86_64                randconfig-007-20250614    clang-20
x86_64                randconfig-008-20250614    clang-20
x86_64                randconfig-071-20250614    clang-20
x86_64                randconfig-072-20250614    clang-20
x86_64                randconfig-073-20250614    clang-20
x86_64                randconfig-074-20250614    clang-20
x86_64                randconfig-075-20250614    clang-20
x86_64                randconfig-076-20250614    clang-20
x86_64                randconfig-077-20250614    clang-20
x86_64                randconfig-078-20250614    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250614    gcc-14.3.0
xtensa                randconfig-001-20250614    gcc-9.3.0
xtensa                randconfig-002-20250614    gcc-13.3.0
xtensa                randconfig-002-20250614    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

