Return-Path: <linux-pci+bounces-10219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A69300AA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D051C21143
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170C288B1;
	Fri, 12 Jul 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXCd5uSo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909F1CD25
	for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811028; cv=none; b=ubRsWsbVhsFRKlkR0osGCE5mzkVAv4dUTmc1ZtlSkOBR4VWEXR4fCj0RIoGSFV5srRJTGWpjBYYxkTOCrtA3KEkK0cXJq/HGmP+6VQ4LXT3WDh/T4IKLkLlzYn+zTRWC6j6qjO2yDR2O3qWN7lQlTHgRvZMfeSye0Zpq8m5DKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811028; c=relaxed/simple;
	bh=AZUqdkvSbBxyebcpx8doaZDqs3EYWqP7e+1ksuNCS0U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i6ZZHG+Vfwsjs8i2GMLViQqtKrvuotkNCvmkJcQmv9DlIlZ5puBrtwnCnTcnTWphplTXu0QQelhiXj3sZhOg6SSbcUBlX8FEaR96f93o1JB+f8Layp71MK1T8lf7P+eGPt5kfNb1qbL+bJV24uHoLK6ictYGOu5e9kMfMqg4k2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXCd5uSo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720811026; x=1752347026;
  h=date:from:to:cc:subject:message-id;
  bh=AZUqdkvSbBxyebcpx8doaZDqs3EYWqP7e+1ksuNCS0U=;
  b=bXCd5uSoaGPaDpMFu4r56tvMboiSEhys8vNXqtusQ188uCkkcniuNVjk
   8/0VNqD0lakOEbnXRjMT2uGg1/Y3jcwYvoWHdo+yo3+ssH0zdDcX7Od5z
   XnRFjwlbZVFG/d0cvB+zCcniFCFsmcme4vWiPar3I0HyhxZ40VEtJcnFN
   VNulmxuqU1VC/qvBFyy6hjOsIwjbccrmRZM5oBbeqsXwQF05yTdZPVZHZ
   QdcaiDFa+ItGbuhO3Dd9RD2fk9miFruhf4S+GY4Y09DkhbCExW62HPgQN
   wseYCyAwvliZBcEeXYmmkmhMLY3Tlfo7FVnyZaDMdFqdTHwNBX9PVoOX3
   w==;
X-CSE-ConnectionGUID: ondBmBpfTFSqC5H1bJ6NBA==
X-CSE-MsgGUID: ii0FMSkuQxKdWBY5TcUc3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18407872"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="18407872"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:03:44 -0700
X-CSE-ConnectionGUID: 8deOyN6CS4yK8cIJKNP7bQ==
X-CSE-MsgGUID: p8RAi9qYSoiQG5CF4UhxkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="86503503"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Jul 2024 12:03:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSLYS-000b9y-1R;
	Fri, 12 Jul 2024 19:03:40 +0000
Date: Sat, 13 Jul 2024 03:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 f00059b4c1b068df108c70f86749b23f9080d2ba
Message-ID: <202407130347.RnjOfbAu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: f00059b4c1b068df108c70f86749b23f9080d2ba  drm/vboxvideo: fix mapping leaks

elapsed time: 1250m

