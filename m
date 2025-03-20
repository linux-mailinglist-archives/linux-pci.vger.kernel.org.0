Return-Path: <linux-pci+bounces-24195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2641CA69E68
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D807A929D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 02:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5F2AE74;
	Thu, 20 Mar 2025 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEIAIShK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D712F5E
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438544; cv=none; b=XjLqeDN4OSpRBXPNkz1sBXi/5A7wgMZfw96tQ9zyHxqL1QD3DnrvgMlCxTL4a/3Fz2K2j02vUW+ieMlZTwcIFEKSonCnuNAruvJMzU+bKWtc3Jd1EMAXkGa3/tQT0YGZ9vy740+3TGr7dTVmaguB6p6G6bw1YCfVa+kyeR26HnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438544; c=relaxed/simple;
	bh=04jpUzaWIt7U3MrlwrIw7jZXnCVq6iVPymZU+UAlu3g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qV/EzmJNEErylnOlMwgTIeauk+GNpHTGKW9HiBB50/OUbarFMYGqSHzUgWIGg/x8MLMirkQZRFkolg2+10NpJ9MaesJucq82vLbFPYyJzPc/gRq7+ePdTiS7XTxH78jcekHeI/AnN8XcnkV8yvjc8+jztY8/N/XKW2hu/UF2Tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEIAIShK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742438543; x=1773974543;
  h=date:from:to:cc:subject:message-id;
  bh=04jpUzaWIt7U3MrlwrIw7jZXnCVq6iVPymZU+UAlu3g=;
  b=AEIAIShKmBWe66giN+TS0u+/9bZCK5qKRHZk5vjyvKdYdt5yLHOPrEil
   jWYQHnmIQdTLjexraKvuYQ9/WTRXayMxpky1AlAY5+hNQwtA/sEpCHQiC
   FFhHY2rSPv+KLSCie77ZeXmaxwWtHe/Cg29IhucgETSKcCWKKzIdbyExh
   oQfy3WMKVZ8SxfpYJBFXkZl/8FLr6vBJRNNsRdp1AmmpBW6KHbVVMRBMC
   VXTYfe2LIzJ8+LYimGPcdXk+nZil/1zpcW7Mdg+lXsx/91UFTIuBpduCT
   3KlRG8brStWd2PTUMOsHKKh5f1/a8ClDWEL5ahGl3pRcZSQoUIBHVIvx1
   g==;
X-CSE-ConnectionGUID: OpoVXyI/QV6bov6kia5lNQ==
X-CSE-MsgGUID: KHOjvc05Rv6u9x5bJJ4ULg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="69009604"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="69009604"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 19:42:22 -0700
X-CSE-ConnectionGUID: SP3taEr/R+mc9XexSteXag==
X-CSE-MsgGUID: N7QWws5hSMaZxQp40m3Q5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122906461"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 19 Mar 2025 19:42:21 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv5rL-00008Q-21;
	Thu, 20 Mar 2025 02:42:16 +0000
Date: Thu, 20 Mar 2025 10:42:09 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 18056a48669a040bef491e63b25896561ee14d90
Message-ID: <202503201003.ibZ9EonC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: 18056a48669a040bef491e63b25896561ee14d90  PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type

elapsed time: 1442m

