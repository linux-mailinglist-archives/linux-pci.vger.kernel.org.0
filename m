Return-Path: <linux-pci+bounces-27819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540EBAB957A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CB43A9427
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4CD1F5858;
	Fri, 16 May 2025 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZPd7VDS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B3481C4
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747373109; cv=none; b=XPeAzo0+Wgd/OE3BFdSPzZUpW+QoUvWFNK6pVWhtxcI+226DX+Qa4N8fQ/F19iDrGpWdNx1XVE32NXoVJ8E3oFGNS+i2g/XX3jwN12w1EPhMgCF6HrmHsWsaqEEQKy0grNCR3ONJqF65xaC7IyGRJh3cIsLrleYahx6Csr0vL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747373109; c=relaxed/simple;
	bh=jRnWRoXeShHnxxN/LWiSKlkp7koVBv0fsUrTdnwvnQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LOyawiEEeTSGweUu6gmLkM4BRqJA0MjKT/kLaouPmtVboNGjYOQ7lDk/Osyiee05Wt6261SqdQVZmRfuBb6SLdzsD0niyYOlepUx0vjHLARPm+r1zyJu0+IzjF7e75GQyBs6jOgBbaSXJg8eDc8vrOJltacgLkSQTqSBbInSjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZPd7VDS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747373107; x=1778909107;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jRnWRoXeShHnxxN/LWiSKlkp7koVBv0fsUrTdnwvnQM=;
  b=dZPd7VDSa7pQJpnyP5NyYlh1+KO2DHHsVduiSvYPGEfPaY2wWlHoqWSR
   VpxoM0rA2qjFlDkOfA+ITAKQs1Yk1p7zLPtfwex2/iDqBtgi9ZOLzLLkq
   2M4/5k/RvtFUiQ8v49dBFkLiY4YNW8Kg3IREWKRsj2vGMmxkZSzoS2PyP
   PwVs++ydHbLmyE2c/nsOf7fId2EEqCzpOkjOFz9ngTbQ65G3/iiJTtd6M
   187NkLocpJXvlXheGFbC5+qB8mwGF9PsH2YYCWc96/5i2JWqxUVxDBDDZ
   hlLE0dESMrm9/pX5FdiYLhzJAEtMI3ezvoBvLRpjVWKXc39Uzgb5wedqo
   w==;
X-CSE-ConnectionGUID: 34arTh1rQemnwJsHq8rB0w==
X-CSE-MsgGUID: FP7PgxKuQKOzUG9W2lGEKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59989523"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="59989523"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:25:05 -0700
X-CSE-ConnectionGUID: ROtqDpGVQuammY39hBIM4A==
X-CSE-MsgGUID: sN7xF4ZPQQ+goRTR1YEApQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143352529"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 May 2025 22:25:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFnZ7-000J0x-1d;
	Fri, 16 May 2025 05:25:01 +0000
Date: Fri, 16 May 2025 13:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 ce45dc4bb22e96b59a07e19b67e915d99dd5281b
Message-ID: <202505161329.UXOeebU5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: ce45dc4bb22e96b59a07e19b67e915d99dd5281b  PCI: Limit visibility of match_driver flag to PCI core

elapsed time: 905m

