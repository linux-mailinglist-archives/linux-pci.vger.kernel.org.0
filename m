Return-Path: <linux-pci+bounces-12139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E978095D7C6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 22:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC2A1C2334E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 20:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F51197A88;
	Fri, 23 Aug 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZ3cr2oy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D8198837
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444323; cv=none; b=VUApYfh7UHXxr/ryR/Fyep49MMNdgUkNUuGYTDa3g7udVbdBRff5Rc5+PxDNkmzMCiHfSwcKlQ9PSvvfIAxj0HY+o4SOaQaAs40ct/KA/uSG7kxuZEyByDTU/q/R9p8UAOfbzCXROU7/h+60pnKW4L/X3zORP4sLN7ftqLkHSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444323; c=relaxed/simple;
	bh=IZJVccup0sapizyoJo+qsosZvdd5sAXFXJG++S1BkXk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d7gXX0Mqnnym8FPk9KN3dtPmANvZC96KXZlUWwB4BOs3MKEs+nG1ODttdVWusBa2uF/sBBSjfxIudy3KsYDiWS0Mba2AeIPfHtmDy8RiKt1O+nlKs8Lvbo02g5trXuwUGcg48tX/EuSOna7hiKjuIfkCrZ96MglhGhu9wQ/UqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZ3cr2oy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724444322; x=1755980322;
  h=date:from:to:cc:subject:message-id;
  bh=IZJVccup0sapizyoJo+qsosZvdd5sAXFXJG++S1BkXk=;
  b=AZ3cr2oyCw4Lqaq8nMgfvOFgJdwYKB9rwflJHEnNkeJrpPKhhgMCODvh
   DDyRpK9AqpSs7PAvSasnzKcF9iGRfGAPwEq+W30C08xjL+API77ESAt9J
   x1xKYZm84IxI0/1u/yvGGvjwYPEwt3KFX1gYfnmXGXgWTgquOdGYUe7dV
   MtshlriHAOq+E8yw3J8jZF1sicHzG02qIxDkDTCJdst8fnYDA3x/LmoWZ
   om+PLZ2w3+0Y5F1kekKS5CcpgWKJAEodTnsmNts2l2YZdOgoXAHeDFzmH
   6pdUB4CAIX6Lk8w7t95ZTrkDKzqxPqZeyt3XyrDVYg9Hv83EH+5ZErRV1
   Q==;
X-CSE-ConnectionGUID: CBsKZr9ZTP2R6uQL2cYEAg==
X-CSE-MsgGUID: HwKLmCXuQf+g45UGA29nBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="26729896"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="26729896"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 13:18:41 -0700
X-CSE-ConnectionGUID: vIg5uMxvT0aViIHnPMqFHA==
X-CSE-MsgGUID: Ygg7NSawSQmW9pc9JpW+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="92695748"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 Aug 2024 13:18:40 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shak1-000E0C-2q;
	Fri, 23 Aug 2024 20:18:37 +0000
Date: Sat, 24 Aug 2024 04:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctl] BUILD SUCCESS
 0da59840f10141988e949d8519ed9182991caf17
Message-ID: <202408240445.WlSL7Qsf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctl
branch HEAD: 0da59840f10141988e949d8519ed9182991caf17  PCI/pwrctl: Add WCN6855 support

elapsed time: 1448m

configs tested: 175
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
arc                                 defconfig   gcc-13.2.0
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
arm                          pxa3xx_defconfig   gcc-13.2.0
arm                   randconfig-001-20240823   gcc-13.2.0
arm                   randconfig-002-20240823   gcc-13.2.0
arm                   randconfig-003-20240823   gcc-13.2.0
arm                   randconfig-004-20240823   gcc-13.2.0
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
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           ip32_defconfig   gcc-13.2.0
mips                     loongson2k_defconfig   gcc-13.2.0
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
powerpc                     mpc512x_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240823   gcc-13.2.0
powerpc               randconfig-002-20240823   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                     taishan_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
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
s390                              allnoconfig   clang-20
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
sh                        sh7785lcr_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240823   gcc-13.2.0
sparc64               randconfig-002-20240823   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
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

