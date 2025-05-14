Return-Path: <linux-pci+bounces-27665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA4AB6080
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 03:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966A119E47FE
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 01:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955835959;
	Wed, 14 May 2025 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AddfoH3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ECB17C98
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747186772; cv=none; b=aKreX3F4jZA402PNZtOdpTth4QOCHGeTzmlaqI9VhlQaf3Ru/nQ36+mTwjZXftk1dtCHotCLFx5dvW2t2YFxatUlv9hdjce3ueabZzJ8h4NLqMOeWuFuwH9DaSiAaY5v0DKjwdSsVhuMk2k+bhgxW/mfz7ZB5llJCeQ2ttwOvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747186772; c=relaxed/simple;
	bh=QLAEcFMYa+jMKIx9vp04GHcbBwXvHQtBQz+hwmQsETs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=byDE78NI9Wdb4FtjGsSErxRZMmGyzflYYINkEq+2tG/Z9wQ7lkNtakrF2JJHNPrJbhL8pRkEe8mULvPpnke7Zo9jGObl3nMVdNo+DXXjy8YmFf/eh1mUXHPhuu1SGwSxlnYQR0O1gKVUAt44UDkkGTi3oH33vJhu7V0GHCSZzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AddfoH3d; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747186770; x=1778722770;
  h=date:from:to:cc:subject:message-id;
  bh=QLAEcFMYa+jMKIx9vp04GHcbBwXvHQtBQz+hwmQsETs=;
  b=AddfoH3dZzJusR6ofubQfT0S+bGPdpRVs/n/0TjMC2OKQcxXfCwclgR6
   slS8YmJa7rZITjDT+UThSDVXFxlPZO66o3hGuQBVWtRT03h/ZxrjBY5CE
   oGU8I4ZuYqNbQoy1+Oz/3iVtI893n+/1ICpJw3m8mqPSs6o40GBpHJfcJ
   fhGXnEabuteHTEv+A2KAf8RNPHMwqL+Dv7GRm0QQ14zLXDfvSa839vkMK
   IigtYgVMv/wR9VKfkQ/wtD7b0+xip8zHK7+jRR0qU7FSNSPP2h7sVA2mk
   KD/KB3uBtPSO5m3lIhjTNwoG7hcnc6iHQMwkOzmrtVinjDBs/Z/hQQpcw
   w==;
X-CSE-ConnectionGUID: D0Tf3BVCSEuBEbrJqTx2bA==
X-CSE-MsgGUID: gfPXLyMgRQ6ho9mFEVOm9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59289570"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="59289570"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 18:39:30 -0700
X-CSE-ConnectionGUID: IhVmTIruRs+eSb7gr5yvLA==
X-CSE-MsgGUID: SCn6QCxUQN+/WdeWhfxPgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="137754978"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 May 2025 18:39:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uF15h-000GZf-21;
	Wed, 14 May 2025 01:39:25 +0000
Date: Wed, 14 May 2025 09:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dw-rockchip] BUILD SUCCESS
 1a176b25f5d6f00c6c44729c006379b9a6dbc703
Message-ID: <202505140925.VYfOjL9F-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dw-rockchip
branch HEAD: 1a176b25f5d6f00c6c44729c006379b9a6dbc703  PCI: cadence: Simplify J721e link status check

elapsed time: 922m

