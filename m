Return-Path: <linux-pci+bounces-10137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A378192DFA5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 07:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5974C283206
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 05:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA2E3AC1F;
	Thu, 11 Jul 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFQt27kY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1F2C861
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676171; cv=none; b=DPgNxO9r8Rb1NESxOJWPQqssWoD17zuMELPs/3XH+Goru9hloa8ocIMALgN+IthTgoqM6k2REkfjVgWhb1BHLGWnD86k6O32PdIenAqKxWsEoVRBUjmulK31TROSzD5/Ot6ubA6Dhg0aW5b9lcN67lOUzVSDP9Q1fDd7NA4vqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676171; c=relaxed/simple;
	bh=VvN1BHYrh9ASoSOzpzCT0cAegLFf3mJGOk1B5gI/JqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TNXSAPZQxNymCv7mTwRBnLVFFS2pm+2bAkALIh60ygQtM9aDGwXliJxEYSPreATt9F4mrqBbyMUuqxvZr2JvWRVGkyulpwowxH7awVvNu90+j8H/m4TV1sUlvmv0wwss7uldiDTioCubbPb7r+7EqmKF2aTs9qxYHwWHTgIqS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFQt27kY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720676169; x=1752212169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VvN1BHYrh9ASoSOzpzCT0cAegLFf3mJGOk1B5gI/JqQ=;
  b=eFQt27kYpTfPjCLINd34VbBiFYyhGUF9WGO+iF7FUJysA/x/5toOuEUT
   LvS9wub1Qb2707oxw1sLRblk8A099l2faYIkCDE0IGwYj+7mMMhDv+/0o
   6/SMa9aon2VdrxX5mW7EvvvJI139k4hiPMc61iogzoddtbHwQWjnV4JBg
   y85zeP4tXIVAf+FrWLhsYAfmeymyRmMajQwZdWOFONPH9UFdbbmWsOH3/
   Msrzjf4jnAsyl0vizcwAmylPKdivQjj3M9Z0o8Xx4dh/Hn+A8/bUKGeAC
   VV3vsIzQBYtqVDx/+4GNzu66qzNuXaUmVWc1cQVz0A8HDTBLm1/9Dh4j9
   w==;
X-CSE-ConnectionGUID: 4W63GM1GT5CFEfkLetexKg==
X-CSE-MsgGUID: W5+3NbC6TkSC7u6CX38oew==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35572314"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="35572314"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 22:36:08 -0700
X-CSE-ConnectionGUID: w8zTs/s1QCmFQl+mvnCyyg==
X-CSE-MsgGUID: tFK4+OTdSJ2GKdu+zETaBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="49193572"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2024 22:36:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRmTM-000YpW-2q;
	Thu, 11 Jul 2024 05:36:04 +0000
Date: Thu, 11 Jul 2024 13:35:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 b2052def4ae398206714548a671cb2a54adf8bf7
Message-ID: <202407111339.0NsEIIwC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: b2052def4ae398206714548a671cb2a54adf8bf7  drm/vboxvideo: fix mapping leaks

elapsed time: 1454m

