Return-Path: <linux-pci+bounces-21530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611A6A3683D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 23:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F141891474
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776F1FC104;
	Fri, 14 Feb 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leq8GGwW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CF1953A9
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572047; cv=none; b=pCoegaDmb+atQfVnqDMvMmANGGm6z+BaxkmWYgOzWoVXhGTQpmodhu13LcM3fuB4svo/kJ7s16utCWIgG0AzvaeMgPtF34on6MYJChGDCy7YJaEGFXcXDyXAadx82c4/6ytUQACE8OHLG+G+SlESvT2MaToeJskAcv28MCkBt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572047; c=relaxed/simple;
	bh=NS4K9rJloeZnJhxWy6DLxOBmHXRwYhDE/t5eY55632A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gOTJ9ntudsRVENasHG89HfCESUoRjRyr+jpLslPjc3J8PLatz3THYdH3oInsdG3Tbs9OAO+kM38/capxapVsPovkhEFL92sYl/0vrQ5O2Dy7jUFENRpTw4Yg0nfuwDEftunGClEqcOxD8srLT0+2q2gWD9OMz67BcQbmwE2+JNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leq8GGwW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739572045; x=1771108045;
  h=date:from:to:cc:subject:message-id;
  bh=NS4K9rJloeZnJhxWy6DLxOBmHXRwYhDE/t5eY55632A=;
  b=leq8GGwWqIyDM9vih+CtuoqWv1a+sppdfQCP0M8wAj6NH54fmmiu6ekt
   iSsVAT4Ka3dyrTQHQm3SWhA827pMNLvRvwL5IYYjWXwPkZEM4A/eq1XFr
   ZfmWxixI02sh5yTz9uwEOA4EsTRWyF/pRZuSsHDzEXTkcPdRjdmZvC0Yk
   0lAbkajvdHpNpRMDejnciPrZZ/TRtSkuF9ZiG+uMUaNBzJyCD0e+WnRva
   ksgMc3ViyB7ux8PcLWP2oBlW+HvhU7FVsZrgPo8K0bf7kWrL/A8B0PJud
   ycfRy+5xyuimgCHShnamD3vddJ3im9uScAgkhpPZluLbyWKFRRE9RqdAJ
   g==;
X-CSE-ConnectionGUID: qgnIye4yTgK1n1GEeBi7dQ==
X-CSE-MsgGUID: OapHYYGIQaa5BehqnyDZYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40603823"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40603823"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 14:27:24 -0800
X-CSE-ConnectionGUID: 9LK8sgZmT+eOh1SXXqVndg==
X-CSE-MsgGUID: z+EDLKKfTBihlbiX9hJXsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113555933"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Feb 2025 14:27:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj49Z-001AER-1f;
	Fri, 14 Feb 2025 22:27:21 +0000
Date: Sat, 15 Feb 2025 06:26:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 4d3c0ff1d632ecc4e5e66aec04d9b3e6efa16de4
Message-ID: <202502150618.l1GxfiF4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 4d3c0ff1d632ecc4e5e66aec04d9b3e6efa16de4  PCI: Rework optional resource handling

elapsed time: 1448m

