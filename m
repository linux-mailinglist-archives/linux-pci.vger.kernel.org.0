Return-Path: <linux-pci+bounces-19931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADEFA130B4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3651888B34
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D366136;
	Thu, 16 Jan 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRpCbkf2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742D5CB8
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990574; cv=none; b=Rf6cI1EREYSEgCs3W4OyYw1A08q+Nex/M+FBfd+opd9FwhkNb6KjvEjwwA0dfdl1WOStJwm0UHGj5hg2+fl+UnHTCDR1lY4Luw57I+4WoxA2VlvbInnUTDoWQBzuAHCIT63wEZAcybiplT4Tr9Bzw8rGF0fd8YK4/DWPjkuO3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990574; c=relaxed/simple;
	bh=OI4LhVGDvQhnBYBLgJsKPjBlN2kZc2pSUxCryymkGkI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dpvVuDPFxbXnf3wGpxouYhBff/ZJFAHJTtx/15uQrqoHGH1guquQlIY90NcxnI+AIY7V/A92tsD/43O4gXIhyZnn6T0QTajGRM/i/I/NUK42Nkr1VtYm0vFR5BolldxaamI2yeHMS6nm33a994dAwbbZ2NalcKLF51RDDPs4Q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRpCbkf2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736990573; x=1768526573;
  h=date:from:to:cc:subject:message-id;
  bh=OI4LhVGDvQhnBYBLgJsKPjBlN2kZc2pSUxCryymkGkI=;
  b=dRpCbkf2hgYrWc/S8Ha1r3bwu+0fIqXezCSIHopFysL6bI3dbLpAlrh8
   RmB5fHLZSdc023vOFhs6YTrjghvo3DQ1Gz6QPXzSRY08dYzNur7bhDBRM
   6ij/Vc8AtsLnUZaphGu+EdM5GXpqQV7d9l/WOgyZg5IC5Xst7EfS+cci6
   D58JUPTWFcD6r+Nbfr97hmczY2zx6eS//V8hxppduRa9UMcfLqXDaGKPJ
   64x3B/XqjB9WTc5Ku1+jNBO2tJonFr2iJ2WoxqMC35wfo1uvW7ifvOE1u
   abcoHG4qFyQRuxDP1VekAcQePssTf5eY7gdsADaRZ+990RdstzORywEUC
   w==;
X-CSE-ConnectionGUID: YJTsKQDcTIOjEV5fIqMx1g==
X-CSE-MsgGUID: u9+OOkwYRFeNGWtLR0482w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48766745"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48766745"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 17:22:52 -0800
X-CSE-ConnectionGUID: TbupLgdNQeawnmpzAYE9og==
X-CSE-MsgGUID: hJsGB1zLRciHyXxKr0D3FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="105132124"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jan 2025 17:22:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYEav-000R5d-1H;
	Thu, 16 Jan 2025 01:22:49 +0000
Date: Thu, 16 Jan 2025 09:22:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:err] BUILD SUCCESS
 b7f71e6e758a63f9d1911e299489eea6361bfbb9
Message-ID: <202501160912.qLKnQxpk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git err
branch HEAD: b7f71e6e758a63f9d1911e299489eea6361bfbb9  PCI: Add pcie_print_tlp_log() to print TLP Header and Prefix Log

elapsed time: 1462m

