Return-Path: <linux-pci+bounces-12827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3296D7BF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 13:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C6D28182A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E75199225;
	Thu,  5 Sep 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqhPwqWn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE9194C65
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537465; cv=none; b=tnNuOpXbdxbfPW7OBHAxgsACcZ2x4BYx5s6bdxWlaaNHPRXq7wQLIFlLT1BOyZNIJnuoLmLHqd7+4H0D3GerBuNSeWVrvy0I4s138LRKy8SxlRo0v4vVapC959ZQLJfg+4clJT+VYyZ3sKdOh3v+vjko2/cE6ZThiF8M+zYyJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537465; c=relaxed/simple;
	bh=q7TVKyAPx5u/YscVcr1l3T2M211aWvaE/jW/izwnKG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PhJ7k/XQOYOfGCwBQV1DRvbOjMhzWjLWUnGgA+4CIWzOVMydue0FA7Vw8c3oxyXF1G300Ytx+xrWWkWd2eh9j7r1G8vqZBc6d3RDuDcvEycyW3vGVGlCiIX1ZpT+tbo8dar90ClFy7EuMQfLrjsNSotqcSzhH86PLhcE2nVPmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqhPwqWn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725537464; x=1757073464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q7TVKyAPx5u/YscVcr1l3T2M211aWvaE/jW/izwnKG0=;
  b=aqhPwqWnIWFrE2Dg0HnsY9Prt1dJrSdVEIkxBh0KKjtrwWpswkBsPZ/7
   DXcaBj+MLyFqko6a0kyJWbJDczq4BqJ1gMNaex3DaCwR2SYG81Jwxk6ub
   XQwWaZ7L58gEB6bAW+t/blOIz/F4J65twAsut4SM9LrlHRuNxb6yBsk6E
   9p7E489KAAQiPbf9SJqMTnGruKlg9kiPnmZrbAqXTkbvkR3dh6BrGN+wE
   9WvVOIT4Y6lrkh4GrQKoM5mt7d0TwXa9yzaTVw4HjvhFvQykq/PiAP4nB
   GTlc1ccKlE5+FPh3yyGIjVkpLfFeEFbgRC9H8V8lnAnj1q9OqLqh2ZtbW
   w==;
X-CSE-ConnectionGUID: qw1Hj84RQIuR5NtX8TWBPg==
X-CSE-MsgGUID: 5VGosmhWSAmc/MHVC69cSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35633837"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="35633837"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:57:43 -0700
X-CSE-ConnectionGUID: n3Ox0qa1S6yuQX3+ecRUIQ==
X-CSE-MsgGUID: BhiMoQd3Sfq2fd9FyNM4AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="66122762"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Sep 2024 04:57:42 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smB7L-0009nn-2l;
	Thu, 05 Sep 2024 11:57:39 +0000
Date: Thu, 05 Sep 2024 19:57:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 f04d277ff328e25ef30939b772d9cc1066f41f86
Message-ID: <202409051958.18nUaJES-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: f04d277ff328e25ef30939b772d9cc1066f41f86  dt-bindings: PCI: altera: msi: Convert to YAML

elapsed time: 1193m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                      axs103_smp_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arc                     haps_hs_smp_defconfig   gcc-14.1.0
arc                        nsimosci_defconfig   gcc-14.1.0
arc                   randconfig-001-20240905   gcc-12
arc                   randconfig-002-20240905   gcc-12
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                     am200epdkit_defconfig   clang-20
arm                         assabet_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          ep93xx_defconfig   clang-20
arm                      footbridge_defconfig   clang-20
arm                          ixp4xx_defconfig   gcc-14.1.0
arm                            mps2_defconfig   clang-20
arm                             mxs_defconfig   gcc-14.1.0
arm                   randconfig-001-20240905   gcc-12
arm                   randconfig-002-20240905   gcc-12
arm                   randconfig-003-20240905   gcc-12
arm                   randconfig-004-20240905   gcc-12
arm                           sama5_defconfig   gcc-14.1.0
arm                         socfpga_defconfig   clang-20
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240905   gcc-12
arm64                 randconfig-002-20240905   gcc-12
arm64                 randconfig-003-20240905   gcc-12
arm64                 randconfig-004-20240905   gcc-12
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240905   gcc-12
csky                  randconfig-002-20240905   gcc-12
hexagon                          alldefconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240905   gcc-12
hexagon               randconfig-002-20240905   gcc-12
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240905   gcc-12
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-004-20240905   gcc-12
i386         buildonly-randconfig-005-20240905   gcc-12
i386         buildonly-randconfig-006-20240905   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-002-20240905   gcc-12
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-004-20240905   gcc-12
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-011-20240905   gcc-12
i386                  randconfig-012-20240905   gcc-12
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-014-20240905   gcc-12
i386                  randconfig-015-20240905   gcc-12
i386                  randconfig-016-20240905   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240905   gcc-12
loongarch             randconfig-002-20240905   gcc-12
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                            mac_defconfig   gcc-14.1.0
m68k                            q40_defconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
microblaze                      mmu_defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   clang-20
mips                  decstation_64_defconfig   gcc-14.1.0
mips                     decstation_defconfig   clang-20
mips                           ip32_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240905   gcc-12
nios2                 randconfig-002-20240905   gcc-12
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                generic-64bit_defconfig   gcc-14.1.0
parisc                randconfig-001-20240905   gcc-12
parisc                randconfig-002-20240905   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      chrp32_defconfig   gcc-14.1.0
powerpc                       holly_defconfig   clang-20
powerpc                        icon_defconfig   clang-20
powerpc                 linkstation_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240905   gcc-12
powerpc               randconfig-002-20240905   gcc-12
powerpc               randconfig-003-20240905   gcc-12
powerpc64             randconfig-001-20240905   gcc-12
powerpc64             randconfig-002-20240905   gcc-12
powerpc64             randconfig-003-20240905   gcc-12
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240905   gcc-12
riscv                 randconfig-002-20240905   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240905   gcc-12
s390                  randconfig-002-20240905   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                 kfr2r09-romimage_defconfig   clang-20
sh                          lboxre2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240905   gcc-12
sh                    randconfig-002-20240905   gcc-12
sh                          urquell_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240905   gcc-12
sparc64               randconfig-002-20240905   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240905   gcc-12
um                    randconfig-002-20240905   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240905   gcc-12
xtensa                randconfig-002-20240905   gcc-12

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

