Return-Path: <linux-pci+bounces-10349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F11931FA9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 06:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301241F21F47
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 04:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A323B0;
	Tue, 16 Jul 2024 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJpW4wOt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3A37B
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 04:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103749; cv=none; b=sYYpb+nHfUAvNP4b0P9g4kZH7I5JHMR2ZkYaW9r635dNc0H1//iQXOsSfhOSUHWfK3DAlhbBUtLCTqMyt9AVv/gtQiTxRQA3s1kRPf/dhpMangRTd16KDev85VdkytbLi4oAKlIN3Y3KQoblAcCSevQePryhO4UTj+AlUmtXh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103749; c=relaxed/simple;
	bh=4/dAx/CembGOjR9qDwHfgOcsyYG6r1a1u6DWhQTBWqY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jsMeAnedVsu3ycqcCQOMHEcIuPOhaPBgPouP5OBlocl9TqfFExWEW0QX34JnWLaPCigKUPouSPzgmN3YelVIliYF1OihNxb/DZFPmLSHr/OSuoO0iCk36iWfYR/PNCtRbcRoEQUUi1OqFcbF8mO8eE//OJoKlA+4rAFqO7ZwpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJpW4wOt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721103747; x=1752639747;
  h=date:from:to:cc:subject:message-id;
  bh=4/dAx/CembGOjR9qDwHfgOcsyYG6r1a1u6DWhQTBWqY=;
  b=AJpW4wOtU+ZPAViL/5l3exrIrvEnaxcapIDzZrbPe6HO5PcIBwRVEae2
   AKASqhBvztTbRzn7hbq/KhHfk102dCrryC+A46OuQrK10p1G82RCrjkEn
   zg1WlWf51Fbl9fKVesfde3LhJdFNqhNHWuLGV8JbErS7xdKsB+K58E+b8
   ne7oJRrWhDwOw2vM/wyr/NsAP3I4iNYhwv3mi2cEJ+r0S5kGGppH+4nng
   4WwkU4oLi35du9jHcJYufnG6rmvgaMOQCsdetqcMgiSV1VBAsa5dmILkT
   v8vaMFymfsz+/hr4wvDa0+4nydKBF3kZWxR9PrWBBCnGJIk0ynpiQ48ZC
   g==;
X-CSE-ConnectionGUID: BpAPjyLrRA+4frES+KwIfw==
X-CSE-MsgGUID: 6cw4EkD1Q6aPMo7OIUPdKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="43944086"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="43944086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 21:22:27 -0700
X-CSE-ConnectionGUID: zWPt4wTMS1+WNED9LYeMYw==
X-CSE-MsgGUID: aYebVu0nR6au4t9AYs5Zhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="80543703"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Jul 2024 21:22:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTZhm-000esy-31;
	Tue, 16 Jul 2024 04:22:22 +0000
Date: Tue, 16 Jul 2024 12:22:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:acs] BUILD SUCCESS
 47c8846a49baa8c0b7a6a3e7e7eacd6e8d119d25
Message-ID: <202407161215.swkX88jU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git acs
branch HEAD: 47c8846a49baa8c0b7a6a3e7e7eacd6e8d119d25  PCI: Extend ACS configurability

elapsed time: 794m

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
arc                        nsim_700_defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240716   gcc-13.2.0
arc                   randconfig-002-20240716   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                      jornada720_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.2.0
arm                          pxa3xx_defconfig   gcc-13.2.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240716   gcc-13.2.0
arm                   randconfig-002-20240716   gcc-13.2.0
arm                   randconfig-003-20240716   gcc-13.2.0
arm                   randconfig-004-20240716   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240716   gcc-13.2.0
arm64                 randconfig-002-20240716   gcc-13.2.0
arm64                 randconfig-003-20240716   gcc-13.2.0
arm64                 randconfig-004-20240716   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240716   gcc-13.2.0
csky                  randconfig-002-20240716   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240716   clang-18
i386         buildonly-randconfig-002-20240716   clang-18
i386         buildonly-randconfig-003-20240716   clang-18
i386         buildonly-randconfig-004-20240716   clang-18
i386         buildonly-randconfig-005-20240716   clang-18
i386         buildonly-randconfig-006-20240716   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240716   clang-18
i386                  randconfig-002-20240716   clang-18
i386                  randconfig-003-20240716   clang-18
i386                  randconfig-004-20240716   clang-18
i386                  randconfig-005-20240716   clang-18
i386                  randconfig-006-20240716   clang-18
i386                  randconfig-011-20240716   clang-18
i386                  randconfig-012-20240716   clang-18
i386                  randconfig-013-20240716   clang-18
i386                  randconfig-014-20240716   clang-18
i386                  randconfig-015-20240716   clang-18
i386                  randconfig-016-20240716   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240716   gcc-13.2.0
loongarch             randconfig-002-20240716   gcc-13.2.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath25_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240716   gcc-13.2.0
nios2                 randconfig-002-20240716   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240716   gcc-13.2.0
parisc                randconfig-002-20240716   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                    adder875_defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      arches_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240716   gcc-13.2.0
powerpc               randconfig-002-20240716   gcc-13.2.0
powerpc               randconfig-003-20240716   gcc-13.2.0
powerpc64             randconfig-001-20240716   gcc-13.2.0
powerpc64             randconfig-002-20240716   gcc-13.2.0
powerpc64             randconfig-003-20240716   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240716   gcc-13.2.0
riscv                 randconfig-002-20240716   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240716   gcc-13.2.0
s390                  randconfig-002-20240716   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240716   gcc-13.2.0
sh                    randconfig-002-20240716   gcc-13.2.0
sh                           se7751_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc                            alldefconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240716   gcc-13.2.0
sparc64               randconfig-002-20240716   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240716   gcc-13.2.0
um                    randconfig-002-20240716   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240716   gcc-13
x86_64       buildonly-randconfig-002-20240716   gcc-13
x86_64       buildonly-randconfig-003-20240716   gcc-13
x86_64       buildonly-randconfig-004-20240716   gcc-13
x86_64       buildonly-randconfig-005-20240716   gcc-13
x86_64       buildonly-randconfig-006-20240716   gcc-13
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240716   gcc-13
x86_64                randconfig-002-20240716   gcc-13
x86_64                randconfig-003-20240716   gcc-13
x86_64                randconfig-004-20240716   gcc-13
x86_64                randconfig-005-20240716   gcc-13
x86_64                randconfig-006-20240716   gcc-13
x86_64                randconfig-011-20240716   gcc-13
x86_64                randconfig-012-20240716   gcc-13
x86_64                randconfig-013-20240716   gcc-13
x86_64                randconfig-014-20240716   gcc-13
x86_64                randconfig-015-20240716   gcc-13
x86_64                randconfig-016-20240716   gcc-13
x86_64                randconfig-071-20240716   gcc-13
x86_64                randconfig-072-20240716   gcc-13
x86_64                randconfig-073-20240716   gcc-13
x86_64                randconfig-074-20240716   gcc-13
x86_64                randconfig-075-20240716   gcc-13
x86_64                randconfig-076-20240716   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240716   gcc-13.2.0
xtensa                randconfig-002-20240716   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

