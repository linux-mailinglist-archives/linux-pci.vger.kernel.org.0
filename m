Return-Path: <linux-pci+bounces-28433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42DAC45B7
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 02:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0971E1890D94
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 00:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AF1DFCE;
	Tue, 27 May 2025 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtdUueUD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F32F43
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748306523; cv=none; b=e0gKs29auHYp2Ob46lamCyPmNJCkAPyPeNo9DtVT3YMPVn63Cu1jig3xlxYcmm8vPNqvrGJpbSOKYFcJyntP0ZKaEz3FgbJxr3eiCX+o8vUHH/Vupbd7wMUzi3bAVaYALdmSb06PHnfG+E8QkQD4/T4IpKTtFi1ySC+y3/3Teu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748306523; c=relaxed/simple;
	bh=IKBXPrJk050VSs/7ikjf2SgESi7p/sxDw47aJYjY3Oo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QKG62s6FaliuExohcbIYZWD3GIwYMAnrFhV1TKWPAdu6d7TwC4zJqcAtWBAhngOrJCr57hJ+8rpwu9yKehymcUTPE+TV1sjwmlY1gkzVGQ6gbGsa5poE+OjJEQ94EEi+J0FrkGUMj6FKCLndsbceNJCcyq9G1FhSr4AfJzXNpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtdUueUD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748306522; x=1779842522;
  h=date:from:to:cc:subject:message-id;
  bh=IKBXPrJk050VSs/7ikjf2SgESi7p/sxDw47aJYjY3Oo=;
  b=WtdUueUDxzpBjmqBpRcJ7xVpXiIhgTrQEGU2y9dteysnk8UV0mbVMW1x
   kg/4aizvfVL4p6wpGNX3b4zdE/gUiShvTcNjiTr9zkOr5FthGHnv/vOYA
   6igYLKqiBZ0JBr0CjWd9AAAd4mlGmPRdX+b5BU/LNnRAVMTTdLeHO3VBV
   9hUKk82TSRUVfcxN0d8dBKCUV6rJqH47cd6h92Sd6NZRnz278v0Dl9Rwb
   P/7iWauEYIi0A8xXbYIqQLVhLNmjBhp65NsTTdz1Res98tNmcIKsifh5G
   YZKprTAWsA4UcLCvdzUJbzZJaonH8LvhlF930QEM1fbAZzX2KHIiSoqQa
   Q==;
X-CSE-ConnectionGUID: /L6prD/VSvuA0IJvVKvuxA==
X-CSE-MsgGUID: /ykfTBBYSLy7Bwho1ef1dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50163166"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="50163166"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 17:42:01 -0700
X-CSE-ConnectionGUID: YOK7bbiKQO2ioxQ8XKDZgw==
X-CSE-MsgGUID: 1gcImiSxReaRDpVZgAKgUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="147454204"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 May 2025 17:42:00 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJiOE-000Slr-1R;
	Tue, 27 May 2025 00:41:58 +0000
Date: Tue, 27 May 2025 08:41:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dw-rockchip] BUILD SUCCESS
 d3d0c2012576be2194c518bcf51c0481510e6137
Message-ID: <202505270822.DiurI4cm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dw-rockchip
branch HEAD: d3d0c2012576be2194c518bcf51c0481510e6137  PCI: qcom: Replace PERST sleep time with proper macro

elapsed time: 734m

configs tested: 129
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250526    gcc-15.1.0
arc                   randconfig-002-20250526    gcc-15.1.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20250526    gcc-6.5.0
arm                   randconfig-002-20250526    clang-21
arm                   randconfig-003-20250526    gcc-7.5.0
arm                   randconfig-004-20250526    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250526    clang-21
arm64                 randconfig-002-20250526    clang-19
arm64                 randconfig-003-20250526    clang-20
arm64                 randconfig-004-20250526    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250526    gcc-9.3.0
csky                  randconfig-002-20250526    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250526    clang-19
hexagon               randconfig-002-20250526    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250526    gcc-12
i386        buildonly-randconfig-002-20250526    clang-20
i386        buildonly-randconfig-003-20250526    clang-20
i386        buildonly-randconfig-004-20250526    gcc-12
i386        buildonly-randconfig-005-20250526    clang-20
i386        buildonly-randconfig-006-20250526    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250526    gcc-15.1.0
loongarch             randconfig-002-20250526    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250526    gcc-5.5.0
nios2                 randconfig-002-20250526    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250526    gcc-6.5.0
parisc                randconfig-002-20250526    gcc-8.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                       ebony_defconfig    clang-21
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250526    clang-21
powerpc               randconfig-002-20250526    clang-18
powerpc               randconfig-003-20250526    clang-21
powerpc64             randconfig-001-20250526    gcc-7.5.0
powerpc64             randconfig-002-20250526    gcc-7.5.0
powerpc64             randconfig-003-20250526    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250526    clang-21
riscv                 randconfig-002-20250526    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250526    clang-18
s390                  randconfig-002-20250526    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250526    gcc-11.5.0
sh                    randconfig-002-20250526    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250526    gcc-14.2.0
sparc                 randconfig-002-20250526    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250526    gcc-14.2.0
sparc64               randconfig-002-20250526    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250526    clang-21
um                    randconfig-002-20250526    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250526    gcc-12
x86_64      buildonly-randconfig-002-20250526    gcc-12
x86_64      buildonly-randconfig-004-20250526    gcc-12
x86_64      buildonly-randconfig-005-20250526    gcc-12
x86_64      buildonly-randconfig-006-20250526    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250526    gcc-12.4.0
xtensa                randconfig-002-20250526    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

