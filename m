Return-Path: <linux-pci+bounces-11214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5903946622
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 01:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A19F28347C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F5D49658;
	Fri,  2 Aug 2024 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlpK5k5e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D9139D10
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641294; cv=none; b=omxbQge7nEfSdS2MH4/PadWJkmj3STf1tNU8xiOXh/WBsTn3Iv2pyKgWmK53h9syOzFbGDfCjlPvvJGrCHuSWqRHIHEQ2vdAhtRlIddMsU50xFFA6U1PQKKWvQW+7chsV3bDgnAFAwzuqLpc09vTFDEYqCyQLdIGkgDTjTJQH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641294; c=relaxed/simple;
	bh=H4gNVisFqRhurLleR7YsKMiIq2/kAZD+VV1bj3VII2A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fWswf8DMxpVphYs1OV7ZDfdmQ1JB1Q8Un/fzBSW95U2NKSXkAb+yE3LeYKTJiHg0QQHStfNxc3dsS0wblHAiRVinwLnDEZzuZn4V0KGSvwuOuPiYkF1+ATGvEsL9RlT39h1FdKEp0bxxpQC7awF9yF3J9ClpOLYcv8iaShQoKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlpK5k5e; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722641293; x=1754177293;
  h=date:from:to:cc:subject:message-id;
  bh=H4gNVisFqRhurLleR7YsKMiIq2/kAZD+VV1bj3VII2A=;
  b=AlpK5k5ey/ZTuebpBkL8DpjhrZvxaJ7GeyvXN+Nbxo/z5x4bL1EY5iqY
   /OpP1HWzCtyuEhm/3TWsliqiro/4Rr9HWiVGr1gCteEuBHORME5N/mH9m
   lY7OJJWSoWneyGC/3Du5DzFQRFCzOe+cBR1vPrbwsHXOVVPmSH+VdAnGe
   /+Mvmuvo/Ma28pA6crphnzZiEufBmEAGR8lqETJBQbjwdPmyw/FhKLpV6
   WLoZOs4tH/zASiY6FC1VCtBLP12k9ixIbxULT3tXQdQSYy/Rc4F+bxGxF
   aU+qAKQwVOFPbp5B3X0Il8H/Qp9KD7hVPfmdvZgm3+mdETENdsDC9srNH
   Q==;
X-CSE-ConnectionGUID: 5Vpdwo7LRziYZx0WCmrl+A==
X-CSE-MsgGUID: hdySl3B/QVCyB3eGHE0hfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="31303008"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="31303008"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 16:28:12 -0700
X-CSE-ConnectionGUID: DT7uj9e1QTCvyQVO6WGuFA==
X-CSE-MsgGUID: 2RXnZYbMTTW6bRcqK5kc0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="86496284"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Aug 2024 16:28:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa1gu-000xXY-2W;
	Fri, 02 Aug 2024 23:28:08 +0000
Date: Sat, 03 Aug 2024 07:27:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/loongson] BUILD SUCCESS
 1f35a0c74e441e1a21b5414c25bc01f06e9cca31
Message-ID: <202408030743.W1s2KSgB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/loongson
branch HEAD: 1f35a0c74e441e1a21b5414c25bc01f06e9cca31  PCI/ACPI: Increase Loongson max PCI hosts to 8

elapsed time: 1453m

configs tested: 199
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240802   gcc-13.2.0
arc                   randconfig-002-20240802   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240802   gcc-13.2.0
arm                   randconfig-002-20240802   gcc-13.2.0
arm                   randconfig-003-20240802   gcc-13.2.0
arm                   randconfig-004-20240802   gcc-13.2.0
arm                             rpc_defconfig   clang-20
arm                             rpc_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                       spear13xx_defconfig   clang-20
arm                           spitz_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240802   gcc-13.2.0
arm64                 randconfig-002-20240802   gcc-13.2.0
arm64                 randconfig-003-20240802   gcc-13.2.0
arm64                 randconfig-004-20240802   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240802   gcc-13.2.0
csky                  randconfig-002-20240802   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240802   gcc-13
i386         buildonly-randconfig-002-20240802   gcc-13
i386         buildonly-randconfig-003-20240802   gcc-13
i386         buildonly-randconfig-004-20240802   gcc-13
i386         buildonly-randconfig-005-20240802   gcc-13
i386         buildonly-randconfig-006-20240802   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240802   gcc-13
i386                  randconfig-002-20240802   gcc-13
i386                  randconfig-003-20240802   gcc-13
i386                  randconfig-004-20240802   gcc-13
i386                  randconfig-005-20240802   gcc-13
i386                  randconfig-006-20240802   gcc-13
i386                  randconfig-011-20240802   gcc-13
i386                  randconfig-012-20240802   gcc-13
i386                  randconfig-013-20240802   gcc-13
i386                  randconfig-014-20240802   gcc-13
i386                  randconfig-015-20240802   gcc-13
i386                  randconfig-016-20240802   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240802   gcc-13.2.0
loongarch             randconfig-002-20240802   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   gcc-13.2.0
mips                           ip30_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240802   gcc-13.2.0
nios2                 randconfig-002-20240802   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
openrisc                 simple_smp_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240802   gcc-13.2.0
parisc                randconfig-002-20240802   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      arches_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   clang-20
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240802   gcc-13.2.0
powerpc               randconfig-003-20240802   gcc-13.2.0
powerpc                     sequoia_defconfig   gcc-13.2.0
powerpc                      tqm8xx_defconfig   clang-20
powerpc                         wii_defconfig   gcc-13.2.0
powerpc64                        alldefconfig   clang-20
powerpc64             randconfig-001-20240802   gcc-13.2.0
powerpc64             randconfig-002-20240802   gcc-13.2.0
powerpc64             randconfig-003-20240802   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240802   gcc-13.2.0
riscv                 randconfig-002-20240802   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240802   gcc-13.2.0
s390                  randconfig-002-20240802   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                 kfr2r09-romimage_defconfig   gcc-13.2.0
sh                    randconfig-001-20240802   gcc-13.2.0
sh                    randconfig-002-20240802   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240802   gcc-13.2.0
sparc64               randconfig-002-20240802   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240802   gcc-13.2.0
um                    randconfig-002-20240802   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240802   gcc-8
x86_64       buildonly-randconfig-002-20240802   gcc-8
x86_64       buildonly-randconfig-003-20240802   gcc-8
x86_64       buildonly-randconfig-004-20240802   gcc-8
x86_64       buildonly-randconfig-005-20240802   gcc-8
x86_64       buildonly-randconfig-006-20240802   gcc-8
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240802   gcc-8
x86_64                randconfig-002-20240802   gcc-8
x86_64                randconfig-003-20240802   gcc-8
x86_64                randconfig-004-20240802   gcc-8
x86_64                randconfig-005-20240802   gcc-8
x86_64                randconfig-006-20240802   gcc-8
x86_64                randconfig-011-20240802   gcc-8
x86_64                randconfig-012-20240802   gcc-8
x86_64                randconfig-013-20240802   gcc-8
x86_64                randconfig-014-20240802   gcc-8
x86_64                randconfig-015-20240802   gcc-8
x86_64                randconfig-016-20240802   gcc-8
x86_64                randconfig-071-20240802   gcc-8
x86_64                randconfig-072-20240802   gcc-8
x86_64                randconfig-073-20240802   gcc-8
x86_64                randconfig-074-20240802   gcc-8
x86_64                randconfig-075-20240802   gcc-8
x86_64                randconfig-076-20240802   gcc-8
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                  nommu_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240802   gcc-13.2.0
xtensa                randconfig-002-20240802   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

