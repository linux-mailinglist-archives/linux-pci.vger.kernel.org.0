Return-Path: <linux-pci+bounces-26253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C6A93F59
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D086917F0DD
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5032868B;
	Fri, 18 Apr 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PENo4+1Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D321B9C5
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010861; cv=none; b=TEXwpOfYfn8TzdJ52GfrvnXbIevYKWaxDbSRSfS11dh4zRIgAnXvpBZHtymd/su/mT6KCqC7Sv2S74i8r9bRjPZlJhTKpbk3BBh5aUnI/aQF3kV8ZZA8aJlntcvAk/6fS6pF5G715tAx8GDyxwg6lpVIuEDQ1U4CMLtAlADkWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010861; c=relaxed/simple;
	bh=VUb1gWLxlhtMUpgPiw1W7aoUDFbwRgxi/zgjWDuilYs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dtCSoMMWIfXtqDFdfSUN2NGl8gdoSs3wNnOsi2f6udjedMl4KUjbWNj9h57m5BydnJyik3Nz0xgqxjxXbRlPK8WMcAFZSCa1qXJqkB15I9yJ4OEDo4hoTFBai3/fM2bR0eZkCaiFJc0BwVN7RbPO035SxYtW28FRmOM9wQpTMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PENo4+1Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745010859; x=1776546859;
  h=date:from:to:cc:subject:message-id;
  bh=VUb1gWLxlhtMUpgPiw1W7aoUDFbwRgxi/zgjWDuilYs=;
  b=PENo4+1YloBEPoSTCWGoa6066MdJxddob8Ub6FqcStDwLqkTps20e9W2
   Ett1dnNHWS19wLRqDMn7zs0zLu4NWEuFkkcIXw5nzwiTzQ5q49tIOE/kz
   5Qse6bVmZ/uC4/4oN6sf19vDqdeXzAwBgAMZVFE7d+EarWSjbvSO60N4Z
   jvPCeLC4/l/0Z5j356ZH0FFScFGICuejZUTd7CEF2tRHOrYWappdsGB5w
   guDhnst5I3HDQpfk/9et5prgVzKiRaBrsm04zAfCS4ToBZKJcna9WRWTt
   TsseAbGFaAeVFdr2fMcrVdfb3T9sqtP5jLt/HD4xoOuKs9aQog2GL55VV
   g==;
X-CSE-ConnectionGUID: n6siTiCdTZ2OtLvmQwtxJA==
X-CSE-MsgGUID: khe/wLRtT2Ce2x94u1hAGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46816513"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46816513"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 14:14:15 -0700
X-CSE-ConnectionGUID: 342miOwxRAKcXVypNvUvrQ==
X-CSE-MsgGUID: LrN3jN65ToGVYv77pbgvNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="135311379"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Apr 2025 14:14:14 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5t2K-0003L7-0Z;
	Fri, 18 Apr 2025 21:14:12 +0000
Date: Sat, 19 Apr 2025 05:13:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 a2c6c1c23bed3506fd87e00c88540ac47832c867
Message-ID: <202504190511.xIkGw3if-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: a2c6c1c23bed3506fd87e00c88540ac47832c867  x86/PCI: Drop 'pci' suffix from intel_mid_pci.c

elapsed time: 1453m

