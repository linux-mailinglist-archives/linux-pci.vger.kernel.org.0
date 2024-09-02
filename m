Return-Path: <linux-pci+bounces-12610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DA9680FC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D726F1C2061C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1F14900E;
	Mon,  2 Sep 2024 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKKj1Twj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC5149C69
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263632; cv=none; b=UQYVR4B/al22ZivCzXB85c5qSPGcUibdfjuYvci6ZaxjbXd5zoiyTaXPgQnIwX9e9UvE5t1s6zhAKJjdrJ73+sVFH0btC0nRQN+SYoR1hqgnnYX/+SNPhPalmI9gKa8uYJd89Tz4IhzIBUslH1A7Ix7aGKO6NsmHljYDlviPKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263632; c=relaxed/simple;
	bh=l09qjR76aGQ8ZUzTJq9VoGicF4GvvxaVw64t+KhJf/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gv4Vtv1VLiehb8Iu3+qmRnTIGHq6dcwYtp3TTKFPuR0MVgKYj89QutKO1XSk7MvbJGhTdPVetgPQyo8TnAqT25E0WLj/PXk6fWdRzgKg30TVY2iT73yb2d09DiVBdax0RDffa/+84SzuO184eyF88RDjjVEU/TzIaFba+tB91sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKKj1Twj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725263630; x=1756799630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l09qjR76aGQ8ZUzTJq9VoGicF4GvvxaVw64t+KhJf/o=;
  b=bKKj1TwjLh1EApb9tG8HqPHSG5uoZWI7TZIqYYwqTxPlHp3iAbSrDquO
   3OX1VNljT8WuV/9vJbd6mOAjzOWSvA0ilzkrQQP6Tm77mn5V4V+Vis45M
   MY1Z/JJim7us077zjkriew/IN37g0Vl+rfpqCAspBPrOiTH4MtWQ6zDL3
   4TIDq9xwfgST1ynEwztSam97lq148Pote/6Y9HiR9o2YqQdLX/H6XuSu3
   kSExyGLDLxotfdeYcMCuv7dnJkKfp6TLG1d3e+M/DBk/OCa+GZFypg90Q
   /JalXq3l2G0y+FeZTx+JMRf/U1pBk82D7SyvWVwt3lh4pSdrRYUDG43r6
   A==;
X-CSE-ConnectionGUID: o2Ap51HlSD6DUozwviqFcw==
X-CSE-MsgGUID: yt+61ujeQP2FEyMG9kUKxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34990350"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34990350"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 00:53:49 -0700
X-CSE-ConnectionGUID: qV/YqcPFQWaaom7+c/0B8A==
X-CSE-MsgGUID: G1O8tf1oQtK8zYD7FF6X/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="101995472"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Sep 2024 00:53:48 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sl1sf-0005Gc-14;
	Mon, 02 Sep 2024 07:53:45 +0000
Date: Mon, 02 Sep 2024 15:53:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 3ee1a6b5d78f07bc026f71ea0664d8df2a7d1280
Message-ID: <202409021506.C8l40rA2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 3ee1a6b5d78f07bc026f71ea0664d8df2a7d1280  PCI/AER: Use PCI_DEVID() macro in aer_inject()

elapsed time: 845m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                          axs103_defconfig   gcc-14.1.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-14.1.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g4_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240902   clang-18
i386         buildonly-randconfig-002-20240902   clang-18
i386         buildonly-randconfig-003-20240902   clang-18
i386         buildonly-randconfig-004-20240902   clang-18
i386         buildonly-randconfig-005-20240902   clang-18
i386         buildonly-randconfig-006-20240902   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240902   clang-18
i386                  randconfig-002-20240902   clang-18
i386                  randconfig-003-20240902   clang-18
i386                  randconfig-004-20240902   clang-18
i386                  randconfig-005-20240902   clang-18
i386                  randconfig-006-20240902   clang-18
i386                  randconfig-011-20240902   clang-18
i386                  randconfig-012-20240902   clang-18
i386                  randconfig-013-20240902   clang-18
i386                  randconfig-014-20240902   clang-18
i386                  randconfig-015-20240902   clang-18
i386                  randconfig-016-20240902   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5208evb_defconfig   gcc-14.1.0
m68k                       m5249evb_defconfig   gcc-14.1.0
m68k                            q40_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   gcc-14.1.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-13.2.0
mips                           mtx1_defconfig   gcc-14.1.0
mips                        omega2p_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-14.1.0
nios2                         3c120_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc                     powernv_defconfig   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-14.1.0
powerpc                     stx_gp3_defconfig   gcc-14.1.0
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-14.1.0
powerpc                      tqm8xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                            migor_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
sh                  sh7785lcr_32bit_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               alldefconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240902   clang-18
x86_64       buildonly-randconfig-002-20240902   clang-18
x86_64       buildonly-randconfig-003-20240902   clang-18
x86_64       buildonly-randconfig-004-20240902   clang-18
x86_64       buildonly-randconfig-005-20240902   clang-18
x86_64       buildonly-randconfig-006-20240902   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240902   clang-18
x86_64                randconfig-002-20240902   clang-18
x86_64                randconfig-003-20240902   clang-18
x86_64                randconfig-004-20240902   clang-18
x86_64                randconfig-005-20240902   clang-18
x86_64                randconfig-006-20240902   clang-18
x86_64                randconfig-011-20240902   clang-18
x86_64                randconfig-012-20240902   clang-18
x86_64                randconfig-013-20240902   clang-18
x86_64                randconfig-014-20240902   clang-18
x86_64                randconfig-015-20240902   clang-18
x86_64                randconfig-016-20240902   clang-18
x86_64                randconfig-071-20240902   clang-18
x86_64                randconfig-072-20240902   clang-18
x86_64                randconfig-073-20240902   clang-18
x86_64                randconfig-074-20240902   clang-18
x86_64                randconfig-075-20240902   clang-18
x86_64                randconfig-076-20240902   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0
xtensa                    xip_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

