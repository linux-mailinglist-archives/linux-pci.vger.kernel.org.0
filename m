Return-Path: <linux-pci+bounces-43762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1493CDFCC4
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D71030019C0
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3828504D;
	Sat, 27 Dec 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDSkybn2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E861311C2F
	for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766841050; cv=none; b=MQJ861QdrKeDO5XfsQW+fNvcwu4WCN7e/fimzInqrLaE1139AX/TBiv6A0WCdJMd434RKZOt5oDKd+O+JEUIibiY3S9l3W1qYh+9MTOXdjSl186R2P7l+MSrA+WpUItVUG3AcyTTRsdhcLsTs4+hGkHYJvDQ3/vsDnC9L9b/0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766841050; c=relaxed/simple;
	bh=iDmC8fuDO9xbfH6I/I/QtkNbelBF8g951OMQaLbyHmo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CSHS4rxNbN2zZvwGBgBvxZGdQGFx9i8yg3oM8/VhzlUO4YFoCKWhWmO7eBdl4SSgnkXRRLaxOvnXFI6uwGub3CPtLNeK4Ub6H/JGxA8qRAFnYr8Kb21BkGduWEnxanOostn0OQVTXWuXlj/IZyOiRIFWDBOL9vuaV7qr/p7fvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDSkybn2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766841048; x=1798377048;
  h=date:from:to:cc:subject:message-id;
  bh=iDmC8fuDO9xbfH6I/I/QtkNbelBF8g951OMQaLbyHmo=;
  b=TDSkybn21J7V7t6wk3EIqFcaDEgovKEXaNvzBIUF9xCI4A2rPqB+P7bP
   29WdFyoHl7ITlbEnkbvd8Cy/mwQ476N38a0kCusnpH5LNsn6eWJJ7ZeGb
   M6l5ygB37UjpgC+oN0bUrdwz6M6S8q9f74/ZiGQf++u/cbyyTrQ7zAyhl
   CpWXroB4+L1+lQ2jNoBuIWrMG+raDZ2WucI0uAH4/KYBm118QhZI85KsJ
   OhhySYOOUy2Ag2bOAUpls/4DLfV93sRK4n5GByh2Er1kxDdsTEDzG9ER8
   19QECQmf/qO906I41egOUEHlls9fNRcb3YXw9YKKscBmm5Gs0L6VSkrB7
   g==;
X-CSE-ConnectionGUID: Tftt+7MYQFG5ERKx27cxJQ==
X-CSE-MsgGUID: cyOOPUzDSB6LH46pA12WqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="68703369"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="68703369"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 05:10:47 -0800
X-CSE-ConnectionGUID: hGQrpvZ/Smymbu61ZWCCCg==
X-CSE-MsgGUID: 73Tvzs6bSjmCUDyjRs2e3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="205596738"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 27 Dec 2025 05:10:45 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZU47-000000005qf-0QCs;
	Sat, 27 Dec 2025 13:10:40 +0000
Date: Sat, 27 Dec 2025 21:09:22 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 b5e65f4b1e1abbd85598924dfbcc13b850cb7806
Message-ID: <202512272118.dW2ONI2g-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: b5e65f4b1e1abbd85598924dfbcc13b850cb7806  Merge branch 'pci/controller/xilinx'

elapsed time: 787m

configs tested: 194
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251227    gcc-11.5.0
arc                   randconfig-002-20251227    gcc-9.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20251227    gcc-8.5.0
arm                   randconfig-002-20251227    clang-22
arm                   randconfig-003-20251227    clang-22
arm                   randconfig-004-20251227    clang-22
arm                        realview_defconfig    clang-16
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251227    clang-19
arm64                 randconfig-002-20251227    gcc-15.1.0
arm64                 randconfig-003-20251227    clang-20
arm64                 randconfig-004-20251227    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251227    gcc-15.1.0
csky                  randconfig-002-20251227    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251227    clang-22
hexagon               randconfig-002-20251227    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251227    clang-20
i386        buildonly-randconfig-002-20251227    clang-20
i386        buildonly-randconfig-003-20251227    clang-20
i386        buildonly-randconfig-004-20251227    clang-20
i386        buildonly-randconfig-005-20251227    clang-20
i386        buildonly-randconfig-006-20251227    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251227    clang-20
i386                  randconfig-002-20251227    clang-20
i386                  randconfig-003-20251227    clang-20
i386                  randconfig-004-20251227    gcc-13
i386                  randconfig-005-20251227    gcc-14
i386                  randconfig-006-20251227    gcc-14
i386                  randconfig-007-20251227    clang-20
i386                  randconfig-011-20251227    gcc-14
i386                  randconfig-012-20251227    clang-20
i386                  randconfig-013-20251227    gcc-14
i386                  randconfig-014-20251227    gcc-14
i386                  randconfig-015-20251227    gcc-12
i386                  randconfig-016-20251227    clang-20
i386                  randconfig-017-20251227    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251227    clang-18
loongarch             randconfig-002-20251227    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       alldefconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
mips                           jazz_defconfig    gcc-15.1.0
mips                       lemote2f_defconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251227    gcc-11.5.0
nios2                 randconfig-002-20251227    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251227    gcc-8.5.0
parisc                randconfig-002-20251227    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    clang-22
powerpc               randconfig-001-20251227    gcc-8.5.0
powerpc               randconfig-002-20251227    clang-22
powerpc64             randconfig-001-20251227    clang-22
powerpc64             randconfig-002-20251227    gcc-8.5.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251227    clang-22
riscv                 randconfig-002-20251227    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251227    clang-22
s390                  randconfig-002-20251227    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251227    gcc-15.1.0
sh                    randconfig-002-20251227    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251227    gcc-14.3.0
sparc                 randconfig-002-20251227    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251227    gcc-8.5.0
sparc64               randconfig-002-20251227    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251227    clang-22
um                    randconfig-002-20251227    clang-19
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251227    clang-20
x86_64      buildonly-randconfig-002-20251227    clang-20
x86_64      buildonly-randconfig-003-20251227    gcc-14
x86_64      buildonly-randconfig-004-20251227    clang-20
x86_64      buildonly-randconfig-005-20251227    clang-20
x86_64      buildonly-randconfig-006-20251227    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251227    gcc-14
x86_64                randconfig-002-20251227    gcc-12
x86_64                randconfig-003-20251227    gcc-14
x86_64                randconfig-004-20251227    clang-20
x86_64                randconfig-005-20251227    gcc-14
x86_64                randconfig-006-20251227    clang-20
x86_64                randconfig-011-20251227    gcc-14
x86_64                randconfig-012-20251227    clang-20
x86_64                randconfig-013-20251227    clang-20
x86_64                randconfig-014-20251227    gcc-14
x86_64                randconfig-015-20251227    gcc-13
x86_64                randconfig-016-20251227    gcc-14
x86_64                randconfig-071-20251227    clang-20
x86_64                randconfig-072-20251227    clang-20
x86_64                randconfig-073-20251227    clang-20
x86_64                randconfig-074-20251227    clang-20
x86_64                randconfig-075-20251227    clang-20
x86_64                randconfig-076-20251227    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251227    gcc-9.5.0
xtensa                randconfig-002-20251227    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

