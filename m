Return-Path: <linux-pci+bounces-34799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC5B37507
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 00:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE687C1E7F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 22:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B5944F;
	Tue, 26 Aug 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apEujSbD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139730CDB4
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248568; cv=none; b=Lm4+kBoNWONZiErx8bT+QH5cT8JHOcEufWqpSOAB2l4LF+SYNiS7YnX9AJwWMZsXx9oucVqjk49aYgkkRxeFPbMg+sCSWHb1zT0p0v3TA8EpLumxn3J8N4qt7dz+zWWy0iJD7tYDbilqmSLuX0m1h+ccCv9LJIFecZOrYFSn0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248568; c=relaxed/simple;
	bh=zbyh0uBoSsefksYkNE828ZLwMxTVy9QC1vV1wbHscJQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Cegi8F2ioMSs7mZRaMzJtia/Bp01dp9poliUVwF3LArHyCald5p7qTCdEW85sU3v29mYlFlEdI4/CN4AaX1enCsYbV96pZ+n9VZvV+UnbjF62Hn8ln5Uxt2f/NBMzSHBqBql+Fbg9K7xRPQOR1ibPiuksXNjHTeZwzHQD/gY3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apEujSbD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756248567; x=1787784567;
  h=date:from:to:cc:subject:message-id;
  bh=zbyh0uBoSsefksYkNE828ZLwMxTVy9QC1vV1wbHscJQ=;
  b=apEujSbD5ly5Re5txVnkM2vf5mxrfpvuUBxZGwJc2bARaLtHN4Inw4zC
   mttyiTPpmtdHJYCQcsC+BIjv/J/bSl3zq3BzJAoYFepofxJ+SV5vwtx79
   SvvWc4ER9txuCr3/OaQxIxFU/zYSOTpzxK1uWM3aMetknnXhXo/HIgyH6
   nevL4ZIzN71dsPUK52MsM+E/k2++RykFRefupRPuzYtZ/8f2bggDpLnQl
   gut4b80XtmPL3SwzFN2IDKhBPFvmT5rAn1UG26OarSZolmG1bZdy4CLZt
   PxF2tumbk95PkwC9xY2TRR46ZdTERfpaLRIKXvYw0Gf2D1UPNOzAcO8rd
   g==;
X-CSE-ConnectionGUID: D7NmPFM3RyicA3TaoxlnUw==
X-CSE-MsgGUID: VokYh938R1C/RjPM0JFhIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61133110"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61133110"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 15:49:26 -0700
X-CSE-ConnectionGUID: xNz0lmVrTq2OlmMpMECgHg==
X-CSE-MsgGUID: u+hhQijkTfe+nofQZwqdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169870738"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Aug 2025 15:49:25 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur2Ti-000STD-18;
	Tue, 26 Aug 2025 22:49:22 +0000
Date: Wed, 27 Aug 2025 06:48:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 dab2c5f9399591a50f9e9746fca6bb47f6ac04ae
Message-ID: <202508270628.j6nXznlV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: dab2c5f9399591a50f9e9746fca6bb47f6ac04ae  PCI/ACPI: Fix pci_acpi_preserve_config() memory leak

elapsed time: 1398m

