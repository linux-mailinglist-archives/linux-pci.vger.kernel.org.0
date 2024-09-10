Return-Path: <linux-pci+bounces-12984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E183973B32
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058E3284D97
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E5196D9D;
	Tue, 10 Sep 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUuZQAgK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABA194132
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981229; cv=none; b=qMqQo/0TvvDZJn3L5TKvgqSGwgwbCCBrKtJAOuG4tnOxEoSi+4hq7ycEwFK0FeqhEXV+4JbS215JM/FuqbZwo9krhWZADV6jXLoE3JdjuTNvK8+tFaQkaYIRKpTlLnkE2v04I2RBpiGkU/wuA7XXo5u0YOWGELalE9/xSq0ASNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981229; c=relaxed/simple;
	bh=12LnXQ/myw+9B4lr1aQ8axVEZcvVgt48uR2OJzPOSzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Dzr2k1PMAOLgBxg8JsLcNhZqkBA0NH5z08MwQTUSYuekMB4S+FUBJ9uf+8wjP4jjhneJIY5uYaF9PGU5sPW6bKnpQyILX2SYx/xoKrw8QcE9MC7ttZ0OKSZkLHgPUGCGVYJAMEaYj6raWFkVY2LI00pq5IJckmXyCd23o+2Yql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUuZQAgK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725981228; x=1757517228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=12LnXQ/myw+9B4lr1aQ8axVEZcvVgt48uR2OJzPOSzU=;
  b=RUuZQAgKFQaggk2MFPNJM+Z2OUgUK0eg7H33V8d4pDqG+1dt+Hqu+fYz
   7RW6TrRVI6fVYgayerAz7CftK7bPPZQ2E+u3kfaTj8pSxtvRkJr1RuEPc
   SbAPLAn8Df7afLxksI1oe37mh3QP3HyLkd06lA7noFdlrIiuQiIRmmWSs
   QID6NtzSNrbVvsN3SyV3sPrZu8oW4re87IvmC7iKcs0rHtd1n+ChNY4DE
   FpCxLkwX2wEQfzzIA8RV8d8ekVifiRxle14cOjdDALzAyD2jXNKcsM17o
   pl39EAn+n8wYscW1vkmVGkU6JpR2W9IAvPWCBxsvqjZpNLj4dWExonxw6
   A==;
X-CSE-ConnectionGUID: ceyhJmJ6RomIqEBshlrKOQ==
X-CSE-MsgGUID: Ci8VxOqGSoyksiVGLszEng==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24877348"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24877348"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 08:13:47 -0700
X-CSE-ConnectionGUID: PVaQ1va7SDCq+evz9SBBCw==
X-CSE-MsgGUID: 8eaahZssTom5EYrwXkkX5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67356905"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Sep 2024 08:13:46 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so2Yp-0002FH-26;
	Tue, 10 Sep 2024 15:13:43 +0000
Date: Tue, 10 Sep 2024 23:12:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 d5e424d21af147985a2afb5eb423e52665e104ae
Message-ID: <202409102346.54Ya8yl0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: d5e424d21af147985a2afb5eb423e52665e104ae  PCI: imx6: Add i.MX8Q PCIe Root Complex (RC) support

elapsed time: 1457m

