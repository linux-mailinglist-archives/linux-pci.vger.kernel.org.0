Return-Path: <linux-pci+bounces-26323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6CDA94BF9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 06:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B09188AA6D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 04:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D42571DA;
	Mon, 21 Apr 2025 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xd9jHh/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402FD531
	for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209631; cv=none; b=Y1v217BLKuyDzIGJ9xhBiqfwmQVBGCV+wlJemG9zwp9qxZtfPEPvwbx9w07ofo2aB5yBJbz+SsRvrLIJo6STRz8uwFCpNf5E6PlohTT+UPqHnJhPBrmNJdv9FKyyAaqCv8zz19u0EcdHsLA6cDr47GfLDyB12+OHS4emmAZ/Nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209631; c=relaxed/simple;
	bh=6JpkLbjXTIoISbPasLUlQV2imwMPVSzsRZBaWfYEtM0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y5TEn7as9pF6HSccFuQwV8o3oxLQ+ju8kbDYlCnURt0AU9MGVpE4HpCK7qCg2iQzWkO/7U9JQvIltlzLroAZifpFivPM2hU9+m7JQhnFotqP6ECRb2Dfnrri6lBSiFPs+MJ0WEIPbDvyWe7w6zt86G85CRFbo7j53yUqw1JOYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xd9jHh/w; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745209629; x=1776745629;
  h=date:from:to:cc:subject:message-id;
  bh=6JpkLbjXTIoISbPasLUlQV2imwMPVSzsRZBaWfYEtM0=;
  b=Xd9jHh/wipL4BXFp70SWmlr8cId9C1PFaiMhvwMFAAJKSrOXoSzqSPdm
   oE1xpGj1LY29brQzBDBynJPAXBqTCURvn9uAsjedwZ8/g4Lexrd3WQV7r
   iq3ZURacsUYAq7uNiLvuQgI5cVVlgZWB4mhw9IbMlSnBzN/+15uKy89Vt
   9MmCh/W1/D9I95VU2fmdaK39gqIZ5tnt0Vfe3mJoSV5pGyVB3q0HCPw+y
   k6Rqe+Nigol+8XZ10E5NJ6yGAfvoyYRyewBhr0Md8ZyjDX08S4ET3M2zU
   RMmNZ1aSq+UMy+ssQp/mCFbz/zuE0RmdYIKS6WSJXxwF8fWu76WChg3I0
   Q==;
X-CSE-ConnectionGUID: +citnHmmT+u0chS8q3otnw==
X-CSE-MsgGUID: JB2Ca2L3TtuapgLtLckYBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46747308"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="46747308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 21:27:09 -0700
X-CSE-ConnectionGUID: u/enun+KQUCIhpK1CpDZxQ==
X-CSE-MsgGUID: bmSgyY+uTJW/e+esNxyqxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="132139771"
Received: from lkp-server01.sh.intel.com (HELO 9c2f37e2d822) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Apr 2025 21:27:07 -0700
Received: from kbuild by 9c2f37e2d822 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6ikL-00007v-1E;
	Mon, 21 Apr 2025 04:27:05 +0000
Date: Mon, 21 Apr 2025 12:26:05 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 a7d824b2df0d8b9e19c334594cdbffab97ff8d66
Message-ID: <202504211255.kqIJahnt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: a7d824b2df0d8b9e19c334594cdbffab97ff8d66  PCI: rockchip-ep: Mark RK3399 as intx_capable

elapsed time: 1445m

configs tested: 205
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250420    gcc-12.4.0
arc                   randconfig-002-20250420    gcc-12.4.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-21
arm                                 defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20250420    clang-21
arm                   randconfig-002-20250420    gcc-8.5.0
arm                   randconfig-003-20250420    gcc-7.5.0
arm                   randconfig-004-20250420    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250420    gcc-8.5.0
arm64                 randconfig-002-20250420    gcc-8.5.0
arm64                 randconfig-003-20250420    clang-21
arm64                 randconfig-004-20250420    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250420    gcc-14.2.0
csky                  randconfig-002-20250420    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250420    clang-21
hexagon               randconfig-002-20250420    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250420    clang-20
i386        buildonly-randconfig-002-20250420    clang-20
i386        buildonly-randconfig-003-20250420    clang-20
i386        buildonly-randconfig-004-20250420    clang-20
i386        buildonly-randconfig-005-20250420    clang-20
i386        buildonly-randconfig-006-20250420    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250421    gcc-12
i386                  randconfig-002-20250421    gcc-12
i386                  randconfig-003-20250421    gcc-12
i386                  randconfig-004-20250421    gcc-12
i386                  randconfig-005-20250421    gcc-12
i386                  randconfig-006-20250421    gcc-12
i386                  randconfig-007-20250421    gcc-12
i386                  randconfig-011-20250421    clang-20
i386                  randconfig-012-20250421    clang-20
i386                  randconfig-013-20250421    clang-20
i386                  randconfig-014-20250421    clang-20
i386                  randconfig-015-20250421    clang-20
i386                  randconfig-016-20250421    clang-20
i386                  randconfig-017-20250421    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250420    gcc-12.4.0
loongarch             randconfig-002-20250420    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250420    gcc-14.2.0
nios2                 randconfig-002-20250420    gcc-8.5.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250420    gcc-13.3.0
parisc                randconfig-002-20250420    gcc-7.5.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-21
powerpc                    gamecube_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250420    clang-21
powerpc               randconfig-002-20250420    gcc-6.5.0
powerpc               randconfig-003-20250420    clang-21
powerpc                     tqm8541_defconfig    clang-21
powerpc                     tqm8548_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250420    gcc-8.5.0
powerpc64             randconfig-002-20250420    clang-21
powerpc64             randconfig-003-20250420    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                    nommu_k210_defconfig    clang-21
riscv                 randconfig-001-20250420    clang-21
riscv                 randconfig-002-20250420    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250420    gcc-6.5.0
s390                  randconfig-002-20250420    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250420    gcc-14.2.0
sh                    randconfig-002-20250420    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250420    gcc-11.5.0
sparc                 randconfig-002-20250420    gcc-7.5.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250420    gcc-9.3.0
sparc64               randconfig-002-20250420    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250420    gcc-12
um                    randconfig-002-20250420    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250420    clang-20
x86_64      buildonly-randconfig-002-20250420    gcc-12
x86_64      buildonly-randconfig-003-20250420    gcc-12
x86_64      buildonly-randconfig-004-20250420    gcc-12
x86_64      buildonly-randconfig-005-20250420    clang-20
x86_64      buildonly-randconfig-006-20250420    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250421    clang-20
x86_64                randconfig-002-20250421    clang-20
x86_64                randconfig-003-20250421    clang-20
x86_64                randconfig-004-20250421    clang-20
x86_64                randconfig-005-20250421    clang-20
x86_64                randconfig-006-20250421    clang-20
x86_64                randconfig-007-20250421    clang-20
x86_64                randconfig-008-20250421    clang-20
x86_64                randconfig-071-20250421    gcc-12
x86_64                randconfig-072-20250421    gcc-12
x86_64                randconfig-073-20250421    gcc-12
x86_64                randconfig-074-20250421    gcc-12
x86_64                randconfig-075-20250421    gcc-12
x86_64                randconfig-076-20250421    gcc-12
x86_64                randconfig-077-20250421    gcc-12
x86_64                randconfig-078-20250421    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250420    gcc-9.3.0
xtensa                randconfig-002-20250420    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

