Return-Path: <linux-pci+bounces-21039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A920A2DF23
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2025 17:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1921884B07
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2025 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862A1D934D;
	Sun,  9 Feb 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drVeGRhy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B11DFE29
	for <linux-pci@vger.kernel.org>; Sun,  9 Feb 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739118614; cv=none; b=MHGGe66TAprhV25l/Oc9WwDiThs1cHwM3QS1NjtN8AJN2KTS4nB4znDgmSlCH77MfWFby7b1s+1cYoT99e4HOYR3PBS/Yvthbf8WqHG7lQ+t+DhltUJ/ClV+Y2kN8F1Pr882h4sYLcpxVh/b9nYcfH3zSQn1vWyjt56z0Y3yqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739118614; c=relaxed/simple;
	bh=M647kSIwK1GxVb8c5A5SqeGDEu+b1x07Vpdg2DYN8Ek=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kKQYctWiaMrZFR8JbYcQOmlDPhYBqr0zOV45/b2ugBamsxI6fuhweS8+cpdQD1fywYkSLjHyOAQ5ai0HeS45as35ln9z8MDjLIkPsCLICYlU6f/yrM1nd8bKjvQ9ZZ0D3oVjGP0zpBs4VjaFO4spiJ+vFiCqOFvcr3MucXLE+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drVeGRhy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739118613; x=1770654613;
  h=date:from:to:cc:subject:message-id;
  bh=M647kSIwK1GxVb8c5A5SqeGDEu+b1x07Vpdg2DYN8Ek=;
  b=drVeGRhyzeoFRGoOP2lrq1R+GFEK2hflUcAc5m4MhnBShKzAp6GqQO9s
   BQIzTxHLyKjS3cvm3HV3JEvX13+XRS7/sX51yskO9ehde99MmVrx5n31R
   lRxMrKbpcSZ0+XtVmut4iOhr2Ywf/tZK1eeQI623SHQJ7qq0GnOHulvpB
   /W7H1Mr8+yP2T2tuisnwoPHY5YNYHhI333noKBO/PTv/oYqy+P2T1oDIX
   Q/kSEdXSuGc/Pt5HB4nB0tHRpO12lh4mR75a3z6cAAwHOuxaLZrTbxWrY
   Oexa0cyRWtWVBGfI6Pb6SD85ZTllLe9KxpVz5ZC/hmhXygtczrEtRbsw4
   Q==;
X-CSE-ConnectionGUID: ydsNKw6yR2C7nQBfwI41TQ==
X-CSE-MsgGUID: l/Bq+yjXRRq5upbU/1BwZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="57121699"
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="57121699"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 08:30:12 -0800
X-CSE-ConnectionGUID: mbIv21mRR36hkzE9Nay+0g==
X-CSE-MsgGUID: Jnjy6I2WSsSpQ446t9lDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117190268"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Feb 2025 08:30:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thAC7-0011gn-37;
	Sun, 09 Feb 2025 16:30:07 +0000
Date: Mon, 10 Feb 2025 00:29:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 993847693500a5b6d72de0845d2d511aa70e0a58
Message-ID: <202502100013.XmcYZnDk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 993847693500a5b6d72de0845d2d511aa70e0a58  PCI: Cleanup dev->resource + resno to use pci_resource_n()

elapsed time: 1239m

configs tested: 200
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250209    gcc-13.2.0
arc                   randconfig-002-20250209    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                   randconfig-001-20250209    gcc-14.2.0
arm                   randconfig-002-20250209    clang-21
arm                   randconfig-003-20250209    clang-21
arm                   randconfig-004-20250209    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250209    clang-18
arm64                 randconfig-002-20250209    gcc-14.2.0
arm64                 randconfig-003-20250209    gcc-14.2.0
arm64                 randconfig-004-20250209    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250209    gcc-14.2.0
csky                  randconfig-002-20250209    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250209    clang-21
hexagon               randconfig-002-20250209    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250209    gcc-12
i386        buildonly-randconfig-002-20250209    clang-19
i386        buildonly-randconfig-003-20250209    clang-19
i386        buildonly-randconfig-004-20250209    gcc-12
i386        buildonly-randconfig-005-20250209    clang-19
i386        buildonly-randconfig-006-20250209    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250209    clang-19
i386                  randconfig-002-20250209    clang-19
i386                  randconfig-003-20250209    clang-19
i386                  randconfig-004-20250209    clang-19
i386                  randconfig-005-20250209    clang-19
i386                  randconfig-006-20250209    clang-19
i386                  randconfig-007-20250209    clang-19
i386                  randconfig-011-20250209    clang-19
i386                  randconfig-012-20250209    clang-19
i386                  randconfig-013-20250209    clang-19
i386                  randconfig-014-20250209    clang-19
i386                  randconfig-015-20250209    clang-19
i386                  randconfig-016-20250209    clang-19
i386                  randconfig-017-20250209    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250209    gcc-14.2.0
loongarch             randconfig-002-20250209    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250209    gcc-14.2.0
nios2                 randconfig-002-20250209    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250209    gcc-14.2.0
parisc                randconfig-002-20250209    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250209    gcc-14.2.0
powerpc               randconfig-002-20250209    clang-21
powerpc               randconfig-003-20250209    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250209    gcc-14.2.0
powerpc64             randconfig-002-20250209    gcc-14.2.0
powerpc64             randconfig-003-20250209    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250209    clang-18
riscv                 randconfig-002-20250209    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250209    clang-21
s390                  randconfig-002-20250209    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250209    gcc-14.2.0
sh                    randconfig-002-20250209    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250209    gcc-14.2.0
sparc                 randconfig-002-20250209    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250209    gcc-14.2.0
sparc64               randconfig-002-20250209    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250209    gcc-11
um                    randconfig-002-20250209    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250209    gcc-12
x86_64      buildonly-randconfig-002-20250209    gcc-12
x86_64      buildonly-randconfig-003-20250209    gcc-12
x86_64      buildonly-randconfig-004-20250209    gcc-12
x86_64      buildonly-randconfig-005-20250209    gcc-11
x86_64      buildonly-randconfig-006-20250209    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250209    gcc-12
x86_64                randconfig-002-20250209    gcc-12
x86_64                randconfig-003-20250209    gcc-12
x86_64                randconfig-004-20250209    gcc-12
x86_64                randconfig-005-20250209    gcc-12
x86_64                randconfig-006-20250209    gcc-12
x86_64                randconfig-007-20250209    gcc-12
x86_64                randconfig-008-20250209    gcc-12
x86_64                randconfig-071-20250209    gcc-12
x86_64                randconfig-072-20250209    gcc-12
x86_64                randconfig-073-20250209    gcc-12
x86_64                randconfig-074-20250209    gcc-12
x86_64                randconfig-075-20250209    gcc-12
x86_64                randconfig-076-20250209    gcc-12
x86_64                randconfig-077-20250209    gcc-12
x86_64                randconfig-078-20250209    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250209    gcc-14.2.0
xtensa                randconfig-002-20250209    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

