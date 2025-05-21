Return-Path: <linux-pci+bounces-28172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2D1ABED58
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875FC1BA3B0B
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D31A9B4C;
	Wed, 21 May 2025 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQjBikuQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D217BD3
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814075; cv=none; b=kMmOQaDNThOdhAeGiaibVMJO9rJ2NWsUpFhFa3cXp2wSCOqmgKpugRjOABPNupoje4GlYdjsQEutQ/8uRwtK5rQ6BKs8VL0USbw+ThbVQHltk2e86xhVyg1jskZTOytUD1miq6d/ld7B6oEW1EdXvb6VdJH72+kH3Ayx+gzt0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814075; c=relaxed/simple;
	bh=8uEnCEKdRhsaow2hQWOdsQPJ+6rYxOdDpjeyonCcwzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ogUYAHCVL4vkRHPrdVl2I/10i9tnb4S3HzeaxP9mU0L1FnQ4s0Pr73YwOVFNqvqMkRLYPuQs0vmW81Wc/UXEJmcXJulT5I54kgUYLV0ZvPOdlY2vqVSUYAZCvyvuOsilVQlGnFmT82xQbjLkLJJzlifMSCqU6Ak8qDy/4RKH9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQjBikuQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747814073; x=1779350073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8uEnCEKdRhsaow2hQWOdsQPJ+6rYxOdDpjeyonCcwzc=;
  b=eQjBikuQW7JufaWmqItYRw8iTORnn93cxy7rNKa6WCcijwr1l777NMzh
   GL09kG+D5541FlIYprNmBRGE6MFAyvomzSVKQlHmwwQmc6ctTBMcc5yqV
   2cO5+7rFWvAiPDpaicULExNMbItI9GATf0U8d4yUI/zQglfoklpLyj28x
   zJ39flQgxgHNJGJk2Q4H0Rv6i94sSQsNg2+8TOJLhIWdTIN/oq5MEBygw
   Up6cYl6adwF06m8uqKiivOkbEVLYILe37ELbxuGNBUlGCYpAR9SSz7rPJ
   YqsoJ6smMYgVLXsTE84FFJHF1CSEKpGmwrjlvwCnq8aKR2qvkEQMbNiD+
   g==;
X-CSE-ConnectionGUID: 8lIcSq9bSaiV0icJgr0GGg==
X-CSE-MsgGUID: uVkCIRIDT7GchVtT/wRJ4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="53443702"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="53443702"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 00:54:33 -0700
X-CSE-ConnectionGUID: ozpI1BJOQpC7wU/SCc7oNA==
X-CSE-MsgGUID: 4/NJBz5dSEGUbwk83euxmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140005592"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2025 00:54:31 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHeHV-000O0M-1C;
	Wed, 21 May 2025 07:54:29 +0000
Date: Wed, 21 May 2025 15:53:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 90ffe1f093e85ebb70212909607e0c0517aa65a5
Message-ID: <202505211549.SYDkD0KF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 90ffe1f093e85ebb70212909607e0c0517aa65a5  PCI: Remove hybrid-devres usage warnings from kernel-doc

elapsed time: 1441m

