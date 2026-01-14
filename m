Return-Path: <linux-pci+bounces-44707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBED1CE18
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509AD30184EB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 07:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00143379979;
	Wed, 14 Jan 2026 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+mbotQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F173793AA
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376011; cv=none; b=jXIj8k1F/mLoDMel8VZ2nXCcWt83mCnzt/aZMHUSwdKxohJttm2kU5Qo0/qTo+LMZujt/SEai2ka/MxyAkeuPoai+zGJcXcSrgARufOnGaTub9VU7UGQ/gFrvqsdJNyIiN623PwyCMtjvO5+NRjewCf9yNZX68x10Rifc1wQTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376011; c=relaxed/simple;
	bh=FVVTc4oF6+A66Lsgj5B67IAbZcUo/rfDsvehbxkw1CE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MTx82PQrGomU76w3KuDqSFML96X86b7Jxn9FeSXp6hX90oBqeA05FTSvc9m+VhReo4H+nMknP/WcPzqf86zxTwPeDCWEMbmRAC4cGIbPgvDJRkYpoHtZbZKngTjQkVOcQQTSg2g6pgSr/QnZVs8NfKiFe8lOuZ5UXV7rHo7KTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+mbotQM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768376007; x=1799912007;
  h=date:from:to:cc:subject:message-id;
  bh=FVVTc4oF6+A66Lsgj5B67IAbZcUo/rfDsvehbxkw1CE=;
  b=B+mbotQM8Yjp9xBQrYlcsO85b0WAOTzdGu5fatJINHm8PzoWpyZQwrxq
   m4nLjKnU27ANfdxXOFzt06eWjEKRaIyJDypzFM+92wcGp+srUliE0eydU
   Va5dLvdpoOifofuGds1sa231k+Ra0I+akaA27+USuT0euhIvMiQ/6iDQa
   Ggzdo5eIO5aw6trRsVaaLLPdMiOSgp8Ipo8fg9pnoY/FzXwQPtmqVoE7W
   wWccsJ039v3gTc1wqNsuw+kG+e6wU8c8kk9G4Wi59jdmjShrQrBPSpvoQ
   ANoY0o1l8uhEdgd4gmrrJBXSDkauqvui1CWpiOQB5brqNUGCE6hb0HAci
   Q==;
X-CSE-ConnectionGUID: aA2otOesTvC/c8TIxutrxA==
X-CSE-MsgGUID: aCd/z553Qu63RYFKRPoReQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69578412"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69578412"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:33:23 -0800
X-CSE-ConnectionGUID: O2BiaBtsQLCqLjYRKFS16Q==
X-CSE-MsgGUID: XFSbE9gdSr6b1xdIgFuIHg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Jan 2026 23:33:22 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfvNY-00000000G0G-197f;
	Wed, 14 Jan 2026 07:33:20 +0000
Date: Wed, 14 Jan 2026 15:32:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:ptm] BUILD SUCCESS
 cfc04a79f0554fc3c33d6541c125d209bd3c1f37
Message-ID: <202601141530.9dLCpzsK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ptm
branch HEAD: cfc04a79f0554fc3c33d6541c125d209bd3c1f37  PCI/PTM: Fix pcie_ptm_create_debugfs() memory leak

elapsed time: 752m

configs tested: 210
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    clang-22
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260114    gcc-10.5.0
arc                   randconfig-002-20260114    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260114    gcc-10.5.0
arm                   randconfig-002-20260114    gcc-10.5.0
arm                   randconfig-003-20260114    gcc-10.5.0
arm                   randconfig-004-20260114    gcc-10.5.0
arm                        shmobile_defconfig    clang-22
arm                        spear3xx_defconfig    gcc-15.2.0
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
arm64                 randconfig-003-20260114    gcc-10.5.0
arm64                 randconfig-004-20260114    clang-18
arm64                 randconfig-004-20260114    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260114    clang-22
csky                  randconfig-001-20260114    gcc-15.2.0
csky                  randconfig-002-20260114    clang-22
csky                  randconfig-002-20260114    gcc-10.5.0
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
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           gcw0_defconfig    gcc-15.2.0
mips                           ip28_defconfig    gcc-15.2.0
mips                      loongson1_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    gcc-15.2.0
nios2                         3c120_defconfig    gcc-15.2.0
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
powerpc                   bluestone_defconfig    gcc-15.2.0
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                     powernv_defconfig    clang-22
powerpc               randconfig-001-20260114    gcc-14.3.0
powerpc               randconfig-002-20260114    gcc-14.3.0
powerpc                    sam440ep_defconfig    clang-22
powerpc64             randconfig-001-20260114    gcc-14.3.0
powerpc64             randconfig-002-20260114    gcc-14.3.0
riscv                            alldefconfig    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260114    gcc-15.2.0
riscv                 randconfig-002-20260114    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
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
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7619_defconfig    clang-22
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260114    clang-20
sparc                 randconfig-002-20260114    clang-20
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260114    clang-20
sparc64               randconfig-002-20260114    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260114    clang-20
um                    randconfig-002-20260114    clang-20
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
x86_64                randconfig-012-20260114    clang-20
x86_64                randconfig-012-20260114    gcc-14
x86_64                randconfig-013-20260114    clang-20
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
xtensa                randconfig-001-20260114    clang-20
xtensa                randconfig-002-20260114    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