configs tested: 237
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250515    gcc-12.4.0
arc                   randconfig-001-20250516    gcc-9.5.0
arc                   randconfig-002-20250515    gcc-14.2.0
arc                   randconfig-002-20250516    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250515    clang-21
arm                   randconfig-001-20250516    gcc-9.5.0
arm                   randconfig-002-20250515    gcc-8.5.0
arm                   randconfig-002-20250516    gcc-9.5.0
arm                   randconfig-003-20250515    gcc-8.5.0
arm                   randconfig-003-20250516    gcc-9.5.0
arm                   randconfig-004-20250515    clang-21
arm                   randconfig-004-20250516    gcc-9.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250515    clang-21
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-002-20250515    clang-21
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-003-20250515    clang-20
arm64                 randconfig-003-20250516    gcc-9.5.0
arm64                 randconfig-004-20250515    gcc-6.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250515    gcc-14.2.0
csky                  randconfig-001-20250516    clang-21
csky                  randconfig-002-20250515    gcc-14.2.0
csky                  randconfig-002-20250516    clang-21
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250515    clang-16
hexagon               randconfig-001-20250516    clang-21
hexagon               randconfig-002-20250515    clang-21
hexagon               randconfig-002-20250516    clang-21
i386                             alldefconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-002-20250515    gcc-12
i386        buildonly-randconfig-002-20250516    clang-20
i386        buildonly-randconfig-003-20250515    clang-20
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-004-20250515    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-005-20250515    gcc-12
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-006-20250515    gcc-11
i386        buildonly-randconfig-006-20250516    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250516    gcc-12
i386                  randconfig-002-20250516    gcc-12
i386                  randconfig-003-20250516    gcc-12
i386                  randconfig-004-20250516    gcc-12
i386                  randconfig-005-20250516    gcc-12
i386                  randconfig-006-20250516    gcc-12
i386                  randconfig-007-20250516    gcc-12
i386                  randconfig-011-20250516    gcc-12
i386                  randconfig-012-20250516    gcc-12
i386                  randconfig-013-20250516    gcc-12
i386                  randconfig-014-20250516    gcc-12
i386                  randconfig-015-20250516    gcc-12
i386                  randconfig-016-20250516    gcc-12
i386                  randconfig-017-20250516    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250515    gcc-12.4.0
loongarch             randconfig-001-20250516    clang-21
loongarch             randconfig-002-20250515    gcc-14.2.0
loongarch             randconfig-002-20250516    clang-21
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    clang-21
m68k                          sun3x_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-21
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250515    gcc-12.4.0
nios2                 randconfig-001-20250516    clang-21
nios2                 randconfig-002-20250515    gcc-6.5.0
nios2                 randconfig-002-20250516    clang-21
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250515    gcc-13.3.0
parisc                randconfig-001-20250516    clang-21
parisc                randconfig-002-20250515    gcc-13.3.0
parisc                randconfig-002-20250516    clang-21
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250515    gcc-8.5.0
powerpc               randconfig-001-20250516    clang-21
powerpc               randconfig-002-20250515    gcc-6.5.0
powerpc               randconfig-002-20250516    clang-21
powerpc               randconfig-003-20250515    clang-21
powerpc               randconfig-003-20250516    clang-21
powerpc                     sequoia_defconfig    clang-21
powerpc                     skiroot_defconfig    clang-21
powerpc64             randconfig-001-20250515    clang-21
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-002-20250515    gcc-8.5.0
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-003-20250515    clang-21
powerpc64             randconfig-003-20250516    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-001-20250516    gcc-7.5.0
riscv                 randconfig-002-20250515    gcc-14.2.0
riscv                 randconfig-002-20250516    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-001-20250516    gcc-7.5.0
s390                  randconfig-002-20250515    gcc-9.3.0
s390                  randconfig-002-20250516    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-001-20250516    gcc-7.5.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                    randconfig-002-20250516    gcc-7.5.0
sh                            shmin_defconfig    clang-21
sh                              ul2_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-001-20250516    gcc-7.5.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc                 randconfig-002-20250516    gcc-7.5.0
sparc                       sparc64_defconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-001-20250516    gcc-7.5.0
sparc64               randconfig-002-20250515    gcc-9.3.0
sparc64               randconfig-002-20250516    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250515    gcc-12
um                    randconfig-001-20250516    gcc-7.5.0
um                    randconfig-002-20250515    clang-21
um                    randconfig-002-20250516    gcc-7.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250515    clang-20
x86_64      buildonly-randconfig-001-20250516    gcc-12
x86_64      buildonly-randconfig-002-20250515    clang-20
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-003-20250515    clang-20
x86_64      buildonly-randconfig-003-20250516    gcc-12
x86_64      buildonly-randconfig-004-20250515    clang-20
x86_64      buildonly-randconfig-004-20250516    gcc-12
x86_64      buildonly-randconfig-005-20250515    clang-20
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250515    gcc-12
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250516    gcc-12
x86_64                randconfig-002-20250516    gcc-12
x86_64                randconfig-003-20250516    gcc-12
x86_64                randconfig-004-20250516    gcc-12
x86_64                randconfig-005-20250516    gcc-12
x86_64                randconfig-006-20250516    gcc-12
x86_64                randconfig-007-20250516    gcc-12
x86_64                randconfig-008-20250516    gcc-12
x86_64                randconfig-071-20250516    clang-20
x86_64                randconfig-072-20250516    clang-20
x86_64                randconfig-073-20250516    clang-20
x86_64                randconfig-074-20250516    clang-20
x86_64                randconfig-075-20250516    clang-20
x86_64                randconfig-076-20250516    clang-20
x86_64                randconfig-077-20250516    clang-20
x86_64                randconfig-078-20250516    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-7.5.0
xtensa                randconfig-002-20250515    gcc-13.3.0
xtensa                randconfig-002-20250516    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