configs tested: 322
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
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240710   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240710   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   gcc-13.2.0
arm                        clps711x_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                   milbeaut_m10v_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   clang-19
arm                          moxart_defconfig   gcc-13.3.0
arm                            mps2_defconfig   clang-19
arm                        multi_v5_defconfig   clang-19
arm                       omap2plus_defconfig   clang-19
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240710   gcc-13.2.0
arm                   randconfig-001-20240711   gcc-13.2.0
arm                   randconfig-002-20240710   gcc-13.2.0
arm                   randconfig-002-20240711   gcc-13.2.0
arm                   randconfig-003-20240710   gcc-13.2.0
arm                   randconfig-003-20240711   gcc-13.2.0
arm                   randconfig-004-20240710   gcc-13.2.0
arm                   randconfig-004-20240711   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.3.0
arm                          sp7021_defconfig   clang-19
arm                        spear3xx_defconfig   gcc-13.3.0
arm                           u8500_defconfig   gcc-13.3.0
arm                       versatile_defconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   clang-19
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240710   gcc-13.2.0
arm64                 randconfig-001-20240711   gcc-13.2.0
arm64                 randconfig-002-20240710   gcc-13.2.0
arm64                 randconfig-002-20240711   gcc-13.2.0
arm64                 randconfig-003-20240710   gcc-13.2.0
arm64                 randconfig-003-20240711   gcc-13.2.0
arm64                 randconfig-004-20240710   gcc-13.2.0
arm64                 randconfig-004-20240711   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240710   gcc-13.2.0
csky                  randconfig-001-20240711   gcc-13.2.0
csky                  randconfig-002-20240710   gcc-13.2.0
csky                  randconfig-002-20240711   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240710   clang-18
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240710   clang-18
i386         buildonly-randconfig-002-20240710   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-13
i386         buildonly-randconfig-003-20240710   clang-18
i386         buildonly-randconfig-003-20240710   gcc-11
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240710   clang-18
i386         buildonly-randconfig-004-20240710   gcc-11
i386         buildonly-randconfig-004-20240711   gcc-13
i386         buildonly-randconfig-005-20240710   clang-18
i386         buildonly-randconfig-005-20240711   gcc-13
i386         buildonly-randconfig-006-20240710   clang-18
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240710   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240710   clang-18
i386                  randconfig-002-20240710   gcc-11
i386                  randconfig-002-20240711   gcc-13
i386                  randconfig-003-20240710   clang-18
i386                  randconfig-003-20240710   gcc-13
i386                  randconfig-003-20240711   gcc-13
i386                  randconfig-004-20240710   clang-18
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240710   clang-18
i386                  randconfig-005-20240711   gcc-13
i386                  randconfig-006-20240710   clang-18
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240710   clang-18
i386                  randconfig-011-20240710   gcc-13
i386                  randconfig-011-20240711   gcc-13
i386                  randconfig-012-20240710   clang-18
i386                  randconfig-012-20240710   gcc-12
i386                  randconfig-012-20240711   gcc-13
i386                  randconfig-013-20240710   clang-18
i386                  randconfig-013-20240710   gcc-12
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240710   clang-18
i386                  randconfig-014-20240710   gcc-13
i386                  randconfig-014-20240711   gcc-13
i386                  randconfig-015-20240710   clang-18
i386                  randconfig-015-20240710   gcc-8
i386                  randconfig-015-20240711   gcc-13
i386                  randconfig-016-20240710   clang-18
i386                  randconfig-016-20240711   gcc-13
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.3.0
loongarch             randconfig-001-20240710   gcc-13.2.0
loongarch             randconfig-001-20240711   gcc-13.2.0
loongarch             randconfig-002-20240710   gcc-13.2.0
loongarch             randconfig-002-20240711   gcc-13.2.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.3.0
m68k                       bvme6000_defconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.3.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.3.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   gcc-13.3.0
mips                     cu1000-neo_defconfig   gcc-13.3.0
mips                         db1xxx_defconfig   clang-19
mips                  decstation_64_defconfig   gcc-13.3.0
mips                          eyeq5_defconfig   clang-19
mips                      malta_kvm_defconfig   clang-19
mips                malta_qemu_32r6_defconfig   gcc-13.3.0
mips                        qi_lb60_defconfig   clang-19
nios2                            allmodconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.3.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240710   gcc-13.2.0
nios2                 randconfig-001-20240711   gcc-13.2.0
nios2                 randconfig-002-20240710   gcc-13.2.0
nios2                 randconfig-002-20240711   gcc-13.2.0
openrisc                         allmodconfig   gcc-13.3.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.3.0
parisc                           allyesconfig   gcc-13.3.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240710   gcc-13.2.0
parisc                randconfig-001-20240711   gcc-13.2.0
parisc                randconfig-002-20240710   gcc-13.2.0
parisc                randconfig-002-20240711   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   clang-19
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.3.0
powerpc                     asp8347_defconfig   clang-19
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.3.0
powerpc                       ebony_defconfig   clang-19
powerpc                       maple_defconfig   clang-19
powerpc                   microwatt_defconfig   clang-19
powerpc                     mpc5200_defconfig   gcc-13.3.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                     powernv_defconfig   gcc-13.3.0
powerpc                         ps3_defconfig   clang-19
powerpc               randconfig-001-20240710   gcc-13.2.0
powerpc               randconfig-001-20240711   gcc-13.2.0
powerpc               randconfig-002-20240710   gcc-13.2.0
powerpc               randconfig-002-20240711   gcc-13.2.0
powerpc               randconfig-003-20240710   gcc-13.2.0
powerpc               randconfig-003-20240711   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   clang-19
powerpc                         wii_defconfig   clang-19
powerpc64             randconfig-001-20240710   gcc-13.2.0
powerpc64             randconfig-001-20240711   gcc-13.2.0
powerpc64             randconfig-002-20240710   gcc-13.2.0
powerpc64             randconfig-002-20240711   gcc-13.2.0
powerpc64             randconfig-003-20240710   gcc-13.2.0
powerpc64             randconfig-003-20240711   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.3.0
riscv                             allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.3.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.3.0
riscv                               defconfig   gcc-13.2.0
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
riscv                 randconfig-001-20240710   gcc-13.2.0
riscv                 randconfig-001-20240711   gcc-13.2.0
riscv                 randconfig-002-20240710   gcc-13.2.0
riscv                 randconfig-002-20240711   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240710   gcc-13.2.0
s390                  randconfig-001-20240711   gcc-13.2.0
s390                  randconfig-002-20240710   gcc-13.2.0
s390                  randconfig-002-20240711   gcc-13.2.0
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.3.0
sh                                  defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.3.0
sh                    randconfig-001-20240710   gcc-13.2.0
sh                    randconfig-001-20240711   gcc-13.2.0
sh                    randconfig-002-20240710   gcc-13.2.0
sh                    randconfig-002-20240711   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.3.0
sh                           se7705_defconfig   gcc-13.3.0
sh                           se7751_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.3.0
sparc                            allyesconfig   gcc-13.3.0
sparc                       sparc64_defconfig   gcc-13.3.0
sparc64                          allmodconfig   gcc-13.3.0
sparc64                          allyesconfig   gcc-13.3.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240710   gcc-13.2.0
sparc64               randconfig-001-20240711   gcc-13.2.0
sparc64               randconfig-002-20240710   gcc-13.2.0
sparc64               randconfig-002-20240711   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240710   gcc-13.2.0
um                    randconfig-001-20240711   gcc-13.2.0
um                    randconfig-002-20240710   gcc-13.2.0
um                    randconfig-002-20240711   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240710   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240710   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240710   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240710   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240710   clang-18
x86_64       buildonly-randconfig-005-20240710   gcc-13
x86_64       buildonly-randconfig-005-20240711   clang-18
x86_64       buildonly-randconfig-006-20240710   clang-18
x86_64       buildonly-randconfig-006-20240711   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240710   clang-18
x86_64                randconfig-001-20240710   gcc-13
x86_64                randconfig-001-20240711   clang-18
x86_64                randconfig-002-20240710   clang-18
x86_64                randconfig-002-20240711   clang-18
x86_64                randconfig-003-20240710   clang-18
x86_64                randconfig-003-20240710   gcc-12
x86_64                randconfig-003-20240711   clang-18
x86_64                randconfig-004-20240710   clang-18
x86_64                randconfig-004-20240711   clang-18
x86_64                randconfig-005-20240710   clang-18
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240710   clang-18
x86_64                randconfig-006-20240710   gcc-13
x86_64                randconfig-006-20240711   clang-18
x86_64                randconfig-011-20240710   clang-18
x86_64                randconfig-011-20240711   clang-18
x86_64                randconfig-012-20240710   clang-18
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240710   clang-18
x86_64                randconfig-013-20240711   clang-18
x86_64                randconfig-014-20240710   clang-18
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240710   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240710   clang-18
x86_64                randconfig-016-20240710   gcc-13
x86_64                randconfig-016-20240711   clang-18
x86_64                randconfig-071-20240710   clang-18
x86_64                randconfig-071-20240710   gcc-13
x86_64                randconfig-071-20240711   clang-18
x86_64                randconfig-072-20240710   clang-18
x86_64                randconfig-072-20240711   clang-18
x86_64                randconfig-073-20240710   clang-18
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240710   clang-18
x86_64                randconfig-074-20240710   gcc-7
x86_64                randconfig-074-20240711   clang-18
x86_64                randconfig-075-20240710   clang-18
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240710   clang-18
x86_64                randconfig-076-20240710   gcc-13
x86_64                randconfig-076-20240711   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                           allyesconfig   gcc-13.3.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240710   gcc-13.2.0
xtensa                randconfig-001-20240711   gcc-13.2.0
xtensa                randconfig-002-20240710   gcc-13.2.0
xtensa                randconfig-002-20240711   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

