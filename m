Return-Path: <linux-pci+bounces-29811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CEDAD9BFF
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 12:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2496F7A3138
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B11CEE90;
	Sat, 14 Jun 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TC+Y9L/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C319E971
	for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749895946; cv=none; b=CajMprYJmRWCUwArbOpJHND47t1Sfj1LMFxi8DoMPnVatGUxZxVmnDHAA3j2u0xjpD6UCqGqVP+xhNdhmmuTiXXxmmq1X+HGMYXBDOOKKwEFhURspqcXYOwU5aDIgLs93MPF1WSB5s1oeRIfA6OxeMu8k1052Ie59K87rXWyShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749895946; c=relaxed/simple;
	bh=DsXq7TkhultNNaHHRuNN2ONdKYEPuxfPvcVYeZdoEQI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DMrWaSI3z2EPw6KImM70L2CqDKPH1K4c5Mi//l2O/OnCgxno9IOdFdNRaHOwuw7YP3TMpslxWU7qnT0ch1uLrHjtDxNXfuni+1/Ema3dBjdFn+D8LqLyT3Lwa4jgQiUYYjO9BGqTAIYL3T+TRe/rL0Z0jgkJvbRhJ5YIyDMy7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TC+Y9L/6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749895945; x=1781431945;
  h=date:from:to:cc:subject:message-id;
  bh=DsXq7TkhultNNaHHRuNN2ONdKYEPuxfPvcVYeZdoEQI=;
  b=TC+Y9L/6CUsZXTwwiytvgvzriyrVVkFiktWX9KVGm0FgmGVcolq5qrYX
   wIKGZnu2j0tWBfwneoCZVLAymMDpF3Q2RcfI+3Wsu2cBxtxEFhmnMkCs2
   yp6u+4K0/wnLk8ph4gYo4jVhau5XbvMCVtTXoc6RPU224C439VwfAaUiC
   MzjpfZjLEpLwxOnLSEyLVsQhPFrAvICVVS3U5+XTkIeS5Z8sovyMOmZKJ
   xBRPj+n7D60nTr94oL/8Qr9yPo8t11AGY9aSByBkvJCWmmpIBtXz1aCkU
   V9rJgxkB3njIYhoixV7tgEoCW4n01gkMcnkAa74wxh5EoJ/K5n04ZGQHl
   Q==;
X-CSE-ConnectionGUID: fa4zcG3VTEWWr27iHbQbow==
X-CSE-MsgGUID: 9bAC74RPRraAgJGdHVgNMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63139922"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="63139922"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 03:12:25 -0700
X-CSE-ConnectionGUID: z/WhD5RFT6iavClxNwf4gQ==
X-CSE-MsgGUID: LZln0DKMTzm9HZiHXidoQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="171229556"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jun 2025 03:12:24 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQNs4-000DQw-37;
	Sat, 14 Jun 2025 10:12:20 +0000
Date: Sat, 14 Jun 2025 18:11:42 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 f58089683f6fb127ed87a5fcf78087de76c9d178
Message-ID: <202506141833.drO3swm8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: f58089683f6fb127ed87a5fcf78087de76c9d178  PCI/ASPM: Consolidate variable declaration and initialization

elapsed time: 1455m

configs tested: 124
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250613    gcc-12.4.0
arc                   randconfig-002-20250613    gcc-12.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250613    clang-21
arm                   randconfig-002-20250613    clang-20
arm                   randconfig-003-20250613    gcc-8.5.0
arm                   randconfig-004-20250613    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250613    gcc-15.1.0
arm64                 randconfig-002-20250613    clang-21
arm64                 randconfig-003-20250613    clang-21
arm64                 randconfig-004-20250613    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250613    gcc-15.1.0
csky                  randconfig-002-20250613    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250613    clang-21
hexagon               randconfig-002-20250613    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250613    gcc-12
i386        buildonly-randconfig-002-20250613    gcc-11
i386        buildonly-randconfig-003-20250613    gcc-12
i386        buildonly-randconfig-004-20250613    clang-20
i386        buildonly-randconfig-005-20250613    clang-20
i386        buildonly-randconfig-006-20250613    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250613    gcc-15.1.0
loongarch             randconfig-002-20250613    gcc-15.1.0
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250613    gcc-11.5.0
nios2                 randconfig-002-20250613    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250613    gcc-8.5.0
parisc                randconfig-002-20250613    gcc-13.3.0
parisc64                         alldefconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    clang-20
powerpc                       ppc64_defconfig    clang-21
powerpc               randconfig-001-20250613    clang-21
powerpc               randconfig-002-20250613    gcc-8.5.0
powerpc               randconfig-003-20250613    gcc-9.3.0
powerpc64             randconfig-001-20250613    gcc-8.5.0
powerpc64             randconfig-002-20250613    gcc-8.5.0
powerpc64             randconfig-003-20250613    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250613    gcc-8.5.0
riscv                 randconfig-002-20250613    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250613    clang-21
s390                  randconfig-002-20250613    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250613    gcc-15.1.0
sh                    randconfig-002-20250613    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250613    gcc-10.3.0
sparc                 randconfig-002-20250613    gcc-13.3.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250613    gcc-15.1.0
sparc64               randconfig-002-20250613    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250613    gcc-12
um                    randconfig-002-20250613    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250613    clang-20
x86_64      buildonly-randconfig-002-20250613    gcc-12
x86_64      buildonly-randconfig-003-20250613    gcc-12
x86_64      buildonly-randconfig-004-20250613    gcc-12
x86_64      buildonly-randconfig-005-20250613    clang-20
x86_64      buildonly-randconfig-006-20250613    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250613    gcc-8.5.0
xtensa                randconfig-002-20250613    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