configs tested: 187
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-14.1.0
arc                               allnoconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240910   gcc-13.2.0
arc                   randconfig-002-20240910   gcc-13.2.0
arm                               allnoconfig   gcc-14.1.0
arm                         at91_dt_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      integrator_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                   randconfig-001-20240910   gcc-13.2.0
arm                   randconfig-002-20240910   gcc-13.2.0
arm                   randconfig-003-20240910   gcc-13.2.0
arm                   randconfig-004-20240910   gcc-13.2.0
arm                           sama7_defconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240910   gcc-13.2.0
arm64                 randconfig-002-20240910   gcc-13.2.0
arm64                 randconfig-003-20240910   gcc-13.2.0
arm64                 randconfig-004-20240910   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240910   gcc-13.2.0
csky                  randconfig-002-20240910   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240910   gcc-13.2.0
hexagon               randconfig-002-20240910   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240910   clang-18
i386         buildonly-randconfig-001-20240910   gcc-12
i386         buildonly-randconfig-002-20240910   clang-18
i386         buildonly-randconfig-002-20240910   gcc-12
i386         buildonly-randconfig-003-20240910   clang-18
i386         buildonly-randconfig-003-20240910   gcc-12
i386         buildonly-randconfig-004-20240910   clang-18
i386         buildonly-randconfig-005-20240910   clang-18
i386         buildonly-randconfig-006-20240910   clang-18
i386         buildonly-randconfig-006-20240910   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240910   clang-18
i386                  randconfig-001-20240910   gcc-12
i386                  randconfig-002-20240910   clang-18
i386                  randconfig-002-20240910   gcc-12
i386                  randconfig-003-20240910   clang-18
i386                  randconfig-003-20240910   gcc-12
i386                  randconfig-004-20240910   clang-18
i386                  randconfig-004-20240910   gcc-12
i386                  randconfig-005-20240910   clang-18
i386                  randconfig-005-20240910   gcc-12
i386                  randconfig-006-20240910   clang-18
i386                  randconfig-011-20240910   clang-18
i386                  randconfig-011-20240910   gcc-12
i386                  randconfig-012-20240910   clang-18
i386                  randconfig-013-20240910   clang-18
i386                  randconfig-014-20240910   clang-18
i386                  randconfig-014-20240910   gcc-12
i386                  randconfig-015-20240910   clang-18
i386                  randconfig-015-20240910   gcc-12
i386                  randconfig-016-20240910   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240910   gcc-13.2.0
loongarch             randconfig-002-20240910   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   clang-20
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson2k_defconfig   clang-20
mips                      pic32mzda_defconfig   clang-20
mips                       rbtx49xx_defconfig   clang-20
mips                           xway_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240910   gcc-13.2.0
nios2                 randconfig-002-20240910   gcc-13.2.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240910   gcc-13.2.0
parisc                randconfig-002-20240910   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   clang-20
powerpc                       eiger_defconfig   clang-20
powerpc                  iss476-smp_defconfig   clang-20
powerpc               randconfig-001-20240910   gcc-13.2.0
powerpc               randconfig-002-20240910   gcc-13.2.0
powerpc               randconfig-003-20240910   gcc-13.2.0
powerpc64             randconfig-001-20240910   gcc-13.2.0
powerpc64             randconfig-002-20240910   gcc-13.2.0
powerpc64             randconfig-003-20240910   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240910   gcc-13.2.0
riscv                 randconfig-002-20240910   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240910   gcc-13.2.0
s390                  randconfig-002-20240910   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240910   gcc-13.2.0
sh                    randconfig-002-20240910   gcc-13.2.0
sh                        sh7785lcr_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240910   gcc-13.2.0
sparc64               randconfig-002-20240910   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                               allyesconfig   gcc-12
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240910   gcc-13.2.0
um                    randconfig-002-20240910   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240910   gcc-12
x86_64       buildonly-randconfig-002-20240910   gcc-12
x86_64       buildonly-randconfig-003-20240910   gcc-12
x86_64       buildonly-randconfig-004-20240910   gcc-12
x86_64       buildonly-randconfig-005-20240910   gcc-12
x86_64       buildonly-randconfig-006-20240910   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240910   gcc-12
x86_64                randconfig-002-20240910   gcc-12
x86_64                randconfig-003-20240910   gcc-12
x86_64                randconfig-004-20240910   gcc-12
x86_64                randconfig-005-20240910   gcc-12
x86_64                randconfig-006-20240910   gcc-12
x86_64                randconfig-011-20240910   gcc-12
x86_64                randconfig-012-20240910   gcc-12
x86_64                randconfig-013-20240910   gcc-12
x86_64                randconfig-014-20240910   gcc-12
x86_64                randconfig-015-20240910   gcc-12
x86_64                randconfig-016-20240910   gcc-12
x86_64                randconfig-071-20240910   gcc-12
x86_64                randconfig-072-20240910   gcc-12
x86_64                randconfig-073-20240910   gcc-12
x86_64                randconfig-074-20240910   gcc-12
x86_64                randconfig-075-20240910   gcc-12
x86_64                randconfig-076-20240910   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240910   gcc-13.2.0
xtensa                randconfig-002-20240910   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

