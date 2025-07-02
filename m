Return-Path: <linux-pci+bounces-31222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D9AF0CA8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4257A4B11
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937BF225A38;
	Wed,  2 Jul 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+dSMwNm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFC1C32
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441654; cv=none; b=heoiDnhIJtCbFG+gmeyK440BGUiv1uDGugR8DOJpVfDrg9N28Huer25Xtn4Fqo9tCSSYpmCY/TxXMCRDGEH/baBX2D4ZWRYzKAmDx+8lLQy3zZ+pmOoUT6LRXuXgvO5nvbw7ngQqAiOxT3G2Xq/Dct2YlaSzUpxE4XghLJlDMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441654; c=relaxed/simple;
	bh=nIXcrKS5cuIb0wsVl3XkYjjBULDYy25NvxS69x9sioU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p8W0ufz3i5owV6r1FNl2Jppb9J/ZKlaD+z9DSUqX5uTQLRZNJ8xzUBqcBjaEig0n8JWAI/hiGjicYqWbcFOS7jv4FVwUaH+jRwAltjqEN/rsK+9WT7qWVsyIvIBid6k+stcDzkKP5IDZsEpyWFJ8GgBfWpvVEefmH5lPUu/csGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+dSMwNm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751441653; x=1782977653;
  h=date:from:to:cc:subject:message-id;
  bh=nIXcrKS5cuIb0wsVl3XkYjjBULDYy25NvxS69x9sioU=;
  b=h+dSMwNm0DOdhbTuIfItRCCkhsmjfE/qkGdWOnb1FBQZH5KSaQpmfoIm
   a4dGwV12w8DljyyS6luhOCdsgg38REYO/uqxkD5Nbi0G5ygP1bx4X2yXu
   7vtQCOzt68IylBDWPEK7T2JwQCO7l9jAQl6994HXTG4DFEPmVLAbnY8bY
   /1waeSo11z9eaFwEXLywgD4Lw+nsX9UepKtiWZDiuP61FxgBkZAxeToeV
   Rr5OmGrisV5EyKbGxKH2pjeDI/JkLjjhdBxM3obDBs1qaoR2TLIAVf8T2
   TNYxAbJpo1/Qo8RCWEwVg42yxaIvKl/ehPUJzaksmF+YoLq8Xdofkvck6
   A==;
X-CSE-ConnectionGUID: BypxQI1DQ6CLRfdj9bEiPw==
X-CSE-MsgGUID: 8QKKaq5uSYGxvWgEAzVG3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53592863"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53592863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 00:34:12 -0700
X-CSE-ConnectionGUID: 5R9UwjzFQouLHlXw4DBfgA==
X-CSE-MsgGUID: CuRq/G9ISviyg8ZUcd/xkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="177685592"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Jul 2025 00:34:11 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWryq-0000KQ-2I;
	Wed, 02 Jul 2025 07:34:08 +0000
Date: Wed, 02 Jul 2025 15:33:56 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 7c184aa42a3dc9b2630010fbcb06c701c440f8e3
Message-ID: <202507021544.cTrto7pJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 7c184aa42a3dc9b2630010fbcb06c701c440f8e3  PCI: qcom: Add support for Qualcomm SA8255p based PCIe Root Complex

elapsed time: 986m

