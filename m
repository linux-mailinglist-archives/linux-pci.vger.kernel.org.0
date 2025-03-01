Return-Path: <linux-pci+bounces-22708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C70CA4AE18
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 23:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C98D3B4EBE
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32551E3DC4;
	Sat,  1 Mar 2025 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKhy0yg/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFE16F271
	for <linux-pci@vger.kernel.org>; Sat,  1 Mar 2025 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740866717; cv=none; b=eM8MOQhogGErxdYGBrzXXyvWBBNlrkMOFcPbAwt3PqsPyN89TJRrCfBD7FwmAHgHe4jZgRuIsBMkjer1G74bPBKLP2Wh/WWaTDh1kPSMNk06zUJbZXQyZ94yTOv9lywZ5C0vTXZv2n0T5aj86t8mLFZugejZzosOhyM08loUXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740866717; c=relaxed/simple;
	bh=zG8+Y/nA7MW0UROJ0RUOSv8qrvb5ORmTqF0Ztp0yyhs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i4ddbSFnrPPI3s8oN7tZ96/EEDPZWglw7o+aNfpLFYB1ocmKA17x8XVBkntWDD4Y6u2vgkAfShtnD9v5voDfSxCsL1GLYQahdubpWz2m5YUcQzl95y20CPh4WqQLEwoOgIKarBGVH7/fn20xSCDKoeeH3to6Oe2XPKKvFCCS99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKhy0yg/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740866716; x=1772402716;
  h=date:from:to:cc:subject:message-id;
  bh=zG8+Y/nA7MW0UROJ0RUOSv8qrvb5ORmTqF0Ztp0yyhs=;
  b=jKhy0yg/FAxSB/hwOdRtsqcYkijiM2dlH2NUjpN8ssOjY4MIlCGP3aCM
   QBoEzP3W6KxnqdAGsPAQKsXdo/ZxZ1oS7odquLbr2kQ+8II+vPTHWgpHd
   V+JbcDvobogl0MkfhGs3mcgVnoGDKNk7u0DwLmUMTbIwx1F0RVEM9q3F8
   0JB0554TAtgES3Jmtm5aUgbaFBBgpx83ojvq5Ys6XwXRPdx2L7hl/gBjj
   K5umJOo8pDJIp+VbklBp2dS7VuRQlP0QIOuNPvp3EVkjNlrreS/GwflpF
   QJnvADR5xa/5HWtwn5YMxNG1f7gEhASGNPsSjFH7DdyN1W4OlGWDHgqqR
   Q==;
X-CSE-ConnectionGUID: Ojk1rMgeSv2johzGFQSp4w==
X-CSE-MsgGUID: 8PmTK4YxSNS1423e1m21rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="44590229"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="44590229"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 14:05:15 -0800
X-CSE-ConnectionGUID: 4kJMXc03So6TwD0zx/P3uQ==
X-CSE-MsgGUID: S93UcgXFTfu2RhFWbBYHVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="118331996"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Mar 2025 14:05:13 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toUxL-000GlE-2y;
	Sat, 01 Mar 2025 22:05:11 +0000
Date: Sun, 02 Mar 2025 06:05:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devtree-create] BUILD SUCCESS
 1f340724419eda8ab07a20edcaf5ec8f70134231
Message-ID: <202503020601.m7C9OjHI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devtree-create
branch HEAD: 1f340724419eda8ab07a20edcaf5ec8f70134231  PCI: of: Create device tree PCI host bridge node

elapsed time: 1450m