configs tested: 214
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250115    gcc-13.2.0
arc                   randconfig-001-20250116    clang-15
arc                   randconfig-002-20250115    gcc-13.2.0
arc                   randconfig-002-20250116    clang-15
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250115    clang-16
arm                   randconfig-001-20250116    clang-15
arm                   randconfig-002-20250115    clang-20
arm                   randconfig-002-20250116    clang-15
arm                   randconfig-003-20250115    clang-20
arm                   randconfig-003-20250116    clang-15
arm                   randconfig-004-20250115    clang-20
arm                   randconfig-004-20250116    clang-15
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250115    clang-20
arm64                 randconfig-001-20250116    clang-15
arm64                 randconfig-002-20250115    gcc-14.2.0
arm64                 randconfig-002-20250116    clang-15
arm64                 randconfig-003-20250115    clang-18
arm64                 randconfig-003-20250116    clang-15
arm64                 randconfig-004-20250115    gcc-14.2.0
arm64                 randconfig-004-20250116    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250115    gcc-14.2.0
csky                  randconfig-001-20250116    clang-20
csky                  randconfig-002-20250115    gcc-14.2.0
csky                  randconfig-002-20250116    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250115    clang-20
hexagon               randconfig-001-20250116    clang-20
hexagon               randconfig-002-20250115    clang-19
hexagon               randconfig-002-20250116    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250115    clang-19
i386        buildonly-randconfig-001-20250116    clang-19
i386        buildonly-randconfig-002-20250115    gcc-12
i386        buildonly-randconfig-002-20250116    clang-19
i386        buildonly-randconfig-003-20250115    gcc-12
i386        buildonly-randconfig-003-20250116    clang-19
i386        buildonly-randconfig-004-20250115    gcc-12
i386        buildonly-randconfig-004-20250116    clang-19
i386        buildonly-randconfig-005-20250115    gcc-12
i386        buildonly-randconfig-005-20250116    clang-19
i386        buildonly-randconfig-006-20250115    gcc-12
i386        buildonly-randconfig-006-20250116    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250116    clang-19
i386                  randconfig-002-20250116    clang-19
i386                  randconfig-003-20250116    clang-19
i386                  randconfig-004-20250116    clang-19
i386                  randconfig-005-20250116    clang-19
i386                  randconfig-006-20250116    clang-19
i386                  randconfig-007-20250116    clang-19
i386                  randconfig-011-20250116    gcc-12
i386                  randconfig-012-20250116    gcc-12
i386                  randconfig-013-20250116    gcc-12
i386                  randconfig-014-20250116    gcc-12
i386                  randconfig-015-20250116    gcc-12
i386                  randconfig-016-20250116    gcc-12
i386                  randconfig-017-20250116    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250115    gcc-14.2.0
loongarch             randconfig-001-20250116    clang-20
loongarch             randconfig-002-20250115    gcc-14.2.0
loongarch             randconfig-002-20250116    clang-20
m68k                              allnoconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250115    gcc-14.2.0
nios2                 randconfig-001-20250116    clang-20
nios2                 randconfig-002-20250115    gcc-14.2.0
nios2                 randconfig-002-20250116    clang-20
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250115    gcc-14.2.0
parisc                randconfig-001-20250116    clang-20
parisc                randconfig-002-20250115    gcc-14.2.0
parisc                randconfig-002-20250116    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                 linkstation_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250115    gcc-14.2.0
powerpc               randconfig-001-20250116    clang-20
powerpc               randconfig-002-20250115    gcc-14.2.0
powerpc               randconfig-002-20250116    clang-20
powerpc               randconfig-003-20250115    gcc-14.2.0
powerpc               randconfig-003-20250116    clang-20
powerpc64             randconfig-001-20250115    gcc-14.2.0
powerpc64             randconfig-001-20250116    clang-20
powerpc64             randconfig-002-20250115    gcc-14.2.0
powerpc64             randconfig-002-20250116    clang-20
powerpc64             randconfig-003-20250115    clang-18
powerpc64             randconfig-003-20250116    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250115    gcc-14.2.0
riscv                 randconfig-001-20250116    gcc-14.2.0
riscv                 randconfig-002-20250115    clang-16
riscv                 randconfig-002-20250116    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250115    clang-20
s390                  randconfig-001-20250116    gcc-14.2.0
s390                  randconfig-002-20250115    clang-15
s390                  randconfig-002-20250116    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250115    gcc-14.2.0
sh                    randconfig-001-20250116    gcc-14.2.0
sh                    randconfig-002-20250115    gcc-14.2.0
sh                    randconfig-002-20250116    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250115    gcc-14.2.0
sparc                 randconfig-001-20250116    gcc-14.2.0
sparc                 randconfig-002-20250115    gcc-14.2.0
sparc                 randconfig-002-20250116    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250115    gcc-14.2.0
sparc64               randconfig-001-20250116    gcc-14.2.0
sparc64               randconfig-002-20250115    gcc-14.2.0
sparc64               randconfig-002-20250116    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250115    clang-18
um                    randconfig-001-20250116    gcc-14.2.0
um                    randconfig-002-20250115    gcc-12
um                    randconfig-002-20250116    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250115    gcc-12
x86_64      buildonly-randconfig-001-20250116    gcc-12
x86_64      buildonly-randconfig-002-20250115    gcc-12
x86_64      buildonly-randconfig-002-20250116    gcc-12
x86_64      buildonly-randconfig-003-20250115    clang-19
x86_64      buildonly-randconfig-003-20250116    gcc-12
x86_64      buildonly-randconfig-004-20250115    clang-19
x86_64      buildonly-randconfig-004-20250116    gcc-12
x86_64      buildonly-randconfig-005-20250115    gcc-12
x86_64      buildonly-randconfig-005-20250116    gcc-12
x86_64      buildonly-randconfig-006-20250115    clang-19
x86_64      buildonly-randconfig-006-20250116    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250116    gcc-12
x86_64                randconfig-002-20250116    gcc-12
x86_64                randconfig-003-20250116    gcc-12
x86_64                randconfig-004-20250116    gcc-12
x86_64                randconfig-005-20250116    gcc-12
x86_64                randconfig-006-20250116    gcc-12
x86_64                randconfig-007-20250116    gcc-12
x86_64                randconfig-008-20250116    gcc-12
x86_64                randconfig-071-20250116    gcc-12
x86_64                randconfig-072-20250116    gcc-12
x86_64                randconfig-073-20250116    gcc-12
x86_64                randconfig-074-20250116    gcc-12
x86_64                randconfig-075-20250116    gcc-12
x86_64                randconfig-076-20250116    gcc-12
x86_64                randconfig-077-20250116    gcc-12
x86_64                randconfig-078-20250116    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250115    gcc-14.2.0
xtensa                randconfig-001-20250116    gcc-14.2.0
xtensa                randconfig-002-20250115    gcc-14.2.0
xtensa                randconfig-002-20250116    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