configs tested: 218
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250702    clang-19
arc                   randconfig-001-20250702    gcc-10.5.0
arc                   randconfig-002-20250702    clang-19
arc                   randconfig-002-20250702    gcc-14.3.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250702    clang-17
arm                   randconfig-001-20250702    clang-19
arm                   randconfig-002-20250702    clang-19
arm                   randconfig-003-20250702    clang-19
arm                   randconfig-003-20250702    clang-21
arm                   randconfig-004-20250702    clang-17
arm                   randconfig-004-20250702    clang-19
arm                           u8500_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250702    clang-19
arm64                 randconfig-001-20250702    clang-21
arm64                 randconfig-002-20250702    clang-19
arm64                 randconfig-002-20250702    clang-21
arm64                 randconfig-003-20250702    clang-19
arm64                 randconfig-003-20250702    clang-21
arm64                 randconfig-004-20250702    clang-19
arm64                 randconfig-004-20250702    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250702    gcc-14.2.0
csky                  randconfig-001-20250702    gcc-15.1.0
csky                  randconfig-002-20250702    gcc-14.2.0
csky                  randconfig-002-20250702    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250702    clang-21
hexagon               randconfig-001-20250702    gcc-14.2.0
hexagon               randconfig-002-20250702    clang-21
hexagon               randconfig-002-20250702    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250702    clang-20
i386        buildonly-randconfig-002-20250702    clang-20
i386        buildonly-randconfig-002-20250702    gcc-12
i386        buildonly-randconfig-003-20250702    clang-20
i386        buildonly-randconfig-004-20250702    clang-20
i386        buildonly-randconfig-005-20250702    clang-20
i386        buildonly-randconfig-005-20250702    gcc-12
i386        buildonly-randconfig-006-20250702    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250702    clang-20
i386                  randconfig-002-20250702    clang-20
i386                  randconfig-003-20250702    clang-20
i386                  randconfig-004-20250702    clang-20
i386                  randconfig-005-20250702    clang-20
i386                  randconfig-006-20250702    clang-20
i386                  randconfig-007-20250702    clang-20
i386                  randconfig-011-20250702    gcc-12
i386                  randconfig-012-20250702    gcc-12
i386                  randconfig-013-20250702    gcc-12
i386                  randconfig-014-20250702    gcc-12
i386                  randconfig-015-20250702    gcc-12
i386                  randconfig-016-20250702    gcc-12
i386                  randconfig-017-20250702    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250702    gcc-14.2.0
loongarch             randconfig-001-20250702    gcc-15.1.0
loongarch             randconfig-002-20250702    gcc-14.2.0
loongarch             randconfig-002-20250702    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250702    gcc-14.2.0
nios2                 randconfig-002-20250702    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250702    gcc-12.4.0
parisc                randconfig-001-20250702    gcc-14.2.0
parisc                randconfig-002-20250702    gcc-14.2.0
parisc                randconfig-002-20250702    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250702    gcc-11.5.0
powerpc               randconfig-001-20250702    gcc-14.2.0
powerpc               randconfig-002-20250702    gcc-11.5.0
powerpc               randconfig-002-20250702    gcc-14.2.0
powerpc               randconfig-003-20250702    clang-21
powerpc               randconfig-003-20250702    gcc-14.2.0
powerpc64             randconfig-001-20250702    clang-21
powerpc64             randconfig-001-20250702    gcc-14.2.0
powerpc64             randconfig-002-20250702    clang-19
powerpc64             randconfig-002-20250702    gcc-14.2.0
powerpc64             randconfig-003-20250702    clang-21
powerpc64             randconfig-003-20250702    gcc-14.2.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250702    clang-21
riscv                 randconfig-002-20250702    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250702    clang-21
s390                  randconfig-001-20250702    gcc-10.5.0
s390                  randconfig-002-20250702    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250702    clang-21
sh                    randconfig-001-20250702    gcc-15.1.0
sh                    randconfig-002-20250702    clang-21
sh                    randconfig-002-20250702    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250702    clang-21
sparc                 randconfig-001-20250702    gcc-12.4.0
sparc                 randconfig-002-20250702    clang-21
sparc                 randconfig-002-20250702    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250702    clang-21
sparc64               randconfig-001-20250702    gcc-9.3.0
sparc64               randconfig-002-20250702    clang-21
sparc64               randconfig-002-20250702    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250702    clang-21
um                    randconfig-002-20250702    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250702    gcc-11
x86_64      buildonly-randconfig-001-20250702    gcc-12
x86_64      buildonly-randconfig-002-20250702    gcc-11
x86_64      buildonly-randconfig-003-20250702    clang-20
x86_64      buildonly-randconfig-003-20250702    gcc-11
x86_64      buildonly-randconfig-004-20250702    clang-20
x86_64      buildonly-randconfig-004-20250702    gcc-11
x86_64      buildonly-randconfig-005-20250702    clang-20
x86_64      buildonly-randconfig-005-20250702    gcc-11
x86_64      buildonly-randconfig-006-20250702    gcc-11
x86_64      buildonly-randconfig-006-20250702    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-004-20250702    gcc-12
x86_64                randconfig-005-20250702    gcc-12
x86_64                randconfig-006-20250702    gcc-12
x86_64                randconfig-007-20250702    gcc-12
x86_64                randconfig-008-20250702    gcc-12
x86_64                randconfig-071-20250702    clang-20
x86_64                randconfig-072-20250702    clang-20
x86_64                randconfig-073-20250702    clang-20
x86_64                randconfig-074-20250702    clang-20
x86_64                randconfig-075-20250702    clang-20
x86_64                randconfig-076-20250702    clang-20
x86_64                randconfig-077-20250702    clang-20
x86_64                randconfig-078-20250702    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250702    clang-21
xtensa                randconfig-001-20250702    gcc-14.3.0
xtensa                randconfig-002-20250702    clang-21
xtensa                randconfig-002-20250702    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

