Return-Path: <linux-pci+bounces-28678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF74AC8046
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB70188B441
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F822CBEE;
	Thu, 29 May 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLpk8pJa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5621CC63
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532508; cv=none; b=n450h/7DA+pUvoZdKMtCcSlvE391oVwy5A11HXs02Y20n0bm0KgoP9BvfCMy0KPDFcLAKUuExNUgU04yMih/SxtgnMrEmNMGdv7XnbcWaQT6ln2bwQoepfcn24nH5LLHWDHiMYT8i3OGoCubvgOVC8NPTq4QOIPeLv+NkQXxSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532508; c=relaxed/simple;
	bh=nI+0dbiJ9sn+WlLj4dlUVWJDQbmNQ/H0FXZSOTd0yUY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q0RmhL56A7B3fizooBpGSL+VLILIuIsb7q8eYcCZ+sdIfLlVaUuX3XLC040GNulvnAu4I/ZGgcYv1emPiC/xqcWKdlGHvkZ3yaLIvYv384w6cRnucWCyZi/H1o9O5aICcmTCfLxcU2aqt2MiOKKys6zfiYkvpVbn1W5XJ0GM7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLpk8pJa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748532508; x=1780068508;
  h=date:from:to:cc:subject:message-id;
  bh=nI+0dbiJ9sn+WlLj4dlUVWJDQbmNQ/H0FXZSOTd0yUY=;
  b=bLpk8pJa9Yk3t4RpipahX+9UpclfS3DPzqKHGDleiqR1AU03BNr8fWNJ
   S63OnzZb9IeXPWS+ZBjpG+7es9VCSehW+1yfGBYPUHvLSiZwLtDLfrZJp
   iMCGW3RkDB13ywFHp1bSD5ffgAo9Ex+Flc9B5UsimaA60y3zpGjselyhk
   pm7UUaC6dKgo+ukAwVdLUvbvCdN+Mflixfhk97Uv3snb3wMYbRrsk518F
   lXLvkB0kjkHS1LYU8u1b3CUL2GfR2JpQlmvV7cmyq2jthQ5E6l5hH27sQ
   lTKgbze73ECuf2uX6dAXmKJQ4q6z/fqhsc9aXptOzhABmvqVrS7PYxrNY
   A==;
X-CSE-ConnectionGUID: ADYxgb5TSPer9ByVpvoDJQ==
X-CSE-MsgGUID: x5gtv28DRfGzHPuRx+V9jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="54264371"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="54264371"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:28:27 -0700
X-CSE-ConnectionGUID: G5Bf66HDShmZ7SyOJF7CPg==
X-CSE-MsgGUID: D3UEUNITRSumf6SSMQskPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="143422784"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 May 2025 08:28:25 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKfB9-000Woy-0k;
	Thu, 29 May 2025 15:28:23 +0000
Date: Thu, 29 May 2025 23:28:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 2ed3fad9bca7cef97e961bae18abe87090ae8f6e
Message-ID: <202505292351.PPDF90EV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 2ed3fad9bca7cef97e961bae18abe87090ae8f6e  PCI: j721e: Fix host/endpoint dependencies

elapsed time: 1002m

configs tested: 168
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.3.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-14.3.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                   randconfig-001-20250529    gcc-10.5.0
arc                   randconfig-002-20250529    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                           h3600_defconfig    gcc-15.1.0
arm                   randconfig-001-20250529    clang-21
arm                   randconfig-002-20250529    gcc-8.5.0
arm                   randconfig-003-20250529    clang-21
arm                   randconfig-004-20250529    clang-21
arm                        realview_defconfig    clang-16
arm                           sama5_defconfig    gcc-15.1.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250529    gcc-6.5.0
arm64                 randconfig-002-20250529    clang-21
arm64                 randconfig-003-20250529    gcc-8.5.0
arm64                 randconfig-004-20250529    gcc-8.5.0
csky                              allnoconfig    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250529    gcc-15.1.0
csky                  randconfig-002-20250529    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250529    clang-21
hexagon               randconfig-002-20250529    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250529    gcc-12
i386        buildonly-randconfig-002-20250529    gcc-12
i386        buildonly-randconfig-003-20250529    gcc-12
i386        buildonly-randconfig-004-20250529    gcc-11
i386        buildonly-randconfig-004-20250529    gcc-12
i386        buildonly-randconfig-005-20250529    clang-20
i386        buildonly-randconfig-005-20250529    gcc-12
i386        buildonly-randconfig-006-20250529    clang-20
i386        buildonly-randconfig-006-20250529    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250529    clang-20
i386                  randconfig-002-20250529    clang-20
i386                  randconfig-003-20250529    clang-20
i386                  randconfig-004-20250529    clang-20
i386                  randconfig-005-20250529    clang-20
i386                  randconfig-006-20250529    clang-20
i386                  randconfig-007-20250529    clang-20
i386                  randconfig-011-20250529    clang-20
i386                  randconfig-012-20250529    clang-20
i386                  randconfig-013-20250529    clang-20
i386                  randconfig-014-20250529    clang-20
i386                  randconfig-015-20250529    clang-20
i386                  randconfig-016-20250529    clang-20
i386                  randconfig-017-20250529    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-14.3.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250529    gcc-15.1.0
loongarch             randconfig-002-20250529    gcc-12.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-14.3.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-14.3.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250529    gcc-12.4.0
nios2                 randconfig-002-20250529    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.3.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.3.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250529    gcc-9.3.0
parisc                randconfig-002-20250529    gcc-13.3.0
parisc64                         alldefconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.3.0
powerpc                          allyesconfig    clang-21
powerpc                      bamboo_defconfig    clang-21
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250529    clang-19
powerpc               randconfig-002-20250529    clang-21
powerpc               randconfig-003-20250529    clang-21
powerpc                      tqm8xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250529    gcc-6.5.0
powerpc64             randconfig-002-20250529    clang-21
powerpc64             randconfig-003-20250529    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.3.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250529    clang-21
riscv                 randconfig-002-20250529    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250529    gcc-6.5.0
s390                  randconfig-002-20250529    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250529    gcc-15.1.0
sh                    randconfig-002-20250529    gcc-12.4.0
sh                          rsk7264_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sh                           se7751_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-14.3.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250529    gcc-11.5.0
sparc                 randconfig-002-20250529    gcc-11.5.0
sparc64               randconfig-001-20250529    gcc-11.5.0
sparc64               randconfig-002-20250529    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250529    clang-21
um                    randconfig-002-20250529    gcc-11
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250529    gcc-12
x86_64      buildonly-randconfig-002-20250529    clang-20
x86_64      buildonly-randconfig-002-20250529    gcc-12
x86_64      buildonly-randconfig-003-20250529    gcc-12
x86_64      buildonly-randconfig-004-20250529    clang-20
x86_64      buildonly-randconfig-004-20250529    gcc-12
x86_64      buildonly-randconfig-005-20250529    gcc-12
x86_64      buildonly-randconfig-006-20250529    clang-20
x86_64      buildonly-randconfig-006-20250529    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250529    clang-20
x86_64                randconfig-002-20250529    clang-20
x86_64                randconfig-003-20250529    clang-20
x86_64                randconfig-004-20250529    clang-20
x86_64                randconfig-005-20250529    clang-20
x86_64                randconfig-006-20250529    clang-20
x86_64                randconfig-007-20250529    clang-20
x86_64                randconfig-008-20250529    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.3.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250529    gcc-7.5.0
xtensa                randconfig-002-20250529    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

