Return-Path: <linux-pci+bounces-34121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA60B287EA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 23:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE096188289E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B4A926;
	Fri, 15 Aug 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfb1AgPU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FE257AFB
	for <linux-pci@vger.kernel.org>; Fri, 15 Aug 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294190; cv=none; b=Fy+j/O1xEGW3H0OD+NpmOCwZENP7RsaJL665U+JU9oJwBNJvtWDYuRJKJTCji5HhyquKipPmvxsAdkhsSCrlBu5QP4e4Mxy2WjsEqMkard845sgCjR5UFDeXj5ciMBcJLoYAecj9wHQNIL2SYguQqR7MH15vTiuBVhj9rutnozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294190; c=relaxed/simple;
	bh=ylF/GXLqvIhL0ip1ahFUc4oMyHT7Jo/V1kDLkA8s2ZM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fBwxMETkqd+tVZmiMTh8ZJX3F7XDMhILXuo3R9iUp8zEHhy/OFZcG2FjwQWKfDyIHMu6zYgo3GsQAoP9GcrGBUtBm2y64sa/PbCf/hj5c3G2AynbbIB5c2ymzliySAlC8EZO1Weu8X3XJWgOo8Hgidt36N6Ok3cXxu5w/hdoe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfb1AgPU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755294188; x=1786830188;
  h=date:from:to:cc:subject:message-id;
  bh=ylF/GXLqvIhL0ip1ahFUc4oMyHT7Jo/V1kDLkA8s2ZM=;
  b=gfb1AgPUdU/rZ4Zv6vfDrMuyQB+6BYjv4yhk9d9wv0rQB5Wh+um7nDsv
   5DogXV4T/LVpAagW7FfgjSVxwhJMPO1SZMx5u9xGEpGcrGhkP6+zqLw9h
   3zvQhwenYCNQyufAjXoH1MF3Bv+Sih3hMV+6QQrppCLxr2VtML2Vxa3gD
   8134mAJksriMeTZurByusZK+XGq5FdrpQELH201V99EBjbpNLOZ1hDYaQ
   +hU/mbf0m6REkyCMSQ0/iXwC4AU0nz8ZNyrAn1x5+14o7EWl2pqNhz2Bd
   EPIw/NLSPRGIRUYCWpjCTc+TGdB4aH+8/Yh4c0B8QVVYx9HTa6Jzt2fJk
   w==;
X-CSE-ConnectionGUID: xM1c3EerQ6GxHfP7ZeLpxg==
X-CSE-MsgGUID: jgyvT7YVQ1aeWMYd92+PfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="83045146"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="83045146"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:43:08 -0700
X-CSE-ConnectionGUID: lPymQBUATpW5XodpFbD/6Q==
X-CSE-MsgGUID: vdb4/dK0T4CuYk3wbU+sMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172315499"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2025 14:43:07 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un2CX-000CN2-11;
	Fri, 15 Aug 2025 21:43:05 +0000
Date: Sat, 16 Aug 2025 05:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 704e5dd1c02371dfc7d22e1520102b197a3b628b
Message-ID: <202508160507.JahUBH3B-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 704e5dd1c02371dfc7d22e1520102b197a3b628b  powerpc/eeh: Use result of error_detected() in uevent

elapsed time: 1453m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250815    gcc-8.5.0
arc                   randconfig-002-20250815    gcc-9.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          moxart_defconfig    gcc-15.1.0
arm                   randconfig-001-20250815    clang-16
arm                   randconfig-002-20250815    clang-18
arm                   randconfig-003-20250815    gcc-14.3.0
arm                   randconfig-004-20250815    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250815    gcc-8.5.0
arm64                 randconfig-002-20250815    gcc-8.5.0
arm64                 randconfig-003-20250815    clang-22
arm64                 randconfig-004-20250815    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250815    gcc-15.1.0
csky                  randconfig-002-20250815    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250815    clang-22
hexagon               randconfig-002-20250815    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-002-20250815    clang-20
i386        buildonly-randconfig-003-20250815    clang-20
i386        buildonly-randconfig-004-20250815    clang-20
i386        buildonly-randconfig-005-20250815    clang-20
i386        buildonly-randconfig-006-20250815    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250815    clang-22
loongarch             randconfig-002-20250815    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-002-20250815    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250815    gcc-8.5.0
parisc                randconfig-002-20250815    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    clang-22
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-002-20250815    clang-19
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250815    gcc-14.3.0
powerpc64             randconfig-002-20250815    gcc-10.5.0
powerpc64             randconfig-003-20250815    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250815    gcc-12.5.0
riscv                 randconfig-002-20250815    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250815    gcc-8.5.0
s390                  randconfig-002-20250815    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250815    gcc-11.5.0
sh                    randconfig-002-20250815    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250815    gcc-11.5.0
sparc                 randconfig-002-20250815    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250815    clang-22
sparc64               randconfig-002-20250815    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250815    gcc-12
um                    randconfig-002-20250815    clang-19
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250815    clang-20
x86_64      buildonly-randconfig-002-20250815    gcc-12
x86_64      buildonly-randconfig-003-20250815    gcc-12
x86_64      buildonly-randconfig-004-20250815    clang-20
x86_64      buildonly-randconfig-005-20250815    clang-20
x86_64      buildonly-randconfig-006-20250815    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250815    gcc-8.5.0
xtensa                randconfig-002-20250815    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

