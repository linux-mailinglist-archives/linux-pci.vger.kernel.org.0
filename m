Return-Path: <linux-pci+bounces-20340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F94A1B7E5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 15:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D197A4214
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23978F4E;
	Fri, 24 Jan 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjXOjXeo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475A132105
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728993; cv=none; b=Gl4RuVCLzQh0VW0SfHe/lwqMpQ5L2Fwao/u1BZ2fFVCRjkXnUfpbwAUuq9HNc2Ib75f9jwPBNrNYkjwVB8reGJQzO+86/vcZpd4mGztPwwuMf35M7MOqUBbJQZ8//5dfYjCoWVeqJ+ZDEOfWWo0vSckgHVKvwT3t8SIMKWBwz/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728993; c=relaxed/simple;
	bh=/i+TaX2ZfvadLiZYx16mxKfckCNeomhi+I4NijXsAQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BLUUMH9pJkZdYI68E4WDnTgCP6w9gRU0hcgqDDRV5OiN5KgKin8cdwYon20yZbTWKbMFx2ySco8sXumkrCBtEgsGdQt206I9aLcSBCGA6l5WQLlW0MOvSWzkFJ1rjMiE8RfCclh7BwpUwRlN9lD0NOAoaA5iZ5GRCyzuuItXmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjXOjXeo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737728991; x=1769264991;
  h=date:from:to:cc:subject:message-id;
  bh=/i+TaX2ZfvadLiZYx16mxKfckCNeomhi+I4NijXsAQA=;
  b=mjXOjXeoE27K7ay/UuxnIugPNzxDpeaMfeWO+ccfuuARLAmPvEi2XLGq
   iWjShXbDaRPH7NdGH2/6ALGlH2kDpxt2iQ2rPx7xJUP0rxEBfSCNKjyif
   Ig+4bhrGyAWBUtNZIKd3c+2rkHN1TN0GcDxJ/pMNvXOd9yC7F/m86B/2G
   ICRqQAvdNGbhieszhMRUgk03/JG934eNS3iluNggeRj8532ZhJ9GO1Sn3
   SJ6W0ImM0GM7GmIcv5DsN4jmaJdYhYEIOP9zg2qKrSAPvnecqZJQqXult
   INybmS3s5/Y6/adA40W7P461vz+HiznURqCZUsWWXcn5xrzfAKo51NRO3
   w==;
X-CSE-ConnectionGUID: 8M5m0YjpS8efaOg+PeWMcQ==
X-CSE-MsgGUID: P0syAOkcQbeuSd3X7Q96Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41097563"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="41097563"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 06:29:51 -0800
X-CSE-ConnectionGUID: bkhFCnN/STalEOmrAOA7MA==
X-CSE-MsgGUID: SwxvyfZcTVW+EFay30EvkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="107592729"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jan 2025 06:29:50 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbKgu-000ckj-0W;
	Fri, 24 Jan 2025 14:29:48 +0000
Date: Fri, 24 Jan 2025 22:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 4453f360862e5d9f0807941d613162c3f7a36559
Message-ID: <202501242259.aB4HmYcu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 4453f360862e5d9f0807941d613162c3f7a36559  PCI: Batch BAR sizing operations

elapsed time: 1229m