configs tested: 252
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-6.5.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.3.0
arc                               allnoconfig    gcc-8.5.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-10.5.0
arc                   randconfig-001-20250319    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-6.5.0
arc                   randconfig-002-20250319    gcc-14.2.0
arc                   randconfig-002-20250320    gcc-6.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-13.3.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-6.5.0
arm                         bcm2835_defconfig    gcc-10.5.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250319    clang-18
arm                   randconfig-001-20250320    gcc-6.5.0
arm                   randconfig-002-20250319    clang-21
arm                   randconfig-002-20250320    gcc-6.5.0
arm                   randconfig-003-20250319    clang-20
arm                   randconfig-003-20250320    gcc-6.5.0
arm                   randconfig-004-20250319    clang-16
arm                   randconfig-004-20250320    gcc-6.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-13.3.0
arm64                             allnoconfig    gcc-8.5.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250319    gcc-7.5.0
arm64                 randconfig-001-20250320    gcc-6.5.0
arm64                 randconfig-002-20250319    gcc-7.5.0
arm64                 randconfig-002-20250320    gcc-6.5.0
arm64                 randconfig-003-20250319    gcc-7.5.0
arm64                 randconfig-003-20250320    gcc-6.5.0
arm64                 randconfig-004-20250319    gcc-7.5.0
arm64                 randconfig-004-20250320    gcc-6.5.0
csky                              allnoconfig    gcc-13.3.0
csky                              allnoconfig    gcc-9.3.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250319    gcc-9.3.0
csky                  randconfig-001-20250320    gcc-12.4.0
csky                  randconfig-002-20250319    gcc-14.2.0
csky                  randconfig-002-20250320    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-13.3.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250319    clang-21
hexagon               randconfig-001-20250320    gcc-12.4.0
hexagon               randconfig-002-20250319    clang-16
hexagon               randconfig-002-20250320    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250319    gcc-12
i386        buildonly-randconfig-002-20250319    gcc-12
i386        buildonly-randconfig-003-20250319    gcc-12
i386        buildonly-randconfig-004-20250319    clang-20
i386        buildonly-randconfig-005-20250319    gcc-12
i386        buildonly-randconfig-006-20250319    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250320    clang-20
i386                  randconfig-002-20250320    clang-20
i386                  randconfig-003-20250320    clang-20
i386                  randconfig-004-20250320    clang-20
i386                  randconfig-005-20250320    clang-20
i386                  randconfig-006-20250320    clang-20
i386                  randconfig-007-20250320    clang-20
i386                  randconfig-011-20250320    gcc-12
i386                  randconfig-012-20250320    gcc-12
i386                  randconfig-013-20250320    gcc-12
i386                  randconfig-014-20250320    gcc-12
i386                  randconfig-015-20250320    gcc-12
i386                  randconfig-016-20250320    gcc-12
i386                  randconfig-017-20250320    gcc-12
loongarch                        allmodconfig    gcc-12.4.0
loongarch                         allnoconfig    gcc-13.3.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250319    gcc-14.2.0
loongarch             randconfig-001-20250320    gcc-12.4.0
loongarch             randconfig-002-20250319    gcc-14.2.0
loongarch             randconfig-002-20250320    gcc-12.4.0
m68k                             allmodconfig    gcc-12.4.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-12.4.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-12.4.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-12.4.0
microblaze                       allyesconfig    gcc-9.3.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-10.5.0
mips                    maltaup_xpa_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-10.5.0
nios2                             allnoconfig    gcc-8.5.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250319    gcc-11.5.0
nios2                 randconfig-001-20250320    gcc-12.4.0
nios2                 randconfig-002-20250319    gcc-5.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-10.5.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250319    gcc-10.5.0
parisc                randconfig-001-20250320    gcc-12.4.0
parisc                randconfig-002-20250319    gcc-10.5.0
parisc                randconfig-002-20250320    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     powernv_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250319    gcc-9.3.0
powerpc               randconfig-001-20250320    gcc-12.4.0
powerpc               randconfig-002-20250319    clang-21
powerpc               randconfig-002-20250320    gcc-12.4.0
powerpc               randconfig-003-20250319    clang-21
powerpc               randconfig-003-20250320    gcc-12.4.0
powerpc64             randconfig-001-20250319    clang-20
powerpc64             randconfig-001-20250320    gcc-12.4.0
powerpc64             randconfig-002-20250319    gcc-5.5.0
powerpc64             randconfig-002-20250320    gcc-12.4.0
powerpc64             randconfig-003-20250319    clang-21
powerpc64             randconfig-003-20250320    gcc-12.4.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250319    clang-20
riscv                 randconfig-001-20250320    gcc-9.3.0
riscv                 randconfig-002-20250319    clang-17
riscv                 randconfig-002-20250320    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-9.3.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-8.5.0
s390                             allyesconfig    gcc-9.3.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250319    gcc-6.5.0
s390                  randconfig-001-20250320    gcc-9.3.0
s390                  randconfig-002-20250319    gcc-8.5.0
s390                  randconfig-002-20250320    gcc-9.3.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-7.5.0
sh                               allyesconfig    gcc-9.3.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-10.5.0
sh                    randconfig-001-20250319    gcc-11.5.0
sh                    randconfig-001-20250320    gcc-9.3.0
sh                    randconfig-002-20250319    gcc-5.5.0
sh                    randconfig-002-20250320    gcc-9.3.0
sh                            shmin_defconfig    gcc-10.5.0
sh                            titan_defconfig    gcc-10.5.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                            allmodconfig    gcc-9.3.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250319    gcc-6.5.0
sparc                 randconfig-001-20250320    gcc-9.3.0
sparc                 randconfig-002-20250319    gcc-8.5.0
sparc                 randconfig-002-20250320    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250319    gcc-8.5.0
sparc64               randconfig-001-20250320    gcc-9.3.0
sparc64               randconfig-002-20250319    gcc-6.5.0
sparc64               randconfig-002-20250320    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250319    gcc-12
um                    randconfig-001-20250320    gcc-9.3.0
um                    randconfig-002-20250319    gcc-11
um                    randconfig-002-20250320    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250319    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-002-20250319    clang-20
x86_64      buildonly-randconfig-002-20250320    clang-20
x86_64      buildonly-randconfig-003-20250319    gcc-12
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-004-20250319    gcc-11
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-005-20250319    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-006-20250319    clang-20
x86_64      buildonly-randconfig-006-20250320    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250320    clang-20
x86_64                randconfig-002-20250320    clang-20
x86_64                randconfig-003-20250320    clang-20
x86_64                randconfig-004-20250320    clang-20
x86_64                randconfig-005-20250320    clang-20
x86_64                randconfig-006-20250320    clang-20
x86_64                randconfig-007-20250320    clang-20
x86_64                randconfig-008-20250320    clang-20
x86_64                randconfig-071-20250320    gcc-12
x86_64                randconfig-072-20250320    gcc-12
x86_64                randconfig-073-20250320    gcc-12
x86_64                randconfig-074-20250320    gcc-12
x86_64                randconfig-075-20250320    gcc-12
x86_64                randconfig-076-20250320    gcc-12
x86_64                randconfig-077-20250320    gcc-12
x86_64                randconfig-078-20250320    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-10.5.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250319    gcc-10.5.0
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-002-20250319    gcc-12.4.0
xtensa                randconfig-002-20250320    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