configs tested: 214
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    clang-22
arc                                 defconfig    clang-19
arc                   randconfig-001-20250826    gcc-11.5.0
arc                   randconfig-001-20250827    gcc-8.5.0
arc                   randconfig-002-20250826    gcc-8.5.0
arc                   randconfig-002-20250827    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           imxrt_defconfig    clang-22
arm                   randconfig-001-20250826    gcc-12.5.0
arm                   randconfig-001-20250827    gcc-8.5.0
arm                   randconfig-002-20250826    gcc-13.4.0
arm                   randconfig-002-20250827    gcc-8.5.0
arm                   randconfig-003-20250826    gcc-8.5.0
arm                   randconfig-003-20250827    gcc-8.5.0
arm                   randconfig-004-20250826    gcc-10.5.0
arm                   randconfig-004-20250827    gcc-8.5.0
arm                           sunxi_defconfig    clang-22
arm                           tegra_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250826    clang-22
arm64                 randconfig-001-20250827    gcc-8.5.0
arm64                 randconfig-002-20250826    gcc-8.5.0
arm64                 randconfig-002-20250827    gcc-8.5.0
arm64                 randconfig-003-20250826    clang-22
arm64                 randconfig-003-20250827    gcc-8.5.0
arm64                 randconfig-004-20250826    gcc-8.5.0
arm64                 randconfig-004-20250827    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250826    gcc-15.1.0
csky                  randconfig-001-20250827    gcc-15.1.0
csky                  randconfig-002-20250826    gcc-11.5.0
csky                  randconfig-002-20250827    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250826    clang-19
hexagon               randconfig-001-20250827    gcc-15.1.0
hexagon               randconfig-002-20250826    clang-22
hexagon               randconfig-002-20250827    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250826    gcc-12
i386        buildonly-randconfig-002-20250826    gcc-12
i386        buildonly-randconfig-003-20250826    clang-20
i386        buildonly-randconfig-004-20250826    gcc-12
i386        buildonly-randconfig-005-20250826    clang-20
i386        buildonly-randconfig-006-20250826    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250827    clang-20
i386                  randconfig-002-20250827    clang-20
i386                  randconfig-003-20250827    clang-20
i386                  randconfig-004-20250827    clang-20
i386                  randconfig-005-20250827    clang-20
i386                  randconfig-006-20250827    clang-20
i386                  randconfig-007-20250827    clang-20
i386                  randconfig-011-20250827    clang-20
i386                  randconfig-012-20250827    clang-20
i386                  randconfig-013-20250827    clang-20
i386                  randconfig-014-20250827    clang-20
i386                  randconfig-015-20250827    clang-20
i386                  randconfig-016-20250827    clang-20
i386                  randconfig-017-20250827    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250826    gcc-14.3.0
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-002-20250826    gcc-14.3.0
loongarch             randconfig-002-20250827    gcc-15.1.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250826    gcc-8.5.0
nios2                 randconfig-001-20250827    gcc-15.1.0
nios2                 randconfig-002-20250826    gcc-10.5.0
nios2                 randconfig-002-20250827    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250826    gcc-8.5.0
parisc                randconfig-001-20250827    gcc-15.1.0
parisc                randconfig-002-20250826    gcc-15.1.0
parisc                randconfig-002-20250827    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250826    gcc-8.5.0
powerpc               randconfig-001-20250827    gcc-15.1.0
powerpc               randconfig-002-20250826    clang-22
powerpc               randconfig-002-20250827    gcc-15.1.0
powerpc               randconfig-003-20250826    gcc-13.4.0
powerpc               randconfig-003-20250827    gcc-15.1.0
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20250826    gcc-10.5.0
powerpc64             randconfig-001-20250827    gcc-15.1.0
powerpc64             randconfig-002-20250826    gcc-11.5.0
powerpc64             randconfig-002-20250827    gcc-15.1.0
powerpc64             randconfig-003-20250826    gcc-14.3.0
powerpc64             randconfig-003-20250827    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250826    gcc-8.5.0
riscv                 randconfig-002-20250826    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250826    clang-22
s390                  randconfig-002-20250826    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20250826    gcc-11.5.0
sh                    randconfig-002-20250826    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250826    gcc-13.4.0
sparc                 randconfig-002-20250826    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250826    gcc-8.5.0
sparc64               randconfig-002-20250826    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250826    gcc-12
um                    randconfig-002-20250826    clang-17
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250826    clang-20
x86_64      buildonly-randconfig-002-20250826    clang-20
x86_64      buildonly-randconfig-003-20250826    gcc-12
x86_64      buildonly-randconfig-004-20250826    clang-20
x86_64      buildonly-randconfig-005-20250826    gcc-12
x86_64      buildonly-randconfig-006-20250826    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250827    clang-20
x86_64                randconfig-002-20250827    clang-20
x86_64                randconfig-003-20250827    clang-20
x86_64                randconfig-004-20250827    clang-20
x86_64                randconfig-005-20250827    clang-20
x86_64                randconfig-006-20250827    clang-20
x86_64                randconfig-007-20250827    clang-20
x86_64                randconfig-008-20250827    clang-20
x86_64                randconfig-071-20250827    clang-20
x86_64                randconfig-072-20250827    clang-20
x86_64                randconfig-073-20250827    clang-20
x86_64                randconfig-074-20250827    clang-20
x86_64                randconfig-075-20250827    clang-20
x86_64                randconfig-076-20250827    clang-20
x86_64                randconfig-077-20250827    clang-20
x86_64                randconfig-078-20250827    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250826    gcc-11.5.0
xtensa                randconfig-002-20250826    gcc-8.5.0
xtensa                         virt_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

