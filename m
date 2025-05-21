Return-Path: <linux-pci+bounces-28171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD64ABEB7A
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 07:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9600916C4FC
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 05:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88721D3D9;
	Wed, 21 May 2025 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWIzzxyu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631032C85
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806564; cv=none; b=V51L7I9JrqcH9M7DUoJhNEXS75Dg11ilMqK37+mn8PJB1AL4Ved+JEMVvBdUMOG1Tei/mZ1x2rnT9lAjBECojrTI45RHNRuBpyZ/itzdJN1M2yf/0wt9NeQe1Ne1+F64jfFjMkzT6GbuZMqvmsaXJKzd8kB3BvRsVppJNOFIsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806564; c=relaxed/simple;
	bh=g+huIRbREPOS6B6cF26XfLkmHrKIwHMLqbpzcG2FBRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q8bIWEc41IJTgdqJ2DHF4i4qXE59wPjl8YHer6bXKMAfocH/j+c0DL64oY6LbS5U+Yc+Wr3SrHSKTjtU9vTxFQH7N4nlzdvoNlC7mgyBnWQ+yKm3KkMqlcQbP5IsE3IFazPILR/D/CWWb9DA8C5pHQLYznMbz1NgGIu7MaXg/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWIzzxyu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747806562; x=1779342562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g+huIRbREPOS6B6cF26XfLkmHrKIwHMLqbpzcG2FBRs=;
  b=GWIzzxyub8b0sBGJqAF9vluQYHmvt2/iNASc8BDzQuKunsvmYOziPGiX
   3IvM+Tmo99GDARXDX0w+MjTpsPbSYsey7za3XcXd0xdkSbtszXE66VUaV
   DB30Qv0/+jpqa9OGC7y47aRkAbTsta6AWE0slBL4WeCg0YODqm48xugP4
   KobMntArFrq3VwQDT1ViUPBCsgGZwp135hfK7zTI0cYqHGLLrbgeaMpwn
   9WxX6shPrJpdGpWuIOYGLp3Yt7He5L8QgKhFYK7Bhe6iZ1dOmHt10Bq5E
   JUF4g0EHi/hxPsz3KSkbFNehn7XH+q0GGJD13+H52/HJuFyvJyEAfwktN
   Q==;
X-CSE-ConnectionGUID: +T0y7JsXQt6IY4j+GokhTg==
X-CSE-MsgGUID: txyqPOpxTJyYr0QGSdXVaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37384639"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="37384639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 22:49:22 -0700
X-CSE-ConnectionGUID: hPxBBCX9TVmp0dwlGsXjaw==
X-CSE-MsgGUID: pckTiEILTnC4sGf1dCyRDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="170921863"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 22:49:21 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHcKM-000Num-1w;
	Wed, 21 May 2025 05:49:18 +0000
Date: Wed, 21 May 2025 13:49:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rcar-gen4] BUILD SUCCESS
 2bdf6ffe9f66d74a6baed3012d78f580c66c0583
Message-ID: <202505211305.FASTvJfa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar-gen4
branch HEAD: 2bdf6ffe9f66d74a6baed3012d78f580c66c0583  PCI: rcar-gen4: Document how to obtain platform firmware

elapsed time: 747m

