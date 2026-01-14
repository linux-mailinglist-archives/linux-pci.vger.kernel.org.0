Return-Path: <linux-pci+bounces-44693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A8D1C3CF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 04:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23590300EDD8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A32D6E53;
	Wed, 14 Jan 2026 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXnkkIEk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E42E0925
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360869; cv=none; b=m8VSIsJ3RnMNw6Pup7zdJ7p0VykPsJGHTLf7tYHb/tIp3isG+o2uXVrIkJHbQoqoTyDq0udBdLFXeuBqP5m6xYJzDewiXE6+DcNOdTQxmx7fH/APSAs36PjOAiGkyUO9g7Rsz28kGqMq1uMdklTyY+9MaX1L+4LvM9ohFLIrALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360869; c=relaxed/simple;
	bh=unbuaMLiPfregysB/scQpBiqlbrjZZq323330KQqQ50=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TT/jxgcoEZex63BOz70MfvraBaKbP+Cvil9iIRv70Jstrp9U3NlGiRzjrRi+5Dp15iGLpMjJBKUDtUapKUB07YL2fidCweddal9ra3/eUwlPnOPmSrjLEMX+fh96L7YaBFlVyp7Vc2Aozqr3QhCAGUmf7LFZJRReTB6Kt/A2fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXnkkIEk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360868; x=1799896868;
  h=date:from:to:cc:subject:message-id;
  bh=unbuaMLiPfregysB/scQpBiqlbrjZZq323330KQqQ50=;
  b=fXnkkIEkLDHhsYg3ftrMCDqUT6YRKyb69y0v4dMsa8DKq+2Db527QD4p
   IFAOv1EGOstQDa+PDjnKUZiR6o3oV4r0Ynt4JhB1okEPs9oLyWmqn+TSL
   kF2EDPbRqfWjfPHyjHVRP/+Xkz+eHauGATmrAr5zXfw17HAlE828GlvuP
   fF9u/zKK7hzgN/pFvKsufNpxk3b43syB/VVpIuyzCuu8B6ZPNLq6u6881
   9ufjhjxaDwZiR9HDImAwuw6XmYTw2EV8QfR/1au7MRDcv9jZpG9xZ4ma7
   3PnuM+Dj6dgODebAZtjSxgwW1ZFumu0QaC2LnZ5Wpsh420C7q7gtKYhyT
   A==;
X-CSE-ConnectionGUID: katgmvK+QviQlpvQFn2fqw==
X-CSE-MsgGUID: 1tGV0SCISziws7kHejhFrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68863249"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="68863249"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:21:07 -0800
X-CSE-ConnectionGUID: goW1lnmZTz6n1ViwZXIzSg==
X-CSE-MsgGUID: Y8c729sdQHSjkggVqTFFDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209074186"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jan 2026 19:21:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfrRP-00000000FiU-0apj;
	Wed, 14 Jan 2026 03:21:03 +0000
Date: Wed, 14 Jan 2026 11:20:26 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-sophgo] BUILD SUCCESS
 613f3255a35a95f52575dd8c60b7ac9d711639ce
Message-ID: <202601141121.IVdGTGHd-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-sophgo
branch HEAD: 613f3255a35a95f52575dd8c60b7ac9d711639ce  PCI: sophgo: Disable L0s and L1 on Sophgo 2044 PCIe Root Ports

elapsed time: 735m

