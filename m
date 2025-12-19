Return-Path: <linux-pci+bounces-43370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F2CCF9E3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A7C33003143
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882746B5;
	Fri, 19 Dec 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4IQTmsu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AE318142
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144416; cv=none; b=TBmRkGH7GKy1U9wO0VqUh4IVSF/YHw0IPUisUirV3RX/NeaCWTxtdW6P+plK409R97QRDBs+Vu2nA07Hwm45SnRflcZeyEtN6i2KIjpxkhYa1E65sRuxnFyHggUULK74QbPUVrxuogQEowBU+9txU5pg5tzkp2ujmYjLaf4eSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144416; c=relaxed/simple;
	bh=Zet6RaGIspsQW6kDH1K7BS04ijEJgYZy2SXL+sJIH9k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i+0RrRa16YtcIaAFgvsZK0Tut6ZTMlNIXpHYhpzGOP7kLNQ+HMAxCQQb+58kzkoMFAar1TwIFuZhkN3mJkExgpeY3tEifg7g4DJoNaEZQVEEN2akdQhgwTY4YlstetKgcRdnQwEykli9bsbPoiy4TZW1VQbaFomhmu+MVDt4SlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4IQTmsu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766144415; x=1797680415;
  h=date:from:to:cc:subject:message-id;
  bh=Zet6RaGIspsQW6kDH1K7BS04ijEJgYZy2SXL+sJIH9k=;
  b=e4IQTmsuDbZJ1DsazOvCBJRsEOupk+35/oA3chD7MBLztDF3jXRh5ytH
   clT0dwHm8/CQfOAeqJpqmPZQGnMCnei6kRsA4x9WwXCV/XGshKAOhGW8u
   5GH3Vvq6I1vYm6PGr/s6xEClSOYjVqOyG25cz+7s0s4X2iMz880jgnjRh
   L4DyI2h22nAlUWSpR/eS8AIJrqn69XmU93aW9tJXGy7q2VxU4dUAWAa3Z
   1RpwgIh48UyzAEAaDlBYY5Me5dmsFnfg1zh54Ft5D6KetScoTFIg4/CKx
   0H2q+7W4DTQ6WE0I3y++txzZ90A1t6Rs8IgQ7bj1s/ggiZXQQFfEa+dNn
   Q==;
X-CSE-ConnectionGUID: rFD53LBRRhCpJMlwptmfEA==
X-CSE-MsgGUID: G5thceMnRLm16Iw0uWobwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67856441"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="67856441"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 03:40:14 -0800
X-CSE-ConnectionGUID: m2+YsIEYSqm2CY8UnSge7g==
X-CSE-MsgGUID: IbOph5mdS2WBXOkfN1bowA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198745288"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2025 03:40:13 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWYqB-000000003Rz-0UKY;
	Fri, 19 Dec 2025 11:40:11 +0000
Date: Fri, 19 Dec 2025 19:39:18 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence-j721e] BUILD SUCCESS
 4b361b1e92be255ff923453fe8db74086cc7cf66
Message-ID: <202512191905.Yiemd79O-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence-j721e
branch HEAD: 4b361b1e92be255ff923453fe8db74086cc7cf66  PCI: j721e: Add config guards for Cadence Host and Endpoint library APIs

elapsed time: 1638m

configs tested: 121
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
alpha                     defconfig    gcc-15.1.0
arc                    allmodconfig    clang-16
arc                     allnoconfig    gcc-15.1.0
arc                       defconfig    gcc-15.1.0
arc         randconfig-001-20251219    gcc-11.5.0
arc         randconfig-002-20251219    gcc-11.5.0
arm                     allnoconfig    gcc-15.1.0
arm                    allyesconfig    clang-16
arm                       defconfig    gcc-15.1.0
arm         randconfig-001-20251219    gcc-11.5.0
arm         randconfig-002-20251219    gcc-11.5.0
arm         randconfig-003-20251219    gcc-11.5.0
arm         randconfig-004-20251219    gcc-11.5.0
arm64                   allnoconfig    gcc-15.1.0
arm64                     defconfig    gcc-15.1.0
arm64       randconfig-001-20251219    gcc-9.5.0
arm64       randconfig-002-20251219    gcc-9.5.0
arm64       randconfig-003-20251219    gcc-9.5.0
arm64       randconfig-004-20251219    gcc-9.5.0
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                      defconfig    gcc-15.1.0
csky        randconfig-001-20251219    gcc-9.5.0
csky        randconfig-002-20251219    gcc-9.5.0
hexagon                allmodconfig    gcc-15.1.0
hexagon                 allnoconfig    gcc-15.1.0
hexagon                   defconfig    gcc-15.1.0
hexagon     randconfig-001-20251219    gcc-11.5.0
hexagon     randconfig-002-20251219    gcc-11.5.0
i386                   allmodconfig    clang-20
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-15.1.0
i386                   allyesconfig    clang-20
i386                   allyesconfig    gcc-14
i386                      defconfig    gcc-15.1.0
loongarch               allnoconfig    gcc-15.1.0
loongarch                 defconfig    clang-19
loongarch   randconfig-001-20251219    gcc-11.5.0
loongarch   randconfig-002-20251219    gcc-11.5.0
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    clang-16
m68k                      defconfig    clang-19
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
microblaze                defconfig    clang-19
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                  allmodconfig    clang-22
nios2                   allnoconfig    clang-22
nios2                     defconfig    clang-19
nios2       randconfig-001-20251219    gcc-11.5.0
nios2       randconfig-002-20251219    gcc-11.5.0
openrisc               allmodconfig    clang-22
openrisc                allnoconfig    clang-22
openrisc                  defconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    clang-22
parisc                 allyesconfig    clang-19
parisc                    defconfig    gcc-15.1.0
parisc      randconfig-001-20251219    clang-22
parisc      randconfig-002-20251219    clang-22
parisc64                  defconfig    clang-19
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    clang-22
powerpc     randconfig-001-20251219    clang-22
powerpc     randconfig-002-20251219    clang-22
powerpc64   randconfig-001-20251219    clang-22
powerpc64   randconfig-002-20251219    clang-22
riscv                   allnoconfig    clang-22
riscv                  allyesconfig    clang-16
riscv                     defconfig    gcc-15.1.0
riscv       randconfig-001-20251219    clang-22
riscv       randconfig-002-20251219    clang-22
s390                   allmodconfig    clang-19
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390                      defconfig    gcc-15.1.0
s390        randconfig-001-20251219    clang-22
s390        randconfig-002-20251219    clang-22
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    clang-22
sh                     allyesconfig    clang-19
sh                        defconfig    gcc-14
sh          randconfig-001-20251219    clang-22
sh          randconfig-002-20251219    clang-22
sparc                   allnoconfig    clang-22
sparc                     defconfig    gcc-15.1.0
sparc       randconfig-001-20251219    gcc-8.5.0
sparc       randconfig-002-20251219    gcc-8.5.0
sparc64                allmodconfig    clang-22
sparc64                   defconfig    gcc-14
sparc64     randconfig-001-20251219    gcc-8.5.0
sparc64     randconfig-002-20251219    gcc-8.5.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-15.1.0
um                        defconfig    gcc-14
um                   i386_defconfig    gcc-14
um          randconfig-001-20251219    gcc-8.5.0
um          randconfig-002-20251219    gcc-8.5.0
um                 x86_64_defconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-22
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    clang-22
xtensa                 allyesconfig    clang-22
xtensa      randconfig-001-20251219    gcc-8.5.0
xtensa      randconfig-002-20251219    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

