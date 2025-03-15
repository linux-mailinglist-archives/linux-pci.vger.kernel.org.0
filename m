Return-Path: <linux-pci+bounces-23842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B0A6304F
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF12F189AFE3
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21941714CF;
	Sat, 15 Mar 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K74XEdPr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DE13AD22
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742057572; cv=none; b=GQn1mI9wrbNXELEH/m47hPKySAgddXNiYaI5AuIgr9so7QZY56/OAcOmRp7SX9hv1ctmV1UC/GQ9h3hGxvEZmhOHdq/1VFW6946wYRfjvuigM15kxWrXPIm4A7G2/uMNG8844tHWD9WU65W/Uh/BDo8ObFdtI37qMDY9U2g6o6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742057572; c=relaxed/simple;
	bh=l8ES+ZkyFzFrQ40pbXvJx2bzVVpz0QUTQjNnd0jIkus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oTEj+HzQo/xU5lFxoHBN08iQt3RESVF9UJlz0x7Wlb2lgEsfVH1bdT1Zewu5UmGxC8W8l5qsv1BqA4ku2HXcnYOP9IrI6lKbSzHaOwmxfp56ZdJuOIhhjoO3kvW+dQzvVtzLwMtAnpLFrC9mXeXCOzgirVdeKIRhkZ/gAa8nuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K74XEdPr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742057571; x=1773593571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l8ES+ZkyFzFrQ40pbXvJx2bzVVpz0QUTQjNnd0jIkus=;
  b=K74XEdPrnO9orkD7/2ArKdo8WYJMevKRpETMwJmDWn5dCHz684rwJEQC
   W9i7MtV2P2A+PcW89ouH9bG50Y5BTKjTOg0Lvj1EnpFdS4lXh+3rPnvjn
   PWzRczwgwuiTX0KKFqeFq/k+Zpo8k2U4eYogRl+fLT7hLBTiwS/x1c6TY
   9uG7b4n1SZrzC2bbdQ6ly58SjJ8KrOyV3HulseZGzxLzkXgrWcPVJq6rj
   y/+Wn4gJn+G5ULlXdn4cIdj+FUE8dxtr9MzSNM+wVe2+TO3DMjtM0xk6G
   m+kw7XYsoJnCjBiKMwlJj73mT4VuviiHhc7xBbnF8Eks78f3cT8gGnaGm
   g==;
X-CSE-ConnectionGUID: 51+/amHITp2oWN+TMD+aYw==
X-CSE-MsgGUID: 5Yjp2RjtRbGSaQTliY9Ndg==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="68556772"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="68556772"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 09:52:50 -0700
X-CSE-ConnectionGUID: UFgOoburTFKRKNRgtqIefw==
X-CSE-MsgGUID: D5N5seRnTie3DfjEf9yNZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="125749370"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Mar 2025 09:52:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttUkg-000BUP-2k;
	Sat, 15 Mar 2025 16:52:46 +0000
Date: Sun, 16 Mar 2025 00:52:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint-test] BUILD SUCCESS
 c4aaa6b5b5ac14ea9b0abf1e0f4bf24c332a9b34
Message-ID: <202503160031.rl0xXwzR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint-test
branch HEAD: c4aaa6b5b5ac14ea9b0abf1e0f4bf24c332a9b34  misc: pci_endpoint_test: Add support for PCITEST_IRQ_TYPE_AUTO

elapsed time: 1450m