configs tested: 251
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250418    gcc-14.2.0
arc                   randconfig-001-20250419    gcc-7.5.0
arc                   randconfig-002-20250418    gcc-12.4.0
arc                   randconfig-002-20250419    gcc-7.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                       multi_v4t_defconfig    clang-21
arm                   randconfig-001-20250418    gcc-8.5.0
arm                   randconfig-001-20250419    gcc-7.5.0
arm                   randconfig-002-20250418    gcc-7.5.0
arm                   randconfig-002-20250419    gcc-7.5.0
arm                   randconfig-003-20250418    gcc-8.5.0
arm                   randconfig-003-20250419    gcc-7.5.0
arm                   randconfig-004-20250418    clang-21
arm                   randconfig-004-20250419    gcc-7.5.0
arm                         socfpga_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250418    clang-21
arm64                 randconfig-001-20250419    gcc-7.5.0
arm64                 randconfig-002-20250418    clang-21
arm64                 randconfig-002-20250419    gcc-7.5.0
arm64                 randconfig-003-20250418    clang-21
arm64                 randconfig-003-20250419    gcc-7.5.0
arm64                 randconfig-004-20250418    gcc-6.5.0
arm64                 randconfig-004-20250419    gcc-7.5.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250418    gcc-14.2.0
csky                  randconfig-001-20250419    gcc-14.2.0
csky                  randconfig-002-20250418    gcc-10.5.0
csky                  randconfig-002-20250419    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250418    clang-21
hexagon               randconfig-001-20250419    gcc-14.2.0
hexagon               randconfig-002-20250418    clang-21
hexagon               randconfig-002-20250419    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250418    clang-20
i386        buildonly-randconfig-001-20250419    clang-20
i386        buildonly-randconfig-002-20250418    gcc-12
i386        buildonly-randconfig-002-20250419    clang-20
i386        buildonly-randconfig-003-20250418    clang-20
i386        buildonly-randconfig-003-20250419    clang-20
i386        buildonly-randconfig-004-20250418    gcc-12
i386        buildonly-randconfig-004-20250419    clang-20
i386        buildonly-randconfig-005-20250418    gcc-11
i386        buildonly-randconfig-005-20250419    clang-20
i386        buildonly-randconfig-006-20250418    clang-20
i386        buildonly-randconfig-006-20250419    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250419    clang-20
i386                  randconfig-002-20250419    clang-20
i386                  randconfig-003-20250419    clang-20
i386                  randconfig-004-20250419    clang-20
i386                  randconfig-005-20250419    clang-20
i386                  randconfig-006-20250419    clang-20
i386                  randconfig-007-20250419    clang-20
i386                  randconfig-011-20250419    gcc-12
i386                  randconfig-012-20250419    gcc-12
i386                  randconfig-013-20250419    gcc-12
i386                  randconfig-014-20250419    gcc-12
i386                  randconfig-015-20250419    gcc-12
i386                  randconfig-016-20250419    gcc-12
i386                  randconfig-017-20250419    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250418    gcc-14.2.0
loongarch             randconfig-001-20250419    gcc-14.2.0
loongarch             randconfig-002-20250418    gcc-12.4.0
loongarch             randconfig-002-20250419    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250418    gcc-10.5.0
nios2                 randconfig-001-20250419    gcc-14.2.0
nios2                 randconfig-002-20250418    gcc-14.2.0
nios2                 randconfig-002-20250419    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250418    gcc-11.5.0
parisc                randconfig-001-20250419    gcc-14.2.0
parisc                randconfig-002-20250418    gcc-13.3.0
parisc                randconfig-002-20250419    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-21
powerpc                      chrp32_defconfig    clang-21
powerpc                      ppc64e_defconfig    clang-21
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250418    gcc-8.5.0
powerpc               randconfig-001-20250419    gcc-14.2.0
powerpc               randconfig-002-20250418    gcc-6.5.0
powerpc               randconfig-002-20250419    gcc-14.2.0
powerpc               randconfig-003-20250418    clang-21
powerpc               randconfig-003-20250419    gcc-14.2.0
powerpc64             randconfig-001-20250418    clang-21
powerpc64             randconfig-001-20250419    gcc-14.2.0
powerpc64             randconfig-002-20250418    clang-21
powerpc64             randconfig-002-20250419    gcc-14.2.0
powerpc64             randconfig-003-20250418    clang-17
powerpc64             randconfig-003-20250419    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250418    clang-21
riscv                 randconfig-001-20250419    gcc-5.5.0
riscv                 randconfig-002-20250418    clang-21
riscv                 randconfig-002-20250419    gcc-5.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250418    gcc-7.5.0
s390                  randconfig-001-20250419    gcc-5.5.0
s390                  randconfig-002-20250418    gcc-6.5.0
s390                  randconfig-002-20250419    gcc-5.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-21
sh                    randconfig-001-20250418    gcc-12.4.0
sh                    randconfig-001-20250419    gcc-5.5.0
sh                    randconfig-002-20250418    gcc-14.2.0
sh                    randconfig-002-20250419    gcc-5.5.0
sh                             sh03_defconfig    gcc-14.2.0
sh                             shx3_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250418    gcc-10.3.0
sparc                 randconfig-001-20250419    gcc-5.5.0
sparc                 randconfig-002-20250418    gcc-7.5.0
sparc                 randconfig-002-20250419    gcc-5.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250418    gcc-9.3.0
sparc64               randconfig-001-20250419    gcc-5.5.0
sparc64               randconfig-002-20250418    gcc-11.5.0
sparc64               randconfig-002-20250419    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250418    clang-21
um                    randconfig-001-20250419    gcc-5.5.0
um                    randconfig-002-20250418    clang-21
um                    randconfig-002-20250419    gcc-5.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250418    clang-20
x86_64      buildonly-randconfig-001-20250419    clang-20
x86_64      buildonly-randconfig-002-20250418    clang-20
x86_64      buildonly-randconfig-002-20250419    clang-20
x86_64      buildonly-randconfig-003-20250418    clang-20
x86_64      buildonly-randconfig-003-20250419    clang-20
x86_64      buildonly-randconfig-004-20250418    clang-20
x86_64      buildonly-randconfig-004-20250419    clang-20
x86_64      buildonly-randconfig-005-20250418    clang-20
x86_64      buildonly-randconfig-005-20250419    clang-20
x86_64      buildonly-randconfig-006-20250418    gcc-12
x86_64      buildonly-randconfig-006-20250419    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250419    clang-20
x86_64                randconfig-002-20250419    clang-20
x86_64                randconfig-003-20250419    clang-20
x86_64                randconfig-004-20250419    clang-20
x86_64                randconfig-005-20250419    clang-20
x86_64                randconfig-006-20250419    clang-20
x86_64                randconfig-007-20250419    clang-20
x86_64                randconfig-008-20250419    clang-20
x86_64                randconfig-071-20250419    clang-20
x86_64                randconfig-072-20250419    clang-20
x86_64                randconfig-073-20250419    clang-20
x86_64                randconfig-074-20250419    clang-20
x86_64                randconfig-075-20250419    clang-20
x86_64                randconfig-076-20250419    clang-20
x86_64                randconfig-077-20250419    clang-20
x86_64                randconfig-078-20250419    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250418    gcc-7.5.0
xtensa                randconfig-001-20250419    gcc-5.5.0
xtensa                randconfig-002-20250418    gcc-14.2.0
xtensa                randconfig-002-20250419    gcc-5.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

