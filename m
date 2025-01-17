Return-Path: <linux-pci+bounces-20080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91666A158BF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA2B188B591
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 20:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B611A2391;
	Fri, 17 Jan 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnsxPi3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B461A9B39
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147458; cv=none; b=qAjrv3m3J6suVgqdfgg/sS5GPqtR5jHUTlEjrVYF4Gp+e+Clm8js0cW9dBCCEDnESJmWF+o6RNAM5G/UD4POX/i/WULXiA74kuC3yo4Ljz9wI+g7j5ust8ikfGT6lH9S1gL7rO4S5cimNrsI+p2nnJle9uDQqzQstD74x99sUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147458; c=relaxed/simple;
	bh=ZCjx4DfOEvhCg7+CthTirgSKeay4nZbkv/4wfLSeRp8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sxUEajMYy3Nwc9/Y+Wg6yRJK1xtF//cl/sCTwIi2K9yYLRBlz+5uzmywyAW3EdGBJGpC6oWQRLOsotquV1OcSW/k4QRFj4u/mAbTzZFKQ28dDg5VOJO4klEwl491Yh7N4st9gZny7cg3+/THVG4bfOOANhTPLVmq3hQsJKQeZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnsxPi3f; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737147457; x=1768683457;
  h=date:from:to:cc:subject:message-id;
  bh=ZCjx4DfOEvhCg7+CthTirgSKeay4nZbkv/4wfLSeRp8=;
  b=VnsxPi3f97XBx3VyFcxYH47vTTmIz5p7hqFib5FfQldWYWTDkhRzFwPl
   jX6wMKvpWHdVtN98hlvSsq2EuOngCIJODw/UWyzY4F3CReVHS7Dj2vcox
   vDvCpZUN83skiL8VEin5B9S/h2HEDczyYgwI5Kcpo3huOVlAEluATqDdn
   35wY8pfIoZKdk3YJIxpe9JNMY0ryAowKE5Taf6ch9X7ldabixsq9eAS2V
   88d8QwBPh2q/D4hCr//T9MO9f7OprZVetwN5sxOhLo5LvrURnfzsQQv4w
   qIQm/eyBVi5phKKFvnM+tIY3KfdQsUpL3aAUVo3qSkmLd/M/l6AVWeDg1
   g==;
X-CSE-ConnectionGUID: rWqydryMTYaSU930jxidOA==
X-CSE-MsgGUID: OWIBuS42TLy7BJsb+bLClw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="36805477"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="36805477"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:57:34 -0800
X-CSE-ConnectionGUID: H26efTiYR1ymqxXBIxhzdQ==
X-CSE-MsgGUID: CuNYOpFgT6evanpqAOxoXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110900289"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Jan 2025 12:57:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYtPG-000ThF-2s;
	Fri, 17 Jan 2025 20:57:30 +0000
Date: Sat, 18 Jan 2025 04:57:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/layerscape] BUILD SUCCESS
 149fc35734e50fc3200cf84c8efd711205961636
Message-ID: <202501180424.xHBW4KET-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/layerscape
branch HEAD: 149fc35734e50fc3200cf84c8efd711205961636  PCI: layerscape: Use syscon_regmap_lookup_by_phandle_args

elapsed time: 1443m