configs tested: 219
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250521    clang-21
arc                   randconfig-001-20250521    gcc-10.5.0
arc                   randconfig-002-20250521    clang-21
arc                   randconfig-002-20250521    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-21
arm                   randconfig-001-20250521    clang-21
arm                   randconfig-002-20250521    clang-21
arm                   randconfig-003-20250521    clang-16
arm                   randconfig-003-20250521    clang-21
arm                   randconfig-004-20250521    clang-21
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250521    clang-21
arm64                 randconfig-001-20250521    gcc-6.5.0
arm64                 randconfig-002-20250521    clang-21
arm64                 randconfig-002-20250521    gcc-6.5.0
arm64                 randconfig-003-20250521    clang-21
arm64                 randconfig-003-20250521    gcc-8.5.0
arm64                 randconfig-004-20250521    clang-21
arm64                 randconfig-004-20250521    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250521    gcc-10.5.0
csky                  randconfig-001-20250521    gcc-14.2.0
csky                  randconfig-002-20250521    gcc-12.4.0
csky                  randconfig-002-20250521    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250521    clang-20
hexagon               randconfig-001-20250521    gcc-14.2.0
hexagon               randconfig-002-20250521    clang-21
hexagon               randconfig-002-20250521    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250521    clang-20
i386        buildonly-randconfig-002-20250521    clang-20
i386        buildonly-randconfig-003-20250521    clang-20
i386        buildonly-randconfig-003-20250521    gcc-12
i386        buildonly-randconfig-004-20250521    clang-20
i386        buildonly-randconfig-005-20250521    clang-20
i386        buildonly-randconfig-005-20250521    gcc-12
i386        buildonly-randconfig-006-20250521    clang-20
i386        buildonly-randconfig-006-20250521    gcc-12
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
loongarch             randconfig-001-20250521    gcc-14.2.0
loongarch             randconfig-001-20250521    gcc-15.1.0
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
nios2                 randconfig-001-20250521    gcc-14.2.0
nios2                 randconfig-002-20250521    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250521    gcc-13.3.0
parisc                randconfig-001-20250521    gcc-14.2.0
parisc                randconfig-002-20250521    gcc-11.5.0
parisc                randconfig-002-20250521    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       ebony_defconfig    clang-21
powerpc                      katmai_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250521    clang-21
powerpc               randconfig-001-20250521    gcc-14.2.0
powerpc               randconfig-002-20250521    gcc-14.2.0
powerpc               randconfig-002-20250521    gcc-8.5.0
powerpc               randconfig-003-20250521    gcc-14.2.0
powerpc               randconfig-003-20250521    gcc-6.5.0
powerpc                      tqm8xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250521    gcc-14.2.0
powerpc64             randconfig-001-20250521    gcc-8.5.0
powerpc64             randconfig-002-20250521    gcc-14.2.0
powerpc64             randconfig-002-20250521    gcc-6.5.0
powerpc64             randconfig-003-20250521    clang-21
powerpc64             randconfig-003-20250521    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250521    gcc-8.5.0
riscv                 randconfig-002-20250521    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250521    clang-20
s390                  randconfig-001-20250521    gcc-8.5.0
s390                  randconfig-002-20250521    clang-21
s390                  randconfig-002-20250521    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250521    gcc-12.4.0
sh                    randconfig-001-20250521    gcc-8.5.0
sh                    randconfig-002-20250521    gcc-15.1.0
sh                    randconfig-002-20250521    gcc-8.5.0
sh                          rsk7201_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250521    gcc-13.3.0
sparc                 randconfig-001-20250521    gcc-8.5.0
sparc                 randconfig-002-20250521    gcc-13.3.0
sparc                 randconfig-002-20250521    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250521    gcc-13.3.0
sparc64               randconfig-001-20250521    gcc-8.5.0
sparc64               randconfig-002-20250521    gcc-13.3.0
sparc64               randconfig-002-20250521    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250521    clang-21
um                    randconfig-001-20250521    gcc-8.5.0
um                    randconfig-002-20250521    clang-21
um                    randconfig-002-20250521    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250521    clang-20
x86_64      buildonly-randconfig-002-20250521    clang-20
x86_64      buildonly-randconfig-003-20250521    clang-20
x86_64      buildonly-randconfig-003-20250521    gcc-12
x86_64      buildonly-randconfig-004-20250521    clang-20
x86_64      buildonly-randconfig-004-20250521    gcc-12
x86_64      buildonly-randconfig-005-20250521    clang-20
x86_64      buildonly-randconfig-006-20250521    clang-20
x86_64                              defconfig    clang-20
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
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250521    gcc-15.1.0
xtensa                randconfig-001-20250521    gcc-8.5.0
xtensa                randconfig-002-20250521    gcc-15.1.0
xtensa                randconfig-002-20250521    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

