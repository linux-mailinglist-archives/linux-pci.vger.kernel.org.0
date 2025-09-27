Return-Path: <linux-pci+bounces-37160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428E4BA61E1
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 19:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9073A1677
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CF1EA7C9;
	Sat, 27 Sep 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1z7za1f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB522424E
	for <linux-pci@vger.kernel.org>; Sat, 27 Sep 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758992833; cv=none; b=guFRLs0+kDhOBnnhue/8eoWQsbmYGm4BFM7kVy52sSvg5JYmcDPrillEnTYNAJtNCPdQCrB2lFczxovso4v9spBXV0ijnMi41xej+0gUP0A8cT/JhM5BicydLaMEMai3xJvqNM4xvjMbB/U73ccRJf5ocEhS34DrlKKNQAMYOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758992833; c=relaxed/simple;
	bh=Hem0QkDKbSCaWH84Yceq/G/G3Q83HWQJ7satAH9Y7XI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rgjsMa2++MqHk1doJN4fWXYDxmzSXuxIuPfPIjFUzl39JGasRzmkLhpPB+iqRn0rLVQnvTpG3hBOB5X5lLhxe3yl/kF+uEPMKKV9usGPioHuDUXAr/6lE6FQPnUWimqw/3evjdHlCmoGm/Kf5nv54o/Vca1gAT06YNRT4jtOvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1z7za1f; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758992832; x=1790528832;
  h=date:from:to:cc:subject:message-id;
  bh=Hem0QkDKbSCaWH84Yceq/G/G3Q83HWQJ7satAH9Y7XI=;
  b=n1z7za1fI2QWsz6LzEfgIE7pIIz8AXfSUI3Cwy1AibxrQSPcMHBTeMIq
   /Zb6YUW70EwpoTAaS+TQ6TGFhCiNlRIm4EZOIPseKq5Avqdv8Stw4LlXm
   cYf6iiNdSW5X5FjDQFOUQayXida7UJa6hewjhbPKrrDT8JNOA612D93T3
   lTpNmddgZ4B7VHEk9BvyMlydhhfuAZfjEMrwuZ4ZaKrx9NhCUIE0NNaSG
   AyCW1j5JaD4ZlgW7dN7G9r1rm/P7kWBIxyJMNxmjtWwOaV+jDr2PH+HZX
   oQOmz9Q+XSo/eu06arunwVw6ohlrBU/Z4MnLkrc/YeSgQgFUEmgceavV2
   w==;
X-CSE-ConnectionGUID: hBh30WYxSyS25D2XR3Kmbg==
X-CSE-MsgGUID: ZzD1jkTATJin7E3miAwxwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="61002874"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="61002874"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 10:07:11 -0700
X-CSE-ConnectionGUID: NOw9PrScTZCA4CYDUb0bHg==
X-CSE-MsgGUID: I5uCqSbZRaOVA2nzcdpWSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="201539694"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Sep 2025 10:07:09 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2YO3-0007E3-13;
	Sat, 27 Sep 2025 17:07:07 +0000
Date: Sun, 28 Sep 2025 01:06:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 cef730075cfe2b2091e3c94471cc0a78405401d5
Message-ID: <202509280151.54AuD4d1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: cef730075cfe2b2091e3c94471cc0a78405401d5  PCI: dwc: Support 16-lane operation

elapsed time: 1155m

