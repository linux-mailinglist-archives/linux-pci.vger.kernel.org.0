Return-Path: <linux-pci+bounces-12137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A495D5FB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 21:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4577B2235B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401B18592E;
	Fri, 23 Aug 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUwXpyWv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D88F6B
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440721; cv=none; b=Q+cDjpWZ//eFO2D6/J+4nOCDL+jDgSv7cEfCJLBo5vvmOcLVBHFL88T6hpaw/kw/63xg3r1C3jCW67hwuhoycHeO1ONcFF5DrWfB6Tfd98JUpLiVP/PkEYCFqV0HUoYd3q+Bp3bdBXu0bQr/J9aaSY6yQu5MpNWLi0qrrYc9xoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440721; c=relaxed/simple;
	bh=eezO9eOgAyNsuRcweMJfcBIpNi9J1OT+MOb6N+Wwf54=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fbc8KzGJZkhX/LXtpwJXhCwFEd0HKqWfgCcDqmVElnUL9bqq1L40FK4JxSyIkffr2RfgEfsuwR1iEk2/Vq0bICXrA/OUx/BOBCbvYBHAikJ4WrfWLykL//rLtzP+zFa4KKNLoWZWRbVx586x+eb+c/U2BowKHLYnVTadlM0W3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUwXpyWv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724440720; x=1755976720;
  h=date:from:to:cc:subject:message-id;
  bh=eezO9eOgAyNsuRcweMJfcBIpNi9J1OT+MOb6N+Wwf54=;
  b=aUwXpyWvwakBiQDUNDN0v4cSaT5OuFSTq1bFMVJCHqKF/28UCYMJiVWB
   TbJcCf5EHCaLyx6AUVKaSf6xVJDTQrB8e0HVeV3ECoWw61wVMWC7i+wGo
   i8pJ9CeRtj/8qo2rHKyjp6PEdiQEe7hbEZjAhwd5870yNg0GlsSitWYAh
   79/yYD8TeaN0oVlL3sKA+UbBJA9TKmY/3QrdNBiHvU455sZOf083upM+Y
   Eb3mypSX27u+p+PRPiYrXfFBw4bGbs+zafTnGQiW1oCpTgBpHualJL5Bs
   YI1/72mPv8BVVCpgg35fc2bziiMWc9ruIuRbHjI2Wr+fKbuR2x1cm7UlF
   Q==;
X-CSE-ConnectionGUID: 0yoeYi3bQ2qDPKYv4o/PPw==
X-CSE-MsgGUID: ceuhttuWQweDtiZ9yRsGuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23094746"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="23094746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:18:39 -0700
X-CSE-ConnectionGUID: zw73w1r4Q6WiBI5SJeeR7g==
X-CSE-MsgGUID: 6IG1PlJSTzuq1C8U6arQ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61904304"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Aug 2024 12:18:38 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shZnv-000DyE-2p;
	Fri, 23 Aug 2024 19:18:35 +0000
Date: Sat, 24 Aug 2024 03:17:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx] BUILD SUCCESS
 308a40fb8fd9cfb1aa7d44f79980dfaef1a6c72f
Message-ID: <202408240354.VyloEn65-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx
branch HEAD: 308a40fb8fd9cfb1aa7d44f79980dfaef1a6c72f  PCI: xilinx-nwl: Add PHY support

elapsed time: 1459m

configs tested: 190
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240823   gcc-13.2.0
arc                   randconfig-002-20240823   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         axm55xx_defconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                         lpc32xx_defconfig   gcc-13.2.0
arm                          pxa3xx_defconfig   gcc-13.2.0
arm                   randconfig-001-20240823   gcc-13.2.0
arm                   randconfig-002-20240823   gcc-13.2.0
arm                   randconfig-003-20240823   gcc-13.2.0
arm                   randconfig-004-20240823   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                        vexpress_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240823   gcc-13.2.0
arm64                 randconfig-002-20240823   gcc-13.2.0
arm64                 randconfig-003-20240823   gcc-13.2.0
arm64                 randconfig-004-20240823   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240823   gcc-13.2.0
csky                  randconfig-002-20240823   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240823   clang-18
i386         buildonly-randconfig-002-20240823   clang-18
i386         buildonly-randconfig-003-20240823   clang-18
i386         buildonly-randconfig-004-20240823   clang-18
i386         buildonly-randconfig-005-20240823   clang-18
i386         buildonly-randconfig-006-20240823   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240823   clang-18
i386                  randconfig-002-20240823   clang-18
i386                  randconfig-003-20240823   clang-18
i386                  randconfig-004-20240823   clang-18
i386                  randconfig-005-20240823   clang-18
i386                  randconfig-006-20240823   clang-18
i386                  randconfig-011-20240823   clang-18
i386                  randconfig-012-20240823   clang-18
i386                  randconfig-013-20240823   clang-18
i386                  randconfig-014-20240823   clang-18
i386                  randconfig-015-20240823   clang-18
i386                  randconfig-016-20240823   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240823   gcc-13.2.0
loongarch             randconfig-002-20240823   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           ip32_defconfig   gcc-13.2.0
mips                     loongson2k_defconfig   gcc-13.2.0
mips                        vocore2_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240823   gcc-13.2.0
nios2                 randconfig-002-20240823   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240823   gcc-13.2.0
parisc                randconfig-002-20240823   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                      mgcoge_defconfig   gcc-13.2.0
powerpc                     mpc512x_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240823   gcc-13.2.0
powerpc               randconfig-002-20240823   gcc-13.2.0
powerpc                     skiroot_defconfig   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                     taishan_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240823   gcc-13.2.0
powerpc64             randconfig-002-20240823   gcc-13.2.0
powerpc64             randconfig-003-20240823   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240823   gcc-13.2.0
riscv                 randconfig-002-20240823   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240823   gcc-13.2.0
s390                  randconfig-002-20240823   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240823   gcc-13.2.0
sh                    randconfig-002-20240823   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7721_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240823   gcc-13.2.0
sparc64               randconfig-002-20240823   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240823   gcc-13.2.0
um                    randconfig-002-20240823   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240823   gcc-12
x86_64       buildonly-randconfig-002-20240823   gcc-12
x86_64       buildonly-randconfig-003-20240823   gcc-12
x86_64       buildonly-randconfig-004-20240823   gcc-12
x86_64       buildonly-randconfig-005-20240823   gcc-12
x86_64       buildonly-randconfig-006-20240823   gcc-12
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240823   gcc-12
x86_64                randconfig-002-20240823   gcc-12
x86_64                randconfig-003-20240823   gcc-12
x86_64                randconfig-004-20240823   gcc-12
x86_64                randconfig-005-20240823   gcc-12
x86_64                randconfig-006-20240823   gcc-12
x86_64                randconfig-011-20240823   gcc-12
x86_64                randconfig-012-20240823   gcc-12
x86_64                randconfig-013-20240823   gcc-12
x86_64                randconfig-014-20240823   gcc-12
x86_64                randconfig-015-20240823   gcc-12
x86_64                randconfig-016-20240823   gcc-12
x86_64                randconfig-071-20240823   gcc-12
x86_64                randconfig-072-20240823   gcc-12
x86_64                randconfig-073-20240823   gcc-12
x86_64                randconfig-074-20240823   gcc-12
x86_64                randconfig-075-20240823   gcc-12
x86_64                randconfig-076-20240823   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240823   gcc-13.2.0
xtensa                randconfig-002-20240823   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