configs tested: 198
configs skipped: 6

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
arc                   randconfig-001-20240712   gcc-13.2.0
arc                   randconfig-002-20240712   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   clang-17
arm                         lpc18xx_defconfig   clang-17
arm                         lpc18xx_defconfig   clang-19
arm                        multi_v7_defconfig   clang-17
arm                   randconfig-001-20240712   gcc-13.2.0
arm                   randconfig-002-20240712   gcc-13.2.0
arm                   randconfig-003-20240712   gcc-13.2.0
arm                   randconfig-004-20240712   gcc-13.2.0
arm                         s5pv210_defconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240712   gcc-13.2.0
arm64                 randconfig-002-20240712   gcc-13.2.0
arm64                 randconfig-003-20240712   gcc-13.2.0
arm64                 randconfig-004-20240712   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240712   gcc-13.2.0
csky                  randconfig-002-20240712   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240712   gcc-9
i386         buildonly-randconfig-002-20240712   clang-18
i386         buildonly-randconfig-002-20240712   gcc-9
i386         buildonly-randconfig-003-20240712   clang-18
i386         buildonly-randconfig-003-20240712   gcc-9
i386         buildonly-randconfig-004-20240712   clang-18
i386         buildonly-randconfig-004-20240712   gcc-9
i386         buildonly-randconfig-005-20240712   gcc-11
i386         buildonly-randconfig-005-20240712   gcc-9
i386         buildonly-randconfig-006-20240712   clang-18
i386         buildonly-randconfig-006-20240712   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240712   clang-18
i386                  randconfig-001-20240712   gcc-9
i386                  randconfig-002-20240712   clang-18
i386                  randconfig-002-20240712   gcc-9
i386                  randconfig-003-20240712   clang-18
i386                  randconfig-003-20240712   gcc-9
i386                  randconfig-004-20240712   clang-18
i386                  randconfig-004-20240712   gcc-9
i386                  randconfig-005-20240712   clang-18
i386                  randconfig-005-20240712   gcc-9
i386                  randconfig-006-20240712   clang-18
i386                  randconfig-006-20240712   gcc-9
i386                  randconfig-011-20240712   clang-18
i386                  randconfig-011-20240712   gcc-9
i386                  randconfig-012-20240712   clang-18
i386                  randconfig-012-20240712   gcc-9
i386                  randconfig-013-20240712   clang-18
i386                  randconfig-013-20240712   gcc-9
i386                  randconfig-014-20240712   gcc-10
i386                  randconfig-014-20240712   gcc-9
i386                  randconfig-015-20240712   gcc-10
i386                  randconfig-015-20240712   gcc-9
i386                  randconfig-016-20240712   gcc-12
i386                  randconfig-016-20240712   gcc-9
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240712   gcc-13.2.0
loongarch             randconfig-002-20240712   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath79_defconfig   clang-17
mips                           ci20_defconfig   clang-17
mips                     decstation_defconfig   clang-19
mips                            gpr_defconfig   clang-19
mips                        omega2p_defconfig   clang-17
mips                      pic32mzda_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240712   gcc-13.2.0
nios2                 randconfig-002-20240712   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240712   gcc-13.2.0
parisc                randconfig-002-20240712   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      cm5200_defconfig   clang-19
powerpc                        fsp2_defconfig   clang-17
powerpc                  iss476-smp_defconfig   clang-19
powerpc                      mgcoge_defconfig   clang-19
powerpc                 mpc8313_rdb_defconfig   clang-17
powerpc                 mpc834x_itx_defconfig   clang-19
powerpc               randconfig-001-20240712   gcc-13.2.0
powerpc               randconfig-002-20240712   gcc-13.2.0
powerpc               randconfig-003-20240712   gcc-13.2.0
powerpc64                        alldefconfig   clang-17
powerpc64             randconfig-001-20240712   gcc-13.2.0
powerpc64             randconfig-002-20240712   gcc-13.2.0
powerpc64             randconfig-003-20240712   gcc-13.2.0
riscv                            alldefconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240712   gcc-13.2.0
riscv                 randconfig-002-20240712   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240712   gcc-13.2.0
s390                  randconfig-002-20240712   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-17
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240712   gcc-13.2.0
sh                    randconfig-002-20240712   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240712   gcc-13.2.0
sparc64               randconfig-002-20240712   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240712   gcc-13.2.0
um                    randconfig-002-20240712   gcc-13.2.0
um                           x86_64_defconfig   clang-17
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240712   clang-18
x86_64       buildonly-randconfig-002-20240712   clang-18
x86_64       buildonly-randconfig-003-20240712   clang-18
x86_64       buildonly-randconfig-004-20240712   clang-18
x86_64       buildonly-randconfig-005-20240712   clang-18
x86_64       buildonly-randconfig-006-20240712   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240712   clang-18
x86_64                randconfig-002-20240712   clang-18
x86_64                randconfig-003-20240712   clang-18
x86_64                randconfig-004-20240712   clang-18
x86_64                randconfig-005-20240712   clang-18
x86_64                randconfig-006-20240712   clang-18
x86_64                randconfig-011-20240712   clang-18
x86_64                randconfig-012-20240712   clang-18
x86_64                randconfig-013-20240712   clang-18
x86_64                randconfig-014-20240712   clang-18
x86_64                randconfig-015-20240712   clang-18
x86_64                randconfig-016-20240712   clang-18
x86_64                randconfig-071-20240712   clang-18
x86_64                randconfig-072-20240712   clang-18
x86_64                randconfig-073-20240712   clang-18
x86_64                randconfig-074-20240712   clang-18
x86_64                randconfig-075-20240712   clang-18
x86_64                randconfig-076-20240712   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240712   gcc-13.2.0
xtensa                randconfig-002-20240712   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

