Return-Path: <linux-pci+bounces-34986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 685F9B398F2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69C47A8248
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEA25BF1B;
	Thu, 28 Aug 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRtD5Ska"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EF25DB0A
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375181; cv=none; b=iHQxaB4p4yPASJNIKxuz4zHN9W0888rq/T6/c/DM7q3+whQd8Cy5tU8cIcf5DmYexhQ05a86NLsGZ24zW7wfhLOjsAXR6hjjoPxjXQ4zix2DK6SLi9awsuEgs7EVC1bjqaomV7d+F/Win6bgtxaQwVaiwT/X18GBh1lgZviT0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375181; c=relaxed/simple;
	bh=j8qYvzZvI3XovPlQJFxHBS9yhTrGdfKQztEwPacsJDc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kzsqjp4NOL2ScHvPnde/thafkkly93AjmUusq0/UPnDwMzOJz6r7kdyiHKc5o0KXAkCwtkGUB1HBaPnBRqYmBuBmx5Sm6IXNMJummKuN75qiNfKQa1MHLx4EyKhLH3zSiTj2KcACER4KD4Zob8dONWflnMAdLU+Fx7xyUgKWNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRtD5Ska; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375180; x=1787911180;
  h=date:from:to:cc:subject:message-id;
  bh=j8qYvzZvI3XovPlQJFxHBS9yhTrGdfKQztEwPacsJDc=;
  b=YRtD5Ska5rZBsmHvcuu34KgHsppmx72jCxu95+E/pGWG9LK/AVXyChxC
   mfbjDvKmEPyShVAbfPEfnoXSlxBno9UoUSmh5K2KVHnvpxMRESr2lpUxx
   31SaTljbhwgB1LWZEAzmYcRE+bWnD6QxBjdJDsu6HTi6/TMtYiJpVpXJ5
   M2VQaVynwMiF6ZS23LLG8k2cVtuBvO9mIE1bxWnlSKWE0Pk1m+MNbwp2Z
   3QvKmBJza5g4dx3n+/mBNXyRNpXiM2e7EWDUQqcUgWLMoQbWAFszLjmG4
   358sI/a87tiwDTnFia/prYrPWoKYykG5jXv5LUY6SC/Cdzu80JbcKujpz
   g==;
X-CSE-ConnectionGUID: y9+TPAp+RjuL1ji1erhzUw==
X-CSE-MsgGUID: QACQ/KJ9SbG5pdglPFhwxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70011751"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70011751"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:59:39 -0700
X-CSE-ConnectionGUID: W6kkjlT0S6618sIxqpaPsA==
X-CSE-MsgGUID: hiZA3CaPRvSIu2cnnYjKMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169592824"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 28 Aug 2025 02:59:37 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urZP8-000Tcb-1g;
	Thu, 28 Aug 2025 09:59:02 +0000
Date: Thu, 28 Aug 2025 17:57:44 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/stm32] BUILD SUCCESS
 3cf6b1bf4d250c15ebe537d55b5e09a902c41971
Message-ID: <202508281735.hgf9bRlN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/stm32
branch HEAD: 3cf6b1bf4d250c15ebe537d55b5e09a902c41971  MAINTAINERS: Add entry for ST STM32MP25 PCIe drivers

elapsed time: 1221m