configs tested: 179
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250117    clang-20
arc                   randconfig-001-20250117    gcc-13.2.0
arc                   randconfig-002-20250117    clang-20
arc                   randconfig-002-20250117    gcc-13.2.0
arm                              alldefconfig    clang-20
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    clang-20
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250117    clang-18
arm                   randconfig-001-20250117    clang-20
arm                   randconfig-002-20250117    clang-20
arm                   randconfig-002-20250117    gcc-14.2.0
arm                   randconfig-003-20250117    clang-20
arm                   randconfig-003-20250117    gcc-14.2.0
arm                   randconfig-004-20250117    clang-16
arm                   randconfig-004-20250117    clang-20
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250117    clang-20
arm64                 randconfig-001-20250117    gcc-14.2.0
arm64                 randconfig-002-20250117    clang-18
arm64                 randconfig-002-20250117    clang-20
arm64                 randconfig-003-20250117    clang-20
arm64                 randconfig-004-20250117    clang-20
arm64                 randconfig-004-20250117    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250117    gcc-14.2.0
csky                  randconfig-002-20250117    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250117    clang-20
hexagon               randconfig-001-20250117    gcc-14.2.0
hexagon               randconfig-002-20250117    clang-20
hexagon               randconfig-002-20250117    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250117    clang-19
i386        buildonly-randconfig-002-20250117    clang-19
i386        buildonly-randconfig-003-20250117    gcc-12
i386        buildonly-randconfig-004-20250117    gcc-12
i386        buildonly-randconfig-005-20250117    clang-19
i386        buildonly-randconfig-006-20250117    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20250117    clang-19
i386                  randconfig-002-20250117    clang-19
i386                  randconfig-003-20250117    clang-19
i386                  randconfig-004-20250117    clang-19
i386                  randconfig-005-20250117    clang-19
i386                  randconfig-006-20250117    clang-19
i386                  randconfig-007-20250117    clang-19
i386                  randconfig-011-20250117    gcc-12
i386                  randconfig-012-20250117    gcc-12
i386                  randconfig-013-20250117    gcc-12
i386                  randconfig-014-20250117    gcc-12
i386                  randconfig-015-20250117    gcc-12
i386                  randconfig-016-20250117    gcc-12
i386                  randconfig-017-20250117    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250117    gcc-14.2.0
loongarch             randconfig-002-20250117    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250117    gcc-14.2.0
nios2                 randconfig-002-20250117    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250117    gcc-14.2.0
parisc                randconfig-002-20250117    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250117    gcc-14.2.0
powerpc               randconfig-002-20250117    gcc-14.2.0
powerpc               randconfig-003-20250117    gcc-14.2.0
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250117    clang-16
powerpc64             randconfig-001-20250117    gcc-14.2.0
powerpc64             randconfig-002-20250117    clang-20
powerpc64             randconfig-002-20250117    gcc-14.2.0
powerpc64             randconfig-003-20250117    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250117    gcc-14.2.0
riscv                 randconfig-002-20250117    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250117    gcc-14.2.0
s390                  randconfig-002-20250117    clang-20
s390                  randconfig-002-20250117    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250117    gcc-14.2.0
sh                    randconfig-002-20250117    gcc-14.2.0
sh                          sdk7786_defconfig    clang-20
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250117    gcc-14.2.0
sparc                 randconfig-002-20250117    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250117    gcc-14.2.0
sparc64               randconfig-002-20250117    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250117    clang-20
um                    randconfig-001-20250117    gcc-14.2.0
um                    randconfig-002-20250117    gcc-12
um                    randconfig-002-20250117    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250117    gcc-12
x86_64      buildonly-randconfig-002-20250117    gcc-12
x86_64      buildonly-randconfig-003-20250117    gcc-12
x86_64      buildonly-randconfig-004-20250117    gcc-12
x86_64      buildonly-randconfig-005-20250117    gcc-12
x86_64      buildonly-randconfig-006-20250117    clang-19
x86_64      buildonly-randconfig-006-20250117    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250117    clang-19
x86_64                randconfig-002-20250117    clang-19
x86_64                randconfig-003-20250117    clang-19
x86_64                randconfig-004-20250117    clang-19
x86_64                randconfig-005-20250117    clang-19
x86_64                randconfig-006-20250117    clang-19
x86_64                randconfig-007-20250117    clang-19
x86_64                randconfig-008-20250117    clang-19
x86_64                randconfig-071-20250117    clang-19
x86_64                randconfig-072-20250117    clang-19
x86_64                randconfig-073-20250117    clang-19
x86_64                randconfig-074-20250117    clang-19
x86_64                randconfig-075-20250117    clang-19
x86_64                randconfig-076-20250117    clang-19
x86_64                randconfig-077-20250117    clang-19
x86_64                randconfig-078-20250117    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250117    gcc-14.2.0
xtensa                randconfig-002-20250117    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