configs tested: 257
configs skipped: 6

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
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-001-20250521    clang-21
arc                   randconfig-002-20250520    gcc-14.2.0
arc                   randconfig-002-20250521    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-21
arm                        mvebu_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-001-20250521    clang-21
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-002-20250521    clang-21
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-003-20250521    clang-21
arm                   randconfig-004-20250520    gcc-7.5.0
arm                   randconfig-004-20250521    clang-21
arm                           stm32_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-001-20250521    clang-21
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-002-20250521    clang-21
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-003-20250521    clang-21
arm64                 randconfig-004-20250520    gcc-9.5.0
arm64                 randconfig-004-20250521    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-14.2.0
csky                  randconfig-001-20250521    gcc-14.2.0
csky                  randconfig-002-20250520    gcc-9.3.0
csky                  randconfig-002-20250521    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250520    clang-21
hexagon               randconfig-001-20250521    gcc-14.2.0
hexagon               randconfig-002-20250520    clang-21
hexagon               randconfig-002-20250521    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-001-20250521    clang-20
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-002-20250521    clang-20
i386        buildonly-randconfig-003-20250520    clang-20
i386        buildonly-randconfig-003-20250521    clang-20
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-004-20250521    clang-20
i386        buildonly-randconfig-005-20250520    clang-20
i386        buildonly-randconfig-005-20250521    clang-20
i386        buildonly-randconfig-006-20250520    gcc-12
i386        buildonly-randconfig-006-20250521    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250521    clang-20
i386                  randconfig-002-20250521    clang-20
i386                  randconfig-003-20250521    clang-20
i386                  randconfig-004-20250521    clang-20
i386                  randconfig-005-20250521    clang-20
i386                  randconfig-006-20250521    clang-20
i386                  randconfig-007-20250521    clang-20
i386                  randconfig-011-20250521    gcc-12
i386                  randconfig-012-20250521    gcc-12
i386                  randconfig-013-20250521    gcc-12
i386                  randconfig-014-20250521    gcc-12
i386                  randconfig-015-20250521    gcc-12
i386                  randconfig-016-20250521    gcc-12
i386                  randconfig-017-20250521    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-14.2.0
loongarch             randconfig-001-20250521    gcc-14.2.0
loongarch             randconfig-002-20250520    gcc-14.2.0
loongarch             randconfig-002-20250521    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-001-20250521    gcc-14.2.0
nios2                 randconfig-002-20250520    gcc-13.3.0
nios2                 randconfig-002-20250521    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250520    gcc-10.5.0
parisc                randconfig-001-20250521    gcc-14.2.0
parisc                randconfig-002-20250520    gcc-14.2.0
parisc                randconfig-002-20250521    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       ebony_defconfig    clang-21
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250520    gcc-5.5.0
powerpc               randconfig-001-20250521    gcc-14.2.0
powerpc               randconfig-002-20250520    clang-17
powerpc               randconfig-002-20250521    gcc-14.2.0
powerpc               randconfig-003-20250520    gcc-7.5.0
powerpc               randconfig-003-20250521    gcc-14.2.0
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                      tqm8xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250520    clang-21
powerpc64             randconfig-001-20250521    gcc-14.2.0
powerpc64             randconfig-002-20250520    gcc-7.5.0
powerpc64             randconfig-002-20250521    gcc-14.2.0
powerpc64             randconfig-003-20250520    gcc-5.5.0
powerpc64             randconfig-003-20250521    gcc-14.2.0
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250520    gcc-9.3.0
riscv                 randconfig-001-20250521    gcc-8.5.0
riscv                 randconfig-002-20250520    clang-21
riscv                 randconfig-002-20250521    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250520    clang-21
s390                  randconfig-001-20250521    gcc-8.5.0
s390                  randconfig-002-20250520    clang-21
s390                  randconfig-002-20250521    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250520    gcc-9.3.0
sh                    randconfig-001-20250521    gcc-8.5.0
sh                    randconfig-002-20250520    gcc-9.3.0
sh                    randconfig-002-20250521    gcc-8.5.0
sh                          rsk7201_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250520    gcc-8.5.0
sparc                 randconfig-001-20250521    gcc-8.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc                 randconfig-002-20250521    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250520    gcc-8.5.0
sparc64               randconfig-001-20250521    gcc-8.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
sparc64               randconfig-002-20250521    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250520    clang-21
um                    randconfig-001-20250521    gcc-8.5.0
um                    randconfig-002-20250520    clang-21
um                    randconfig-002-20250521    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-001-20250521    clang-20
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250521    clang-20
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250521    clang-20
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250521    clang-20
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250521    clang-20
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250521    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250521    gcc-12
x86_64                randconfig-002-20250521    gcc-12
x86_64                randconfig-003-20250521    gcc-12
x86_64                randconfig-004-20250521    gcc-12
x86_64                randconfig-005-20250521    gcc-12
x86_64                randconfig-006-20250521    gcc-12
x86_64                randconfig-007-20250521    gcc-12
x86_64                randconfig-008-20250521    gcc-12
x86_64                randconfig-071-20250521    clang-20
x86_64                randconfig-072-20250521    clang-20
x86_64                randconfig-073-20250521    clang-20
x86_64                randconfig-074-20250521    clang-20
x86_64                randconfig-075-20250521    clang-20
x86_64                randconfig-076-20250521    clang-20
x86_64                randconfig-077-20250521    clang-20
x86_64                randconfig-078-20250521    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250520    gcc-6.5.0
xtensa                randconfig-001-20250521    gcc-8.5.0
xtensa                randconfig-002-20250520    gcc-12.4.0
xtensa                randconfig-002-20250521    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