configs tested: 208
configs skipped: 4

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
arc                   randconfig-001-20250315    gcc-13.2.0
arc                   randconfig-001-20250315    gcc-14.2.0
arc                   randconfig-002-20250315    gcc-13.2.0
arc                   randconfig-002-20250315    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                   randconfig-001-20250315    gcc-14.2.0
arm                   randconfig-002-20250315    clang-21
arm                   randconfig-002-20250315    gcc-14.2.0
arm                   randconfig-003-20250315    clang-21
arm                   randconfig-003-20250315    gcc-14.2.0
arm                   randconfig-004-20250315    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250315    gcc-14.2.0
arm64                 randconfig-002-20250315    gcc-14.2.0
arm64                 randconfig-003-20250315    clang-16
arm64                 randconfig-003-20250315    gcc-14.2.0
arm64                 randconfig-004-20250315    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250315    gcc-14.2.0
csky                  randconfig-002-20250315    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250315    clang-21
hexagon               randconfig-001-20250315    gcc-14.2.0
hexagon               randconfig-002-20250315    clang-17
hexagon               randconfig-002-20250315    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250315    clang-19
i386        buildonly-randconfig-001-20250315    gcc-12
i386        buildonly-randconfig-002-20250315    clang-19
i386        buildonly-randconfig-003-20250315    clang-19
i386        buildonly-randconfig-004-20250315    clang-19
i386        buildonly-randconfig-005-20250315    clang-19
i386        buildonly-randconfig-005-20250315    gcc-11
i386        buildonly-randconfig-006-20250315    clang-19
i386        buildonly-randconfig-006-20250315    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250315    clang-19
i386                  randconfig-002-20250315    clang-19
i386                  randconfig-003-20250315    clang-19
i386                  randconfig-004-20250315    clang-19
i386                  randconfig-005-20250315    clang-19
i386                  randconfig-006-20250315    clang-19
i386                  randconfig-007-20250315    clang-19
i386                  randconfig-011-20250315    gcc-12
i386                  randconfig-012-20250315    gcc-12
i386                  randconfig-013-20250315    gcc-12
i386                  randconfig-014-20250315    gcc-12
i386                  randconfig-015-20250315    gcc-12
i386                  randconfig-016-20250315    gcc-12
i386                  randconfig-017-20250315    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250315    gcc-14.2.0
loongarch             randconfig-002-20250315    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-21
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250315    gcc-14.2.0
nios2                 randconfig-002-20250315    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250315    gcc-14.2.0
parisc                randconfig-002-20250315    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250315    clang-21
powerpc               randconfig-001-20250315    gcc-14.2.0
powerpc               randconfig-002-20250315    gcc-14.2.0
powerpc               randconfig-003-20250315    clang-18
powerpc               randconfig-003-20250315    gcc-14.2.0
powerpc64             randconfig-001-20250315    gcc-14.2.0
powerpc64             randconfig-002-20250315    clang-18
powerpc64             randconfig-002-20250315    gcc-14.2.0
powerpc64             randconfig-003-20250315    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250315    gcc-14.2.0
riscv                 randconfig-002-20250315    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250315    clang-19
s390                  randconfig-001-20250315    gcc-14.2.0
s390                  randconfig-002-20250315    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250315    gcc-14.2.0
sh                    randconfig-002-20250315    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7724_defconfig    clang-21
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    clang-21
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            shmin_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250315    gcc-14.2.0
sparc                 randconfig-002-20250315    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250315    gcc-14.2.0
sparc64               randconfig-002-20250315    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250315    gcc-12
um                    randconfig-001-20250315    gcc-14.2.0
um                    randconfig-002-20250315    clang-18
um                    randconfig-002-20250315    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250315    clang-19
x86_64      buildonly-randconfig-001-20250315    gcc-12
x86_64      buildonly-randconfig-002-20250315    clang-19
x86_64      buildonly-randconfig-003-20250315    clang-19
x86_64      buildonly-randconfig-004-20250315    clang-19
x86_64      buildonly-randconfig-005-20250315    clang-19
x86_64      buildonly-randconfig-006-20250315    clang-19
x86_64      buildonly-randconfig-006-20250315    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250315    clang-19
x86_64                randconfig-002-20250315    clang-19
x86_64                randconfig-003-20250315    clang-19
x86_64                randconfig-004-20250315    clang-19
x86_64                randconfig-005-20250315    clang-19
x86_64                randconfig-006-20250315    clang-19
x86_64                randconfig-007-20250315    clang-19
x86_64                randconfig-008-20250315    clang-19
x86_64                randconfig-071-20250315    clang-19
x86_64                randconfig-072-20250315    clang-19
x86_64                randconfig-073-20250315    clang-19
x86_64                randconfig-074-20250315    clang-19
x86_64                randconfig-075-20250315    clang-19
x86_64                randconfig-076-20250315    clang-19
x86_64                randconfig-077-20250315    clang-19
x86_64                randconfig-078-20250315    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250315    gcc-14.2.0
xtensa                randconfig-002-20250315    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

