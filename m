Return-Path: <linux-pci+bounces-26372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD7A9650C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F66A189CB1C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D5202960;
	Tue, 22 Apr 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klTtDHR6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3A19D8B7
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315534; cv=none; b=gbiZ+j2X7yRx/7DKFv/0gX3j2ZTnImqII+okvpPsR3ygnHo7Ynys8wYl/ix1MBwIR/h3kNHKHfiOwOFF3t3pnqVyI+NGSZyn50XWNuWrMlDFDeLm60Eq/a78JHeI4aSTxhqz+vrja1aBf8gMzer0GUYeXzndlR5Z3Hr2B/eoo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315534; c=relaxed/simple;
	bh=dtMONYdXIN3xiVQ7F4B5W6i/8V3rXJLEkted2OwGiB8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZV6uwSTaM51UzfrumFlUzxdPZ/eWE9/JMNRNyCCDEz6i50mVNDSJkMXZvj7i5q11dwibWF7mA2+l/xWHiOIZxGXS4MSO3Ae7khwJ/Yl+BAwmX5alzYT5/5LK+UVCizaVkBq1oNXWYCgjHMFkH+CPLtn4yZ+tA/x1r4FpT/SGyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klTtDHR6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745315532; x=1776851532;
  h=date:from:to:cc:subject:message-id;
  bh=dtMONYdXIN3xiVQ7F4B5W6i/8V3rXJLEkted2OwGiB8=;
  b=klTtDHR6NVGHyLSdz9WebOiLcD83qQqn7V+sswtAmyWbmQWlZP/DO0ta
   Bn+GiglLvG80JfiFjd4WYOXTJ+uJ2da1EVJmcxklkbfTE1Q8iv4eDxm00
   bGemnI5kgqMCvp9OE1bntkN11N8IkoMUEOrbVvxEIAD5l3OWN8C94osXn
   NzHCm0XMxQyfcNt0D3YzVeTH0h8awzfakpeFTXJsckCLAviXtJUPqlqyK
   QYXg4BKQ2mKSS8tX6PjXbR5hYhsU/ZMRBA7gBc9S862AVe3CEcXn7NYbv
   uGK6TuSgnuVVqnfXPtoplBMvg8omEOv7HD2YUQLNuKaqZJctkzwwsMwv2
   g==;
X-CSE-ConnectionGUID: 2W4NdmsfR5mdYXGhEYn4OA==
X-CSE-MsgGUID: ERl4nvc6Q7unEnSNFgLpGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="64395607"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="64395607"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 02:52:12 -0700
X-CSE-ConnectionGUID: ShjEe3IOTpKZdz1uQP13tw==
X-CSE-MsgGUID: jsy16XeASV+aT3DDJ17jTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="136841531"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Apr 2025 02:52:11 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7AIS-0000ol-0M;
	Tue, 22 Apr 2025 09:52:08 +0000
Date: Tue, 22 Apr 2025 17:51:58 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 7a68d4ab59fa66ebbd9b8abdbffcaf748e109ad7
Message-ID: <202504221748.VJRvQTtl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 7a68d4ab59fa66ebbd9b8abdbffcaf748e109ad7  PCI: j721e: Add support to build as a loadable module

elapsed time: 1456m

configs tested: 230
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250421    gcc-11.5.0
arc                   randconfig-002-20250421    gcc-13.3.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                        clps711x_defconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    clang-21
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250421    clang-21
arm                   randconfig-002-20250421    gcc-10.5.0
arm                   randconfig-003-20250421    gcc-6.5.0
arm                   randconfig-004-20250421    gcc-6.5.0
arm                        realview_defconfig    clang-16
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250421    gcc-5.5.0
arm64                 randconfig-002-20250421    gcc-7.5.0
arm64                 randconfig-003-20250421    gcc-9.5.0
arm64                 randconfig-004-20250421    clang-16
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250421    gcc-14.2.0
csky                  randconfig-002-20250421    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250421    clang-16
hexagon               randconfig-002-20250421    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250421    clang-20
i386        buildonly-randconfig-002-20250421    clang-20
i386        buildonly-randconfig-003-20250421    clang-20
i386        buildonly-randconfig-004-20250421    gcc-12
i386        buildonly-randconfig-005-20250421    gcc-12
i386        buildonly-randconfig-006-20250421    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250422    gcc-12
i386                  randconfig-002-20250422    gcc-12
i386                  randconfig-003-20250422    gcc-12
i386                  randconfig-004-20250422    gcc-12
i386                  randconfig-005-20250422    gcc-12
i386                  randconfig-006-20250422    gcc-12
i386                  randconfig-007-20250422    gcc-12
i386                  randconfig-011-20250422    clang-20
i386                  randconfig-012-20250422    clang-20
i386                  randconfig-013-20250422    clang-20
i386                  randconfig-014-20250422    clang-20
i386                  randconfig-015-20250422    clang-20
i386                  randconfig-016-20250422    clang-20
i386                  randconfig-017-20250422    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250421    gcc-14.2.0
loongarch             randconfig-002-20250421    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250421    gcc-9.3.0
nios2                 randconfig-002-20250421    gcc-13.3.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250421    gcc-6.5.0
parisc                randconfig-002-20250421    gcc-8.5.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc                  mpc885_ads_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250421    clang-21
powerpc               randconfig-002-20250421    clang-21
powerpc               randconfig-003-20250421    clang-21
powerpc                     redwood_defconfig    clang-21
powerpc64                        alldefconfig    gcc-14.2.0
powerpc64             randconfig-001-20250421    gcc-10.5.0
powerpc64             randconfig-002-20250421    clang-21
powerpc64             randconfig-003-20250421    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250421    gcc-14.2.0
riscv                 randconfig-002-20250421    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250421    clang-21
s390                  randconfig-002-20250421    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250421    gcc-11.5.0
sh                    randconfig-002-20250421    gcc-7.5.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250421    gcc-10.3.0
sparc                 randconfig-002-20250421    gcc-8.5.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250421    gcc-12.4.0
sparc64               randconfig-002-20250421    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250421    gcc-12
um                    randconfig-002-20250421    clang-16
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250421    gcc-12
x86_64      buildonly-randconfig-002-20250421    clang-20
x86_64      buildonly-randconfig-003-20250421    gcc-12
x86_64      buildonly-randconfig-004-20250421    gcc-12
x86_64      buildonly-randconfig-005-20250421    gcc-12
x86_64      buildonly-randconfig-006-20250421    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250422    clang-20
x86_64                randconfig-002-20250422    clang-20
x86_64                randconfig-003-20250422    clang-20
x86_64                randconfig-004-20250422    clang-20
x86_64                randconfig-005-20250422    clang-20
x86_64                randconfig-006-20250422    clang-20
x86_64                randconfig-007-20250422    clang-20
x86_64                randconfig-008-20250422    clang-20
x86_64                randconfig-071-20250422    gcc-12
x86_64                randconfig-072-20250422    gcc-12
x86_64                randconfig-073-20250422    gcc-12
x86_64                randconfig-074-20250422    gcc-12
x86_64                randconfig-075-20250422    gcc-12
x86_64                randconfig-076-20250422    gcc-12
x86_64                randconfig-077-20250422    gcc-12
x86_64                randconfig-078-20250422    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250421    gcc-6.5.0
xtensa                randconfig-002-20250421    gcc-6.5.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

