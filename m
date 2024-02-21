Return-Path: <linux-pci+bounces-3839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBF85E8D7
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 21:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB3D2838CE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 20:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B885C52;
	Wed, 21 Feb 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr3wcwR9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056283CB2
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546358; cv=none; b=MiIroNDy1v/g9r/5ZqTsiDpXCzOHuWjCtLE7A2Tg490EfA4kcxpQjKO6s/ToJQegYsuhuRean4DooBS1axlCVVWx4+8AhmHRot5LcyuuEZKl88ejQOGrMhQYpzKuDQyw9iK2rpqoyqXyLqMYonHS+ZJragdIyYC3Gfn12Dk7GCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546358; c=relaxed/simple;
	bh=atRwBmnWpyGLf4fl2sTn+7aHJcEHl/NmCk6cmtagtjU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZSSs2hVMUpaqYpSaLaYTxiXFnymJK3EH/R/vXFguIrswlXUWLRATVSyzWekbdvyVsK2fnBlvv7vsZ257XFKiofhajeBhz2dcGjeocCvNEh/g4lDC9yJpRgHvk297vGRsDmPKYMxbetWeGx5JRD5SBljQNLDzcnJLZt+r9tBDYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr3wcwR9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708546357; x=1740082357;
  h=date:from:to:cc:subject:message-id;
  bh=atRwBmnWpyGLf4fl2sTn+7aHJcEHl/NmCk6cmtagtjU=;
  b=Mr3wcwR9fjlApJniL4mxeADjWXACPiMOD4Mob+FHdkw06tZ6+M18KFLV
   YD7YR4gKQp3ryBVBHpiqRan7RjEkuobYnBX18i7tfoICYwxsfC0yCFt0l
   RJLK25Q2B3hPsYMizJOOW6EJWAOSna3X7bK2gPhU2DVcm5SlYB3iUbB15
   STFcvGD2wuSoS6hYZiUMcW2CXrW36Y3FYen0kVuGdNeQ87TYYsOqEN2Td
   derc8q0oFc3gsaWdHBbd5Y/4exuCahdjJOdOpMJG6WNfKEIqvtmjry88b
   tnVqo8hDLHaGPy4iqrWEiAiK0PPz56rGN1wiwgvOUeGw0MGu5w+W5gs6r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="5683978"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5683978"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 12:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9827776"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 21 Feb 2024 12:12:32 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcsx2-0005g6-2W;
	Wed, 21 Feb 2024 20:12:26 +0000
Date: Thu, 22 Feb 2024 04:12:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 baf67aefbe7d7deafa59ca49612d163f8889934c
Message-ID: <202402220407.K8DBxTC7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: baf67aefbe7d7deafa59ca49612d163f8889934c  PCI: Mark 3ware-9650SE Root Port Extended Tags as broken

elapsed time: 1367m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240221   gcc  
arc                   randconfig-002-20240221   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                        neponset_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240221   clang
arm                   randconfig-002-20240221   clang
arm                   randconfig-003-20240221   gcc  
arm                   randconfig-004-20240221   clang
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240221   gcc  
arm64                 randconfig-002-20240221   gcc  
arm64                 randconfig-003-20240221   gcc  
arm64                 randconfig-004-20240221   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240221   gcc  
csky                  randconfig-002-20240221   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240221   clang
hexagon               randconfig-002-20240221   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240221   clang
i386                                defconfig   clang
i386                  randconfig-002-20240221   clang
i386                  randconfig-003-20240221   clang
i386                  randconfig-006-20240221   clang
i386                  randconfig-012-20240221   clang
i386                  randconfig-014-20240221   clang
i386                  randconfig-016-20240221   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240221   gcc  
loongarch             randconfig-002-20240221   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240221   gcc  
nios2                 randconfig-002-20240221   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240221   gcc  
parisc                randconfig-002-20240221   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240221   gcc  
powerpc               randconfig-002-20240221   gcc  
powerpc               randconfig-003-20240221   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240221   gcc  
powerpc64             randconfig-002-20240221   gcc  
powerpc64             randconfig-003-20240221   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240221   clang
riscv                 randconfig-002-20240221   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240221   clang
s390                  randconfig-002-20240221   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240221   gcc  
sh                    randconfig-002-20240221   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240221   gcc  
sparc64               randconfig-002-20240221   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240221   gcc  
um                    randconfig-002-20240221   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240221   clang
x86_64       buildonly-randconfig-002-20240221   gcc  
x86_64       buildonly-randconfig-003-20240221   gcc  
x86_64       buildonly-randconfig-004-20240221   clang
x86_64       buildonly-randconfig-005-20240221   clang
x86_64       buildonly-randconfig-006-20240221   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240221   gcc  
x86_64                randconfig-002-20240221   gcc  
x86_64                randconfig-003-20240221   gcc  
x86_64                randconfig-004-20240221   gcc  
x86_64                randconfig-005-20240221   gcc  
x86_64                randconfig-006-20240221   gcc  
x86_64                randconfig-011-20240221   clang
x86_64                randconfig-012-20240221   gcc  
x86_64                randconfig-013-20240221   clang
x86_64                randconfig-014-20240221   gcc  
x86_64                randconfig-015-20240221   gcc  
x86_64                randconfig-016-20240221   gcc  
x86_64                randconfig-071-20240221   gcc  
x86_64                randconfig-072-20240221   gcc  
x86_64                randconfig-073-20240221   gcc  
x86_64                randconfig-074-20240221   gcc  
x86_64                randconfig-075-20240221   clang
x86_64                randconfig-076-20240221   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240221   gcc  
xtensa                randconfig-002-20240221   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