configs tested: 210
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    clang-22
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260114    gcc-10.5.0
arc                   randconfig-002-20260114    gcc-10.5.0
arc                           tb10x_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260114    gcc-10.5.0
arm                   randconfig-002-20260114    gcc-10.5.0
arm                   randconfig-003-20260114    gcc-10.5.0
arm                   randconfig-004-20260114    gcc-10.5.0
arm                        shmobile_defconfig    clang-22
arm                           stm32_defconfig    clang-22
arm                    vt8500_v6_v7_defconfig    clang-22
arm                         wpcm450_defconfig    clang-22
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260114    clang-22
arm64                 randconfig-002-20260114    clang-22
arm64                 randconfig-003-20260114    clang-22
arm64                 randconfig-004-20260114    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260114    clang-22
csky                  randconfig-002-20260114    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260114    clang-22
hexagon               randconfig-002-20260114    clang-22
i386                             alldefconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260114    gcc-14
i386        buildonly-randconfig-002-20260114    gcc-14
i386        buildonly-randconfig-003-20260114    gcc-14
i386        buildonly-randconfig-004-20260114    gcc-14
i386        buildonly-randconfig-005-20260114    gcc-14
i386        buildonly-randconfig-006-20260114    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260114    gcc-14
i386                  randconfig-002-20260114    gcc-14
i386                  randconfig-003-20260114    gcc-14
i386                  randconfig-004-20260114    gcc-14
i386                  randconfig-005-20260114    gcc-14
i386                  randconfig-006-20260114    gcc-14
i386                  randconfig-007-20260114    gcc-14
i386                  randconfig-011-20260114    gcc-14
i386                  randconfig-012-20260114    gcc-14
i386                  randconfig-013-20260114    gcc-14
i386                  randconfig-014-20260114    gcc-14
i386                  randconfig-015-20260114    gcc-14
i386                  randconfig-016-20260114    gcc-14
i386                  randconfig-017-20260114    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260114    clang-22
loongarch             randconfig-002-20260114    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         apollo_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260114    clang-22
nios2                 randconfig-002-20260114    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260114    gcc-14.3.0
parisc                randconfig-002-20260114    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-22
powerpc               randconfig-001-20260114    gcc-14.3.0
powerpc               randconfig-002-20260114    gcc-14.3.0
powerpc                    sam440ep_defconfig    clang-22
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260114    gcc-14.3.0
powerpc64             randconfig-002-20260114    gcc-14.3.0
riscv                            alldefconfig    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260114    gcc-15.2.0
riscv                 randconfig-002-20260114    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260114    gcc-15.2.0
s390                  randconfig-002-20260114    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    clang-22
sh                             espt_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260114    gcc-15.2.0
sh                    randconfig-002-20260114    gcc-15.2.0
sh                           se7619_defconfig    clang-22
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260114    clang-20
sparc                 randconfig-001-20260114    gcc-14.3.0
sparc                 randconfig-002-20260114    clang-20
sparc                 randconfig-002-20260114    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260114    clang-20
sparc64               randconfig-002-20260114    clang-20
sparc64               randconfig-002-20260114    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260114    clang-20
um                    randconfig-001-20260114    gcc-14
um                    randconfig-002-20260114    clang-20
um                    randconfig-002-20260114    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260114    clang-20
x86_64      buildonly-randconfig-002-20260114    clang-20
x86_64      buildonly-randconfig-003-20260114    clang-20
x86_64      buildonly-randconfig-004-20260114    clang-20
x86_64      buildonly-randconfig-005-20260114    clang-20
x86_64      buildonly-randconfig-006-20260114    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260114    gcc-14
x86_64                randconfig-002-20260114    gcc-14
x86_64                randconfig-003-20260114    gcc-14
x86_64                randconfig-004-20260114    gcc-14
x86_64                randconfig-005-20260114    gcc-14
x86_64                randconfig-006-20260114    gcc-14
x86_64                randconfig-011-20260114    gcc-14
x86_64                randconfig-012-20260114    gcc-14
x86_64                randconfig-013-20260114    gcc-14
x86_64                randconfig-014-20260114    gcc-14
x86_64                randconfig-015-20260114    gcc-14
x86_64                randconfig-016-20260114    gcc-14
x86_64                randconfig-071-20260114    clang-20
x86_64                randconfig-072-20260114    clang-20
x86_64                randconfig-073-20260114    clang-20
x86_64                randconfig-074-20260114    clang-20
x86_64                randconfig-075-20260114    clang-20
x86_64                randconfig-076-20260114    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  audio_kc705_defconfig    clang-22
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260114    clang-20
xtensa                randconfig-001-20260114    gcc-10.5.0
xtensa                randconfig-002-20260114    clang-20
xtensa                randconfig-002-20260114    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