configs tested: 290
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250214    gcc-13.2.0
arc                   randconfig-001-20250214    gcc-14.2.0
arc                   randconfig-001-20250215    clang-17
arc                   randconfig-002-20250214    gcc-13.2.0
arc                   randconfig-002-20250214    gcc-14.2.0
arc                   randconfig-002-20250215    clang-17
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250214    clang-16
arm                   randconfig-001-20250214    gcc-14.2.0
arm                   randconfig-001-20250215    clang-17
arm                   randconfig-002-20250214    gcc-14.2.0
arm                   randconfig-002-20250215    clang-17
arm                   randconfig-003-20250214    clang-21
arm                   randconfig-003-20250214    gcc-14.2.0
arm                   randconfig-003-20250215    clang-17
arm                   randconfig-004-20250214    gcc-14.2.0
arm                   randconfig-004-20250215    clang-17
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250214    gcc-14.2.0
arm64                 randconfig-001-20250215    clang-17
arm64                 randconfig-002-20250214    gcc-14.2.0
arm64                 randconfig-002-20250215    clang-17
arm64                 randconfig-003-20250214    gcc-14.2.0
arm64                 randconfig-003-20250215    clang-17
arm64                 randconfig-004-20250214    gcc-14.2.0
arm64                 randconfig-004-20250215    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250214    clang-21
csky                  randconfig-001-20250214    gcc-14.2.0
csky                  randconfig-001-20250215    clang-21
csky                  randconfig-002-20250214    clang-21
csky                  randconfig-002-20250214    gcc-14.2.0
csky                  randconfig-002-20250215    clang-21
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250214    clang-21
hexagon               randconfig-001-20250215    clang-21
hexagon               randconfig-002-20250214    clang-15
hexagon               randconfig-002-20250214    clang-21
hexagon               randconfig-002-20250215    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250214    gcc-12
i386        buildonly-randconfig-001-20250215    clang-19
i386        buildonly-randconfig-002-20250214    gcc-12
i386        buildonly-randconfig-002-20250215    clang-19
i386        buildonly-randconfig-003-20250214    clang-19
i386        buildonly-randconfig-003-20250214    gcc-12
i386        buildonly-randconfig-003-20250215    clang-19
i386        buildonly-randconfig-004-20250214    gcc-12
i386        buildonly-randconfig-004-20250215    clang-19
i386        buildonly-randconfig-005-20250214    gcc-12
i386        buildonly-randconfig-005-20250215    clang-19
i386        buildonly-randconfig-006-20250214    gcc-12
i386        buildonly-randconfig-006-20250215    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250214    gcc-12
i386                  randconfig-002-20250214    gcc-12
i386                  randconfig-003-20250214    gcc-12
i386                  randconfig-004-20250214    gcc-12
i386                  randconfig-005-20250214    gcc-12
i386                  randconfig-006-20250214    gcc-12
i386                  randconfig-007-20250214    gcc-12
i386                  randconfig-011-20250214    clang-19
i386                  randconfig-011-20250215    gcc-12
i386                  randconfig-012-20250214    clang-19
i386                  randconfig-012-20250215    gcc-12
i386                  randconfig-013-20250214    clang-19
i386                  randconfig-013-20250215    gcc-12
i386                  randconfig-014-20250214    clang-19
i386                  randconfig-014-20250215    gcc-12
i386                  randconfig-015-20250214    clang-19
i386                  randconfig-015-20250215    gcc-12
i386                  randconfig-016-20250214    clang-19
i386                  randconfig-016-20250215    gcc-12
i386                  randconfig-017-20250214    clang-19
i386                  randconfig-017-20250215    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250214    clang-21
loongarch             randconfig-001-20250214    gcc-14.2.0
loongarch             randconfig-001-20250215    clang-21
loongarch             randconfig-002-20250214    clang-21
loongarch             randconfig-002-20250214    gcc-14.2.0
loongarch             randconfig-002-20250215    clang-21
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250214    clang-21
nios2                 randconfig-001-20250214    gcc-14.2.0
nios2                 randconfig-001-20250215    clang-21
nios2                 randconfig-002-20250214    clang-21
nios2                 randconfig-002-20250214    gcc-14.2.0
nios2                 randconfig-002-20250215    clang-21
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250214    clang-21
parisc                randconfig-001-20250214    gcc-14.2.0
parisc                randconfig-001-20250215    clang-21
parisc                randconfig-002-20250214    clang-21
parisc                randconfig-002-20250214    gcc-14.2.0
parisc                randconfig-002-20250215    clang-21
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    gcc-14.2.0
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250214    clang-21
powerpc               randconfig-001-20250214    gcc-14.2.0
powerpc               randconfig-001-20250215    clang-21
powerpc               randconfig-002-20250214    clang-18
powerpc               randconfig-002-20250214    clang-21
powerpc               randconfig-002-20250215    clang-21
powerpc               randconfig-003-20250214    clang-21
powerpc               randconfig-003-20250215    clang-21
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250214    clang-18
powerpc64             randconfig-001-20250214    clang-21
powerpc64             randconfig-001-20250215    clang-21
powerpc64             randconfig-002-20250214    clang-21
powerpc64             randconfig-002-20250214    gcc-14.2.0
powerpc64             randconfig-002-20250215    clang-21
powerpc64             randconfig-003-20250214    clang-21
powerpc64             randconfig-003-20250214    gcc-14.2.0
powerpc64             randconfig-003-20250215    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250214    clang-16
riscv                 randconfig-001-20250214    clang-18
riscv                 randconfig-001-20250215    clang-19
riscv                 randconfig-002-20250214    clang-16
riscv                 randconfig-002-20250214    gcc-14.2.0
riscv                 randconfig-002-20250215    clang-19
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250214    clang-16
s390                  randconfig-001-20250214    gcc-14.2.0
s390                  randconfig-001-20250215    clang-19
s390                  randconfig-002-20250214    clang-16
s390                  randconfig-002-20250214    clang-19
s390                  randconfig-002-20250215    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250214    clang-16
sh                    randconfig-001-20250214    gcc-14.2.0
sh                    randconfig-001-20250215    clang-19
sh                    randconfig-002-20250214    clang-16
sh                    randconfig-002-20250214    gcc-14.2.0
sh                    randconfig-002-20250215    clang-19
sh                          rsk7201_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250214    clang-16
sparc                 randconfig-001-20250214    gcc-14.2.0
sparc                 randconfig-001-20250215    clang-19
sparc                 randconfig-002-20250214    clang-16
sparc                 randconfig-002-20250214    gcc-14.2.0
sparc                 randconfig-002-20250215    clang-19
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250214    clang-16
sparc64               randconfig-001-20250214    gcc-14.2.0
sparc64               randconfig-001-20250215    clang-19
sparc64               randconfig-002-20250214    clang-16
sparc64               randconfig-002-20250214    gcc-14.2.0
sparc64               randconfig-002-20250215    clang-19
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250214    clang-16
um                    randconfig-001-20250214    gcc-12
um                    randconfig-001-20250215    clang-19
um                    randconfig-002-20250214    clang-16
um                    randconfig-002-20250215    clang-19
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250214    clang-19
x86_64      buildonly-randconfig-001-20250214    gcc-12
x86_64      buildonly-randconfig-001-20250215    clang-19
x86_64      buildonly-randconfig-002-20250214    clang-19
x86_64      buildonly-randconfig-002-20250214    gcc-12
x86_64      buildonly-randconfig-002-20250215    clang-19
x86_64      buildonly-randconfig-003-20250214    gcc-12
x86_64      buildonly-randconfig-003-20250215    clang-19
x86_64      buildonly-randconfig-004-20250214    clang-19
x86_64      buildonly-randconfig-004-20250214    gcc-12
x86_64      buildonly-randconfig-004-20250215    clang-19
x86_64      buildonly-randconfig-005-20250214    gcc-12
x86_64      buildonly-randconfig-005-20250215    clang-19
x86_64      buildonly-randconfig-006-20250214    gcc-12
x86_64      buildonly-randconfig-006-20250215    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250214    clang-19
x86_64                randconfig-001-20250215    gcc-12
x86_64                randconfig-002-20250214    clang-19
x86_64                randconfig-002-20250215    gcc-12
x86_64                randconfig-003-20250214    clang-19
x86_64                randconfig-003-20250215    gcc-12
x86_64                randconfig-004-20250214    clang-19
x86_64                randconfig-004-20250215    gcc-12
x86_64                randconfig-005-20250214    clang-19
x86_64                randconfig-005-20250215    gcc-12
x86_64                randconfig-006-20250214    clang-19
x86_64                randconfig-006-20250215    gcc-12
x86_64                randconfig-007-20250214    clang-19
x86_64                randconfig-007-20250215    gcc-12
x86_64                randconfig-008-20250214    clang-19
x86_64                randconfig-008-20250215    gcc-12
x86_64                randconfig-071-20250214    gcc-12
x86_64                randconfig-072-20250214    gcc-12
x86_64                randconfig-073-20250214    gcc-12
x86_64                randconfig-074-20250214    gcc-12
x86_64                randconfig-075-20250214    gcc-12
x86_64                randconfig-076-20250214    gcc-12
x86_64                randconfig-077-20250214    gcc-12
x86_64                randconfig-078-20250214    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250214    clang-16
xtensa                randconfig-001-20250214    gcc-14.2.0
xtensa                randconfig-001-20250215    clang-19
xtensa                randconfig-002-20250214    clang-16
xtensa                randconfig-002-20250214    gcc-14.2.0
xtensa                randconfig-002-20250215    clang-19

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