configs tested: 254
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250827    gcc-12.5.0
arc                   randconfig-001-20250828    clang-22
arc                   randconfig-002-20250827    gcc-8.5.0
arc                   randconfig-002-20250828    clang-22
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20250827    clang-22
arm                   randconfig-001-20250828    clang-22
arm                   randconfig-002-20250827    clang-22
arm                   randconfig-002-20250828    clang-22
arm                   randconfig-003-20250827    clang-22
arm                   randconfig-003-20250828    clang-22
arm                   randconfig-004-20250827    clang-22
arm                   randconfig-004-20250828    clang-22
arm                           u8500_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250827    gcc-11.5.0
arm64                 randconfig-001-20250828    clang-22
arm64                 randconfig-002-20250827    gcc-8.5.0
arm64                 randconfig-002-20250828    clang-22
arm64                 randconfig-003-20250827    clang-22
arm64                 randconfig-003-20250828    clang-22
arm64                 randconfig-004-20250827    gcc-9.5.0
arm64                 randconfig-004-20250828    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250827    gcc-10.5.0
csky                  randconfig-001-20250828    clang-22
csky                  randconfig-002-20250827    gcc-15.1.0
csky                  randconfig-002-20250828    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250827    clang-22
hexagon               randconfig-001-20250828    clang-22
hexagon               randconfig-002-20250827    clang-22
hexagon               randconfig-002-20250828    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250828    gcc-12
i386                  randconfig-002-20250828    gcc-12
i386                  randconfig-003-20250828    gcc-12
i386                  randconfig-004-20250828    gcc-12
i386                  randconfig-005-20250828    gcc-12
i386                  randconfig-006-20250828    gcc-12
i386                  randconfig-007-20250828    gcc-12
i386                  randconfig-011-20250828    clang-20
i386                  randconfig-012-20250828    clang-20
i386                  randconfig-013-20250828    clang-20
i386                  randconfig-014-20250828    clang-20
i386                  randconfig-015-20250828    clang-20
i386                  randconfig-016-20250828    clang-20
i386                  randconfig-017-20250828    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-001-20250828    clang-22
loongarch             randconfig-002-20250827    clang-22
loongarch             randconfig-002-20250828    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ci20_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250827    gcc-8.5.0
nios2                 randconfig-001-20250828    clang-22
nios2                 randconfig-002-20250827    gcc-11.5.0
nios2                 randconfig-002-20250828    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250827    gcc-12.5.0
parisc                randconfig-001-20250828    clang-22
parisc                randconfig-002-20250827    gcc-8.5.0
parisc                randconfig-002-20250828    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250827    clang-22
powerpc               randconfig-001-20250828    clang-22
powerpc               randconfig-002-20250827    clang-22
powerpc               randconfig-002-20250828    clang-22
powerpc               randconfig-003-20250827    clang-22
powerpc               randconfig-003-20250828    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250827    gcc-11.5.0
powerpc64             randconfig-001-20250828    clang-22
powerpc64             randconfig-002-20250827    gcc-11.5.0
powerpc64             randconfig-003-20250827    gcc-13.4.0
powerpc64             randconfig-003-20250828    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250827    clang-19
riscv                 randconfig-001-20250828    clang-19
riscv                 randconfig-002-20250827    clang-22
riscv                 randconfig-002-20250828    clang-19
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250827    gcc-13.4.0
s390                  randconfig-001-20250828    clang-19
s390                  randconfig-002-20250827    gcc-8.5.0
s390                  randconfig-002-20250828    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250827    gcc-15.1.0
sh                    randconfig-001-20250828    clang-19
sh                    randconfig-002-20250827    gcc-9.5.0
sh                    randconfig-002-20250828    clang-19
sh                          rsk7264_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250827    gcc-15.1.0
sparc                 randconfig-001-20250828    clang-19
sparc                 randconfig-002-20250827    gcc-15.1.0
sparc                 randconfig-002-20250828    clang-19
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250827    gcc-11.5.0
sparc64               randconfig-001-20250828    clang-19
sparc64               randconfig-002-20250827    gcc-8.5.0
sparc64               randconfig-002-20250828    clang-19
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250827    gcc-12
um                    randconfig-001-20250828    clang-19
um                    randconfig-002-20250827    clang-22
um                    randconfig-002-20250828    clang-19
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250827    clang-20
x86_64      buildonly-randconfig-001-20250828    gcc-12
x86_64      buildonly-randconfig-002-20250827    clang-20
x86_64      buildonly-randconfig-002-20250828    gcc-12
x86_64      buildonly-randconfig-003-20250827    gcc-12
x86_64      buildonly-randconfig-003-20250828    gcc-12
x86_64      buildonly-randconfig-004-20250827    gcc-12
x86_64      buildonly-randconfig-004-20250828    gcc-12
x86_64      buildonly-randconfig-005-20250827    clang-20
x86_64      buildonly-randconfig-005-20250828    gcc-12
x86_64      buildonly-randconfig-006-20250827    clang-20
x86_64      buildonly-randconfig-006-20250828    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250828    clang-20
x86_64                randconfig-002-20250828    clang-20
x86_64                randconfig-003-20250828    clang-20
x86_64                randconfig-004-20250828    clang-20
x86_64                randconfig-005-20250828    clang-20
x86_64                randconfig-006-20250828    clang-20
x86_64                randconfig-007-20250828    clang-20
x86_64                randconfig-008-20250828    clang-20
x86_64                randconfig-071-20250828    clang-20
x86_64                randconfig-072-20250828    clang-20
x86_64                randconfig-073-20250828    clang-20
x86_64                randconfig-074-20250828    clang-20
x86_64                randconfig-075-20250828    clang-20
x86_64                randconfig-076-20250828    clang-20
x86_64                randconfig-077-20250828    clang-20
x86_64                randconfig-078-20250828    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250827    gcc-10.5.0
xtensa                randconfig-001-20250828    clang-19
xtensa                randconfig-002-20250827    gcc-10.5.0
xtensa                randconfig-002-20250828    clang-19

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

