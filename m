Return-Path: <linux-pci+bounces-37292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AFBAE6FB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 21:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BDD1C1BD6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF232AD0C;
	Tue, 30 Sep 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaFAiz2W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BF1EA65
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260336; cv=none; b=Au4Z/+1KQjsMnwbKIcVJ9VilgNi/+E6Z/oLz2z7WOBoLFavcLt+GH5R3kfbXQIjHKkblgADnlessJzzgPLx3XudHontFEDvuK17OIeUrkSvT+1+y5jz84ZrXWt/WZ56n0gfc7eNt2NBS9A4lObjybKHlzO0PJ2QzPu5y3nnOWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260336; c=relaxed/simple;
	bh=nZ5OC6h+7LYMx91DBi0GwhdOe0Ft3O6sHFT1f6fg6EY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qxxEm806LpmS1vh0U7H1YYMvLYJUFCWQsEaF51AtiGq7hJWLBcgTiQIIzOsg8JDgaDqyx8XCKJDm7LB8arRPIEfa5qquZT5ivMol/1hwjCfVxWo3DRMt4c7Iehk/owfCYNc86Qcocr0YRUX3Xmo7n/t0g0RnSEL55fo3yvBBDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaFAiz2W; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759260334; x=1790796334;
  h=date:from:to:cc:subject:message-id;
  bh=nZ5OC6h+7LYMx91DBi0GwhdOe0Ft3O6sHFT1f6fg6EY=;
  b=YaFAiz2W4YT/cAoo9DztazkUNBOD0JWyj3zONqpwlv4ymOj25JvnNocg
   Q3otPY+a6QV59AIcm/8RwaOZMErEAf2myYgQXGMAgjmZjIgsfO8y+rlAW
   CwC4K1L1Pl/BHau3dVXWoL6qLTc+mHIsguuCd55WGhPWrD1G57aHsGDgG
   shgNKTvLLowY9CuzCqCr7NWfZK2QDum93Uha7/+8hK8u62adhq8YeEGEo
   mfQyz+PFi03En9j67xIAalokq8fZMyg/wKrfFoO9ZqJulu0l+2LtjmzKi
   3lB4UOTtafONMBDhMZQwdnAk7M5gO1EPH6LDQSqcZyPdoc51O1UUujkP1
   g==;
X-CSE-ConnectionGUID: MyRCsISUTm2T/onGVtFytw==
X-CSE-MsgGUID: LoCdljcMSa6cCkL0WN9DFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61440870"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61440870"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 12:25:33 -0700
X-CSE-ConnectionGUID: D5U1UtkmTuCyT+xGDDTD4Q==
X-CSE-MsgGUID: ejN9ocA+SfiCkrMYM1C3fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="177722176"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Sep 2025 12:25:32 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3fyb-0002Qp-34;
	Tue, 30 Sep 2025 19:25:29 +0000
Date: Wed, 01 Oct 2025 03:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx-nwl] BUILD SUCCESS
 98a4f5b7359205ced1b6a626df3963bf7c5e5052
Message-ID: <202510010356.Qt8m0Bl3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx-nwl
branch HEAD: 98a4f5b7359205ced1b6a626df3963bf7c5e5052  PCI: xilinx-nwl: Fix ECAM programming

elapsed time: 1265m

