Return-Path: <linux-pci+bounces-2135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07382CA38
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 07:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DB11F2390A
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jan 2024 06:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D6FBEC;
	Sat, 13 Jan 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKBOqgok"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BE12E4B
	for <linux-pci@vger.kernel.org>; Sat, 13 Jan 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705127077; x=1736663077;
  h=date:from:to:cc:subject:message-id;
  bh=Wix+hAKWUPPkUW6cQ69PKEja0T7ikOcH5XWtEaq8UIc=;
  b=fKBOqgokHqzPZ7JvG8H4QdDNNh0MTGcMLb9AgT1Ne0Jky4RUu0e76CqH
   kIfw6NFneLv6W/SCixZERmCGrD6i7v0MIG89pat0COUSTO8KT2+nVa55o
   Lpk3YkJUQch7+InKUSLdMZEpzJlFifnIUiiY5wOEnmajnjTcip1nEecSH
   W3binXatyqp5KX/BS6j1PWm7bX5UcCgOSI7WenD1gXCbKIIGBWG8tK4bU
   tjlYdSSjretUGCItbppiPId9kYNPT4kmGL9FtLOAayjCxkPMCUVeo3UWO
   G6z0csw/+cBjaZRVRAIHnHeVXHRL1CX7rfGUKz4BieVY9jKxc0JgwIjWA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6076892"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="6076892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 22:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="956308927"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="956308927"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2024 22:24:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOXRY-000AAg-2l;
	Sat, 13 Jan 2024 06:24:32 +0000
Date: Sat, 13 Jan 2024 14:24:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 7360443ff4b7cde8960c6520a1426b863257e292
Message-ID: <202401131404.e8nDploh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 7360443ff4b7cde8960c6520a1426b863257e292  Merge branch 'pci/misc'

elapsed time: 1750m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240113   gcc  
arc                   randconfig-002-20240113   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240113   gcc  
arm                   randconfig-002-20240113   gcc  
arm                   randconfig-003-20240113   gcc  
arm                   randconfig-004-20240113   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240113   gcc  
arm64                 randconfig-002-20240113   gcc  
arm64                 randconfig-003-20240113   gcc  
arm64                 randconfig-004-20240113   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240113   gcc  
csky                  randconfig-002-20240113   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240113   clang
hexagon               randconfig-002-20240113   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240112   clang
i386         buildonly-randconfig-002-20240112   clang
i386         buildonly-randconfig-003-20240112   clang
i386         buildonly-randconfig-004-20240112   clang
i386         buildonly-randconfig-005-20240112   clang
i386         buildonly-randconfig-006-20240112   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240112   clang
i386                  randconfig-002-20240112   clang
i386                  randconfig-003-20240112   clang
i386                  randconfig-004-20240112   clang
i386                  randconfig-005-20240112   clang
i386                  randconfig-006-20240112   clang
i386                  randconfig-011-20240112   gcc  
i386                  randconfig-012-20240112   gcc  
i386                  randconfig-013-20240112   gcc  
i386                  randconfig-014-20240112   gcc  
i386                  randconfig-015-20240112   gcc  
i386                  randconfig-016-20240112   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240113   gcc  
loongarch             randconfig-002-20240113   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240113   gcc  
nios2                 randconfig-002-20240113   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240113   gcc  
parisc                randconfig-002-20240113   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240113   gcc  
powerpc               randconfig-002-20240113   gcc  
powerpc               randconfig-003-20240113   gcc  
powerpc64             randconfig-001-20240113   gcc  
powerpc64             randconfig-002-20240113   gcc  
powerpc64             randconfig-003-20240113   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240113   gcc  
riscv                 randconfig-002-20240113   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240113   clang
s390                  randconfig-002-20240113   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240113   gcc  
sh                    randconfig-002-20240113   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240113   gcc  
sparc64               randconfig-002-20240113   gcc  
um                               allmodconfig   clang
um                    randconfig-001-20240113   gcc  
um                    randconfig-002-20240113   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240113   gcc  
xtensa                randconfig-002-20240113   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