configs tested: 235
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250513    gcc-14.2.0
arc                   randconfig-001-20250514    clang-21
arc                   randconfig-002-20250513    gcc-14.2.0
arc                   randconfig-002-20250514    clang-21
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-21
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250513    gcc-7.5.0
arm                   randconfig-001-20250514    clang-21
arm                   randconfig-002-20250513    gcc-8.5.0
arm                   randconfig-002-20250514    clang-21
arm                   randconfig-003-20250513    gcc-8.5.0
arm                   randconfig-003-20250514    clang-21
arm                   randconfig-004-20250513    clang-16
arm                   randconfig-004-20250514    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250513    clang-21
arm64                 randconfig-001-20250514    clang-21
arm64                 randconfig-002-20250513    clang-21
arm64                 randconfig-002-20250514    clang-21
arm64                 randconfig-003-20250513    gcc-6.5.0
arm64                 randconfig-003-20250514    clang-21
arm64                 randconfig-004-20250513    clang-21
arm64                 randconfig-004-20250514    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250513    gcc-14.2.0
csky                  randconfig-001-20250514    gcc-10.5.0
csky                  randconfig-002-20250513    gcc-12.4.0
csky                  randconfig-002-20250514    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250513    clang-21
hexagon               randconfig-001-20250514    gcc-10.5.0
hexagon               randconfig-002-20250513    clang-21
hexagon               randconfig-002-20250514    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250513    clang-20
i386        buildonly-randconfig-001-20250514    clang-20
i386        buildonly-randconfig-002-20250513    clang-20
i386        buildonly-randconfig-002-20250514    clang-20
i386        buildonly-randconfig-003-20250513    clang-20
i386        buildonly-randconfig-003-20250514    clang-20
i386        buildonly-randconfig-004-20250513    clang-20
i386        buildonly-randconfig-004-20250514    clang-20
i386        buildonly-randconfig-005-20250513    gcc-12
i386        buildonly-randconfig-005-20250514    clang-20
i386        buildonly-randconfig-006-20250513    gcc-12
i386        buildonly-randconfig-006-20250514    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250514    clang-20
i386                  randconfig-002-20250514    clang-20
i386                  randconfig-003-20250514    clang-20
i386                  randconfig-004-20250514    clang-20
i386                  randconfig-005-20250514    clang-20
i386                  randconfig-006-20250514    clang-20
i386                  randconfig-007-20250514    clang-20
i386                  randconfig-011-20250514    clang-20
i386                  randconfig-012-20250514    clang-20
i386                  randconfig-013-20250514    clang-20
i386                  randconfig-014-20250514    clang-20
i386                  randconfig-015-20250514    clang-20
i386                  randconfig-016-20250514    clang-20
i386                  randconfig-017-20250514    clang-20
loongarch                        alldefconfig    clang-21
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250513    gcc-14.2.0
loongarch             randconfig-001-20250514    gcc-10.5.0
loongarch             randconfig-002-20250513    gcc-14.2.0
loongarch             randconfig-002-20250514    gcc-10.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    clang-21
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    clang-21
mips                          eyeq5_defconfig    clang-21
mips                          eyeq6_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250513    gcc-10.5.0
nios2                 randconfig-001-20250514    gcc-10.5.0
nios2                 randconfig-002-20250513    gcc-12.4.0
nios2                 randconfig-002-20250514    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250513    gcc-11.5.0
parisc                randconfig-001-20250514    gcc-10.5.0
parisc                randconfig-002-20250513    gcc-11.5.0
parisc                randconfig-002-20250514    gcc-10.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250513    clang-21
powerpc               randconfig-001-20250514    gcc-10.5.0
powerpc               randconfig-002-20250513    gcc-8.5.0
powerpc               randconfig-002-20250514    gcc-10.5.0
powerpc               randconfig-003-20250513    clang-21
powerpc               randconfig-003-20250514    gcc-10.5.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250513    clang-21
powerpc64             randconfig-001-20250514    gcc-10.5.0
powerpc64             randconfig-002-20250514    gcc-10.5.0
powerpc64             randconfig-003-20250513    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250513    gcc-14.2.0
riscv                 randconfig-001-20250514    clang-21
riscv                 randconfig-002-20250513    gcc-14.2.0
riscv                 randconfig-002-20250514    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250513    clang-21
s390                  randconfig-001-20250514    clang-21
s390                  randconfig-002-20250513    gcc-9.3.0
s390                  randconfig-002-20250514    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250513    gcc-12.4.0
sh                    randconfig-001-20250514    clang-21
sh                    randconfig-002-20250513    gcc-14.2.0
sh                    randconfig-002-20250514    clang-21
sh                          sdk7786_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250513    gcc-11.5.0
sparc                 randconfig-001-20250514    clang-21
sparc                 randconfig-002-20250513    gcc-13.3.0
sparc                 randconfig-002-20250514    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250513    gcc-11.5.0
sparc64               randconfig-001-20250514    clang-21
sparc64               randconfig-002-20250513    gcc-13.3.0
sparc64               randconfig-002-20250514    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250513    clang-19
um                    randconfig-001-20250514    clang-21
um                    randconfig-002-20250513    gcc-12
um                    randconfig-002-20250514    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250513    gcc-12
x86_64      buildonly-randconfig-001-20250514    gcc-12
x86_64      buildonly-randconfig-002-20250513    gcc-12
x86_64      buildonly-randconfig-002-20250514    gcc-12
x86_64      buildonly-randconfig-003-20250513    clang-20
x86_64      buildonly-randconfig-003-20250514    gcc-12
x86_64      buildonly-randconfig-004-20250513    gcc-12
x86_64      buildonly-randconfig-004-20250514    gcc-12
x86_64      buildonly-randconfig-005-20250513    clang-20
x86_64      buildonly-randconfig-005-20250514    gcc-12
x86_64      buildonly-randconfig-006-20250513    gcc-12
x86_64      buildonly-randconfig-006-20250514    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250514    gcc-12
x86_64                randconfig-002-20250514    gcc-12
x86_64                randconfig-003-20250514    gcc-12
x86_64                randconfig-004-20250514    gcc-12
x86_64                randconfig-005-20250514    gcc-12
x86_64                randconfig-006-20250514    gcc-12
x86_64                randconfig-007-20250514    gcc-12
x86_64                randconfig-008-20250514    gcc-12
x86_64                randconfig-071-20250514    clang-20
x86_64                randconfig-072-20250514    clang-20
x86_64                randconfig-073-20250514    clang-20
x86_64                randconfig-074-20250514    clang-20
x86_64                randconfig-075-20250514    clang-20
x86_64                randconfig-076-20250514    clang-20
x86_64                randconfig-077-20250514    clang-20
x86_64                randconfig-078-20250514    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250513    gcc-7.5.0
xtensa                randconfig-001-20250514    clang-21
xtensa                randconfig-002-20250513    gcc-14.2.0
xtensa                randconfig-002-20250514    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