configs tested: 243
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250930    gcc-10.5.0
arc                   randconfig-001-20250930    gcc-9.5.0
arc                   randconfig-002-20250930    gcc-10.5.0
arc                   randconfig-002-20250930    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                         orion5x_defconfig    gcc-15.1.0
arm                   randconfig-001-20250930    gcc-10.5.0
arm                   randconfig-001-20250930    gcc-13.4.0
arm                   randconfig-002-20250930    gcc-10.5.0
arm                   randconfig-002-20250930    gcc-8.5.0
arm                   randconfig-003-20250930    gcc-10.5.0
arm                   randconfig-003-20250930    gcc-8.5.0
arm                   randconfig-004-20250930    gcc-10.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm                          sp7021_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250930    clang-18
arm64                 randconfig-001-20250930    gcc-10.5.0
arm64                 randconfig-002-20250930    clang-22
arm64                 randconfig-002-20250930    gcc-10.5.0
arm64                 randconfig-003-20250930    clang-18
arm64                 randconfig-003-20250930    gcc-10.5.0
arm64                 randconfig-004-20250930    gcc-10.5.0
arm64                 randconfig-004-20250930    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250930    gcc-13.4.0
csky                  randconfig-001-20250930    gcc-8.5.0
csky                  randconfig-002-20250930    gcc-13.4.0
csky                  randconfig-002-20250930    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250930    clang-22
hexagon               randconfig-001-20250930    gcc-8.5.0
hexagon               randconfig-002-20250930    clang-22
hexagon               randconfig-002-20250930    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250930    clang-20
i386        buildonly-randconfig-001-20250930    gcc-12
i386        buildonly-randconfig-002-20250930    clang-20
i386        buildonly-randconfig-002-20250930    gcc-14
i386        buildonly-randconfig-003-20250930    clang-20
i386        buildonly-randconfig-004-20250930    clang-20
i386        buildonly-randconfig-004-20250930    gcc-14
i386        buildonly-randconfig-005-20250930    clang-20
i386        buildonly-randconfig-006-20250930    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250930    gcc-14
i386                  randconfig-002-20250930    gcc-14
i386                  randconfig-003-20250930    gcc-14
i386                  randconfig-004-20250930    gcc-14
i386                  randconfig-005-20250930    gcc-14
i386                  randconfig-006-20250930    gcc-14
i386                  randconfig-007-20250930    gcc-14
i386                  randconfig-011-20250930    gcc-14
i386                  randconfig-012-20250930    gcc-14
i386                  randconfig-013-20250930    gcc-14
i386                  randconfig-014-20250930    gcc-14
i386                  randconfig-015-20250930    gcc-14
i386                  randconfig-016-20250930    gcc-14
i386                  randconfig-017-20250930    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    gcc-15.1.0
loongarch             randconfig-001-20250930    clang-22
loongarch             randconfig-001-20250930    gcc-8.5.0
loongarch             randconfig-002-20250930    clang-22
loongarch             randconfig-002-20250930    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250930    gcc-8.5.0
nios2                 randconfig-002-20250930    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250930    gcc-12.5.0
parisc                randconfig-001-20250930    gcc-8.5.0
parisc                randconfig-002-20250930    gcc-8.5.0
parisc                randconfig-002-20250930    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    gcc-15.1.0
powerpc                       eiger_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250930    gcc-8.5.0
powerpc               randconfig-002-20250930    gcc-14.3.0
powerpc               randconfig-002-20250930    gcc-8.5.0
powerpc               randconfig-003-20250930    gcc-15.1.0
powerpc               randconfig-003-20250930    gcc-8.5.0
powerpc64             randconfig-001-20250930    gcc-14.3.0
powerpc64             randconfig-001-20250930    gcc-8.5.0
powerpc64             randconfig-002-20250930    gcc-12.5.0
powerpc64             randconfig-002-20250930    gcc-8.5.0
powerpc64             randconfig-003-20250930    gcc-11.5.0
powerpc64             randconfig-003-20250930    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250930    gcc-10.5.0
riscv                 randconfig-001-20250930    gcc-12
riscv                 randconfig-002-20250930    clang-22
riscv                 randconfig-002-20250930    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250930    gcc-12
s390                  randconfig-001-20250930    gcc-12.5.0
s390                  randconfig-002-20250930    clang-22
s390                  randconfig-002-20250930    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20250930    gcc-12
sh                    randconfig-001-20250930    gcc-15.1.0
sh                    randconfig-002-20250930    gcc-12
sh                    randconfig-002-20250930    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250930    gcc-11.5.0
sparc                 randconfig-001-20250930    gcc-12
sparc                 randconfig-002-20250930    gcc-12
sparc                 randconfig-002-20250930    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250930    clang-22
sparc64               randconfig-001-20250930    gcc-12
sparc64               randconfig-002-20250930    gcc-12
sparc64               randconfig-002-20250930    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250930    gcc-12
um                    randconfig-001-20250930    gcc-14
um                    randconfig-002-20250930    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250930    clang-20
x86_64      buildonly-randconfig-001-20250930    gcc-14
x86_64      buildonly-randconfig-002-20250930    gcc-14
x86_64      buildonly-randconfig-003-20250930    gcc-14
x86_64      buildonly-randconfig-004-20250930    clang-20
x86_64      buildonly-randconfig-004-20250930    gcc-14
x86_64      buildonly-randconfig-005-20250930    gcc-14
x86_64      buildonly-randconfig-006-20250930    clang-20
x86_64      buildonly-randconfig-006-20250930    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250930    clang-20
x86_64                randconfig-002-20250930    clang-20
x86_64                randconfig-003-20250930    clang-20
x86_64                randconfig-004-20250930    clang-20
x86_64                randconfig-005-20250930    clang-20
x86_64                randconfig-006-20250930    clang-20
x86_64                randconfig-007-20250930    clang-20
x86_64                randconfig-008-20250930    clang-20
x86_64                randconfig-071-20250930    gcc-12
x86_64                randconfig-072-20250930    gcc-12
x86_64                randconfig-073-20250930    gcc-12
x86_64                randconfig-074-20250930    gcc-12
x86_64                randconfig-075-20250930    gcc-12
x86_64                randconfig-076-20250930    gcc-12
x86_64                randconfig-077-20250930    gcc-12
x86_64                randconfig-078-20250930    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250930    gcc-12
xtensa                randconfig-001-20250930    gcc-12.5.0
xtensa                randconfig-002-20250930    gcc-11.5.0
xtensa                randconfig-002-20250930    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