configs tested: 194
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
arc                               allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250301    gcc-13.2.0
arc                   randconfig-001-20250302    gcc-14.2.0
arc                   randconfig-002-20250301    gcc-13.2.0
arc                   randconfig-002-20250302    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                        mvebu_v7_defconfig    clang-15
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20250301    gcc-14.2.0
arm                   randconfig-001-20250302    gcc-14.2.0
arm                   randconfig-002-20250301    gcc-14.2.0
arm                   randconfig-002-20250302    gcc-14.2.0
arm                   randconfig-003-20250301    clang-21
arm                   randconfig-003-20250302    gcc-14.2.0
arm                   randconfig-004-20250301    clang-21
arm                   randconfig-004-20250302    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250301    gcc-14.2.0
arm64                 randconfig-001-20250302    gcc-14.2.0
arm64                 randconfig-002-20250301    clang-21
arm64                 randconfig-002-20250302    gcc-14.2.0
arm64                 randconfig-003-20250301    clang-15
arm64                 randconfig-003-20250302    gcc-14.2.0
arm64                 randconfig-004-20250301    clang-17
arm64                 randconfig-004-20250302    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250301    gcc-14.2.0
csky                  randconfig-001-20250302    gcc-14.2.0
csky                  randconfig-002-20250301    gcc-14.2.0
csky                  randconfig-002-20250302    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250301    clang-21
hexagon               randconfig-001-20250302    gcc-14.2.0
hexagon               randconfig-002-20250301    clang-21
hexagon               randconfig-002-20250302    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250301    clang-19
i386        buildonly-randconfig-001-20250302    gcc-12
i386        buildonly-randconfig-002-20250301    clang-19
i386        buildonly-randconfig-002-20250302    gcc-12
i386        buildonly-randconfig-003-20250301    clang-19
i386        buildonly-randconfig-003-20250302    gcc-12
i386        buildonly-randconfig-004-20250301    clang-19
i386        buildonly-randconfig-004-20250302    gcc-12
i386        buildonly-randconfig-005-20250301    gcc-12
i386        buildonly-randconfig-005-20250302    gcc-12
i386        buildonly-randconfig-006-20250301    clang-19
i386        buildonly-randconfig-006-20250302    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250302    gcc-12
i386                  randconfig-002-20250302    gcc-12
i386                  randconfig-003-20250302    gcc-12
i386                  randconfig-004-20250302    gcc-12
i386                  randconfig-005-20250302    gcc-12
i386                  randconfig-006-20250302    gcc-12
i386                  randconfig-007-20250302    gcc-12
i386                  randconfig-011-20250302    gcc-11
i386                  randconfig-012-20250302    gcc-11
i386                  randconfig-013-20250302    gcc-11
i386                  randconfig-014-20250302    gcc-11
i386                  randconfig-015-20250302    gcc-11
i386                  randconfig-016-20250302    gcc-11
i386                  randconfig-017-20250302    gcc-11
loongarch                        alldefconfig    clang-15
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250301    gcc-14.2.0
loongarch             randconfig-001-20250302    gcc-14.2.0
loongarch             randconfig-002-20250301    gcc-14.2.0
loongarch             randconfig-002-20250302    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250301    gcc-14.2.0
nios2                 randconfig-001-20250302    gcc-14.2.0
nios2                 randconfig-002-20250301    gcc-14.2.0
nios2                 randconfig-002-20250302    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-15
parisc                randconfig-001-20250301    gcc-14.2.0
parisc                randconfig-001-20250302    gcc-14.2.0
parisc                randconfig-002-20250301    gcc-14.2.0
parisc                randconfig-002-20250302    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                 mpc832x_rdb_defconfig    clang-15
powerpc               randconfig-001-20250301    clang-17
powerpc               randconfig-001-20250302    gcc-14.2.0
powerpc               randconfig-002-20250301    clang-19
powerpc               randconfig-002-20250302    gcc-14.2.0
powerpc               randconfig-003-20250301    clang-21
powerpc               randconfig-003-20250302    gcc-14.2.0
powerpc64             randconfig-001-20250301    gcc-14.2.0
powerpc64             randconfig-001-20250302    gcc-14.2.0
powerpc64             randconfig-002-20250301    clang-21
powerpc64             randconfig-003-20250301    gcc-14.2.0
powerpc64             randconfig-003-20250302    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250301    gcc-14.2.0
riscv                 randconfig-001-20250302    gcc-14.2.0
riscv                 randconfig-002-20250301    gcc-14.2.0
riscv                 randconfig-002-20250302    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250301    clang-15
s390                  randconfig-001-20250302    gcc-14.2.0
s390                  randconfig-002-20250301    gcc-14.2.0
s390                  randconfig-002-20250302    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250301    gcc-14.2.0
sh                    randconfig-001-20250302    gcc-14.2.0
sh                    randconfig-002-20250301    gcc-14.2.0
sh                    randconfig-002-20250302    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250301    gcc-14.2.0
sparc                 randconfig-001-20250302    gcc-14.2.0
sparc                 randconfig-002-20250301    gcc-14.2.0
sparc                 randconfig-002-20250302    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250301    gcc-14.2.0
sparc64               randconfig-001-20250302    gcc-14.2.0
sparc64               randconfig-002-20250301    gcc-14.2.0
sparc64               randconfig-002-20250302    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250301    gcc-12
um                    randconfig-001-20250302    gcc-14.2.0
um                    randconfig-002-20250301    gcc-12
um                    randconfig-002-20250302    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250301    clang-19
x86_64      buildonly-randconfig-001-20250302    gcc-12
x86_64      buildonly-randconfig-002-20250301    clang-19
x86_64      buildonly-randconfig-002-20250302    gcc-12
x86_64      buildonly-randconfig-003-20250301    gcc-11
x86_64      buildonly-randconfig-003-20250302    gcc-12
x86_64      buildonly-randconfig-004-20250301    gcc-12
x86_64      buildonly-randconfig-004-20250302    gcc-12
x86_64      buildonly-randconfig-005-20250301    gcc-12
x86_64      buildonly-randconfig-005-20250302    gcc-12
x86_64      buildonly-randconfig-006-20250301    clang-19
x86_64      buildonly-randconfig-006-20250302    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250302    clang-19
x86_64                randconfig-002-20250302    clang-19
x86_64                randconfig-003-20250302    clang-19
x86_64                randconfig-004-20250302    clang-19
x86_64                randconfig-005-20250302    clang-19
x86_64                randconfig-006-20250302    clang-19
x86_64                randconfig-007-20250302    clang-19
x86_64                randconfig-008-20250302    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                          rhel-9.4-func    clang-19
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250301    gcc-14.2.0
xtensa                randconfig-001-20250302    gcc-14.2.0
xtensa                randconfig-002-20250301    gcc-14.2.0
xtensa                randconfig-002-20250302    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