configs tested: 188
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250124    gcc-13.2.0
arc                   randconfig-002-20250124    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250124    clang-17
arm                   randconfig-002-20250124    gcc-14.2.0
arm                   randconfig-003-20250124    gcc-14.2.0
arm                   randconfig-004-20250124    clang-19
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250124    clang-20
arm64                 randconfig-002-20250124    clang-20
arm64                 randconfig-003-20250124    clang-19
arm64                 randconfig-004-20250124    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250124    gcc-14.2.0
csky                  randconfig-002-20250124    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20250124    clang-20
hexagon               randconfig-001-20250124    gcc-14.2.0
hexagon               randconfig-002-20250124    clang-14
hexagon               randconfig-002-20250124    gcc-14.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250124    clang-19
i386        buildonly-randconfig-002-20250124    clang-19
i386        buildonly-randconfig-003-20250124    clang-19
i386        buildonly-randconfig-003-20250124    gcc-12
i386        buildonly-randconfig-004-20250124    clang-19
i386        buildonly-randconfig-004-20250124    gcc-12
i386        buildonly-randconfig-005-20250124    clang-19
i386        buildonly-randconfig-005-20250124    gcc-12
i386        buildonly-randconfig-006-20250124    clang-19
i386        buildonly-randconfig-006-20250124    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250124    clang-19
i386                  randconfig-002-20250124    clang-19
i386                  randconfig-003-20250124    clang-19
i386                  randconfig-004-20250124    clang-19
i386                  randconfig-005-20250124    clang-19
i386                  randconfig-006-20250124    clang-19
i386                  randconfig-007-20250124    clang-19
i386                  randconfig-011-20250124    gcc-12
i386                  randconfig-012-20250124    gcc-12
i386                  randconfig-013-20250124    gcc-12
i386                  randconfig-014-20250124    gcc-12
i386                  randconfig-015-20250124    gcc-12
i386                  randconfig-016-20250124    gcc-12
i386                  randconfig-017-20250124    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250124    gcc-14.2.0
loongarch             randconfig-002-20250124    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250124    gcc-14.2.0
nios2                 randconfig-002-20250124    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250124    gcc-14.2.0
parisc                randconfig-002-20250124    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    clang-18
powerpc               randconfig-001-20250124    gcc-14.2.0
powerpc               randconfig-002-20250124    gcc-14.2.0
powerpc               randconfig-003-20250124    clang-20
powerpc               randconfig-003-20250124    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250124    gcc-14.2.0
powerpc64             randconfig-002-20250124    clang-20
powerpc64             randconfig-002-20250124    gcc-14.2.0
powerpc64             randconfig-003-20250124    clang-19
powerpc64             randconfig-003-20250124    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250124    clang-19
riscv                 randconfig-001-20250124    gcc-14.2.0
riscv                 randconfig-002-20250124    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250124    gcc-14.2.0
s390                  randconfig-002-20250124    clang-20
s390                  randconfig-002-20250124    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250124    gcc-14.2.0
sh                    randconfig-002-20250124    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250124    gcc-14.2.0
sparc                 randconfig-002-20250124    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250124    gcc-14.2.0
sparc64               randconfig-002-20250124    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250124    gcc-12
um                    randconfig-001-20250124    gcc-14.2.0
um                    randconfig-002-20250124    clang-20
um                    randconfig-002-20250124    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250124    gcc-12
x86_64      buildonly-randconfig-002-20250124    gcc-12
x86_64      buildonly-randconfig-003-20250124    clang-19
x86_64      buildonly-randconfig-003-20250124    gcc-12
x86_64      buildonly-randconfig-004-20250124    clang-19
x86_64      buildonly-randconfig-004-20250124    gcc-12
x86_64      buildonly-randconfig-005-20250124    clang-19
x86_64      buildonly-randconfig-005-20250124    gcc-12
x86_64      buildonly-randconfig-006-20250124    clang-19
x86_64      buildonly-randconfig-006-20250124    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250124    clang-19
x86_64                randconfig-002-20250124    clang-19
x86_64                randconfig-003-20250124    clang-19
x86_64                randconfig-004-20250124    clang-19
x86_64                randconfig-005-20250124    clang-19
x86_64                randconfig-006-20250124    clang-19
x86_64                randconfig-007-20250124    clang-19
x86_64                randconfig-008-20250124    clang-19
x86_64                randconfig-071-20250124    gcc-12
x86_64                randconfig-072-20250124    gcc-12
x86_64                randconfig-073-20250124    gcc-12
x86_64                randconfig-074-20250124    gcc-12
x86_64                randconfig-075-20250124    gcc-12
x86_64                randconfig-076-20250124    gcc-12
x86_64                randconfig-077-20250124    gcc-12
x86_64                randconfig-078-20250124    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250124    gcc-14.2.0
xtensa                randconfig-002-20250124    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

