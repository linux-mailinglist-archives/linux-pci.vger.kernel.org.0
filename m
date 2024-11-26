Return-Path: <linux-pci+bounces-17351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64F9D98A8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49211162C5A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005638BEA;
	Tue, 26 Nov 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQ/6lplx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AACB652
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628289; cv=none; b=Rl+2BpE7BVqA34F8O363JzCDGgK+nNocnTVQq2NDffEO0ePRqvHjUavvYkWtTnIorueb+O+itbqXdCn4CMtfxHWuWHKKC9Gr0XgcM5xEsEFYoNhdBW+3PcjKXFtefENZ3VI8kuxM4mZL6x3p2PrY27yfAL6omgb3eybiPoNNwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628289; c=relaxed/simple;
	bh=PB1F93ZazvqpK4AKyKJXsdXzq1MG8y7/zpath6/j4u0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LLIbO4xUZ15VMhrbWRnamLjye4ZkvVw3m0c/T48p2cY+cj13S2YcNnDgFDqjyI+eTtUlTmfTCHqY6iONIFl+3HNy7yZDJYdJZ3COBW3Olr01kfjhkW0vgOfdijLHwjZJSpUS2yPGZCqo/G7Wke2KH6hqE2PsVOxVPz75HR/XKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQ/6lplx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732628289; x=1764164289;
  h=date:from:to:cc:subject:message-id;
  bh=PB1F93ZazvqpK4AKyKJXsdXzq1MG8y7/zpath6/j4u0=;
  b=jQ/6lplxleJpv6p1x+d/9ds00ZiV90u2IS+KrOzGn3RjlZkDmfsGLcvD
   lVC5tmSHPSzH1N2g8yb2YnraWNBz8UInzxh1UPKLeIntKGAYSg3uJsgJk
   nt34tzmnZp730wU5SbWez3vjfaftdytidvzPw6P2siDysEqUC9vU0SvEM
   +hDrzR0c6B8vtLazdWIojNV/a6K9BLDdKHySif9254aNZJNSAMr7iuoYy
   hF5nPRTskhH/FKCd4a/B+49qRXTHbrs+Q1FeTxviztwhfFUHkoFtc/ZNo
   6xxpt5WjQdDFY6Lhtly+sVEHn6igD3Aa3AaIWK3RJap+5efSfPLON8W22
   g==;
X-CSE-ConnectionGUID: VVLZfhGXRLO1c9xHsFq73Q==
X-CSE-MsgGUID: BYBLI8ipRz+HUkkxLLYEsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="50313350"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="50313350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:38:08 -0800
X-CSE-ConnectionGUID: shs/T5RrSp+cKWy97xD8UA==
X-CSE-MsgGUID: GKiyNI41QTyvDzdurLyFew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91235055"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2024 05:38:07 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFvlU-0007JN-1F;
	Tue, 26 Nov 2024 13:38:04 +0000
Date: Tue, 26 Nov 2024 21:36:08 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 10099266dec8275a6899e6a27dcdfebbcc726cc7
Message-ID: <202411262157.MKO4PV0R-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 10099266dec8275a6899e6a27dcdfebbcc726cc7  Merge branch 'pci/typos'

elapsed time: 1054m

configs tested: 135
configs skipped: 18

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
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20241126    gcc-13.2.0
arc                   randconfig-002-20241126    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-13.2.0
arm                          ep93xx_defconfig    clang-14
arm                       multi_v4t_defconfig    gcc-13.2.0
arm                        mvebu_v5_defconfig    gcc-13.2.0
arm                             pxa_defconfig    clang-14
arm                   randconfig-001-20241126    clang-20
arm                   randconfig-002-20241126    gcc-14.2.0
arm                   randconfig-003-20241126    clang-20
arm                   randconfig-004-20241126    clang-16
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241126    gcc-14.2.0
arm64                 randconfig-002-20241126    gcc-14.2.0
arm64                 randconfig-003-20241126    gcc-14.2.0
arm64                 randconfig-004-20241126    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241126    gcc-14.2.0
csky                  randconfig-002-20241126    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241126    clang-17
hexagon               randconfig-002-20241126    clang-20
i386        buildonly-randconfig-001-20241126    gcc-12
i386        buildonly-randconfig-002-20241126    gcc-12
i386        buildonly-randconfig-003-20241126    clang-19
i386        buildonly-randconfig-003-20241126    gcc-12
i386        buildonly-randconfig-004-20241126    gcc-12
i386        buildonly-randconfig-005-20241126    clang-19
i386        buildonly-randconfig-005-20241126    gcc-12
i386        buildonly-randconfig-006-20241126    gcc-12
i386                  randconfig-001-20241126    gcc-12
i386                  randconfig-002-20241126    gcc-12
i386                  randconfig-003-20241126    gcc-12
i386                  randconfig-004-20241126    gcc-11
i386                  randconfig-004-20241126    gcc-12
i386                  randconfig-005-20241126    clang-19
i386                  randconfig-005-20241126    gcc-12
i386                  randconfig-006-20241126    clang-19
i386                  randconfig-006-20241126    gcc-12
i386                  randconfig-011-20241126    clang-19
i386                  randconfig-011-20241126    gcc-12
i386                  randconfig-012-20241126    clang-19
i386                  randconfig-012-20241126    gcc-12
i386                  randconfig-013-20241126    clang-19
i386                  randconfig-013-20241126    gcc-12
i386                  randconfig-014-20241126    gcc-12
i386                  randconfig-015-20241126    clang-19
i386                  randconfig-015-20241126    gcc-12
i386                  randconfig-016-20241126    clang-19
i386                  randconfig-016-20241126    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241126    gcc-14.2.0
loongarch             randconfig-002-20241126    gcc-14.2.0
m68k                             alldefconfig    clang-14
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-13.2.0
m68k                          sun3x_defconfig    clang-14
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-13.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-14
mips                         db1xxx_defconfig    clang-20
mips                           xway_defconfig    clang-14
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241126    gcc-14.2.0
nios2                 randconfig-002-20241126    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241126    gcc-14.2.0
parisc                randconfig-002-20241126    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-14
powerpc               randconfig-001-20241126    clang-20
powerpc                    socrates_defconfig    gcc-13.2.0
powerpc64             randconfig-001-20241126    clang-16
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-13.2.0
sh                            hp6xx_defconfig    clang-14
sh                          kfr2r09_defconfig    gcc-13.2.0
sh                          landisk_defconfig    gcc-13.2.0
sh                     magicpanelr2_defconfig    gcc-13.2.0
sh                          rsk7203_defconfig    gcc-13.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

