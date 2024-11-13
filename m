Return-Path: <linux-pci+bounces-16685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88FA9C7A74
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 18:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707791F28C16
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF420262E;
	Wed, 13 Nov 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMtR7P/e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F5202651
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520631; cv=none; b=FThEiLZBJOs156gO9vgNPfUcENkw8+VfXo2TZx9i916Ec3RE8gFPIY7vPR7/aSMoOv2r+Z7/J5irVEakrVrW4tvcAnsqkiqOrHaPn0yTR0IW20IrF+65oiSXsUZIb0T3fIdn/OT5PxTchrtye366tzw9FASAbbbJHjXHdA80OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520631; c=relaxed/simple;
	bh=Rbt5SSfyDOFINcxZTAI3jp3w30dDdv0Rw6iDGGHewog=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JMNH0sp0Brk4od8qOxK45jN3MAGVbuCOfz9PdJdpdHTfMBPoQqmemU5iiZsKdQ0005bJYp2kRWI6PPOe/3slWujMHxrL80Yb+x1ZAg0v4PtnP9UvBlbbqa9uFYoBfFa4B51QEtuUruzc4HaHONLDynmbqTboffPU1YiT66XHgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMtR7P/e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731520630; x=1763056630;
  h=date:from:to:cc:subject:message-id;
  bh=Rbt5SSfyDOFINcxZTAI3jp3w30dDdv0Rw6iDGGHewog=;
  b=VMtR7P/exnfU/iOconatqTpaMbkPz/X55kaFZ5JTHxtiNWmV69eA8Fri
   1c9qIlozs+U1zwKN8Jfc+47YZlU0PUzBnUVDXzjfGYHLaHLFRX2SxejxN
   AGW82f8Dh0tPEhY0Ucpc+5YVbxX8q2/Eo3dSKpXERY44wr9zxX62pgwX0
   COXXwGJJvnbSEkaHc9p7IPgIT6xktB1EQjT2SM1xxGOqKYCH9fWMGA/fO
   7nhduU7pdL/2LtuKDF3IZxa7SF31a6GnpRQGJrMzaSaxOl5PuVQxVPC/M
   6dLVAaequk0Sn5BUMzx43z+xMb/RKKr79aSYmRl4PNpecDBOJtzgUfDbU
   Q==;
X-CSE-ConnectionGUID: tsGaG7HzSvC+TxLk2keR6Q==
X-CSE-MsgGUID: PHg4+YU5SfaU3/mRCKzFkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42040723"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42040723"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 09:57:08 -0800
X-CSE-ConnectionGUID: K/2CV9WdSbiESqWMyXV1fQ==
X-CSE-MsgGUID: DXDTmfuOSPKLML2B3hjFhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92897579"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2024 09:57:06 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBHbz-0000bJ-1Y;
	Wed, 13 Nov 2024 17:57:03 +0000
Date: Thu, 14 Nov 2024 01:56:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 750af79f55c2925f333021d19d0addf831e076ab
Message-ID: <202411140139.XA5CymYb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: 750af79f55c2925f333021d19d0addf831e076ab  PCI: Warn if a running device is unaware of reset

elapsed time: 1057m

configs tested: 184
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                        spear3xx_defconfig    clang-20
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    clang-20
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    clang-19
i386        buildonly-randconfig-005-20241113    clang-19
i386        buildonly-randconfig-006-20241113    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    clang-19
i386                  randconfig-002-20241113    clang-19
i386                  randconfig-003-20241113    clang-19
i386                  randconfig-004-20241113    clang-19
i386                  randconfig-005-20241113    clang-19
i386                  randconfig-006-20241113    clang-19
i386                  randconfig-011-20241113    clang-19
i386                  randconfig-012-20241113    clang-19
i386                  randconfig-013-20241113    clang-19
i386                  randconfig-014-20241113    clang-19
i386                  randconfig-015-20241113    clang-19
i386                  randconfig-016-20241113    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                            gpr_defconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-20
mips                       rbtx49xx_defconfig    gcc-14.2.0
mips                         rt305x_defconfig    clang-20
mips                   sb1250_swarm_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                       maple_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    gcc-14.2.0
powerpc                     redwood_defconfig    clang-20
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv                    nommu_virt_defconfig    gcc-14.2.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-20
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241113    clang-19
x86_64      buildonly-randconfig-002-20241113    clang-19
x86_64      buildonly-randconfig-003-20241113    clang-19
x86_64      buildonly-randconfig-004-20241113    clang-19
x86_64      buildonly-randconfig-005-20241113    clang-19
x86_64      buildonly-randconfig-006-20241113    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241113    clang-19
x86_64                randconfig-002-20241113    clang-19
x86_64                randconfig-003-20241113    clang-19
x86_64                randconfig-004-20241113    clang-19
x86_64                randconfig-005-20241113    clang-19
x86_64                randconfig-006-20241113    clang-19
x86_64                randconfig-011-20241113    clang-19
x86_64                randconfig-012-20241113    clang-19
x86_64                randconfig-013-20241113    clang-19
x86_64                randconfig-014-20241113    clang-19
x86_64                randconfig-015-20241113    clang-19
x86_64                randconfig-016-20241113    clang-19
x86_64                randconfig-071-20241113    clang-19
x86_64                randconfig-072-20241113    clang-19
x86_64                randconfig-073-20241113    clang-19
x86_64                randconfig-074-20241113    clang-19
x86_64                randconfig-075-20241113    clang-19
x86_64                randconfig-076-20241113    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