configs tested: 210
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250927    gcc-10.5.0
arc                   randconfig-002-20250927    gcc-10.5.0
arc                   randconfig-002-20250927    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                          exynos_defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                   randconfig-001-20250927    clang-18
arm                   randconfig-001-20250927    gcc-10.5.0
arm                   randconfig-002-20250927    clang-16
arm                   randconfig-002-20250927    gcc-10.5.0
arm                   randconfig-003-20250927    gcc-10.5.0
arm                   randconfig-003-20250927    gcc-8.5.0
arm                   randconfig-004-20250927    gcc-10.5.0
arm                        spear3xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250927    gcc-10.5.0
arm64                 randconfig-001-20250927    gcc-8.5.0
arm64                 randconfig-002-20250927    gcc-10.5.0
arm64                 randconfig-002-20250927    gcc-11.5.0
arm64                 randconfig-003-20250927    clang-22
arm64                 randconfig-003-20250927    gcc-10.5.0
arm64                 randconfig-004-20250927    gcc-10.5.0
arm64                 randconfig-004-20250927    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250927    clang-22
csky                  randconfig-001-20250927    gcc-15.1.0
csky                  randconfig-002-20250927    clang-22
csky                  randconfig-002-20250927    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250927    clang-22
hexagon               randconfig-002-20250927    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250927    clang-20
i386        buildonly-randconfig-002-20250927    clang-20
i386        buildonly-randconfig-002-20250927    gcc-14
i386        buildonly-randconfig-003-20250927    clang-20
i386        buildonly-randconfig-004-20250927    clang-20
i386        buildonly-randconfig-005-20250927    clang-20
i386        buildonly-randconfig-005-20250927    gcc-12
i386        buildonly-randconfig-006-20250927    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250927    gcc-14
i386                  randconfig-002-20250927    gcc-14
i386                  randconfig-003-20250927    gcc-14
i386                  randconfig-004-20250927    gcc-14
i386                  randconfig-005-20250927    gcc-14
i386                  randconfig-006-20250927    gcc-14
i386                  randconfig-007-20250927    gcc-14
i386                  randconfig-011-20250927    clang-20
i386                  randconfig-012-20250927    clang-20
i386                  randconfig-013-20250927    clang-20
i386                  randconfig-014-20250927    clang-20
i386                  randconfig-015-20250927    clang-20
i386                  randconfig-016-20250927    clang-20
i386                  randconfig-017-20250927    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250927    clang-22
loongarch             randconfig-001-20250927    gcc-15.1.0
loongarch             randconfig-002-20250927    clang-18
loongarch             randconfig-002-20250927    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250927    clang-22
nios2                 randconfig-001-20250927    gcc-9.5.0
nios2                 randconfig-002-20250927    clang-22
nios2                 randconfig-002-20250927    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250927    clang-22
parisc                randconfig-001-20250927    gcc-9.5.0
parisc                randconfig-002-20250927    clang-22
parisc                randconfig-002-20250927    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250927    clang-22
powerpc               randconfig-001-20250927    gcc-13.4.0
powerpc               randconfig-002-20250927    clang-22
powerpc               randconfig-003-20250927    clang-22
powerpc               randconfig-003-20250927    gcc-8.5.0
powerpc64             randconfig-001-20250927    clang-22
powerpc64             randconfig-002-20250927    clang-22
powerpc64             randconfig-002-20250927    gcc-15.1.0
powerpc64             randconfig-003-20250927    clang-22
powerpc64             randconfig-003-20250927    gcc-12.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250927    clang-22
riscv                 randconfig-001-20250927    gcc-11.5.0
riscv                 randconfig-002-20250927    gcc-11.5.0
riscv                 randconfig-002-20250927    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250927    clang-22
s390                  randconfig-001-20250927    gcc-11.5.0
s390                  randconfig-002-20250927    clang-22
s390                  randconfig-002-20250927    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250927    gcc-11.5.0
sh                    randconfig-001-20250927    gcc-15.1.0
sh                    randconfig-002-20250927    gcc-11.5.0
sh                    randconfig-002-20250927    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250927    gcc-11.5.0
sparc                 randconfig-002-20250927    gcc-11.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250927    gcc-11.5.0
sparc64               randconfig-001-20250927    gcc-15.1.0
sparc64               randconfig-002-20250927    gcc-11.5.0
sparc64               randconfig-002-20250927    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250927    gcc-11.5.0
um                    randconfig-001-20250927    gcc-14
um                    randconfig-002-20250927    clang-22
um                    randconfig-002-20250927    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250927    gcc-14
x86_64      buildonly-randconfig-002-20250927    clang-20
x86_64      buildonly-randconfig-002-20250927    gcc-14
x86_64      buildonly-randconfig-003-20250927    clang-20
x86_64      buildonly-randconfig-003-20250927    gcc-14
x86_64      buildonly-randconfig-004-20250927    gcc-14
x86_64      buildonly-randconfig-005-20250927    gcc-14
x86_64      buildonly-randconfig-006-20250927    clang-20
x86_64      buildonly-randconfig-006-20250927    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250927    clang-20
x86_64                randconfig-002-20250927    clang-20
x86_64                randconfig-003-20250927    clang-20
x86_64                randconfig-004-20250927    clang-20
x86_64                randconfig-005-20250927    clang-20
x86_64                randconfig-006-20250927    clang-20
x86_64                randconfig-007-20250927    clang-20
x86_64                randconfig-008-20250927    clang-20
x86_64                randconfig-071-20250927    gcc-14
x86_64                randconfig-072-20250927    gcc-14
x86_64                randconfig-073-20250927    gcc-14
x86_64                randconfig-074-20250927    gcc-14
x86_64                randconfig-075-20250927    gcc-14
x86_64                randconfig-076-20250927    gcc-14
x86_64                randconfig-077-20250927    gcc-14
x86_64                randconfig-078-20250927    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250927    gcc-11.5.0
xtensa                randconfig-001-20250927    gcc-8.5.0
xtensa                randconfig-002-20250927    gcc-10.5.0
xtensa                randconfig-002-20250927    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

